Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27A1AB6F1
	for <linux-iio@vger.kernel.org>; Sat, 24 Jan 2026 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769273779; cv=pass; b=gqcwiO6/5m8T8e1QjP+r86o6ncpPQYnA3OlbO2nKYodw01XEDpsAA3X3yFag/h7Sbv5T7qslXJu+Pz0UlKMSms8+kYDfPtzRX1TFaJvJksYnk0bwokM8NmhUrYke54+5Us8pLGs0UmoKYOlRzFpHCazBCU6Eas+u2lK5QXmdR3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769273779; c=relaxed/simple;
	bh=nngxUqRFcmb+PaCYme9ss53MQLQbq9LdKlsZgz3OuBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GccB09g7ZtaatDpz+/Y46eyqrxnx0xTQXGFvVRl3CM2F6SdjYEviqOiSeQEPtsn5MdbYbEQ3fhoF7IhIu302NT5t8KDzJ0pBjSaqGwFWDsXXMBpRZ8WQOP+YQEyRnEqBYWZe/Q3Ci5aGL8ntEyn3aRwj6fP4GuMfLMf1NlcTtKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpDIehb1; arc=pass smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpDIehb1"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so407903066b.2
        for <linux-iio@vger.kernel.org>; Sat, 24 Jan 2026 08:56:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769273776; cv=none;
        d=google.com; s=arc-20240605;
        b=OVXaskNNUW/+p1tBTliHv+pFRB5Fm4V35BSZ8qDn0nqd6d5IwBGr2I4yPjXlWC3OBj
         +QfxU25jj6ccy4Awm2I2wWbaz55kbrTPRKsO0MSM2/nuPgBgu0lfL8yhlQiW8qVBkTm/
         GQ+WUuB1WLqmfIz3W0B3jFCw/y+fDDSD9UM3Cu99U2H1W9iJbn+GSo+Tt0I9Jo9pm4YD
         Pv5N77yj7lPFyfDzezU25hgeCHtBLICN3D0VN11qt0xmN70JHCiUH+BgGFYTXZERtOov
         aa8YPbNh58PuokqGHzS4QKyVPwzKBA0AGdrWT/Up/CNhyVqyByF4s+DkiE3/wW7mR/e0
         HAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KZpvGDkcl1DgYAfVYgQMcbiMSJ/Yorek6nrxD3kJFJc=;
        fh=3f0js+XK2ZpRwAZDnC85lAbi68pCI4cpEhE3728+REU=;
        b=Xm447SsBHKxAxfYS9HIjYD54LoL/iEQNT2XKuna+uPNq16NKJx8GJc0lAJFQ+UCnY6
         qt8MBdQyN00umxwW/x7Yr6SMXFrTh77A1OBrj6V2NnAIOAJqbF2Dm2zYGICEEcArNtiZ
         LIHdu+Qa9xgrQLKyM/p6RdN6+GwsDzyUiY5aHYwbmYEjYrAmqWgnsq+HddjzGVxh4Ah4
         7w1ssOgMNmr/0zB+MbeguF1Xnm+e8CGfPz5gIQ39LZt2clnGuecAW+L7Oju8CiRiMTVl
         QUwzXeTlfk6ZJUB+xDmbmd0394yWsp3AMDR5h1xzY1779cQ9WX3z1x90vJQoI2OexM1s
         1Wmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769273776; x=1769878576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KZpvGDkcl1DgYAfVYgQMcbiMSJ/Yorek6nrxD3kJFJc=;
        b=VpDIehb1kCy9VB+ycNkkJYX/9K/H2hCYIsG67De6/t1p9skc1hWAol/t2q1zbQRWzy
         9Q/DWD+DJ+clyWUxNSq6exQ7vmdrxX2J+4YtubXyld4NMg3FLMinY6IyB1UPkbva2yel
         Crd+kM7jkhRZmtHjhCotJqblAEaOBAqzuzv/EAmoFaceB8+Dre9D0FKsAUqyNbBG1h0Z
         pQxHEftWBZDsmi5UGOOSvSGkBKWXrSVM+1KpdDMYpntGDanQRp71tgCpjRe5TFjnXGqx
         IN5RLLcWOsYVsEak3M5AK8VlGVgrEcMpL/GJgtwqNOSguSVfWkHcBZtx2ajLYMXFjlyQ
         deJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769273776; x=1769878576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZpvGDkcl1DgYAfVYgQMcbiMSJ/Yorek6nrxD3kJFJc=;
        b=ilHTFE/v7HW25O/11yQUoZkkc2ZBquQbQYZ5Txnb8t92CPyVPQlSvPaBiSLRS+1YXy
         GDD1BRenaq5DluetI9hwUqQUxOvJo+naiNrYzH5wUJOHQ6DSamAmvwvc4led3D1QEmZs
         ELw+XDlKFR5DqALL0WKfzJUsZy34xwTxdjJOiC6Uh22eQThZjl2EfaAZGojb29sZ+ith
         S0k2+S2SVhAEIiKaorVnORL4NAuYRMpOGnHX1Y8AaiTQcblUSr9jdbQkns1ED19YBxzp
         3HXrvydovTgxW8sOMH6FRDGuI+xVpGNFUUsNItnwqWgzmp/9kJFn3+cAaK71viE+u8OZ
         iNgg==
X-Forwarded-Encrypted: i=1; AJvYcCUqOUjbh0u9fpU2BF2loCTXLChf72X0ZORQIFfp16iGSrEDYflAeZvUpKMV7q4b3KZqkgUty+I1X1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBoa6DYe5V696nTyAK95nwaFunDYAFwMXCk+UGAzll3huA6WQO
	Q716wrAVBkx5T33rWvnjZsOdJQ7012ufS2Lm5O/fC2zmK4IeXCOxCoqsO0cE95c6Rbx07orRcIi
	KyeJlRZWMkOBDEt4fr7HXtl2e9IfO+Ys=
X-Gm-Gg: AZuq6aLv3fOHhJt+N8QDskIDp9yx9POZKKDNsrzpqhRN0TQS421tCjA9NFKO6t7iHvj
	7c6/d1gja5NEXQXFEH3/5TJEI4MHk0tn4vD5oyQ4x0/tSGZLfib8O/UoVy3GzWV2t6OlGSBcTB/
	yvNOWUYJivJpJUuyNKAFMhBnZiy5u0F+g65mKOfaPDCoLFXg3FJyocxZjXZjZFzExpy0Of1do21
	HEO5nIVgYaTCHnT8oEOfNiV5N101XDP8fwHQxd7M3SoS/hnzbk/qYnWJXgCn6YA0If5diSVIQhc
	X/Op/w==
X-Received: by 2002:a17:906:ef04:b0:b83:37eb:34f8 with SMTP id
 a640c23a62f3a-b885ae11011mr460485766b.35.1769273775891; Sat, 24 Jan 2026
 08:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-2-5b944d0605dd@gmail.com> <aXCWz6O2CdU_Sp8r@smile.fi.intel.com>
In-Reply-To: <aXCWz6O2CdU_Sp8r@smile.fi.intel.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sat, 24 Jan 2026 22:26:04 +0530
X-Gm-Features: AZwV_QjAq7IK3pArFOJQgcpOOCZzeFXqetm3twDJeg8XCCBWYDIP9QttPFf8Xfg
Message-ID: <CAHc1_P5hY6-z5s0J4SW_2GMER+NP4NsqoVVVaYFUg_gRi=31JQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] iio: proximity: rfd77402: Use kernel helper for
 result polling
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> > +                              10 * USEC_PER_MSEC,
> > +                              10 * 10 * USEC_PER_MSEC,
>
> This makes sleeps shorter by 2. Why?
I have considered the timeout values from the RFD77402 datasheet.
The timeout values mentioned in section 3.1.1 Single Measure are as below:
1. Every Status Check = 10ms
2. Whole Flow = 100 ms

Regards,
Shrikant
