Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DE30DD2F
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285627; cv=pass; b=Bg7t/jdcbAe+NvtV/FVJj/F8yTR4KfLlmDGA33s7pe9akMz9ToLS4lsux/IkDzVUcA0eDXC4o2qkgikkPE5Qq2AjrAusBx97EkfR2zLpIVDYP49Pz9DnrZRCV9MKZd06yW+BWzzHGVLsz/RL2X3JjP1/35/tbtre4ouLVYa3xvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285627; c=relaxed/simple;
	bh=ASawsjX7X/8urY08XtMTUeZsranJFRKht9uH7qNh/VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO+pq2gxPg6wawk0uNMd5ORbXeGJO4NegRIuWRGwpfREsGIjxjV7tkn+ou7OM3x2rnIKGIB6fo39GAgA/cWBdzeC0+cg6cKSI77KRcNWT+wg8b1Sk68ixSudT/Oi2vx8Sk8E1s20Pu0CsGLqBUwToS5pb2jYt9CvldG72XQ4e6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2EKBatB; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2EKBatB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43eada6d900so9911707f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 03:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777285625; cv=none;
        d=google.com; s=arc-20240605;
        b=ENKOMy1FKwreeGljguSY27hWc4gEKwlKBBJvym9VexJ1eGvqG2QWLQLAUZtvY1BE3f
         JfxEiFNacdFde799WmTdsUYa21AJ8flfOGbBkqstmccb7Kj0c5k6nmzoly2aZn0TmF+a
         mnJtu4IRFwUlNmKJEXKSMtWm9tDy+7cWoDJNnA2evfWkziw23YOIoMBru/rFSr86ZPXj
         TAz7j5LMxlIil19RKiUyN7ljvlVMjDG+gSIYaH7iECx7babZGwFHOyUPaPTNr7Ysn+H8
         Nil+pocQNC2ikdTZnhEILTxi9xDdks92NXG8lP/DE7oaUMaNLg8ATlPRUSTZxpp8od9H
         HoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yy9TpvF4dvMsti6vWTJtuN6n13VJmg3/jzu0qnThAws=;
        fh=XIwCSbGA+3mLI4AfdJcsoaalt8ceZc188pnzFZUiSjs=;
        b=SQ/8Gi9ed6zIspnTsJRrBx8aLpugx07yA6tfMDFH5UbmciIKUsgW8OUuvMCsgyC3DR
         3TAGPQRywAJ9342F3qo9iMQPmYqiIHSvs3ogoE7WL4xmtbTKh34S4vrZNNPPyI08t2kw
         bHzAP+p6qp/hP3iqP1COl+VfASKm50Exb0SA4WnfVsLCnhq9BTgiSBYtqpuGub1n+BJW
         8z5Of9G56oI3feJLWOrX0ryyl+SUNNE888ms9BI5hyoIs5OVOonoS/18kftDT6xo3rPO
         1Y+ISwWuEkT7HUv4Kx0P/A032IQHALEkFVdGrJZpR8p/vaxmPWJY86VegM5+w3vXPvq+
         AgXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777285625; x=1777890425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yy9TpvF4dvMsti6vWTJtuN6n13VJmg3/jzu0qnThAws=;
        b=G2EKBatBs3pje3wFYrfwpv5cpj7I4tdZg9+6JxY8DbWNM5Sw9WWETwpkWPLqPZV8lP
         IRpkZ+smWAn3pvCG/VDYur2DBlj3m5tkwg4oJ2WhUQcR6KEVuehpMerXgrIjRjuFJAvG
         mvnmyo5K+6IU3CUgysj0J/RFNq8vjlrpYsUM8d8hfoL5srQksjKbTERONU+VZqQlwHUJ
         ddUt4lkabcYs5PJsdlykgDu1TqsyM39w+1iI5FdSYVDqiH3XAKAMpJ7dbIOktXJh3RpW
         PvVjRwezgESHjmeQprYA5C0xzLV+WtguqAfxxDXxLLaXQrAU79wjIqd+a4jR7gSkKOku
         Psrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777285625; x=1777890425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy9TpvF4dvMsti6vWTJtuN6n13VJmg3/jzu0qnThAws=;
        b=lQcnvtJRZVDj5Bo7hvlMh+YKNK5RHzakgBNXa4OAkr/osEa6PNvhswBqfrlpYr6gOO
         MdIXE8V11sv1BpVJz6rA8Q9lLJlFCLAP6UL+1XvBgA8msyt1+RZFjuLUcbOVJ+ElwcyA
         YyQG/qVKGc1AbvJlJRp/57hWMKjg0T7TTLSD77liFMwQHYKqrkTv3umcvgXxChONyGK1
         tkzA2wOBK0uaUzRgjWr5ZoHTHeHE6kn39i75ijv1d+e/cuRP8SL5lzKpQt8YSP5puqbp
         F1/ibRhp3rmbWqJp1mZFjSK5sdH9hti9td450+KAm7wHlfMfknY4JHk1vY2D/8aPtRZU
         clhg==
X-Forwarded-Encrypted: i=1; AFNElJ/Gsj7pSKTG+B948WthvCwFnr2dWru1Chz/RgPJhBhhbtvSi4AZOhBzn4ZrnaH5Qh5MnI42hD1/KSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoTpoCz90AqGWsM2PfafEmeqYsgEqQLHTewUu7ZmzsNcZCVAf
	aEtjJSk8Xvzb2eoqZV5YEKIH+RjP1NaO5qp+xXHIGj2DNlACH1MmUeMO+VjBZ8XOK3R9SdUhKba
	xDf01oqI5rmsGZb0TaQ+giMyuR/Gln0Q=
X-Gm-Gg: AeBDiet+MpeHK5ANcHQami/nkhBSgCS4Lf2wso9Uqq+/65UfMS0tTcocVxL801g7XOd
	xNSWtu7vUeCpAd7Bmb1yfd0Zjg0A1CAUc2fFe6koVN6u5O57Ea2gAK+Oehcs8oWcoYvIpRhrjd3
	HvdJO7zxwpYHn3DPFYn1bA/bSmCqSwVQiD1zqfx/NULarvTb3PTSdmN183zAngXMG9voj+S4EWa
	hkCestc248MKFNCLTmFYEEqoqvifgkfShOrO3EMwywajiIDFcSYiwbghuU5cWLujJUPzz2Aplbd
	cDGUaeEGmz43DSBVbU/Zf9osGxApY0UIL9cFlw3PSA7A3tPKFNo4G3zMRO4ymiDbtcTNUReWZdQ
	xtEXTuGJkrygcHHCh9xtc04HJTlRMPjmnQDaCB48ckiD1hZa3RCCOddLP9O6h5dP6KF2JJTtyPz
	7fivzIl23ZcOW5saUe
X-Received: by 2002:a5d:64e4:0:b0:43c:f7e5:817a with SMTP id
 ffacd0b85a97d-43fe3dd4b72mr64580748f8f.19.1777285624674; Mon, 27 Apr 2026
 03:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427100950.33936-1-piyushpatle228@gmail.com> <20260427100950.33936-4-piyushpatle228@gmail.com>
In-Reply-To: <20260427100950.33936-4-piyushpatle228@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 27 Apr 2026 12:26:53 +0200
X-Gm-Features: AVHnY4KLhM9LmRw6U_pxzl6g17NRKK7HGlQhT2QlACTV2zSAWMDHtjGAu-A9zqo
Message-ID: <CALoEA-wAUpZ7_2_3kB33mNB_Y_DAc_p7QwPR9a5pxL1iET_cdw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] iio: adc: hx711: update Kconfig, module
 description and file header
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:23, Piyush Patle <piyushpatle228@gmail.com> wrote:
> +         which are used for bridge sensors such as weigh cells.

Typo here.

-- 
Kind regards

CJD
