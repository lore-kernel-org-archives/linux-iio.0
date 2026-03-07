Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD5355F47
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919800; cv=none; b=rSqMnhZipddHwtnFavcLi0NXpSOfBNQiHtszFtXyCBBGLdkaucYGirkE9YLqvl1pQw3GoH8rtVPtVNgslz6a7/PaZVJh+lqVxM42dxLRyxxZQmZ2TRPMYnP4rCCSbULRaS1blXInxPkwx0rfVvcV/Y5jqR76urzFevFnqZYt/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919800; c=relaxed/simple;
	bh=8pxL4T2Jjl0AcsladIiKYoodx/yl8lsjNn3HQ8AfaAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otT6CH5colNxvFX/86PkWoJCvyQEw2qmK32Nv2IxT2Fo4AJkkMfXzVVGj5/SBYOB3Z/C9JVT1/2FqGl4KJqRVgD+FOOGt1dgMXnN9UvbfnXcCO9pfAr3KCOoEcl/EEM5Xte6529REJ0pSYydSkrWw2x/svwVxc02yYMB2RZ+1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E53FQuDQ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E53FQuDQ"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56afff51694so1208734e0c.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 13:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772919798; x=1773524598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1etgWm/sNBVjupgsc0F/skJCAtMhhMHTHLJkhw1i25Q=;
        b=E53FQuDQAgAoz26+rFUW23PGY1JjkOhkKcHYirtb4FmLM34apF52e7blEJDiEb0I21
         nyqivt+tNTpA4cESacXpjtzGQ1sh/Flk4gMZHUjYCnbh9/nISWwdpdlxt02ipkkJnQmK
         dE6y0ae+nQ1DoSZgaTV8MgVJQtOmBCteQ+En/yKrT5itoeNPm2fOrueRhU5xwgXrjuIy
         B2v3KFo2rRfRjIaUiZe45+MaSn7XUt1z0pNXY+K4GHlPVcqUzSORddjfyRFr6eL6touW
         uGzpLw4VsgNubhlQJarVHP7d57M6YNCpS07Pk+DGr7j0pmBKNsGCBkJ/ZYR3hmoEIOqX
         w6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919798; x=1773524598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1etgWm/sNBVjupgsc0F/skJCAtMhhMHTHLJkhw1i25Q=;
        b=CUg1F9kpiczZEt39q+QuyEMiBvy7pWNtYXODLtomW/eN55/PGLvqZUM490NRqgFR3d
         bvRuFBm2bw05iHrswnZTQSHbN05JqnKIvnrPwowq+K0tEigIDHDYLbh3dLGnxIwANzCY
         INTDXCjfkNnLId39KTizvqEDbL7ydFgWCnRtGhKgTeB8KBvxslv1T7eYTlmN1Sgv8M2P
         sCo73ThXqzd+xhsQ0GJSFRJDl7CVIZitEan7j7NnBxfEDnsU432R5ZIprE6+RYAUqk4q
         sxFLsR7ml+u9XG6Ri+5RGOEh8WziEr8DJN7fCj1SyrQLvApQ2bANWhA7/akBmW1QgItr
         KHIw==
X-Forwarded-Encrypted: i=1; AJvYcCWrkVX27Xw15F2C1QlsrxjwsCVO4F33kDsGvp0G3EFqHbH6VGzp5ohDbI3nAlB11SdMKlxMrceGQds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAG1kfKJkavQKiCuQCSotHWxWsT9SuH1CVzf3qtYdD5s/QvJ3p
	jmr+O9mROSaU/S6fjegZiT9b2ACPKBs/puYqyswKO1il33Dy5rdRR/M6S3oOH0gQ
X-Gm-Gg: ATEYQzx5a0/qHOLp7BJvOUu3QdrvBmv8GV024tjekXk+6tOKyX3aEw+7zM4k592obs0
	qZ2v3K9luO9Q1iUHQ9/9jvMpomZ1rnB70xAQ1mxaREdRtvxnvvDRWwurzAdq1sq9GLhbmk2tdgE
	AZZ1CLCMoDTEhfiXR0DCNmV3M6V/9pc61cYjKsGuKL+DBRxHPuGt/2azqdMEesIgJNC0wcPyMlA
	5nXrG4RaecOQ3iN4ymHfsyKpQiQp5iLRaW8FEmqjM3Cebl1UWqtyF0xh3vsjd0umHVYhIDMzCWx
	tLZVeJkRmh84Tmt+nemO3kGYr+HHgBsBohJ3Kzjbw9gyXRZMsw0lKLhrHPqiFPqkwCQhnn6AYZk
	LwtUcITk23WjuRSeCjmeGdLQpMPADlLWvBOS9O/gkzqRfVkIKGyNVRbMScP7LfsI7pL53DQ0NLK
	0sXcf6W9ttA9Fg+Jwd4+1XBHyoFL720lU=
X-Received: by 2002:a05:6122:21ac:b0:563:c3e7:6132 with SMTP id 71dfb90a1353d-56b07e17d49mr2174579e0c.10.1772919797882;
        Sat, 07 Mar 2026 13:43:17 -0800 (PST)
Received: from localhost ([2804:30c:966:7b00:fd18:61b8:43a7:4049])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b09a0a121sm6008229e0c.3.2026.03.07.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 13:43:17 -0800 (PST)
Date: Sat, 7 Mar 2026 18:43:53 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: ShiHao <i.shihao.999@gmail.com>
Cc: marcelo.schmitt@analog.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	till@linux.com
Subject: Re: Request for guidence
Message-ID: <aaycGSJIQicH34jD@debian-BULLSEYE-live-builder-AMD64>
References: <aapjuiq0JSVWfmWA@fedora>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aapjuiq0JSVWfmWA@fedora>

Hello ShiHao,

On 03/06, ShiHao wrote:
> hello,
> 
> I hope everyone is doing well and fine. Recently i have been
> getting prepared for gsoc 2026 for The Linux Foundation project
> idea iio AD39113 driver development however i just noticed that the
> project idea has been withdrawn from the list. I wanted to ask that
> whether the driver develpment is still planned or it is dropped from
> project idea list.

Glad to know about your interest in the IIO driver GSoC project.
There will be no IIO driver GSoC project this year. I suggest the Device Tree
Bindings project as an alternative.

https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

> 
> If the driver is still needed , I would be interested in contribtuting
> to its development outside gsoc as well since i have no idea whether i
> would be allowed for its development or not thats is why  any help would
> be appreciated thank you for your time .
> 

If you're anyway interested in contributing to IIO, there are links to
IIO-related material in the non-active IIO project page

https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-IIO-Driver

I am unable to send any hardware anywhere, though.

With best regards,
Marcelo
