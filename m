Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33278 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbbGEXuO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 19:50:14 -0400
Received: by oiyy130 with SMTP id y130so107077192oiy.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2015 16:50:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <33438a3f3e237279d0807a4241efa495@imap.cosmopool.net>
References: <op.x1bjac2cfh00o9@enterprised.lan>
	<33438a3f3e237279d0807a4241efa495@imap.cosmopool.net>
Date: Mon, 6 Jul 2015 01:50:13 +0200
Message-ID: <CACRpkdaj+bgGMjmJvCQhYtUGw2sZ4QG==tZ98sCrNfYfGe6b2A@mail.gmail.com>
Subject: Re: [RFC PATCH] iio: humidity: dht11: Rewrite decode algorithm,
 improve read reliability
From: Linus Walleij <linus.walleij@linaro.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Jonathan Bell <jonathan@raspberrypi.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>,
	Richard Weinberger <richard@nod.at>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 6, 2015 at 1:39 AM,  <harald@ccbib.org> wrote:
> On Sun, 5 Jul 2015 22:00:02 +0100, Jonathan Bell
> <jonathan@raspberrypi.org>
> wrote:

>> - Cater for GPIO chips that can raise interrupts when I/O pins
>>    are set as output by expanding the maximum number of edges recorded.
>> - Start decoding the bitstream right-justified to make the driver
> agnostic
>>    towards whether the start bits generate IRQs.
>
> That was the original behaviour, but is actively prohibited by some GPIO
> chip drivers. We asked Linus Walleij about it in
> https://lkml.org/lkml/2014/12/1/171 who replied:
> "IRQs on pins set to output *does* *not* *make* *sense*." I still
> disagree,

I just don't understand this usecase. Can you explain to me
what you are doing and why exactly so as to soften me up
a bit?

Yours,
Linus Walleij
