Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E647427A;
	Fri, 24 Jul 2026 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932994; cv=none; b=Bz6/M81e++/U8qxmn2LE69/OuAM3rTpcNZsQVyWd3kwrgPjW5Mt+WHXDlq/APdtd/4osLgiVDgsKB1zDmnHCvw5h3FdsjwlulOpYDb0PvggcZOOq8FSxZCvKe36ZEvt75+8+U5Bv6WswuAVLGl5ujnLhRvLrdDuPI4oEvbM20PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932994; c=relaxed/simple;
	bh=fUsUfYkYO7BPIcMWrMEi+8czHeZWO5eohGtqiRGdAFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UM6PCg3t+AE9xvh2DVBg3zKKUNrnshlAhlAAZ/WWjU/qY6ub6sfTG5aOTGXMmmSEPPebF9aLOw+asH5LL9GO1DBUd3vQx82opzXBlhWEnuz0sMIme/ovhaBz5mrBFa4kpP6x/1ENedCG72TQj0gI0CJp92qstlWcAQvWo7f/55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns1krx7W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns1krx7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0C61F000E9;
	Fri, 24 Jul 2026 22:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932985;
	bh=DcuMa3hW4xAy1bNAUDfzjxTyqpls521SZF7uTQ/PRRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ns1krx7Wkwt6CBZNYdI5gnaF7i8vHaVorFQ+actMBVPQ5wTPMIWqmCsUk9JjY/Pt4
	 kzlXvPU2sBvBEa83XlJCm+yHtth/TweATl9pr/50esmL9H10mHDRd2xdMegB2LErzS
	 wEYGvlNpCQL4Vs7lfRLmWIbETi/EvJCj6a1jUmv/gVKkYP30xWIq2VKEq8nMhFM6FS
	 CrJYOi/iQW7CM0yk3nlmMtigedvl3OShzcXdF78HXMOwU57Na3fd+tLyh9hBS/CTh0
	 UVhUwtUosHEcfAJSYM9Xf392jV+iDXRgcLkD+mkcHnRcHnU1hE/h5B0S0L2TS108vq
	 PNQSHVhovmCNQ==
Date: Fri, 24 Jul 2026 23:43:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add mailing list to veml3328 entry
Message-ID: <20260724234301.64660df6@jic23-huawei>
In-Reply-To: <20260721-veml3328-maitainers-v1-1-8166db77c79c@gmail.com>
References: <20260721-veml3328-maitainers-v1-1-8166db77c79c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:28:19 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Add the IIO mailing list to VEML3328 entry in MAINTAINERS, as it is
> standard to do so.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Hmm. ok I guess, but I can't say I'm enthusiastic about this sort of
entry by entry update.

Applied

Jonathan

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b1ec46c5919..013f6fe6324e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28777,6 +28777,7 @@ F:	drivers/iio/light/veml3235.c
>  
>  VISHAY VEML3328 RGB IR LIGHT SENSOR DRIVER
>  M:	Joshua Crofts <joshua.crofts1@gmail.com>
> +L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/iio/light/veml3328.c
>  
> 
> ---
> base-commit: 036d96ceec6d966339aea34d034420991e24cfac
> change-id: 20260721-veml3328-maitainers-b5534e17c459
> 
> Best regards,

