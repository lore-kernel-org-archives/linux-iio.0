Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031344AbdEXToP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:44:15 -0400
Date: Wed, 24 May 2017 20:44:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH v2 1/3] iio: adc: ina2xx: Make use of attribute flags
 consistent on all channels
Message-ID: <20170524204410.51fec937@kernel.org>
In-Reply-To: <2340f65ef51843f2b4fada09ecbb9048@rwthex-w2-b.rwth-ad.de>
References: <20170524000907.7788-1-stefan.bruens@rwth-aachen.de>
        <2340f65ef51843f2b4fada09ecbb9048@rwthex-w2-b.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 24 May 2017 02:09:05 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Flags for shared channel attributes should be set on all channels of a
> channel set. I.e. SAMP_FREQUENCY and OVERSAMPLING_RATIO are set on the
> in_voltage{0,1} channels, thus should be set on in_power, in_current.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Applied to the togreg branch of iio.git.

Thanks for tidying this up.

Jonathan
> ---
>  drivers/iio/adc/ina2xx-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 6b588ac3130c..bba10a1b2fcb 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -442,6 +442,8 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  			      BIT(IIO_CHAN_INFO_SCALE) | \
>  			      BIT(IIO_CHAN_INFO_INT_TIME), \
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
>  	.scan_index = (_index), \
>  	.scan_type = { \
>  		.sign = 'u', \

