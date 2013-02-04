Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:41784 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab3BDX5a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2013 18:57:30 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHP00KMSZV93C70@mailout4.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 05 Feb 2013 08:57:28 +0900 (KST)
Received: from [10.90.8.51] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MHP00411ZVRVPA0@mmp1.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 05 Feb 2013 08:57:28 +0900 (KST)
Message-id: <51104AE7.2020909@samsung.com>
Date: Tue, 05 Feb 2013 08:57:27 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Anton Vorontsov <cbou@mail.ru>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] iio: Update iio_channel_get API to use consumer device
 pointer as argument
References: <1360009566-26347-1-git-send-email-linux@roeck-us.net>
 <1360009566-26347-2-git-send-email-linux@roeck-us.net>
In-reply-to: <1360009566-26347-2-git-send-email-linux@roeck-us.net>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/2013 05:26 AM, Guenter Roeck wrote:
> For iio_channel_get to work with OF based configurations, it needs the
> consumer device pointer instead of the consumer device name as argument.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/extcon/extcon-adc-jack.c    |    3 +--
>   drivers/iio/inkern.c                |   11 ++++++++++-
>   drivers/power/generic-adc-battery.c |    4 ++--
>   drivers/power/lp8788-charger.c      |    8 ++++----
>   include/linux/iio/consumer.h        |    5 +++--
>   5 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
> index eda2a1a..d0233cd 100644
> --- a/drivers/extcon/extcon-adc-jack.c
> +++ b/drivers/extcon/extcon-adc-jack.c
> @@ -135,8 +135,7 @@ static int adc_jack_probe(struct platform_device *pdev)
>   		;
>   	data->num_conditions = i;
>   
> -	data->chan = iio_channel_get(dev_name(&pdev->dev),
> -			pdata->consumer_channel);
> +	data->chan = iio_channel_get(&pdev->dev, pdata->consumer_channel);
>   	if (IS_ERR(data->chan)) {
>   		err = PTR_ERR(data->chan);
>   		goto out;
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c42aba6..b289915 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -93,7 +93,8 @@ static const struct iio_chan_spec
Ack for drivers/extcon .

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

