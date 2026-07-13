Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCC38DD3;
	Mon, 13 Jul 2026 00:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903551; cv=none; b=NDkZGuhgvwUPGfCbLJycSo/Yd8585tUq0mJ2p28+377+73SbYwpdErpATnIwIC85/2F8uspkhojMzSaVn2luZL3KQJNup1L0fMoZnfSvy9DyJG2hGPSU3vQvqygkeYDK8KCVmg8/fapLlyu0uZwyumN2jh8nAJYTKrUSKplI/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903551; c=relaxed/simple;
	bh=b5aYDM4BQPJXSpLcBJDsUUpoAYIPW7+0PYBGk2t8E5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdQ1x+P7d60pdilKlyEUxnSn6cfyxfEKUpPu62BxQWo/VSinF5m0QgNyo9fQ6zTs6q3q2srhw+Gvrs8kEapccz41bwUeWZqt+nw39lXlJZOP9LCjTcvy0WKqgpwxHWY3nDjgAxvu+NImncCPvpcUBufLqDe3H3NJ9h5qQWGmPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow5UNGER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow5UNGER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06CA1F000E9;
	Mon, 13 Jul 2026 00:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783903550;
	bh=FQRpdPl9/pAyulwHjzxtkcJU2zYbJ/R6bCZLkrIfyZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ow5UNGER38aiCWLwgRzZUtZlg6MfjB2feLpeLYb6z/YiYst/ZVsYMYqyQBKk5Duc8
	 R2+RHg5ZHroPLWyZ94Vi9f7Rg76SoVuFgPpt8G/bmkSThSBbG+X3KNJRhWiyca73gI
	 G1g8MPA2bu8RYhAFfutGA6YF1Cv08roNFMe9rdkorsIr/GL6BNG91M5X3R9dH1XiuO
	 3hvCK9wjVDXwKDYxLyYKPRjh3kmAAOLC27PPdJNciEPJzbCVnie7RAUsYjXpfvKvkF
	 EAibZhGLsfFMzc1Gqdp/fVMyQxk/LtcYD8mVHKicH8LW12bRCo36cfJeNaYXyxa2LI
	 +9N9Wt+uELqAg==
Date: Mon, 13 Jul 2026 01:45:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iio: light: opt4001: Fix reversed GENMASK()
 arguments in fault count mask
Message-ID: <20260713014545.69a2ba41@jic23-huawei>
In-Reply-To: <20260712202451.20822-5-nikhilgtr@gmail.com>
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
	<20260712202451.20822-5-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 01:54:51 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> GENMASK(h, l) requires h >= l, but OPT4001_CTRL_FAULT_COUNT is defined
> as GENMASK(0, 1). The define is currently unused so there is no
> functional impact, but fix it before anyone builds on it, and add the
> _MASK suffix for consistency with the neighbouring definitions.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Another good spot.   I guess it is just about worth a fixes tag as
someone might add support that needs this then backport that missing this
fix otherwise.

Jonathan

> ---
>  drivers/iio/light/opt4001.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index 31a5397926eb..294532bcbc50 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -39,7 +39,7 @@
>  #define OPT4001_CTRL_OPER_MODE_MASK      GENMASK(5, 4)
>  #define OPT4001_CTRL_LATCH_MASK          GENMASK(3, 3)
>  #define OPT4001_CTRL_INT_POL_MASK        GENMASK(2, 2)
> -#define OPT4001_CTRL_FAULT_COUNT         GENMASK(0, 1)
> +#define OPT4001_CTRL_FAULT_COUNT_MASK	 GENMASK(1, 0)
>  
>  /* OPT4001 constants */
>  #define OPT4001_DEVICE_ID_VAL            0x121

