Return-Path: <SRS0=a9na=2Z=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 16 Mar 2017 23:05:55 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Robles <miguel.robles@farole.net>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: frequency: use octal permissions instead
 of symbolic
Message-ID: <20170316140555.GB30080@kroah.com>
References: <1489672056-7957-1-git-send-email-miguel.robles@farole.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489672056-7957-1-git-send-email-miguel.robles@farole.net>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 16, 2017 at 02:47:36PM +0100, Miguel Robles wrote:
> Fix checkpatch warnings:
> Symbolic permissions are not preferred. Consider using octal permissions.
> 
> Signed-off-by: Miguel Robles <miguel.robles@farole.net>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 20 ++++++++++----------
>  drivers/staging/iio/frequency/ad9834.c | 22 +++++++++++-----------
>  drivers/staging/iio/frequency/dds.h    |  2 +-
>  3 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 8d40c8e..163a4ef 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -248,22 +248,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>   * see dds.h for further information
>   */
>  
> -static IIO_DEV_ATTR_FREQ(0, 0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ0HM);
> -static IIO_DEV_ATTR_FREQ(0, 1, S_IWUSR, NULL, ad9832_write, AD9832_FREQ1HM);
> -static IIO_DEV_ATTR_FREQSYMBOL(0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ_SYM);
> +static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> +static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);

Meta-comment, would a IIO_DEV_ATTR_WO_FREQ() and friends help out here?
That way it's impossible to get the permission values incorrect.

thanks,

greg k-h
