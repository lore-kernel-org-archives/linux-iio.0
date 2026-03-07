Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0740337BBB;
	Sat,  7 Mar 2026 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904651; cv=none; b=ZFtu+iSy8c+osNd8tVtZMk0NmBsqOWQgQZbBU70ec8bOjF7ON+Sgj6tz8CoOuZ4huqzgpwKB2NJNLczB0ZaOxaw0+xQ8pKemxMD1Yij2yrxFB3zyqtG9F18ShYXANSOxJWxC9g4TDqT159UL9lwBAJM98hE1FECDRfaN3tjvWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904651; c=relaxed/simple;
	bh=0m8eb92p5f4C9KbX4jyODM6pL4cuRbS8g830oWZMYtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccLgl83gIGoNMcgy4PpmrwB69lxrzcj70IdLZjmoUArPy6vjKRUAAkCY51eD8CavtOQELatBhgqHx6djCaDdPCkUc55iKJjOgOy9UI5AS2pzJtrn7PyPaiuKCwQ554XB0vOoOZxsFtxaIcxlsw03uQ4mA4nEyrvBn5uDXw5E3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRtOXQNk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRtOXQNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D03C19423;
	Sat,  7 Mar 2026 17:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772904651;
	bh=0m8eb92p5f4C9KbX4jyODM6pL4cuRbS8g830oWZMYtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JRtOXQNk0UDuvahW88jNlhNtq1FmjLnfdj3rfTMihuxzsYoVr9N7UowIQM9VOOPP4
	 UlVGakSEGNGev2ydrhgQUKFmG9CX1jme1boejxTNkjen0SnFQMDkdjedQbYnvtXoTO
	 1oWGRNGsZV+NPfJJbsZYy4OLw+hpAQvo0qzmvO6gfcDp53Mri8M28/1HT4m5lKjpsK
	 AfTMnFrL6MW1Kgj1wwcc6+/rLN3r22tHQLd5NBVeieSW36bFFZvCrMRXQ380nCKJzj
	 o+BC280uB1jCkKar/6uDJWMkpnOnn5X9YEMrpoADS5KfXVpGB9/tT3AQyCkl1TEcG2
	 xxDgWUrwcoTEg==
Date: Sat, 7 Mar 2026 17:30:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v2 5/6] iio: chemical: fix spelling mistake in comment
Message-ID: <20260307173043.65482c27@jic23-huawei>
In-Reply-To: <20260307104705.49129-6-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
	<20260307104705.49129-6-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 16:17:04 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> fix incorrect spelling in comment
> 
> - insuffient -> insufficient
Similar to earlier. Say this in the patch description given
it's just the one thing.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 70f81c4a96ba..204663330bb3 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -807,7 +807,7 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
> 	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
> 
> 	/*
> -	 * occurs if either the gas heating duration was insuffient
> +	 * occurs if either the gas heating duration was insufficient
> 	 * to reach the target heater temperature or the target
> 	 * heater temperature was too high for the heater sink to
> 	 * reach.
> --
> 2.53.0

