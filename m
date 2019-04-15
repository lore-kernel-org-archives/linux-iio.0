Return-Path: <SRS0=ZeA0=SR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B77C10F0E
	for <linux-iio@archiver.kernel.org>; Mon, 15 Apr 2019 22:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F092075B
	for <linux-iio@archiver.kernel.org>; Mon, 15 Apr 2019 22:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfrdfcsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfDOWJx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:09:53 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:39364 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfDOWJx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Apr 2019 18:09:53 -0400
Received: by mail-yw1-f48.google.com with SMTP id z9so6603302ywd.6
        for <linux-iio@vger.kernel.org>; Mon, 15 Apr 2019 15:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=xYXyVu2UGm5NVJcQBRrpwZ4kFezE3zeC/S6QAAEC6Ag=;
        b=JfrdfcsZiA6qkEVSUoGPXfo5MUuD5TMb3eVQ+KCYkgXFQ54HnwoMr302jH0l9q2Rp1
         oRJ/lRcKhbPgZdJvZyj3QYFlF3AvFMCkAeFbB88QiPzlSYGa9p+O89WM6Iiqlw3UbBpA
         ODap6ySeqwJBs+UcNy+LXC5ewwr/5M0IGrwd5oXkzHWkiU9OQqHVWEqkP19S/IznpEPe
         Y5XNcKyYi8L12XdauuKgKWPn+mWYFHTRb5Gh3vVvVGwHvFqKQGRWEUXKhTcUK7iYXNw4
         L0KcIA+5g5K4hsDdr+apBoYNRuMHdh5XhxgumJf3JnILbddaS23/LwUTJGl5nzBQ4A5V
         yQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=xYXyVu2UGm5NVJcQBRrpwZ4kFezE3zeC/S6QAAEC6Ag=;
        b=bg8xwHfE025SsGiMtIrj8sj9NZu4cWgNOrTNFAVeH+psILinp8nodCO3HTJFe22P1H
         uVMKja2G4lcpoYb0jIh+o01bksUW6HsXDxrING48JjDtSSj3WE3n0ltykG9RT9C+CU1Y
         JxO8MT6klW9DozghyosZcPbsX4Cw6FXiay18oalI4Sy9qQcmfirF/LGQvj8/Q370DAB0
         BcJbBUSJkPQv8C+UrKp3lHgasKn8kXbgNMWF7BLEi5ZHqEQRfZEZO+WOCWf2KODi0YH6
         geuIM+eS+WDPA3Nx2aRTH18pTld3EjRIsDOC0Iqe57CvLI3OF85m3tU6DbjcvEpxTlKJ
         Fj4w==
X-Gm-Message-State: APjAAAWpiUvjhg+nC5x6vN6RM+DbQNslwmuovqUU79zrVWcTSE7R4JZ0
        KjC1q5IiNAdDMrsqm8lPhl8=
X-Google-Smtp-Source: APXvYqwen3zNPo6+/BCNKjGDzfwTCeUi7r7+A11bH4q4pqBaqKMVLeDZaMuxDZOunU6qj6/qQtrfNw==
X-Received: by 2002:a81:4fcb:: with SMTP id d194mr62211680ywb.171.1555366192560;
        Mon, 15 Apr 2019 15:09:52 -0700 (PDT)
Received: from renatolg ([186.220.23.67])
        by smtp.gmail.com with ESMTPSA id m5sm22433146ywm.67.2019.04.15.15.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 15:09:52 -0700 (PDT)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Mon, 15 Apr 2019 19:09:48 -0300
To:     jic23@kernel.org, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        dragos.bogdan@analog.com
Cc:     linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Subject: IIO on KernelDevDay
Message-ID: <20190415220946.wev5gjdh6dn6hmot@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

(CC-ing linux-iio in case others would like to comment. :)

So some history to begin with. Since late last year, we've
been attempting to build a tradition of kernel contribution
amongst students here at the computer science department of
the University of São Paulo (USP). We made it "official" and
created a student group made out of graduate and
undergraduate students: FLUSP [1].

We started small, but as you probably know, managed to get
almost three drivers moved out of staging! We've been quite
excited with what we've achieved so far and decided to open
up our small group to the whole University.

Since then we've managed to get some new people involved and
some of their patches sent out. Recently we have received
quite a big influx of students interested in contributing to
the kernel, and so we wanted to do something big. We came up
with this idea for a KernelDevDay [2], in which we get a
bunch of us in a room and spend the whole day sending out
patches to a specific subsystem.

We were thinking of going with the IIO for this debut
version, as that's the one we've most experience with. We
intend on working on 5 or more specific drivers (depending
on the number of attendees), and our objective is to move
them out of staging. This event would happen on May 18
(that's a Saturday), with several patches sent throughout
the day.

We know that your review window is on weekends, and that
this might mean a high volume of patches on that day, so we
wanted to let you know of all this beforehand and give you
the time to send any suggestions or comments on all this.
Like if maybe you'd want us to specifically tag our patches
for a later batch review, and not have to deal with them all
at once; or have us send large patchsets as opposed to small
or individual patches so as to not spam you.

We are also aware of several problems that might turn up.
Like that our patches might not be accepted or reviewed on
the same day, which might result in a bottleneck. We plan on
working on multiple drivers at the same time to solve this
issue. We also plan on having an internal review to avoid
wasting your time with minor reviews. We also know that
you're not the only one reviewing drivers (and we obviously
don't expect you to review everything on the same day!), and
that the event being on a Saturday might be troublesome, but
I think what we really want is to just help out the IIO any
way we can. :)

Anyway, we'd really love to have your opinion on this.
Sorry for the high content email.

Looking forward to hearing from you,
Thanks,
Renato

[1] - https://flusp.ime.usp.br/
[2] - https://flusp.ime.usp.br/events/2019/04/01/kerneldevday_en/
