Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6828504F;
	Sun, 12 Apr 2026 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020537; cv=none; b=DficFnbG+fMFkuNWLJcg+prVN/EVoRykf/bOpn2l7g3K2zoQsDOKVGHe2psJvhfTyWCdAy1+t5A9H7he0lzEkxBq+k5lYXHS/RqNP1ssY5EOgCyRPWKhLAPV+dKxOBfw/m9b21qa7OQ+Xwk+exF0qGsqvpQ0zvCCjzOUIAQorVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020537; c=relaxed/simple;
	bh=QrtPiIIEmngjX/ufKTHzDO+WoXwfO9/2Qs6ernMOB0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAdYqtrKirFRVtkg0Jm42qiMdMyZ3XgmAE7VCO1aYcumWmSAXzFKzDXhQTIzJ+1UD6cxd1A17/PlFB0L7FLvGBLVA2zSZ9SqthvmLbG8eRosua7B1+MsqUgMFkRep2zFxlxV47dCoRKLy0yjNen2vFBQ77Kc9EjI281E6jlyTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfJP5fq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfJP5fq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FA7C19424;
	Sun, 12 Apr 2026 19:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020536;
	bh=QrtPiIIEmngjX/ufKTHzDO+WoXwfO9/2Qs6ernMOB0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IfJP5fq/xN1TF00WXItP+OJ7Tu2m1itvRGs5THOQFFp0hx/uIJTySXoff+liEsERH
	 Ya8aQCxfL42FFo7HBfRaH9wjRvhYyW2LvTWTtvzmQVMMT3JLugSuOF8depdB11lc/C
	 OhrqcrnbDzYlGQJJjwFyYacXYcZEmz83kxjxfwXFgefAJTG6bL2irXn5YQBoOZL3rj
	 /1zDuCSfMx9DXRn3PLUi2ppjX/LIaZBv5Cammbmicq9N/fhmT5HNq6NMcuHPXBnUBQ
	 q+7FvZAGou7b+Kn8/sybuDPkvekObhgClHiVyI4/QnYBRUJ2yRB8eeAQIHj33eQnTy
	 NaXW1A+2f6iDQ==
Date: Sun, 12 Apr 2026 20:02:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Renato
 Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] iio: adc: use dev_err_probe in probe paths
Message-ID: <20260412200208.3a53429f@jic23-huawei>
In-Reply-To: <20260330111856.121589-1-antoniu.miclaus@analog.com>
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 14:18:43 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> This series converts dev_err() calls to dev_err_probe() in the probe
> paths of various IIO ADC drivers. This ensures proper handling of
> deferred probing and simplifies error handling.
> 
> Where needed, a local struct device pointer is introduced first to
> reduce repeated &spi->dev dereferences throughout the probe function.
> 
> Drivers addressed:
>   - ad7949, ad7780, ad7793, ad7292, ad7791, ad7280a, ad7768-1,
>     ad9467, ad4062

Applied with the minor tweak of adding () to dev_err_probe in the
patch titles.

Thanks,

Jonathan

> 
> Antoniu Miclaus (13):
>   iio: adc: ad7949: use dev_err_probe
>   iio: adc: ad7780: add dev variable
>   iio: adc: ad7780: use dev_err_probe
>   iio: adc: ad7793: add dev variable
>   iio: adc: ad7793: use dev_err_probe
>   iio: adc: ad7292: add dev variable
>   iio: adc: ad7292: use dev_err_probe
>   iio: adc: ad7791: add dev variable
>   iio: adc: ad7791: use dev_err_probe
>   iio: adc: ad7280a: use dev_err_probe
>   iio: adc: ad7768-1: use dev_err_probe
>   iio: adc: ad9467: use dev_err_probe
>   iio: adc: ad4062: use dev_err_probe
> 
>  drivers/iio/adc/ad4062.c   |  7 +++---
>  drivers/iio/adc/ad7280a.c  |  4 ++--
>  drivers/iio/adc/ad7292.c   | 16 ++++++-------
>  drivers/iio/adc/ad7768-1.c |  6 ++---
>  drivers/iio/adc/ad7780.c   | 46 ++++++++++++++++----------------------
>  drivers/iio/adc/ad7791.c   | 19 ++++++++--------
>  drivers/iio/adc/ad7793.c   | 30 +++++++++++--------------
>  drivers/iio/adc/ad7949.c   | 25 ++++++++-------------
>  drivers/iio/adc/ad9467.c   |  9 ++++----
>  9 files changed, 69 insertions(+), 93 deletions(-)
> 

