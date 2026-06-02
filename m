Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDC3D5666
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396317; cv=pass; b=pLGxK09Z+7w2/6IhoDrGEUZ23Vi7hmHB/mBYbXs3++qk6mk0ob2F1FfysaCMwjEKmtJfg78Av2K8hoCR5u7DTUvjvUtVAfXQuF6GUx1fpup46OSEdyHt7j9KbvzeamcUiiD5gfNcthBWfhB/jpl2ct0kC2v3nRJFZJ8h7TxQoXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396317; c=relaxed/simple;
	bh=FrPJKUKAeNpDp2O8s3b0xd97pGYPIKC59ry1jtVER0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTyFvXpxmKYTwwkTxTgi05igA5mvd09iFGIFHoBR+EUwhHQjWKYk/hQaxU2Y1Zsrnu3BNvLyTm0JeQ/BO/7JNC8eWwS1UowD3wwlFXoIg/xhS8UhqQF1RlxCRV9EcVFv8ix8SM9gjkDjqvnGT1R6ugj04dPU6ziRNk9dOHd4b30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgdcvLgs; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgdcvLgs"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-307263ad0cbso2140685eec.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 03:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780396315; cv=none;
        d=google.com; s=arc-20240605;
        b=MHzNsyoTEqScZN0Zzkc262XxYLtmqYGCWYUF27qwElZahI3Pd+G5CnxfjoH8n/vyyY
         H3BiuNqAASCDiE9wITpfO7TOTVee80LkQ9IVZLre0FJptnepsIWicDcMr7W2hinFJl1b
         HYFo0l441H98ArvgmheBv+i9tw4I9265jrID7K1rxiGeII+rWe1FailV8MBwEAW3EaNF
         dZyRIOg1PvcJsJ4snlRdQVXPBIHZnKCAKjAS5V7TfS2r05Ffy2kow6X9crPEhz/mdn1S
         ZdbUeakabibaTCTn3TXJMsrjW2lqVgtXfkVO/Xq/S/1/UFNM+CuZFhwib0vCLqiwP4Yg
         JEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lDdI0YPykfuK0xhOe7sArc4RNqAa0Hyds1kbH01jcws=;
        fh=1+Hh/uEyDegVXfEJe+vYNvHmWttWHPVpp5YDDpL52WM=;
        b=b44pLir7Pr93skg7l/3wMD2uYJg1aXGsF4IRfYxluyZnNwV8V8Aie4cmqcJWR+UQi0
         I/mEWpxxjh/qpzbYSGXydgyMi8XfmQk0GVCDwb0lvl1+OUMuCIHMjEnT838z8UHYNydI
         ruW/7Zyx6RRDmGMVQqy6Se1tcIegwQ5gDsNoMud/aygMK+jL+F259R6m4EdwlzJVgd1D
         w3yLl6BkuLlgtoByUOCF0WxA2moWd4tmOsezNtGl1xTlrIy1TgIbIKPTSfIBurb/XesV
         zLlXgfhrmartOLAFv19mdSYGLVojsi7lmEETLv8G29uY6T4f2PwjfQLlsiTJnUw7q5Vv
         t+oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780396315; x=1781001115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDdI0YPykfuK0xhOe7sArc4RNqAa0Hyds1kbH01jcws=;
        b=kgdcvLgsZ3uILaWfcIBvtHl1005DoEY8tGo67hlFEfjapWwGze3khJCdXZVrRKnA5h
         37CEtBPX6b8X0AaK1mntR77AtOfQ7CnhjfrTLJkgB7WDAz4Y/g/BYmJIegvqnORr9bq5
         n4OWtbMTtq/mjZcJIJcbF+jusrW4PmKgWNJhp8HOEGxYqPKN/UJEzHEriS9U5IkVSd/X
         a+n0v00qp7WOv4PuvEdollon2e7UV0qZEw4J8/TKa/gk16Yk+R6ZtCJeo0qvmGh4xIYN
         My3s/VQXDMREfLQ0j0hnhT0u5c0lkmltuEnWw+FvVO2NdGut68L28anjbQPSB74A/WSt
         icGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780396315; x=1781001115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDdI0YPykfuK0xhOe7sArc4RNqAa0Hyds1kbH01jcws=;
        b=RoR+19CJfc9E7cQ3sNdfQyzW23chIbkn9YHSmvwlzJXJ9ACMx77Og31L/NE63B092O
         OLIbhWxV/t2CtPlmE+DB+ZKnfki4JNDmaoBTvgiaLBz55sYnCYeZPXNyLTRTGZPgmLBi
         OajA2mai54KuqohPf4aD0whVHEcxXczz1J7D6pid12RtJkhV/i2sT893PLb9ABDUX4WY
         PgpbULSUtd4jc8A9Z4KFlywCVtS5TxmdAZwIHN2OAYGlfWKatx5h7RVZrAaJIw1AjYnE
         LqQC/1AMF03fTL3+E/1aiI87y9c23h49yUggtLJUnNhYMHUSqdvT7V+cBLjrHIdD3PSf
         Vqdw==
X-Forwarded-Encrypted: i=1; AFNElJ8cWGKnFiTF2Jic8G8h0cduFD9yT6QnM8xIWvipjSo7nDYuq1oZ4luOUi8hvRO5rzd+oMSTTWKd+ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJXftE/QAqCjReMQebJgwBv013SGW2x5f7FKDY3AV97dxiWp+x
	RKeCXSsS25pLROeLscwU+gOLqtoEpx/lLHF5vWdjq4Uf2tqmAOG3kVtcKPSZ+J8vmapyVxOPv1Z
	fYSp8mzP02fiyClPhgd0+qS4F8IB8K+Y=
X-Gm-Gg: Acq92OEZrs+Wca5bevNWuVOq+SqBr+78nOyYDzRL0xI+QEQ2aNlZCOoXLG94LClmqXG
	MukpqGqBNvy/C7eA4IJTc3n+KRiqPW1gPoNB692NE77p/C8KnwCs5qkMJXSpXzAW9tgXKJHahge
	ev/3hfgyKCX10zx/CHOX6a2spX5qE0xTZhIN/EzgN/li8A4WI18hz0ef5d8WorxFRggDCRvfXDX
	nrS6BkLXsNhSqO+cfbuRtf6MeDc1jH8rCTtbpyryZjLdwqCx/rzBb66sRpxYgweH8RUvXbG+Y1c
	Qm7I+DdL9vDfI4u7CJ03rkdyOog1lw==
X-Received: by 2002:a05:693c:2c86:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-304fa64c553mr7093613eec.27.1780396315135; Tue, 02 Jun 2026
 03:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-6-clamor95@gmail.com>
 <ah6TGjRNnDpQGO60@ashevche-desk.local>
In-Reply-To: <ah6TGjRNnDpQGO60@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 13:31:44 +0300
X-Gm-Features: AVHnY4LWQiJbbknL3YlvePeYbIxJnooafI1v7YVQtfA6307ubpWpYRL37q4rijM
Message-ID: <CAPVz0n21RGAaJc1sda4xyp1h0z+6R6FJ4=XWdOtB1mgtV8=RUA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:24=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Jun 01, 2026 at 06:18:25PM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
>
> ...
>
> > @@ -57,6 +60,9 @@ struct lm3533_als {
> >
> >       atomic_t zone;
> >       struct mutex thresh_mutex;
> > +
> > +     bool pwm_mode;
> > +     u32 r_select;
> >  };
>
> Have you run `pahole`? Does it agree with the layout you made here?
>

Noted.

> ...
>
> > -     als->irq =3D lm3533->irq;
> > +     als->irq =3D platform_get_irq_optional(pdev, 0);
>
> > +
>
> Redundant blank line.
>

Simplifies code perception, whatever.

> > +     if (als->irq =3D=3D -EPROBE_DEFER)
> > +             return -EPROBE_DEFER;
>
> What about other error codes when IRQ is found by can't be retrieved for =
some
> reasons? IIRC we check against ENXIO in similar cases
>

Then we treat it as no IRQ. Original implementation cares only if IRQ
is present or no.

>         als->irq =3D platform_get_irq_optional(pdev, 0);
>         if (als->irq =3D=3D -ENXIO)
>                 als->irq =3D 0;
>         if (als->irq < 0)
>                 return als->irq;
>
> ...
>
> > +     led->pwm =3D 0;
>
> Isn't it 0 by zalloc ?

It is, thanks.

>
> > +     device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->=
pwm);
>
> ...
>
> >  #define LM3533_BOOST_FREQ_MASK               0x01
> >  #define LM3533_BOOST_FREQ_SHIFT              0
> > +#define LM3533_BOOST_FREQ_MIN                500000
> > +#define LM3533_BOOST_FREQ_MAX                1000000
>
> HZ_PER_KHZ  (since you included units.h)?
>

500 * HZ_PER_KHZ
1000 * HZ_PER_KHZ

You meant this? Sure.

> ...
>
> > +     nchilds =3D device_get_child_node_count(dev);
> > +     if (!nchilds || nchilds > LM3533_CELLS_MAX) {
> > +             dev_err(dev, "num of child nodes is not supported\n");
> > +             return -ENODEV;
>
> Why not dev_err_probe() here and elsewhere? It looks inconsistent with th=
is
> patch.
>

I must have overlooked it, thanks. WDYM elsewhere, this is the only occuran=
ce.

> >       }
>
> ...
>
> > +     device_for_each_child_node_scoped(lm3533->dev, child) {
>
> > +             if (!fwnode_device_is_available(child))
> > +                     continue;
>
> Do we need this check?
>

This is nice to have if the node is disabled. If we assume that there
are no disabled nodes, I can remove it.

> ...
>
> > +                             dev_err(dev, "invalid LED node %s\n",
> > +                                     fwnode_get_name(child));
>
> %pfw
>

Noted.

> ...
>
> > +     ret =3D sysfs_create_group(&dev->kobj, &lm3533_attribute_group);
>
> No way. You should use .dev_groups.
>

I did not change how driver does this, just swapped lm3533->dev to
dev. I will set is back as it was.

> > +     if (ret) {
> > +             dev_err(dev, "failed to create sysfs attributes\n");
> >               goto err_unregister;
> >       }
>
> ...
>
> Can you think on how to split this change to smaller steps? I believe it'=
s
> possible.
>

No, I am done with tinkering with this patchset. It is broken enough
and it has inflated enough.

> --
> With Best Regards,
> Andy Shevchenko
>
>
