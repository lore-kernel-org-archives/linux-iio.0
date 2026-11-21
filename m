Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288429;
	b=ZVxtCLcTD1osJA+vfVsfjOgA0xvEuXA5R46PgTyQq8wZJq3N3rA2mSiJpxQEGMfI56vT
	 NHCxa/KZded5t5WU75frTS6SQ87znb8tQfXyTxSbhaozIs4T0EvVfY8iLYrp4nhbU901N
	 bxErGtktb4j8c4bIs+hR5Zk3o3RYg6SiBxs9OvZ1KzGQ6Xs/Ajoj25ngsrq33ZyWtskch
	 tqPbePrkQ3voWghaAUagw/yUSmmzHmbYU5aGesZdwhP8dEjbXKob/lJ6+Xp26I9mcsnoE
	 vYsYIV703ozc9XB9VEEkG3Sh3AQ9N2+T38H3zj49fkmgJWE3Rwi2WQGuYwNzJCC+9Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288429;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8H6RdqY+TYjwos/2v0fo1/5eFR0WDL0iwmc+wYuW/Yg=;
	b=hWFwIAB/UNvNutPFp+4T93QmqBtEU1+w+bLHGnRc5AVAIJwygvfwC6t8Jba77iWY9UDA
	 wMsCVDcyrqRG29CjfTeoJCbPKjQLmZ5/jaReRp7DdJn2ok0S8T8V+DpuGSHLSWcp9IEBC
	 k2vC1SBSLSWLok3Wd6idvpS7nxCyvTaHz00lHeQMLDY2+9sm6QZr6qynzWPWv9k4/WVHo
	 zw2r0mxadD7OLf6qNks5OyMouZEjxfnegzwTB2VxUC+KZp4rUFGijMOll/0zXj//XaFUA
	 Ok3n1aqdWzmWCrrx+VlHYSsA9EmV9CLVisxf+N+YoVDrux9uZmFMyoRbrhD4561YDaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eh8f4a5J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896C606A337
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eh8f4a5J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798891F000C4;
	Sat, 21 Nov 2026 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288429;
	bh=8H6RdqY+TYjwos/2v0fo1/5eFR0WDL0iwmc+wYuW/Yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eh8f4a5Jrq5CPoOnUgHtQ61gle70ItXfN5TK965vuHnNlzClGLhuDx2N5hpHUbNUx
	 VlZPcfYEeHJ0eEnlfV9ViVJMYXVlOCstvtZOWnfGZIN8+VzS1/yKww8LF9RifkRTcG
	 cRYGxM9Bi8ynroGYt3sBVNg5deeiKKO8RGBRmkdmdgnEDCdKg6Y2xt/uJ1ntYX405A
	 bReHXy7Vy/qn+UY08OMp30ex/ASovOij46l/nbN9x4cDt9aTPnnpVb1/7Ndza73Rt7
	 ud5N9rRNHgA8cxz2ZpIO1W21bNWQLq+cbFhUjwBJWC7zbeosyHROZ9sZr067zvV129
	 81Lf+PzPv2tJw==
Date: Sat, 21 Nov 2026 19:13:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, andriy.shevchenko@intel.com, kapoorarnav43@gmail.com
Subject: Re: [PATCH v2] tools: iio: Prefer channel-specific scale and offset
 values
Message-ID: <20261121191333.1ccbacc9@jic23-hlaptop>
In-Reply-To: <20261121142417.1538-1-bhardwajhimanshu2515@gmail.com>
References: <20261121142417.1538-1-bhardwajhimanshu2515@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Nov 2026 19:54:16 +0530
Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com> wrote:

> iioutils_get_param_float() stops at the first directory entry matching
> either the channel-specific attribute or its generic counterpart. If
> the generic attribute is returned first, a more specific value is ignored.
> 
> For example, the MAX31855 driver exposes in_temp_scale as 250 and
> in_temp_ambient_scale as 62.5. Reading the ambient scale can therefore
> return 250, making the converted ambient temperature four times too
> large. The offset lookup uses the same helper.

I can't remember what the history of that was.  Under the ABI drivers
are not supposed to ever do this, but perhaps this is patching over
an ABI bug where we had the option to keep the incorrect value in place.

Anyhow, if we allow that both can exist (and they clearly do in practice)
this makes sense.

Given this is just a demo tool, I'll route this one the slow way.

Applied to the testing branch of iio.git, so on course for next merge window.

Thanks,

Jonathan


> 
> Continue searching after reading a generic attribute, and stop when the
> channel-specific attribute is found. Free the temporary filename before
> continuing to avoid leaking it when both attributes are present.
> 
> Reproduced with temporary attribute files containing the MAX31855 scale
> values and both directory enumeration orders. The fixed helper passes
> 14 parameter lookup tests, including generic fallback and malformed
> values. All three IIO tools build with -Wall -Werror.
> 
> Fixes: e58537ccce73 ("staging: iio: update example application.")
> Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
> ---
> v2:
> - Move the tool-assistance note below the --- line (Andy)
> - Collect Reviewed-by tags; no code change
> 
> Found, implemented and tested with assistance from OpenAI Codex;
> independently reviewed and re-tested with Anthropic Claude. No physical
> sensor hardware was used.
> 
>  tools/iio/iio_utils.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index e274a0d..5df2c76 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -265,7 +265,12 @@ int iioutils_get_param_float(float *output, const char *param_name,
>  				ret = errno ? -errno : -ENODATA;
>  
>  			fclose(sysfsfp);
> -			break;
> +			/* Prefer the channel-specific value over the generic one. */
> +			if (strcmp(builtname, ent->d_name) == 0)
> +				break;
> +
> +			free(filename);
> +			filename = NULL;
>  		}
>  error_free_filename:
>  	if (filename)
> 
> base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd

