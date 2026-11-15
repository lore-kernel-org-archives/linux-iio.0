Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701813;
	b=XFHxpPB0Ss7sKoz/ZAEYCQsGVpiGeVt3VXi7kz/7svBBbGP7AavXmS+tjLuOPyvuVHCQ
	 X8wZr/zwni3uZTZ5v4dUVXWB5FtoShflhWXaDJJ6s80GG5KZKUjfwplyUXF8jYhUIwyT4
	 ht0F0kWaQnUjuCuxmOl0zP1wB8+FKqO/Pmi8tuZs0s6P9WOjXBRaakXEGa8tGEtkBGPeV
	 gcz/zDy7CxgUbYzfwmTZ+O1TO+Vgygqk9bEvZJVIUWgLVoJTl5fSjGmN4R8pET4HLIn33
	 uGHW/doRKA1A3arlzN+KsuSNlPOuDDXwOLYiCYmqtw4HkDNxYaYdsLsytOXUAXT55bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701813;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Kg1PlE4fOnBwYniQ0lGay4dPoZeME5amR887QdfdhFk=;
	b=bZ66El1qMm/74dnN0wYPAs8Tud89LdK9etWOOYdUegTW/Ygmvjsp3BbDTHqR/3kuoNc9
	 tmeY/XooKIOj6TSlJJuoxqF8X6caSe6G2Zl+swjOw988sKR0id0U99bVvhBoKgznjY5e8
	 VFl53oRrCm1MsArW17YMaknFEj556jVxxihuEn/FiPq36Ya7VsztFq/XDQMlNyelHV1cu
	 mwIbLWLZOhjFQebczvgy18S94TQy4MDjJl8DmQli5IJTGc5IUod/CTYK1R+iW7VZ7tTwN
	 3gxLxlQmra/iB5TOi19+RB57iMvcaTbRnkMuBG0ZYIpOFGuSXMwy4A02f38Zp9IKqUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1h7HIAq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DA606A323;
	Sun, 15 Nov 2026 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1h7HIAq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1251F000C6;
	Sun, 15 Nov 2026 00:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794701812;
	bh=Kg1PlE4fOnBwYniQ0lGay4dPoZeME5amR887QdfdhFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q1h7HIAqH+yzapxRE0Non13QKTRF4/5wLgXm78NtK9tdv9YYsixRgD4n6fYy1Iyg5
	 lL8gDepv/bRn+n1EPVOjH5VvqvQAGQgygF2dbcwWGh8PAwBgyO7Mbxst7YjeTTqmlg
	 IOb6m2pWlRdRm3+5iPYMGTCv8WpaXGcd/kcMpUpw8IjtH9phwcMj1LCGMIyMmRiPeW
	 SGwz1/rW6p6iQMFM7MJ6d/AqktAxLzPbdgl5kBFLICYcx7+A4SFadHb5d8Co/wbZ9M
	 StBearJeoqdeVnfmi+qB1chod8IG1phF6h6JCp0YDFsOw8iaGxZZECvonh4QSXxbpQ
	 CG7U+rdATJ8PQ==
Date: Sun, 15 Nov 2026 00:16:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 10/11] iio: adc: ti-ads1015: inline
 ads1015_set_conv_mode()
Message-ID: <20261115001645.60c1cf90@jic23-hlaptop>
In-Reply-To: <20261109165805.31160-5-architanant5@gmail.com>
References: <20261109165805.31160-1-architanant5@gmail.com>
	<20261109165805.31160-5-architanant5@gmail.com>
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

On Mon,  9 Nov 2026 22:28:04 +0530
Archit Anant <architanant5@gmail.com> wrote:

> The ads1015_set_conv_mode() helper function is a single-line wrapper
> around regmap_update_bits().
> 
> Since the function is simple and only called during initialization and
> power management state transitions, the wrapper is unnecessary. Remove
> it and inline the regmap_update_bits() logic directly at the call sites
> to improve code readability and traceabilty.
> 
> Where applicable, introduce a local 'map' pointer to keep the
> inlined function calls concise.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 93a8318e950e2..2c3ba1b91aac4 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c

...

> @@ -956,6 +951,7 @@ static int ads1015_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
>  	struct ads1015_data *data;
> +	struct regmap *map;
>  	int ret;
>  	int i;
>  
> @@ -1007,8 +1003,9 @@ static int ads1015_probe(struct i2c_client *client)
>  	data->regmap = devm_regmap_init_i2c(client, chip->has_comparator ?
>  					    &ads1015_regmap_config :
>  					    &tla2024_regmap_config);
> -	if (IS_ERR(data->regmap))
> -		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +	map = data->regmap;

Where it is easy enough to do, don't put error pointers into structures.
 So

	map = devm_regmap_init_i2c();
	if (IS_ERR(map))
		return dev_err_probe(dev, PTR_ERR(map),
				     "Failed to allocate register map\n");

	data->regmap = map;

I'm not advocating whole scale cleanup of other drivers for this
as it is churn heavy but here it makes the code you are changing
anyway better.

> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
>  				     "Failed to allocate register map\n");
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,

