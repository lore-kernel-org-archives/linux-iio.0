Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752164AbeGGQH1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Jul 2018 12:07:27 -0400
Date: Sat, 7 Jul 2018 17:07:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org,
        Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH] iio: adc: ina2xx: avoid kthread_stop() with stale
 task_struct
Message-ID: <20180707170721.5abc618f@archlinux>
In-Reply-To: <CAC5umyhY62whz2GfY59MngLMUu6KLnpw5wW1+FY_p8FwHpLsOw@mail.gmail.com>
References: <1529852721-17828-1-git-send-email-akinobu.mita@gmail.com>
        <20180630184049.47d10937@archlinux>
        <CAC5umyhY62whz2GfY59MngLMUu6KLnpw5wW1+FY_p8FwHpLsOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2 Jul 2018 17:44:42 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2018=E5=B9=B47=E6=9C=881=E6=97=A5(=E6=97=A5) 2:40 Jonathan Cameron <jic23=
@kernel.org>:
> >
> > On Mon, 25 Jun 2018 00:05:21 +0900
> > Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > =20
> > > When the buffer is enabled for ina2xx driver, a dedicated kthread is
> > > invoked to capture mesurement data.  When the buffer is disabled, the
> > > kthread is stopped.
> > >
> > > However if the kthread gets register access errors, it immediately ex=
its
> > > and when the malfunctional buffer is disabled, the stale task_struct
> > > pointer is accessed as there is no kthread to be stopped.
> > >
> > > A similar issue in the usbip driver is prevented by kthread_get_run a=
nd
> > > kthread_stop_put helpers by increasing usage count of the task_struct.
> > > This change applies the same solution.
> > >
> > > Cc: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com> =20
> > Seems fine, but this is a fix so should have an appropriate fixes
> > tag.  Feel free to send one in reply to this thread rather than a v2. =
=20
>=20
> It seems like this problem has been there ever since the ina2xx driver
> was added.
>=20
> Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monito=
rs")
>=20
Thanks, added.
> > Without a fixes tag it can be very hard to know exactly where
> > a patch 'should' apply.  I also have little visibility on
> > how important backporting htis issue is.  What would actually trigger
> > the issue and is it likely to be seen in the wild? =20
>=20
> This issue was actually triggered in the system with an I2C controller
> that occasionally malfunctions due to a software bug in the controller
> driver.

In that case I'm not going to rush it, but rather will take it via the
next merge window.

>=20
> BTW, there is no way to notify this error to the process that is calling
> poll() or read() to the buffer.  Maybe we should implement the mechanism
> for returning POLLHUP or POLLERR events.

I'm certainly not against adding something like that to notify on error
cases.  In general, minor hardware failures are not well handled in the
kernel - there is no 'standard' way of doing it.  Every now and then
it is discussed but no one ever takes it any further.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

