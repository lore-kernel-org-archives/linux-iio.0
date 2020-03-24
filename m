Return-Path: <SRS0=WWoV=5J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6A4C4332B
	for <linux-iio@archiver.kernel.org>; Tue, 24 Mar 2020 12:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFD620714
	for <linux-iio@archiver.kernel.org>; Tue, 24 Mar 2020 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5/TSnOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCXMDO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:03:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45548 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgCXMDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 08:03:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id b9so7304348pls.12;
        Tue, 24 Mar 2020 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2EXDFgxva5oF0426JjSTRbKqwLaE46RW/hlFLUbrrA=;
        b=G5/TSnOHqp5DlvZeCBAifsCPJVcPcwb9Bepaavt3fg4yKA34r6/pNilltLQNEnhbcn
         5BQ7/UWFVlePUAVM277SAwkeJJ9BO1PAPl3xa+nYtYBQziiAvJvgFyOkA9rDVvLeVwtI
         IEfWnkwFz0fsZ3X9HCnYHGx+CLiyk+X61kZ0noAhYFHRG6vtYolDzMGP6jOT59IBvhi8
         XSraOhsyArognYXGKQFqpzlZyburAUHq23mcrd9M4sntUkuTX4Sayx17qlk1zGauNvE5
         0M81TYnmG0eOMpyAzCrPf9HBIgFn1+//GjuEjCYq2Eh54wQvZ5isrPm86ujp/BGNNvtS
         eT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2EXDFgxva5oF0426JjSTRbKqwLaE46RW/hlFLUbrrA=;
        b=RJndM1W2jrtOLiV2M34Wj7iGFuhoOrT7lg7t8aqAsoZCDsyw+HE3d1fvpzmjbrvFsD
         i37td2XlJ8KbJpr5g3sSSU8N9ColG4ZfCZK66dxwZaJsxh8kJj8+yyhaFUSfJi+UQHi0
         7mh79fJEWUd53Kt6mheqZR9I9mj/lNwy1+Rqqni2UBPyv18xgxB2dPMEQkdjJFUHZ90j
         wXikZ3N9inQFkwmPUay/RGNGexEI79KLJnZOQYd3oGtV6yqJAWH6x0hrcisV4W0GgqmM
         PibOnplzRxHdGkgJS1Fn5e48srAm/2qcf1GvP6ehAki8PH30MkXMj+niHPNjQvG+TEjR
         k69g==
X-Gm-Message-State: ANhLgQ28QENBpWreo6o3Yu4xUBEJxy1TiwtFBcwyNnxh5A5ynJnUqndE
        yUxKK/54t14QMb87HGZ4W8u1rPUDogLsB6mdUy9rCy+YE2I=
X-Google-Smtp-Source: ADFU+vt4rHgVamUtya4h3lHE3q6Yop3GkBHyB2s5gDiR0Em1mTuxwPzZuqQ5a6G8Mr9p+7OsPvhIrBUPP5Fwdd0Xj68=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr26037755plf.255.1585051391994;
 Tue, 24 Mar 2020 05:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200323103926.21271-1-i.mikhaylov@yadro.com> <20200323103926.21271-3-i.mikhaylov@yadro.com>
 <CAHp75Ve4rejBKjG+mioRL3S7i3meyy=_4TtW1fr2aGvnVn2tBA@mail.gmail.com> <321453af40ca49839bc7b9d1c65b828841492f72.camel@yadro.com>
In-Reply-To: <321453af40ca49839bc7b9d1c65b828841492f72.camel@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Mar 2020 14:03:04 +0200
Message-ID: <CAHp75VeHRxgKFfiqO3V+=jMB-Pqe9-1YM+0oFuuo=cjJfJa+bA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 24, 2020 at 1:52 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> On Mon, 2020-03-23 at 14:10 +0200, Andy Shevchenko wrote:
> > On Mon, Mar 23, 2020 at 12:41 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

...

> > > +static int32_t vcnl3020_init(struct vcnl3020_data *data)
> >
> > int32_t...
> >
> > > +{
> > > +       s32 rc;
> >
> > ...s32?!
> >
> > Applies to entire code.
>
> checkpatch.pl --strict doesn't show anything bad in it but I can change from
> int32_t/s32 into int easily, it's not a problem for me.

The problem is consistency. You code should be self-consistent.
And yes, s32 is quite unusual for (generic) returning variables.

...

> > > +       dev_info(&client->dev, "Proximity sensor, Rev: %02x\n",
> > > +                data->rev);
> >
> > Noise.
>
> Doesn't it help to determine the presence of driver to a common user?

You have a lot of knobs to detect this. Starting from sysfs to 'initcall_debug'.

...

> > > +               goto out;
> > > +
> > > +       return rc;
> > > +out:
> > > +       devm_iio_device_free(&client->dev, indio_dev);
> > > +       return rc;
> >
> > Managed resources are exactly for this not to be appeared in the code.
>
> I can do something like this:
> return devm_iio_device_register(&client->dev, indio_dev);
>
> Would it suffice?

I think so, but you may double check with documentation.

-- 
With Best Regards,
Andy Shevchenko
