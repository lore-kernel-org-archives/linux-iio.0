Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdGAKHA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 06:07:00 -0400
Date: Sat, 1 Jul 2017 11:06:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: linux-iio@vger.kernel.org, Maarten Brock <m.brock@vanmierlo.com>
Subject: Re: [PATCH 1/3] iio: adc: mcp3422: Changing initial channel
Message-ID: <20170701110656.3ff5b462@kernel.org>
In-Reply-To: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
References: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 28 Jun 2017 23:53:09 +0200
Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:

> Initial channel should be the first available channel on
> all configurations, so changing to channel 0 available on
> all supported chips.
> 
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
I'm going to apply these the 'slow' route as the failure case in
patch 2 is reasonably uncommon.  Maarten if you want to request
a back port to stable after these have merged (will probably
be a while given where we are in the cycle) then that's fine
with me.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/mcp3422.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 254135e..6737df8 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -379,7 +379,7 @@ static int mcp3422_probe(struct i2c_client *client,
>  
>  	/* meaningful default configuration */
>  	config = (MCP3422_CONT_SAMPLING
> -		| MCP3422_CHANNEL_VALUE(1)
> +		| MCP3422_CHANNEL_VALUE(0)
>  		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
>  		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
>  	mcp3422_update_config(adc, config);

