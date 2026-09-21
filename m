Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAF136351;
	Mon, 21 Sep 2026 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961556; cv=none; b=UObM7FsaQfwwBotq6VuCNW4prdex35S4g41GuBEOAisUlDsPbWMbwlguZJlOC7tcYANycH0fhx1z/EmIhNWuEtDwAbvRpxZXYzXYYPBcoR/Xlw8nr5+DDwB0XrsyiESlXOom2OALPQJtqFQmG7vPPxBKMdIQfTKVHnoueS2VJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961556; c=relaxed/simple;
	bh=Hs3MuyE9q8Kyhlfn2uz2PYd4Z2IIHBp2fA7Y6zJwTMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/rn5/NRpDBsqcDjaaLIL9AQY7q+JccH6luPVFDnzGMLdmv38PKy6BFM5O3cXNxdmhow/41ovSpbXNdkoCCvov+YbscFkOYnb5DfvU4lgJorEA8bstmSq0yYMddpPuUc1VZcxCsPZvWgwebptGi6Hp/eET8drgjKvrQides05W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYGaIsWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYGaIsWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0B81F000FF;
	Mon, 21 Sep 2026 03:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789961554;
	bh=YhL9rfq4BhEnSaUnz77Iq+bsQ+QAOVxiG/yeddhB5AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TYGaIsWumF3G+taNu5LMJGqevlhv9IOGmeTAIBEdowaJrEiEfq74snTwb1X4/9OS/
	 XeRii62gkWqkrcFg5jOElc4PbnBaoxbXSDf6Ke0Fnk6InK+YTGhuml4mJeO2G3j+LJ
	 2SWLo05xzY7QX/t7h4HJ3hEt05l1ULq0H1EpzGNHyEgQXlBBtdIMKk8o5tvr4tk1Q/
	 kEYoN4Y1Lo2VDNHu3D9urFud29Kl/BiKon3g4Ghd43oyI8k6ujNt3WFpZhVXxxm/EZ
	 saZW2h6RLWIfP8Vr0HK4uqEqujsrN5wjlRVyee162ZR/TD+CVQNm+W4Ky40UG1ihwP
	 +tjMChD80fjUw==
Date: Mon, 21 Sep 2026 04:32:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org>
Cc: cdcp206@gmail.com, Matti Vaittinen <mazziesaccount@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kx022a: fix typo in comment
Message-ID: <20260921043230.7060b680@jic23-hlaptop>
In-Reply-To: <20260920-iio-kx022a-fix-comment-typo-v1-1-9fc233272712@gmail.com>
References: <20260920-iio-kx022a-fix-comment-typo-v1-1-9fc233272712@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 20:06:45 -0500
Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org> wrote:

> From: Carlos Casadiego <cdcp206@gmail.com>
> 
> Fix "usng" to "using" in a comment.
> 
> Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>
Applied.
Thanks,

Jonathan

> ---
>  drivers/iio/accel/kionix-kx022a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 8f2810c8ffeb..a3d80e4e7f1e 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -809,7 +809,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>  		 * the timestamps. If we are ran from IRQ, then the
>  		 * IRQF_ONESHOT has us covered - but if we are ran by the
>  		 * user-space read we need to disable the IRQ to be on a safe
> -		 * side. We do this usng synchronous disable so that if the
> +		 * side. We do this using synchronous disable so that if the
>  		 * IRQ thread is being ran on other CPU we wait for it to be
>  		 * finished.
>  		 */
> 
> ---
> base-commit: 61718ed183599e5162496b5306c3377a925d21cd
> change-id: 20260920-iio-kx022a-fix-comment-typo-c1d1ce27472f
> 
> Best regards,
> --  
> Carlos Casadiego <cdcp206@gmail.com>
> 
> 

