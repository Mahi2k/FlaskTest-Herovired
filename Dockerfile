FROM python:3 as testing
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN pytest > testing_results.txt
RUN if grep 'passed' testing_resuts.txt; then \
      echo 'test passed' \
    else \
      echo 'test failed' \
    fi

FROM python:3
COPY --from=testing /app /app
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]