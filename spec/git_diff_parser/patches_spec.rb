require 'spec_helper'

module GitDiffParser
  describe Patches do
    describe '#parse' do
      let(:file0) { 'lib/saddler/reporter/github.rb' }
      let(:body0) { File.read('spec/support/fixtures/file0.diff') }
      let(:file1) { 'lib/saddler/reporter/github/commit_comment.rb' }
      let(:body1) { File.read('spec/support/fixtures/file1.diff') }
      let(:file2) { 'lib/saddler/reporter/github/helper.rb' }
      let(:body2) { File.read('spec/support/fixtures/file2.diff') }
      let(:file3) { 'lib/saddler/reporter/github/support.rb' }
      let(:body3) { File.read('spec/support/fixtures/file3.diff') }
      it 'returns parsed patches' do
        diff_body = File.read('spec/support/fixtures/d1bd180-c27866c.diff')
        patches = Patches.parse(diff_body)

        expect(patches.size).to eq 4
        expect(patches[0].file).to eq file0
        expect(patches[0].body).to eq body0
        expect(patches[1].file).to eq file1
        expect(patches[1].body).to eq body1
        expect(patches[2].file).to eq file2
        expect(patches[2].body).to eq body2
        expect(patches[3].file).to eq file3
        expect(patches[3].body).to eq body3
      end

      it "handles path with trailing spaces" do
        patches = Patches.parse(<<-EOP)
diff --git a/1 2 3 b/1 2 3
new file mode 100644
index 0000000..b85905e
--- /dev/null
+++ b/1 2 3\t
@@ -0,0 +1 @@
+1 2 3
diff --git "a/foo bar \\\\t" "b/foo bar \\\\t"
new file mode 100644
index 0000000..3b18e51
--- /dev/null
+++ "b/foo bar \\\\t"
@@ -0,0 +1 @@
+hello world
        EOP

        expect(patches[0].file).to eq("1 2 3")
        expect(patches[1].file).to eq("foo bar \t")
      end
    end
  end
end
