Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F31B6527
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 05:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217484; cv=none; b=uWdv0r6V+kRwrwxR9Kvn1bSMnPVG7DlTKu2wKp+f2VBEDUkGIE56XQepkkeyeeaKsNKT2B+Xtsl4O8wLES8CSuEqc+lK5BlxbalVuEFMC73/yq6M0phZVYPFrWVZoFmDQQoPUkf5dIznb97OUSHDHWrhpoPdbIo9rh+K9r9kUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217484; c=relaxed/simple;
	bh=W6rZL+pdGHSkW1VUQLDy/28JOv4SjWY8ND02XLZ/b54=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gKjoxNGIl7nunNgGF2FAZEje8QDlwtXgoe7w/urgiDVpmAjg8BemawWh4OUtHQ4uaUM0U9gNPrqso047MhIZUZdu9FbXID0zmwRjdWiWkGC7rKkC3/7V5CcHnuM+cwtg4Yqrpo2QKtq9HLhmHsvfTRznwxdBE/4sk3aSJ+VL8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=symu1R5t; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="symu1R5t"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-479dd56d016so1099062b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 22:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778217482; x=1778822282; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APrwum3xfFopkj2EbXKDUBAUTbsa7J6W3fdDH1HbIxM=;
        b=symu1R5tsIqqcBZr6NbmaxDupM3K6axO75mQf3bgaV8cN9JLEbsjMcF3yWjOihgE6W
         Q4cbWm1OWwSMEnJRlGoi4WYljEigxT/x5sNX1/+2dFFzcWRARK/EoukTb9FScNEpQm91
         UCm9+3KtUPYj7p9LWrPDSrmSx/5qsae0Nqz1IEypPcqoEHzyCsi5roMvsnMo3/YAAYk9
         RgVoQeTRXJ9plaOmzW6xIGItZFjUoaUGrkZt2/medbCtuxcpKKqQNJvAaeKwt/c/INY7
         /SDmhiJylrxenkbloqDXsfxWzexnNthp6VpJJQCAu2iKj+3aELKwJTxDjoG+al2pznHn
         aYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778217482; x=1778822282;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APrwum3xfFopkj2EbXKDUBAUTbsa7J6W3fdDH1HbIxM=;
        b=CDFoMYwuEjwM/oJaMIxx1pS6g/jNZbnxetCuCcdgsomLgLZ+boNFO0BhEORviCo2X0
         LrwpYbGpruNRfR3Bw+jMuhtvjARPrZfoL5DRzuK9yZvUX3cRkXMeHofqTyqjxTyBbvbN
         AVYLnqbV3RTcu8ln2Flx7gJQW+h5d6eicLJvTCfm2A5ySA29lbZQnoUwcMWUXBgmLg/l
         zjpp+1NdsSxT92VXWBAOEf/v/cJkPH1mD9OMCRjbmWWhAXBCWBKyi8nYCMX2fX/WZtph
         mx35bqGvAzwwMMhN+3/LncT5RZ9nf+7LiTOvh+g5iOpRxblWxb2kWVCTCYtWvyPM0Moa
         ZUxg==
X-Forwarded-Encrypted: i=1; AFNElJ+HxbMLIzyr4qjZ2DYYnSQLJ9hKSc73GuFAKngqpfX1x9Rg2j2mv6jKYYZQakbTjMReqvwbBTNyNns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLeiCvlNWPb8UaGYmsszeULRiE411h0oE9MYYYTt/XvLDPOPrU
	FFiaG31HjTpAChZgyqJVZM7rTUtbVHRuCVi1VIabdxs7paF6O8gu6SJK
X-Gm-Gg: AeBDies6tfW0wVBfN8NGgDgtVyavqZ1PlfLf4kNtYciDWBA41BM5a7fD5lXSqrvb78R
	9AtpxmlTS/MjxOXkOKDCw8h/CAhIPR/7WBjUizIespDhkov5vd2x2g0b03SRbHAdtKCYH0E4KjA
	1PfsyfOHcxDwOuVu7tXyQrHHm2vYi9Y18z4YpmTqucxyp4mcy/7AV8q3iQ8462WQcT/adEFusvA
	lE+gph7IZ0WXYbX6j8mlCIyj9PPyz07NKg2yvXQ6MPomIIdSltNT4jgzWB9iUy6E6i/PZIU70o0
	9kMfgE5wiEzAGOJMiQjJqCllmyVM3Zw7ZfPc84MOf51/Lvc/xSUXDcxR5ZTVwk6c+LhcaUO5SfC
	Yab73eUTQEjajx5L5AAxWWrZwSvAObp2XCNDAzbRUI1AMkVDACbEhrST+ZPXHovixUvqvbN1i86
	sr/u00ZTpzsm2rMh7O+O6vRYOQnwXs9gt2NUmzs9L7Re2s5pQeLDyjMs69Xyv8E9ZiBw==
X-Received: by 2002:a05:6808:bc7:b0:479:de32:b310 with SMTP id 5614622812f47-48041e56648mr6576848b6e.0.1778217482378;
        Thu, 07 May 2026 22:18:02 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367dfb66csm522566a34.27.2026.05.07.22.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 22:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 00:18:00 -0500
Message-Id: <DID1HLASZ0VS.359G8NOYVYG0W@gmail.com>
Cc: "Guilherme Dias" <guilhermeabreu200105@usp.br>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] counter: intel-qep: Replace manual mutex logic with
 lock guards
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Joao Paulo Menezes Linaris" <jplinaris@usp.br>,
 <ilpo.jarvinen@linux.intel.com>, <wbg@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260508034057.23595-1-jplinaris@usp.br>
In-Reply-To: <20260508034057.23595-1-jplinaris@usp.br>

Hi Joao, comments inline.

On Thu May 7, 2026 at 10:40 PM CDT, Joao Paulo Menezes Linaris wrote:
> Use scoped_guard() for handling mutex lock instead of locking and
> unlocking mutex explicitly. This improves readability by eliminating
> the need for gotos and by clearly indicating mutex will be locked only
> when execution is in guard scope.
>
> Signed-off-by: Joao Paulo Menezes Linaris <jplinaris@usp.br>
> Co-developed-by: Guilherme Dias <guilhermeabreu200105@usp.br>
> Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
> ---
> v1 -> v2:
>  - fold the commit message properly
>  - replace scoped_guard() with guard()
>  - remove unnecessary comments
>

If this is the v2 then the subject should be:

[PATCH v2] counter: ...rest of subject here...

You can do this by running git format-patch -1 -v2.

> +	guard(mutex)(&qep->lock);
> +	if (qep->enabled)
> +		return -EBUSY;
> =20

Would recommend putting blank lines between guard(mutex)() and other
code, Andy usually treats the guard()()s as separate things.

>
>  	pm_runtime_get_sync(qep->dev);
>  	intel_qep_writel(qep, INTEL_QEPMAX, max);
>  	pm_runtime_put(qep->dev);
> =20
> -out:
> -	mutex_unlock(&qep->lock);
> -	return ret;
> +	return 0;
>  }
> =20
>  static int intel_qep_enable_read(struct counter_device *counter,
> @@ -226,10 +221,10 @@ static int intel_qep_enable_write(struct counter_de=
vice *counter,
>  	u32 reg;
>  	bool changed;
> =20
> -	mutex_lock(&qep->lock);
> +	guard(mutex)(&qep->lock);
>

Again (and so on and so forth).

best regards,
max

