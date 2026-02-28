Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7F22B8C5;
	Sat, 28 Feb 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772280206; cv=none; b=fnx+0/Vl6iNSjydwZVnSrpy++do3buhxEQFyprtT1fds0UE6ILstxHeWsxBlkxpg8lKvwVAoWpaNjqgolZsqFUT5eguJ942InTa19p5Ed3w1gMyuOBZbM/nZLdMshr3U0YzAIBrGTK2eyCyqfRgeANnnOClV2LGUVXvUVc0EoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772280206; c=relaxed/simple;
	bh=2i4e1KGk2Jvnc/r5Ua5Oqh5uBaSYPkRHfsFpnQIf9hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQrEy1nh9Klxer6/496b/PLFoVjPs5Eleo4KIZ27xcXeLVEfls7oEE/LnSK7JFm4WdlVJiGp4KqeLzT8yBlNbED5WcSCTecY097mQxvg1qcTp/KLNyUt0kYeIq8ogtDV092Enf8iLL4hfD3AHyPbORBJHHprdG34tOjmgo+5F78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtHEh15C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtHEh15C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4CAC116D0;
	Sat, 28 Feb 2026 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772280206;
	bh=2i4e1KGk2Jvnc/r5Ua5Oqh5uBaSYPkRHfsFpnQIf9hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QtHEh15C1LVH/fdBPENeG/T2kX56nfcTAof2shJs7bWYVzFjuRzIgfViX7RdffE1/
	 qMmxuukCNDFqB18M8/1gYevKd1IQvHROgZXYULnhLiRq86VAJfa7NQQ+Ktm332uPl+
	 LTB9SNoRLfPFJsMS+FPgFy2caIc6Wer8qtPqOmj9XgCubWpSJEidaEErxaigOOn85U
	 o5y/7Mtxm5Q1v0ApKKOuYu3qQ1AS6+2cYpht/r9FegQEz8TdePBN7dAZvYTO5c719W
	 dc6AdNPVu2VzPTBlqLCn6HaDxQ4KghmTdahGyMoWyfRaDRPi7VrgV44j0NMvEwinxj
	 NDyPXjWASqQkg==
Date: Sat, 28 Feb 2026 12:03:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl380: fix FIFO watermark bit 8 always
 written as 0
Message-ID: <20260228120317.4fc18024@jic23-huawei>
In-Reply-To: <20260227124305.55271-1-antoniu.miclaus@analog.com>
References: <20260227124305.55271-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 14:43:05 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> FIELD_PREP(BIT(0), fifo_samples & BIT(8)) produces either 0 or 256,
> and since FIELD_PREP masks to bit 0, 256 & 1 evaluates to 0. Use !!
> to convert the result to a proper 0-or-1 value.
> 
> Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl380.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 8fab2fdbe147..a51d1d61c412 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -877,7 +877,7 @@ static int adxl380_set_fifo_samples(struct adxl380_state *st)
>  	ret = regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0_REG,
>  				 ADXL380_FIFO_SAMPLES_8_MSK,
>  				 FIELD_PREP(ADXL380_FIFO_SAMPLES_8_MSK,
> -					    (fifo_samples & BIT(8))));
> +					    !!(fifo_samples & BIT(8))));
>  	if (ret)
>  		return ret;
>  

