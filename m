Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3ED376A18
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142173; cv=pass; b=j5MlqC88v+MfySBmZ37LHqLXSMgRa85PuhukbZt5Y56aDqfbyeuGtwdLqHARD0ukonbeaD072FvbmOIXqDSCDxWjN71fosfs9OpSLoSi5r9ANXz+jtIR7Fwh3R23a1Z08RUvDXCX34R82LngVUFh2FEN9n8SYF5lBZcrV/BuQNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142173; c=relaxed/simple;
	bh=KQ7uEoW5q7ok/4PPv/9Ic71rSNFWcWnC9QQl4PvoEUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn8uXq5qGDTjKSY9ulHL+aZbWt2rwp1IeZqbgXdv03Qu4U62ANUnnYAX85axE0XZhjyIdo/NQ6Ey80mO3R6LVtRONBaNKoEBeee72zyN1jr/WoGKyqi2mO4d4QEpWC3mnR/3c6zJeb/wiUvfMux2Gb9+lyV69qAGscwYcHS/WiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmIwMH3v; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmIwMH3v"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-800619d5e7eso44434767b3.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 08:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782142171; cv=none;
        d=google.com; s=arc-20240605;
        b=fpQRn0C4FKlwSkusskAc+luJkfQ551UkCvU6JmR4lv9FFFEBWjNJuUNyl0Cf6pHEsd
         YH+X+5150P6m1vWjG1x2DQaO8G0Xj+4u6EBcDpzbnueEHlqeIowyuZ88tLfGOaZvhu/w
         Dk6djZ+YMUYcqwHMH3Cb6aJP1FsTX8KFUOyuXe7YjmQlyQQUfkH19pZi0fxLiNMFVPRp
         zaQ+L3nG2x3ogcakpi2CdkRBxKFsw4DXNk0DMm/yILRZ/4AIli6t90T8aHkLyiFRi1UM
         w2Ce3SkB/Awg/L4rXsy1mGtp7Q+75FF1k+UrSDQBiRVpe7U95pTiNCa2cJW+aYDHuwQe
         cx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KQ7uEoW5q7ok/4PPv/9Ic71rSNFWcWnC9QQl4PvoEUA=;
        fh=UxOEcn6FdyprjFl/ZSnvlA9/hSycwm4wRNsz3dYXK8A=;
        b=WJadtzxmr6GBPUr7qD9TWkp8j0b9V62s7iGwt74WGINMGeee8XdzxRJYUr6plo9lsi
         Y/XNXADKgH1/TTlBXKSVy2a8Io+h+H6yyc4d/sKJZY0LfdZsmDxL3WxpMtxwNYbh13rN
         zCShveMW+VbgHO3DQgd7dHbYC62XGinYWnTjQJgupIkiTUYDOoDWwo0ogjyZ37X1GmVa
         cAJKBqGLDNXmUu/JCACoCFO1jYPQCGeN2S8e26Y8jtV7qTdDSLoT/+vaOHIlLmEXJ7pZ
         +3WOmhvHOsywisKOvVC+MZmDijlAYaVp8UVX/rSve5AKLldxz0t9QtUz/40SfwvJKaPS
         h+DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782142171; x=1782746971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ7uEoW5q7ok/4PPv/9Ic71rSNFWcWnC9QQl4PvoEUA=;
        b=TmIwMH3vuLmpefS01ItJ5WbZx07d5SMPZUHumIUlTW+zdA9N7RWwwh6xP57br1MxtM
         Aldceh+WTP3ibVAgNbfSIHjVEF6Gzn47BzHItkP+9qJ5pJYTH8EShIAVn8nWlVUB3TBI
         JEr9gq5QZQgvx4DrT1BLwUU6zFrdzIT6lvHyBR4PQ6piZbrKGLsNOlUiY/4qNd0RbaRa
         X4ZijXd6HG0ZEsDbktoqjMBuWIjHRbhOvvUh7dHWFjcHpXl//A4H8mQEHwsrTrwdrpiu
         hEzGd8mYQiNyz94nMqE9la4+NylxzV+o/C+se2InUmYj3A2NywJrCO1J6X4FUxv4f+Y4
         zgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142171; x=1782746971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQ7uEoW5q7ok/4PPv/9Ic71rSNFWcWnC9QQl4PvoEUA=;
        b=pSIAnoWzmLd7yEPtzOhBuGP0dJNIFfbWKNta+Z5jKz1um29+AdpBbX+DV9cviffXmG
         APCAs0VESPr+qKBieh32D01DDUnv3RMXG3HvlY4HM0uysYFiGYkUOHzBJ5LBP4Y0Y23X
         3WXhPqNpsjrJzqP3cgHsRNtRdcxPj+/QKJbXjkJ3LgTcZTmr2+OCV+cb2Hh4jc3hU+Ff
         ulvX2C7JLOMk57tZ+N0UVtxNGvzC018ShhXJIYmANGwJ2tKQjqPOIWmUlPy7KlHuLzFh
         iSrzS6WgBoUlk6bRcSWgV6mE49qq0sbYEu6MtBMVeqjm49kaH6f9MNcCbYrSRXmlAgLZ
         ETdw==
X-Forwarded-Encrypted: i=1; AHgh+RpY3BIZwEHcz52Y4IaXWCDTYadqg37R76MZiTGOscZ5sgWpsqshAkBPA86ZH+s0hcbMwvXJ8jAVJAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbYb1Kj2ABaDBVXXmEqwcqPMhQ2vSG44+zk63BHiq/dPgmMNJ
	S0HFvWk9OZh52mVQxX1viAsA9hcm8OK0K/nmNmJ011cfITXcsm7urCpEyh7POKwScJ9IhjR+3P0
	sYfxi1gcS8mwMWnwx75xi9AuJHVNCn6M=
X-Gm-Gg: AfdE7cnQd/9Xsr6utlcamg0VQln+HxPFSKZC8/CGxCNTlCYdQRLjnUrF9Q/mP/poIjw
	ShdE1AWcCV3GW+QpJwhZ/WPtwuCqmIghQLPL6jYn3csD9K2autC8wGfDFSgmzPRyLmbKPcB2kos
	cI/Qz6d+rKqGfn8pZx84FvCl35s73l5CUOi/sqZqWqr1w8HINwTmh7SSgEZChosjQRvqG28oLYh
	S6DX9gmSGI88gPJqB6UMOtKgE2iiLpHE9uNFqGE3kQT/f+Svx4VMoGtaEMf/UR6wetreDkO3g==
X-Received: by 2002:a05:690c:3502:b0:7ff:8c8d:162a with SMTP id
 00721157ae682-80266843e74mr112915737b3.39.1782142170798; Mon, 22 Jun 2026
 08:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622052135.1804135-1-sanjayembedded@gmail.com> <767892206bf6a10de4122f5e1faa8481541170ca.camel@linux.intel.com>
In-Reply-To: <767892206bf6a10de4122f5e1faa8481541170ca.camel@linux.intel.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 22 Jun 2026 10:27:09 -0500
X-Gm-Features: AVVi8CdKjx1UPZeLJTKQy1YQKelEvDPdcHbYi8ty_vxr0rRtarCXghB4ppKXTpY
Message-ID: <CAKqfh0Hk12rA7wkU9wbse=n9qbOgbmxK0vhP6Enj-R2yKCohuQ@mail.gmail.com>
Subject: Re: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	hongyan.song@intel.com, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:26=E2=80=AFAM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2026-06-22 at 10:51 +0530, Sanjay Chitroda wrote:
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >
> > Avoid using devm_iio_device_register(), as this driver requires
> > explicit
> > error handling and teardown ordering.
> >
> > Mixing devm_* APIs with goto-based error unwinding breaks the
> > expected
> > LIFO resource release model and can introduce race windows during
> > device
> > removal. In particular, the IIO device may remain visible to
> > userspace
> > while dependent resources are already being freed, potentially
> > leading
> > to use-after-free issues.
>
> Please explain this use after free case here.
>
> Thanks,
> Srinivas

My guess is that because the device would still be registered but
would actually be removed, sysfs still has "wild" pointers to
read_raw() and write_raw() (which don't exist anymore), causing the
UAF. If I'm wrong feel free to correct me though.
