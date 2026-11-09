Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794204926;
	b=LQZHOKhY2g1oIF6MNHuvZajqlucXplmzpkeOgXmooeP9JAFgKNH+4fcDNYfys72uCf0E
	 ytrwFzzqnZMaDXfYsdMGfqA6AtiuKTFq9bhFzyPYEZA6wpQMcrjYdgLbboeI9GIW9uIdO
	 wgFkKlD6A2ZHywQmaGdNKOQtWXRQe1hHXRBtwZ1t7UwWQ+oy5/geGBEfTFlF1xuoNDh/L
	 aXG/2lg2WbmacGCreHpywk6YaTv8Kq7zLbDvYsKHAEmSPzVGF9YKue7VjlxGl+qK0qvEV
	 dQDGkpxLcaTaWZhf5Wzk+n1aeqGcqulBxfdPKiGH2ENe75GK/4u5BiZhIbDEKRAedWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1OirEdYPjNWlGy7xmMe0PuTtLR8bBFzhH374tYnu7hI=;
	b=Sy4Lp1Af4RP5z/7FyVzJiDmDdaCPKTJTlaP7Z9UBYHBlV5FdiosVV+lYT4xnlDc3ZktC
	 +S+iOLcr+qFbIUdoAgoj8uqyUsJMw3SVveFUGe8CT3cPDM5CGaLC7Sp4B0dTJ0obwdYGi
	 nXHlZhwZmpBjdLMVbsXVWrwFJfoph0fWGxFwgYr0izDSBJc1rE9aXmx56kZCghi09SF9P
	 lYf7Ug9df3CV+RWioupZPleKB22hYrxH+AHR2zxGFrZouhMIpso8Wrvz5HAMACcrncMk8
	 /9mBAOg8xiF1jk0UHl3iBTd+E4FKdgP+YTBBZeQCoPsX/I0ZcLuIJ0ip+I2UCX1CTdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VnjAxhbN;
	arc=fail smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C192606A323
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 06:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C192606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VnjAxhbN
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c49b431f022so80073566b.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 22:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794204924; cv=none;
        d=google.com; s=arc-20260327;
        b=qj7U+gu2x6Cyt3SqBiNWGhCPgK6VWzqDB/C5x9UBsugn7FIeur8vVbQ0oHleOZf2yu
         XQvOqmvKqkjXkru6msxrUjhU4F30dYfD7jmnSZWGttgkyflxhMnpmiOUcavhvD6VHGBD
         EpHmhGcrJgDpn9IIIMJChZcVdr5Qc9QfpP4vd0xtrvJbgJWSFtu+OFX41FrBcFTDQwTv
         xR0qQzaT0QO3vIynEq3/5e8iTvpxXO2+UARKPYatWKBbxB8EZZ3B5WrDtF6jKNEWYccd
         ox7mU9WoM0Gm91mBoVL7L0wpLzTiM8l8OzSMQt/Rw0NW7WKV1JU2hmnbgGJw1HOviskp
         OjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1OirEdYPjNWlGy7xmMe0PuTtLR8bBFzhH374tYnu7hI=;
        fh=mhmJsiUNDHh1kMFE/9FqoIItItzTdWVjHYZLQm4zK5o=;
        b=bRxhY1Rn+zg+hW+mQGiYmDiA9ymzWXJQmadj5sk8nUU1kgSGzgapco2rtEz0g833Hf
         i7Ap+Tj1tBHdVpzBf1ezpoN8297rqpiXXzv82/ZpUziIGhl5CKqGFsnKZuXn8dxGLpPg
         HNpvpkp+qSNktDzuYWqE/wPLLVYRMHnABXogdepmg8tZ3dPseaVEwfAQuRE4W52uGecc
         dssPaT4V+akXS71shthO+kByrftK5a+Uu4if/mbRk18HrpEs+Kl4ju8GdyArcxc/kFU2
         jX+lzMom1IZIu3IjAZx0qj4oHsN0Zg7rf2sZkS5iOHL5BTPXH6BpYhfNmygX6JKmTTW2
         wCdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204924; x=1794809724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1OirEdYPjNWlGy7xmMe0PuTtLR8bBFzhH374tYnu7hI=;
        b=VnjAxhbNIjKY+l3FrLTmF03OxcKJy99I711bzC3orIvQ/IyAT8tKQ1hKmQCwmbXoPR
         NGkudxmIUppfph+Fay5VwyDK8YO6d5x4aT7B195TrKrr5HfSwfg3KS7Q+PAYuhNhEPiZ
         IRenmIGzDopf4rYBDPbHVT/JQiS+FFrkbVxUynpEC1iK/+YOcP6QSwUx1yCz23ybDlcZ
         Y0fYXmWkLUJ0pXjH0yv1XqMBAArtkh8qyC5x2xrKIwOCmyiDeMmIfSUS/ABWouNZWEaa
         H12QVsoGGcFF3yvgGG+8UzKvr2Y9RB3LSzfnt0J6ZOp0TL3PJ3H1uIJuyrSmZaRtmYi4
         Y3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204924; x=1794809724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1OirEdYPjNWlGy7xmMe0PuTtLR8bBFzhH374tYnu7hI=;
        b=XYBBDONkF3n/GnBMM7d21MH0kJTkCOOJliN1aKT+Y3pWNqHAkQXGchCmkDO+S+qj0J
         cALBjg+p17P5Og+epIGqd0ToR04gMY4w/ymmmZPQcFP05ZCViI8Vpzy2jVWWj67IcmOM
         wtb89rQruwsKY7Ac8pOIzUKCFNR3i6p9W4s/oYEDi1LzjnKJYmGhOxKihe1+sGnB29m2
         FPv0ckkfglcnU2WTyoj0tsy1oxBziiTWYgRMoa/W2p/BFDmu0wsm/oG9M73OCTdfB1Ww
         Qt+AMe5Rgm2fwtZiDr/2NkarnePMR59aYZzx8GhMlqDXL9pO+4wgiTV9k8mZuDPpvBq5
         w5Nw==
X-Forwarded-Encrypted: i=1; AL+hErG8kH95TuZJT3ZNX4oRadlyrezqsRaTPDO3eX7fE1N9Lh7Hzg9pIxr9DKRspE31dQHCgOEaM2BX0L8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kyDnh7aIB1zhnxJN4H+geB3cBJC7y88/jQiJyN+gRgUs7fZH8
	zj8VHYOPrDjGK921vHgj/FMrpV/2pkpPbvFS5G35c+KtJulccvkhiegyuKPN4MzvDooKtZU114Z
	QrTCq97Eqns0TY9El2rXlo/VyKFpIoVc=
X-Gm-Gg: AYBFou2phZc7w4mQhiq5DKLIt2z0+TkXgS0pVUmWFmHsUId9SSLxPGmz/HAdZmHt73L
	ExVZjzVMzTKMVMtfp/UV3SeVqRHEQwIkHQ1gBITLhLQrZk90RXCUUT9tp4ZmAOYiWBHkSPNno7v
	iuuGljClDXjDkAPE9NPGe+GdX/VLdjeuSECIeajHtQ9h6HmSGi824rPZiwTVEEDp9COo4H6wGet
	GUCTELudivkO/mzXCShoeFDIVTnUWXKnvd+8wGiTk2BC3BR+W7r2e4Y1K5BZM8vAtg8FajV1Mau
	I/1Qt1UxgVmHpgp8O6MTSPz0YyD288TlfPpADUl8xUjNyQXkh762XOMhjpxyaL49d2uhNHE4zGM
	7s9PMtEldbEklGX1JVxISe/zgu4tZGFf9nZuBtLypGeTTqo2k+JhTDMtoujJzeNbP8sXsLS5ybT
	TCYEopAj+RknJOo7DFS96FlyWjAUrPi8a5LrC78Ov49FFiDXMmw3w=
X-Received: by 2002:a17:907:3ea1:b0:c2b:4142:2db1 with SMTP id
 a640c23a62f3a-c4d6d842e53mr191712566b.40.1794204924269; Sun, 08 Nov 2026
 22:15:24 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108095634.100517-1-clamor95@gmail.com> <20261108095634.100517-3-clamor95@gmail.com>
 <20261108205143.134d6aa0@jic23-hlaptop>
In-Reply-To: <20261108205143.134d6aa0@jic23-hlaptop>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 9 Nov 2026 08:15:10 +0200
X-Gm-Features: AclHuK8Qn06eeEYq6AauLfpWkIVYBvVrCQiH0heTOHXTTI9POYlOkAaf0cbYYK8
Message-ID: <CAPVz0n3uRoQAN=rk1dHyHMFxueK8Ry0UsDxkxA=jzgGP7Ykceg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] mfd: max8907: Add ADC client support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 8 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:51=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun,  8 Nov 2026 11:56:32 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > The Maxim MAX8907 has an 8-channel ADC at a fixed location. Add client
> > support for it along with its regmap and interrupts.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> > diff --git a/include/linux/mfd/max8907.h b/include/linux/mfd/max8907.h
> > index 35b2ede54f856..cf304afc782d6 100644
> > --- a/include/linux/mfd/max8907.h
> > +++ b/include/linux/mfd/max8907.h
> > @@ -153,6 +153,51 @@
> >  #define MAX8907_REG_MPL_CNTL         0x1E
> >
> >  /* ADC and Touch Screen Controller register map */
> > +#define MAX8907_REG_TSC_STA_INT              0x00
> > +#define MAX8907_REG_TSC_INT_MASK     0x01
> > +#define MAX8907_REG_TSC_CNFG1                0x02
> > +#define MAX8907_REG_TSC_CNFG2                0x03
>
> ....
>
> > +/* Regulator stride */
>
> I'm not sure what this means. Stride of what?  Seems to
> be some offsets in the register address.
>

Regulator register offsets.

> >  #define MAX8907_CTL                  0
> >  #define MAX8907_SEQCNT                       1
> >  #define MAX8907_VOUT                 2
> > @@ -165,6 +210,8 @@
> >  #define MAX8907_MASK_OUT5V_ENSRC     0x0E
> >  #define MAX8907_MASK_OUT5V_EN                0x01
> >  #define MAX8907_MASK_POWER_OFF               0x40
> > +#define MAX8907_MASK_RST_CFG_INT_REF_EN      0x01
> > +#define MAX8907_MASK_NREF_OK         0x10
>
