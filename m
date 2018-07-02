Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43190 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbeGBIoy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2018 04:44:54 -0400
Received: by mail-pg0-f67.google.com with SMTP id v13-v6so1197677pgr.10
        for <linux-iio@vger.kernel.org>; Mon, 02 Jul 2018 01:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <1529852721-17828-1-git-send-email-akinobu.mita@gmail.com> <20180630184049.47d10937@archlinux>
In-Reply-To: <20180630184049.47d10937@archlinux>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 2 Jul 2018 17:44:42 +0900
Message-ID: <CAC5umyhY62whz2GfY59MngLMUu6KLnpw5wW1+FY_p8FwHpLsOw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ina2xx: avoid kthread_stop() with stale task_struct
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        =?UTF-8?Q?Stefan_Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2018=E5=B9=B47=E6=9C=881=E6=97=A5(=E6=97=A5) 2:40 Jonathan Cameron <jic23@k=
ernel.org>:
>
> On Mon, 25 Jun 2018 00:05:21 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> > When the buffer is enabled for ina2xx driver, a dedicated kthread is
> > invoked to capture mesurement data.  When the buffer is disabled, the
> > kthread is stopped.
> >
> > However if the kthread gets register access errors, it immediately exit=
s
> > and when the malfunctional buffer is disabled, the stale task_struct
> > pointer is accessed as there is no kthread to be stopped.
> >
> > A similar issue in the usbip driver is prevented by kthread_get_run and
> > kthread_stop_put helpers by increasing usage count of the task_struct.
> > This change applies the same solution.
> >
> > Cc: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Seems fine, but this is a fix so should have an appropriate fixes
> tag.  Feel free to send one in reply to this thread rather than a v2.

It seems like this problem has been there ever since the ina2xx driver
was added.

Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monitors=
")

> Without a fixes tag it can be very hard to know exactly where
> a patch 'should' apply.  I also have little visibility on
> how important backporting htis issue is.  What would actually trigger
> the issue and is it likely to be seen in the wild?

This issue was actually triggered in the system with an I2C controller
that occasionally malfunctions due to a software bug in the controller
driver.

BTW, there is no way to notify this error to the process that is calling
poll() or read() to the buffer.  Maybe we should implement the mechanism
for returning POLLHUP or POLLERR events.
