# frozen_string_literal: true

require "spec_helper"

RSpec.describe Wholable do
  subject(:whole) { implementation.new }

  let :implementation do
    Class.new do
      include Wholable[:name, :label]

      def initialize name: "test", label: "Test"
        @name = name
        @label = label
      end
    end
  end

  let(:similar) { implementation.new }
  let(:different) { implementation.new name: "odd" }

  describe "#initialize" do
    it "answers attributes" do
      expect(whole).to have_attributes(name: "test", label: "Test")
    end
  end

  describe "#frozen?" do
    it "answers true" do
      expect(whole.frozen?).to be_frozen
    end
  end

  describe "#==" do
    it "answers true when values are equal" do
      expect((whole == similar)).to be(true)
    end

    it "answers false when values are not equal" do
      expect((whole == different)).to be(false)
    end

    it "answers false with different type" do
      expect((whole == "other")).to be(false)
    end
  end

  describe "#eql?" do
    it "answers true when values are equal" do
      expect(whole.eql?(similar)).to be(true)
    end

    it "answers false when values are not equal" do
      expect(whole.eql?(different)).to be(false)
    end

    it "answers false with different type" do
      expect(whole.eql?("other")).to be(false)
    end
  end

  describe "#equal?" do
    it "answers true when object IDs are identical" do
      expect(whole.equal?(whole)).to be(true)
    end

    it "answers false when object IDs are different" do
      expect(whole.equal?(similar)).to be(false)
    end
  end

  describe "#hash" do
    it "answers identical hash when values are equal" do
      expect(whole.hash).to eq(similar.hash)
    end

    it "answers different hash when values are not equal" do
      expect(whole.hash).not_to eq(different.hash)
    end

    it "answers different hash with different type" do
      expect(whole.hash).not_to eq("other".hash)
    end
  end

  describe "#inspect" do
    it "answers inspection information" do
      expect(whole.inspect).to match(/#<#<Class:.+{18}>\s@name="test",\s@label="Test">/)
    end
  end

  describe "#to_a" do
    it "answers array" do
      expect(whole.to_a).to eq(%w[test Test])
    end
  end

  describe "#to_h" do
    it "answers hash" do
      expect(whole.to_h).to eq(name: "test", label: "Test")
    end
  end
end
