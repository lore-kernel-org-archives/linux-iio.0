Return-Path: <SRS0=fZBy=P5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D0EC282F6
	for <linux-iio@archiver.kernel.org>; Mon, 21 Jan 2019 09:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B264F2085A
	for <linux-iio@archiver.kernel.org>; Mon, 21 Jan 2019 09:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi4TG4RM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfAUJtb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:49:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38836 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfAUJta (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2019 04:49:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so16951367lja.5
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2019 01:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klCGRFpkS10f4pHp7uFNtolnPPHMvSv8HkXKShYpYFo=;
        b=Bi4TG4RMoPy+SDdap0em7KMZJCLyUt0i3nj7xI5+ACcl55nFQ74Qs58rFwNt6zXfLH
         t2KaCRINJGYAk8IP+/kXM+kSFN1ox/qnbV7jeGXlynomzsFv6RfpPLDbqaZli10fZH5n
         wTsZJQoryKn3vlntLZsZcS5T2KCS7PiqbYYKgI8pt1Yc/mhmmWobak15DFqG2R8WNqvr
         Kh3LBNP4X8fDP26zPpuiQmqcNwOrUHf8Ro5htlB31pxnaO7RxHQn1aEHxI8xUn3WiFaD
         KjwiY1UK4RFDU7sq/iSF4wVmhK9iwgpA/yM6HsRsSt5kkjw7NEe424PEo/Ym6thiJIKL
         w2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klCGRFpkS10f4pHp7uFNtolnPPHMvSv8HkXKShYpYFo=;
        b=TcYX6m+rkNk7Aa8vqA+JLN5Lqjh3CQN3NsdTHrc9MIYHLMDp7BR6f6Hg0a3HOxPi4/
         tYvAWPq70xLWBijU6ODR7WofCiOi1+6TlifsF/kM3vRKE7H/Wa056Y7ddZFmswoqWjzw
         HT+xCegrnPKliwm41FRGU3sClFsD2LYoU4c32pMZZUqic1s8//3ixV8xn4gCoyBVsv5S
         tfNekMNBVtXGzHWAho3PYAWrXkiZyXaFkq9dIuA9qSkjZHACX9bw2HCOwuPxOHAiWp7t
         UR5v/K+NnA3w2m4FGErM/xGohBUpQPniZyIdG0+qdaN4wBhTF5F/XpwU9i+dUohbrI1L
         eoyA==
X-Gm-Message-State: AJcUukfuWTLd3Q+kHpI2mQczereLCC+z41OZitcnSuel/sFLhZwXf6iV
        hDpLD3C2PuBAGdQvQyynAaQvs2jkboccNzJKyRTlisKu
X-Google-Smtp-Source: ALg8bN7mW9yb+xXTqxxnrqy2ktluUwa1ax+7VXUJzbbaKvU1Z4+TEKwSya/OQTSIAOlYq9GkNKfvGCPGMpz11rMmbX4=
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr18960935ljj.61.1548064168696;
 Mon, 21 Jan 2019 01:49:28 -0800 (PST)
MIME-Version: 1.0
References: <1542679806-5812-1-git-send-email-ibtsam.haq.0x01@gmail.com>
 <alpine.DEB.2.21.1811200637130.11466@vps.pmeerw.net> <20181125130102.62c32183@archlinux>
In-Reply-To: <20181125130102.62c32183@archlinux>
From:   Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>
Date:   Mon, 21 Jan 2019 10:49:17 +0100
Message-ID: <CAPQseg1q=heJpKPQX-PcPkThHq2NVM1k2tQj1SpUTYTfC=D1Hg@mail.gmail.com>
Subject: Re: [PATCH] iio: Add driver for TLA202x ADCs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Thanks a lot for the review. I shall apply all these in the v2, I do
have just one question, below.

> > > +
> > > +static int tla2024_of_find_chan(struct tla2024 *priv, struct device_node *ch)
> > > +{
> > > +   u16 chan_idx = 0;
> > > +   u32 tmp_p, tmp_n;
> > > +   int ainp, ainn;
> > > +   int ret;
> > > +
> > > +   ret = of_property_read_u32_index(ch, "single-ended", 0, &tmp_p);
> There is now (only very recently) a generic description in DT for
> acpi channels.  Please look at that:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/devicetree/bindings/iio/adc/adc.txt?h=togreg&id=00426e99789357dbff7e719a092ce36a3ce49d94
>
> It is minimalist.  If it is single ended, you can tell that by the absence
> of diff-channels.
>

How should we specify which single ended channel to use? For example,
say I want to configure the driver for reading single-ended values
only from input pin AIN3. When we only signify a single-ended channel
by the absence of "diff-channels", where should the "3" be specified?

> If the binding needs additional elements (it probably does)
> then propose them for that generic binding.  We are trying to move
> away from each driver doing it's own thing given all this stuff is
> pretty generic!
>

Sorry for trimming the message. Gmail was otherwise blocking my
outbound message, and I could not find any other way to get it
through.

Best regards,
Ibtsam Haq
