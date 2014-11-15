Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42826 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbaKOQJo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Nov 2014 11:09:44 -0500
Message-ID: <54677AC6.9030001@kernel.org>
Date: Sat, 15 Nov 2014 16:09:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Axel Lin <axel.lin@ingics.com>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: men_z188_adc: Add terminating entry for men_z188_ids
References: <1415606646.23695.0.camel@phoenix>
In-Reply-To: <1415606646.23695.0.camel@phoenix>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/14 08:04, Axel Lin wrote:
> The mcb_device_id table is supposed to be zero-terminated.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
> ---
>  drivers/iio/adc/men_z188_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
> index b58d630..d095efe 100644
> --- a/drivers/iio/adc/men_z188_adc.c
> +++ b/drivers/iio/adc/men_z188_adc.c
> @@ -152,6 +152,7 @@ static void men_z188_remove(struct mcb_device *dev)
>  
>  static const struct mcb_device_id men_z188_ids[] = {
>  	{ .device = 0xbc },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(mcb, men_z188_ids);
>  
> 

