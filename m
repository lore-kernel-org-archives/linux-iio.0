Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938D1482E8
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490317; cv=pass; b=nimGbYNYVhN+YaIlwwpAd9lBICxGBQJH4peZM/Pypn+Rv5lVE/oiWAy9BtXH5zj1t5XLJPg2khQBDgxsqaNI6qvtyQ/HykCeJpIUlmbfBdql7s+T7t2ifodLdrPt4j3ndyve8uTHKpKWtOv8+nSE9p4SPYZyDprNWrme3h58+Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490317; c=relaxed/simple;
	bh=huDLNzGzY11EXM+Q6TVxrhzAr19PLBuVbxUouLMLkVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ayb0auOwjvzXO06f5GZsbdvP29gPFg8xfiym3+zP9vRtNsAmSTEAKqe22g4ARgQrtx77FdZSE4HupbZMiLaN4hwIyOFtmMN66oEHfnvh19wDIpaqVVPt5X2C/NGiRlH8CCjyYnOgU6sG7n7pR+I9ugxxG+RAu64eNs/dZ/Z82uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Tz9Txyfo; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Tz9Txyfo"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651b4d09141so278115d50.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 12:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777490313; cv=none;
        d=google.com; s=arc-20240605;
        b=DaD65Oo6HYhpeDQ2iTcypM+UZwtpn9UdeUkCDShNV/aGcH9VITgk3NKEs/SgjVlfK5
         9rgGJ9n6S024JxE7B4HkoNdB1A9/nAQQ+E19/xSyo+PmalpPnR8fNLp3nRvqD0v7S4X4
         muwnBcunRH1DuPwg/V7j+wdUSEOIsKQVGmnW+Qva8U6F4/wXyt/YhQ0Im2VdLgr+cjpI
         zZpyn0xGcjwrQz0vyA+ocCfj+iE8esURPk+cNOGNf5WpTlxAU/LDSZMZhVjQyHn8uZCx
         8/B2HypEDvv727ciTZjrvBOG4WRsq4lewbBIsJOPf6uHSt88Khnf4RRPAnXQshvdSk+n
         7Xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=evfYZBjBW8bQqs5i+ZH7Q74L/k3albA2fI4MfsScnAw=;
        fh=JUZ/xV6SeG/uuMFvlJLFcu4BzfzawZ+xEh9NU4qOskk=;
        b=iCtDzwPI19kZ5MoE/C/03oJC+xjFB2GL1FNEKaJTJAAInCqPPp8KRuedmjMOgq2UM3
         /ZnQrKTACEmJYw4lq6CHf0pCXDlAbezU/PeKLhHKsA3khlXvpq+6rdRcWQndKRz4P7vh
         FeB1JGvh02mM/PK2mnO9NNadZxZnHCsrYXJOUO7vmTdyJCzUO3pW17+ep6YxlCC3UI28
         ARb0Y0ozttfblR3ZCebBZ4z9WJP+2rRaq0ijnjU9a2M5LTGtcjGNqXPJsQkpsa9cB8dQ
         B174Mf7a/25rO0D+UsRh8vhoG7ebzi/28/5SuaUt7zBQzld9dUAjhxqmLaBoceWqyfX2
         wwSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777490313; x=1778095113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evfYZBjBW8bQqs5i+ZH7Q74L/k3albA2fI4MfsScnAw=;
        b=Tz9TxyfoAYvsX/PKTWwCdxXtjP562+AQA85Q/kaGjo71lhKApa7Hxeop1gnDfLPzjH
         zB0kgwVUuJqzkXyTVvgefHiWoGCGRXqARoCnRzfHbpexbC5WEZnqAl3SQ7OVVuMk36WM
         QVNMsOOPPLsx7wy9qVsIMJhGbICybQ6wGT9ANVBbKZ3kAEXndNNzFTtNHM8PWpMaNeD5
         5Dmmh63pFq8jVY6uazZ4cGkqVW5QnYqapF4bSP0nSeQQkjVIMrkmNzBEA86yKkP7Lj2b
         bwFlZy7cBYWWjXhg+lVMGc8NkjxpM50bFToiIj7QLp9F3xK1EyNqVJ4ptLW2vJYt6lBd
         tOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777490313; x=1778095113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evfYZBjBW8bQqs5i+ZH7Q74L/k3albA2fI4MfsScnAw=;
        b=BwEOUXFIUhgcMkMrqpUwlR0y1oJFCssb9/dD/xj++71bNWQXaJ6jMjnmUIjyFUEb6W
         NEDFFKFHTmFRjAEvdH4CtxiKf18xXmETwRMEJac8DPtyr0QGyqp98HpE1EnTuynVkZjI
         9x93HiYonrco/HbU9KgWVwNviwlr8Z0QecJ9LAnzdnpGy27HVtDBmYgZUij9cTLBjiK/
         hFrcTHSPAIn7G+phAxh3S+XUpPOG0JJZmBZQS9Lo6aemphC3WlyzPzyxaBeMERjsrQWb
         2s8gsDU6QmjcLs7fplYOqXo5moVcVs2wiFU0Mhh6e2dKt02V3AJCqfPZsI+WxcH7aval
         Qz0A==
X-Forwarded-Encrypted: i=1; AFNElJ/qkfVPx76KWJjVLwKaBOyCU9KRyT+8W6Sq6n9Rd17v9vlrQ1ncdnkl/aoXV+6lWl923zjSIPIaW7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpknT8wkGhLxBjkYT5Hb9r5APx+ka0MqPcKYNVcqZi1q4wBqX
	Vv5dbRqzinw7wjAlXgJkOT+tUMwpFcJLThjZTF/PoFXMtSxJkeN/ygUBhJWCYGydZxHHwAX8eDW
	gBJtJkcpcthjvN8W5dY38DyOm631wB7Cu3O7puOfA2ZfULFiBvMKGjx1RDUmL
X-Gm-Gg: AeBDiev/+Xp7iXmtp8DjalhO55AoJ7BS+rU5IvF2lobH/ds73iQFd7VCG7FEnPha/xv
	7hqwkg5NGM7mut6wrqJAHlHMqft/Qx27P72Eh8Q1M3VWNmu2xzEVy9r+/1qXKEffLJQFzupfClo
	pUbmYucKOcJ1pqy7zcE2nnRIJHywXaAf8sx5rusZ3depEauIEbjU7lPHGZpzBHtXpoOkTTELQPi
	X3uFlZ7kslv5LX/n/nY3zaoHN3p2LkWTp6Q1n4fjxfL017kIU6oPzymaf5pCKlO1OYCkgbgB7jF
	c3c4vy4gXwD4XvME1lc=
X-Received: by 2002:a05:690e:e8d:b0:654:6ccc:69ec with SMTP id
 956f58d0204a3-65bfe52fa64mr3500746d50.13.1777490313306; Wed, 29 Apr 2026
 12:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
 <20260428161339.1187956-2-rafael.guimaraes.dias@usp.br> <CALoEA-zxZgPwgb7o_=F9Q=bQSYiQi=THtCpgu0mW3EEzbXEAcw@mail.gmail.com>
 <20260429112300.696e2722@jic23-huawei> <CAPBn40g+PPyxnVfLn8q2bGgtQ=Zy1VBQW3qQeje=v9sTSx0N5Q@mail.gmail.com>
In-Reply-To: <CAPBn40g+PPyxnVfLn8q2bGgtQ=Zy1VBQW3qQeje=v9sTSx0N5Q@mail.gmail.com>
From: Rafael Guimaraes Dias <rafael.guimaraes.dias@usp.br>
Date: Wed, 29 Apr 2026 16:18:22 -0300
X-Gm-Features: AVHnY4KYstOzM8eN2jLTEaSzkAC4TIrQwlvHMfIx7u1CxrlLoFCHBzFetQSaQeE
Message-ID: <CAPBn40g33v0z6ki8P4iE1eZz-QTfWA2REEMN3Zghmt-TiiQL1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: stk3310: Update includes to match IWYU
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, 
	Felipe Khoury Dayoub <felipedayoub@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Resending as plain text for the mailing list. Apologies for the
duplicate to those who already received it).

Hi Jonathan and Joshua,

Thank you very much for the guidance and for the time you took to
review this patchset.

Thank you, Jonathan, for making the final tweaks with asm/byteorder.h
and linux/sysfs.h before applying it. I completely understand your
point regarding the explicit inclusion for attribute_group.

I also appreciate the advice about slowing down between versions. I
will definitely keep that in mind and wait longer before sending out
updated versions in my future contributions.

Best regards, Rafael G. Dias

Em qua., 29 de abr. de 2026 =C3=A0s 15:55, Rafael Guimaraes Dias
<rafael.guimaraes.dias@usp.br> escreveu:
>
> Hi Jonathan and Joshua,
>
> Thank you very much for the guidance and for the time you took to review =
this patchset.
>
> Thank you, Jonathan, for making the final tweaks with asm/byteorder.h and=
 linux/sysfs.h before applying it. I completely understand your point regar=
ding the explicit inclusion for attribute_group.
>
> I also appreciate the advice about slowing down between versions. I will =
definitely keep that in mind and wait longer before sending out updated ver=
sions in my future contributions.
>
> Best regards, Rafael G. Dias
>
>
> Em qua., 29 de abr. de 2026 =C3=A0s 07:23, Jonathan Cameron <jic23@kernel=
.org> escreveu:
>>
>> On Tue, 28 Apr 2026 18:49:36 +0200
>> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>>
>> > On Tue, 28 Apr 2026 at 18:14, Rafael G. Dias
>> > <rafael.guimaraes.dias@usp.br> wrote:
>> > >
>> > > Clean up the included headers in stk3310.c according to the
>> > > Include-What-You-Use (IWYU) tool. Remove the generic <linux/kernel.h=
>
>> > > header and add explicit dependencies to improve compilation accuracy=
.
>> > >
>> > > Co-developed-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
>> > > Signed-off-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
>> > > Signed-off-by: Rafael G. Dias <rafael.guimaraes.dias@usp.br>
>> https://sashiko.dev/#/patchset/20260428161339.1187956-1-rafael.guimaraes=
.dias%40usp.br
>> Had a few comments.  I added asm/byteorder.h and linux/sysfs.h.
>>
>> Maybe we could argue the sysfs.h one will always be included by
>> iio/sysfs.h but I think it's better to explicitly include it
>> for struct attribute_group and similar.
>>
>> The asm/byteorder.h is simpler one as that should definitely be here.
>>
>> Anyhow, tweaked whilst applying and applied to the testing branch of
>> iio.git.
>>
>> However, do slow down a bit as Joshua suggested - I'd generally
>> suggest a week between first version and second, but I am a bit
>> more relaxed on this for students and new submitters doing fairly
>> simple patches.
>>
>> Thanks,
>>
>> Jonathan
>>
>> > > ---
>> > >  drivers/iio/light/stk3310.c | 13 ++++++++++++-
>> > >  1 file changed, 12 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310=
.c
>> > > index 1fad9367c2d4..37b7b9367269 100644
>> > > --- a/drivers/iio/light/stk3310.c
>> > > +++ b/drivers/iio/light/stk3310.c
>> > > @@ -7,16 +7,27 @@
>> > >   * IIO driver for STK3310/STK3311. 7-bit I2C address: 0x48.
>> > >   */
>> > >
>> > > +#include <linux/array_size.h>
>> > > +#include <linux/bits.h>
>> > > +#include <linux/dev_printk.h>
>> > > +#include <linux/err.h>
>> > > +#include <linux/errno.h>
>> > >  #include <linux/i2c.h>
>> > >  #include <linux/interrupt.h>
>> > > -#include <linux/kernel.h>
>> > > +#include <linux/irqreturn.h>
>> > >  #include <linux/mod_devicetable.h>
>> > >  #include <linux/module.h>
>> > > +#include <linux/mutex.h>
>> > > +#include <linux/pm.h>
>> > > +#include <linux/property.h>
>> > >  #include <linux/regmap.h>
>> > > +#include <linux/sprintf.h>
>> > > +#include <linux/types.h>
>> > >
>> > >  #include <linux/iio/events.h>
>> > >  #include <linux/iio/iio.h>
>> > >  #include <linux/iio/sysfs.h>
>> > > +#include <linux/iio/types.h>
>> > >
>> > >  #define STK3310_REG_STATE                      0x00
>> > >  #define STK3310_REG_PSCTRL                     0x01
>> > > --
>> > > 2.43.0
>> > >
>> >
>> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>> >
>>
