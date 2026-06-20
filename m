Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84D227BB5
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781980703; cv=pass; b=sbAglN5a59UBp/UemwZcdSVkur615IHi7BTebDdBCYUoGqZD0Mpb3Aqz9NHwtSSeJ4CIaVSYBw+4np0eazWGXJhwBSF+5GrXHHOmRDvKB6JwXu3P11Sdhz6kmptAqnp8eT77e53KoYSDPYTYuzVi7hG78m8NHgZs2lnF5fUlFYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781980703; c=relaxed/simple;
	bh=Aa9P/Mi41OD3Kc2puae9QfPotZPZLSNTcSaoGs68Ang=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mREIFUrfQxBkG/Y2jG8WwdhZ1OyJL1dkLxsvNdOWD1jw4Vh7WS51TvcN2CLw3jtEKGLZAzGq9lpdg+vPK7p7bGM+c1nFsc1YSpHZ16jic172gpgKMZ74Sr8+0v9kNDHAOcU3pS8o4ZzMEzwxptjHUY+yQ/l/GShKgmQC/Mu8mOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6uSUQNE; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6uSUQNE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf125989f2so19147095ad.3
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 11:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781980702; cv=none;
        d=google.com; s=arc-20240605;
        b=XKCpoxZO2UDU7PFaH3u2ouhwdT8hPna6xZU7NE5YQQQf5Qg0t41gtavWHyTTMkFIb6
         atO1I+PoLRMqADp6uyLtwUbm21/MZfaeSmQctIpEWP0lBO9TUfD80xashdoR23+nZTNb
         fhWElNmmeMhVWs7gJuY2/GHrz2gO2502KZwSzx50qt/ruRD8EU+ivZvsFRGerc2bnlrA
         a0xF643z90YIUv5VXdpiTr82EKlcXsSrLysM6CeENlJd6PDBqYaqHPaLefTxxA937W/x
         6yN15bFrhGEeCzHJ/wSe+HljQqnK3TZFbK0nOJJjTZIqUS7Cbe69doGMLYCG/v4Sm5wm
         2TGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Aa9P/Mi41OD3Kc2puae9QfPotZPZLSNTcSaoGs68Ang=;
        fh=wvisCRc09bqtyzQR5oV/AYzO55zOYMhA5o4Wt1YkqL0=;
        b=LZUT3V3QSTHtm4slLigf40H/Xhdmw6V9pnR9XKRulyH7eaWRHaw6/UIj8gotxVuCiy
         0wKuMagkd6a0DprOYk2YTUc2KlYQEqXWjwdRzqPhEChfmR9/XePXBIS9pppYB/LG3NeK
         0lU/zpxL+zTP+i6SEFArNTIn9c6liT0dC2y7xgVmeH2Pg7QmzYuEtkmgmqtrSeLqz8hx
         /mZ1fFnju7W17u1rc6CLKaAHKpSRcvuCQzujEREk8ch0abE2kt9RVZU54fucQJJ0drx0
         xCfzOe4NQIFT+uUu1eo5r0a72PjBQq8jpf4xYBh9eZm+efqEnsD+WZoSkMjPMD/lSP8f
         zzpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781980702; x=1782585502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa9P/Mi41OD3Kc2puae9QfPotZPZLSNTcSaoGs68Ang=;
        b=W6uSUQNEncvPBsnoagqtqZDCPPoUtHAmiiIMp60HKJKSStm6mpwRdus5IJISYJCGW3
         AZKnvf0WOzWXHBXMSU8BOcxVHbFuR+FPySF7LtmkIKBWJ2XlC1bNznBkIlaB26zV8ALq
         evy9FcB/Ujl1Y4PuaMZnJWeaL8zPbrRUcuCEmc+G1FdgRucenC0HB2odrExqHQ9K0j7l
         Jzi5EUtNIJFcbBpHEMH1sLSWN7F0MOb+Og6FvzTqCK0FuthBpnV8eAAn9Cn2WCdzyzh2
         GCaCXsjOrzFszdN2WcMUElv3KNPMn18zoCFlX/37ZsJ1tTcNtCKoM/n/VCoS6a+L1uT6
         oviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781980702; x=1782585502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa9P/Mi41OD3Kc2puae9QfPotZPZLSNTcSaoGs68Ang=;
        b=LThQBJbSb7wfe3oRLZpOdQIAg0MQ82i3YFSi0RkfnRtMbeLLhS5Cgh/VO1CPdlj75v
         M7jNiiIBXpH2rvozmqgJMokE5QKG/c4P+qc8hsMGGOSuyUAxIBc3fKzDbUr4Od9zslWv
         NXyA/SFQIwbjj1nSdpqc0ue9fD5vuPIlnQqqW35gYZi9W9SuRrS+K3Z+UNW//rfCWnt9
         DUNjt11fmHUrLoKCoeQNPF40ok0P8sUqueFYGRpscb40D2vi5F5Nj8GI1qTPx6fmp3f3
         3Zu6m5b/FPkPh+LyO7/yW1IMs18XJnLIAdITk6AkPGyBnvEwYnYt/e84pqE/QBbgHhzu
         hf3g==
X-Gm-Message-State: AOJu0YyzG3pdVV/ES90xXylHZgZdA7V71iyQml+nUWEql8tgAp06Hrjg
	qOmuzA+GzG6tir0562lGvYsg9Qlj366tjd8g1F0ppzq1ERxNyGpj10XLfWvQsGOEoBAy9G9cqvm
	BcrOc2xpw7xzpRPPIoQIbDIEqADMyfKVb5aUA
X-Gm-Gg: AfdE7ckV3n1sFSyYf6CJp4RBeyr6DU2mAq4rxfVQ3IL4xoQwE1HMdmiLJsatX9RpBZ3
	RO26mQYQzIB9AdrSi+JPHsL6E5P2hEBEfYBOKJbPLdZW/Ka3iQlybmYfOJrOqz+KkhQIYNvRUja
	aXRLKdataSRNwgAFCZvpycdx7FWXcSX5okMO7F+8ghx3SzC9qEdFT1zLMvCvcEAfdlkeXKVBdSu
	Lje6O50S2/ArWbxfzi/xqlRSU+QyCrOsC+ghiqzhB2bQsrGeb3OSusSPaZ1OiF9uVEYiO/c7hB6
	+hpbbavGLiHffB/bu9yvzRAKWAsGoeI=
X-Received: by 2002:a17:902:ccd0:b0:2c2:bd05:dac5 with SMTP id
 d9443c01a7336-2c718f1da13mr85666705ad.19.1781980701844; Sat, 20 Jun 2026
 11:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
 <20260613190957.654798-4-jakubszczudlo40@gmail.com> <a0e19dd9-c2de-489f-a727-dbc42e5b36da@baylibre.com>
In-Reply-To: <a0e19dd9-c2de-489f-a727-dbc42e5b36da@baylibre.com>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Sat, 20 Jun 2026 20:38:09 +0200
X-Gm-Features: AVVi8CcwN3JA29B8Cxd1bF8JqRYySlAWpmR-3qka3_VEtMqSg_tSpJ1FT3_uzkE
Message-ID: <CA+gq5Jhv_ZvESipg2AtRSN9ov3ALbOnUZ9yhJeM=2xBp7TtxBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, duje@dujemihanovic.xyz, 
	jic23@kernel.org, jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com, 
	krzk+dt@kernel.org, linusw@kernel.org, linux-kernel@vger.kernel.org, 
	marcelo.schmitt@analog.com, mazziesaccount@gmail.com, mike.looijmans@topic.nl, 
	nuno.sa@analog.com, robh@kernel.org, sakari.ailus@linux.intel.com, 
	wens@kernel.org, joshua.crofts1@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> On 6/13/26 2:09 PM, Jakub Szczudlo wrote:
> > When device is suspended and it is in single mode then changing
> > datarate doesn't make it actual wait for new measurement, so to
>
> s/actual/actually/
>
> > be sure that read after change is correct functions that changes
> > datarate and gain will wait for new data.
>
> s/datarate/data rate/g
>
Thanks for that I will correct it in next patch

>
> The commit message isn't very clear to me. Is the point that the
> changes don't actually take effect in the ADC until a conversion
> is done?

When changes are done when ADC is in single mode the first read
after change are still with old settings that are not desired.

My change make it wait for new conversion with new setting so reading
will be correct
