Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F11A9FB7
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696034; cv=pass; b=pn//b4tDgsIC20aLeau5emyFLl89Zm/Cr0epwEat1T1L5xvPxiXlgYBiyV460NXSL/mv7h5EYXbMjK1ldjlwhytSc7YEX80PEyyBgNU8in38WojSqp8WsQRvUWTo1SesmsP906Sq3YD7p4U1Aup3VmvtBPwvOLGdoXLQNixSeD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696034; c=relaxed/simple;
	bh=8hkiA+rqLonbkBeEG98v+Sz9qEZUaEVjTZj/+zjwtzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLojl0DRAKuIT3d1zGDCJb1vvjJJC3UeOCvDUHGskk+ksLysuTOf8VlDEZ0C6e7hg+B5hGS+mjeHaA1K4Bb70vCOdAL0I9OmpYvR+FATvawJ1XW480eKi/igzcmTsflXUyaALf8/fHObJ6gFWnctLyzmDjF5pxSk5P5aBVaKO84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoLh7E6Y; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoLh7E6Y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487b7b3fc7so493195b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 08:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783696033; cv=none;
        d=google.com; s=arc-20260327;
        b=EtY1ep910ZZRt+VhG8ToxxjNdyT9mxvuAxWyLxhYpm5oU0nQygm32POjYzDKwNyqlQ
         uQVfih5zdtDn04nu4NHxMf+Vybmj88nHphxjlvh1EIwWfNW0PtV8otLVykGSsBXEIHeC
         LPNrMgVGZ53tyw5f/lTPTuE726jESRnEHmpzwBjmLgepLAiAuz4KF2oPnR3dmJEV2AfD
         fesXpt0KBJ1fAisY1jKtBcHflYOIw0SPron49lmUompLu4/gf7ewOvne7lnXKay05QAx
         qtV2J0p5ZHJeXNvCOC+r2tCF+oUTeo6y1aQsI2RDqdPlr9L5NkrQFbwo1u5min3r4t23
         OZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/PBUbuW97BmRnNDRBsX5fmCAT8a6hYKltUYvO59k1gw=;
        fh=fWmlgQMgf8giUxw/S9dQZHiszy6xDoBcObLcNAab81g=;
        b=J8CKS/C2QncTc5Atxj99SQlPJtABAMdVQGcABCg8VGS4Ynk1fBP0b1P8RCC4refLYW
         ouqv++5QqcYBnDX0OFQNCGR0pY9LVNENT5rRNw9uI4WfXFJhyLG+djfdcIX27ZXjgMSa
         oaRt2yZ261TTKrcsfdBxoZ7IjDh6siwz7jlrN9K0JMBbAvl6wOkM2m5M7KZpkMghx4RU
         LYnAMOtcFzZTpwh/VhQW2riQEQsY23ACGcE7LZklFX942GiUP6PInykYta6sv0yaSPax
         uLLOntbznK2cvNwm198jnM3to9TqeKgA/P5u+iXDV7v5AliY5oQqOS8Uz+qrMuGMSaVr
         akKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783696033; x=1784300833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/PBUbuW97BmRnNDRBsX5fmCAT8a6hYKltUYvO59k1gw=;
        b=YoLh7E6YToP5LVqqJUjBO9q9qbBZhaC9RKdruUa/+6rx/sz39Axetl1cSUlxpIPMQg
         DKgR3bz9J5IrrootTWOSdUy65BskhZCWxHJdgj7ZK++bhozeR+m9hYVY+hqPIAM3HgAd
         oEELYFj4MYGuc+MufQNxARqy87EfB2if0MtIIdldM9T/iHYS8bPdJkeUrYMQn6UvG/IO
         FfGuC6iXceedjHAHuja8OJmwPNkrfy3OgfotX2Z6kjA5ocGHhuG+LojuuROSOEtrq7In
         6LI89Pk5+R62PA3X2MMkoR8TfXeNVHfRY70JpTk50LKG0jvLunaYQhh5V3M7crcI9u3m
         G1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696033; x=1784300833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PBUbuW97BmRnNDRBsX5fmCAT8a6hYKltUYvO59k1gw=;
        b=e99ljzY8LaP2Z7IQApPlmdkpkv1M0B7eij7D0wdF6dZokNUwRscHkAQbYsztOaCdxH
         s+mSK4NJ3a+rYgaEbFPt/KTh5uLClUM+uAckfAmdmcefU5VmdvBbHrUQk6oqDtda8f1D
         1qp4Ipbtnpouz1MLgxQO7JYBTsemkKJUVLXkbpSJYGfRH6JwKESdwtwpSqKHlVMjyT6M
         jT/Wer+7GIO+UzK+IvxXe+FzS/BXR2QlPC7+WPoW1z2ZXF73BQgvH70PUm5bdCKHWSvC
         6T9QurwtYei3F9ag+1YpMm851B3sOXUU9UStnhIh6U1fGm94Y6XHiN3NYQ1WQvufgtIt
         j9Bg==
X-Forwarded-Encrypted: i=1; AHgh+RoKSw+zFk4eAL2WxtLA9pjcjMB+ndPPpg2FU9NIoom4H2pNAGyhLNlTWSR/lWxNcXJ+Pe9fZN6CKcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsBP1dZ7em4a3HlUN8ndYcetbar8/QCAEAR4INW1/QtMX9leh
	a4gdLt/FFiOuDjs+M7W+ZA4lZYq98+P/OPtJLjPvmweuV7Jbu/MDyyikWZUStYu/PhTF0qEXkin
	4ZRdzMJ8mX91wNbmPX+5Gi/mvNj3mLpY=
X-Gm-Gg: AfdE7cmqeHYvbsz3ks0A32cc3FDO/UxKaXw1L7BnFiulcoPaKgO98PANF/qvZRFaE0T
	qkFHw6fzQw8iJRxo2RK/zZAQ2Z0ZchKosEVBw0TIj4APkUeB+nuO/Zhjkw9ExhRJ/br01cwNMT2
	M+5nQ7PvqH/vY9QWb4i3A3sPaJ7vfjROiyaJNMZkGTIdVcUl7ez7eIdnTQt+YKyjIJBRRMUMCII
	3EbScWD+zQsBR+ZswkUuFToHDTGZfcBQK35umBX7FQQ3NWy25bA1Q08ZZEgECh/iBhCiHGlGjk2
	SRPF8r9FqKRgfUtCHDAthcR0rzS+bQ0l6n1ywWE3VGRSj4lxirPRJACNQQ==
X-Received: by 2002:a05:6a21:1f8c:b0:3bf:6856:d8fb with SMTP id
 adf61e73a8af0-3c0bcef7461mr13434511637.29.1783696032961; Fri, 10 Jul 2026
 08:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
 <agAvydze87mMLaVC@ashevche-desk.local> <20260608085754.32def4cd@linuxescape>
 <20260609140712.2e5d1640@jic23-huawei> <20260609102159.14c68a8e@linuxescape>
 <20260610103651.00007a64@gmail.com> <a2b1acbb-f8f2-4d6f-9681-986f42feddfa@gmail.com>
 <09dea87f-d2e2-4bbf-a948-3092a2dae29a@gmail.com> <806c72a7-8c29-4308-b226-c347bcde7b0d@gmail.com>
In-Reply-To: <806c72a7-8c29-4308-b226-c347bcde7b0d@gmail.com>
From: =?UTF-8?Q?Tomasz_Duszy=C5=84ski?= <tduszyns@gmail.com>
Date: Fri, 10 Jul 2026 17:07:00 +0200
X-Gm-Features: AVVi8CdrCN0uRIaddmlPIu9xVnsd17NTIrzf-SLRqEo1qLSESEAppUV-brxSw8Q
Message-ID: <CAObtm8z5CGvNrPHk6fw+ibsQkqsMzK3CQBpmQFNCUj3jFzartw@mail.gmail.com>
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Maxwell Doose <m32285159@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	open list <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	heikki.haikola@fi.rohmeurope.com, antti.sakkinen@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

just add yourself as a co-maintainer. What changes are you planning precise=
ly?

On Mon, Jun 29, 2026 at 8:20=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> On 25/06/2026 08:11, Matti Vaittinen wrote:
> > On 10/06/2026 12:46, Matti Vaittinen wrote:
> >> On 10/06/2026 11:36, Joshua Crofts wrote:
> >>> On Tue, 9 Jun 2026 10:21:59 -0500
> >>> Maxwell Doose <m32285159@gmail.com> wrote:
> >>>> Alrighty then. I'll probably take his chemical/ drivers since I've
> >>>> been spending some time in there. Regarding his light/ driver (ROHM
> >>>> BH1750 AMBIENT LIGHT SENSOR DRIVER) I can take it but I want to see =
if
> >>>> anyone else wants to first.
> >>>>
> >>>
> >>> I believe that there are a few ROHM folk in IIO, perhaps they would t=
ake
> >>> interest in maintaining the driver.
> >>>
> >>
> >> Thanks for pinging me. I need to see if we have any of the:BH1710,
> >> BH1715, BH1721, BH1750 or BH1751 here - and if we don't, then I need
> >> to ask from the HQ.
> >
> > The HQ promised to provide me BH1721 and BH1751 so I am fine maintainin=
g
> > (S:) this driver.
> >
>
> Oh, I noticed from another mail-chain that Tomasz was found :)
>
> Tomasz, are you still actively maintaining the ROHM ND1750 driver? If
> yes, then I'm not jumping in. If not, then I'll send a MAINTAINERS patch.
>
> Yours,
>         -- Matti
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~



--=20
Tomasz Duszy=C5=84ski
