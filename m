Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35762 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbFAVQw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:52 -0400
Message-ID: <556B5129.3020404@kernel.org>
Date: Sun, 31 May 2015 19:21:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 16/32] tools:iio: catch errors in string allocation
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de> <29a631c03c9f07b4d19daf4f6f59081a90392a57.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <29a631c03c9f07b4d19daf4f6f59081a90392a57.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> This patch catches errors in string allocation in generic_buffer.c,
> iio_event_monitor.c, iio_utils.c and lsiio.c.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.

Thanks
> ---
>  tools/iio/generic_buffer.c    |  4 +++-
>  tools/iio/iio_event_monitor.c |  2 ++
>  tools/iio/iio_utils.c         |  9 ++++++---
>  tools/iio/lsiio.c             | 15 +++++++++++++--
>  4 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index bd974b8..9164b27 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -234,7 +234,9 @@ int main(int argc, char **argv)
>  	}
>  	printf("iio device number being used is %d\n", dev_num);
>  
> -	asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
> +	ret = asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
> +	if (ret < 0)
> +		return -ENOMEM;
>  
>  	if (!notrigger) {
>  		if (trigger_name == NULL) {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 578390d..1374374 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -265,6 +265,8 @@ int main(int argc, char **argv)
>  		/* If we can't find a IIO device by name assume device_name is a
>  		   IIO chrdev */
>  		chrdev_name = strdup(device_name);
> +		if (!chrdev_name)
> +			return -ENOMEM;
>  	}
>  
>  	fd = open(chrdev_name, 0);
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 812153f..f0896f46 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -36,7 +36,7 @@ int iioutils_break_up_name(const char *full_name,
>  	char *current;
>  	char *w, *r;
>  	char *working, *prefix = "";
> -	int i;
> +	int i, ret;
>  
>  	for (i = 0; i < sizeof(iio_direction) / sizeof(iio_direction[0]); i++)
>  		if (!strncmp(full_name, iio_direction[i],
> @@ -46,6 +46,9 @@ int iioutils_break_up_name(const char *full_name,
>  		}
>  
>  	current = strdup(full_name + strlen(prefix) + 1);
> +	if (!current)
> +		return -ENOMEM;
> +
>  	working = strtok(current, "_\0");
>  
>  	w = working;
> @@ -59,10 +62,10 @@ int iioutils_break_up_name(const char *full_name,
>  		r++;
>  	}
>  	*w = '\0';
> -	asprintf(generic_name, "%s_%s", prefix, working);
> +	ret = asprintf(generic_name, "%s_%s", prefix, working);
>  	free(current);
>  
> -	return 0;
> +	return (ret == -1) ? -ENOMEM : 0;
>  }
>  
>  /**
> diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
> index 65a2385..daa6c53 100644
> --- a/tools/iio/lsiio.c
> +++ b/tools/iio/lsiio.c
> @@ -107,7 +107,12 @@ static void dump_devices(void)
>  		if (check_prefix(ent->d_name, type_device)) {
>  			char *dev_dir_name;
>  
> -			asprintf(&dev_dir_name, "%s%s", iio_dir, ent->d_name);
> +			if (asprintf(&dev_dir_name, "%s%s", iio_dir,
> +				     ent->d_name) < 0) {
> +				printf("Memory allocation failed\n");
> +				goto error_close_dir;
> +			}
> +
>  			dump_one_device(dev_dir_name);
>  			free(dev_dir_name);
>  			if (verblevel >= VERBLEVEL_SENSORS)
> @@ -119,11 +124,17 @@ static void dump_devices(void)
>  		if (check_prefix(ent->d_name, type_trigger)) {
>  			char *dev_dir_name;
>  
> -			asprintf(&dev_dir_name, "%s%s", iio_dir, ent->d_name);
> +			if (asprintf(&dev_dir_name, "%s%s", iio_dir,
> +				     ent->d_name) < 0) {
> +				printf("Memory allocation failed\n");
> +				goto error_close_dir;
> +			}
> +
>  			dump_one_trigger(dev_dir_name);
>  			free(dev_dir_name);
>  		}
>  	}
> +error_close_dir:
>  	closedir(dp);
>  }
>  
> 

