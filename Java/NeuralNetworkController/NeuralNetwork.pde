class NeuralNetwork {
  float[][] mat;
  
  // Initializes a Neural Network with the given number of inputs and outputs
  NeuralNetwork(int x, int y){
    //randomSeed(0);
    this.mat = new float[3][];
    for (int i = 0; i < x; i++){
      this.mat[i] = new float[1];
    }
    randomize(-1, 1);
  }
  
  //  Initiates the Neural Network weights with random values between the given min and max values
  void randomize(float min, float max){
    for (int i = 0; i < mat.length; i++){
      for (int n = 0; n < mat[i].length; n++){
        this.mat[i][n] = random(min, max);
      }
    }
  }
  
  // Returns the sigmoid value of the given value
  float sigmoid(float num){
    return 1 / (1 + exp(-num));
  }
  
  // Returns the sigmoid derivative of the given value
  float sigmoidDerivative(float num){
    return num * (1 - num);
  }
  
  // Returns the dot product of the two 2D arrays given (matrices)
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
  
  // Returns a 2D array where each value in the array is the difference of the values in the two given 2D matrices at the same location
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
  
  // Returns a 2D array where each value in the array is the sum of the values in the two given 2D matrices at the same location
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
  
  // Returns a 2D array where each value in the array is the product of the values in the two given 2D matrices at the same location
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

  // Returns a 2D array where all the values are the sigmoid derivative of the given 2D array
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
  
  // Flips a 2D array
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
  
  // Calculates the output(s) that result from the given inputs
  float[][] think(float[][] inputs){
    float[][] output = dot(inputs, this.mat);
    for (int i = 0; i < output.length; i++){
      for (int n = 0; n < output[0].length; n++){
      output[i][n] = sigmoid(output[i][n]);
      }
    }
    return output;
  }
  
  // Trains the Neural Network with the training data provided
  void train(float[][] inputs, float[][] desiredOutputs, int iterations) {
    for (int i = 0; i < iterations; i++){
      float[][] outputs = think(inputs);
      float[][] error = subtract(desiredOutputs, outputs);
      float[][] adjustment = dot(flip(inputs), multiply(error, sigmoidDerivativeMatrix(outputs)));
      mat = addition(mat, adjustment);
    }
  }
}
