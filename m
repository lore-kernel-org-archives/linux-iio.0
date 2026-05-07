Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226082C3261;
	Thu,  7 May 2026 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171403; cv=none; b=gr4vjJ3RwWo9X8OPSCxpm+0gzkqMgloPRhejJDgXlxhucq4i1bjgN4rfuSFeEInCP57WUXdeh0AoIXb81LHN0hwbqkRPcoYavRTgIgrTGW3eVq9oyhJ8U7YI8GSeTEVF35tigDcneg4e+kmIbHLQ1gpGs5saSN7nqJMj4hoOVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171403; c=relaxed/simple;
	bh=hYJD4Rl2UF7bWkKsOCVtaNIXK7OpgHEcSz+WPJ92etc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbNMMODgGnKdYVs07r7iQgdRZKX2xbBC+ghOr1GMK9IYj8QbXpm/M1E1zG+4IY/Gl4XpdW6gL59O1dqZw672nLp0o3ontCIPLshrpI6H9MD03dxsEW1G84ytkT90Z5PRL7HqYhDRdmy+khsIpFimpUe41vHYdo8lOx37ayeJeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJSSAB8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJSSAB8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA810C2BCB2;
	Thu,  7 May 2026 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778171402;
	bh=hYJD4Rl2UF7bWkKsOCVtaNIXK7OpgHEcSz+WPJ92etc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cJSSAB8RulSVpL9QCXsVxSqV/lT1Dpr3HZKnpZ4Qu7H7kiDIRkcEo//2MlKds3Eo1
	 +GZB31O587SwPnh3Gr7TZSyY8Sqh1pGxv0mHe0DNGMpj1XeGUFilFXIUF5yZRah6u2
	 /gFjLe1PY2Vx7wzI5xCBljHvPEkOtjYlep34fL769O/2m9cBl0MkHpEtup125MIyWB
	 dMSnj8CV3sj1rareIahRSYilYiu5Hu1Qb/YWGB1xVJtMfQu3B+474iIj23u5ASv2C1
	 NSmFDOVOt6rNa9jnAe5rnBbO9q46zZ0KF0PtFM6AdMaQZ0SIsc9Eo3XvLI7VBA5dx+
	 Hz70X6Fi6qFpQ==
Date: Thu, 7 May 2026 17:29:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 2/3] iio: adc: ti-ads1298: Fix incorrect timeout
 comment
Message-ID: <20260507172954.4e36f306@jic23-huawei>
In-Reply-To: <20260507105129.25639-3-shofiqtest@gmail.com>
References: <20260507105129.25639-1-shofiqtest@gmail.com>
	<20260507105129.25639-3-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 13:51:27 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> At the lowest supported data rate of 250Hz, one conversion period is
> 4ms, not 40ms. Fix the comment to correctly reflect the timing.
> The 50ms timeout value itself is correct as a conservative margin.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
I'm confused - why didn't you make the change Mike requested on v1?

Fine to argue against it but you need to reply to his review.
Perhaps it went missing.

J
> ---
>  drivers/iio/adc/ti-ads1298.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index cf5f954206..186bda3087 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -210,7 +210,7 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
>  		return ret;
>  	}
>  
> -	/* Cannot take longer than 40ms (250Hz) */
> +	/* Cannot take longer than 4ms at the lowest rate (250Hz) */
>  	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
>  	if (!ret)
>  		return -ETIMEDOUT;

