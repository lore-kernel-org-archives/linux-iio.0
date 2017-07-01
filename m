Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdGAKHd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 06:07:33 -0400
Date: Sat, 1 Jul 2017 11:07:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: linux-iio@vger.kernel.org, Maarten Brock <m.brock@vanmierlo.com>
Subject: Re: [PATCH 2/3] iio: adc: mcp3422: Checking for error on probe
Message-ID: <20170701110729.767ec879@kernel.org>
In-Reply-To: <1498687088-28529-2-git-send-email-angelo.compagnucci@gmail.com>
References: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
        <1498687088-28529-2-git-send-email-angelo.compagnucci@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 28 Jun 2017 23:53:10 +0200
Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:

> Some part of the configuration are not touched after the probe
> and if something goes wrong on writing the initial one,
> the chip will misbehave.
> Adding an error checking ensures that the inital configuration will
> be written correctly. Moreover ensures that a sensible configuration
> will be saved in driver data and used subsequently as intended.
> 
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.
Added a reported by for Maarten.

Jonathan
> ---
>  drivers/iio/adc/mcp3422.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 6737df8..63de705 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -382,7 +382,9 @@ static int mcp3422_probe(struct i2c_client *client,
>  		| MCP3422_CHANNEL_VALUE(0)
>  		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
>  		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
> -	mcp3422_update_config(adc, config);
> +	err = mcp3422_update_config(adc, config);
> +	if (err < 0)
> +		return err;
>  
>  	err = devm_iio_device_register(&client->dev, indio_dev);
>  	if (err < 0)

