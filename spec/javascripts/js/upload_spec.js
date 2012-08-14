describe("Upload", function() {
  describe("#extractFilename", function(){
    it("should update the progress", function() {
      filename = Upload.extractFilename("C:fakepath\\monkeys.jpg");

      expect(filename).toEqual("monkeys.jpg");
    });
  });
});
