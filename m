Return-Path: <SRS0=aSiY=47=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 25 May 2017 08:46:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harinath Nampally <harinath922@gmail.com>
Cc: lars@metafoo.de, devel@driverdev.osuosl.org,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
	jic23@kernel.org
Subject: Re: [PATCH] staging: iio: light: Replace snprintf calls with
 scnprintf
Message-ID: <20170525064627.GA7597@kroah.com>
References: <1495668131-5239-1-git-send-email-harinath922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495668131-5239-1-git-send-email-harinath922@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 24, 2017 at 07:22:11PM -0400, Harinath Nampally wrote:
> This patch fixes the miscoded use of return value of snprintf
> by using the scnprintf function which returns the length of actual
> string created in the buffer.
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 1467199..6908bc1 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -921,7 +921,7 @@ static ssize_t power_state_show(struct device *dev,
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", chip->tsl2x7x_chip_status);
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", chip->tsl2x7x_chip_status);

It should just be sprintf(), no need for testing for PAGE_SIZE for sysfs
attributes, we "know" an integer will not overflow that buffer.

thanks,

greg k-h
