Received: from mail-oo2-f23.google.com (mail-oo2-f23.google.com [74.125.231.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B3B477E31
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768059; cv=pass; b=Zer2fZvtirqG12gULbnA4Dx2w1p+k2X8dmyEYksvu0UTrq/RFSz9qAE/040a0LFcKDePX9e+/ekBilViMc2J+aa3BFZnlKknjnerFu16XTqJMvpE0Ob1BUVckRp2Xo4LjH4yzDY2uqaAhOGUj3erF9mDfWzuZalFuY8eQ/ZuLlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768059; c=relaxed/simple;
	bh=aYrSFshnjc1dLaRx+4fcphgUxBfodGw4jGAuwnmXMOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+yRvU1fOytEIlsO/JAMeMM1oGUdvexA3RZTNr/KGK5LLCjmr71HcMAGnv9vdx6XNXXdHRMGS2IQYWi7ZZ2/KZRblb+vGt21hn9aEwiJuebHAzaKkr5vcLE2ZrXxVNrvgp8V17AKF/2ZmueBLjs/AFMa2hGLJxBl0mzhBMoaOu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSLEWDCx; arc=pass smtp.client-ip=74.125.231.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSLEWDCx"
Received: by mail-oo2-f23.google.com with SMTP id 006d021491bc7-6c72bd8a02fso2851381eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 04:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790768057; cv=none;
        d=google.com; s=arc-20260327;
        b=KIAbLam4/30ld5+BerLJwn3pyn0Nb61vM3l7Hwmz7METbKVPhJuSKYcNuFnMklmyq2
         91xl4RkH/l6QYyrzwJc9ONvALnJS2r+EsaRdtDiFWgK8eoMxLbYpbc0ytvDx/OXt+MuM
         FLDZpaRAoSpi1RzSRkzEkoegRhGTa2v1VDkyArqIcX6jflk/YITAwC5S7x31gMFMyv53
         mzercxMwUiVG+OltJIb7/uoRJi2D8CiciKYckQpsjznM5HBcRxDgkw3lQy9Qz6rg4OAm
         /JjrMCCiLR8ZJ/0LwW+wZTe9UdZYf4/+j9Ksz4K99f/1qxe9P7QjxzlfKXNSUuZp7L/w
         +dFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=srVWHQ34fmEZwN42zGAC9YE78eGz/CHZFtfzts5HK8c=;
        fh=pN/qmPkW/+xQuFLKxXPEartkgP+4ZiGgW8EAcCITQoo=;
        b=UiVJV4BahkRZfzH9UhsqFIakY3pKYghJdDBpgVSrSSdy0KoB/zKTcFkwXAEvTuUV9S
         jIyoZ8EHeRQEv0mOt6LDm7J/h7IQINVizlvEywLmfumqxk4ck4IYQMVpBezUYIb6cNPh
         +yBmUxSIk97X2ZLlzNoOhITyTragfeWPDbThZA33NZLpmELbpEXLBisp1Sgjftt0Wi8t
         hoPM2du5zd7UO0fL3VOPXtxfOB4GATVpM6bn5rgbWV+rk/SbBifJZu10v8GSob9IsEgd
         XJOrb+2UNlCGnRkTXCq/QSp16ih+UEAo0v+j/8DWujmwxGl1bRGJ+3ioYOkFJKLmcY+4
         jE0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790768057; x=1791372857; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=srVWHQ34fmEZwN42zGAC9YE78eGz/CHZFtfzts5HK8c=;
        b=DSLEWDCxtXVZ6Dk0G3hXOPk3okJJEQM5h23blJMnNu9NPvswzaOoAEnQIpCfD+ZRYO
         DjZHDLdaQAohjSgkJScxpPeRvjDhBJc6FjPC3nKYvd7e11WN3HNBss3jCpimkK0z93o7
         tKKbym7+bvU/JnBwZOQsphJBY+ZsfpOCQA7PspdGHBeXCsS1WTYUrM1cN7OIuVtXRCu1
         ngddTig4H2T7MnThDPZrtxN4IX5tIf88kZVTUMeits1Z0Xv5IEG8vsJmx3RC4iOSn6mL
         R3rFN3V8JYM9tAjcy6CNEINV1RcfZDYhAumKclDHQbPhFEmCCiRzRMgALTpYThBDv/Wl
         DUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790768057; x=1791372857;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=srVWHQ34fmEZwN42zGAC9YE78eGz/CHZFtfzts5HK8c=;
        b=dSi3Y/iTBtoF8V+4LefqD1OrItkzsnYa6hoRv32RaUAVQq5BwE52lYqtqTMIJVBCkh
         kf69yNEVMSNlN5/XCNdp+J9LHNFJIM8liAqnrWyfns0CcY3db4Zt+KMLa29+L0ZTkp6K
         oxrPDwvEwH43avXRDEKDHfNR0FwhToYDO6PH44x6gIRjKnxRk8Dsc+GwZTqamijhFWmB
         t/w4Gb0UC3flXprHm9VvqYNjSirhlOEkgwXqwnHSbS3Bipa90F6BU0WKkGAOJLxhraQ9
         PCDAkRXtOS9FlITwdMEDB+CGjO02365N4xkhKBZD12hp9yC1Dxfxs7uBHTiqpvj0NErC
         hEsA==
X-Forwarded-Encrypted: i=1; AKwUvBwQHPNnnPZGEDSgVoM45tzsbhqH9dUASSyl4qEbYgIqXqaKAkytXgYSzd3gKRwEYatrCLMX38LG8Ec=@vger.kernel.org
X-Gm-Message-State: AFuF++m4NQW3KrlBItGHoydN8kbDZQcNCoadbEutyoqJ6vq1sFm8TAvr
	0OeICufEm6M0iBWVhqrIy6aceanVjFur3KtjmeU6OPaAwKwMTU5OhAkOUEg03Cq9NoqsCKt+voz
	FHZCtVb4iWjMvmcn7iTPI+yiaYCMYek4=
X-Gm-Gg: AYBFou2N77QRkTOEcKMZT0PJ5rT/FE/yR4ZyOl0TaRPMO869CLcgt+id3NV/PDWlFFO
	VJm/6sXyYJhgQxSGypK6Oe+xgeW7TD83bHH0hItTewTNNmbuFfLgX9DhYMKLiAVAaLAErqHQhDb
	p3gBIuT+SEkTxrR090qSOVJ8CWY5kFhF09jUf4+f7Bo0LY3tOcKIdxNhPsCIRAHp8llAGqnOFd6
	4WdtpfCBMhmo5Rn4lI8h2VwqL3pX4UU0ikU5dXx2f5t2FuulOlj08rHi7GBtZNpxiN/lRkCwtJw
	tNjnjVKTMm69PP+0s747DL3kuGcmwOcogyKrsbS1IWKY9OLKG4U5lbjaV43LicDIkhcL
X-Received: by 2002:a05:6820:4ccb:b0:6c9:80d8:a205 with SMTP id
 006d021491bc7-6dcf6b1c1efmr862593eaf.66.1790768057073; Wed, 30 Sep 2026
 04:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
 <20260929184900.39515-2-abdelnasserhussein11@gmail.com> <arzUmYfK6mbznNre@ashevche-desk.local>
In-Reply-To: <arzUmYfK6mbznNre@ashevche-desk.local>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Wed, 30 Sep 2026 14:34:06 +0300
X-Gm-Features: AclHuK88JiQnM2CrEgftb3pl5BF2N7zfRmcPmhGHddpC3jq8LxEOXsr2V5NPP8U
Message-ID: <CANpqX3bTpB-y2hr2UZZkZWC1+wPNz1M0HQg_h+c5SU+XdR8n_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] staging: iio: accel: adis16203: fix inclination
 naming and remove unsupported Y-axis
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com, error27@gmail.com, 
	narcisaanamaria12@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Andy

Thank you for the review.

> Read Submitting Patches about imperative mode (search for "This patch").

I will reword the commit message to  use the imperative mood in v2.

> This is a staging driver, why do we care about ABI preservations?
> Yes, ideally it would be good to have existing user space software
> continue working as before, but if this adds a confusion, better to
> rework an ABI as well.

 I will completely drop the 'X' modifier from the channel definition in v2.

Best regards,
Abdelnasser
