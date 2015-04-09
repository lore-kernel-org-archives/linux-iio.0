Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52823 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbbDIOOB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 10:14:01 -0400
Message-ID: <55268925.7000005@kernel.org>
Date: Thu, 09 Apr 2015 15:13:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Karol Wrona <k.wrona@samsung.com>,
	Jan Kardell <jan.kardell@telliq.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, fcooper@ti.com
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: refactor DT parsing into
 a function
References: <1427800357-21680-1-git-send-email-vigneshr@ti.com> <1427800357-21680-2-git-send-email-vigneshr@ti.com>
In-Reply-To: <1427800357-21680-2-git-send-email-vigneshr@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/15 12:12, Vignesh R wrote:
> Refactor DT parsing into a separate function from probe() to
> help addition of more DT parameters later.
> 
> No functional changes.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
Clearly going to need this whatever the outcome of the second patch being
reviewed.

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 2e5cc4409f78..2f818405ffbe 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -396,16 +396,30 @@ static const struct iio_info tiadc_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +static int tiadc_parse_dt(struct platform_device *pdev,
> +			  struct tiadc_device *adc_dev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct property *prop;
> +	const __be32 *cur;
> +	int channels = 0;
> +	u32 val;
> +
> +	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
> +		adc_dev->channel_line[channels] = val;
> +		channels++;
> +	}
> +
> +	adc_dev->channels = channels;
> +	return 0;
> +}
> +
>  static int tiadc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev		*indio_dev;
>  	struct tiadc_device	*adc_dev;
>  	struct device_node	*node = pdev->dev.of_node;
> -	struct property		*prop;
> -	const __be32		*cur;
>  	int			err;
> -	u32			val;
> -	int			channels = 0;
>  
>  	if (!node) {
>  		dev_err(&pdev->dev, "Could not find valid DT data.\n");
> @@ -421,12 +435,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  	adc_dev = iio_priv(indio_dev);
>  
>  	adc_dev->mfd_tscadc = ti_tscadc_dev_get(pdev);
> -
> -	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
> -		adc_dev->channel_line[channels] = val;
> -		channels++;
> -	}
> -	adc_dev->channels = channels;
> +	tiadc_parse_dt(pdev, adc_dev);
>  
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->name = dev_name(&pdev->dev);
> 

