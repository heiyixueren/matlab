function [c] = dicomHeader_read(c)
%
% NAME
%
%	function [c] = dicomHeader_read(c)
%
% ARGUMENTS
% INPUT
%	c		class		img2dcm class
%
% OPTIONAL
%	
% DESCRIPTION
%	This method access the (ls) first file in c.mstr_dicomInputDir
%	and stores the meta-data.
%
% PRECONDITIONS
%
%	o c.mstr_dicomInputDir must define a valid directory spec
%	o c.mstr_dicomInputDir must contain a set of valid dicom files
%
% POSTCONDITIONS
%
%	o c.mDicomInfo is populated with relevant meta information
%
% NOTE:
%
% HISTORY
% 10 April 2008
% o Initial design and coding.
%

c.mstack_proc 	= push(c.mstack_proc, 'dicomHeader_read');

cd(c.mstr_dicomInputDir);
cell_ls		= dls();

str_dicomFile	= cell_ls{1};
c.mDicomInfo	= dicominfo(str_dicomFile);

str_SeriesDescription	= c.mDicomInfo.SeriesDescription;
str_SeriesInstanceUID	= c.mDicomInfo.SeriesInstanceUID;
str_Manufacturer	= c.mDicomInfo.Manufacturer;
str_PatientID		= c.mDicomInfo.PatientID;
str_AccessionNumber	= c.mDicomInfo.AccessionNumber;
str_ProtocolName	= c.mDicomInfo.ProtocolName;
SeriesNumber		= c.mDicomInfo.SeriesNumber;
str_SeriesNumber	= sprintf('%d', SeriesNumber);

LC_orig			= c.m_marginLeft;
RC_orig			= c.m_marginRight;

c.m_marginLeft		= 20;
c.m_marginRight		= 60;
sys_print(c, sprintf('| Dicom header successfully read.\n'));
cprint(c, 'Manufacturer', 	str_Manufacturer);
cprint(c, 'PatientID', 		str_PatientID);
cprint(c, 'AccessionNumber',	str_AccessionNumber);
cprint(c, 'ProtocolName',	str_ProtocolName);
cprint(c, 'SeriesDescription', 	str_SeriesDescription);
cprint(c, 'SeriesInstanceUID', 	str_SeriesInstanceUID);
cprint(c, 'SeriesNumber', 	str_SeriesNumber);
cd(c.mstr_workingDir);
c.m_marginLeft		= LC_orig;
c.m_marginRight		= RC_orig;

[c.mstack_proc, element]= pop(c.mstack_proc);
