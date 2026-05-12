Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651A36F918
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569720; cv=pass; b=iTXrydmezJ8bVtNmrKxkarejGAfFedqD927TfVm0m0p4Wfzt7Go2y+BOT1TlqanPnjl57FeAaJaXebK+QKqS8J6zV99Xl2pm4jIpQMsd+akMVniphBH4IzWdPAlFb568AewUnW27Ahw8E5XKkKr4Elw8xccbXIR0I2RwcJps9qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569720; c=relaxed/simple;
	bh=MT81Hd3L84EXgk134AFMdTo3wRN3W9j9EMFVjmJ2DXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQj/pHIwkff9A57D1xAAL1923axQYfCOwLEmEXeOOwx5lopJ/jCyA2kNAUZ2QLunpkbMkSNcLwgv07SxtroduQqTss53xDIsEUmmmLBj3R1FEnVwytGknwJptGtKet466xhIIsrwLvPqlBDifMU2g9UQjjEM5qDCNDxxcHyxLes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iigrshKB; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iigrshKB"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd01481e592so227015766b.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 00:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778569715; cv=none;
        d=google.com; s=arc-20240605;
        b=H00C8eLe5ZuY6vxcyja5o7cGPcNgWLtd8/+cMUV1eudbjmSvXShg/2c0uNUoUeGeEq
         6ldbcSK0892cvN2L4g3rUl/So97RzBsZiFCHTvjXlljR5p0plh2bU/6Hd7h5lmH83Yuh
         hZWJsdk5Tht6zaQSrKmIh8yd91Tm8bdERhoFeqBT4WpKQPosu8NQYucSaE4OE3sOEsvu
         a6neNI2PPmSMuuvVYWp6sp6+PU4wbm791IXlfianlsFw6a6vs7iOhlFvJWV20ZupMXqr
         y3IWRKEuacOnU2XI77f8NrcpSZmUmErvifOLIkDT06peIEgXUMcMaVDrlU5F7zeKximF
         SZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MT81Hd3L84EXgk134AFMdTo3wRN3W9j9EMFVjmJ2DXg=;
        fh=hso4XcB/gG3nqZsfLhkfzCbsoNTvoxwiSC5K+LfW65g=;
        b=bB0zFjzJKCJBu6kwopN+T9jHyrB+im3Y2Z4DIxQfFK1ii+JhqeilaFemVbIM4gTb95
         M7mJYwp/fY40DsxV5cFByIjTJngf5IWoNFn4U5wg4ADJSuQuO9D8vcrEu7RBWiw4yXCT
         HpsU8Ou49nuFmag8LlWKseFtlh8jN52IQsV8IRppVAaqL8G+LZk9E8IaYAXT5u1q1NCQ
         fy4Z1H3RjJBJNMYC0yf+1ufdY2KrlKoCzRAuAfTzzyznaHOXEvcgmDHbWl3rmmmpngi3
         iAzcnuyetpDvlxWKTuA8DOMf04W2Y4gK6jbDiGIj77jnyvOYAT4wY0eCDi41/dXptkJY
         kbxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778569715; x=1779174515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT81Hd3L84EXgk134AFMdTo3wRN3W9j9EMFVjmJ2DXg=;
        b=iigrshKBo0am7I6P5eCDAyfBD298mmufQAIOkJPvsGwke2WZmo26E1KD/S0dbEapqK
         lHv6+AANpxfU08BKqjipRPVuHEvqWTp0rWZh1cvNZ+b7MhzFH7j0WjcJpxpaK6SMmHza
         DMfd2VTdjr2S/myQKVMcmKA2PPvhqvBUvODV1l8qVDuRRdy7pxPGZC0126e6hYMp2oYo
         d9jFhVECRVjctnEZ093Y5zEpQMPAXMIOj5ObSv46HrO2jfU/nxcVaPa0WCd09kEb+dX3
         rSm+UpmzT3fJP5BBwaYe6+xDvLX3eDYA9vmd2vg5qtJ84A31ihdbPGuaMnPAIIumjj8a
         te7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569715; x=1779174515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MT81Hd3L84EXgk134AFMdTo3wRN3W9j9EMFVjmJ2DXg=;
        b=FvpF9BUYDLECsmeJ3nYpHPyM8RvyVJVIoG6sjcHD+lC0YAmuLhMSfrJwp6brIP7LCU
         7NMFXIxIm7RwzCS+1DC2PzBP/Qc1k63pdE7Wl3ks5lPpLFLLX2r8K6XmLbEHKQHqh5UP
         edfXv55kfugE2R3+cYdU6PRnyW+SsJ71/xjRJH9kAmwKarFi1Pn2CsI9sl6+TZbJEK8c
         jAn4xEeT62Ru49E2FHxjzB6+NM4xfkfRWPY0rKeIz8a6PyzxZ36+X/DxaHQgUL4Fl0hc
         RFHJovbJgKU6wJEbMRwKHvJBdWeNRiX5GCWVsKrSbcG65iu75LQoILJsBSTLcoV88CKs
         ZgPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yRckjGOKxEBqXIGihXOgTbakYX9loo1JAizR/0K+st52cvTNOK7vwRSrSRCozuHIEmBaBd3swUvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtUxVBrxmb0qWRw2EtJ4EJZpk0+qOKvHv9IlzwRn/Xy/M1GVT4
	YwBUBw6EBtoQdLXBJoblfrX+Tb6xx6ELMHXk1QC8YiWUFINlyHjKkuX23lwxeBaP2W89rIEhKcj
	L1kLiT5R26RQmAVFyyjPV6FOTNJ5blpE=
X-Gm-Gg: Acq92OGap/vvUZNPRGWh8YixP8hhW05FeEirfqERjKKUKqgWCczSbIuXc+HSc1EtQF9
	fHB6tRush/GG3cMD8lyqAjz24mKWwOdfUmsw/65dCw7uH0+uk1DVQ1QcAR5/wcqx4sty+OrJ8jd
	oGeL5hqKy/QHQouNaVP6DUS83MSN1qhgKCZSRTO/3HE1+k8BMF1YiSB5rvYyFhN9jUt04rHWkRI
	LZgUQfLXpNs97nEAd87Bai1e2PAgxGm4L9lhZddXlNPdvt6ci/YIM56hfGlvY+ZNTPgb5Swxz0x
	XzTzrPq+lypLPmdh9RA+tG4SHhhLvhqAr1govho0IwZWTGvPoeXF72zHduQbBDhJLws93IF4YGh
	1LmQM/fk=
X-Received: by 2002:a17:907:9412:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-bc56de100damr1755416366b.21.1778569714611; Tue, 12 May 2026
 00:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-10-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-10-3efcba579e88@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 10:07:57 +0300
X-Gm-Features: AVHnY4Jipzfnw1owf-ZULaa0oh4jwzOau62Z8kgQLDNNHax4pisYq4PVzs9Mr6s
Message-ID: <CAHp75Vfi8VwJvBLAAnRO4ZdoFYCCXcC62UOPC5hCcYpTpf-+og@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] mfd: mt6397-core: add mt6323 thermal support
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:21=E2=80=AFAM Roman Vivchar via B4 Relay
<devnull+rva333.protonmail.com@kernel.org> wrote:
>
> The mt6323 PMIC temperature can be measured using AUXADC channel.
> Register the thermal in the mt6323 devices array to allow the
> corresponding driver to probe using compatible string.

Wouldn't it be better to interleave these MFD patches to enable each
driver just immediately after the driver provided? However, in
previous review somebody ( IIRC it was Krzysztof) asked how dependent
are they and it has something to do with the device tree bindings.
Take into account that one as well.

--=20
With Best Regards,
Andy Shevchenko
