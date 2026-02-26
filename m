Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C32DC34E
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114721; cv=pass; b=DyuTe3p5+vguZAvvMYcyRlMLlUABZtWWTi0zr7WHxE2eklwipq+E2mcftv65Tuaj3dHimSn1SHv/9yyZB1wnZVOgGIKzDNin/gJE6dSHedGC0fDf1EnVtr8Bxp04tMsHRyUtJmJ6C8Em4FLqN0Y/9TarRBdA1M52jhMabsVRhLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114721; c=relaxed/simple;
	bh=f4/09Baeh2GGcEIKb3u/quw0y5qNtvQTbmxH4VSdrNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrbwfOJW1oK0hkojRVZnxUVFLShgoGDdCWUbrdvvD8oHA64mZcS1i4hRbUwfQgUV/cquKU+Vc4k2W3Y+3BZjYM5pGxvTtkalZKItK+qe0g+yzJWFEgXj4R/VypEnazajYwHUjkryE0mk2hzo1EleCS/EXe4RQ7szBlUl4hPsLSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8pydEsx; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8pydEsx"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64caae0eb68so86466d50.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 06:05:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772114719; cv=none;
        d=google.com; s=arc-20240605;
        b=CfwNobgM6flj/vhSJ4U7cPmfSkFbVR9HmCU4Ma4mSJ7gAFOvqQpwmgQA2ZYkANn82l
         fJ+joOzcCiub2yGbLAr9z7LASUj/Hzz/hLMRPj5hZ1GHofvAbiPhbd0kTQBPthS446sj
         q73BXik80mk/Byc5COo3BLU7nIHfMMAJsCSKzJbUQWXSraAqov8fzd5dRRa6qJ5gOQtT
         5sviQgWItf9a75RUlP0i04dMx+3qOb5qmssy4bRVug/qOcd4Bm4z7AiaFbuaQKtFkrOF
         rwtPXYk6xmB7zD0Gup1Hp+jLefGOwfNAoW9nnyjUM3Jo7Xw6/QVYI3pOeVBpp/3ij4L4
         BLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4/09Baeh2GGcEIKb3u/quw0y5qNtvQTbmxH4VSdrNc=;
        fh=O6mTQ56acCbMTzaG5cFYHUV7PY7enJjBHP3pJBKviz4=;
        b=gkK3iUxr0Ymae2QUYgk8m/be2SVAWi6vxk3iPTYsiE0Otp94rFEuNAPDKhMWzoPPcU
         WKrQ2xHkAUOC1qrVh974TSSg/53Z6D4UqVckMDghqBEQ2hZlJ8AgDSEMJB4xVU+rtR/7
         kO9lFPhigkIS1clCzFbsiNYLQ66Ud/uQSFIX5oizIl8vpdWnBQfCHyR0EcmIeUmspLxc
         aa7Osnw6z9Cgs0e77kUFpobpsrwMPSV2TnbdARbNsv5WMzVpGsux+fPUUGIct/l1QMuV
         WAY3B3NepBiVXXXpl/Cx+8tGdBEICr4L/xwiy7UtSjGnM+qGOZbp7UksxK6VuEoCKpSr
         K+vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772114719; x=1772719519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4/09Baeh2GGcEIKb3u/quw0y5qNtvQTbmxH4VSdrNc=;
        b=J8pydEsxqRF3YxRCLK6RXNl1Gjr3CR35LGYs1P3wtLHNmfEnbK6yeBkBTZ17n2MF4/
         ZtzsUKHJMEwf2ViSKGTF00wgHt5d6m9GcO0Elld7AX5Pe5QI0qa1kYmzdqdbqy+w7ODr
         +vdUpN3eDw1GMQLvCFMDqwaykuresxFVy4rqKRVZ2vuLwz3w3w5HgcSzGkUtEjdy97Gy
         EMjOB+5Lo69GODMLjBJxhW99GERQwhWfcsbnqddU+e/QIKXXldCkR4GhvEd2JRRwsbJK
         CFmCEAT1TAZZL7JB6S9hsyT/UQsF4D6JDiM2U5crinAS4sh9sPnizJrLIFEY4zug1TU6
         oOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114719; x=1772719519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4/09Baeh2GGcEIKb3u/quw0y5qNtvQTbmxH4VSdrNc=;
        b=widKc8fvFCYLAhkXECsHBjkws9hklAJNrI3/wfQXFtKwpEc5KazgkZmFtKtWVAhqLo
         +MGpMdP7KeqWEgKSZ8Q6JBWbWCUifuz22bYSjX/mQ951lQcBJl2/jc85mUaCtnRliwyP
         zDrJQEb2iGCYIEkDY4WIXG78zCi6isLApcbj+d+mNUlnrAaFBntLK3p+F1ic7u9pMbVc
         WEYTHPJs5rKWV91nhNKdRfWapw5jziJAKbdohAGkdufRD4qeInP/lQB1A5tzUPNXuUKb
         5RJhFIpQJtm+eT0pTeWl94jg4ssYEVKxVQcQqRYSFfQF5v5E3dFoa8SPHwpcquM3AgK5
         bDKw==
X-Forwarded-Encrypted: i=1; AJvYcCUSoSa123D3wqEAlFcpFQfefPtYmQ5h1lxEX6yuM1u67s4U8YNGPvT87Nq5cTLcVe4sAK+Nn63T+78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDOovIA/BbCBu//0lF6xVPO8cslPV3zRvSNxp7uhewNnJRGKS
	BrIs3//kW6mSlqgKfkcB2nH4YYtY4wzcYqOjW6tTPYgyqs/FwKKVK70/cu6HNjx0lhVMwnto44B
	NjBOS4ipOKdCdvZ4pjacW/QlGPWTy1ps=
X-Gm-Gg: ATEYQzwRMpNsKETM9LcUQkDEIwMUlR1DoOYnvm9Czc4hBuFfMh4NFpyJYRQP6W5Zxpx
	VdPvX2WMaM6W8wS6D8X22/4mPxSDDqwIvF9nr+bKZYrWMjvnAjcmld7FTsCx8mlfWYMI0lJmPoo
	MK0YvNayFEg4lCvdp/3mRN8R8xYRNelNDt74kiHNlernZqT6dbWquX1zDyPVY4JuAxpNEQGryon
	BY7D4mhOOxHjpg3X7MWLFhWxl1k907SGrCK+EO9Uz8yxM2Q0tjUwRrxrXQFCSzAjioAi/UE1LWK
	dQ7+SAu1rKobTTIKzZzcAQT71V/TI0aJPxnVjaoptfzyHAOJ6vWiAmhu2fGgdNMnK3+a5f2lNP1
	JDFzsBjdjPt/KKYa5QQtLHg==
X-Received: by 2002:a05:690e:1c0b:b0:64c:a761:7f72 with SMTP id
 956f58d0204a3-64ca7618104mr4666851d50.5.1772114719018; Thu, 26 Feb 2026
 06:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226133741.437403-2-giorgitchankvetadze1997@gmail.com> <aaBOJWYk5xvLo2FB@smile.fi.intel.com>
In-Reply-To: <aaBOJWYk5xvLo2FB@smile.fi.intel.com>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Thu, 26 Feb 2026 18:05:08 +0400
X-Gm-Features: AaiRm51Mkobb-wUHHqDqcS5x_A2x0Hu22eMahNXnKvNso6O9mjow3bXi93CiSvE
Message-ID: <CAE7dp2qvzGx-W-Ci1ertssSC=N1FrgaZiZ2GWEqDQy_1TcrYDg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ade9000: fix wrong register in CALIBBIAS case
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 5:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Sounds like a good fix, but:
> - needs a Fixes tag
> - needs a reference to datasheet section / table / et cetera to prove the=
 point

Added both in v2.

> Also, how did you found this? Code inspection? Testing on real HW?

Code inspection. Unfortunately, I do not have a real hardware yet
