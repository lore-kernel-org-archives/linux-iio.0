Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48687 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbaBCT16 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2014 14:27:58 -0500
Message-ID: <52EFEDD7.7030300@kernel.org>
Date: Mon, 03 Feb 2014 19:28:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Johannes Thumshirn <morbidrsa@gmail.com>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: viperboard: Drop platform_set_drvdata call
References: <1391266364-14383-1-git-send-email-morbidrsa@gmail.com>
In-Reply-To: <1391266364-14383-1-git-send-email-morbidrsa@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 01/02/14 14:52, Johannes Thumshirn wrote:
> Drop call to platform_set_drvdata as driver data is not used anywhere in the
> driver
>
> Signed-off-by: Johannes Thumshirn <morbidrsa@gmail.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/adc/viperboard_adc.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
> index d0add8f..9acf6b6 100644
> --- a/drivers/iio/adc/viperboard_adc.c
> +++ b/drivers/iio/adc/viperboard_adc.c
> @@ -139,8 +139,6 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>
> -	platform_set_drvdata(pdev, indio_dev);
> -
>   	return 0;
>   }
>
>
