Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F63DC4D6
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891489; cv=pass; b=DphREPmIRhF6rTPx1zpRQorUSV8vFXodjweI5epEJzs8eqVLs2nGdiMM3VThdUisEihxIdHKVnmoroq6SakmYiQ1yNcilLRYFeHw0DGL9zGHgveNCL+yX2vxcqzAy7NONXlSIc9N/O7emAaxmGr4E88eLjCvAidMlezjXLuiQt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891489; c=relaxed/simple;
	bh=/POCNtVCVgs8Wz8mZ9O1D8ykDMaaTk6zJm6BSwE9+PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoyIabx1S/+Closu2Yhd2YB+xK1vhJh3PPdYLw+EYY36oj5mggOviL7dX6xuFZPbGIrM+yq0pZwzIRWUJoRucliPt1Y+posZyscrYasuuOtiHNVTlITDJKzj4aPtrvSRmo05JmmEkUFLDtWRSZkRu2Byqtf2nU6ACyLBcZmY1AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V76BZqIs; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V76BZqIs"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b980785a0bfso659549266b.3
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 10:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774891486; cv=none;
        d=google.com; s=arc-20240605;
        b=Drgghiz0tTA1QD/UAuvxumNiw4+ZcIkQeKE0MWo6RJGNwAqoxk5Lkrep4NQbsCzzgD
         XUPjIwT5IqrTrMdH+iiGaSxK0EPj6ZGpqnkbVUTyjQupQIfB1g21uYCkp1klnGHf9JR3
         8ieJQmWaWSUg5H2vXP3tyG8/PFle3y+qNJXZyi0PKxZJrLdeS/5mV54QnMy54LcDim5R
         q/J5BTWj8DRxRhpRhGWcP+e6grOR4fCsiMj1mOpmXJ5mn976haUuuviHL7ucoy1KO7hS
         UlcrZMfFJxXm26t3T5AcFGJewDNmIE6vN/eBbp7Kf0kvqijTE7Fx0faIqO67IxEpL7Ts
         6Gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/POCNtVCVgs8Wz8mZ9O1D8ykDMaaTk6zJm6BSwE9+PU=;
        fh=9+KiEF0MheCWNVVqgDz8AosrbqKlbkN+/FTee9Y6AEk=;
        b=IrZVY9Rzhy7v4GucZDWkS2oHbvSOb9R+X1aihOxZbOhZ8ScecRw1DUQjM6i9pMq/0P
         faklY9uI1jdXKq3Bs0k3q73iMVpVRiXFL52+FC98o6UW2FgVpfhwFAMFkK5sO1+jXc9F
         BnaqQ8arqwVpZFyhxd6hPodWeOTC0dmVPsvyJ5isYTeUT1bACDW4gQ/04mX0tcGtjJAf
         yPq2T3GwNrBwXit6SlYz9Z+wTxc7AODWU3uLL3SsiApDCcaF3lxfZ/WMaYDy1sxWFrG3
         IOK/uKFSPsPTUclWo4u7IW0c+uZL4/9UkMDBNu7TkK86crW0/pTM0OqvkB6Wecpf9uoj
         jPCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774891486; x=1775496286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/POCNtVCVgs8Wz8mZ9O1D8ykDMaaTk6zJm6BSwE9+PU=;
        b=V76BZqIsg6SY28n+CDDu+IH++PLSb8MJSlRIvY02cnLUWXpaxB91LN/qlH3xzlIxCx
         OJpm0KiBuf6pIWl4hS1tBcqhmkha9q0QN7jpVlN/RWZSajGpxmqtZstQppDr8zTLHfCl
         7/3yLIORDyGDv/FwB7cjm/RynB6KgTd3CbCbcKooE15JDQcnwXYC3TG/cD+TSmFNry9y
         qase5dwhuuHQDJ75vNqql1kmgBxzGIcszCChHk74hP53Qdi5sFznMywjfIRhJmz89xoa
         FPIC0Py+qZ9XjashK4KXSbxEdCIEca9UEaypsvN6Gb+8PtPdnCYX4WzuDT0B1re+KOEK
         PpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774891486; x=1775496286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/POCNtVCVgs8Wz8mZ9O1D8ykDMaaTk6zJm6BSwE9+PU=;
        b=T1ZG5as59UjOq41HJbo5yqA2njbyW1WarYrpKMUE8cT4DZK46ptZ/lNgjVaXk+0beu
         FgYrzzrKdduEKUp8giMuyX44xq1c8T9UEeVK4yzhXVP2RBndoE0MuqLkFFxBoYTBEBxd
         bdUbe6XZsOJM/rgonQORihDEQWChB6ELSxrJg7sGjLC3sKFRBWyq4VhPmsH6lW8RC07o
         wx7g0XBgUMLE9qMcZslqdxWeO+Cr4SvozUYFn3USrQiROUcXhHZ+gX/6e4TRoes7tl/y
         dOu2LJ23Iv/moF0WQtgic53XtRKGRELPVBM/u8/jyJ6ByOI8K1QHjXqmRZTBunXlvZBf
         x+fA==
X-Forwarded-Encrypted: i=1; AJvYcCVywuQeeVhWk31zprY4wkoR+4epoS3BZpFnBjPWNdSlvLQwmPKK38LS1qDgzgrDhebUZhaF7wQ90D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0vCHjhoXH8S/9MsGBqijgztdFaiaS6Je5co0AV1+k/+Jc53K
	Map1QibxAiZMtDI52Bl0eSCwJrzcYU8TzO03ODUWLPBhOT7Mv8ycbVSPWXxak7EjmEVv8KUnspg
	jHj5V06RmpBdeRifNnUdoVe7/x1PjCQ8=
X-Gm-Gg: ATEYQzxL2WzrD9OMTcbNu8EiHCuMiojzlT8mp5faka8tUHx6USX5IKMdaJmzw4RLnEh
	QO6+sZHDpAdN4JREtbj5eV0fxekPmZK/VNxxh4byfbjDHzUc1yDn4rl23vOH3mkL79dNzYKwRCX
	GMfRyW4gSVYcymRT0IS7YYq8XmZjwfDW98Ez7usFrdlWZWQzkWWF5yT17QscSBKbwWRFhuaECq+
	0PoZS5DRKlAhjJzAjQXJAYU/hcykS6OzFllo38HgEDods6/bJ307WTCIKRS8RKby0r7ExsXyySo
	YJ7BWEPuaR4I2J9kl4suNYyuk9FWLGlrCA8D64YGwzaGha5yldcbxMBo3O0vDeE+hXHLwqUUqAn
	03X/nqKs=
X-Received: by 2002:a17:907:9626:b0:b97:554:f12e with SMTP id
 a640c23a62f3a-b9b50350860mr690721166b.14.1774891485468; Mon, 30 Mar 2026
 10:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
 <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
 <acZrthJYQX-h_9p5@ashevche-desk.local> <LV9PR03MB84143540CE505514E1CD84B4F752A@LV9PR03MB8414.namprd03.prod.outlook.com>
In-Reply-To: <LV9PR03MB84143540CE505514E1CD84B4F752A@LV9PR03MB8414.namprd03.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 30 Mar 2026 20:24:09 +0300
X-Gm-Features: AQROBzDi52qTqIm1Vf3lVJqwmlc9iA41VGN7nD3k385cLEOQCXsLlg-VEZ4M7zs
Message-ID: <CAHp75VcUCM8aeUpNaFEXnS+Cm08Mq5j+Qp2gYqWP9vCO+9CtQA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691 family
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 5:20=E2=80=AFPM Sabau, Radu bogdan
<Radu.Sabau@analog.com> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Friday, March 27, 2026 1:36 PM
> > To: Sabau, Radu bogdan <Radu.Sabau@analog.com>

...

> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/cleanup.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> >
> > Hmm... Is it used? Or perhaps you need only
> > dev_printk.h
> > device/devres.h
> > ?

> I have checked this out and it seems device.h doesn't actually need
> to be included anyway since spi.h directly includes device.h, and since
> this is a SPI driver that's never going away, it's covered. Will drop it!

No, this is the wrong justification. IWYU principle is about exact
match between what is used and included in a file (module). spi.h is
not dev_*() provider and may not be considered for that.

--=20
With Best Regards,
Andy Shevchenko
