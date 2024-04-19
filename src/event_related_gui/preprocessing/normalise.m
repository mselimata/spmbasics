%-----------------------------------------------------------------------
% Job saved on 18-Apr-2024 14:56:24 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%%
home = getenv('HOME');
root = fullfile(home, 'spmbasics', '/data/face_rep_gui')
func = spm_select('FPList', fullfile(root,'RawEPI'), '^arsM.*\.img$');
def = spm_select('FPList', fullfile(root,'Structural'), '^y_sM.*\.nii$'); % y_sM03953_0007.nii


matlabbatch{1}.spm.spatial.normalise.write.subj.def(1) = {cellstr(def)};

matlabbatch{1}.spm.spatial.normalise.write.subj.resample(1) ={cellstr(func)};
%%
matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [3 3 3];
matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
save(fullfile(scriptdir,'normalise.mat'),'matlabbatch');
spm_jobman('run',matlabbatch);