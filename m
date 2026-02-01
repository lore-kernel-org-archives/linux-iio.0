Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CC29B78F
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769929642; cv=pass; b=PrUrnPVg8+IHaqb0zAzXZuiFc6u7viRdsDShQpmLTNeZz7iYh/wneGeDAAHhsVPyZ5vnFQ1FcgxttPHXNN3EMIB44f2EOBSVzF7B3Da0F1MOe+AcEbZ25val3pe1haMuqti7aWCEMYS/yDlkx3vnZJryuDUYHEdRraTplYaVSdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769929642; c=relaxed/simple;
	bh=m43UbkmbLBc3R/MOJSbzoCwEFQ3lxNZqdfln+hRLhHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9sXreIwsqCVSkzQ4oLR4JudSRiWaj3ZifwxzY6YE3DzguVFqSa7Bv+TSUbGJVkkq3N/6rw9GB6HO6SFZ5l3dMBR0vu9LZUnP5NZbgJajJVheibdzB27qtw3wS3HLj9DBDN3BdoDGPMZ8UESoMYzeTlRtK1BSYJ1gNlqtNn4b/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIY8ZJP3; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIY8ZJP3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso20136715e9.3
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 23:07:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769929639; cv=none;
        d=google.com; s=arc-20240605;
        b=emUBrhOnXkjSSe2OPlrokJV9Ld9P0Jw947AJHRq8DFHcgjs8gAiaLNf8QnHQdEy3YU
         PMvJVuX9l9hOZpBot+/nQ3PIh+ZEqt/9b5joO+jG6aM8EE2e9aAGMmKJNqKUbvwb9d8H
         4q2UH9vpDXhtuKYFDb/PnX9qD5aGvf0DLvEEX4lg1ui9icqOvSj3A/lL3NfvSHVLO3hG
         ZttGn53TKk98JcmcZLU8Mjc4SNET4KDI2UvZmTfDN1Jj9ZzzRf9DTkqhjPEG0pW/0xlu
         WMck+uswJFMp7j/MyYn4yJ3Cxu7n6b0K1k6qBBaWnqvHDJQm4B42GvzCDiiZKtP/SfAn
         D4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VgA1XtNopgDhPd28c1FlWpyjNQUNZlwtx4L9F82W03M=;
        fh=XnwMM9jjryH6aDcwN+/aDi6u4kwkUlOMX3PG7k/A+Zw=;
        b=K5QqdoY6JnUSMw1ewynAEetpDrjHBRc1bHcE4lNOZHZ2fyA2DziG8qMuti5x9qQCP3
         pUWD5GjWW6NiB8EAOXyzzjFvXltBtEmWhYzY5w69adV7JZiSRLB+FYzblVCYUcApyab+
         ouXUwpOTWBSvcFyFVlVonRopEzaUNgngH+kVzio/4Wt9LwqHTBlA5c5bQGmX1DHm+0Ci
         SdrfPcwEjR4WWuFodimZvRVkWgPVb3hPsbqbjMh1LuJjAtL3npMnxJVFNBtarTJ6+1y4
         9jSBUTl+R/JWToTk+qDyET420hQW6xuF3K9Cw9W1MX/WWAR0X9ba8hzbKIIXQ22IZiIj
         v2NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769929639; x=1770534439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgA1XtNopgDhPd28c1FlWpyjNQUNZlwtx4L9F82W03M=;
        b=jIY8ZJP3nRcpBxAvG6e4g5y/0jzG2yQja7zNQQwx0ztOh3n4P49jiYL9GbTx11wHjD
         hbS0CAjHHYArQfTGirQGaM1u6uNbwpcv7QK0M/Onoq7aQBcS01uHg46DLIVPiRd5oY8u
         1q1UPrgCB9TwrMJ12g73KCeA0d57kCCi6wVONFCAnkHGzYYWF11m8BogQDZGrj4Udn5P
         o9m8EY3WyadvMbmsRKnRC0X6VO72Es9JRQNIxim/MRb/3v91ZTssIO3WD2igXDg6sWP8
         sXGtjy+Oyx7SfzY+Q4pCHPjCqdHkmxBsJndOJQvTagzfa2DQwyBGxnr0eNVC/4UHXSJB
         s+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769929639; x=1770534439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgA1XtNopgDhPd28c1FlWpyjNQUNZlwtx4L9F82W03M=;
        b=F1ePAWsXysisA2yc/oqFDjLz8uFphYwdzoE4AHWPfjjMl+OvtHT4MU003+dTYuEWYH
         rWJHhnihcGZTnDhFVlPUXB9TONN8X8scQC+biCR6DajpZXXbsyj6vICVWisfeEq/CdLu
         7fR9kSh9/Vq3x/y56CICj0dKijqQhH3J6qQJt0XeaM0pcG+2CT+CY9wHyedMRX0o+tua
         8gBBpi4J7YbHyzlpAslj1P3pCizlgZiytU+NZ5xBNVSkLDmTwdXSgx/UGbwJSx+uThFG
         dGUGTJ8K7NjJwr/BDPLRSNg8Lh9bWSO2Jgu14Rm15escuwlECCKvNXh9XupNUoZyruCM
         RV0g==
X-Forwarded-Encrypted: i=1; AJvYcCWuP74KNXNP+XukLgp1mcRAes3VMk0YRCS/cFExHW68MkbaKxpIlCuQQfQJAJcFrlFsJuvaTv9q0RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQs+5LuYP9HWg2aSDlx5Tl4TSVVKAe3lbqsoY/U3lHh0fYg8c9
	fJbiVrTYf7jbdxMdUNldZBoIDPpBwuerv0dNv4Gvv6TaKZRPn4QZ4jGgc7El6TfDWuxwpTxid6t
	gW4adesZemjbJl3Z70zNCvplHWjTpdSY=
X-Gm-Gg: AZuq6aJg2Q6wlgh7NzM4eI8z/dQw68Y+t2gKGUhnKlUBpFO7Kvnf6XCuteHqO7a4/QL
	79CTHHaBK7AkZnQIF/1/L62PYV+q1RD5hGlUPH8+YZDQ3Nms6HmHuQzFs1rLJSFEYJt02gepNBI
	BnoXKWQhWFRoLWn/EMbCcvtB5D2k3y71IjjUPtzwmAE4v7x1eK6lgz8taAWBLsrLiQzAr8SaNMg
	Jxz4KzYhpaXtZHo71tUgDmDDQACwzSZRLLZ0Evw2Tc8LnTLJ276zmSFyklH/MszqhtgVZxW
X-Received: by 2002:a05:600c:6092:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-482db45441fmr96523965e9.12.1769929638889; Sat, 31 Jan 2026
 23:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-8-clamor95@gmail.com>
 <8bd89524-dfc3-43b0-b0f2-cdb1cd51e1ac@baylibre.com>
In-Reply-To: <8bd89524-dfc3-43b0-b0f2-cdb1cd51e1ac@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Feb 2026 09:07:07 +0200
X-Gm-Features: AZwV_QgiEH1CnR4Y5eJqYT3-6LdT1ghmK5ngGD3UdwSwjKt6ss6U4z-A2BxtD6Q
Message-ID: <CAPVz0n25ukBJ6=hmmR9nd4MBoPkHaHQ+ZHMXYxghYZdkB28_sg@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] dt-bindings: input: cpcap-pwrbutton: convert to schema
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

=D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 22:02 Davi=
d Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> > Convert power button devicetree bindings for the Motorola CPCAP MFD fro=
m
> > TXT to YAML format. This patch does not change any functionality; the
> > bindings remain the same.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
> >  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
> >  2 files changed, 32 insertions(+), 20 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbu=
tton.txt
> >  create mode 100644 Documentation/devicetree/bindings/input/motorola,cp=
cap-pwrbutton.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.tx=
t b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> > deleted file mode 100644
> > index 0dd0076daf71..000000000000
> > --- a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> > +++ /dev/null
> > @@ -1,20 +0,0 @@
> > -Motorola CPCAP on key
> > -
> > -This module is part of the CPCAP. For more details about the whole
> > -chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
> > -
> > -This module provides a simple power button event via an Interrupt.
> > -
> > -Required properties:
> > -- compatible: should be one of the following
> > -   - "motorola,cpcap-pwrbutton"
> > -- interrupts: irq specifier for CPCAP's ON IRQ
> > -
> > -Example:
> > -
> > -&cpcap {
> > -     cpcap_pwrbutton: pwrbutton {
> > -             compatible =3D "motorola,cpcap-pwrbutton";
> > -             interrupts =3D <23 IRQ_TYPE_NONE>;
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap-pwr=
button.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbut=
ton.yaml
> > new file mode 100644
> > index 000000000000..643f6b2b1f13
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.=
yaml
> > @@ -0,0 +1,32 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/motorola,cpcap-pwrbutton.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Motorola CPCAP PMIC power key
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  This module is part of the Motorola CPCAP MFD device. For more detai=
ls
> > +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
> > +  power key is represented as a sub-node of the PMIC node on the devic=
e
> > +  tree.
> > +
> > +properties:
> > +  compatible:
> > +    const: motorola,cpcap-pwrbutton
> > +
> > +  interrupts:
> > +    minItems: 1
>
> Should this be maxItems: 1?
>
> > +    description: CPCAP's ON interrupt
>
> Or I suppose:
>
>   items:
>     - description: ...
>

Both options are perfectly fine for me, and I lean towards using
"items: desc" but I would like to hear what schema maintainers would
say, which layout is preferred in this case.

>
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
>
> example: ...
>
> > +...
>
