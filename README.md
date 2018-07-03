# 3D-Laue-Multi-Grain-Indexing

This functions and scripts are used for multi-grain indexing of oligo-crystals from neutron Laue data.
The two main scripts are Seeding_Single_Grain_Fitting and Global_Fitting, as described in the paper.
The Maps script is used for segmentation of diffraction peaks, the variables "Peaks" and "Blobs" generated serve as input for the setup_experimental_data function in the single and global fitting scripts.
A list of valid reflecting planes and structure factors has to be provided to the "setup_grains" function so that the crystallographic information is correct. The format read by the parser function "importh" is the output format of the Mantid crystallography suite.
setup_beamline, setup_experimental_data, setup_grains and setup_detectors have to be configured based on the parameters of every specific experiment and sample.
