Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8821ABB9;
	Thu, 29 Jan 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702710; cv=none; b=LumP1pw/qC7JcmtswvCqOR8sEpCpeGcr93JA82jD5FjnzIWN6z+9L2hdn5PzMgRYJwaIyd/+VKAozEUiVK9oPK5etaCblYYO5nI2OCW+ytC1hAxDbH7nSqbJKtKPKh9WYDUy43nBkHlHM9dyJaQggoNI7IU2P9fdn/D1T0NJWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702710; c=relaxed/simple;
	bh=dvGaKrxjwDjL3wSEWfqdB70ktO29nFul/sc5Qxs9Rqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7bnHV9Y+UPQyU6tKphjCPdtL9II70hu3QSGeBfblQ/xVpmOkHF/OpG/vbC7bOzjnwrK82Evwetm8Xi5TPMkrBJz0PAPWKbwcu53FsNcej91Xsd8G06P9Qs3mpi6y3vWVSGtplMS8SYPn3oTSUUlj+GIBqZmDap0vb3oYSRsGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEn9xy0V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEn9xy0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2296C4CEF7;
	Thu, 29 Jan 2026 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769702710;
	bh=dvGaKrxjwDjL3wSEWfqdB70ktO29nFul/sc5Qxs9Rqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vEn9xy0VsGk3/O+ugHYSgz17xMy8YX5h8qm7npyDCeoynXI2zIVG70y4olbbM/Qp3
	 6cZI1U2UBCOisJih8wDI8lUomSEsNWpCQWuhHVICQRuEx6w3oRSFgmosMSinzqKFE0
	 G3TmR0lgaeiGqFxxJvvx5SAvSUeMA/5EVZGp5E2qcUE3uYNRatA89mzBnPzKKqKQ2K
	 tGEhNFSrUxEjgRNlh9T+cSsjznyGz91RT0bydcdDaN37GoVliAHjevBco/Q/97g7la
	 4ZJkyM1TL7xZd0E18+KnKXAt4xKmj4WjZKZVgsMv+2wsJbCwCUxyqneYAwL25X7Jxl
	 Fp5v0+qm9JRxg==
Date: Thu, 29 Jan 2026 16:05:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dev-jorge.sanjuangarcia@duagon.com
Subject: Re: [RESEND PATCH v2 0/1] iio: Remove MODULE_ALIAS from
 men_z188_adc
Message-ID: <20260129160502.33cb6a0a@jic23-huawei>
In-Reply-To: <20260123104805.15975-1-dev-josejavier.rodriguez@duagon.com>
References: <20260123104805.15975-1-dev-josejavier.rodriguez@duagon.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 11:48:04 +0100
Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com> wrote:

Hi Jose,

When resending the first thing we should see is a clear statement here
at the top of the cover letter for why?  I applied the previous posted
version and not seeing any indication here on why I would consider this one.

Jonathan


> The first patches I sent for fixing the autoload problem encountered
> on mcb device drivers were 2. The first [1] was focused on updating the
> modpost process for letting kbuild to access to the data within
> MODULE_DEVICE_TABLE and the second one [2] for removing the MODULE_ALIAS
> on all mcb client drivers.
> 
> They were rejected and Andy suggested me to split the second patch
> in a per-driver basis instead of sending all drivers' changes in a
> single patch once the first patch was merged.
> 
> The first patch is already merged on Linus's Git repository for 6.19-rc4
> 
> commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
> 
> So now I am sending this patch for removing MODULE_ALIAS on the mcb driver
> in this subsystem as it is no longer required. This cleanup is being sent
> to each affected subsystem separately, as per the review suggestion to ease
> the handling for maintainers.
> 
> [1] https://lore.kernel.org/all/20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com/
> [2] https://lore.kernel.org/all/20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com/
> 
> changes in v2:
> - Renane commit message
> 
> Jose Javier Rodriguez Barbarin (1):
>   iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS
> 
>  drivers/iio/adc/men_z188_adc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
