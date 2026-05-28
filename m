Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4EF3AF666
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961626; cv=none; b=hl/KNx0YHJzF+ejy3eNz2zRKylE7oAHVCt7h6bO++ZurGgKw8ebE6gwCFUuh/8W5VYkU47fQ5US44gC3/aA264KtzKzNRYYIVtrVzbmAJpwrZUs9DETiKHalU4NDVGs09uxBnlgAd1Mlf9bhCyNhsTjNjZ1PjjJquGjAG+bY+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961626; c=relaxed/simple;
	bh=WxcFhngft8c8ireqPIArr1ONijQXtbUhoOqt9c7lRfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPe/pwAmmIX6VyDoJrN0z12CuT4NIBKCJBGGKcQip4GjR+li3VuMTAceTG6L27fpbCm42iV/P8qVMh2WgmCT1FTy/HFokaVGuDSVdaMfm43ikO5wCF7NPyJbTojrxMyShX3+Iooxh8vojFnQJXrcvFdFOG29d9kwTFOmB6YNpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqV5beF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqV5beF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2BF1F000E9;
	Thu, 28 May 2026 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779961624;
	bh=C8/aGRTaJKmgxLx4M7XVJ77D+vbmBy7raMS79z1q1Sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QqV5beF5oxOwCJ58jfVmS/eID9VBZadw1Yb2ikKDIqYoWuDkFJtpz0tv5tlsRktRF
	 ZvIhR26/nkjWJSVZbI/evDLhj0MgSYUfQYnmO8sWvQTJmFIUCxZVFxPfscqz1qTzfE
	 NavlKF3n6vPEuCIlNIsZS23UvWoPjvkDBnIeBM5rScyeDzp9+xqfabA5+dFvl7FnQM
	 4L5jfgojK4Ql8pcmAj0X1KfRCv90g37QkfMavAi3bkTNSTITBunB7jRmGz3UC7TnKg
	 datT0U5cjjtMSXD/+ZA3ol8JK99H3orliMjQ+efm3muLPuyTKFySnn7Hc+3xZ4AX3W
	 5fQO2DVNKX56A==
Date: Thu, 28 May 2026 10:46:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH 3/4] update adc Kconfig with ads1110
Message-ID: <20260528104657.7d5cd7e8@jic23-huawei>
In-Reply-To: <20260527164312.355729-3-jakubszczudlo40@gmail.com>
References: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
	<20260527164312.355729-3-jakubszczudlo40@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 18:43:11 +0200
Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:

Hi Jacub,

Welcome to IIO.

See how other drivers are done. Kconfig and Make files need
to be in the patches that introduce the first code for which
they are controlling the build.

Thanks,

Jonathan


> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  drivers/iio/adc/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a9dedbb8eb46..3f2bbfb24daf 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1756,6 +1756,16 @@ config TI_ADS1100
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1100.
>  
> +config TI_ADS1110
> +	tristate "Texas Instruments ADS1110"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Texas Instruments ADS1110
> +	  ADC chip.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads1110.
> +
>  config TI_ADS1119
>         tristate "Texas Instruments ADS1119 ADC"
>         depends on I2C

