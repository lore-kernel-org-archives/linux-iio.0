Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F712E285C;
	Sat, 14 Feb 2026 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771094187; cv=none; b=ALf6pNw5H9kATop7jQ38I/hAKUugaGHuyzSvbFwR8l9d2oztFK4mf5Nov8fjACyACof6zESj3QzJscEu79T1tNiAVJZltzGrNUnhehXxQZoEpElm8/ZIk0DaAm1HsFHFiQur9wknT+wGzXr/xHifErvao5klbKO6Qf4VrBm6PTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771094187; c=relaxed/simple;
	bh=MD4tqM10zaHwJjS9x+1TvAOjoWB0dW1elVxWOVPcaag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8Hhrt3INKXzEbtTXq4EHbZLfi/yDFCl0cj9KDAxtJqhmcsarYiZXLmdQvgtmEuZt0MClF8Bz+gGRopQ2dVFe6TkCSH9qm5sLbzAL/cTZje5Ndp3nyXn+CgQuweutK+S4XDZzBdGstsRNiYn3A9567Op3ojbRxBQTtLWcB66J6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/LRujBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/LRujBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D659C16AAE;
	Sat, 14 Feb 2026 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771094187;
	bh=MD4tqM10zaHwJjS9x+1TvAOjoWB0dW1elVxWOVPcaag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s/LRujBvav6cirWCooDfTKeHbfzcZhbIwACESA/BLx8XX2ViXnrLm7wEPaqtbLTXQ
	 GH2ETPcHgLsi2c87/OgfDXhRYkIwvrD4Q2T7xqKGgB7WkNeIFC0pGA39/0VjfNzSLl
	 8BKrDEezlhlm8iyPMl7DfvcsTZyYCbm3SVx+tpSc/F5DJvvHBxH7ueuY2v5Zk1As0c
	 /zZpYAJkXHzVCddg8zY5MICmvkWhSEQDKVPn91CcNFc5F5QLmXqZj/WE0EscyS3lUG
	 94kDlKmMC/9oYUliONz/9nM5OBXJ19XRgY+7esMgUJG6lKxm8OGcHMQzW5VdxBwE8C
	 72FjSwtjy7Y9g==
Date: Sat, 14 Feb 2026 18:36:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 05/11] iio: amplifiers: ad8366: use devm_mutex_init()
 and drop mutex_init()
Message-ID: <20260214183616.14f790bc@jic23-huawei>
In-Reply-To: <20260210-iio-ad8366-update-v4-5-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
	<20260210-iio-ad8366-update-v4-5-15505f7b15b4@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 19:42:05 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Adopt proper mutex lifecycle with devm_mutex_init(), replacing
> mutex_init(). Also, Include linux/mutex.h header.

Why move the *mutex_init()?  Even if it is just because it looks better there,
not breaking up spi related stuff, then say that.

> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/amplifiers/ad8366.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 3456a31cb1ee..f0053a09cbb6 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  
> @@ -251,6 +252,10 @@ static int ad8366_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
>  	st->reg = devm_regulator_get(&spi->dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
> @@ -259,7 +264,6 @@ static int ad8366_probe(struct spi_device *spi)
>  	}
>  
>  	spi_set_drvdata(spi, indio_dev);
> -	mutex_init(&st->lock);
>  	st->spi = spi;
>  	st->type = spi_get_device_id(spi)->driver_data;
>  
> 

