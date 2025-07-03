# Etapa 1: Imagem base
# Usamos uma imagem oficial do Python. A tag 'slim' é uma boa escolha para produção,
# pois é menor que a imagem padrão, mas ainda inclui ferramentas essenciais.
FROM python:3.11-slim

# Etapa 2: Diretório de trabalho
# Garante que todos os comandos subsequentes sejam executados neste diretório.
WORKDIR /app

# Etapa 3: Copiar e instalar dependências
# Copiamos o requirements.txt primeiro para aproveitar o cache de camadas do Docker.
# A instalação das dependências só será executada novamente se o arquivo requirements.txt mudar.
COPY requirements.txt ./

# O --no-cache-dir reduz o tamanho da imagem. Atualizar o pip é uma boa prática.
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
COPY . .

# Etapa 5: Expor a porta
EXPOSE 8000

# Etapa 6: Comando de execução
# Inicia o servidor Uvicorn. O host 0.0.0.0 é necessário para que o servidor
# seja acessível externamente. O --reload não é para produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
