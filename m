Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53589 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbcAPNCz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 08:02:55 -0500
Subject: Re: [PATCH v2] iio: light: acpi-als: Report data as processed
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
References: <1452180105-9584-1-git-send-email-gabriele.mzt@gmail.com>
 <1452612099-26630-1-git-send-email-gabriele.mzt@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
	marxin.liska@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A3F7C.2050400@kernel.org>
Date: Sat, 16 Jan 2016 13:02:52 +0000
MIME-Version: 1.0
In-Reply-To: <1452612099-26630-1-git-send-email-gabriele.mzt@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/01/16 15:21, Gabriele Mazzotta wrote:
> As per the ACPI specification (Revision 5.0) [1], the data coming
> from the sensor represent the ambient light illuminance reading
> expressed in lux. So use IIO_CHAN_INFO_PROCESSED to signify that
> the data are pre-processed.
> 
> However, to keep backward ABI compatibility, the IIO_CHAN_INFO_RAW
> bit is not removed.
> 
> [1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Applied to the fixes-togreg branch and marked for stable.

I added a bit to the commit message including that bug report you found for
iio-sensor-proxy as additional justification for the stable marking
and sending it as a fix.

Jonathan

> ---
>  drivers/iio/light/acpi-als.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 60537ec..53201d9 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -54,7 +54,9 @@ static const struct iio_chan_spec acpi_als_channels[] = {
>  			.realbits	= 32,
>  			.storagebits	= 32,
>  		},
> -		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW),
> +		/* _RAW is here for backward ABI compatibility */
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
> +					  BIT(IIO_CHAN_INFO_PROCESSED),
>  	},
>  };
>  
> @@ -152,7 +154,7 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
>  	s32 temp_val;
>  	int ret;
>  
> -	if (mask != IIO_CHAN_INFO_RAW)
> +	if ((mask != IIO_CHAN_INFO_PROCESSED) && (mask != IIO_CHAN_INFO_RAW))
>  		return -EINVAL;
>  
>  	/* we support only illumination (_ALI) so far. */
> 

