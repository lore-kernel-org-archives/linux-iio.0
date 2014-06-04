Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-156.synserver.de ([212.40.185.156]:1104 "EHLO
	smtp-out-155.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932327AbaFDIF1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jun 2014 04:05:27 -0400
Message-ID: <538ED344.1030604@metafoo.de>
Date: Wed, 04 Jun 2014 10:05:24 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 11/15] iio:adc:ad799x: Add helper function to read/write
 config register
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-12-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/2014 12:42 AM, Peter Meerwald wrote:
> 16-bit on ad7997/ad7998, 8-bit elsewhere
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Should this and patch 13 be considered a bug fix?

> ---
>   drivers/iio/adc/ad799x.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index dbc7c2b..0219970 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -136,6 +136,30 @@ struct ad799x_state {
>   	unsigned int			transfer_size;
>   };
>
> +static int ad799x_write_config(struct ad799x_state *st, u16 val)
> +{
> +	switch (st->id) {
> +	case ad7997:
> +	case ad7998:
> +		return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
> +			val);
> +	default:
> +		return i2c_smbus_write_byte_data(st->client, AD7998_CONF_REG,
> +			val);
> +	}
> +}
> +
> +static int ad799x_read_config(struct ad799x_state *st)
> +{
> +	switch (st->id) {
> +	case ad7997:
> +	case ad7998:
> +		return i2c_smbus_read_word_swapped(st->client, AD7998_CONF_REG);
> +	default:
> +		return i2c_smbus_read_byte_data(st->client, AD7998_CONF_REG);
> +	}
> +}
> +
>   /**
>    * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
>    *
>

