describe("ProgressEventHandler", function() {
  describe("with a successful upload", function(){
    beforeEach(function() {
      jasmine.Clock.useMock();
    });

    it("should update the progress", function() {
      var target = $('<div></div>');

      spyOn($, "ajax").andCallFake(function(params) {
        params.success("100");
      });
    
      ProgressEventHandler.start('1234', target);
  
      expect(target.html()).toEqual("100%");
    });

    it("should call itself again and update the progress", function() {
      var target = $('<div></div>');
      var content = '50'

      spyOn($, "ajax").andCallFake(function(params) {
        params.success(content);
      });
    
      ProgressEventHandler.start('1234', target); 
      expect(target.html()).toEqual("50%");

      content = '100';
        
      jasmine.Clock.tick(2000);

      expect(target.html()).toEqual("100%");
    });
  });
});
