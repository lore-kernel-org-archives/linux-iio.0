Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC9245020
	for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787714864; cv=none; b=T7K5NBEm5jcozZvvbeQs1+vupqdvfQTQv23YM4vQnzjjDBcuPjlJN7oESuXYqzxKMAcvLy5rKwyt9CZMS0+35JSDPYSCELuFMw7FWwialOm3pTyGljuX8Cn6AakFAKczAq+HX+rbJ2uhtAJ0jPPqrfPVcOjdhZ1ZxKZzyp+Kc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787714864; c=relaxed/simple;
	bh=apy7rp0KkyJekeLRg0/LbfQacv3/tKBpXuMOv5a0FoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bryxzvsatze5x1wRLv867ZY2ZkZXgRAPGqDpymiB+5Ld2dVDh/vAU3NUr7bZrm6GYK7n3FNZN6GSc0OKQuph8hYyJZ+JwaOq+SrQ1PqNEo36ZzN3Q4y9PArQGDFRonhed/TttuGaBvdd86vL1Hl8GbmEL5Mjg8Y5mHORi8hHC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABTd0Smh; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABTd0Smh"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-97c940ef65cso276341241.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787714861; x=1788319661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1qWanT6gYm3HAacbnAtggJfeeI5p5/Qpb1KAGvhVW4U=;
        b=ABTd0SmhhYOMflYY1GGdHxD1wdCpP2LP9Flp8xNbatyjWX4os5Av9mE8SQUwHiVnW8
         QkhNP588rNxobK7tzzsIfeRwPq40FIqreCx2fuIjgXlBzY5z8zV64VCSF1AdKJ436zXs
         uHGHjchW3MIL6hUmQ7Qkz8oPMmxOZi5nHBKxEVkziv4B+817fjNFslMHp6ew3+iAQv4V
         +zfXEqMvMPFCaytkkRTOo8f558478Khz3RzeqFjm7iSibHZNbRFQuNDHH3zCN4cPLQY2
         VfTdxaYJJ1pUDSnHbcXejRdOJLzuSG74M8RuSNbXQvclxT8ofrBepbwiIupojOGN5MJy
         O+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787714861; x=1788319661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qWanT6gYm3HAacbnAtggJfeeI5p5/Qpb1KAGvhVW4U=;
        b=sXBQYkan+p+HJHvjpOHVa2x8Itl+APVD2JcyAQTLfsEIqBacgqU9lYCFMv+0IGqecd
         bIONhpREcETKJ9IFLZ0WLZsFOnn0mEucV/LLAScx6lxvmlvuMx4DjDaHjfL9Q6aklSvP
         CU7QudGSsS+teWdFygataq4Z9swzIumCij+S2JjvcXP7t8+JMaxZBXLLK6V5hhO8eFUA
         IkgbFkafUDknmFtGfSbtEr3SH8pBFVRq275drozpFYRwN2K9JQyoM14IPrS+dXuITLMp
         rPFouWhAiqSSV6kIjv/7mHs3l7lFf7O+JcVKkCin+oY5t6IEr3IjtQmXZqZDUDsX8/Bx
         9RzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVGhiUwrRSFEyMa9Hxa3+8g0ls5nFVSpF+xQTBKnvMtcdL2FxhQaTb9Dq/zue15cNPLfgpZXk1QqA=@vger.kernel.org
X-Gm-Message-State: AFuF++lSSvrHIMi2/OhqHfwIpDLxsvarB6dbq0X8HMm/pRTEeN06NIje
	+AkpMEYb5LtV1OFKTLUwXkzaivug6B8KFN79wcoMF1z6fhD33O9YA9f86t26zA==
X-Gm-Gg: AR+sD13tpv1MorscqqVUDuTzdqamH7CApKPJkt5foRuQy08gyhW/GSTowAePNc0w0zR
	5zyBh/h5VDzHXhISKy9vAp8fU1RUxVyCYdy3ICmXPveJQbOk4BAeaBXqrSReWZdKw+Tu7mVjc23
	UNoQs+d5ThmMbUgEWFa5FWZTikbXWVfkICoWERD3U67UjIfPydXUGVDTFCCaLwpLuGh/Q545qMv
	Kd2pMR+IxlH8LsmiPmuJ0bH4ozYag9aYf4o6S0qBuJ85ee0pCN6+K/DmPDn3368ioHm//l7ziHx
	C/ASuvvEcGmLqEJ+y+gnTvUePog08Uzzx+xwd90dnNdFO2yZEvGyixReXiAooMv6sba61storWR
	5CtQesQ22Lvwxtf7eGC8p87txPSPnvXkRNdq60Ky+MPEMlQIptz0ylLGdxhuIGbnC2Kw0UXzh9S
	lC/PFSIy4N8xY00teun0GljV+W9+G0j4Ther+cQ4lDUwUScr6yZX+PiqTZBcyVXiao5PL+
X-Received: by 2002:a05:6102:2924:b0:77a:ce37:9884 with SMTP id ada2fe7eead31-782c2d07c5fmr1413440137.14.1787714860922;
        Tue, 25 Aug 2026 20:27:40 -0700 (PDT)
Received: from localhost ([2804:30c:97d:e800:9454:1179:18df:ab33])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-783081c3988sm665463137.11.2026.08.25.20.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 20:27:39 -0700 (PDT)
Date: Wed, 26 Aug 2026 00:28:22 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] iio: adc: bcm_iproc_adc: sort headers
 alphabetically
Message-ID: <ao5dVuReF1Q63ccU@debian-BULLSEYE-live-builder-AMD64>
References: <20260825172155.250484-1-mdshahid03@gmail.com>
 <20260825172155.250484-2-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825172155.250484-2-mdshahid03@gmail.com>

Hello Mohammad,

On 08/25, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Sort the Linux kernel headers alphabetically to improve consistency
> and make the include list easier to maintain.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index ab66b97d2f04..e46e3761993a 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -3,14 +3,14 @@
>   * Copyright 2016 Broadcom
>   */
>  
> -#include <linux/module.h>
> -#include <linux/io.h>
>  #include <linux/clk.h>
> -#include <linux/mfd/syscon.h>
> -#include <linux/regmap.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>

The sorting looks okay to me. Though, there are some includes missing and a
couple of them that don't seem to be needed (delay.h and io.h). Either in
replacement of this patch or as a follow on extra patch (not sure how maintainers
would like to have it in this case), it would be nice to also update the include
list according to include-what-you-use principles.

If you decide to work on the update to make it iwyu compliant, it may be
helpful to set an IIO tailored mapping file such as the one shared by Jonathan
a while ago.
https://lore.kernel.org/linux-iio/20250629194336.34a03946@jic23-huawei/
