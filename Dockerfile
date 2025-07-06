FROM python:3.13.5-alpine3.22
# Usamos uma imagem base do Python 3.13.5 com Alpine Linux 3.22 para manter a imagem leve.
# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# Fazer isso separadamente aproveita o cache do Docker. A instalação das dependências
# só será executada novamente se o arquivo requirements.txt for alterado.
COPY requirements.txt .

# Instala as dependências do projeto
# --no-cache-dir: Desabilita o cache do pip, o que pode reduzir o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação Uvicorn quando o contêiner for iniciado
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

