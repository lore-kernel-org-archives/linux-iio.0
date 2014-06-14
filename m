Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43362 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683AbaFNOTY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 10:19:24 -0400
Message-ID: <539C5A60.5060805@kernel.org>
Date: Sat, 14 Jun 2014 15:21:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 02/12] iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 05:54, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/adc/ad799x.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 6eba301..6cf9ee1 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -105,9 +105,8 @@ enum {
>    * struct ad799x_chip_info - chip specific information
>    * @channel:		channel specification
>    * @num_channels:	number of channels
> - * @monitor_mode:	whether the chip supports monitor interrupts
>    * @default_config:	device default configuration
> - * @event_attrs:	pointer to the monitor event attribute group
> + * @info:		pointer to iio_info struct
>    */
>   struct ad799x_chip_info {
>   	struct iio_chan_spec		channel[9];
>

