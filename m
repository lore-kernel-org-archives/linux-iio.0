Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35756 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbbFAVQw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:52 -0400
Message-ID: <556B50A7.9060205@kernel.org>
Date: Sun, 31 May 2015 19:19:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 14/32] tools:iio:iio_utils: implement digit calculation
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de> <70d40a8692e2f83fc72eb1d0ea9a011d5b62e37e.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <70d40a8692e2f83fc72eb1d0ea9a011d5b62e37e.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> Previously, the return value of sscanf() was treated as an indication of
> the digits it would have read. Yet, sscanf() only returns the amount of
> valid matches.
> Therefore, introduce a function to calculate the decimal digits of the
> read number and use this one to commence a colon search, as originally
> intended.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.  Ouch.
> ---
>  tools/iio/iio_utils.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index c5b4136..60e5ec4 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -431,6 +431,18 @@ error_ret:
>  	return ret;
>  }
>  
> +int calc_digits(int num)
> +{
> +	int count = 0;
> +
> +	while (num != 0) {
> +		num /= 10;
> +		count++;
> +	}
> +
> +	return count;
> +}
> +
>  /**
>   * find_type_by_name() - function to match top level types by name
>   * @name: top level type instance name
> @@ -441,7 +453,7 @@ error_ret:
>  int find_type_by_name(const char *name, const char *type)
>  {
>  	const struct dirent *ent;
> -	int number, numstrlen;
> +	int number, numstrlen, ret;
>  
>  	FILE *nameFile;
>  	DIR *dp;
> @@ -459,9 +471,19 @@ int find_type_by_name(const char *name, const char *type)
>  			strcmp(ent->d_name, "..") != 0 &&
>  			strlen(ent->d_name) > strlen(type) &&
>  			strncmp(ent->d_name, type, strlen(type)) == 0) {
> -			numstrlen = sscanf(ent->d_name + strlen(type),
> -					   "%d",
> -					   &number);
> +			errno = 0;
> +			ret = sscanf(ent->d_name + strlen(type), "%d", &number);
> +			if (ret < 0) {
> +				ret = -errno;
> +				printf("failed to read element number\n");
> +				goto error_close_dir;
> +			} else if (ret != 1) {
> +				ret = -EIO;
> +				printf("failed to match element number\n");
> +				goto error_close_dir;
> +			}
> +
> +			numstrlen = calc_digits(number);
>  			/* verify the next character is not a colon */
>  			if (strncmp(ent->d_name + strlen(type) + numstrlen,
>  					":",
> @@ -495,6 +517,11 @@ int find_type_by_name(const char *name, const char *type)
>  	}
>  	closedir(dp);
>  	return -ENODEV;
> +
> +error_close_dir:
> +	if (closedir(dp) == -1)
> +		perror("find_type_by_name(): Failed to close directory");
> +	return ret;
>  }
>  
>  int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
> 

