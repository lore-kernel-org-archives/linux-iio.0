Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151D44D682
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053505; cv=pass; b=EuSIMQ/ww3QHdLtWiEd/N+MlpQhmJc34myvom7OTPAGBsHtz/FGa9WRib0EGyEWYgw4Xo/oQyRnylhqlRR4peptDJAZvIrtZzX2HMuOrIP8CpWpDjTeZjYxzCPDF7JSTSUCN6aQpmdiM37eJ04y2LIR5Ihypzdzpf1uVZPHeDCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053505; c=relaxed/simple;
	bh=gSQ6pTcuTePG32M6XmGUQnNRHQHNKydM20nRxn05ChU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXkTDEkOUwoTRqKK3ycVq/w+hiSbdDmiW8IIrFOjlSk9mAot9RtiVcgaLf/DINDt16Es1C+B0LE6HU8j96m5AVuQlG25ihA/xBz0LDPenjQaWd7zzr2cQKg2iAekGiiRWyIGqgQdpuv3wnTovYwngAwLVKhirsd6EzXCgREMXzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xofge9k9; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xofge9k9"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38a43f1f978so60513821fa.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 07:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775053503; cv=none;
        d=google.com; s=arc-20240605;
        b=QBrcRrmhMH26nrN3bRwN2983WrCURLzWC908GjTR1wyESCQTwjAdPfg+XCF0TUnsao
         7Su3Qx2fqMVH//LuT3V362+J0tpzuSwe1Ojo3YcEUvnUcld9SdVTE3V9CH6hmYSduydR
         t0WkR+pxMkBnCRmN2r6cAN3ctaKQMKZ0o9YdvE9/LHMSyTUaRv1Vcy+/4jv1cUyXT9W/
         SDz3JLpVJDK9NsbPP0lfrtdoUomV/Sa507GPwnxW8P/MZJd/XscZL+YTDduBgB3kHBf+
         vGMoy8GJ0tFYGv6tMlcIk2GaAJzSCbJM2D/9Clxi8dWmnPI7MdJY6nWGzrhcERyvRivT
         NIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gSQ6pTcuTePG32M6XmGUQnNRHQHNKydM20nRxn05ChU=;
        fh=IhG3PWZQfqB9dXoB5itpnbJDC801EVsY8wvTLh34DWk=;
        b=XhEKe1bxact2LTZzcEkbUvtY+i3++TN1XXfAN4/i/qlcQSQ48U3roKv4Jpo8kHIbrY
         mh2B0rLRY2qPq05fVdPFlRDFsNywJSwSIHBX2gHy0bIiqLyyTBCatbhXYEXauBNI1v30
         ZOOO91hQjhofMfsaXSHTQSRQaTxiHRQon45avB3dJ6x7K0ydpRtxA4x5nYMScrFzQYhm
         ACNFS2/OJhpToM52P8YYxibGGFnxDOor74MA3YLenp70fsVckjECTcuozg9M2GirZD/B
         ueGcN/82+05jStZx2JnpCE1e1zz8AUrnqzQl79Z8p8cQuiX2tFBQsR4NZUR/ZgLLdYC6
         497w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775053503; x=1775658303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSQ6pTcuTePG32M6XmGUQnNRHQHNKydM20nRxn05ChU=;
        b=Xofge9k9RYYO7Of36FF8GfpDt/uyrCaYs6FmX3T1kxcsdFBwnS0Nvh1zd4qbrMZkL+
         nmGPgtAtkthl3E0uPCSKWS1WURe09D0MFkwuMR4j7Wk/bly20CifWMMa+VL1PntyQKPc
         1utfxSWMuh7ZUar3Z7OOcjQ1XQIVEIi2utvg8yaLKyjTyAO1veoYw1s53/bsGH56nVdp
         PR/2H3Ky7FsukRQa2DsIOcWSFxaClCCy8LhU1jf4fQNe6ZCDD2l+yQUjhFMihJbD+dPc
         UH/nbZ2bbGprgFui6fOXv+db6YTr2GzAszapfqPOluJIFA1G4sJMeAUy1Ua5YSG1AfoU
         iV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053503; x=1775658303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSQ6pTcuTePG32M6XmGUQnNRHQHNKydM20nRxn05ChU=;
        b=ERfm/sHl2SVM/mW8ddJem0NeEjPuBmzLpbP4We3+Py7iWMtKSRSTZ2SEh/YqdRNR8z
         /GTD015v2+1C/NskZNZpguPsgKZCN2PfiBa6EfLhRcR/6RKqBsW3D1GwOjzugDu1CCkZ
         5ulYTUSKi9wNc8icjuPo1hFBBZwlDrSXWsD7yuYCqwSOv66u0UDtyd9ne0E2KL0i5Qpk
         Z4rCxrJMHJGKiu20Uu+wm10RwvtMkl5PsN23mCPaJAyPLUcIwZISVDcx2XW0PexyVAT7
         bXiMxnw1NZmebkJs3+4cMq2CUXYlt09WTww+WEye740k7f4bvyfWVVeT6J+L+Jtsss8T
         CJEA==
X-Forwarded-Encrypted: i=1; AJvYcCWca13LFD/HgybDAlKJl2J6oyNEZSdnmkYqs+QdiK4Cm4azBVYPllKtRvlhgpArR/Fc9Sxk1D4is0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/IZJj6B2ItCwsO4meW4J8X2v8wcywVlKOOAmvI89QQxGupHkL
	SAg30GmfIoFz9A6GTWJmpAsJgQQVozoPzgJeZ67tpc2ygNCeE90r4mla9wN/tUzrCP3EasKtFG+
	uBqRtiSmR57pRnv/1RBJznBfbj+vY+6o=
X-Gm-Gg: ATEYQzy+++DpfvMEEza/iBMgk2SE6ewm0QrwQn99fLW4OW87mouGZ7rve2cj+DNkjYV
	cOM2FEfnP8UUxucvSvFbKPuXvKwfvutO+rT/YB6/Hd5cBCu1knEB6IOe1mPmo9GJba4cRCiTHOa
	em0LMbpIQYRLhkTy+W5gUrwdj0Y1LrOZeOjFtIopYw2xb3pn1j1WFGifWeTViBOpyyEydoGmQLd
	WcjOho+1maLPywMMYPTbS4v2YQod/zYKJnJQ+N79xRSsCYDin33xJC+CNYDoJP8moz4ojasmpir
	A4NHaJqzmG8OjK9kJy38MQAyXHAHnmZcJ8rpmEmMiYt4RFoxrLx9snOP7LaUZWXECwIL3e4ryyz
	X4JeQRto=
X-Received: by 2002:a2e:a554:0:b0:38c:3e3:953a with SMTP id
 38308e7fff4ca-38cc30fed48mr13856341fa.29.1775053502521; Wed, 01 Apr 2026
 07:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei> <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
 <IA1PR12MB77361978ED21FF22F079034D9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
 <IA1PR12MB77369F79026F7BCB1D9C64999F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB77369F79026F7BCB1D9C64999F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 1 Apr 2026 17:24:24 +0300
X-Gm-Features: AQROBzBoZ-LI1caYHqTvdlVWNWIbminA0-gaXJPHQ8leXNSCDNAFQN7WnRQJ33Y
Message-ID: <CAHp75Vcg1u86z_TWwz+1Gk9QQ9RB63QmNcqpkGa5HQHZhSE=5Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
To: "Erim, Salih" <Salih.Erim@amd.com>
Cc: "Simek, Michal" <michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, 
	Christofer Jonason <christofer.jonason@guidelinegeo.com>, 
	"O'Griofa, Conall" <conall.ogriofa@amd.com>, "lars@metafoo.de" <lars@metafoo.de>, 
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>, 
	"andy@kernel.org" <andy@kernel.org>, 
	"victor.jonsson@guidelinegeo.com" <victor.jonsson@guidelinegeo.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:58=E2=80=AFPM Erim, Salih <Salih.Erim@amd.com> wro=
te:
> > -----Original Message-----
> > From: Erim, Salih <Salih.Erim@amd.com>
> > Sent: Wednesday, April 1, 2026 2:13 PM


> > Caution: This message originated from an External Source. Use proper ca=
ution
> > when opening attachments, clicking links, or responding.
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
>
> I am deeply sorry about these markings. Please try to ignore them, and I =
will do my best to escape from them.

Maybe, but ignoring them might be subject to law enforcement or other
legal actions. You must get rid of them for your OSS contributions.

--=20
With Best Regards,
Andy Shevchenko
