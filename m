Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47776 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFGQZh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 12:25:37 -0400
Message-ID: <5574707F.6000109@kernel.org>
Date: Sun, 07 Jun 2015 17:25:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Belisko <marek@goldelico.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	hns@goldelico.com
Subject: Re: [PATCH 1/2] iio: adc: twl4030_madc: Fix calculation of the temperature
 sense current
References: <1432842619-7251-1-git-send-email-marek@goldelico.com>
In-Reply-To: <1432842619-7251-1-git-send-email-marek@goldelico.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/05/15 20:50, Marek Belisko wrote:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
> 
> The bit mask to read the setting of the constant current source
> for measuring the NTC voltage was the wrong one. Since default
> value is initialized to the lowest level (000 = 10uA) the difference
> was probably never noticed in practice.
I'm going to take that literally and apply it via the slow route on
the basis that a bug no one noticed doesn't need fixing fast!
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/twl4030-madc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index 94c5f05..6d2d429 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -235,7 +235,7 @@ static int twl4030battery_temperature(int raw_volt)
>  	if (ret < 0)
>  		return ret;
>  
> -	curr = ((val & TWL4030_BCI_ITHEN) + 1) * 10;
> +	curr = ((val & TWL4030_BCI_ITHSENS) + 1) * 10;
>  	/* Getting and calculating the thermistor resistance in ohms */
>  	res = volt * 1000 / curr;
>  	/* calculating temperature */
> 

