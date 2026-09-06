## Banco de Dados 1

### Atividade 1
Elaborar um DER(Diagrama de Entidade-Relacionamento) completo a partir da descrição dada pelo professor, contendo o sistema de gestão de uma oficina mecânica, controlando clientes, veículos, serviços, funcionários...

Conceitos trabalhados:
1. Entidades
2. Atributos
3. Identificadores
4. Relacionamentos
5. Cardinalidades mínima e máxima
6. Atributos de relacionamento
7. Generalização/ Especialização
8. Entidade associativa

Link da atividade (Diagrama feito no BR Modelo): https://app.brmodeloweb.com/publicview/6a997360f351603fa48c078a

### Atividade 2
Modelagem conceitual (DER) para um sistema de cálculo de locação de veículos.O sistema recebe dados de uma locação (dias, valor da diária, quilometragem percorrida, contratação de seguro e idade do motorista) e calcula o valor final a pagar, considerando:

- Valor das diárias (dias × valor da diária)
- Franquia de quilometragem (100 km/dia) com cobrança de R$ 0,50/km excedente
- Seguro opcional (R$ 35,00/dia, se contratado)
- Desconto progressivo sobre o valor das diárias conforme a duração da locação (0%, 5% ou 10%)
- Taxa adicional para motoristas com menos de 21 anos (R$ 150,00)
- Validação de entradas inválidas (dias, valor da diária, idade ou quilometragem fora dos limites aceitáveis)

Conceitos trabalhados:
1. Identificação de entidades a partir de um problema computacional (Locação, Veículo, Motorista)
2. Atributos simples vs. atributos derivados/calculados
3. Modelagem de atributo opcional (seguro) como atributo booleano ou relacionamento opcional
4. Regras de negócio como restrições de domínio, não como entidades
5. Faixas de desconto como regra aplicada sobre atributo, não como entidade
6. Validação de entradas como restrição de integridade dos atributos
7. Cardinalidade entre Motorista, Veículo e Locação
8. Separação entre modelagem de dados e lógica de cálculo/algoritmo

Link da atividade (Diagrama feito no BR Modelo): https://app.brmodeloweb.com/publicview/6a99736df351603fa48c0798
