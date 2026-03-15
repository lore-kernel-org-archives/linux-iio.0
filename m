Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B7434D903
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577805; cv=none; b=CYdRrCTNQrty0jXnPzHMStUe7ZBIWO5h6JZvb5QdFZqM+uYvcehHVN089m37F9pAIK/Z3IXIvV+jNSJNzjEag8x8k83zVUQH8DY25CZ2AuAYQO2zr3UOZoWdtvKuNK6tMIPfBvSU0UTkxzZMD8KK5q+H5qu2N/GdS1pplxxZfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577805; c=relaxed/simple;
	bh=EwnCOf46mN3COISjD8XAj/Au2p5ZQrfSmYKRVrffpk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPC8L990eRRuosYBfT5fY0MOjQFNCpd/WjVGyEdFtLq8LwLXmm0RaU2yTAjFycVbSf8UPN2+K2WuHSTNCh1BiHyQGkQdp2S/lK08G1GNce80KufIteKa418EpCMu2gntJe7SzrwJLES3m8ebr0jZRgRWQzzb6Wwf98zjz3w7R1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THaTrVnG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THaTrVnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5C1C4CEF7;
	Sun, 15 Mar 2026 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773577805;
	bh=EwnCOf46mN3COISjD8XAj/Au2p5ZQrfSmYKRVrffpk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=THaTrVnGvkXUOeg1wGumYti7Kp7hS+9Q9V6QHrCTHDY3qewPoOvpCK254vRCvaHhS
	 3B96UUFV78fT6+QU6QpRg2bur3K1ZIWiijJ3FBc3VeQP8ZcDxbtyJV6EzwZzsLOovt
	 JvVLkuqr588NQm2RW76b9CpdTx7JtLUopVt0eGk23QSdDugDhH7YA7yqib8+EUNYb2
	 3RbL+YlzRQcVNE6p3GSkmjRcIOCw4rFLm8O9YuTzJh+UltdypQ/5RM185pKMzvqPoF
	 +5vvsyT6Z4caUcfIEJ3st/ep3KVKA7jMVEm1qk03XgBx1gcCt6Wz86UABrF5m44oIC
	 C51SzEyQtaoSA==
Date: Sun, 15 Mar 2026 12:29:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mt6359-auxadc: Fix comma spacing
Message-ID: <20260315122958.5c95485a@jic23-huawei>
In-Reply-To: <20260310143809.83126-2-giorgitchankvetadze1997@gmail.com>
References: <20260310143809.83126-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 18:38:10 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> Fix incorrect whitespace around comma on line 325 to comply with
> kernel coding style. This silences checkpatch errors "ERROR: space
> prohibited before that ','" and "ERROR: space required after that ','".
> No functional change.
> 
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Applied.
Thanks.
> ---
>  drivers/iio/adc/mt6359-auxadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
> index f426a289e867..6b9ed9b1fde2 100644
> --- a/drivers/iio/adc/mt6359-auxadc.c
> +++ b/drivers/iio/adc/mt6359-auxadc.c
> @@ -322,7 +322,7 @@ static const struct mtk_pmic_auxadc_chan mt6359_auxadc_ch_desc[] = {
>  	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP1, 15, 128, 7, 2),
>  	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, PMIC_AUXADC_IMP1, 15, 8, 5, 2),
>  	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, PMIC_AUXADC_IMP1, 15, 8, 1, 1),
> -	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, PMIC_AUXADC_IMP1, 15 ,8, 1, 1),
> +	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, PMIC_AUXADC_IMP1, 15, 8, 1, 1),
>  	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, PMIC_AUXADC_IMP1, 15, 8, 3, 2),
>  	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, PMIC_AUXADC_IMP1, 15, 128, 1, 1),
>  	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, PMIC_AUXADC_IMP1, 15, 256, 1, 1),

