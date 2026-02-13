Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153128F949
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967414; cv=pass; b=rPwhjiL6VG7L9aGvcoNLVAo1WfBts2vT/96Q7OsmC/HEvtAHX390XV3yHlcupbBozNgk7e2BZcls1lO7BMwcfxJLvnvLopXnxFzGg72wX5DsPhPilw51AO7Ln4FkfBIeL6/vQoKEW1CjxZ/Aq2vYUeCCUAbeEAy69hRhUf5rbgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967414; c=relaxed/simple;
	bh=MmyEyVaUK0nInRHofYHUBo4aN8wM9mt3v+WrEEIMH9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIxT6MqtsXBxHb9Z4/ObIZ8Y7ZtSh2h1pf9GBSp8wyUgcOiQMTgHS8aX48P3m2/WQU2wXFdACMBzY6Ab/+p8M9PnjA1qwm6eH7DPFGBlZIqPAxyQwdee/tw0gQ+HODiABWpUvjgqsHR0xSVbjt0qBNE8cDFNer9dMpwzVw+dbaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myyQa0+0; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myyQa0+0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so4574785e9.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 23:23:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770967410; cv=none;
        d=google.com; s=arc-20240605;
        b=NbvIBpYCKyBsemLAt1n83jMEto/XX8uQnr97ih2VoexHmJEF9dja8YemLu2lVTLaZH
         jK5jJs40OenAU3us0ywIeJCJeg2m+4c045TXNbfWkyUOcHi3ThXT5dv1J1W7aJcoaqd/
         j8nqMJ5YxlYcldUBELo8tlKJxyom/r5/bfWkfacLGpqPbYz+8ohO2XLhagjxG2hswyfv
         lA4tiZ/xth+qSzqRURY/YORoOmZdlq5r10ylgMBugT1I2mUvozCKhuExJOl7hRg2QE5k
         +fdSRw6r8D3YE6oylXrRQse9oaA/AroE6raU4mZP6aenpMHft2sKLMxtDyN1rE843ezY
         oaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VBWGvgMwD89B2tOYl/7fTry4UgR0kuVd41YN846Sbf0=;
        fh=GmUoCatP1BCmeenVoL1ugTVe8GYuyhsMRtO/tZCbcnI=;
        b=fzvubKhiFN7euhRfpTgdyO8iSfPO9skOMsI5jCQwD6xyq5gdAU4VW+ApMY7KjkKkF2
         WUp6FoKcb4GwzhlxtZ2BGARlQesUny+nGJDlF9JU3D3uXG6Q1Gw9iDb+DgmaW9xIUiVe
         nP7f5puePmGUhh6fsOD36PCsz3iGWMiPJIxCKvvJahtI47jwbT4hpygtn3dTzpQxkdY9
         jFpLtIdr5LIndqCtOoDMeP5GplPmG0TeRjh+P3KDOrZpSwh70dLGFkCOvgbcHc8xhaZy
         A7Q12oNLOcsEVMnLr9zw6AgPmwv3pexhdiJiFOb+YOngioi+EG8Oap09/ybHTl7+aKHp
         TDZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770967410; x=1771572210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBWGvgMwD89B2tOYl/7fTry4UgR0kuVd41YN846Sbf0=;
        b=myyQa0+0cdZ+6BCDWQ9XRyfq36ArqkIuxg3T0B0e0k3KTN7Fxgoza3JurNqt2hIZ73
         Z8KwemYutt8a8dmsYEa2cW5TON/PySdU4wGeWtt1jiX+oI8PKGY0C21vpyywSg04XAnM
         cAZkTinhBo7tp7ijknJZGHWS7qK4EW+9jQ0UykLEXXpPrW5XASJwMPNVDtBJm5zFeuCw
         kg83RWB/vx57hGCKzvOnJgXA/b2Xa2tWpYcQqB5NPd5nYEUK9CZ5Ff4uyOJdO5K2Oth6
         pVkInJIEja5yeUvaUK+jxWU4C5HbQdUhXNdKsMBGitLgviYxiCARAeZew8gezjZNy5vC
         iYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770967410; x=1771572210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VBWGvgMwD89B2tOYl/7fTry4UgR0kuVd41YN846Sbf0=;
        b=jLKMUpW2l4+xf5t73DVw2uqSm7tpyjFNLy+zQiOjrBC/Js4CXy6NpjCEdO9n3mYd/S
         2qqzIrDxkjYC53aVsUG6S9ZpCuJffxvMfl8cVflfQWWvCxUbShACvXBOHozbM4NrYFxB
         p5sW79fia6K5512QVs/gXqHCokHWv5s6QpidMTfw+hJUoG1y+OBu0gMOWn2EqslPudL0
         CO6IbOENo3T9kWXLWuxOZDSefvELcF3q6k+XH94plxNyJySqsaVBHTuuj1CWRKOtNQ6l
         CKrkmuquoeTzO34de+5QHv7MrOD6yI8O3+cIV90yxBFbmUKJ8J0VZ3u5IuK+hoWLOxba
         4QZw==
X-Forwarded-Encrypted: i=1; AJvYcCWDUuKqtVDjdSyt1x7ER4JNwpEWkQUaU0QkBxeHPLUUjtItvEtPnvLIKWGSX+ACyu7HXS+Qa/mrH4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5O/QsMkNp0mx7PM7Z2OA0pkUHZUf27C407Q1+h0Rwit+Lg63
	SqOYsUr9k6BghiDGsaVaPWC2OzCk+QPMjilVt0L15549LmTD4GVFYN8kVoDKYnekrv9dJb//2sf
	aNnuUKd4rnXep2UBTCILk9Lv81SfWUXc=
X-Gm-Gg: AZuq6aKlepMmnkNM5ePNqiSOFsmg7RX98zqh2kDPqZzyUknjwCklke2UG4MIRiMisEP
	tg9Jprvd0jMScpAY5szSLyu37J5oFXPLPn6aa6hWxN2AAndoKGHf82ag6EOv6HhP4v02SLzdkWN
	61PoklnHD3aQOdpb0ppryLi8T8yQb5sFkkpDVB+742qh0xXImq/gjs1+kGsViW6v10nHDhUHARZ
	1wyVZ5S6VgHin362CMKwhnCJzwFpuXWKtA8et9I0Kl61PHC8ynAqASwxm+Vdq5U+YSO+tpjb9Gt
	7ssre2m5
X-Received: by 2002:a05:600c:314b:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-483710962c5mr18176375e9.32.1770967409817; Thu, 12 Feb 2026
 23:23:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-9-clamor95@gmail.com>
 <20260211212016.GA3910589-robh@kernel.org> <E5BC797C-4362-4C75-BCAC-7C32A51C4725@gmail.com>
 <CAL_JsqLcFAP7oP0KzLp7DfcCpz0DjsjoAW3PcfnWu2nc-dG1CQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLcFAP7oP0KzLp7DfcCpz0DjsjoAW3PcfnWu2nc-dG1CQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Feb 2026 09:23:17 +0200
X-Gm-Features: AZwV_QgDJIV6_g_jAAOQ5PvTpgIhruzFFHa64dzcRToVwkVZEzE9kWpIOm1s5Xg
Message-ID: <CAPVz0n3oSpaW4w74Wxv9G_RUhCYX-WsnVexoAbp1tU6rkJ4nNw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] dt-bindings: mfd: motorola-cpcap: convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 12 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:19 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 11, 2026 at 11:30=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
> >
> >
> >
> > 11 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 23:20:16 G=
MT+02:00, Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >On Fri, Feb 06, 2026 at 07:28:42PM +0200, Svyatoslav Ryhel wrote:
> > >> Convert devicetree bindings for the Motorola CPCAP MFD from TXT to Y=
AML.
> > >>
> > >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > >> ---
> > >>  .../bindings/mfd/motorola,cpcap.yaml          | 411 +++++++++++++++=
+++
> > >>  .../bindings/mfd/motorola-cpcap.txt           |  78 ----
> > >>  2 files changed, 411 insertions(+), 78 deletions(-)
> > >>  create mode 100644 Documentation/devicetree/bindings/mfd/motorola,c=
pcap.yaml
> > >>  delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-c=
pcap.txt
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.ya=
ml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> > >> new file mode 100644
> > >> index 000000000000..7e350721d9f6
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> > >> @@ -0,0 +1,411 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/mfd/motorola,cpcap.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: Motorola CPCAP PMIC MFD
> > >> +
> > >> +maintainers:
> > >> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > >> +
> > >> +allOf:
> > >> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    enum:
> > >> +      - motorola,cpcap
> > >> +      - st,6556002
> > >
> > >This does not match the only user in the kernel .dts files as
> > >"st,6556002" should be a fallback.
> > >
> >
> > Honestly, I would remove st,6556002 since it is not the only cpcap mode=
l which can be used, hence it cannot serve as a universal fallback. Some de=
vices use ST produced cpcap chips, others use TI and range of models varies=
 too. I guess I have to multiply commits.
>
> The "cap" name goes way back to at least 2G Motorola phones. There
> were whitecap and redcap chips for different 2G technologies which got
> replaced by patriot (red+white+blue I guess) for 2.5G.
>
> Dropping is fine with me, but then you have to update the .dtsi. If it
> was me, I'd just make the binding match because that's 1 patch instead
> of 2. You can still drop it on the new compatibles you are adding.
>

Yeah, you are right. I will preserve st,6556002 fallback for
motorola,cpcap while Mapphone and Mot would not require this fallback.
Thank you for suggestion and for the cpcap's origin.

> Rob
