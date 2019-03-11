Return-Path: <SRS0=pZra=RO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7AFC4360F
	for <linux-iio@archiver.kernel.org>; Mon, 11 Mar 2019 11:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B882075C
	for <linux-iio@archiver.kernel.org>; Mon, 11 Mar 2019 11:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="Hww2FaCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfCKLW3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:22:29 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44751 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfCKLW2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Mar 2019 07:22:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id c4so3508714ywa.11
        for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2019 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJcU2Bab04hznGrdFV1DSsCxIpb4sAD6RZmk3PYCkaE=;
        b=Hww2FaCDAoeODwd+DJyT0zRFkn6zQIp7+8WVBujK5ve1F1142fTV4d7CPSXehnBTYg
         uNK7UT7Qjhfk33FQx5FBvLndQcaFgEfaNr6pHCku8hyLxDGa5xVU9T0ADzUGYyfaSQnf
         DX1LIcv3foHV0eRhLTt1cWKrHwqJvn/b2dSXk96X0btn0qD2oZ6S0lDMX6sXDHQDUMWO
         Ff/ABjfcwdb2uncueHYx7+u676OFNC3Y5hor/cLfhe+10SbNNZaZmFdLt8BGYEj4YgCo
         L0PBNhpiCsuBh8lij3RCOv6hIG2wWlqNT8KeMg2MZzNMZ2Sjlix1c4rDmjqsoex+EmsE
         2n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJcU2Bab04hznGrdFV1DSsCxIpb4sAD6RZmk3PYCkaE=;
        b=ND+5W2/83zLHuVV1SODUK1cjvjwNKCDk2thuUEu91aEzEg9TRoj66Swrxi976xA57j
         bv8umK+FmY5s273rC72EORMd9/A16RSooN8LCbEOpXG9yNweJ2mvkgX784tMyrjmavAN
         5me6nxaabF8/JKO/0+VXCSk2RU2F/sjHcGMOomhin6L4OqTKAXDjFrQHIXWsObFBvB0b
         Hhh/TOnhduGKW9kf8LhW0PanmOZ5L+nVrfmSPzuZ2SJkM+0ADTZgKIJ0wA3DuZ3wcJnR
         94yYlI8r3XvFzDvVpMDoigNb+b7UzEgGWK+N8vwN0hYj2WW69NM6i6Uh9XDglHfcGq27
         96lQ==
X-Gm-Message-State: APjAAAVneRf9LITS3nzj2VMB/kZlUZivWBq4X/nzX5pfuMBYR7DAfNwO
        8mV6tK6Xw3TWdfpdP3WcHJqzFyYGUHNz0GnJT92ONg==
X-Google-Smtp-Source: APXvYqyQmORXF22uMshydHEj+pYkbrAm/SsQvIzYbzybVjIXKP76ybbG4dPvpUijdPpIkGIu9DP4czn0yPOKo9YBn9s=
X-Received: by 2002:a25:3ca:: with SMTP id 193mr26437201ybd.498.1552303347474;
 Mon, 11 Mar 2019 04:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-6-patrick.havelange@essensium.com> <20190307113147.GA7851@icarus>
In-Reply-To: <20190307113147.GA7851@icarus>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Mon, 11 Mar 2019 12:22:16 +0100
Message-ID: <CAKKE0ZHtFk=XvBLbUzZbdqjh-m5TewnH+P__=d=Yio8TinRFNQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] counter: add FlexTimer Module Quadrature decoder
 counter driver
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 7, 2019 at 12:32 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> > +/*
> > + * take mutex
> > + * call ftm_clear_write_protection
> > + * update settings
> > + * call ftm_set_write_protection
> > + * release mutex
> > + */
>
> Jonathan mentioned it before in the previous review, and I think I agree
> too, that this comment block is superfluous: the context of this code is
> simple enough that the function call order is naturally obvious (i.e.
> write protection must be cleared before settings are modified).
>
> The only important thing to mention here is that the mutex must be held
> before the write protection state is modified so a comment along the
> following lines should suffice:
>
> /* hold mutex before modifying write protection state */

I think that keeping the more verbose comments is better. You directly see
what operations are needed, and is a good reminder, especially if you
are not familiar with the driver.
I'll use your comment on the next version if you insist (see below for
why new versoion).

> > +static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> > +{
> > +     ftm_write(ftm, FTM_MODE, 0);
> > +}
>
> The ftm_quaddec_disable function is only used for cleanup when the
> driver is being removed. Is disabling the FTM counter on removal
> actually something we need to do?

It might provide some power-saving, so I would keep that function.

>
> While it's true that the register will keep updating, since the driver
> is no longer loaded, we don't care about that register value. Once we
> take control of the hardware again (by reloading our driver or via a new
> one), we reinitialize the counter and set the count value back to 0
> anyway -- so whatever value the register had no longer matters.
>
Indeed the previous values at start do not matter. It's there just to
shut down the device properly.
This discussion made me verify again the specs and in its current form
the disable doesn't even work at all :
 - That register should be written with write protection disabled (duh!)
 - It doesn't even stop the FTM from running, the clock must be
disabled for that.

So I'll probably provide a fix for that (in some days/weeks).

> > +
> > +enum ftm_quaddec_count_function {
> > +     FTM_QUADDEC_COUNT_ENCODER_MODE_1,
> > +};
>
> The FlexTimer Module supports more than just a quadrature counter mode
> doesn't it?
>
> We should keep this initial patch simple since we are still introducing
> the Counter subsystem, but it'll be nice to add support in the future
> for the other counter modes such as single-edge capture.

yes it provides more features, those are in a backlog ;). I would
prefer if this simple version(I mean, with the disable/shutdown fixed)
of the driver could be merged already before extending support.

>
> > +
> > +static struct counter_signal ftm_quaddec_signals[] = {
> > +     {
> > +             .id = 0,
> > +             .name = "Channel 1 Quadrature A"
> > +     },
> > +     {
> > +             .id = 1,
> > +             .name = "Channel 1 Quadrature B"
> > +     }
> > +};
>
> If possible, these names should match the FTM datasheet naming
> convention. The reason is to make it easier for users to match the
> input signals described in the datasheet with the Signal data provided
> by the Generic Counter interface.
>
> I think the FTM datasheet describes these signals as "Phase A" and
> "Phase B", so perhaps "Channel 1 Phase A" and "Channel 1 Phase B" may be
> more appropriate names in this case.

I'll verify those,

> > +static int ftm_quaddec_remove(struct platform_device *pdev)
> > +{
> > +     struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> > +
> > +     counter_unregister(&ftm->counter);
> > +
> > +     ftm_quaddec_disable(ftm);
> > +
> > +     return 0;
> > +}
>
> If the ftm_quaddec_disable is not necessary, then we can eliminate the
> ftm_quaddec_remove function as well by replacing the counter_register
> call with a devm_counter_register call.

yes, but as stated before, I would keep it for potential energy saving.

Thanks for your feedback :)
