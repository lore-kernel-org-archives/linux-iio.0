Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB81C84DC;
	Mon, 21 Sep 2026 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789953557; cv=none; b=Sd75EZVY10axNeTtaS+sGA/Snwl8EsNwm6OOfLYl1Gdl5O69/pCYHFFHeCRBePywiI2usd8bss3dCqMB93y6v35m/j1QwB5ayDiFFE9VvBs9js9hLA/3dXErqNkzVHm19BW87r1kDS/HDkoRFpwGXijRBmwYjQKbTDePmgQAkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789953557; c=relaxed/simple;
	bh=lbIvY/eynchDqImJvtzesABbQmPFXvGMa/yqsKHTN7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcTsNcaYVQWP+urmnOAPXYVqHa2jYGKtZqpvPVWLc5ZNYoT3TElv03SR9ZVONeRX1t1f22D+8D51R79CSWI5w5ZDecevO/w529CQHvwAcQt5mklhnEPEH4cw25jarwWixA2rX/DzhRnK8A3sdJ9T0bMKx+ZeSqttenRRxQhjYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeJQ8wn1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeJQ8wn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190301F000FF;
	Mon, 21 Sep 2026 01:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789953556;
	bh=cEJrBwba1qEIXFQQfHI7h6KYj9erQ0v70wmojbek39E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LeJQ8wn1yif8N3iG4icAXyRdXUfjQYFVjTzIYmbIdbzgXo9rj+sRmyDkr5OMa/Od3
	 Ktu68cNzVFpbQCsxzixd0ShoIVpipckRl6j2+43NAYRasr/nsXI8NvIeAxMhhhlJxx
	 fcDvLCqektYeX4bkl2Dgt1OBWsN27uItskoGgteCkP/6XO4WeVJWL7iAbZB0bM0AIw
	 WqHN0yWLZp94yyEtpykQjz2uuoO2dZhTWIXBywoJG8qJ+XNCBLcYbX7ZJjxSRZeDTl
	 7H3P8s9IFiZIJy5+GHz7l8DVZH2lfuzETqlpZhOHT6n34WEDhgzzpJoFD3cnuj+i/X
	 q3D1ydftKESGQ==
Date: Mon, 21 Sep 2026 02:19:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 03/15] iio: adc: ad4134: Drop import to empty name
 space
Message-ID: <20260921021912.44f97d2c@jic23-hlaptop>
In-Reply-To: <8e4ab2b09873f171767da897e02dd60c56f0a0c5.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
	<8e4ab2b09873f171767da897e02dd60c56f0a0c5.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 16:12:38 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Drop unused name space that somehow remained being included by the device
> driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
I'll pick this one up now even if the rest need more time

Applied, thanks,

Jonathan

> ---
> No changes since v1.
> 
>  drivers/iio/adc/ad4134.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 7d40c0521bb3..3c759b89d331 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -498,4 +498,3 @@ module_spi_driver(ad4134_driver);
>  MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD4134 SPI driver");
>  MODULE_LICENSE("GPL");
> -MODULE_IMPORT_NS("IIO_AD4134");

