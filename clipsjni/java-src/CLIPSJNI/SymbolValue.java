package CLIPSJNI;

public class SymbolValue extends PrimitiveValue
  {
   /****************/
   /* SymbolValue: */
   /****************/
   public SymbolValue()
     {
      super(new String(""));
     }

   /****************/
   /* SymbolValue: */
   /****************/
   public SymbolValue(
     String value)
     {
      super(value);
     }

   /****************/
   /* lexemeValue: */
   /****************/
   public String lexemeValue() throws Exception
     {
      return (String) getValue();
     }
     
   /****************/
   /* symbolValue: */
   /****************/
   public String symbolValue() throws Exception
     {
      return (String) getValue();
     }
     
   /***********/
   /* retain: */
   /***********/
   public void retain()
     {
      //System.out.println("SymbolValue retain");
     }

   /************/
   /* release: */
   /************/
   public void release()
     {
      //System.out.println("SymbolValue release");
     }
  }
