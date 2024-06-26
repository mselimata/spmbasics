%-----------------------------------------------------------------------
% Job saved on 18-Apr-2024 14:56:40 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%
home = getenv('HOME');
root = fullfile(home, 'spmbasics', '/data/output/face_rep_gui');
func = spm_select('FPList', fullfile(root,'RawEPI'), '^sM.*\.img$');
scriptdir = fullfile(home, 'spmbasics', '/src/event_related_gui/preprocessing/matfiles');

disp('Starting preprocessing...'); 

matlabbatch{1}.spm.spatial.realign.estwrite.data(1) = {cellstr(func)};

matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';

disp('Completed preprocessing...')
save(fullfile(scriptdir,'realign.mat'),'matlabbatch');
spm_jobman('run',matlabbatch);