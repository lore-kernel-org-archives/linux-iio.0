Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68823D3B3;
	Mon, 21 Sep 2026 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789949939; cv=none; b=IGPCOEoeqI8RQUput/+5rqO7q549eth0PEF2WYkMrqNjwjsN6iw0mC9aL8SxPCodCZKRLkaFngp38Xn08GyIIvn0rmG5KmEY161d4ulKzQ/CnRQKCQ3VN2XetYBKGGVw+TOODqcdpqM8f1a1cO/GcfWWIlLBHj331MmPw5pgM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789949939; c=relaxed/simple;
	bh=bTCkyx7gYIwwH2XQEptDRV0EKXsk0JHIHCfAyZ9pnhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRNInFzXubsMIvQ4+ns71yzd9woL5jkjS/IruqawaLNYd612P/evICedd0437+OrzZOOpahgI5UgFL0r7xBlrlm4+ZdXuLt2huEiz3AslIK75JXGFenM2852cZ60eBVUJdQntkmUshLKT4WPoQDuNrDzNs13Qy2HcEIID8cUF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzyIlKGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzyIlKGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529561F00893;
	Mon, 21 Sep 2026 00:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789949938;
	bh=pYjifRCpzas7A2q9taWb5XtUcgBE3zaYyp3xpNGct2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AzyIlKGS948QUvJQD47PT6Q8xIVq54PD0JZhrFOPRD9orjx0+GMuAAXruOLz2Kk5O
	 LWy5IlT2fue8tCLWhKPjS9C38HmqBFF/78B8WkZdChkbKbc9z4pGQpHsA4i+jFdBdI
	 9HoyfYMlTGxOk2Mp/7QP9t4HVqFHJdpEswP9bktS9QdyirZO03uxg/9S1/aUkrQxVW
	 t4tG5oA+WMP26BplzY8hEdtiZAE92KEX05KeSyhZejRgi2CB4hmOknEW6crLCvm/f3
	 IusLschtF0rz8MNgKY8rNm1FV93H+KD6Bs3+AzWjtJd+HS+0Zi0utOB0cZncSjRRVN
	 kQR0udFEhIUeQ==
Date: Mon, 21 Sep 2026 01:18:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux@analog.com>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7173: Fix digital filter
 configuration
Message-ID: <20260921011852.1325aed0@jic23-hlaptop>
In-Reply-To: <6de8050f5cc2b1632d7c72e4d290a484dbe53d31.1789577939.git.marcelo.schmitt@analog.com>
References: <6de8050f5cc2b1632d7c72e4d290a484dbe53d31.1789577939.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 14:01:34 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Filter enable and filter type selection masks were swapped on data
> preparation for filter configuration register write. Use the correct masks
> to set each property of post filter configuration.
> 
> Fixes: bb688cd9f772 ("iio: adc: ad7173: support changing filter type")
That's not a valid hash.  Fixed up whilst applying.

Applied to the fixes-togreg branch of iio.git.


> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/iio/adc/ad7173.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index eb47175a0528..faebb7b34a15 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -775,9 +775,9 @@ static int ad7173_load_config(struct ad7173_state *st,
>  
>  	return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
>  			       FIELD_PREP(AD7173_FILTER_SINC3_MAP, 0) |
> -			       FIELD_PREP(AD7173_FILTER_ENHFILT_MASK,
> -					  post_filter_enable) |
>  			       FIELD_PREP(AD7173_FILTER_ENHFILTEN,
> +					  post_filter_enable) |
> +			       FIELD_PREP(AD7173_FILTER_ENHFILT_MASK,
>  					  post_filter_select) |
>  			       FIELD_PREP(AD7173_FILTER_ORDER, 0) |
>  			       FIELD_PREP(AD7173_FILTER_ODR_MASK,
> 
> base-commit: 9c464e7473f762cee4c031a09da04f65a1c65d49

