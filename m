Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D8312834;
	Mon, 17 Aug 2026 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931647; cv=none; b=DEkxTrmD7zkNX+zl+Croegws4kVgjOY0Dxo5czTeXQR+djlJVwlexCuJ7+/etViT+/jTkkX/3GtjXRyDaCAHw1l30Uh2bWNOWonMFnbGWQYgBJGOJmOD2r8IJCKXz3jQSbdXUOzhn30hD4GzKT+ItnWfIQ4apx2yVFaCzvJ0IV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931647; c=relaxed/simple;
	bh=9rQjjwu8BhI02hLpyriasZdWC/mK9TSdP1HPCflK8N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APDZU14rf/a0fqjIaFXrqjj9XGq21c9zV3NElF7/qQTd8z7CiHRZSo/94pMAwk2xWE6uRQ3syDVeFEZBWGcz7+FvMiZDM7FZ2tErvpsaUDOKer07lvU5SBsbNaDwGavQ+F6qlcv4L3nM2uabRCbFMBldYGJ0d9m4u1cxzjoZtNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo7AiTPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo7AiTPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEEB1F000E9;
	Mon, 17 Aug 2026 01:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786931645;
	bh=yCUvB3oDO0KgD4iM7dlexzunbiu74IbvlhuFHUYBDao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lo7AiTPqURQIXVfxkK/eb2dRSgDe42gI0BZBZKAvNNEuVgjzsgx/GL23tEFpV8dYk
	 YqsY0EjTEkBOndZoYIIj3PSHv20QYdw2MlyPg/O4aL/IzH7HxU/+i8kH2voynmvEE7
	 JD5sxmuSjFQclmnE62J4zyLYZpN1otUfgvmCnCFjY+FMy6Bss5jsTYWT6SiLPMeZSI
	 RPjq6hQm3uo6G44DLOgDzTkm8Qra0eDHNm8nCRAu4OO/7shdMmiHPYUSuP28XQ1HuE
	 LnH+6NsFWbfhSPDYYVp1IqRreRlH6HSFU7BzFJevBnVNy67jJ1NVdhkaTcTni+ltms
	 TpTUpynH6WqYA==
Date: Mon, 17 Aug 2026 02:54:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>,
 0012-iio-accel-kx022a-Fix-IPOL-macro-name.patch@mva-rohm, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Mehdi Djait <mehdi.djait.k@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Kalle Niemi
 <kaleposti@gmail.com>, Topi =?UTF-8?B?U29ua2Fqw6Rydmk=?=
 <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 12/12] iio: accel: kionix-kx022a: Fix IPOL macro name
Message-ID: <20260817025351.5d3baf14@jic23-huawei>
In-Reply-To: <c26c2741ca11adf7a089c094d8648f4ec6cbab54.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<c26c2741ca11adf7a089c094d8648f4ec6cbab54.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:55:25 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The "interrupt polarity high" -macro for KX022A variant is defined as:
> However, the KX022A_MASK_IPOL1 is not defined anywhere, so actually
> using the KX022A_IPOL_HIGH would produce a compile error.
> 
> Fix the define by using correct mask.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> 
> ---
> It appears the KX022A_IPOL_HIGH is unused as the IRQ is currently,
> unconditionally set level low in kx022a_prepare_irq_pin(). The KX022A
> hardware would support other configurations though. So, another
> potential fix would be removing the define altogether. I decided to
> leave the define there, as having it will allow users who need different
> configuration to simply change the KX022A_IPOL_LOW to KX022A_IPOL_HIGH,
> which is kind of a "easy to try" thing.

Handling interrupt polarity options at the device end is typically a
'feature' rather than a must have given in most cases we don't have sharing
going on and these days interrupt controllers can cope with most types
of input.  If anyone needs it they can propose support.

Note I've never been happy with how we do this when we do support it
because the argument for letting DT set the polarity is there may be
not gates or similar in the path so the driver can't know, yet if we
read the type to set the polarity at the driver end we are saying we
do know there aren't any such not gate (trick for level shifting on
the cheap). I haven't figured out a better binding.

Jonathan


> 
> I don't have a strong preference here though.
> ---
>  drivers/iio/accel/kionix-kx022a.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 0ed54f584223..a2d122c1e234 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -65,7 +65,7 @@
>  #define KX022A_MASK_IEN		BIT(5)
>  #define KX022A_MASK_IPOL	BIT(4)
>  #define KX022A_IPOL_LOW		0
> -#define KX022A_IPOL_HIGH	KX022A_MASK_IPOL1
> +#define KX022A_IPOL_HIGH	KX022A_MASK_IPOL
>  #define KX022A_MASK_ITYP	BIT(3)
>  #define KX022A_ITYP_PULSE	KX022A_MASK_ITYP
>  #define KX022A_ITYP_LEVEL	0

