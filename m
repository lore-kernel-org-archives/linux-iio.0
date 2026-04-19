Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C59288C30;
	Sun, 19 Apr 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617532; cv=none; b=jIfRle0psTJTARgk/PJt+3cmO8C8rHvJeKgyLF4rK1/CxbfjJq4O7XtY8fOEQ6/w31ZwYolAeoLuNT6Bc3dNrSCfT9oE4h78mjgNwoqhYj/HoNNc9qhOnRC1LxB7uS4CD1VH9TLlCDKysNMBeaeAwtnuuid0W1Iy8FXfqe1mxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617532; c=relaxed/simple;
	bh=/Y5PgksujCVb7dB09bs82ZLlUXcOxxsz8aKpNRAhD8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYkgyWfSvcqs5ogvvhS/h/1+LdExYU3Q/OPvapnWIyuQYY8Ns81yaB356BJV4UjVDI/+GCCV0gaugjYPyWLN/nTQjmJrYxN5UUSNmvXIYRI71WvnpxTkl4yzOFwhYYkz57s473wL531fDMAVR2ZwQWJEZvU1XQlWaKPib9fZUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efUPMOyt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efUPMOyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA79C2BCAF;
	Sun, 19 Apr 2026 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776617532;
	bh=/Y5PgksujCVb7dB09bs82ZLlUXcOxxsz8aKpNRAhD8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=efUPMOytd0CgVQbBt2FC4PEOd6Kl7kXk9fK1qlrBTNafJRIhaKAHozIsLmWUnjR8y
	 eah90hzD7tkJR84OPms/KLpO07Q/Ypa0NqDEcD3Jmfu05+43CpnKyp+xDN/6xKLjYQ
	 Rhv4xyxtprO6wsfissuvjHs+W8uX0M7juTJIdrR1zvLI7xcpT25/n2K5cNwZfI2S0u
	 9Dp39jgOeAA4gtLIjlXsvTaPSi0eSRIg2ceXweTYFvYNs0MdTiqGMgYlXxFxrl1kMe
	 MTePiOq/Gvy3Mk6oowrMn3bi1pTTw2cZX4dVWjMpXnUyWgtRVLXVVUYFXwXscTWqjO
	 PqEqKNSfnlkfw==
Date: Sun, 19 Apr 2026 17:52:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6 2/2] iio: frequency: ad9832: simplify bitwise math
Message-ID: <20260419175202.7f0cec54@jic23-huawei>
In-Reply-To: <20260417101623.1281-3-joshua.crofts1@gmail.com>
References: <20260417101623.1281-1-joshua.crofts1@gmail.com>
	<20260417101623.1281-3-joshua.crofts1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Apr 2026 10:16:23 +0000
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Refactor the ad9832_calc_freqreg by adding a BIT_ULL() macro instead of
> manual bit shifting for better readability.
>=20
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio=
/frequency/ad9832.c
> index c0b7852f1c..6ce9651542 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -117,8 +117,8 @@ struct ad9832_state {
> =20
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned lo=
ng fout)
>  {
> -	unsigned long long freqreg =3D (u64)fout *
> -				     (u64)((u64)1L << AD9832_FREQ_BITS);
> +	u64 freqreg =3D (u64)fout * BIT_ULL(AD9832_FREQ_BITS);
https://sashiko.dev/#/patchset/20260417101623.1281-1-joshua.crofts1%40gmail=
.com

So does this actually improve readability?  Sashiko had fun with this one a=
nd
I'm somewhat inclined to agree with it.  The suggestion it made was that
the following was more readable still and avoided oddity of using BIT_ULL as
a multiplier.
=09
	u64 freqreg =3D (u64)fout << AD9832_FREQ_BITS;

> +
>  	do_div(freqreg, mclk);
>  	return freqreg;
>  }

