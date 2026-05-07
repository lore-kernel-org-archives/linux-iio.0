Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A01A316E;
	Thu,  7 May 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170747; cv=none; b=NaFkjsB+5XSP6sfH5gKDCRKLNHq0k03Tpovfh9VbPqK2Zmenpq0rLRL0aryGVC3U+eT+TVrBMc+erfimI+4fms0xKnZCz42F0WmyNwCAPvsmeoqOydwwpWnNw+br2SuYFVrmq4FpXqryxzqS8pcm51VtLbvh510ww9OC5wMGk+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170747; c=relaxed/simple;
	bh=oYhTygtEH2rwLPCNzNn1MTNOQz4oc/UF7GDdi0gFwvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8miSh7e01PKNG+fkkot4gAJoI96PW+T1qsNosRIZJZo6kHGiiKT98ghJhgr92EBLblXqtfzaFLUSekc/q7eDQVMydW1XCMPoW4C+Tffd1l9ntiRP2uNiCGQ7KMfaufWTKU1Qdi1qaLT4A8B2arim/lg3HAorgmK7M+BFHQu8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INZW4N97; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INZW4N97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDFCC2BCB2;
	Thu,  7 May 2026 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170746;
	bh=oYhTygtEH2rwLPCNzNn1MTNOQz4oc/UF7GDdi0gFwvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=INZW4N97O83uZJ63llk5EHXWeSr/CtxuLFBbSBRjNnBXnq0LKbSzhFZoN0GDFHeIQ
	 XIHE/Xa6QNl7/XZpnjsRTya/B+37MEO7yfv+UlFQRNpcAOq/xiv6A6q1DNQocNm/h/
	 RNEsokomRSu5PY+bQ1jkMvIgI/Dw2GfxkyqPkZOSKBYNWNuLtZrrTipNY+M7MlzAOp
	 itRODcnWLELTk8kMyhaUzBrBFBOVlv+ZtlKjDHrmzccZHQK9U+9UmtDvFBWIudnrrT
	 vSG5DMNgYNSfu0orH99aCTOtOghNlke8j9n6T2qzmSdwRd6xKlAUu/dmNnP214ZZg0
	 9VZuy8P+NkBpw==
Date: Thu, 7 May 2026 17:18:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: tomasz.duszynski@octakon.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: scd30: avoid potential NULL deref in
 scd30_i2c_command()
Message-ID: <20260507171858.7a835306@jic23-huawei>
In-Reply-To: <20260506181533.409-1-sozdayvek@gmail.com>
References: <20260506181533.409-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 23:15:33 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> scd30_i2c_command() takes an opaque "response" buffer plus its size.
> At the start of the function the code already checks if response is
> NULL (via the rsp local), but the response-decoding loop after the
> i2c transfer always dereferences rsp without re-checking.
> 
> With the current callers in scd30_core.c this is harmless, since
> write commands pass response=NULL together with size=0 (so the loop
> body is never entered). However, the inconsistency is an accident
> waiting to happen if a future caller passes response=NULL together
> with size > 0 -- the loop would then write through a NULL pointer.
> 
> smatch flags this:
> 
>   drivers/iio/chemical/scd30_i2c.c:104 scd30_i2c_command() error: we
>     previously assumed rsp could be null (see line 77)
> 
> Bail out early when rsp is NULL so the function is robust regardless
> of the (cmd, size) combination chosen by the caller.
> 
> No functional change for the existing callers.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Hi Stephan

Thanks for the analysis - as you say no actual bug here but good
to make that more obvious to static analzers.

If we ever did hit this I think it would be better to return an
error code.  I'd also do it at the top given such a combination doesn't
make sense so we should exclude it early.

if (!response && size != 0)
	return -EINVAL;


> ---
>  drivers/iio/chemical/scd30_i2c.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
> index 436df9c61..fb06bec75 100644
> --- a/drivers/iio/chemical/scd30_i2c.c
> +++ b/drivers/iio/chemical/scd30_i2c.c
> @@ -93,6 +93,9 @@ static int scd30_i2c_command(struct scd30_state *state, enum scd30_cmd cmd, u16
>  	if (ret)
>  		return ret;
>  
> +	if (!rsp)
> +		return 0;
> +
>  	/* validate received data and strip off crc bytes */
>  	for (i = 0; i < size; i += 3) {
>  		crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);

