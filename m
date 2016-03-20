Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56712 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbcCTKbu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2016 06:31:50 -0400
Subject: Re: [PATCH 1/2] iio: adc: max1363: add missing adc to max1363_id
To: Stefan Eichenberger <eichest@gmail.com>
References: <1458316264-18244-1-git-send-email-stefan.eichenberger@netmodule.com>
Cc: linux-iio@vger.kernel.org, stefan.eichenberger@netmodule.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56EE7C14.5020804@kernel.org>
Date: Sun, 20 Mar 2016 10:31:48 +0000
MIME-Version: 1.0
In-Reply-To: <1458316264-18244-1-git-send-email-stefan.eichenberger@netmodule.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/03/16 15:51, Stefan Eichenberger wrote:
> max11644-max11647 had an enum value but were not added to the max1363_id,
> so they where not selectable in the devictree.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@netmodule.com>
oops - applied to the fixes branch of iio.git,

Thanks,

Jonathan
> ---
>  drivers/iio/adc/max1363.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 929508e..b5d28c0 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1680,6 +1680,10 @@ static const struct i2c_device_id max1363_id[] = {
>  	{ "max11615", max11615 },
>  	{ "max11616", max11616 },
>  	{ "max11617", max11617 },
> +	{ "max11644", max11644 },
> +	{ "max11645", max11645 },
> +	{ "max11646", max11646 },
> +	{ "max11647", max11647 },
>  	{}
>  };
>  
> 

