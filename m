Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16C36EAAD;
	Thu,  7 May 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171337; cv=none; b=Hq29IB+J3KsgVU7OuRftHVQnzmcOiP0aDDxSl97LPJUSdn9OxsSjxb3va6SchSpg9lP2hw+6Jtm0utxLbXDuD1iFpRwtM71xTpUoOvWv8BxNGxkdSM4KoNRUCsUQzFamlJjyM6xsTZY7X4O2DfjMnXJ1hGglqy7KKa+iaeNX6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171337; c=relaxed/simple;
	bh=YQW5tIdpT4e0V4gbbu1QTVy5IIIwvNojePa4U4wXd58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5VXEZc5bkJ44LgVd1Iq9GENdPzxwNl5V+5kyIhIsossNXS9Fdrk1/1GUoJ6gCv9YbPeNqToajBu4lDEU+fKH60EpqDbkXJKeuwkyTFMPFE8ywQ+J2Q0IAJqkCvbd0pfSnaj4MZv+TXz+pBICvbp38yrjSzcpe+H/PUWSPPwKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8UO7HXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8UO7HXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED89C2BCC4;
	Thu,  7 May 2026 16:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778171337;
	bh=YQW5tIdpT4e0V4gbbu1QTVy5IIIwvNojePa4U4wXd58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8UO7HXYQmZvIOiyt8eRwzylba0ujkQR39CZyMCfSIPmKu0cNmJzlMg3rEA6c+FJw
	 9f0IIKPgfvqVIGHczZOhCyyqhd7kU+p57JG6IogZsDw4aGc6nc/LwSMjHy8G9eFcWz
	 9znwSWeD7fHP8mqvEYetM299BtSu18Uf2vVmCjVz4C+kHlTn0m657vkRSaYPy9dTaX
	 ZKcbhssLXRFANfvoX7dKAIDePvxilGKzYbJ6kaKiNRb6hzY9sV5Jxyq7s0mSxIa5HO
	 kRkSfrUahBE6Aa12Oki0zH9a5i6XpuTtrD+oUiSfdQ62uVo7xr8vBl070+QAcGEopJ
	 +lEpzKnp/JLpw==
Date: Thu, 7 May 2026 17:28:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 1/3] iio: adc: ti-ads1298: Add parentheses around
 macro parameter
Message-ID: <20260507172848.1f472782@jic23-huawei>
In-Reply-To: <20260507105129.25639-2-shofiqtest@gmail.com>
References: <20260507105129.25639-1-shofiqtest@gmail.com>
	<20260507105129.25639-2-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 13:51:26 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> ADS1298_REG_CHnSET() is missing parentheses around the parameter 'n'.
> Add them to follow kernel macro coding style and prevent potential
> operator precedence issues if the argument is an expression.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
Hi.

You should have picked up Mike's tag for v2.
Maybe he'll give it again - if not if everything else is fine I'll sort
this out whilst applying.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ti-ads1298.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index ae30b47e45..cf5f954206 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -66,7 +66,7 @@
>  #define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)
>  
>  #define ADS1298_REG_LOFF	0x04
> -#define ADS1298_REG_CHnSET(n)	(0x05 + n)
> +#define ADS1298_REG_CHnSET(n)	(0x05 + (n))
>  #define ADS1298_MASK_CH_PD		BIT(7)
>  #define ADS1298_MASK_CH_PGA		GENMASK(6, 4)
>  #define ADS1298_MASK_CH_MUX		GENMASK(2, 0)

