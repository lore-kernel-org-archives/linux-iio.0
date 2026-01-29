Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAC2D0600;
	Thu, 29 Jan 2026 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703896; cv=none; b=cNPM7jefG/9z91+d5myvs+DYKZc9U2mbNedjQDBPbjBtau9ytFpKHHYvlDjWpNRf2l9uvD8zbwMf7ZfisxEsrPyLwOhWZT5KR5JRQMVhl4a1R6izSAOOlXWe9v2tTFoUvSFyY2zll1iwTQ3aeenj8T+/E1bAQwPJ8TrQiLa7jJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703896; c=relaxed/simple;
	bh=hAqbh0cpEoXFR306WLoTetPyQmJ7ucKTVXFHDnVbAO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZ9QG+uAsccP08svPNvC60pM+9s+ts9Mu16jswXc6VxXTNPPs+CD0rCELHj1eQV8NioZq6o3Q6DUq3VNY7T0dSr07bLoIq/fJ1RhG1BzlHEmUzwzPqWowz18LEyMMczXoErMH85i+ftI7SsF4cOT7brOWohv0ry5HJya3BTD4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzpVbh46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzpVbh46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457DFC4CEF7;
	Thu, 29 Jan 2026 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703896;
	bh=hAqbh0cpEoXFR306WLoTetPyQmJ7ucKTVXFHDnVbAO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VzpVbh469zpOfuKPfUxrqU/B17PliZUEx96/3IRnp4AUSpojinWhvLwZ756xe8FJD
	 pDAiUFRaM9ZZCG8z41R7TgeQRzja8uzttF1HyZe2L//iO4eet23uhGYhCkFZ8n/sBR
	 QMztIHz4BHqxhuAETDFXDCu68zoMFR6b8yOb7NTHTSxFW8OS9x/UoNr3qXy4dI47dn
	 i51EeuxFwAFKbckfhaV6Ra/hjvZGjgpm+ly8/r9uVCWTfRCu+cUEARIMWOVVZF68VE
	 5kOf/Bf76SWNPvG8FlN2W4VMIjguP+gpqgYU5U2wB0J3XESgfnPNLDu+yPbly/+1v7
	 pgnjGNwSEaXRw==
Date: Thu, 29 Jan 2026 16:24:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Andrew Ijano
 <andrew.ijano@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: accel: adxl380: remove unused odr field
Message-ID: <20260129162446.39e7adf4@jic23-huawei>
In-Reply-To: <20260129141205.106285-2-antoniu.miclaus@analog.com>
References: <20260129141205.106285-1-antoniu.miclaus@analog.com>
	<20260129141205.106285-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 16:11:58 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Remove unused odr field from adxl380_state struct.
> The field is declared but never accessed in the driver.
It is used in my tree...

I blindly applied this on assumption a build test was quicker than
checking if you were right :)

drivers/iio/accel/adxl380.c:271:8: error: no member named 'odr' in 'struct adxl380_state'
  271 |                         st->odr = ADXL380_ODR_VLP;
      |                         ~~  ^
drivers/iio/accel/adxl380.c:273:11: error: no member named 'odr' in 'struct adxl380_state'
  273 |                 if (st->odr == ADXL380_ODR_VLP)
      |                     ~~  ^
drivers/iio/accel/adxl380.c:440:42: error: no member named 'odr' in 'struct adxl380_state'
  440 |         *odr = st->chip_info->samp_freq_tbl[st->odr];
      |                                             ~~  ^
drivers/iio/accel/adxl380.c:518:6: error: no member named 'odr' in 'struct adxl380_state'
  518 |         st->odr = odr;
      |         ~~  ^
drivers/iio/accel/adxl380.c:1967:6: error: no member named 'odr' in 'struct adxl380_state'
 1967 |         st->odr = ADXL380_ODR_DSM;
      |         ~~  ^
5 errors generated.


> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/accel/adxl380.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index aef5109c1ddd..4c584f6ec902 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -206,7 +206,6 @@ struct adxl380_state {
>  	struct mutex lock;
>  	enum adxl380_axis tap_axis_en;
>  	u8 range;
> -	u8 odr;
>  	u8 fifo_set_size;
>  	u8 transf_buf[3];
>  	u16 watermark;

