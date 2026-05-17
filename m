Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523535CB6A
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779012678; cv=pass; b=dEpXWh4na69S685+Qqwlz8Bq9TGUlNBxom5F3lRZTmgCTDDYuIo8KwyPG2uPv1VrkSFC6m+4mmu4OAbSik96BmuybEDqxTs4cfea474mGxB6HHYUudapoOXJ19JvUMNx2bTp7CisxEdTHwpdZI6ZvB6suT8B6IzWMAWvyU9bxyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779012678; c=relaxed/simple;
	bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfrkgFoCEQMvURff+J7lKXoH7zUcYd4CAsmW9KeJIcJpSQHjcJvjNTgvSlEXac4jz6waNoLRU/6GGw4c6UIwlMlhnUgt9QHfTKQPRIXPUjdxuiNVookTSHG328KtmlieLaIuRh6CNwbtkR2SQB9lpUiEVp4msDaYOzeliSsgEK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rciXCJPe; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rciXCJPe"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30246cfd41aso2956937eec.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 03:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779012676; cv=none;
        d=google.com; s=arc-20240605;
        b=KyDrULywygUnll2pPTNoB5T3ajT6/Dm2ir6al/hkZfTd1U4OIzQgPcb+/jjRZjYMHu
         k595UK/WH5DQowop8ys8u450TvvulsroAY1ksJPJ0/AsmCDXi4AW8riGmylGuceRocad
         tLr4jLPnmUSuvH3MUVbw608uesiS3y6Lk5ebRpAPhW5iKr4YrzbGWwaP37pwCdT8z4Gi
         X5NbDbvULl5pHAOZnRL98S7vr2Od0oO3yaTPF8aVK7WjoUGcFS7WDuN3hL91TK9nUz7D
         i8EEdtjq+xv6Np3hAZ9qK1aO1feWg+CzXk7dofCsuuIM47Visf7w9u2+HLMg/tObd6hq
         E0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
        fh=NLPgmVU1jI82WcPQbms50rmb0xv5SODAiztNvXdsA18=;
        b=KdoPcAmlKMa2U2x5WVzZv3WaMkjx0xgqQGkSOv4/1NaS7QvTdYjIU1oWKg9o4sXKhw
         zUVhCn/AvPCRJh+BGpb10ARgFzX6oS5WX4aI/POV6tni7pUcVHuzyRzeVQhRVt5kwYak
         oJJT6MlOXzHFaEgrDNr62d+Bh0Xz1+/IwwI7ZK8k8kFbXtxYXE/W5zFPf2leHsVuD3A4
         nELYFBifNJjYlPyUZmH9sOiYJqAvvArYxOuXznpD4mCmd2W1Ex3zjc3f4edphazgVT2W
         q9ytGUVZmL6ADbGjgowsKOgFaNNWWAHpuQTd9eXOLxspLUj/syOjewe4u8z9ah8m9pCv
         N5HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779012676; x=1779617476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
        b=rciXCJPeT566uKV/w+At0X8Rs0RZV/FR/rji3r7v5LvvlzTyLylSU/Xzt91AF8VNNW
         XN8A0EauYbrgo4watG8Yts5hYBUsa709meo1B9CmObIghjF8H+BXZwjQt+yx2jMyDijH
         2iwsLse01gO9RFaghvIQuT7SbEbt2SVzdL7E+wFMBA3OoPrhnAENZnH/VClpeWB4dxyk
         oM3zMzSfboDWz8Vi28CYGvdqVRP3qZOWO5TjTgdfXKX1oNqoFXrB/XNvEegSWLQ3WnhM
         tEgJK2s49ifJyLvNL2YCaFkq1OK7DDMjfXTPd1Q5PGC2tKUQv7RQv04N1Qz/BWVn3U/+
         5DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779012676; x=1779617476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
        b=R78RUGs/wp/FGP+MNPpx4BGr6qT+Nsf+IOM9MEwjyokzBFEBO+ziXkAIOZvHxXPbdo
         mlzrnK8vFfPzClxCNmYk3/xvhc1t+OsSGSTUA+JeEZsdSBpyqwuE7kyPlOI7p3hwd0tn
         sRhY4h7HVZorY+BnMiBz85hNZKBNc5Z7pANLjG8u/JxK9WKGtmfFltbagAUN3uezGbdV
         xhP6Q5/n2f9qrM9gXvh8Yx+o0/4UsIiZzA0eBejvit9HiDh1pD4JJFxWqyWT0OgwQrfq
         Z4Zamy3Mck6CvGwEZDvZYWC2r3VVE07hUHXirxjof1DQlXl2hxgGOOn+Y4sC0l5w9bzF
         B8lQ==
X-Forwarded-Encrypted: i=1; AFNElJ8U2VT76dwIVh8R0Tc77QIhtwe0qpRzf7e3AIgcC8+43BDQ1n9HhMP4XICWDvz45j4CjFs7/fxuwnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUU4e6sPqxf07e5z3dCvBdszU+sG9yxqgklPLP+6lbc+W/5ut5
	O0XKY61AyRSZLiqrLlbvcS+ltTvmivAJjx9OlO1eKL9J/B0G5vv6+T6rntRYgLi3fXGIgCY1CM7
	91M/yiL0uTSQDnwLHtg8S4PujTBgeY2j7VRQQ
X-Gm-Gg: Acq92OF2E+tzzjHlFrN80tdMErGtgpifuT6o2QhRR1OApcAGI8nkOmPbU0afaUhwel7
	VxDUmtVmuWTA7Fzx1t5hobzHplVPJLECetHtQPrFOKxdw2jtRm8MOmWmJ4b0okZfPPKiZzpETun
	e0iKhmHKNwJslr+iV7/lwTJb6t0PAqj4HbYJttVGs7hSE5rW/G96jReI4q/McdNYXQeJ2DccLg0
	at0Z76TQ3p6Q3uMzBChYtvtaFCcm3YiVsMXEyxp7JIgWenL8aGNNMfzpvfqvgtsI8pgS8cA3ALj
	NjaY9Xtt
X-Received: by 2002:a05:7301:3d12:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-3039818a65bmr4929254eec.2.1779012676435; Sun, 17 May 2026
 03:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <20260517074306.30937-3-clamor95@gmail.com>
 <agl0Z_EGzX8X4No4@ashevche-desk.local>
In-Reply-To: <agl0Z_EGzX8X4No4@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:11:05 +0300
X-Gm-Features: AVHnY4L0_43-8RfJ6hM5f4ALu2Syvstfg64dnmlFGgfmiwaNMhHznD8dW2kFuMQ
Message-ID: <CAPVz0n2D7q5kEECPr+bo=W=5OU=w4eni-FccdMEUMupkzHhvLw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] mfd: lm3533: Convert to use OF bindings
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 10:5=
5 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 10:43:02AM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> > Additionally, optimize functions used only by platform data.
>
> This is a mixture of at least (!) three patches:

Maybe you can make a list of how to split it then. I have tried to
make it complete and remain readable. I am open to your suggestions.

> - devm conversion

This will be dropped.

> - the change of some constants

If you mean LM3533_ALS_RESISTOR_MIN and LM3533_ALS_RESISTOR_MAX they
are used explicitly in r_select value. Previously it was passed via
pdata as register value and now it is obtained from the device tree as
resistance in Ohms and register value is actually calculated.
Naturally ALS_RESISTOR boundaries changed.

> - the rest
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
