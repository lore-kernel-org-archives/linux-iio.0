Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-156.synserver.de ([212.40.185.156]:1119 "EHLO
	smtp-out-156.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbaFDIBu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jun 2014 04:01:50 -0400
Message-ID: <538ED26D.1090106@metafoo.de>
Date: Wed, 04 Jun 2014 10:01:49 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 07/15] iio:adc:ad799x: Only expose event interface when
 IRQ is available
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-8-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/2014 12:42 AM, Peter Meerwald wrote:
> an IRQ is necessary to handle the ALERT condition; without
> IRQ, the IIO event interface serves no purpose
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Makes sense. We should probably at some point investigate if it is possible 
to implement something to ignore certain channel attributes when the channel 
is created, rather than having to have two almost identical declarations of 
the channel arrays.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

[...]
> @@ -612,8 +702,9 @@ static int ad799x_probe(struct i2c_client *client,
>   	i2c_set_clientdata(client, indio_dev);
>
>   	st->id = id->driver_data;
> -	st->chip_info = &ad799x_chip_info_tbl[st->id];
> -	st->config = st->chip_info->default_config;
> +	st->chip_config = (client->irq > 0 && chip_info->irq_config.info) ?
> +		&chip_info->irq_config : &chip_info->noirq_config;

Nitpick: should be

	if (...)
		st->chip_config = ...;
	else
		st->chip_config = ...;

> +	st->config = st->chip_config->default_config;
>
>   	/* TODO: Add pdata options for filtering and bit delay */
>
[...]
