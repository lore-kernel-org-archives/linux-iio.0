Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbeKLCtt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:49:49 -0500
Date: Sun, 11 Nov 2018 17:00:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v6 1/2] staging: iio: adc: ad7280a: power down the
 device on error in probe
Message-ID: <20181111170041.5b8bfcc6@archlinux>
In-Reply-To: <20181111155911.3604-2-sst@poczta.fm>
References: <20181111155911.3604-1-sst@poczta.fm>
        <20181111155911.3604-2-sst@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Nov 2018 16:59:10 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> Power down the device if anything goes wrong after the SPI has been
> setup correctly in the probe function.
> 
> Existing code that toggles the AD7280A_CTRL_LB_SWRST bit inside
> ad7280_chain_setup function is responsible for powering up the device.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Hi Slawomir,

Nearly perfect... But see inline...
> ---
>  drivers/staging/iio/adc/ad7280a.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 58420dcb406d..3ab06fd87675 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -870,7 +870,7 @@ static int ad7280_probe(struct spi_device *spi)
>  
>  	ret = ad7280_chain_setup(st);
>  	if (ret < 0)
> -		return ret;
> +		goto error_power_down;
The ideal is always for a function to unwind on error to the point where
it leaves no visible side effects.  As such we should power down 'inside'
chain_setup on error (unfortunately there are a lot exit paths in that
function so the resulting patch will be larger than this :(

This may seem a pain to do this way, but it makes the code flow
more obvious generally making things cleaner.

Rather than go around again for such a trivial thing, I've
made the change and pushed out the updated patch to the togreg
branch of iio.git as testing for the autobuilders to see if
I messed it up!

Note this will move the resulting devm call as well. I'll do that for
patch 2.

Jonathan


>  
>  	st->slave_num = ret;
>  	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
> @@ -901,7 +901,7 @@ static int ad7280_probe(struct spi_device *spi)
>  
>  	ret = ad7280_channel_init(st);
>  	if (ret < 0)
> -		return ret;
> +		goto error_power_down;
>  
>  	indio_dev->num_channels = ret;
>  	indio_dev->channels = st->channels;
> @@ -950,6 +950,9 @@ static int ad7280_probe(struct spi_device *spi)
>  error_free_channels:
>  	kfree(st->channels);
>  
> +error_power_down:
> +	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
> +		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
>  	return ret;
>  }
>  
