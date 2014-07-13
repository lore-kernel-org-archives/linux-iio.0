Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35273 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbaGMUyr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 16:54:47 -0400
Message-ID: <53C2F29E.1010907@kernel.org>
Date: Sun, 13 Jul 2014 21:57:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 07/12] iio:adc:ad799x: Make chan_spec const in ad799x_chip_config
 struct
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-8-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 05:54, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
applied
> ---
>   drivers/iio/adc/ad799x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index b8a8117..92401c9 100644
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

