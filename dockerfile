# Imagem oficial do NGINX com Alpine (menor tamanho)
FROM nginx:1.23-alpine

# Remove configurações padrão desnecessárias
RUN rm /etc/nginx/conf.d/default.conf

# Copia configuração customizada
COPY nginx.conf /etc/nginx/nginx.conf

# Cria usuário não-root para segurança
RUN adduser -D -g '' -G www-data www-data && \
    chown -R www-data:www-data /var/cache/nginx && \
    chmod -R 755 /var/cache/nginx

# Porta não padrão para evitar conflitos
EXPOSE 4500

USER www-data

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:4500/ || exit 1