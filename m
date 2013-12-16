Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-038.synserver.de ([212.40.185.38]:1127 "EHLO
	smtp-out-047.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751147Ab3LPIwV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Dec 2013 03:52:21 -0500
Message-ID: <52AEBF77.1000800@metafoo.de>
Date: Mon, 16 Dec 2013 09:53:11 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net,
	o.v.kravchenko@globallogic.com, stigge@antcom.de
Subject: Re: [PATCH 23/24] staging:iio:ad799x replaces IIO_ST macro with explicit
 entries to struct scan_type
References: <1386787542-19666-1-git-send-email-jic23@kernel.org> <1386787542-19666-24-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-24-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/2013 07:45 PM, Jonathan Cameron wrote:
> IIO_ST is going away as it is a pain to maintain. As an i2c driver, multi byte
> words will be read by the driver in the native cpu endianness.

Are you sure about this? As far as I understand it the I2C message will be
read byte by byte. The device sends the MSB first, so I think it should be
IIO_BE.

> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/adc/ad799x_core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index 5ea36410f716..45e64d8bf29b 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -409,7 +409,13 @@ static const struct iio_event_spec ad799x_events[] = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>  	.scan_index = (_index), \
> -	.scan_type = IIO_ST('u', _realbits, 16, 12 - (_realbits)), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = (_realbits), \
> +		.storagebits = 16, \
> +		.shift = 12 - (_realbits), \
> +		.endianness = IIO_CPU, \
> +		}, \
>  	.event_spec = _ev_spec, \
>  	.num_event_specs = _num_ev_spec, \
>  }
> 

