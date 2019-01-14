class Neuron {
  float[][] mat;
  
  // 3 by 1
  Neuron(int x, int y){
    randomSeed(0);
    this.mat = new float[3][];
    for (int i = 0; i < x; i++){
      this.mat[i] = new float[1];
    }
    randomize(-1, 1);
  }
  
  void randomize(float min, float max){
    for (int i = 0; i < mat.length; i++){
      for (int n = 0; n < mat[i].length; n++){
        this.mat[i][n] = random(min, max);
      }
    }
  }
  
  float sigmoid(float num){
    return 1 / (1 + exp(-num));
  }
  
  float sigmoidDerivative(float num){
    return num * (1 - num);
  }
  
  float[][] dot(float[][] matrix1, float[][] matrix2){
    float[][] output = new float[matrix1.length][];
    for (int i = 0; i < output.length; i++){
      output[i] = new float[matrix2[0].length];
      for (int n = 0; n < matrix2[0].length; n++){
        output[i][n] = 0;
        for (int j = 0; j < matrix2.length; j++){
          output[i][n] += matrix1[i][j] * matrix2[j][n];
        }
      }
    }
    return output;
  }
  
  float[][] subtract(float[][] matrix1, float[][] matrix2){
    float[][] output = new float[matrix1.length][];
      for (int i = 0; i < output.length; i++){
        output[i] = new float[matrix1[0].length];
        for (int n = 0; n < matrix1[0].length; n++){
          output[i][n] = matrix1[i][n] - matrix2[i][n];
        }
      }
    return output;
  }
  
  float[][] addition(float[][] matrix1, float[][] matrix2){
    float[][] output = new float[matrix1.length][];
      for (int i = 0; i < output.length; i++){
        output[i] = new float[matrix1[0].length];
        for (int n = 0; n < matrix1[0].length; n++){
          output[i][n] = matrix1[i][n] + matrix2[i][n];
        }
      }
    return output;
  }
  
  float[][] multiply(float[][] matrix1, float[][] matrix2){
    float[][] output = new float[matrix1.length][];
      for (int i = 0; i < output.length; i++){
        output[i] = new float[matrix1[0].length];
        for (int n = 0; n < matrix1[0].length; n++){
          output[i][n] = matrix1[i][n] * matrix2[i][n];
        }
      }
    return output;
  }
  
  float[][] sigmoidDerivativeMatrix(float[][] matrix){
    float[][] output = new float[matrix.length][];
      for (int i = 0; i < output.length; i++){
        output[i] = new float[matrix[0].length];
        for (int n = 0; n < output[0].length; n++){
          output[i][n] = sigmoidDerivative(matrix[i][n]);
        }
      }
    return output;
  }
  
  float[][] flip(float[][] matrix){
    float[][] output = new float[matrix[0].length][];
      for (int i = 0; i < output.length; i++){
        output[i] = new float[matrix.length];
        for (int n = 0; n < output[0].length; n++){
          output[i][n] = matrix[n][i];
        }
      }
    return output;
  }
  
  float[][] think(float[][] inputs){
    float[][] output = dot(inputs, this.mat);
    for (int i = 0; i < output.length; i++){
      for (int n = 0; n < output[0].length; n++){
      output[i][n] = sigmoid(output[i][n]);
      }
    }
    return output;
  }
  
  void train(float[][] inputs, float[][] desiredOutputs, int iterations) {
    for (int i = 0; i < iterations; i++){
      float[][] outputs = think(inputs);
      float[][] error = subtract(desiredOutputs, outputs);
      float[][] adjustment = dot(flip(inputs), multiply(error, sigmoidDerivativeMatrix(outputs)));
      mat = addition(mat, adjustment);
    }
  }
}
