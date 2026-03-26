Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E82D739C
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512387; cv=pass; b=kElyDbGbFVVMQt+BxaTt6EpRzJJVYVQ/7029sJLmjsimDg767JYy/WoJJ9jR3XpYKqteD2J2bQY9NWsnlm+wG88mNRWXGruaYKap0GadTEPcmCvaV9u0IgilHTruy3BZzKH6kwjvP1vAvQ/TTiWp9BFsr9ZPGcB8QPgTaF4rmxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512387; c=relaxed/simple;
	bh=niHdZBDZHf260XUrpN+ksmslfOR5jMQbmSuF20pOdwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMGu36HIeZiEXC3pOwzG8zID6Z4Tc2O2QxQwnq21UYB2p1nFFj2RnDYc5T+HLPmMy3GvYgHpkb0QjUryGsysEXja7NWJ3Ue3bl90KahA74gGzxkRj5grn/lw/qX92HExPnff3F5/uV+mQhS/sLmDRNqiCelPbwxLTLEUgRXOaMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGFykcuU; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGFykcuU"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64edd93b666so96616d50.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 01:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774512385; cv=none;
        d=google.com; s=arc-20240605;
        b=gI+ZSImInoEmMFaGKGCEnXPLb5M7HkDQ+GoHVUZnRLAXVktqJWef4FmIX6uwuR3HLN
         sE8ewC3scs4PQcQwLb9R1eC7AJ4q7r7DL1It4p2LSyG9FSB591MNduO4AlKMlujLBaZr
         paFx+LTyTTIyUnJh9kL3oYKLo6feYTP0/5vryjGDpJooMbG78IZa5PotGCKvsvjTWEKi
         odhbuj0kui6ypD/mwLP/bgLLZGPrQG1Oz9j+maIx0TYv1Nfah+gr0Gw5SCjEFacx+dGZ
         yn8s/ilEr+DMnom3R8VOUIp9+o7BdTzwzTOai619VXZaXOcR/BsF5upHmMLMxllb+IQG
         B8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fWew/LjRP91jOIcD/djXr4fha9G8WSJ4dJEexRtFGdA=;
        fh=yEEa2Vg9areMoUe7adNX5YL5apxTqg4U00oEmWsAVCs=;
        b=hTlrHRvKbPR6T7MEwvsLoZ614veJ0rDo0vyMoZ62N2swqvLrKeW3IeI2TAbSD+KCyv
         qwrShHW/liseDaUQvi8Qxi8QvBh3WpEkHua8/WCX4p0GJCnJypXK3UttJDXLAj1Ol9Sq
         a9dNXwPaav638gP6DpkI5HDvgJMZpl2JpNXOH6grXInxgaNo5l3YmnGadAXwbQZVUqhW
         a47pmh1BacqZuUDDc68hrftQPLrJTa6slzyxkgK4dwGy+ztnIh46B/r7due292kpDQjn
         KigE94aHuAI7zi3qNFBfN6ssbPNMT3Nsqq/3WDeygdFtJ5yytoNmGJGbUp/Vy/KPREhS
         3fvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774512385; x=1775117185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWew/LjRP91jOIcD/djXr4fha9G8WSJ4dJEexRtFGdA=;
        b=GGFykcuU6V2E+y212/ZR1wt2R1+PGHJHPgmMa/yZ3Hskk2oDhfX2343Lj8sY9uYMxB
         AvdAYP5slsCT+o61ESzdHaR62zjPDQLgVjXHppNcoplOU16W6tqL9tDMbeFu3MSihHnr
         dLYMgdAA8KCn1JyC3/HrHNarOF8XxseIKv9Nnsol6E+2d/aIY2SLV4hbEYC31g2K29/t
         6nqNoB+LUY4Ey5anmJJRJS2PdnVAoTbodDB7k1mJTjVmfSJD8xTDVp/TAoC1j2hxyT/H
         incGXdRL6TMXL0F9dg64G9yWCoi2kSQbQbVJlc/WcdIdRaNsxJm9+IqP/QdqB1+n7pf4
         HByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512385; x=1775117185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWew/LjRP91jOIcD/djXr4fha9G8WSJ4dJEexRtFGdA=;
        b=EZpKYtGE7EedRMohFXhlG9d6nkVIn8IYvgXnfPjOju6yDtuMnbKd0rL8aXeH9fOkMn
         1GAGpsbAFMSLVcRG2yCu+0Td3vABROy3RWR4hNSoyS5LFY6tx2nDO7cS55puQz8T9qCi
         XI30Vr0ihqO8FRSsIxpp7KRI9bgYBzSsvQPdK8tGyNmy+wqcaJSR26FaouTiZDtmMcHT
         Wwabl3f8eu46VPrzBv2Wq2cCG0+l8fce51gzvRrLv4grLgFhdfcAPYv5hyKgVCwGph7r
         ZkX7RhKKV9a40gU76a/9cu72ByQAbxXZbrnZOj7c7Uv2kKEIPtTEFNpieaBQhtndqpzQ
         sOcw==
X-Forwarded-Encrypted: i=1; AJvYcCXvDuUDZ/RYMQLG7saZHVvPTYwbhh0hJpgtDaJleTd0b0BpVxcw+HdFH9/Ll5280AW2w58otcrN+E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXk5pNLjN3ZEfpHmrvtyFv9rrt7igx9+QpDZiHPtQ/jUFIrGy4
	vLE580SgZYx0uL0DGo0s9Ks4LpSZv+GFO53AmamfhwkJ5dqdKy8m6EuxT7/tGFJIQ42A/BKgI0M
	AZPZDCsuZL1v1X9NCupHlmvQzwdCAac0=
X-Gm-Gg: ATEYQzxWc10zzZS7m7u3EX7vZSMODzhgX/4AtMiWuIVKArNBh2b54VfUV8QMDyIHiez
	sOaKk8Vj8LoYcVJjp9/3otBrh5jtaybY5EumMBeR5kzH0EqqZZPs7tBjZQrMTA44K/16pjpGkK4
	s1G0XG+E0faY9UAxuDlqk7fkv8jUR1hjX3yOs1ePZjYmSPXf+n8mAidBuM/KwCozM1KARH4e0kf
	PPAMnVZivdcZxNwTgvD2Es0S/kb9z7vROHoUQuKaHWqxhyStQTO5cHLJsv+8RQMJkiDsoHMGlSm
	9bFHBKCipSbsZlMHk+d2rvsa726myGKq4vNbel2bwNpTGEOSRdysDqs2ZD/lKyuS4RoEHmTI5YU
	9mcHzO6iIEsDoUTZw2MykaYNSYhmCfwDA
X-Received: by 2002:a05:690e:bc7:b0:64e:d610:71d5 with SMTP id
 956f58d0204a3-64ee612796amr4996321d50.3.1774512384949; Thu, 26 Mar 2026
 01:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314111250.223788-4-giorgitchankvetadze1997@gmail.com>
 <abfVKws8hF4bUbv5@ashevche-desk.local> <20260321210833.7268a3b1@jic23-huawei>
 <CAE7dp2qUM3Sza1endobT44VqAdwoBFqXb77MAfaFK1h8tJkOGQ@mail.gmail.com> <20260325204039.582cce84@jic23-huawei>
In-Reply-To: <20260325204039.582cce84@jic23-huawei>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Thu, 26 Mar 2026 12:06:13 +0400
X-Gm-Features: AaiRm53m0Cczm5RhyAaZ696vy472NTSHAmsnrR8zn8lYmQn4wLT6wHPuToBeWwU
Message-ID: <CAE7dp2oFaheJMcK_khRRSZnQpAVN8Lgsy_phZsNO=spcbJU+Rg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: Format block comments
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, antoniu.miclaus@analog.com, 
	lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 12:40=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>

> > I haven=E2=80=99t done a full sweep across iio/adc yet; this was a loca=
l fix.
> > Given how broad this kind of cleanup can get(fixing formatting in
> > multi line comments in the entire iio/adc directory), I assumed it
> > would be preferred to keep the scope limited rather than risk missing
> > cases in a larger series.
>
> How big is it looking?  I wasn't expecting these to be particularly commo=
n.
>
> Jonathan
>

Hi Jonathan,
I took a closer look.
There are a handful of similar multi-line comments across
drivers/iio/adc.. However, a good portion of them
are file headers, NOTE blocks, or structured comments that appear
intentional.

There are some cases similar to the one fixed here, but overall it
doesn=E2=80=99t seem particularly widespread. I think , not widespread enou=
gh
for patch series.


Regards,
Giorgi
