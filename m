Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp103.mer-nm.internl.net ([217.149.192.139]:51224 "EHLO
	smtp103.mer-nm.internl.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751826AbaKZLvO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 26 Nov 2014 06:51:14 -0500
Message-ID: <5475BEAB.3020700@topic.nl>
Date: Wed, 26 Nov 2014 12:51:07 +0100
From: Mike Looijmans <mike.looijmans@topic.nl>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad799x: Fix ad7991/ad7995/ad7999 config setup
References: <1416998135-19931-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1416998135-19931-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

﻿Tested it on the Miami board, and this patch indeed fixes the issue. You can 
add my tested-by if you like:

Tested-by: Mike Looijmans <mike.looijmans@topic.nl>


On 11/26/2014 11:35 AM, Lars-Peter Clausen wrote:
> The ad7991/ad7995/ad7999 does not have a configuration register like the
> other devices that can be written and read. The configuration is written as
> part of the conversion sequence.
>
> Fixes: 0f7ddcc1bff1 ("iio:adc:ad799x: Write default config on probe and reset alert status on probe")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   drivers/iio/adc/ad799x.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index e37412d..b99de00 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -143,9 +143,15 @@ static int ad799x_write_config(struct ad799x_state *st, u16 val)
>   	case ad7998:
>   		return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
>   			val);
> -	default:
> +	case ad7992:
> +	case ad7993:
> +	case ad7994:
>   		return i2c_smbus_write_byte_data(st->client, AD7998_CONF_REG,
>   			val);
> +	default:
> +		/* Will be written when doing a conversion */
> +		st->config = val;
> +		return 0;
>   	}
>   }
>
> @@ -155,8 +161,13 @@ static int ad799x_read_config(struct ad799x_state *st)
>   	case ad7997:
>   	case ad7998:
>   		return i2c_smbus_read_word_swapped(st->client, AD7998_CONF_REG);
> -	default:
> +	case ad7992:
> +	case ad7993:
> +	case ad7994:
>   		return i2c_smbus_read_byte_data(st->client, AD7998_CONF_REG);
> +	default:
> +		/* No readback support */
> +		return st->config;
>   	}
>   }
>
>



Met vriendelijke groet / kind regards,

Mike Looijmans
System Expert


TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Please consider the environment before printing this e-mail

Topic zoekt gedreven (embedded) software specialisten!
http://topic.nl/vacatures/topic-zoekt-software-engineers/

