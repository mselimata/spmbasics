# spmbasics, a reproduction attempt


[![DOI](https://zenodo.org/badge/784344321.svg)](https://zenodo.org/doi/10.5281/zenodo.10953222)
### Understanding  and reproducing SPM Tutorials.

<Project description>
  
## Table of contents

   * [Overview](#Overview)


   * [How to reproduce each step](#How-to-reproduce-each-step)

      A. [Block Design fMRI Preprocessing Steps]( Block_Design_fMRI_Preprocessing_Steps)
      
      B. [Block Design fMRI First Level Analysis Steps](Block_Design_fMRI_First_Level_Analysis_Steps)

      C. [Event-related fMRI Steps](Event_related_fMRI_Steps)

   * [Further on reproducibility](#Further-on-reproducibility)

## Overview


Version of the software used:```MATLAB R2020b``` & ```SPM12 (release 7771)```.

This repo contains my reproduction of the SPM12  tutorials with MATLAB R020b and they will be reffered as [original tutorial](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/block/) from now on. You can download the data used for preprocessing in this tutorial from [here](https://www.fil.ion.ucl.ac.uk/spm/download/data/MoAEpilot/MoAEpilot.bids.zip). And the data used for event related fMRI analysis [here](https://www.fil.ion.ucl.ac.uk/spm/download/data/face_rep/face_rep.zip)
You can find the code in [src](https://github.com/mselimata/spmbasics/tree/main/src) folder.


## How to Reproduce Each Step

### A. Block Design fMRI Preprocessing Steps 

First thing before the running the pipelines, add SPM to your path in MATLAB, because the scripts are calling SPM.

At all the scripts there  section defining the data root which requires that ```/spmbasics``` folder to be under ```to be under your home directory``` directory. 

The parameter in the scripts should be adjusted accordingly including true name of your data.  Here is an example setting showing the MoAEpilot folder under  ```/data/MoAEpilot``` the corresponding line in your script should look like ```root = fullfile(home, 'spmbasics', '/data/MoAEpilot')```. 

For the face fMRI data ```root = fullfile(home, 'spmbasics', '/data/face_rep)```.
If you edit the folder names keep the edits in the code as well. 
Your folder structure should look like the example below:

![folder_basics](/figures/folder_basics.png)

To be able test the reproducibility afterwards, in your ```/data/``` folder keep three different copies of your original data, named according to the processes.  For example ```MoAEpilot_script``` should contain the files to run the script interface. The ```root``` should be edited beforehand according to the pipelines, to avoid overwriting.

As a reminder all scripts meant to run in a clear window with no parameters. For the event related design there is an exception,  when a parameter needs to be loaded  beforehand it is mentioned on the script. 
So as a rule it would be useful to ```clc``` and ```clear all``` before and/or after each time running the scripts.


Now steps of running these scripts:
All the scripts meant to run without loading the gui and all the dependencies are defined and can be adjusted as mentioned earlier.

To avoid redundancies if you want to use the GUI interface solely, I recommend to follow the [original preprocessing tutorial](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/block/preprocessing/realignment/). 
If you want to load the scripts in this repo using the GUI interface it is possible and could be done by selecting data folder in similar methodology in the original tutorial.
Below I will be explaining running all as a script.

To be able to run SPM, it should be added to the path in MATLAB via ```addpath /path/of/your/spm12/```. 


<details>

<summary><strong> 1. GUI Interface </strong></summary>

<!--#### 1. GUI Interface:-->
 
 All the, ```.m``` files in the folder ```src/batch_step``` and they must be run subsequently. 
  1. Load and run [realignment_batch.m](src/batch_step/realignment_batch.m) first.
  Then run the script. It should produce a file starting with ```mean``` and ```r```. 
  2. Then run [slice timing_batch.m](src/batch_step/slice_timing_batch.m) 
      Run the script. It should produce a file starting with and ```ar```. 
  3. Follow by [coregistration_batch.m](src/batch_step/coregistration_batch.m).  Run the script and your anatomical images now be coregistered to the ```mean``` that we obtained at the realignment step. Deformation field is generated under ```/anat``` folder, with the name of ```y_sub-01_T1w.nii```
  4. Continue by running [segmentation_batch.m](src/batch_step/segmentation_batch.m)
      Segmentation script produce different segmentations  in the ```/anat/``` folder according to the predefined tissue probability maps. 
   5. Load and run [normalization_batch.m](src/batch_step/normalisation_batch.m) 
      This script produces files starting with ```war```
   6. Lastly [smoothing_batch.m](src/batch_step/smoothing_batch.m) This script produces the files starting with ```s``` and at the end in the ```/func``` folder there must be a version of the subject file starting with ```swar```
</details>

<details>
<summary><strong> 2. Batch Interface </strong></summary>   

<!-- #### 2. Batch Interface -->

 For the Batch interface inside ```/batch``` folder ```preprocessing_batch_job.m``` should be run. 
 *  If you want to follow the GUI, steps below:
     1. Load the [batch interface GUI](src/batch/preprocessing_batch.m) at the first step of the Batch interface ```Realign: Estimate &Reslice ``` select your data by specifiying  ```Data> Session```. And the rest is the same with the [tutorial](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/block/preprocessing/batch/).

     2. The rest of the script should run automatically using the relative paths of your data.

* If it does not work, follow the steps in the [original preprocessing tutorial](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/block/preprocessing/batch/) to define paths of your anatomical data.

</details>

<details>
<summary><strong> 3. Scripting </strong></summary>

<!-- #### 3. For scripting --> 

 * To be able to run the scripting, in ```/script``` folder, ```/preprocessing_script_job.m``` is the main file and it should be run.
   * In this tutorial I only edited and used  ```preprocessing_script_job.m``` solely.
   
   * NOTE: In the ideal setting, ```preprocessing_script.m``` controls the job of [preprocessing_script_job.m](src/preprocessing_job.m), but currently ```preprocessing_script.m``` is redundant so does not exist in this repo.
   
   * As a rule of the thumb make sure to indicate correct file paths for these files as mention at the very beginning of the tutorial.
</details>

### B. Block Design fMRI First Level Analysis Steps

Relative path settings are the same as [Block Design fMRI Preprocessing](Block_Design_fMRI_Preprocessing) for the ```first_level_analysis.sh``` The rest of the two scripts are depending on the resulting ```SPM.mat``` under the ```/first_level_analysis_script``` folder.

<details> 

<summary><strong> 1. First Level Analysis GUI Interface </strong></summary>

<!-- #### 1. GUI Interface: -->

* Run ```first_level_specification_gui.m``` firstly it will form the ```SPM.mat``` file at the ```/first_level_analysis_gui``` folder. 
* And then run ```first_level_estimation_gui.m```
* To be able to obtain the T staticstics and perform inference and rendering, [original first level analysis tutorial](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/block/modelling/block_design/) should be followed. 
* At the end, it is possible to get a rendered figure showing activations: ![gui_figure](figures/FIRST_LEVEL/first_level_gui_render.png)
</details>

<details>
<summary> <strong> 2. First Level Analysis Scripting </strong></summary>

<!-- #### 2. Scripting:-->

* All the scripts should be loaded subsequently,
         
   1. ```first_level_specification_script.m``` produces the ```SPM.mat file in the ```first_level_specification_script``` folder. The following scripts are taking this file as an input.
   2. The ```first_level_estimation_script.m``` does the GLM estimation.
   3. ```first_level_inference_script.m``` does the rendering. Calculates the estimation parameters and the T level statistics.
   
Resulting render can be seen here : ![script_figure](figures/FIRST_LEVEL/first_level_script_render.png)

</details>   


### C. Event-related fMRI


<details>

<summary> <strong> 1-A. GUI Interface Preprocessing </strong> </summary>

<!-- #### 1. Preprocessing -->
GUI interface: 
This part is following exact steps of the [original tutorial](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/event/preprocessing/). All the code files exported from the saved ```mat``` files.

 *   All the, ```.m``` files in the folder ```src/event_related_gui/preprocessing``` and they must be run subsequently. 
      1. Load & run [realign.m](src/event_related_gui/preprocessing/realign.m) first. 
      Then run the script. It should produce a file starting with ```mean``` and ```r```. 
      
      2. Then run [slice timing.m](src/event_related_gui/preprocessing/slice_timing.m) 
      Run the script. It should produce a file starting with and ```ar```. 

      3. Follow it by [coreg.job.m](src/event_related_gui/preprocessing/coreg.job.m).  Run the script and your anatomical images now be coregistered to the ```mean``` that we obtained at the realignment step. Deformation field is generated under ```/anat``` folder, with the name of ```y_sub-01_T1w.nii```
      4. Continue by running [segmentat.m](src/event_related_gui/preprocessing/segment.m)
      Segmentation script produce different segmentations  in the ```/anat/``` folder according to the predefined tissue probability maps. 
      5. Run [normalise.m](src/event_related_gui/preprocessing/normalise.m) 
      This script produces files starting with ```war```
      6. Lastly [smooth.m](src/event_related_gui/preprocessing/smooth.m)
      This script produces the files starting with ```s``` and at the end in the ```/func``` folder there must be a version of the subject file starting with ```swar```

</details>

<details>
<summary><strong> 1-B. Preprocessing via scripting </strong></summary>

* Script Interface [TODO]

</details>

<details>
<summary><strong> Parametric Modelling  </strong></summary>

#### Parametric Modelling

*  GUI interface
   * Run ```parametric_spec.m```  firstly it will form the ```SPM.mat``` file at the ```/event_related_gui``` folder. And then run ```parametric_est.job.m```
The inference should be followed at the [original event related tutorial](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/event/parametric/).  
* Script interface [TODO]

</details>

<details>

<summary> <strong> Categorical modelling and Bayesian Analysis are omitted for this tutorial. </strong> </summary>

#### Categorical Modelling

* Run ```categorical_spec.m```  firstly it will form the ```SPM.mat``` file at the ```/event_related_gui``` folder. And then run ```categorical_est.job.m```
The inference should be followed at the [original event related tutorial](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/event/categorical/).  

#### Bayesian Analysis

   * Run ```bayesian_spec.m```  firstly it will form the ```SPM.mat``` file at the ```/event_related_gui``` folder. And then run ```bayesian_est.job.m```
The inference should be followed at the [original event related tutorial](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/event/bayesian/).

</details>

## Further on reproducibility

SPM has a display and check reg features to visually inspect the outputs.
Visual inspection does not guarantee that all the results are the same.
To ensure about all of the steps producing same results after the same preprocessing steps, you can use [this](/src/shasum_checker.sh) *bash* script.
This script basically lists and compares the ```sha25sum``` values of the designated folders containing nifti files.  

Instructions to check hash values using the provided bash script:

* The script is in ```/src``` folder, named as ```shasum_checker.sh``` 

* Important note regarding to the base folder: Base folder should contain the results from the [batch_step](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/block/preprocessing/introduction/) interface. It is recommended to run the ```shasum_checker.sh``` on it once it is finished and then lock the writing access using ``` chmod a=rx -R filename ``` for linux. 


* <u> REMINDER</u>: Make sure to save your results of preprocessing into different folders and direct their paths accordingly.

* For example, for results which obtained from  interface create a ```BATCH``` folder with the input data and make SPM run from there so it will create results of the  batch interface.

* You can see the results of your shasum comparisons as a text file in the [/results](results/comparison_result.txt) folder.

Lastly keep in mind that every  instruction in this repo can change and serves the purpose of  my learning and testing. 

If you notice anything needs to be edited or fixed, feel free to open an issue. 

Thanks for your time and attention. :smile: 