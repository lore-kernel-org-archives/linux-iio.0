Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C52C10F0E
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825C02084F
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 12:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRARLky1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDIM2O (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:28:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35142 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIM2N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Apr 2019 08:28:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id m10so15360659otp.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Apr 2019 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODsuCt+XNJgIpdJS3hGeiBg25ma3+VEpVyOMJ9tzpqI=;
        b=pRARLky1bEVO1wkrbgwOrJyraPmoeQEnvmlxzmDo+gbyeTK2oCkN61rU8l1rnld0Wx
         09+geASsTDHki9MsLxSEwzmQG0VouNDgH9y3MYWoWIJrEpxAUfkmYqds0x1ky57HkwXy
         nEDX4iAvtJ2HkPWqEy6d0aXzIoWmocnHvGYVXTpWZGV+EMY01ugxSXVUiQmfeGsgYavR
         xXIqoHxOzMPyWvRSGrWb9j85oiONU5ZepzAzVzG3EiVBQzEZjUWhqg/nDSH2tXTmKiw7
         KI70u9lelXoimPGMnody7Br+tYW8hqfp0tDoD4T/FpgJif91nynEyW0v+6oE4m56r5Tq
         DUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODsuCt+XNJgIpdJS3hGeiBg25ma3+VEpVyOMJ9tzpqI=;
        b=f3nlWYKGyR4dRTEm/Gl4S/vcQGATBtOUoJ0bOPzDIE7XZsaO5zw+D4vrRSZThJ4AEV
         QBL48AxZf5fBYP+ztzDShc3Rx+sh2IcRaLyQiCzSS8cwjJqeMufUGe4f9RX/HKGwzrLo
         gCOnYQlRYct8tcuE2uTrq8VwUzTuoUth9v6rQMgPetSNURKVrXiL5uv3O5rkIbUNuttQ
         4DTnKxiqVEwmT1X28aQr4u/15UIRAqmql2CvowNbKAQBGJBEU2/dZZCYDXnv9IjAJh87
         VWSYCDZzQ5gQgjyLyNbCAsv9i8qU4qkMh88PrXPWfc7oduoFnAgxsfyIn2XmPC5SdFtb
         bduw==
X-Gm-Message-State: APjAAAXdWH98G57NUETPrjmB46aGBJlfEmKF8ESh0cY+HfpsYgYbX0op
        LJHzzMzGyTFTv97BJbQ79XoPDpA63tAceCWT9BM=
X-Google-Smtp-Source: APXvYqzHjeIljjdnhPW1j1y0hfrovdJFfX/327LPJ81x1JW4ZoWR6jv/SRKxlr/8cvEHoCrDME+A0OpYxSYJiAWC6bg=
X-Received: by 2002:a9d:12e9:: with SMTP id g96mr23371943otg.5.1554812892855;
 Tue, 09 Apr 2019 05:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190406194528.qx2tvrriuymb6xnq@smtp.gmail.com>
 <CA+U=DsokFDLC+kO61iErM12xp6ZBteYyfhrFKxexRzuumiFDqg@mail.gmail.com> <20190409121655.qptymigvkitgo3iv@smtp.gmail.com>
In-Reply-To: <20190409121655.qptymigvkitgo3iv@smtp.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 9 Apr 2019 15:28:01 +0300
Message-ID: <CA+U=DspEug7s6q6Lt_He2vth3nC0+jSzwbeeS06puU3vNNqmaw@mail.gmail.com>
Subject: Re: RFC on IIO AD7292 driver GSoC proposal
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     dragos.bogdan@analog.com,
        "Hennerich, Michael" <michael.hennerich@analog.com>,
        stefan.popa@analog.com,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 9, 2019 at 3:17 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 04/08, Alexandru Ardelean wrote:
> > On Sat, Apr 6, 2019 at 10:46 PM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > Hello.
> > >
> > > My name is Marcelo Schmitt, I'm a computer science student learning
> > > how to contribute to the Linux Kernel in the IIO subsystem. I was told
> > > by a friend that Google was encouraging people who contribute to open
> > > source projects through the GSoC program and that there was a project
> > > for developing a new IIO driver. I intend to continue contributing to
> > > IIO and, if possible, engage in this GSoC project. As suggested by
> > > GSoC organization, I shared a draft proposal for the project here
> > > https://docs.google.com/document/d/1vOegyoC5b90jwLe1PBz4IbKGXaXMozi-RldS5OAZz4Y.
> > > It would be really great if anyone could comment on it.
> > > Sorry for sending it so close to dead line date.
> > >
> >
> > Overall doc looks good.
> > One note about the steps: ideally the AD7292 driver should not be put
> > into staging, it's a new driver.
> > Hence there is no reason to have a "move out-of-staging" step.
> >
> > The current IIO drivers in staging are there, because initially the
> > IIO framework was done in staging, and some drivers were not updated
> > because of time/priorities.
>
> Thanks Alexandru.
> OK, understood. But where one should commit code for a driver in
> development as will be the case for AD7292? iio main tree will
> probably not be a good idea. Does any development branch exists?
> testing2, compiletest?

I guess I'm not very familiar with how GSoC works.
I guess work can be done in any public place.
And then the final parts can be submitted to the IIO list as standard.

Regarding the DT bindings, I'm afraid you will have to make them in YAML format.
Just be aware of this.

This is a recent change to DT bindings.
I'm also trying out this new YAML thingi [for personal curiosity].
They don't look too difficult, but they are a bit weird. But I've
always found YAML a bit weird.

>
> >
> > > Thanks in advance,
> > >
> > > Marcelo
