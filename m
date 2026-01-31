Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1EB2253EE;
	Sat, 31 Jan 2026 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877704; cv=none; b=M+kxQn7EZG/zUN5iIckH/HoDz/gvMFbORlywffAjP6Quvd7/cxrusRpPjIgyTrzyBV8wBOkp5xv/GBkYPSnn7e4Zz/rYWC7RG3BvCpmP1XScQ5dDbRzPdDK4trvhIaL+Bo7nidR3BUbgWBZjLQzCiwIXHrGrm77/owaeYXWphGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877704; c=relaxed/simple;
	bh=5+NOOTSK7C4iDIzKzINy076cViWrqMKQTQd97jMCdmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCxAnB76uncoLbb3E4eIg+DqoiZwub4Pr5WZ0oA2BBv1v8m8ntsdXwPB5jweLIF4OPDKmBYhwkmu9zb5+pPjylbBVs/sDx6VU2yVuPAydCaMoeyxcQFFHR9s3FaDX0/pnTWt2NWXFFeUgNJKn9W2JA/lIgc7LjAvstMcf19O/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA2x136r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA2x136r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9D7C4CEF1;
	Sat, 31 Jan 2026 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769877704;
	bh=5+NOOTSK7C4iDIzKzINy076cViWrqMKQTQd97jMCdmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UA2x136rBklqKifcrOVMKuROYE46P0MraZB0nd18sOBa9RpOJCZdfCaW5EUKtMxCf
	 jQ53QxIAxsWxiLvCIbCxYstZXExdO67RC5M0nca+yaEaegqVCSEgffNCMGOayLU3RV
	 uxe4bbVnRQj5Qsb+8MZiDenxjSLc13JhdhffId0QNJdnKw20C2KlRvMMEy6r0dW1aJ
	 7+hyLa8cVXpMQPP/dKsIKofLE1qyZwjU0QXLJlaSvpZgyL8+s8V7LCo1Ds7jyFXFDi
	 KGIz6cPy0klcisrEjONkweh8ptBtts1XTGAU++ls4EEuV/qJgt/R5e/6MAK5ZKbGfv
	 4uog/AHWhoShw==
Date: Sat, 31 Jan 2026 16:41:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: mpu3050-i2c: use pm_runtime_resume_and_get()
Message-ID: <20260131164135.35f07a27@jic23-huawei>
In-Reply-To: <20260130153227.213413-1-antoniu.miclaus@analog.com>
References: <20260130153227.213413-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 17:32:26 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Use pm_runtime_resume_and_get() in bypass_select() and return its
> result directly. Unlike pm_runtime_get_sync(), it doesn't increment
> the refcount on failure.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Please always put a cover letter on anything with more than one patch.
Provides both a nice name for the series in patchwork etc and a 
single place to reply.

Are these fixes?  What is side effect of the wrong ref count?

> ---
>  drivers/iio/gyro/mpu3050-i2c.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
> index 092878f2c886..6549b22e643d 100644
> --- a/drivers/iio/gyro/mpu3050-i2c.c
> +++ b/drivers/iio/gyro/mpu3050-i2c.c
> @@ -19,8 +19,7 @@ static int mpu3050_i2c_bypass_select(struct i2c_mux_core *mux, u32 chan_id)
>  	struct mpu3050 *mpu3050 = i2c_mux_priv(mux);
>  
>  	/* Just power up the device, that is all that is needed */
> -	pm_runtime_get_sync(mpu3050->dev);
> -	return 0;
> +	return pm_runtime_resume_and_get(mpu3050->dev);
>  }
>  
>  static int mpu3050_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)

