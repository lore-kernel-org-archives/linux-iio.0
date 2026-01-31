Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4D337B9D;
	Sat, 31 Jan 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879295; cv=none; b=uilP72fAVpkezsSi4m7RR2BXsU1IxXy+L3RzDBmA3lRyfwVXE85AEIp0zM3v4I8I3mOZm/fOF8urTxm7Mh3i5GRkYcFgsjJt37KZLwzLo8wpe8vhvbf/ftE9A7A05lnPDjzcN70ohNIyTKf9gBdPwiXSjoiZF7tSU1gXJcBI5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879295; c=relaxed/simple;
	bh=TvzEHX/5j6unP+CqymD6CcBHyV8EzGx4bDP7/EZCfkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZHPivER2RkiPQ+tOq9CP+4gmKpL2b2whJmYVMtLosaxjG4cZJKcBRkyN0wm9C8JUqBWtmTvhzQzrZKbGkqkyRHVXY8Y6n0nSiNIaxPaOdLtZWcU4+o0yDuJvbcLnCBKiXUnbM4l+MxalM7zIOan9c8bFNW3HSyVIbs2+Cv3Q8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuB3rkJY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuB3rkJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB14EC4CEF1;
	Sat, 31 Jan 2026 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769879294;
	bh=TvzEHX/5j6unP+CqymD6CcBHyV8EzGx4bDP7/EZCfkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QuB3rkJYCMqrRuFIO/P7r2eykMlQBWpaEZOWZd6FDUXzRuzO8yhhHuQ1vt4cG/0An
	 vysHnrKI3HWuVBz8bWGKdSSjPWKgMAvC6FlYV6OeZX5rjZa7igUcX2jXCez0YM2WyK
	 ObvLUyA0A/vNzD7erQVKFPhNvw77hiyuCjo26d27J3z3p6X6PbQnH3V2n6i+sY6KMb
	 1BBatMdq3JnkpEnP2fRdhXCXzeH81hJbTs5Jmy2fPIEP6Hu03uNUo3ut3exJmBl6Pe
	 SN9tHrY9MCHD5DUJD6TFIP1raYS5MkdXoaDdv2YpIWHhtbJQOU8U2V30tFiO8Idetg
	 U8yYka3qL23wA==
Date: Sat, 31 Jan 2026 17:08:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: frequency: admv4420: return proper error code from
 admv4420_calc_parameters()
Message-ID: <20260131170806.6fde32a0@jic23-huawei>
In-Reply-To: <20260130135005.136363-1-antoniu.miclaus@analog.com>
References: <20260130135005.136363-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 15:50:05 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Return -EINVAL instead of -1 when no valid PLL parameters solution is
> found. Using standard kernel error codes ensures consistency and proper
> error propagation through the call chain.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied to a local branch. I'll need to rebase on something sensible after
the merge window. For now I'll push out as testing.

Thanks

Jonathan

> ---
>  drivers/iio/frequency/admv4420.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
> index 3ae462b4f5c9..8748d9747639 100644
> --- a/drivers/iio/frequency/admv4420.c
> +++ b/drivers/iio/frequency/admv4420.c
> @@ -243,7 +243,7 @@ static int admv4420_calc_parameters(struct admv4420_state *st)
>  		st->n_counter.n_counter = 1;
>  	}
>  	if (!sol_found)
> -		return -1;
> +		return -EINVAL;
>  
>  	st->n_counter.int_val = div_u64_rem(st->n_counter.n_counter, 10, &st->n_counter.frac_val);
>  	st->n_counter.mod_val = 10;

