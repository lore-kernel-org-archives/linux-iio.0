Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8829AAF7
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769929789; cv=pass; b=Z5IMXYhsYJYVem8gNWHbvASFBGndduRkFGpL7zS4tOCYgRiM4e9UIQJ0jLzE/36GQsQG4G/96GeN1XTnxxbzQSLZMixwm2fp0WK985z7ZklAsDNNfjOvkI2cHxt6+MaNyXPneL168L+Q43ajcp6nPLSVBNqTRg32tczQwzCq6fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769929789; c=relaxed/simple;
	bh=mVleZTFVGkwhs8mQsAxLo89FsklFvp22Sy0QI4BhQvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ycgne8SbvEIswXJt6Pth9BGCVnWU4Tuxq+4jRXwQ5RW3ic+K0rS1i2PprYdDgxV6wWOs3D38dwfqZcgF0sRn1EVTcEmVH4p0tK2lNRM9wr2LCpzYDZHe2ZENFbJz/B2iDJAmVIwq38a/jVhIdI59zldz6zO4HEfL2oZBcTBfwDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/E02SDd; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/E02SDd"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc305882so2154980f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 23:09:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769929786; cv=none;
        d=google.com; s=arc-20240605;
        b=i18xoSfeDqF2UiG76ga5PcC8bSmnyciPgngwakzOd9eMCV4m52SOFsEyGePPlhAL4g
         76JL807uMC5PDWc/Hl9H98hA9ByOZ2bt97VF7d5K0Cv3XCdCGM3K2AEZSV4y315wVrGk
         fzaesuc0aTbUCquceWFkzPTIgfgs0Cc9Ze6ESSFqUe0fkEuires+/LXsHurmfNp8DHyS
         GacT+N3XRf9CaKZ5Dwx/5ROZva0/uIBYy9CgbPG06x8ono+d3tRjqnvv46wn5wjDamtP
         6ixUmFnj7Ld/OUmZXJIpL33ymupUdjADgzgGJCX+XMtdRpJjDtWaiuENZTkYDkehSHqW
         vUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mVleZTFVGkwhs8mQsAxLo89FsklFvp22Sy0QI4BhQvE=;
        fh=udXfKFM39edOLsjoLYbhn2mN3/HyJ7koWys8FUxJ69Q=;
        b=hdP0QB+RAutvF0eb59qEDnx1QJDbygEqsIApDytSVZuMnhfRLJqdneiCPTXiwFe0fX
         84zdnOemnayJxRw8LyFhiZW4c6T6ZJslYVK7sZ1PfJpjj8pzhvqcvcaneQcNCxx4F2fP
         KtgeeIbZMJcmEKYe00hL6yL5ZWhOPqwYzwNRK4amK5luzbrgu0k54KNFrNBjbHml7MjJ
         S7XPs7Ufw2QQb9svzI4fYC7yUhp0OVeLVeWaUFjQBD//i0tsgc0M7UCEWFRTmLZB4XJr
         VgZREhLyDH+GC0q2KmuG+22YcBaKDEpBkWFbMcaew4E0ZGSWhcGx7a7UWn1hJW0DxDIZ
         e2fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769929786; x=1770534586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVleZTFVGkwhs8mQsAxLo89FsklFvp22Sy0QI4BhQvE=;
        b=c/E02SDdbVDPPQi7HL8AFN3msp3RoF3Mpiv4ztFLpwmQ02C8hdg1DqCFwXPHIN1mju
         FbIv43PIv7hBATmlP/PEOYiM++UxUYMBGg+epg6xMTgnnDEn4OlkzxPBSBbCAPr3n2AQ
         WqW31xJD/0UiMYR8As70DsGvCdsLdrE9f/EX3f5HGqg2rRnJYN+1f7gGc/lIrn1/ShZv
         SsIAKiaA4fojunyTpmjg+yqt3zFLbYN4XtQ+VAWVtSx+Tg2AMKc5kPuOHQEK9oUehzsn
         JEPwI8BDMY2FrvIspNC4uXgJh5Q9/pgmQpe7GRfrrhW9nAedb7FJR92YxVk5YdU7Lux4
         RIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769929786; x=1770534586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVleZTFVGkwhs8mQsAxLo89FsklFvp22Sy0QI4BhQvE=;
        b=w538smRFcLsMFQIcZbMrQfSxKhm0r1dm/Bhg2RnL9JJktNnviKORr+luheJfaXS5vx
         lpmh8Qu/RS2rMnsKIWBHuklMiDoLPHZdfcrDbiPZOIgGNWizdvRk57ddduMdcGu4rhdj
         3eLX2HBEOCTqqUykpRb+KJfh0/8lTmbChLPfv3Je8aYPlxF2rggut7x9To7rlPdv6P1l
         PImtlbc/ZHn3I6w/9aMBT4fndFsCGDT8Qt9cGbEOKSNfo3Visqpvf41ZcHjwVnJ7k3uc
         x8y5tnXTSrTKE2lNEh0OMc1s0L/5ONpXqdjnhy5/dR1eSmHUV0OJbrz4T8ITy32PAXVd
         mPPA==
X-Forwarded-Encrypted: i=1; AJvYcCX0UgizfLKdZcBNuaQyNiAS7jI2Q41ERXPOF8sb4WpCypD/TSXCU7UlTOUi+7cQbQv+jcJLfR6F9kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxb/rii0xqxD52np/oKoEnYESdVp3L8nrWshqwd75/mim/5luJ
	5xYm0s53xwlO1PxCcJHObCCuMdudUFkzgkFUs6JbLGrOUx272oq/m5ce+Bn14EXJPKkP3pw8XaF
	Rnka6OWLAWwobysTqg0QeTqbjQ1X1cF0=
X-Gm-Gg: AZuq6aLI+tvdouVyGywA7vkOWNikqKl6Xw6pLdRExmUKd7s03o2pL96zHltKJIyN0zv
	cQ58py1tS0MyZzMW0PJX7fNpEB14q4yWR1Iku1xUO5XWQN9XJRECxcYihzCsT9i2eoq+QcwOFHz
	Si4n10Yrvqru+nFF8veboguzGXz7mCGEfvRHaqbUBTJY0pjrkNAU82tzm990XU7ltjLUM/V3xrn
	rr928cUtzVlWp+h8xCqnZpFtpfMmU3kAmwLL96GJVSCAqydDf0Sp6dLVRvLuUgvcgOy3HtQ
X-Received: by 2002:a05:6000:2310:b0:435:a594:33dd with SMTP id
 ffacd0b85a97d-435f3aafeb2mr12707085f8f.46.1769929786087; Sat, 31 Jan 2026
 23:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-9-clamor95@gmail.com>
 <fca2c04b-fe1c-4685-9c80-b0d7d37ced60@baylibre.com>
In-Reply-To: <fca2c04b-fe1c-4685-9c80-b0d7d37ced60@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Feb 2026 09:09:34 +0200
X-Gm-Features: AZwV_QgqhXC-zAPZm3FWrQrZKb00Emtx10eOBVUYX82Uyvi3NU9ESnDiArQ89Vo
Message-ID: <CAPVz0n3XPmYPWD=Yr8WXGn84M-9Onf+AHZK0ZpyQcBJJNHUCeA@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] dt-bindings: mfg: motorola-cpcap: convert to schema
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 22:07 Davi=
d Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 1/25/26 7:43 AM, Svyatoslav Ryhel wrote:
> > Convert devicetree bindings for the Motorola CPCAP MFD from TXT to YAML=
.
> > Audio codec bindings adjusted with common ports node for port@0 and
> > port@1. Added compatible for Mot board CPCAP. Other bindings remain the
> > same.
> >
>
> ...
>
> > +examples:
>
> Ah, I guess this covers all of the missing examples. The other commit
> messages should say that was the plan so we know why the examples were
> omitted in the other patches.
>

Subdevices schema state that they are part of MFD and link to the main
MFD schema. MFD device description mandates to have a complete device
example so having examples for each subdevice is redundant.
