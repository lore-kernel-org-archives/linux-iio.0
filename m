Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970F326938
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776599470; cv=pass; b=NZlQZ4UITK5n6A5cCSDyOvk0fOS7ORHPpox1SjHK35/JnYDo/rqTfntS5r7zYNY0NOW3HRDxgSkA84/mh5KW8UUUp01ztKuR+kPELWcXAHU9uJSXLMYUFf7YUldvkBm4mhWuBaJmd/7oWDE/vRn7Slb0q68PtZ3QeJSywPNYv78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776599470; c=relaxed/simple;
	bh=YFp/ewbau35oN7gDA56jyAxYeb909Rw3ZdgCe0T18io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnl4mMNUDL6OjYGKx5aOFvGojYsTIQMsiE912GTtlTiMWIh5R+7OzcN+a/v0ZaIABxZMqElBtyGX5HWwlVFiYtRLIR18HpHjGRKFPPAHqYIt4wT7918+AO4jHyR8uSSS1lZ0btqj+cDhpO8N0RryfuSXjLQ+k58nH/21iNs6z7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULlXizHi; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULlXizHi"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d77f60944so1628656f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 04:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776599467; cv=none;
        d=google.com; s=arc-20240605;
        b=c1KFFH0gczZ0qto+dvL3ypIyKBtD2DR9Vza0gOUCCf08V36VkrZw0uGFJ+XfdnZROF
         kXsZBCqr2ax6PfMjPELOyafnr742JJbfHTHk5FloO/qoPWQQhcd/N5v48zXf/szLCRpX
         5ziKzy5FfauWy7YMFAtlXxKbVo9IpDPvm9StN81XfCsTd3J/dNZBaaL4Ko7Y6HMOfUth
         poQqfRqcoSgivRBXujAcfO1I8r6pJ89j365NJfMMqc3EiV9MCdetmC9o1JcpViAOjzzP
         5lEwMQJn+522UJYcBjUme3ypCTKbBkkCGcl937HGXVWOltl0vNHRSsi0ztyH+P/vMcHO
         CAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tncWQPfYyaqZlRgPygAaRhu74GKThm47UJdwkoBU6aE=;
        fh=Lbf7et+uuHvMNHpQOuR623kNUpVgHlwKUjeeEvRGkZA=;
        b=HHJKCFsu2lB6hhUVD6+1BCtE47FS/zof0pPbBlLOs2d0WRc+10Nd/bQy8cM8VjUJW0
         kE5FcwIgtHWEzOs7pTccqushYJnIDraZYElYy/wagFe4/AqCwJgIKIClIA210910sVMb
         u/65zenwcKZwcBNehs55Res6XYD6OPoctabC/qYsNVh4bLBz/O2DNnzRLvKM1jQYwin8
         comXAeGRO8b7Mi8S9MuPifME17zZ8Hc069TwyV9gE+hk90zQ2DQTVVlM9iicbd58L1Qw
         kIcHOhz/DCpdsf7QvNRAWE8YhxIEbmbv3bYgIEN3+XBqWvQt0/c6twFv4Cjvp2f4sgdA
         Gtdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776599467; x=1777204267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tncWQPfYyaqZlRgPygAaRhu74GKThm47UJdwkoBU6aE=;
        b=ULlXizHiYDjudHl9qXhJkmL+V3dEip6uM5SHtuB5Z+uKFiJJIHbVopdSvws/mWI5Li
         AVhXE1kDBm06a919Lz6TfPql8hdQ8WRki8hLSxwzNrUpyxnIb3UckqJbzecVetT1PJH6
         HfoAu1PJhxvVRtmYAojgLLcqpK8Jtn/2nu2dvZC6HomStMhvvp2MUREp4x15gvCR6gjl
         AZ6b+M5VW68nyHOeiiXRFIjl/bmvu2eJNxcDzxWobI8w2IBJDH6I/3l5CORfZF3ed1Om
         SWsW5vnemQIKTD51TQBJCMrtP5GLxavNCo/aoexnZ1bP47RM4Isxkm2cG8Dqf0UtppHc
         RY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776599467; x=1777204267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tncWQPfYyaqZlRgPygAaRhu74GKThm47UJdwkoBU6aE=;
        b=MKzvzs6u2echNDqTqLX/nRicfwlDXDK4Q0LTDDtF89ptaQzcwJpU3q87lbe/wvkqSR
         XRVD1kD19iaV2IW0xge7CJpcQA8Wy9BawbZPPPZ6mOu1YBM/xbML6UCqFYNVYQyP/1/A
         spCM8E60B//LYuVj5X0nsH1Gwp7/Ht2cYfmlqUHjIDVK8OL9AqSyOAhbTEVze/uaTscJ
         3+v2WulLWt7r5n8smVtgRmHAA19KanKs5aNekIBAg7JaJTQBlGJ8snCgbRm9FSmV7mjk
         E9OJp30u9BWvscAFpv2SDf9maDJf0mwl6A/Hk2mLteUGD57HzEp2r2Hc8unfg8+g4w5j
         mN6A==
X-Forwarded-Encrypted: i=1; AFNElJ/iXTIYpcnYY91dbrGHdZyEoF9/H/qHmT8wH0bNbqfFLPuFuwQjXkRMWkO7+CL6nbzRmSDUk2YLoyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFPxAzWSJD/q4D0FdqKIVRmxFDJMDZsvFJaVwStyUNamlIRaq
	M+2CmINxQKzc+ksjIlSbYOqraWgGSfO4rXVzkt6taz05+AYwJDL4vJNbvlPQx9rkjDhpDf61O+N
	44XNgYjLFiASM9c10HLepXsoGFdeXAtk=
X-Gm-Gg: AeBDieu7E8kXykJIMdpDWaB8ZKJfb0udx1M0PFTCpaHPos3AqN1FxMvqbW5EqnjioDI
	H5vabTRlEZLaj3qA7sXb696Uyi2CcAydm7zPgAEkP6AONSvrefifmcYIrOpjXRE0mbZmGb4ybHR
	9bkmQhn2Ce322GM77SJ/e7mVL95HkBroiC1/X2oaenmzwuhDgMW8NidT+ypEi039S2QdlNI5zmV
	IZAfH1Nxm88bWXP/2UK9EqF1zEb4cg12sVrX//zXe+63Ku1JEevXxjwWkwW6iwLFgidypvndICa
	n93Wb1YyNLD9a8nUFi0=
X-Received: by 2002:a5d:5f82:0:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-43fe3dc842bmr14658844f8f.7.1776599467085; Sun, 19 Apr 2026
 04:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419083125.35572-1-clamor95@gmail.com> <20260419083125.35572-3-clamor95@gmail.com>
 <20260419122950.67355f4c@jic23-huawei>
In-Reply-To: <20260419122950.67355f4c@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 19 Apr 2026 14:50:55 +0300
X-Gm-Features: AQROBzDe6HM4uuoI0FaMpknWQm05f0KEdcarfEIwiYOb4XhXkmoLtebse2uUQdc
Message-ID: <CAPVz0n1iB9iC+TFrGK5ajXjdk8-g8vzr4ZbXdvW5=F8iukanaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: tsl2772: add support for Avago APDS9900/9901
 ALS/Proximity sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 19 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:3=
0 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 19 Apr 2026 11:31:23 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > The Avago APDS990x has the same register set as the TAOS/AMS TSL2772 so
> > just add the correct bindings and the appropriate LUX table derived fro=
m
> > the values in the datasheet. Driver was tested on the LG Optimus Vu P89=
5.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Hi Svyatoslav,
>
> Just one small thing.
>
> Experience has given me a strong aversion to the use of wildcards
> in naming within drivers.  They go wrong too often because companies
> can seem to resist using similar names for very different parts.
>

Noted.

> > ---
> >  drivers/iio/light/tsl2772.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index c8f15ba95267..8dab34bf00ca 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -127,6 +127,7 @@ enum {
> >       tmd2672,
> >       tsl2772,
> >       tmd2772,
> > +     apds990x,
>
> As above, just name this after one of the supported parts. apds9900
> That doesn't stop you using it for multiple compatible devices.
>
> Same applies for all the uses of x as a wildcard.
>

If this is the only thing keeping you from picking this patchset may I
resend with apds990x fixed right away?

> thanks,
>
> Jonathan
>
> >       apds9930,
> >  };
>
