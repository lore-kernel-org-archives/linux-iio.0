Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794100131;
	b=fVn9D7w7q4/6LX6oO4XOvdViKUtV3z2ZHCgdmY8/N2DAC1CUjPImYM8vhlALm0+YhPOq
	 zFVF0ZR2w024WMJ5bQDPrKOmSmQZiltjtQkHDzLzySgiBJQjU77ymjNOOwhiKt92Uv4L2
	 /gOOcq3L1pG7l0fATWrz8jS6eSfjWYtKyLQ9qlDJlxax0PG+ctpEYyGod6VfKHIUoi+Cd
	 sPOM64Rs50N2M9rWuwXUUirn9cxSy6jCzF0TehrJ3pGGFWwyNWGjcsvXQVP8eZ0baryjt
	 bSnxe+62v+cs4ozcycPXIsRWOQCDOeo2ObhV1ocrVAVIeESa3KmUab64dVBjONQIMbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100131;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dX2zHeR5d9CMhKQ6rCUIn3F7g835XMuk8GBF9JMR+cg=;
	b=hgE62VwBnaU9W9Qidey1kUnXPPlQFbm/nAHNAbIcl16ixvyX26IxIbwUA4zqIKZp15V5
	 IzRUfe6UIH0mh/jCmYaFD/uFhHPN+M0CmoWtUkZrISHq/zb7+mDib0YmlU7NklDn5pME0
	 ZI2B+ZBuDtWqolVw4U8DjkeFNN9go/QPQNN4I6B3CgqRhiJrG5M4crBMVzb3O51Xc9dPo
	 Hn2A1vNL42UOD9bsT42vnOuc1QgNlA16shk5JZ1QuOvLzL1yCWlnTaX/gS8yUJm5PsXwG
	 k1uUEm3S9fWJTKlVGoewRP2Xmvjpx5yzqv8hxuDZ9oR756k0GRHiR7QJ+pQqvj0Qqzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6OCgzQr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E62606A326;
	Sun,  8 Nov 2026 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6OCgzQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BBE1F0089F;
	Sun,  8 Nov 2026 01:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794100130;
	bh=dX2zHeR5d9CMhKQ6rCUIn3F7g835XMuk8GBF9JMR+cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f6OCgzQrM2EjdKw/HL5UxbEH/Vj/Nfm5Gb1un7DWFiqZs02cFMIndOeTTt3TYbmfE
	 6YEu7iD1CHZwIKWfQmvbUiER6I9sHYmFBLJ9rJVhDHcM/NobFZj21HMR5TcKJzcaFy
	 jfi4CdGpA23J3tGEv6ZZek8c9Sy6ehgQdPeGyojNsDLlZk12hho1GDiytFP2uyoIJJ
	 QRdbwVYeT6wcVemSjIyw2VCBn9FrMFUvjZVIMp/TzWrtPEzmBsX/9x7tS9orDc/Xlr
	 F+8uci5NNmWOL229b8QLg0QufLdGvBtk3nFyc6gscCZo6md/Q7FHbgEdHQNPoQ7gK3
	 cCdaWiFsZTA2w==
Date: Sun, 8 Nov 2026 01:08:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Matt
 Ranostay <mranostay@gmail.com>, Robert Eshleman <bobbyeshleman@gmail.com>,
 Leonard Crestez <cdleonard@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: light: max44009: Report the integration time
 via read_avail()
Message-ID: <20261108010842.13470b16@jic23-hlaptop>
In-Reply-To: <20261102074700.63075-4-arka@arkamondal.net>
References: <20261102074700.63075-1-arka@arkamondal.net>
	<20261102074700.63075-4-arka@arkamondal.net>
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

On Mon,  2 Nov 2026 16:46:57 +0900
Arka Mondal <arka@arkamondal.net> wrote:

> The light channel has IIO_CHAN_INFO_INT_TIME in info_mask_separate,
> so userspace reads the integration time from
> in_illuminance_integration_time. The values it accepts are listed by
> a custom attribute called illuminance_integration_time_available.
> That name lacks the in_ prefix the core puts on the attribute it
> describes, so it is registered at the device level, and userspace
> looking for in_illuminance_integration_time_available finds nothing.
> 
> Report the list through read_avail() and drop the custom attribute
> along with the string it printed. read_avail() wants the values as
> IIO_VAL_INT_PLUS_NANO pairs, while max44009_write_int_time() rounds a
> request to the nearest supported value with find_closest_descending()
> over a flat table, so the two forms stay as separate tables.
> 
> The eight values do not change. The core prints them with nine
> decimals, so the attribute now reads 0.800000000 down to 0.006250000
> instead of 0.8 down to 0.00625.
> 
> Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
> Signed-off-by: Arka Mondal <arka@arkamondal.net>
> ---
> 
> Notes:
>     Compile tested only; no relevant hardware available.
> 
>  drivers/iio/light/max44009.c | 48 ++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
> index 82b8a806c5fa..c27f0f9ecc44 100644
> --- a/drivers/iio/light/max44009.c
> +++ b/drivers/iio/light/max44009.c
> @@ -66,15 +66,16 @@ static const u32 max44009_int_time_ns_array[] = {
>  	6250000,  /* Manual mode only */
>  };
>  
> -static const char max44009_int_time_str[] =
> -	"0.8 "
> -	"0.4 "
> -	"0.2 "
> -	"0.1 "
> -	"0.05 "
> -	"0.025 "
> -	"0.0125 "
> -	"0.00625";
> +static const int max44009_int_time_avail[] = {
> +	0, 800000000,
> +	0, 400000000,
> +	0, 200000000,
> +	0, 100000000,
> +	0, 50000000,
> +	0, 25000000,
> +	0, 12500000,
> +	0, 6250000,
Lot of zeros...

> +};
>  
>  struct max44009_data {
>  	struct i2c_client *client;
> @@ -101,6 +102,7 @@ static const struct iio_chan_spec max44009_channels[] = {
>  		.type = IIO_LIGHT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>  				      BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
>  		.event_spec = max44009_event_spec,
>  		.num_event_specs = ARRAY_SIZE(max44009_event_spec),
>  	},
> @@ -284,17 +286,21 @@ static int max44009_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static IIO_CONST_ATTR(illuminance_integration_time_available,
> -		      max44009_int_time_str);
> -
> -static struct attribute *max44009_attributes[] = {
> -	&iio_const_attr_illuminance_integration_time_available.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group max44009_attribute_group = {
> -	.attrs = max44009_attributes,
> -};
> +static int max44009_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*vals = max44009_int_time_avail;
> +		*type = IIO_VAL_INT_PLUS_NANO;

And the reason for the extra zeros is this.  Why not use PLUS_MICRO
and drop 3 of them.

> +		*length = ARRAY_SIZE(max44009_int_time_avail);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
>  
>  static int max44009_threshold_byte_from_fraction(int integral, int fractional)
>  {
> @@ -464,7 +470,7 @@ static const struct iio_info max44009_info = {
>  	.read_event_config = max44009_read_event_config,
>  	.write_event_value = max44009_write_event_value,
>  	.write_event_config = max44009_write_event_config,
> -	.attrs = &max44009_attribute_group,
> +	.read_avail = max44009_read_avail,
>  };
>  
>  static irqreturn_t max44009_threaded_irq_handler(int irq, void *p)

