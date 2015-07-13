Return-Path: <knaack.h@gmx.de>
Message-ID: <55A438B6.50205@gmx.de>
Date: Tue, 14 Jul 2015 00:16:22 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Cristina Opriceana <cristina.opriceana@gmail.com>,
 jic23@kernel.org
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
 octavian.purdila@intel.com
Subject: Re: [PATCH v3] tools: iio: Send error messages to stderr
References: <b9014ff8b0916710f88ba01c41261782fcb819a8.1436792589.git.cristina.opriceana@gmail.com>
In-Reply-To: <b9014ff8b0916710f88ba01c41261782fcb819a8.1436792589.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Cristina Opriceana schrieb am 13.07.2015 um 15:33:
> This patch intends to make some cleanup and send printf
> error messages to stderr. The changes were performed with coccinelle
> for failure messages and manual for other cases, such as wrong usage
> messages.
> 

Looking very good so far. Two off-by-one indentation issues spotted however
(checkpatch didn't spot at least the first one), but after fixing you can
add my

Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>

> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> ---
> Changes since v2:
>  - merge all replacements in one commit
> 
>  tools/iio/generic_buffer.c    | 23 +++++++++++---------
>  tools/iio/iio_event_monitor.c | 14 ++++++-------
>  tools/iio/iio_utils.c         | 49 +++++++++++++++++++++++++------------------
>  tools/iio/lsiio.c             |  2 +-
>  4 files changed, 50 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 9535c2d..249858a 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -193,7 +193,7 @@ void process_scan(char *data,
>  
>  void print_usage(void)
>  {
> -	printf("Usage: generic_buffer [options]...\n"
> +	fprintf(stderr, "Usage: generic_buffer [options]...\n"
>  	       "Capture, convert and output data from IIO device buffer\n"
>  	       "  -c <n>     Do n conversions\n"
>  	       "  -e         Disable wait for event (new data)\n"

These lines should be moved one space to the right, as well.

<...>
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index e177f40..15bd663 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
<...>  
> @@ -800,8 +808,9 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
>  		}
>  
>  		if (strcmp(temp, val) != 0) {
> -			printf("Possible failure in string write of %s "
> -			       "Should be %s written to %s/%s\n", temp, val,
> +			fprintf(stderr,
> +				"Possible failure in string write of %s "
> +				"Should be %s written to %s/%s\n", temp, val,
>  			       basedir, filename);

And this is the other instance.

>  			ret = -1;
>  		}
