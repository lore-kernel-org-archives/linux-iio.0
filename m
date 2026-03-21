Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0703C1A9FA4;
	Sat, 21 Mar 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774127597; cv=none; b=lnggnHy6JJjjrjFrumz5lsqqf2ACQkb3Hv92fh+1/b1IFX3sjeX5IAJ78JNpn/jvbrjKPrYwt9jtQ7YAuxK2InvWBnRtSt3w0fe7YxHUEXJ9jHPrKh8vZ/LhgeOfGXZx2CnvoRXaNzWgR1ZSCiEEWvcaChANc5/oJFxS4jb1+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774127597; c=relaxed/simple;
	bh=i6nhQJKyWJ7tOR2iZZ/RFYHcCKqE21WUG9DDIVgyyVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWu7M7wRNZns4PMuyoHBySSE+H78mJNCdyMYzYfwUw265qEyDhm12MDqsf/QwPb44tBYzkJ5xHaV9xk7tlxfZ5HTwVlCS2sL1pivyLE1cGOb45KKP+MRTrFYvc/d054kB9XHAZHz2OI9TcFrv8ILyQS6Vq6FJTrmVMdAp/MwSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opBwA0MG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opBwA0MG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83349C19421;
	Sat, 21 Mar 2026 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774127596;
	bh=i6nhQJKyWJ7tOR2iZZ/RFYHcCKqE21WUG9DDIVgyyVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=opBwA0MG5mO9T8Yi0FmexYyCfMIQVKIorgcFoUYbx29ivNxMyuV9GzTzFEBrFuQAE
	 HGgt6ICO5OZstDD1QfK0/Fhkv7WYpwRYW0MuDrS5uDDLJbZIcXV1ZNT2YFRVgEHEpP
	 cSyZlO6GPFxcmSBE4y6zTGiI2ezvbTkSdADsAS1aDBENY6QSLzAfuimtdQ9D6WZeGV
	 gPBZ5j7jZAAsZXxysOI/elhTIRCvbANYPUizRiQyh1wyHFg2FtXOtjqbnqR2O6QycB
	 oIcA3cLomfnvPBgphQ7EgDTi5n7Yo3ltFn0H1bi29kaEaKNG1tIJGhjG1WNdglV79U
	 IOy7UFP5aGYOg==
Date: Sat, 21 Mar 2026 21:13:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] iio: frequency: use dev_err_probe for admv4420
 and ad9523
Message-ID: <20260321211307.4d1e5cd3@jic23-huawei>
In-Reply-To: <cover.1773050333.git.antoniu.miclaus@analog.com>
References: <cover.1773050333.git.antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 13:57:40 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Use dev_err_probe() instead of dev_err() in the probe paths of the
> admv4420 and ad9523 frequency drivers.
> 
> Each driver update is split into two patches:
>  - First patch introduces a local struct device variable in the probe
>    function and replaces &spi->dev references in non-error paths.
>  - Second patch converts dev_err() calls to dev_err_probe() in the
>    probe path.
> 
> No lines are edited twice across patch pairs.
Series applied to the testing branch of iio.git.

Usual stuff about will wait for bots to poke it then push out as togreg
for linux-next to pick it up.

thanks,

Jonathan
> 
> Changes in v2:
>   - Fix vco_freq_hz format specifier from %lld to %llu (patch 2)
>   - Split pdata declaration and assignment in ad9523_probe() (patch 3)
>   - Leave dev_err(&spi->dev, ...) untouched in patch 3, let patch 4
>     handle the full dev_err_probe(dev, ...) conversion
> 
> Antoniu Miclaus (4):
>   iio: frequency: admv4420: add dev variable
>   iio: frequency: admv4420: use dev_err_probe
>   iio: frequency: ad9523: add dev variable
>   iio: frequency: ad9523: use dev_err_probe
> 
>  drivers/iio/frequency/ad9523.c   | 22 ++++++++++----------
>  drivers/iio/frequency/admv4420.c | 35 +++++++++++++++-----------------
>  2 files changed, 27 insertions(+), 30 deletions(-)
> 

