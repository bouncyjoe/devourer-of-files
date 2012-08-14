module DevourerOfFiles::Models
  describe File do
    let(:fake_store){ FakeDataStore.new }
    
    describe "#update" do
      it "should update the description of the file" do
        file = File.new('soundcloud.png', fake_store)
        
        file.update(:description => 'The great sheep chase')
        
        fake_store.get('soundcloud.png:description').should == 'The great sheep chase'
      end
      
      context "without a description" do
        it "should not update anything" do
          file = File.new('soundcloud.png', fake_store)
          
          fake_store.should_not_receive(:set)
          
          file.update(:description => nil)
        end
      end
      
    end
  
  end
end