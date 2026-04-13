Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE3391E54
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066334; cv=pass; b=Zu+HmsWQSfA0lUC8upqluSbkoIJ6acGVKcoABpbZeyRCnDA4PxhbFfQ3yrEqjMy6xExUYr3tc+nJOQsC2nlV7DaWc5qnuJ9B6P1FBwCX66S6ipysQQ6ggJG3xxZPXv/rJ9lkwjRWIqhqpJCvLcgyFukpADrk+QwgYraWYnQWhh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066334; c=relaxed/simple;
	bh=1FXKnl20PJUiPS9posIRbFjif7nY77RGUWe3QN7ImXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp+5TXlQewJKmal7fkX/I6zohTtea9a9ImCHcAwbV3Nzn5bL7Aif3pGsnG9swTS8tuX6S3ikJX1rxfUrj3zAt36PJZ8INs0O7jQlTZhmuBWYo2aNmuA6NOruQsWU0DtGF07FlUz55t2/uKH+ud24DL1p1CoLM42QjVwkj76G1bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frIqzcXN; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frIqzcXN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c6f1d1282so537542766b.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 00:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776066331; cv=none;
        d=google.com; s=arc-20240605;
        b=jWXDwwePFfcVZOYEkOON+kFTaLlc3p23zeGT072+KVWZ1pTN01VXhNS1iQi58A1lv6
         Gjs9dP2rXg5lCd9QZGX/F1P++W97YY5icS6OSPdszOmiBMk6TMnYJFbgBwG+FYbHhBQ/
         Z3OWi5s6rI0CMP6UxGWaL2qVcqPBk+Fj1nDl6/cnUwf1cVmhCkDOp0Ze6FQ0ljMptxwU
         7L34J9NznLY3z2WHdPy152hQxP7oVyHEHXeBRJCaQuCRj48+vPAdIzt8oxfffvEHBUKQ
         FnJ+yOVHlmlT+hbEqp0AmGtVJd35OHWA9k8KdtgmqcYB4JHHDP0cltapwG8Kn5IPrFP0
         wjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnqixEkGW+9Zp/P9ornTQQICok6llGoX22gpH2/U8VI=;
        fh=0HPMbxgxg56xcQCUgtW8Sr2KZr6hov5pPZ+lKglbsqE=;
        b=XTA/52J8Eol2YSDVXdG86O34KZ6JhA7NWgOINpQqA/wn3XbwE729dRBfxhE/0PDuhp
         KYc0+CalQANcMZhnlYb/1TdIQ67+t98zAraY3L+4HjL08L947mfJ1qER3yIDo9Owj+uc
         7yE1WiG1F0NSApjK2frq9hINbMbNCli8L8SQICPwlKC20WKzTzSk09kGaMdLNfZnb8b+
         /cv2pLec+7cfE/hTje40uik9A1AY3pXiHAneOyhFah9THoKJBr7OBm9Ff1K5rOt6iFNQ
         3pLMuc11jL1ARmInZBbWy3YFoQEJln3klxIGMWd7bwKQge2wGnOoh1LdLWI1b7PdxV0N
         bG4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066331; x=1776671131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnqixEkGW+9Zp/P9ornTQQICok6llGoX22gpH2/U8VI=;
        b=frIqzcXNCcZAlhm3iWOg856xjxW3dF7Hn1qF2+U7YubknI7pN2lexrB1YbJasci8Bs
         D8RLosGPBx1v9zDcLRBJjMa/OqdABHpSAwswrRZRJfT9InxqH3quP+Ssj2Ohg/8BMJAm
         OXiet8bFf1HF90HQKAAiyK3PIWIUllPKDbrZd186koE5aGXA2cPWn/MIVq9qkhQqBaLz
         jNN4pO9MgnWLT2hIvp98x8DMA2A9XNkW/BwYKCO+yw7SvuCAnKVYJgdoYOBkitBmqRGN
         G+AbCVWbsf0wfetlCb2Wb0MTDziAOx0Ttb5Iz+lvpDfqy7QXy/DGJc5VG5E1JfjEK9f1
         OkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066331; x=1776671131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnqixEkGW+9Zp/P9ornTQQICok6llGoX22gpH2/U8VI=;
        b=k2JdoaH8+Oj6DzGegphQBXUJ6srzlKi4SAZsS2xD1MEgVnCoMHeC0iojnGrgYjwc2n
         rsi1qV0G/IaKds2rIy50EP9eOnaXDLjSU4UOoUea+ofDbSyzi5x/ewTnylkq2kJRNnpz
         MSzUb7YEiWlugrmgnQdaFqvRcQlhY06BiJ/S1czlCDLRihO3ptyO3GuoUwlh07ZSLYl7
         nKYsB+Hr+8Y5tcXMU2VvyXTse6UrOno4U43z+KYGIHdOw52XWgkJDfX4PkfQfkmCtGHX
         KhKNWTxycrAAHqu7HoBdjdT71f9gyil1KiQQId+kalSn5nRo9O7MWabMiyEOoDcENX25
         rkcw==
X-Forwarded-Encrypted: i=1; AFNElJ+uyhErHVa2Z/jdWuN6FWRwaEe3aUPLDdPIb2VMwW2+Rr/bf3tdDIxVofnXEsdiWhB0PP9M/IieKGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyrsbbksRyIFaiyQ8B36xcz4MErRxnHfgKZnAHlJUYPt4Zh80
	8ZofCIWdED7DjVucKlK8HPVaz+l2+suAwIJnNwM48tcAbmOOZkbmMqoZMiaNbypP4Q2LxoDDzmQ
	a8S/R9heH8YyBOtNlK8sV+HRU7wcSPg4=
X-Gm-Gg: AeBDiesyGAwalf+WjGQSc1DFsKICjdZ3tw3b2iNTVbyUvPccxlDS8qzemHgx+OvlwfZ
	uSwxoIOfPW1/d8u0ShUCSBvyLdxvxDOO5gHNCdUc8bAX7DKvWenGSqAfIYTMAbN3nyvf1MuSq+7
	PJNT5g0g6CpGDZkvlRKv+ErlzofLQ/J5ng/G4L1UI2X2yi6jlMhfYjbsFxCSHpn+nUtVukM5Cs9
	Xn03fuJPQlnRv1oko2OSPnZu3Dhz088wRs21ZGVfPfyuZOClboBfGyKPnfB/aAkwWrwipv+DIeg
	WqrdGIJu3an1lrqrlIl/ENJ+6hKhjEznSGw3lW/rwu15FbMpWU37dz9hq4ovDV53/OdrT69rNpo
	OAUSHSq4=
X-Received: by 2002:a17:907:7256:b0:b73:2b08:ac70 with SMTP id
 a640c23a62f3a-b9d72ad9ef9mr661517066b.49.1776066331369; Mon, 13 Apr 2026
 00:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com>
 <20260410-dev_ad5706r-v7-2-af93a4caa186@analog.com> <cdfb9deb-2439-413b-8c20-3c6ad6a81ce3@baylibre.com>
 <PH0PR03MB63515AAF92A4F2B6F7C26E70F1242@PH0PR03MB6351.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB63515AAF92A4F2B6F7C26E70F1242@PH0PR03MB6351.namprd03.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 10:44:54 +0300
X-Gm-Features: AQROBzCZ8NU3HcLs7SXQbD_oCz0l4yiFTm2pzR_sJZM7NsZ80XLspwkdW7zsXr8
Message-ID: <CAHp75Vf7Y3m11YahS7NGMZjoNQnBZtrN3bO+US5YUcU39HA9Bw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:16=E2=80=AFAM Torreno, Alexis Czezar
<AlexisCzezar.Torreno@analog.com> wrote:

...

> > > +   /* Extract value from response (skip 2-byte command echo) */
> > > +   if (num_bytes =3D=3D AD5706R_SINGLE_BYTE_LEN)
> > > +           val =3D st->rx_buf[2];
> > > +   else if (num_bytes =3D=3D AD5706R_DOUBLE_BYTE_LEN)
> > > +           val =3D get_unaligned_be16(&st->rx_buf[2]);
> > > +   else
> > > +           return -EINVAL;
> > > +
> > > +   put_unaligned_be16(val, val_buf);
> >
> > Can't this all be simplified to memcpy(val_buf, &st->rx_buf[2], num_byt=
es); ?

Also note, num_bytes still needs validation.

> > Or the whole thing simplified to:
> >
> >       return spi_write_then_read(st->spi, reg_buf, 2, val_buf, num_byte=
s);
>
> as discussed above about mem* and spi_write_then_read



--=20
With Best Regards,
Andy Shevchenko
