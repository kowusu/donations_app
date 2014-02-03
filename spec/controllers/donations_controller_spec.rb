require 'spec_helper'

describe DonationsController do
  
  describe "GET new" do
    context "when creating a new donation" do
      subject { get :new }
      its(:status) { should == 200 } # OK
      it "should render the new view" do
        subject
        response.should render_template("new")
      end
    end
  end
  
  describe "POST create" do
    context "when title, description, donatable are present" do
      subject { post :create, { :donation =>
        { :title => "Donation Title",
          :description => "What this donation is all about" ,
          :donatable_type => "Voucher",
          :donatable => { :expiration_date => 1.month.from_now }
        }
        }
      }
      its(:status) { should == 302 } # redirect
      
      it "saves the donation" do
        subject
        Donation.all.count.should == 1
      end
      
      it "should redirect to index" do
        subject.should redirect_to(donations_path)
      end
    end
    
    context "when title is present and descripton is blank" do
      subject { post :create, { :donation =>
        { :title => "Donation Title" }
        }
      }
      its(:status) { should == 200 } # redirect
      
      it "should not save the donation" do
        subject
        Donation.all.count.should == 0
      end
      
      it "should render to index" do
        subject.should render_template("new")
      end
    end
    
    context "when description is fpresent and title is blank" do
      subject { post :create, { :donation =>
        { :title => "Donation Title" }
        }
      }
      its(:status) { should == 200 } # redirect
      
      it "should not save the donation" do
        subject
        Donation.all.count.should == 0
      end
      
      it "should render to index" do
        subject.should render_template("new")
      end
    end
  end
  
  describe "GET edit" do
    context "when editing existing donation" do
      let(:donation) {
        Donation.create(:title => "First Donation", :description => "First Donation description", :donatable => Voucher.new(:expiration_date => 1.month.from_now))
      }
      subject { get :edit, :id => donation.id }
      its(:status) { should == 200 } # OK
      it "should render the edit view" do
        subject
        response.should render_template("edit")
      end
    end
  end
  
  describe "PUT update" do
    context "when title and description are edited" do
      let(:donation) {
        Donation.create(:title => "First Donation", :description => "First Donation description", :donatable => Voucher.new(:expiration_date => 1.month.from_now))
      }
      
      subject { put :update, {:id => donation.id, :donation =>
          { :title => "Donation Title",
            :description => "What this donation is all about",
            :donatable_type => "Voucher",
            :donatable => { :expiration_date => 1.month.from_now }
          }
        }
      }
      
      it "assigns @donation" do
        subject # let!
        assigns(:donation).should eq(donation)
      end
      its(:status) { should == 302 } # redirect
      
      it "update the donation" do
        subject
        Donation.all.count.should == 1
      end
      
      it "should redirect to index" do
        subject.should redirect_to(donations_path)
      end
    end
    
  end
  
  describe "GET show" do
    context "when the donation exists" do
      let(:donation) {
        Donation.create(:title => "First Donation", :description => "First Donation description", :donatable => Voucher.new(:expiration_date => 1.month.from_now))
      }
      
      subject { get :show, :id=> donation.id }
      
      it "assigns @donation" do
        subject
        assigns(:donation).should eq(donation)
      end
      
      it "renders the show template" do
        subject
        response.should render_template("show")
      end
    end
    context "when the donation does not exist" do
      subject { get :show, :id=> 404 }
      
      its(:status) { should == 302 }
      
      it "should redirect to index" do
        subject.should redirect_to(donations_path)
      end
    end
  end
  
  describe "GET index" do
    context "when there are some donations" do
      let(:donations) do
        [
          Donation.create(:title => "First Donation", :description => "First Donation description", :donatable => Voucher.new(:expiration_date => 1.month.from_now)),
          Donation.create(:title => "Second Donation", :description => "Second Donation description", :donatable => Voucher.new(:expiration_date => 1.month.from_now)),
          Donation.create(:title => "Third Donation", :description => "Third Donation description",  :donatable => Voucher.new(:expiration_date => 1.month.from_now))
        ]
      end
      before { donations }
      subject { get :index }
      
      it "assigns @donations" do
        subject # let!
        assigns(:donations).should eq(donations)
      end
    end
    
    context "when there are no donations" do
      subject { get :index }
      
      it "assigns @donations" do
        subject
        assigns(:donations).should eq([])
      end
    end
  end
  
  describe "DELETE destroy" do
    context "when the donation exists" do
      let(:donation) { Donation.create(:title => "First Donation", :description => "First Donation description", :donatable => Voucher.new(:expiration_date => 1.month.from_now)) }
      subject { delete :destroy, :id=> donation.id }
      
      it "deletes the donation" do
        subject
        Donation.all.count.should == 0
      end
      
      it "should redirect to index" do
        subject.should redirect_to(donations_path)
      end
    end
  end
  
end
