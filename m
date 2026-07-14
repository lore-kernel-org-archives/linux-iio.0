Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDABC466B75
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035882; cv=pass; b=AijG5kIJN9dySCgksRznkvplewtVbadJ+sanNrvBZO8dEl7fGgoQXgl0MjnhBHxEdMAf19R1sitFuWq8UA0YcxoButq2v5Xd08wzZRL0hqnIejszp/v+T/+a5hjN+vIyEVPR6ur1vi1ce20GoChvhphP4iTdJn2Y8cpsc/qZ4Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035882; c=relaxed/simple;
	bh=6DZv1K0DlUi+ti2Ixfzbo+SkZOzrPzgNcj+8JfhDZTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mwft9WiudHh+nBLEqdI/dJ4dLySqJfYnUV9MnMPLF5XZu+moWy3CRAGvJs5rz+Vc+9ZB5abdN/ERUt6VGVHFqTm2ePQVqGmA1PVp7ZdNHMAEfg3ZBHgHYwch6KYtY5LMazEiTfQGmKGOSmaTnfYOGaQW84PzTFbACAQ10Bo0Loc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adtRORoK; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adtRORoK"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38175907a56so760491a91.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 06:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035880; cv=none;
        d=google.com; s=arc-20260327;
        b=lM9cHkULPYBgvK2XbZY9PREQFdBZDLgEeMLW1DU3fLcXYxltxG8x7inyuTPJACdObA
         0iAVwVSuOJ1XtF2oSXrP4Rb4uB73XSuUVpNy4G/sSYbRINj74PJI0UL2KzjAuIAGDzou
         kWF7XuxUbTa4lohoj/xUwFO7K31zehGAic8S8K6OB2aNoVLX1kDRiY06J6u4/wgYGF2h
         qpFRrc1m4O3c8gRYvnXsOcig7p6oUJLX6wf4c97IMC1SN4Dph/SvNF3/0LKBJrRL8olu
         dlaNqKtLexl5YHR19KBrO6IN8rVnSf5oFjTujERl11I/YmbzQI7kO4UMl8knHzVYbYId
         nhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLfW8NpBLmGd5rRr/q7P+WdrGpDQQoBNPKO5OnQCHQk=;
        fh=b47WcTJA8mpUGDX2p9UilF3WSQDtg9fhXx2879xUFZU=;
        b=RN0xnrrupBesNgMBKYgWyvEOJQMj5uf23k5mCpJ2qIEkUKqMTm2vJktsHNQp6yPSfv
         YehiwxHG2o/QmFpPIfI7GO5IV7lvlITTM1O9YRwc+BaHiVQDi838is50E8RPJxoVgmys
         WyuiNh9EtTujLmFTSO9L4pWTIzAdwiwI+rKhSE/BfI7vG+Tom318Ryt2bzkfzMF246Pc
         73ecuXp202YD3FKUcVfTJrq8Vdf+mtFcSPsuzkt6oOAk3bTk2tf+ouQZpSuPoGXPN+W3
         2apXjvV3TFZcS3NchoDSkLsCtT19lAbScoOk/ZIaqH0q9RqUZMyY4C4fo3v5eWSahrJU
         3w+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035880; x=1784640680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kLfW8NpBLmGd5rRr/q7P+WdrGpDQQoBNPKO5OnQCHQk=;
        b=adtRORoK6ykURV4MpPqfrnTXyFhgyraH2fPjJ0S7zI+Kwx7knp9zoE890+UYb+j00y
         bFiN9z5SSPD8qzVBXDWlV5SlrMQbkjEPvlDpqIz1kmHac6uHt49DQ93YNWJQfdi5EQHk
         475uVtuqDXE2WWrNE7/ik48QuATe0RyrQUbWMxyxEj9KdpndUMc9EO3fPKh/seREI0ql
         //DrLBaWIMGG0cjP3+D5fNXmM/AIXH05XyLQawLfUa820ELjaK2iJiPlBqzjJ35GHXmI
         D9sKHXvALthnn958hN4yPWlnY+H2pBMvmeGysDo4boFy80Y/Zwozmr8Tvp6DryTrOpwS
         AT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035880; x=1784640680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLfW8NpBLmGd5rRr/q7P+WdrGpDQQoBNPKO5OnQCHQk=;
        b=lJFpQ4FQjT2UtAfryrDstcQcLo8gVo1e4HmA7+FXF8tUIJCOKchTdFP3rDuTpYkV5o
         f4ONHhbmlnC5M7nOerkXe8skEupNbI55LFnFtaLIvc+Qla3F73fcTqsNy4KZXKGUVBgH
         OcARMuLuPzgjsg0SF9WnIKLCwBpxHieLveGAcUfLz+V580ZzkZzloBqzPRSsm8FM/Biy
         iZ/hFMu8AeNecdpaviRqLjllvXCLocgzcux/5L58bNitQYW8vtWkeIhpPUtD+oicIfQS
         wPszxAr+HPSO1FhUMW2s+gSg6ZpuzoQllBlf01IjljSwlQ/w6q35fbQR+gTDedLiLBvT
         NI2A==
X-Forwarded-Encrypted: i=1; AHgh+Rp2dCahMn2DpfFNuwac9ZVGRw99I1m1Ioe5irnLC1jfo4MXacx8I13K3byjgXy9dd+tk/e5RV4pbyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSYZXpl0/HhxLA0ErtG9ImXgsdqcQEdgEA5FcZkIVbc7+NNVT
	tndJWhePzjArjF5Q+xxD40NRk/IEHZQL2QdK+Hoz0+7KT272uvOyAx7XDWsSeS0qDADXkskLxL0
	IYH1RY8nd8aJXZaRiQoELizYq88o513w=
X-Gm-Gg: AfdE7cnEZh/nRHeg2NJR/QaO0VLjMqfFJ3RCNOTWQajB+8zVF/Kfp8SIoDmbFpCxLPh
	ard5+DNFSeA/INfkXSJFaeaVMVyAIZokmuPNlJAvYqCpczj3nQ0k4F4rzqoXdbpAa+dZZphOCp1
	OVZsPs6abu5DTf5iSMYz1HjNuUwHPSbUsJVcldtuvOwBRpk8D3Ar57I/oQfOkeRr/NRoz+OmODJ
	5ODiI0cT6Q9uPLpHGRwfIh6DfuYehIwlixVdHJdMPDGRy2p6AfLK8z3cZb4UdjpaPAQIHB5FWtl
	jTu2Q+mT09e69GrcTdhXOs5YbWd5S5CMbqqHWZlt
X-Received: by 2002:a17:90b:5607:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38d13c60530mr18215292a91.5.1784035880304; Tue, 14 Jul 2026
 06:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-6-clamor95@gmail.com>
 <akeHC-OA8tqM941f@hovoldconsulting.com>
In-Reply-To: <akeHC-OA8tqM941f@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:31:08 +0300
X-Gm-Features: AUfX_mxzYxEuGLMctIZqZIdW8wmxIrFK1WcO0C4FctuVUcu9qYtJIaIs5OSxe4o
Message-ID: <CAPVz0n2DPia=nfvd3W-rHy91OvZNO6jdSczT7kyvH-G138KJyg@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] iio: light: lm3533-als: Remove redundant pdata helpers
To: Johan Hovold <johan@kernel.org>
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:55 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:22AM +0300, Svyatoslav Ryhel wrote:
> > The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
> > are used only in lm3533_als_setup(). Incorporate their code into
> > lm3533_als_setup() directly to simplify driver readability.
>
> That's a debatable claim.
>

Adding helpers to wrap custom regmap wrappers seems redundant twice.

> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
> >  1 file changed, 16 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-=
als.c
> > index a9af8e2b965f..69bac1b202f1 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
>
> > -static int lm3533_als_setup(struct lm3533_als *als,
> > -                         const struct lm3533_als_platform_data *pdata)
> > -{
> > -     int ret;
> > -
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +                        pdata->r_select);
> >       if (ret)
> > -             return ret;
> > -
> > -     /* ALS input is always high impedance in PWM-mode. */
> > -     if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +             return dev_err_probe(dev, ret, "failed to set resistor\n"=
);
> >       return 0;
> >  }
>
> There's nothing hard to read about the above. To the contrary the logic
> is more obvious this way.
>
> You also remove the high-impedance comment for no good reason.
>

Removing one level of indentations without obscuring readability is
always a good idea.

> Johan
