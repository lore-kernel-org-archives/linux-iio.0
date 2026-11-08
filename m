Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794100238;
	b=Sl6soh2qHLU8aICxtDz5zfiGvHimyEP9OrGempNPvGNsUwQ1WBKHG9WzaoB+I6er2s13
	 YNyWHb8IAJ92l+twCOxqJlEDZ7rT8sFgdXFwYo1dF8a/4r1adv/4w3Qz+WA9sSwobBw3r
	 v6qK8GSB2keZJlDqfwJNUp8KGFH/oydiCbeZ5Brb4z8QHQRVhfXbSBQfbPGKeWxBjdd45
	 +LLCN798odgtH7azELF03YSyVzk/UvG/kMnCRxBB+fQTqPWVJo7Z5QsUzfV+T7O9wpVYX
	 eBuGgh4i/upK4b4pGZtC6yrJ2O+47DUKrcNFJxWq4OQGuokfOEBcwhfgwRkbBbxWWgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100238;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=prGr2rCCPYq8dfhCbZ3/nC39kFMYq8jBR7hx9f+mnLo=;
	b=gJLV/dRFmwOe5W9oqanPqvWav7QlCIzqn9BWYGNJOZy3r5UH0Xxvoc3yCi1rKxB0xKH6
	 83RRbIHqiRzVj4TKDQUQq1z6jHKvmZBEfkdTVDcjr8WeKKsgSDlBfVXN/IvaaekYovE9Q
	 nO95tZiSbUscWRgn9SbeI0hU4g1yQ+4f/b0t++iK6vSr7qqoxD5fCPyP5WtSyKzhJUxBH
	 sygKU9GzzYkjVXW9a8l77jpc8+J+gOrJEz2D/OA7Xr22Ws920Bmq/1wvyzBUhGZV4512c
	 mEbnI/DWl1oUU8Vy/rQJhC7ReM5H7Y4NYPAl2VjLqyh+wAD57bOtRivgfRshbGA3wyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="inXbqEd/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4675606A326;
	Sun,  8 Nov 2026 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inXbqEd/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74471F0089F;
	Sun,  8 Nov 2026 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794100237;
	bh=prGr2rCCPYq8dfhCbZ3/nC39kFMYq8jBR7hx9f+mnLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=inXbqEd/xXfmjPcrGSfIfjCEz7mHVQDRMB+W3CMVltYyeEb0Ko3wi7/t4zcVxq1np
	 0Hq7g3ZgXoFCSAU4osDVbUbwtC5dGRp/lKvUs1bdKVdf/3+XZ8vY7F2ADmlaTSiI9H
	 U1V+dMNuuAjr4JlVYb/IGby/YXw1InoG4Tj4CiWGrcHQ+uMsgiE9UDCCWsMXUN2ePB
	 al8CNyofwH8zIL4OPLDYyvXhHIRHMthCh8ozKHcPonsbwARIBvig0EZqz6TdIlkMlK
	 rrDQuKK7CYH0YhWWZCp4HuIMLaiEtEz0eaYYnRRq7HcTzcI0LJ4Tu5kxTVb30GkgGV
	 JHs4ZoE4tsNTA==
Date: Sun, 8 Nov 2026 01:10:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Matt
 Ranostay <mranostay@gmail.com>, Robert Eshleman <bobbyeshleman@gmail.com>,
 Leonard Crestez <cdleonard@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: light: apds9960: Report the available lists
 via read_avail()
Message-ID: <20261108011029.6a195efb@jic23-hlaptop>
In-Reply-To: <20261102074700.63075-3-arka@arkamondal.net>
References: <20261102074700.63075-1-arka@arkamondal.net>
	<20261102074700.63075-3-arka@arkamondal.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 16:46:56 +0900
Arka Mondal <arka@arkamondal.net> wrote:

> The proximity and intensity channels put IIO_CHAN_INFO_SCALE in
> info_mask_shared_by_type, and the intensity channels put
> IIO_CHAN_INFO_INT_TIME there too. The values those attributes accept
> are listed by three custom attributes: proximity_scale_available,
> intensity_scale_available and integration_time_available. None of the
> three carries the in_ prefix that the core gives the attribute it
> describes, so all three are registered at the device level, and
> userspace looking for in_proximity_scale_available,
> in_intensity_scale_available or in_intensity_integration_time_available
> finds nothing.
> 
> Report all three through read_avail() and drop the custom attribute
> group. The two gain lists keep their exact text. The integration time
> list becomes 0.028000 0.100000 0.200000 0.700000 instead of 0.028 0.1
> 0.2 0.7, because the core prints IIO_VAL_INT_PLUS_MICRO with six
> decimals. The values are unchanged.
> 
> Fixes: aff268cd532e ("iio: light: add APDS9960 ALS + promixity driver")
> Signed-off-by: Arka Mondal <arka@arkamondal.net>

Applied this patch to the testing branch of iio.git.

> ---
> 
> Notes:
>     Compile tested only; no relevant hardware available.

Fwiw it is fairly easy to stub enough to get a driver to load and
then just check these static files.  The i2c test stuff
in tree works, or qemu if you prefer that path.

Perhaps if you are going to do a lot of this sort of patch
it might be worth you exploring how to do that.

> 
>  drivers/iio/light/apds9960.c | 56 +++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index afe520de60e2..496678c4d338 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -289,6 +289,8 @@ static const struct iio_event_spec apds9960_als_event_spec[] = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
>  			BIT(IIO_CHAN_INFO_INT_TIME), \
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) | \
> +			BIT(IIO_CHAN_INFO_INT_TIME), \
>  	.channel2 = IIO_MOD_LIGHT_##_colour, \
>  	.address = APDS9960_REG_ALS_CHANNEL(_colour), \
>  	.modified = 1, \
> @@ -304,6 +306,7 @@ static const struct iio_chan_spec apds9960_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_CALIBBIAS),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
>  		.channel = 0,
>  		.indexed = 0,
>  		.scan_index = -1,
> @@ -322,6 +325,8 @@ static const struct iio_chan_spec apds9960_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
>  			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_INT_TIME),
>  		.channel2 = IIO_MOD_LIGHT_CLEAR,
>  		.address = APDS9960_REG_ALS_CHANNEL(CLEAR),
>  		.modified = 1,
> @@ -370,19 +375,11 @@ static const int apds9960_int_time[][2] = {
>  static const int apds9960_pxs_gain_map[] = {1, 2, 4, 8};
>  static const int apds9960_als_gain_map[] = {1, 4, 16, 64};
>  
> -static IIO_CONST_ATTR(proximity_scale_available, "1 2 4 8");
> -static IIO_CONST_ATTR(intensity_scale_available, "1 4 16 64");
> -static IIO_CONST_ATTR_INT_TIME_AVAIL("0.028 0.1 0.2 0.7");
> -
> -static struct attribute *apds9960_attributes[] = {
> -	&iio_const_attr_proximity_scale_available.dev_attr.attr,
> -	&iio_const_attr_intensity_scale_available.dev_attr.attr,
> -	&iio_const_attr_integration_time_available.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group apds9960_attribute_group = {
> -	.attrs = apds9960_attributes,
> +static const int apds9960_int_time_avail[] = {
> +	0, 28000,
> +	0, 100000,
> +	0, 200000,
> +	0, 700000,
>  };
>  
>  static const struct reg_field apds9960_reg_field_int_als =
> @@ -786,8 +783,39 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static int apds9960_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			*vals = apds9960_pxs_gain_map;
> +			*length = ARRAY_SIZE(apds9960_pxs_gain_map);
> +			break;
> +		case IIO_INTENSITY:
> +			*vals = apds9960_als_gain_map;
> +			*length = ARRAY_SIZE(apds9960_als_gain_map);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*vals = apds9960_int_time_avail;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = ARRAY_SIZE(apds9960_int_time_avail);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct iio_info apds9960_info = {
> -	.attrs = &apds9960_attribute_group,
> +	.read_avail = apds9960_read_avail,
>  	.read_raw = apds9960_read_raw,
>  	.write_raw = apds9960_write_raw,
>  	.read_event_value = apds9960_read_event,

