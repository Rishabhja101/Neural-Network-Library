NeuralNetwork network;

void setup() {  
  // sample inputs
  float[][] inputs = new float [][] {
    {0, 0, 0},
    {0, 0, 1},
    {0, 1, 0},
    {0, 1, 1},
    {1, 0, 0},
    {1, 0, 1},
    {1, 1, 0},
    {1, 1, 1}
  };
  
  // sample outputs
  float[][] outputs = new float [][] {
    {0},
    {0},
    {0},
    {0},
    {1},
    {1},
    {1},
    {1}
  };
  
  network = new NeuralNetwork(3, 1);
  network.train(inputs, outputs, 1000);
  
  float[][] inputs1 = new float [][] {{1, 0, 0}};
  float[][] inputs2 = new float [][] {{0, 1, 0}};
  float[][] inputs3 = new float [][] {{0, 0, 1}};
    
  println(network.think(inputs1)[0][0]);
  println(network.think(inputs2)[0][0]);
  println(network.think(inputs3)[0][0]);
}
