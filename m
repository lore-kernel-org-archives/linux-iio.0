Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:57373 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161883Ab3DEO4Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Apr 2013 10:56:16 -0400
Received: by mail-la0-f45.google.com with SMTP id fn20so95636lab.18
        for <linux-iio@vger.kernel.org>; Fri, 05 Apr 2013 07:56:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <515E90FD.10006@metafoo.de>
References: <1363364801-23684-1-git-send-email-ch.naveen@samsung.com>
	<51439846.9090201@metafoo.de>
	<CAD=FV=V+-DwCjGoookySCazazBBYOoRO+=G5Q_WXAw+SrXNc-A@mail.gmail.com>
	<5144849A.8050907@metafoo.de>
	<CAD=FV=VBYHyD6yXBrM1BV3gazDFT0oHgvJM0+5LU1w4AO16Yzg@mail.gmail.com>
	<515E90FD.10006@metafoo.de>
Date: Fri, 5 Apr 2013 07:56:14 -0700
Message-ID: <CAD=FV=XHKn_vqv7-rqpraJy_V2kyBfo98WdMsAJ5eXhADc_rmA@mail.gmail.com>
Subject: Re: [RFC: PATCH 2/2] iio: adc: exynos_adc: Handle timeout and race conditions
From: Doug Anderson <dianders@chromium.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	linux-iio <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Naveen Krishna <naveenkrishna.ch@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars,

On Fri, Apr 5, 2013 at 1:53 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Since we sleep inside the protected section we need to use a mutex.

Ah, good point.

> It's not the timeout case I'm worried about, but the case where the transfer
> is interrupted by the user. Even though it is rather unlikely for the
> problem to occur we should still try to avoid it, this is one of these
> annoying heisenbugs that happen once in a while and nobody is able to
> reproduce them.

Yes, of course.  Then we can also get extra confidence that the reset
logic works well by stressing out this case...  :)

This makes me think, though.  Given how fast we expect the ADC
transaction to finish, would there be any benefit to making the wait
non-interruptible and then shortening the timeout a whole lot.  If we
shortened to 1ms then we're really not "non-interruptible" for very
long and there's less chance of subtle bugs in the way that reset
works.

-Doug
