Return-Path: <SRS0=+BiV=RV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A9C43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 08:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CAB2082F
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 08:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/lqLcAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCRId6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:33:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33414 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfCRId6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Mar 2019 04:33:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id e22so5195317oiy.0
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2019 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KjTmLOyBJcSZsptQ+qGjBLdq44IrHRacKzE0HPEXiM8=;
        b=F/lqLcAeMWOZt66ITQZzkQcYdOOSaOPckqfUqVtfrCd6qR3Xl7+ZbORnN2PFwo17W3
         Y8eNHaxcgnLgtqGslHyZiEso4/pIVUwdwkxBcmGq8/nmV8R2NGZy2t5nWGasHhHJCUen
         oePLhRojvDR8YhDE+yVqHIPF5kKP78sJFqCc8cjaeqL5NFmN+KBNE6ZIUo03W8ksZVmq
         0/uPmTR8aprQaI2xU1bysCjBWiIez2wDahpZMo4y2q2mVniHJvKl9m00aymfAR8MAr8F
         /hzNpY0hgd6FzNgEygX6w7H6axrGid9u8eLbRzuQoFzk99tlXnht79Qasky5xhoBgtvy
         wY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KjTmLOyBJcSZsptQ+qGjBLdq44IrHRacKzE0HPEXiM8=;
        b=SbqWneYOxJ704Ukt1wQdA3SkAPaV60+W81dzBMavyu9+/43+N2Lu/RapqLOA0oDChW
         9UyNi7Wa45/4W3r+PXQ0wTl7kf+bXDDDuJoAaEUuzafqwc2hrmYVuj3uFTEts6pMjBCZ
         je8fMx3HFOj0QONuqz+GrGNexIlonS9umXAlQ+3nX0Cg4ZtErFKTuRzwBvk/i2KlyrCS
         sN0xOVsr4CVPkwNGhkiaRB2+Va6UWXnwkJLG9qNHcnpOkH/eTmuxI53X06WgBuAMgVLa
         +NSO2P1YD5ywMkbFTaWbTqq+37CBSNTy/8Rjihp4H/U5MEFRp0XWssFeXIK3PoFCIzXV
         z9kQ==
X-Gm-Message-State: APjAAAW562z5Ir1gePu2hD+7kDdlWH61rVTkkEqo1NcwQeZ398rRY4vE
        TXtJHMNgkyejeb8DUSLXDmR0IO8lplzw29/gntY=
X-Google-Smtp-Source: APXvYqxEbVbSvbyI/P38gLOcOA7EJIh4/K49f0n+TunFugecWro0gJQXArHB9geqUZ9MKPmwvYQk6p4sjgmXgOXepC8=
X-Received: by 2002:aca:ba06:: with SMTP id k6mr9787775oif.159.1552898036788;
 Mon, 18 Mar 2019 01:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRz_ybdmvgntoVjvSizUKLKETJasHyucoPM56v2Xrf=3K30Hw@mail.gmail.com>
 <20190317171848.GA7105@himanshu-Vostro-3559>
In-Reply-To: <20190317171848.GA7105@himanshu-Vostro-3559>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 18 Mar 2019 10:33:44 +0200
Message-ID: <CA+U=Dspj8V13kGf0GFBbOgPwkSDnC+Oh43rDzmWvHgcKk2vmkg@mail.gmail.com>
Subject: Re: [GSoC] AD7292 driver project
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Karuna Grewal <karunagrewal98@gmail.com>,
        linux-iio@vger.kernel.org, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 17, 2019 at 7:19 PM Himanshu Jha
<himanshujha199640@gmail.com> wrote:
>
> On Sat, Mar 16, 2019 at 04:09:36PM +0530, Karuna Grewal wrote:
> > Hello,
> >
> > I'm interested in working on the AD7292 driver for Linux kernel as a
> > part of the GSoC project. I've previous experience working with device
> > drivers and am also familiar with couple of Linux kernel's subsystems.
> > For a starting point I wonder if someone can point out some tasks
> > which I could work upon as the project page doesn't elaborate much
> > about it.
>

Curios.
Is this project listed anywhere ?
If so, can we get a link ?

Thanks
Alex

> Agreed!
>
> You may try the following:
> https://kernelnewbies.org/IIO_tasks
>
> Please don't send these Tasks on iio list.
>
> > In case the idea is to start working on the driver itself I'd like to
> > discuss about the same.
>
> My personal opinion: Try to get atleast a small patchset accepted in
> the kernel. It helps you get familiar with all the tools and how kernel
> cycle moves. I strongly agree with Jonathan on 'setup', whatever
> hardware you plan to use in the project say., how would you build/test
> kernel on Rpi or beagle or QEMU or diolan ? dt-overlay, acpi
> enumeration ?
>
> Pray that AD7292 doesn't have an unusual SPI interface.
> Otherwise you end up like me ;)
>
> If you really want to try some sensor, I would recommend https://www.tano=
tis.com/
> to buy them as they have cheap and low duty-taxes+GST+ ...
>
> In my case I ordered from mouser IIRC:
> =E2=82=B9 1,459.58(sensor) + =E2=82=B9 1,750.58(duty taxes + other taxes =
from Indian
> Gov.)
>
> Yeah, taxes are more than the actual sensor! Surreal :/
>
> Feel free to query mentors and community with questions -- I would
> join you too.
>
>
> Goodluck!
> --
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology
