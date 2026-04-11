Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378F33030F
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775903913; cv=none; b=AMkv+shhHEqMRSkIvc4tFkm8sPNdV8eg/i1Q7njygcuwm3x4+MgHetITOWXaClx8PwhQtOfR2bsqd4I4Q50WCrITwXMwGGns89Cg7+qnUnOlThjdxaCzUi5y4+YRmzdtkgHOTmpwnZnOH/TZGKQ0M4iMM30Z8+HoA3D5s42lOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775903913; c=relaxed/simple;
	bh=1ssmPN6eaWpsHEUpRPyPqbNx0hAfCC6bne2u4F647W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2neXoFc8PC1hK8x9hPLvmFOHBUYhH8yVf42oYEAOgTIW/OsyKZ+7Ia+ltsEPW+JFVvuNtN+rCD9PEg//JTXs+yd6Iv4pLH+rgDYOfsdQriEiUiUuK8p/hvJCZfr+k80ju4K92uGmeQfJTvpx/iS5iCwJhDROeJbuB1LgKjzhtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zc5JTcIp; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc5JTcIp"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-128e4d0cc48so10492152c88.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775903911; x=1776508711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m48yn0WPV4oaRj5jTwnjFikJvqvV0KXxEX/oKLKRTpY=;
        b=Zc5JTcIpYJirx+1Z+Z0CvkDVCpIbQS3C/YpU6oRin2gMOQwl2VijKLIWJCp599N7Su
         Hx/SimGNWOffVjbCeGGhVQPNBNeDTlBcaheGe91KaGGaoRZAg7XIFx1M7gluoRgRxGg1
         qAnbIjfYUYmIbLB1gwK7VqO1iGK77ylaU5EYVnRYAVl38JVKpgXhlDUkVf40Fg4B77Gt
         kgTF94vqw1XR82a7Blixrkd7ZUrj3VTaL+MMHlHXF0zEz00ecb1pWsgELIjczMbHDmvB
         cRtyCXNP5WahH68mtGytuTKUKjUlUfk/8iJfL7qcy5BFJuCQaUP/5F4TEOjenKSbu5Zo
         0i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775903911; x=1776508711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m48yn0WPV4oaRj5jTwnjFikJvqvV0KXxEX/oKLKRTpY=;
        b=M1mpdz0WY0wpbV+cjEor9sCV2b4HwAwDSOk3sfJW9ex404TTeEgoxXQnbwHeUecbZv
         jxBnvHLBNO0kN9tL/PFccx76bKQoK8dylJzY9EXc9fPs8UxO+EQL9DG2mvVEB69Yo13C
         dsClZAo4HjXKBRScomQlCLzWwT8qpfX4G+47Rry0BwOPurnDLP5YhhIkwe+YubzWo6lP
         oG2YQMXJtkj6EsfzVU5bQ6/sQbYh+M3HRBBNUmkBmN+0JLLNxMri29Ke4t7rU/Z3q83z
         Lbc2Q87ACttnCFwAEK4CsTil3p7j/O5Q2Vj67LSh9/KDh2F2Dzz50SdGW0omtCnVz/F6
         3ijA==
X-Forwarded-Encrypted: i=1; AJvYcCV1N2Nl9yrrBC3YGDOfY/XRWttyx3dXm7XWbBqUfVOGjB/zFK5sqKG93N/BpultsQ7LvAhtMGiMfsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQFF8BFBYaFmYQ7DgrAYFlXqLXdME2P42glzqngFcCIRkXUKKU
	hU4nIqq8TOaZudMYRE1c1wvHt1h4SyXTFtB/2D1Hw/ASPtiSnTv30mgt
X-Gm-Gg: AeBDieutAUnUabhjlTwL8XDlfR4KNZm3WmcQJBQNnCIOt1aBwWXB5rqtILnBECU2i4E
	Xg0gQlNfJRqRg39KXkGvvckZ8RhDzmkcUfkbAK1B16OLgtejicVZPTQHSQ3s8Py8mJjR8Kpn/Su
	bJLojER6hW7hcqEe+Ajw4IZXd3V5H0hz/PxPKgfCm82Se1kweZ2See/dYtK/4rpVJ0tQrxHxs9J
	cve3bnCcfjBHbC6NDYLg2p64hiUWAmjMI35ccI5jSW8JzKyellu836Z4KddJck8w1F6ByXwxPVV
	7ITgDFk0hJDnknPMJKf1wSZuZgfzkiJTQxFBLjnz2/iZPIA/U/RlJJXluAdzjH2nfjmG62CJhO6
	xDoKm3D5/Z8N9dFo+EmGKPIsNHBE6Nbc5dNbp2IbaEyo2ueXihUt5eHezZbbieXLcKcKKdwwVoM
	xtKQ7/LXqHcOFcX5c=
X-Received: by 2002:a05:7300:7495:b0:2c8:8ae4:962a with SMTP id 5a478bee46e88-2d5870ac142mr3775954eec.2.1775903911142;
        Sat, 11 Apr 2026 03:38:31 -0700 (PDT)
Received: from localhost ([45.86.211.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5632a64easm9136444eec.31.2026.04.11.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 03:38:30 -0700 (PDT)
Date: Sat, 11 Apr 2026 13:38:24 +0300
From: Dan Carpenter <error27@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] iio: frequency: ad9832: simplify bitwise
 math
Message-ID: <adokoNfP-Ueg4yQ7@stanley.mountain>
References: <20260411085848.75381-1-joshua.crofts1@gmail.com>
 <20260411085848.75381-3-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411085848.75381-3-joshua.crofts1@gmail.com>

On Sat, Apr 11, 2026 at 10:58:48AM +0200, Joshua Crofts wrote:
> Refactor the ad9832_calc_freqreg by adding a BIT_ULL()
> macro instead of manual bit shifting for better
> readability.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> v2:
>  - changed ull to u64 type
> 
>  drivers/staging/iio/frequency/ad9832.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 8873a6d11e..4221e51dc4 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -112,8 +112,8 @@ struct ad9832_state {
>  
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
> -	unsigned long long freqreg = (u64)fout *
> -				     (u64)((u64)1L << AD9832_FREQ_BITS);
> +	u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS)i;
                                                           ^
This extra i char is something I really dread as a vim user.  :P

regards,
dan carpenter

