Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35292 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbaGMUze (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 16:55:34 -0400
Message-ID: <53C2F2CD.1010805@kernel.org>
Date: Sun, 13 Jul 2014 21:57:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 08/12] iio:adc:ad799x: Add helper function to read/write
 config register
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-9-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 05:54, Peter Meerwald wrote:
> 16-bit on ad7997/ad7998, 8-bit elsewhere
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>   drivers/iio/adc/ad799x.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 92401c9..fe2a9b1 100644
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

