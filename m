Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7A1A681E
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777221872; cv=pass; b=ZjEvj4PHe2eYaBeW2XNi1yZbvMDbDHF7NnX9nWMV8wLxvROX/ReYtKoPGFsonm21ikNgAzDsB/4SkqmKJE51A8Os8IXN8mzNFERlpr9XDLIDve7+sJl4yKgINKK24AIOtDlqfO+V8NX5LdlEXhdESrZKe1J+3NclVODQX0iPbAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777221872; c=relaxed/simple;
	bh=wmZ8Dpe7vWo4FjUXWm2XsIppLlcGoz8XQcj0Stb2G6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF8uI+WL6XR8l1DTVv9R87qE5/Lg+Y6T+fsMH/eQUsemCYC27SPhZ9vTPCVZJKO2v4/cofE9aiASnnGMFl8NOu5zJtZooAZ5sKBUwl57Lht8B0lo/3TAT2OFuLm8JxApKuCQzbu8A0i8OZwDpkMYC22IVnj5SJuDnl1XtGfGtoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ7sT9pP; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ7sT9pP"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3878de20527so71239161fa.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777221870; cv=none;
        d=google.com; s=arc-20240605;
        b=ENj2ndv3oFTpH5KunHQf0Od3hAJhQ8kjzWU29CQjZpsmEeRqyqECbF/x0tIU7LNrou
         pXKvMP3zVdlI7c+mj24zhdMrMe+5cKtqv6ZDqXYgjsExdPBToUZMVAaKmwrMuh62zoLy
         CnPM4rIboo8jznXKe5WuOnTRnZ97QORn6DGlInRWEwfI7Ceyvy/XAgRdp2UmpA/T3K3W
         5KLykO8RyakFEGExXgc+4oBgfnjzVkUjGk/7jvVhulAnaPi/q+bF1SlG86Ejx6jXDght
         LNPY18HQdvm5KcPURX/Sb0hhe0ZkQ+tXxiv1km/MFuT2NP66dsklEE/2RMSw0JP5+3Rp
         5+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gF0s3Zdd9y3ounVULddivCvOaPAIz7AmO/Iu2YOKL5U=;
        fh=WE76UZ+WxCs0ZAy6niMdakReI/Ut0FwwxE7VAb9ITug=;
        b=MuixeA/eQ4kIrlqT3eAiu7oMtY5bI1NpEeQWhSX7QO2nW4D49qEbQ18UdB1AZQxMIA
         sZ6jvg0gDDfbhwh5l3rCnb3IaiGIaOVbgS6ukukxiXHZW/sbTZvyy8srE6o2MvF89/Yo
         60DgwvKEPUFuoB6mSV+jfZt7fQqOk6/2UlO0RS/UPu6mdo50RsFQVz5CzPHwlVxKYhet
         0KNjk1o/L1A7OzDsyntjHIU8pZBpc94T7jsfzWqjA4pC0bhWWRZzzSqHaUGyZHQXnq2g
         4r9HGaz1LAxZmxucwtV5oogkNKoWD4gFjUWJdKTFPAEZDS/YTfSHx+Au14k/jj2+oZkm
         foSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777221870; x=1777826670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gF0s3Zdd9y3ounVULddivCvOaPAIz7AmO/Iu2YOKL5U=;
        b=IJ7sT9pPKLTF/cuj5jo8WzqD7Z39d84p5lXTsOvGJMqGU7kULgw48akrtTjTgLj73F
         33tqlxYYESAr1tXmHcu3GuqM6PGEsKBAOjKt37GGk7OTl9yIMh8w5opKJMy5U3vEh8gS
         Pjc6tVvhK4ueLOIHvMOohqI4CPzwsmRHUYIBtT1MLAHo5gVTaPj5UQHbfwZFI7A8IqJO
         +QI2u0+9Iq5M5QYVl2ko2YlekqObn6X5ndmINJpwYDtHBgJCJLQGKuILDhOGNhoFEzTc
         kv1mZXnpVupMkbndC8VCEczPnaRi2UNXyig+Jp8YVZDNNQLpVcqEUZHNkqZn5IZ09M/+
         mPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777221870; x=1777826670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gF0s3Zdd9y3ounVULddivCvOaPAIz7AmO/Iu2YOKL5U=;
        b=Rrvr7g7pHlTVajBkHCgQkkGfqs39vUeOl3ECxN7Y5wKEFE1b8nx/4/eT5Ewxj7R3CJ
         YARmWXJjtP4/gS5SJtnOgpAnPIOmFCJ7XraquTwyGreCWVJlZgyL5AnQs7UrOCLA92P9
         HPT+btgrLQHriKTMrzpZmccBeyv9uGjgBPp9V4v6QPKGQkRemWmwHa1B+fRifWE5l+gI
         Jb6OpviI8zzOqjJkTnQG3gEoRSP9yOfeYajg/iZLEcZx4ONbZB2jPKUmOKevA+fJQBSQ
         +i6KJxxDNTtt0kgHrFUIcUaw0mU/wOQtChSpJshZebU2S6Qqc/wPVYLsKj80V/GXFZAs
         t1kw==
X-Forwarded-Encrypted: i=1; AFNElJ/vFJQmsyGPNtcAc3ZM7lCHWiJNTQZqcmrK2L9GePIlEH4e8xluNVh4iftBnnO4ivRLCf1jQ+GskYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyT/4H4P8DIqvtLQANRG6XxyB5+ZCoPeLIruurtSvjwFfOw5Es
	OfA3YqBVObiJHTzZROlHRsgmYcTlBJrN+cI5rbisp52Cw6KEhIeqI4k0mgliowZLs6/TqaL2gIb
	CXnEDm8ZukGsj+ilh6uprX4YfMNpaKIc=
X-Gm-Gg: AeBDiev5R+ByunwR6QjHmpnub+uMyhVEdy0L7ftAz6x5DTOu4h5Hv/5HCFFBqRaYe3D
	76c+v10c5AsZj7AsckbCeHviPQp3y3bT9EvcixNOIWMHgTorR4fh8BKjv/sTp4bhMRqKgQa15L5
	uWzIKceJXYGT2MCN776DcVBIOp1LGioSrt3ImHNlzT1FuiZZ/Jw8KcpBhRCzKNPHXMbffRzb5ef
	XspAS2pJg07lVQRqdWyI9rgE2DduHdNIfVVSupqN75XnnuCaQ0ihDTdm+L3ZjB/i0+6IrFEXUzS
	oXpy2wpFRpYxQYNpfsTZMcErZHwbQWtWWi/PNJXz4YGfTUepWE8SVrVDdrsTy/SNysapT+F+H1O
	fYk/xgDxmyXTQ4WQ=
X-Received: by 2002:a2e:8a9c:0:b0:38f:f6a2:a5dc with SMTP id
 38308e7fff4ca-38ff6a2a783mr88016101fa.32.1777221869275; Sun, 26 Apr 2026
 09:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
 <20260422175910.1258579-2-piyushpatle228@gmail.com> <78aa1551-2dc6-432d-9d44-ecef0198e1d3@baylibre.com>
In-Reply-To: <78aa1551-2dc6-432d-9d44-ecef0198e1d3@baylibre.com>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sun, 26 Apr 2026 22:13:51 +0530
X-Gm-Features: AQROBzCaiysL2a2QMEYBOq53qTpzqm7ui1GlIeNHbpCurNM0rkHZyNxj2hgt9PE
Message-ID: <CAMB+xkaOc=y8t9VHSNKkRRxsxLR-Af_GonwiaY6Tmtapkabo0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andreas Klinger <ak@it-klinger.de>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 9:58=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 4/22/26 12:59 PM, Piyush Patle wrote:
> > The HX710B shares the same two-wire interface as the HX711 but differs
> > in its channel and gain model: gain is fixed at 128 and the number of
> > trailing PD_SCK pulses selects the input channel rather than the gain.
> >
> > Add avia,hx710b to the compatible enum. Document the chip differences
> > in the description and add chip-specific supply properties (dvdd-supply=
,
> > vsup-supply) for the HX711, a rate-gpios property for the HX711 RATE
> > pin, and an allOf constraint that forbids HX711-only properties on
> > HX710B nodes. Clarify the clock-frequency description to reflect its
> > actual purpose: controlling the SCK bit-bang timing.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > ---
> > Changes in v3:
> > - Drop the vref-supply mention from avdd-supply; no such binding
> >   property exists.
>
> Why is there no vref-supply?
>
> HX710B has a VREF pin for a reference voltage input.
>

In v4 I will add vref-supply as an HX710B property and update the
allOf block accordingly.

Regards,
Piyush Patle
