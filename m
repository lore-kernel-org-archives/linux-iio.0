Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47641 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbbGSOBE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 10:01:04 -0400
Message-ID: <55ABAD9E.2090504@kernel.org>
Date: Sun, 19 Jul 2015 15:01:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Cristina Opriceana <cristina.opriceana@gmail.com>
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
	octavian.purdila@intel.com
Subject: Re: [PATCH 1/3] tools: iio: Remove explicit NULL comparison
References: <cover.1436789446.git.cristina.opriceana@gmail.com> <2c7026f9557d27bf16437bae495e864dd04e0f19.1436789446.git.cristina.opriceana@gmail.com> <55A4077A.4050005@gmx.de>
In-Reply-To: <55A4077A.4050005@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/07/15 19:46, Hartmut Knaack wrote:
> Cristina Opriceana schrieb am 13.07.2015 um 15:15:
>> Remove explicit NULL comparison and write it in its simpler form as
>> recommended by checkpatch.pl.
>>
>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git.  Thanks,

Jonathan
>> ---
> 
> Every instance covered, consistency improved. Not everyone will mind that,
> but good job.
> 
>>  tools/iio/generic_buffer.c |  4 ++--
>>  tools/iio/iio_utils.c      | 56 +++++++++++++++++++++++-----------------------
>>  tools/iio/lsiio.c          | 10 ++++-----
>>  3 files changed, 35 insertions(+), 35 deletions(-)
>>
>> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
>> index 0e73723..9535c2d 100644
>> --- a/tools/iio/generic_buffer.c
>> +++ b/tools/iio/generic_buffer.c
>> @@ -270,7 +270,7 @@ int main(int argc, char **argv)
>>  		}
>>  	}
>>  
>> -	if (device_name == NULL) {
>> +	if (!device_name) {
>>  		printf("Device name not set\n");
>>  		print_usage();
>>  		return -1;
>> @@ -290,7 +290,7 @@ int main(int argc, char **argv)
>>  		return -ENOMEM;
>>  
>>  	if (!notrigger) {
>> -		if (trigger_name == NULL) {
>> +		if (!trigger_name) {
>>  			/*
>>  			 * Build the trigger name. If it is device associated
>>  			 * its name is <device_name>_dev[n] where n matches
>> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
>> index 8fb3214..4a7e480 100644
>> --- a/tools/iio/iio_utils.c
>> +++ b/tools/iio/iio_utils.c
>> @@ -117,13 +117,13 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>>  	}
>>  
>>  	dp = opendir(scan_el_dir);
>> -	if (dp == NULL) {
>> +	if (!dp) {
>>  		ret = -errno;
>>  		goto error_free_builtname_generic;
>>  	}
>>  
>>  	ret = -ENOENT;
>> -	while (ent = readdir(dp), ent != NULL)
>> +	while (ent = readdir(dp), ent)
>>  		/*
>>  		 * Do we allow devices to override a generic name with
>>  		 * a specific one?
>> @@ -138,7 +138,7 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>>  			}
>>  
>>  			sysfsfp = fopen(filename, "r");
>> -			if (sysfsfp == NULL) {
>> +			if (!sysfsfp) {
>>  				ret = -errno;
>>  				printf("failed to open %s\n", filename);
>>  				goto error_free_filename;
>> @@ -235,13 +235,13 @@ int iioutils_get_param_float(float *output, const char *param_name,
>>  	}
>>  
>>  	dp = opendir(device_dir);
>> -	if (dp == NULL) {
>> +	if (!dp) {
>>  		ret = -errno;
>>  		goto error_free_builtname_generic;
>>  	}
>>  
>>  	ret = -ENOENT;
>> -	while (ent = readdir(dp), ent != NULL)
>> +	while (ent = readdir(dp), ent)
>>  		if ((strcmp(builtname, ent->d_name) == 0) ||
>>  		    (strcmp(builtname_generic, ent->d_name) == 0)) {
>>  			ret = asprintf(&filename,
>> @@ -325,12 +325,12 @@ int build_channel_array(const char *device_dir,
>>  		return -ENOMEM;
>>  
>>  	dp = opendir(scan_el_dir);
>> -	if (dp == NULL) {
>> +	if (!dp) {
>>  		ret = -errno;
>>  		goto error_free_name;
>>  	}
>>  
>> -	while (ent = readdir(dp), ent != NULL)
>> +	while (ent = readdir(dp), ent)
>>  		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
>>  			   "_en") == 0) {
>>  			ret = asprintf(&filename,
>> @@ -341,7 +341,7 @@ int build_channel_array(const char *device_dir,
>>  			}
>>  
>>  			sysfsfp = fopen(filename, "r");
>> -			if (sysfsfp == NULL) {
>> +			if (!sysfsfp) {
>>  				ret = -errno;
>>  				free(filename);
>>  				goto error_close_dir;
>> @@ -369,13 +369,13 @@ int build_channel_array(const char *device_dir,
>>  		}
>>  
>>  	*ci_array = malloc(sizeof(**ci_array) * (*counter));
>> -	if (*ci_array == NULL) {
>> +	if (!*ci_array) {
>>  		ret = -ENOMEM;
>>  		goto error_close_dir;
>>  	}
>>  
>>  	seekdir(dp, 0);
>> -	while (ent = readdir(dp), ent != NULL) {
>> +	while (ent = readdir(dp), ent) {
>>  		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
>>  			   "_en") == 0) {
>>  			int current_enabled = 0;
>> @@ -391,7 +391,7 @@ int build_channel_array(const char *device_dir,
>>  			}
>>  
>>  			sysfsfp = fopen(filename, "r");
>> -			if (sysfsfp == NULL) {
>> +			if (!sysfsfp) {
>>  				ret = -errno;
>>  				free(filename);
>>  				count--;
>> @@ -424,7 +424,7 @@ int build_channel_array(const char *device_dir,
>>  			current->name = strndup(ent->d_name,
>>  						strlen(ent->d_name) -
>>  						strlen("_en"));
>> -			if (current->name == NULL) {
>> +			if (!current->name) {
>>  				free(filename);
>>  				ret = -ENOMEM;
>>  				count--;
>> @@ -452,7 +452,7 @@ int build_channel_array(const char *device_dir,
>>  			}
>>  
>>  			sysfsfp = fopen(filename, "r");
>> -			if (sysfsfp == NULL) {
>> +			if (!sysfsfp) {
>>  				ret = -errno;
>>  				printf("failed to open %s\n", filename);
>>  				free(filename);
>> @@ -567,12 +567,12 @@ int find_type_by_name(const char *name, const char *type)
>>  	char *filename;
>>  
>>  	dp = opendir(iio_dir);
>> -	if (dp == NULL) {
>> +	if (!dp) {
>>  		printf("No industrialio devices available\n");
>>  		return -ENODEV;
>>  	}
>>  
>> -	while (ent = readdir(dp), ent != NULL) {
>> +	while (ent = readdir(dp), ent) {
>>  		if (strcmp(ent->d_name, ".") != 0 &&
>>  		    strcmp(ent->d_name, "..") != 0 &&
>>  		    strlen(ent->d_name) > strlen(type) &&
>> @@ -595,7 +595,7 @@ int find_type_by_name(const char *name, const char *type)
>>  			    ":", 1) != 0) {
>>  				filename = malloc(strlen(iio_dir) + strlen(type)
>>  						  + numstrlen + 6);
>> -				if (filename == NULL) {
>> +				if (!filename) {
>>  					ret = -ENOMEM;
>>  					goto error_close_dir;
>>  				}
>> @@ -654,7 +654,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
>>  	int test;
>>  	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>>  
>> -	if (temp == NULL)
>> +	if (!temp)
>>  		return -ENOMEM;
>>  
>>  	ret = sprintf(temp, "%s/%s", basedir, filename);
>> @@ -662,7 +662,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
>>  		goto error_free;
>>  
>>  	sysfsfp = fopen(temp, "w");
>> -	if (sysfsfp == NULL) {
>> +	if (!sysfsfp) {
>>  		ret = -errno;
>>  		printf("failed to open %s\n", temp);
>>  		goto error_free;
>> @@ -683,7 +683,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
>>  
>>  	if (verify) {
>>  		sysfsfp = fopen(temp, "r");
>> -		if (sysfsfp == NULL) {
>> +		if (!sysfsfp) {
>>  			ret = -errno;
>>  			printf("failed to open %s\n", temp);
>>  			goto error_free;
>> @@ -749,7 +749,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
>>  	FILE  *sysfsfp;
>>  	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>>  
>> -	if (temp == NULL) {
>> +	if (!temp) {
>>  		printf("Memory allocation failed\n");
>>  		return -ENOMEM;
>>  	}
>> @@ -759,7 +759,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
>>  		goto error_free;
>>  
>>  	sysfsfp = fopen(temp, "w");
>> -	if (sysfsfp == NULL) {
>> +	if (!sysfsfp) {
>>  		ret = -errno;
>>  		printf("Could not open %s\n", temp);
>>  		goto error_free;
>> @@ -780,7 +780,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
>>  
>>  	if (verify) {
>>  		sysfsfp = fopen(temp, "r");
>> -		if (sysfsfp == NULL) {
>> +		if (!sysfsfp) {
>>  			ret = -errno;
>>  			printf("Could not open file to verify\n");
>>  			goto error_free;
>> @@ -855,7 +855,7 @@ int read_sysfs_posint(const char *filename, const char *basedir)
>>  	FILE  *sysfsfp;
>>  	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>>  
>> -	if (temp == NULL) {
>> +	if (!temp) {
>>  		printf("Memory allocation failed");
>>  		return -ENOMEM;
>>  	}
>> @@ -865,7 +865,7 @@ int read_sysfs_posint(const char *filename, const char *basedir)
>>  		goto error_free;
>>  
>>  	sysfsfp = fopen(temp, "r");
>> -	if (sysfsfp == NULL) {
>> +	if (!sysfsfp) {
>>  		ret = -errno;
>>  		goto error_free;
>>  	}
>> @@ -902,7 +902,7 @@ int read_sysfs_float(const char *filename, const char *basedir, float *val)
>>  	FILE  *sysfsfp;
>>  	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>>  
>> -	if (temp == NULL) {
>> +	if (!temp) {
>>  		printf("Memory allocation failed");
>>  		return -ENOMEM;
>>  	}
>> @@ -912,7 +912,7 @@ int read_sysfs_float(const char *filename, const char *basedir, float *val)
>>  		goto error_free;
>>  
>>  	sysfsfp = fopen(temp, "r");
>> -	if (sysfsfp == NULL) {
>> +	if (!sysfsfp) {
>>  		ret = -errno;
>>  		goto error_free;
>>  	}
>> @@ -949,7 +949,7 @@ int read_sysfs_string(const char *filename, const char *basedir, char *str)
>>  	FILE  *sysfsfp;
>>  	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>>  
>> -	if (temp == NULL) {
>> +	if (!temp) {
>>  		printf("Memory allocation failed");
>>  		return -ENOMEM;
>>  	}
>> @@ -959,7 +959,7 @@ int read_sysfs_string(const char *filename, const char *basedir, char *str)
>>  		goto error_free;
>>  
>>  	sysfsfp = fopen(temp, "r");
>> -	if (sysfsfp == NULL) {
>> +	if (!sysfsfp) {
>>  		ret = -errno;
>>  		goto error_free;
>>  	}
>> diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
>> index 7f432a5..4f8172f 100644
>> --- a/tools/iio/lsiio.c
>> +++ b/tools/iio/lsiio.c
>> @@ -46,10 +46,10 @@ static int dump_channels(const char *dev_dir_name)
>>  	const struct dirent *ent;
>>  
>>  	dp = opendir(dev_dir_name);
>> -	if (dp == NULL)
>> +	if (!dp)
>>  		return -errno;
>>  
>> -	while (ent = readdir(dp), ent != NULL)
>> +	while (ent = readdir(dp), ent)
>>  		if (check_prefix(ent->d_name, "in_") &&
>>  		    check_postfix(ent->d_name, "_raw"))
>>  			printf("   %-10s\n", ent->d_name);
>> @@ -107,12 +107,12 @@ static int dump_devices(void)
>>  	DIR *dp;
>>  
>>  	dp = opendir(iio_dir);
>> -	if (dp == NULL) {
>> +	if (!dp) {
>>  		printf("No industrial I/O devices available\n");
>>  		return -ENODEV;
>>  	}
>>  
>> -	while (ent = readdir(dp), ent != NULL) {
>> +	while (ent = readdir(dp), ent) {
>>  		if (check_prefix(ent->d_name, type_device)) {
>>  			char *dev_dir_name;
>>  
>> @@ -134,7 +134,7 @@ static int dump_devices(void)
>>  		}
>>  	}
>>  	rewinddir(dp);
>> -	while (ent = readdir(dp), ent != NULL) {
>> +	while (ent = readdir(dp), ent) {
>>  		if (check_prefix(ent->d_name, type_trigger)) {
>>  			char *dev_dir_name;
>>  
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

