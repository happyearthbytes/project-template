package helloswing;

import javax.swing.*;        

public class HelloWorldSwing {
    private static void mainGUI() {
        JFrame frame = new JFrame("Hello World Title");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JLabel label = new JLabel("Hello World Label");
        frame.getContentPane().add(label);

        frame.pack();
        frame.setVisible(true);
    }

    public static void main(String[] args) {
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                mainGUI();
            }
        });
    }
}