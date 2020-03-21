Return-Path: <SRS0=UYdU=5G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE53AC4332D
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 19:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9293820753
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSOfEjBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCUTxg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:53:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36818 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgCUTxf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 15:53:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so4021743plo.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2020 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4N58z2QN8wZ8KAe7QWvSKWARwMaeQ3FxxpZJrQfXxc=;
        b=LSOfEjBx1erdvgHHuLs6CHyYpWQRSACMBXe80IxqXnng80hV2ejWfDnrpwqZ85KmHd
         y5sbWjjf/E1rHcETMlwzbaCogHTwo0B51Eo6haMAYMLYjq46bNuenOpkJrn3sgZdwCvA
         kB3rVx9+vuMVIvx7ORAnavHRNdkxNqGohcJnAPR2mEGna06MvozmQHhI1oL3dKuk9/Wh
         blqqkg+/GXNYGpGPMgP2i22xU/qrMQhYz07a1QgZt1qTlvyVzfM/SQ9Puh0bbBp442eg
         kaXCiOjJguRGbhaYDh51ILnh+wGebSr1PlTgCHtu1q3NGJiiYIYyJcu9tvWwgH3cro5n
         9SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4N58z2QN8wZ8KAe7QWvSKWARwMaeQ3FxxpZJrQfXxc=;
        b=tC+/diSZpFSJ1mvVb947outvwNCWvheLQU66+lhqJHp81njnBKM9uKOZsw41Oy9Dpj
         VfImuBQyOTNs6gyAgJNuMQEBQqa6b45YtpvuiupwE3Kn6lh8iqiY8QOtU9vgFChtrNzV
         1uduq/DBfZVJGmTg5nyL08GT8yi6aTBcX05/Zs2g+OpRJnzC1GlL++OPwyjrJ3Ko1h2Q
         bExokWTB7fhT6qcezSPFeJ5WDkg5G4ylstllFTYaMXWRVlLixk0tSwrP2BvfqXMEoRYY
         Lp4J/6LRDLgf+Th0nRdWSMv0MSbl3vGVtRVnu7EyG351cljfqsK7qhP92mIPRbYWpaRH
         IM/w==
X-Gm-Message-State: ANhLgQ0J0M6elDxP+fuTHXyPkndHiE2hMNAgRKMpOZ3p0lyEwtuoYDBD
        39Ljy92B+iONuQrynqTnss0DFTvrcJEyCc/KVbI=
X-Google-Smtp-Source: ADFU+vtKzAZkxQZg37hfQhoqAkzkng9LQXwHMHy+DDCgDfj+TMcxS4EC0UIdqxCf0tVYR9p8BoAWW0n7DBjmVQt6HTc=
X-Received: by 2002:a17:902:b096:: with SMTP id p22mr9408871plr.262.1584820414864;
 Sat, 21 Mar 2020 12:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <5e730c2f.1c69fb81.9eda3.5c70@mx.google.com> <CAHp75Vf+SA7ptRQRxvMtVfN0MzQeQ_AgzAP7fc3eaT5nmsxo_g@mail.gmail.com>
 <MN2PR12MB4422876C03060876ACBB4414C4F40@MN2PR12MB4422.namprd12.prod.outlook.com>
 <20200321183154.128d8920@archlinux>
In-Reply-To: <20200321183154.128d8920@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 21 Mar 2020 21:53:23 +0200
Message-ID: <CAHp75VcUtMZDMqizhW=oayvbGcMTZ9M0s=7L0TngkdXz=M49uQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w interface
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 21, 2020 at 8:31 PM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On Thu, 19 Mar 2020 11:08:44 +0000
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> > iio debugfs register interface is quite handy because we can read a single register and write a value.
> >
> > regmap debugfs is only a dump of all registers, as far as I know (may have missed something).
>
> So this is something Mark has discussed before around regmap
> and more generally IIRC.  The issue is that a write
> interface does make it somewhat easy to do really nasty things
> in some drivers that use regmap (to the extent of setting boards
> on fire etc).  For IIO we are much safer - the worst you can do
> is break the IIO driver.

Sometimes IIO driver provides a sensor data about platform facilities,
such as temperature of the die / chip or battery voltage threshold.

> I've never been that fussed myself about the debugfs interfaces
> as it's easy to hack them in when needed for actual debugging, but
> have taken the view that if someone has enough of a usecase to
> want to add them to a particular driver, then it's up to them.

Good to know your p.o.v.!

-- 
With Best Regards,
Andy Shevchenko
