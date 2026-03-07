Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD42253340;
	Sat,  7 Mar 2026 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903838; cv=none; b=CfJdgO7zYNZ+5gaFE4RvhSNdkfQSqdj28KBGz6pHm3ZXSFUFp305X108RiUvHQ4mw+1rA+avXA0TrO8Ldb7f18U/z2q/UvX3nD4+S/BK7zwEdGUYNDrDscNeSlQkTXeNDHS0dGjbj5RC7BACTuqXxeR0phKRliSg6L+ctEg6jUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903838; c=relaxed/simple;
	bh=Ng60Nmsrl46XiuwVJCXG/RGYiZXrQdGUSPx/t+Mouyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lE0Vvonua5g8L3RiX9/r/cMKRr83O53lpxt2XkCaR1TH4AOE6NFagg9B7K6QOcBdIoroyHp2KnynadxndAC52IH+r/QjhYsOqOEZLhI8yZtxnBJr2gRaIvOFgurnwr13cfGwJV7n84drJaZXKAsAjiOYyOmeu4JR7z0VYiTbRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIBzPhr4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIBzPhr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B870C19422;
	Sat,  7 Mar 2026 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772903838;
	bh=Ng60Nmsrl46XiuwVJCXG/RGYiZXrQdGUSPx/t+Mouyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vIBzPhr4dIY8YEWXO0/8SJ3ik93P5qADtuSZ1fE3sjf0pMrJY/Cbpum0h2LxlpPDj
	 Q432pe+XemhhYwq7jPauA4qRGfHSyMVORRDGYGoFmHwYW5ikJzrhGtZDBOw4AouqN+
	 OK9QBtaiQ4+PtG2wWVb9DNTuijmBnwZIjgXVNPmF/Ls95PuGFkrIHmORAbSTlMaOqC
	 PAv2Wx/oz258NcERccQyEW361k8b1kIFptihmtVKe8Vz+/cuAQXvPiQb4uv7Mq6YVg
	 K3VPhO9Jk+7nEcizPpyFP6gHr+LsBeH/H4pWPwWYgysUGsKZWRR18XC5DVS0pJmb1o
	 TyT66fDKbfjbg==
Date: Sat, 7 Mar 2026 17:17:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: palmas_gpadc: Fix leading space indentation
Message-ID: <20260307171710.2aa24c55@jic23-huawei>
In-Reply-To: <20260307130213.174010-2-giorgitchankvetadze1997@gmail.com>
References: <20260307130213.174010-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 17:02:14 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> Fix lines starting with spaces instead of tabs to comply with the
> kernel coding style.
> 
> No functional change.
> 
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Huh. I wonder why I never got bot warnings on this?

Thanks for fixing it. I applied but changed the patch title a little
to remove the word fix as that tends to make people thing it needs a backport.

Applied to the testing branch of iio.git.

Jonathan

> ---
>  drivers/iio/adc/palmas_gpadc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 3f433064618e..f9995e28b10f 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -521,16 +521,16 @@ static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *adc,
>  
>  	val = (val * 1000) / adc->adc_info[adc_chan].gain;
>  
> -        if (adc->adc_info[adc_chan].is_uncalibrated) {
> +	if (adc->adc_info[adc_chan].is_uncalibrated) {
>  		/* 2% worse */
>  		min_gain_error -= 20;
>  		min_offset_error = -36;
> -        } else {
> +	} else {
>  		val = (val * adc->adc_info[adc_chan].gain_error -
>  		       adc->adc_info[adc_chan].offset) /
>  			1000;
>  		min_offset_error = -2;
> -        }
> +	}
>  
>  	return palmas_gpadc_threshold_with_tolerance(val,
>  						     min_INL,

