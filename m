Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC582899;
	Sat, 28 Feb 2026 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277978; cv=none; b=ojunr4KgKBPSyA/xcLHNDNM/AfxuQRmZuGclQitzr/4jGA/97wefXY1obG7kLTVNA7Z1A8ft0BbBXDSAm1Mvx+FNXQC9ZJ416nAKhihaGhsl7QB/VwqpanbM0npQxMrTSsIaLjvYeYkHeCCwWJB8XB5FEHdMOfPCeD2hFhtuDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277978; c=relaxed/simple;
	bh=AcVPXkGADFmy2hwVB05WuVei4FdcNdpRYF81pHGr1A8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKM0DH1zMvPaacHaDZsLJ5KOAvpnSZHpwILZjFZB7VT6YbtdCH0VvLL+1LyyBoVL7ae1tq00Ky8q6MPmozxzXpNUSBfqeRm9Q1NrKBrePEWme/iS/mnhqDwDr3U7ki6JlzJ/a2mO2Vxdv4PqEbwbKBATyPF6RvIwsSV6fvVleKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpDAVMWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpDAVMWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DF8C116D0;
	Sat, 28 Feb 2026 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772277977;
	bh=AcVPXkGADFmy2hwVB05WuVei4FdcNdpRYF81pHGr1A8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YpDAVMWs292EAVKrn2d+H9WeBlUZr2pKsZb+TqiY8FlrkXHH77zjf6t5yW1p/OpGm
	 LZejSwQGCVz9kXgORENz6IjdRpozmVmlYpHCLTFpU6f6JJKyb1dNBe1+t1y5M2igvI
	 aGMSyUMC7Rxr4kmU5pyBr6jXi/L8pLbQRh8oFLYX65NWVpIvnZoU1dmTWDZNWiWU1a
	 StlOozxGEnwNIHhf95vH9UyQ0ofvhJwNDN/+VhCtmOyo4D9rUlgUTMO2GzXlx9yzpr
	 weqIqyis6AdJDrmZymexSsWIXLpzeZwbCoIeA9sebJTRXeBclNlxkVlMiP8y5lR9Ol
	 JZEsTVR6CYnBw==
Date: Sat, 28 Feb 2026 11:25:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Fix unbalanced pm reference count
 in ds1119_single_conversion()
Message-ID: <20260228112559.03ec989c@jic23-huawei>
In-Reply-To: <20260228-ads1119-v1-1-e16825ce34af@gmail.com>
References: <20260228-ads1119-v1-1-e16825ce34af@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 01:48:19 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> In ads1119_single_conversion(), if pm_runtime_resume_and_get() fails,
> the code jumps to the pdown label, which calls
> pm_runtime_put_autosuspend().
> 
> Since pm_runtime_resume_and_get() automatically decrements the usage
> counter on failure, the subsequent call to pm_runtime_put_autosuspend()
> causes an unbalanced reference counter.
> 
> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Hi Felix,

Looks correct to me.  Applied to the fixes-togreg branch of iio.git and
pushed out as testing.

More eyes always welcome though if others have time to take a look.

Jonathan

> ---
>  drivers/iio/adc/ti-ads1119.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> index c9cedc59cdcd..4454f28b2b58 100644
> --- a/drivers/iio/adc/ti-ads1119.c
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -274,7 +274,7 @@ static int ads1119_single_conversion(struct ads1119_state *st,
>  
>  	ret = pm_runtime_resume_and_get(dev);
>  	if (ret)
> -		goto pdown;
> +		return ret;
>  
>  	ret = ads1119_configure_channel(st, mux, gain, datarate);
>  	if (ret)
> 
> ---
> base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
> change-id: 20260228-ads1119-66b5271ef827
> 
> Best regards,

