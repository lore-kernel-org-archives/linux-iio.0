Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-155.synserver.de ([212.40.185.155]:1027 "EHLO
	smtp-out-155.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321AbaFDHoo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jun 2014 03:44:44 -0400
Message-ID: <538ECE69.50204@metafoo.de>
Date: Wed, 04 Jun 2014 09:44:41 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 03/15] iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/2014 12:42 AM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/iio/adc/ad799x.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 39b4cb4..7e08c60 100644
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

