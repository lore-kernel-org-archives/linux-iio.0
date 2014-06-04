Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-156.synserver.de ([212.40.185.156]:1042 "EHLO
	smtp-out-155.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932067AbaFDH5N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jun 2014 03:57:13 -0400
Message-ID: <538ED158.5050704@metafoo.de>
Date: Wed, 04 Jun 2014 09:57:12 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 08/15] iio:adc:ad799x: Make chan_spec const in ad799x_chip_config
 struct
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-9-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/2014 12:42 AM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/iio/adc/ad799x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index eb49ac1..0f97cd2 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -107,7 +107,7 @@ enum {
>    * @info:		pointer to iio_info struct
>    */
>   struct ad799x_chip_config {
> -	struct iio_chan_spec		channel[9];
> +	const struct iio_chan_spec	channel[9];
>   	u16				default_config;
>   	const struct iio_info		*info;
>   };
>

