Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:45004 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555Ab1JZLgW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2011 07:36:22 -0400
Message-ID: <4EA7F0BD.5060206@cam.ac.uk>
Date: Wed, 26 Oct 2011 12:36:29 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: adc: ad7280a: Fix memory leak
References: <1319627774-27278-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1319627774-27278-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/26/11 12:16, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Free channels in case read fails with error.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad7280a.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 0c212e0..f45b66b 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -688,7 +688,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  
>  	ret = ad7280_read_all_channels(st, st->scan_cnt, channels);
>  	if (ret < 0)
> -		return IRQ_HANDLED;
> +		goto out;
>  
>  	for (i = 0; i < st->scan_cnt; i++) {
>  		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6) {
> @@ -731,6 +731,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  		}
>  	}
>  
> +out:
>  	kfree(channels);
>  
>  	return IRQ_HANDLED;

