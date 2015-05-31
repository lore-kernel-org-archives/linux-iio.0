Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35781 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbFAVQ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:56 -0400
Message-ID: <556B56B7.9090802@kernel.org>
Date: Sun, 31 May 2015 19:45:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 22/32] tools:iio:lsiio: add error handling
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de> <29c8e3159f3b5fc3fac7bee3b624eb57e1adf2d7.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <29c8e3159f3b5fc3fac7bee3b624eb57e1adf2d7.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> Add error handling to calls which can indicate a major problem by
> returning an error code.
> This also involves to change the type of dump_devices() from void to int.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/lsiio.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
> index daa6c53..b1089ad 100644
> --- a/tools/iio/lsiio.c
> +++ b/tools/iio/lsiio.c
> @@ -69,7 +69,10 @@ static int dump_one_device(const char *dev_dir_name)
>  			"%i", &dev_idx);
>  	if (retval != 1)
>  		return -EINVAL;
> -	read_sysfs_string("name", dev_dir_name, name);
> +	retval = read_sysfs_string("name", dev_dir_name, name);
> +	if (retval)
> +		return retval;
> +
>  	printf("Device %03d: %s\n", dev_idx, name);
>  
>  	if (verblevel >= VERBLEVEL_SENSORS)
> @@ -87,20 +90,24 @@ static int dump_one_trigger(const char *dev_dir_name)
>  			"%i", &dev_idx);
>  	if (retval != 1)
>  		return -EINVAL;
> -	read_sysfs_string("name", dev_dir_name, name);
> +	retval = read_sysfs_string("name", dev_dir_name, name);
> +	if (retval)
> +		return retval;
> +
>  	printf("Trigger %03d: %s\n", dev_idx, name);
>  	return 0;
>  }
>  
> -static void dump_devices(void)
> +static int dump_devices(void)
>  {
>  	const struct dirent *ent;
> +	int ret;
>  	DIR *dp;
>  
>  	dp = opendir(iio_dir);
>  	if (dp == NULL) {
>  		printf("No industrial I/O devices available\n");
> -		return;
> +		return -ENODEV;
>  	}
>  
>  	while (ent = readdir(dp), ent != NULL) {
> @@ -109,11 +116,16 @@ static void dump_devices(void)
>  
>  			if (asprintf(&dev_dir_name, "%s%s", iio_dir,
>  				     ent->d_name) < 0) {
> -				printf("Memory allocation failed\n");
> +				ret = -ENOMEM;
> +				goto error_close_dir;
> +			}
> +
> +			ret = dump_one_device(dev_dir_name);
> +			if (ret) {
> +				free(dev_dir_name);
>  				goto error_close_dir;
>  			}
>  
> -			dump_one_device(dev_dir_name);
>  			free(dev_dir_name);
>  			if (verblevel >= VERBLEVEL_SENSORS)
>  				printf("\n");
> @@ -126,16 +138,26 @@ static void dump_devices(void)
>  
>  			if (asprintf(&dev_dir_name, "%s%s", iio_dir,
>  				     ent->d_name) < 0) {
> -				printf("Memory allocation failed\n");
> +				ret = -ENOMEM;
> +				goto error_close_dir;
> +			}
> +
> +			ret = dump_one_trigger(dev_dir_name);
> +			if (ret) {
> +				free(dev_dir_name);
>  				goto error_close_dir;
>  			}
>  
> -			dump_one_trigger(dev_dir_name);
>  			free(dev_dir_name);
>  		}
>  	}
> +	return (closedir(dp) == -1) ? -errno : 0;
> +
>  error_close_dir:
> -	closedir(dp);
> +	if (closedir(dp) == -1)
> +		perror("dump_devices(): Failed to close directory");
> +
> +	return ret;
>  }
>  
>  int main(int argc, char **argv)
> @@ -163,7 +185,5 @@ int main(int argc, char **argv)
>  		exit(1);
>  	}
>  
> -	dump_devices();
> -
> -	return 0;
> +	return dump_devices();
>  }
> 

