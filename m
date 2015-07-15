Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:54663 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbbGOSMm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 15 Jul 2015 14:12:42 -0400
Message-ID: <55A6A295.9020102@gmx.de>
Date: Wed, 15 Jul 2015 20:12:37 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Andrea Galbusera <gizero@gmail.com>, jic23@kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: mcp320x: add masking of unknown bits
References: <1436880983-29017-1-git-send-email-gizero@gmail.com>
In-Reply-To: <1436880983-29017-1-git-send-email-gizero@gmail.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Andrea Galbusera schrieb am 14.07.2015 um 15:36:
> According to the datasheet, the 2 MSBs for parts 3001 and 3201 are
> unspecified and should be masked out
> 

Hi,
since resolution is already set, better make it more generic by applying
the mask in _read_raw like this:

*val = ret & GENMASK(adc->chip_info->resolution - 1, 0);

Thanks,
Hartmut

> Signed-off-by: Andrea Galbusera <gizero@gmail.com>
> ---
> 
> This was already suggested but for some reason got lost during review of a
> previous patch. See http://marc.info/?l=linux-iio&m=140748835509583&w=2
> and following discussion
> 
>  drivers/iio/adc/mcp320x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 8d9c9b9..0673ee7 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -114,13 +114,13 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>  
>  	switch (device_index) {
>  	case mcp3001:
> -		return (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
> +		return ((adc->rx_buf[0] & 0x1f) << 5 | adc->rx_buf[1] >> 3);
>  	case mcp3002:
>  	case mcp3004:
>  	case mcp3008:
>  		return (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
>  	case mcp3201:
> -		return (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
> +		return ((adc->rx_buf[0] & 0x1f) << 7 | adc->rx_buf[1] >> 1);
>  	case mcp3202:
>  	case mcp3204:
>  	case mcp3208:
> 

