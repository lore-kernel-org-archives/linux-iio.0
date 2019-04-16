Return-Path: <SRS0=o58m=SS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C5C10F13
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 11:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBE720868
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 11:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDPLwO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:52:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfDPLwO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Apr 2019 07:52:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F66A8FF238E7636D870;
        Tue, 16 Apr 2019 19:52:12 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 19:52:06 +0800
Date:   Tue, 16 Apr 2019 12:51:55 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Renato Lui Geh <renatogeh@gmail.com>
CC:     <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <stefan.popa@analog.com>, <alexandru.Ardelean@analog.com>,
        <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <kernel-usp@googlegroups.com>
Subject: Re: IIO on KernelDevDay
Message-ID: <20190416125155.00001793@huawei.com>
In-Reply-To: <20190415220946.wev5gjdh6dn6hmot@renatolg>
References: <20190415220946.wev5gjdh6dn6hmot@renatolg>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Apr 2019 19:09:48 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Hi Jonathan,

Hi Renato,

> 
> (CC-ing linux-iio in case others would like to comment. :)
> 
> So some history to begin with. Since late last year, we've
> been attempting to build a tradition of kernel contribution
> amongst students here at the computer science department of
> the University of São Paulo (USP). We made it "official" and
> created a student group made out of graduate and
> undergraduate students: FLUSP [1].
> 
> We started small, but as you probably know, managed to get
> almost three drivers moved out of staging! We've been quite
> excited with what we've achieved so far and decided to open
> up our small group to the whole University.

It's been great to see your activities grow!

> 
> Since then we've managed to get some new people involved and
> some of their patches sent out. Recently we have received
> quite a big influx of students interested in contributing to
> the kernel, and so we wanted to do something big. We came up
> with this idea for a KernelDevDay [2], in which we get a
> bunch of us in a room and spend the whole day sending out
> patches to a specific subsystem.
> 

Sounds fun :)

> We were thinking of going with the IIO for this debut
> version, as that's the one we've most experience with. We
> intend on working on 5 or more specific drivers (depending
> on the number of attendees), and our objective is to move
> them out of staging. This event would happen on May 18
> (that's a Saturday), with several patches sent throughout
> the day.
> 
> We know that your review window is on weekends, and that
> this might mean a high volume of patches on that day, so we
> wanted to let you know of all this beforehand and give you
> the time to send any suggestions or comments on all this.
> Like if maybe you'd want us to specifically tag our patches
> for a later batch review, and not have to deal with them all
> at once; or have us send large patchsets as opposed to small
> or individual patches so as to not spam you.

Don't worry about it, but thanks for the warning.  Just send
the patches out when they are ready to post.  Given this
whole day sounds like a great idea, I'll see if I can be available
that afternoon / evening UK time to give some immediate feedback.
No promises though!

If we are lucky there may be a few others who can help out as
well on the day.

> 
> We are also aware of several problems that might turn up.
> Like that our patches might not be accepted or reviewed on
> the same day, which might result in a bottleneck. We plan on
> working on multiple drivers at the same time to solve this
> issue. We also plan on having an internal review to avoid
> wasting your time with minor reviews. We also know that
> you're not the only one reviewing drivers (and we obviously
> don't expect you to review everything on the same day!), and
> that the event being on a Saturday might be troublesome, but
> I think what we really want is to just help out the IIO any
> way we can. :)
> 
> Anyway, we'd really love to have your opinion on this.
> Sorry for the high content email.

Great stuff in general so I'll look forward to the outputs.

One thing I would suggest though is to discuss potential drivers
to look at on the list before you get started. The reason being
that the last thing you want to happen is to:

a) Send big changes for a driver that clash with someone elses
   ongoing work.

b) Work hard on a driver for hardware that is unobtainable / obsolete.

The number of IIO drivers left in staging has shrunk, partly
of course because of your groups efforts, so the chances of running
into these sorts of issues is increasing!

Also given we have a month, you can probably get some reviews of
current driver status if that is helpful to work out where to focus.

Keep up the good work.

Thanks,

Jonathan 
> 
> Looking forward to hearing from you,
> Thanks,
> Renato
> 
> [1] - https://flusp.ime.usp.br/
> [2] - https://flusp.ime.usp.br/events/2019/04/01/kerneldevday_en/


