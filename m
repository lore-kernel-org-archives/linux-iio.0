Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:62756 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759739AbaJaUxm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 31 Oct 2014 16:53:42 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so2015060iec.7
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2014 13:53:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c422075c-f86a-415b-a19b-d4c11fd5e0fd@email.android.com>
References: <1408815064-5763-1-git-send-email-linus.walleij@linaro.org>
	<53FB6205.5020704@kernel.org>
	<CACRpkdZuSsePVjPpmLV5bs5VOcbnH2_gK4-kOfbpBM1-7Q=zgQ@mail.gmail.com>
	<c422075c-f86a-415b-a19b-d4c11fd5e0fd@email.android.com>
Date: Fri, 31 Oct 2014 21:53:41 +0100
Message-ID: <CACRpkdZQk+5bemmLQsiP-eLiAhrS8-cJriP=8LBaBDu+Jiustw@mail.gmail.com>
Subject: Re: [PATCH] iio: st-sensors: add support for lis3lv02d accelerometer
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Sep 11, 2014 at 6:39 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On September 11, 2014 10:13:24 AM GMT+01:00, Linus Walleij <linus.walleij@linaro.org> wrote:

>>Apart from that it has a custom sysfs interface to read the
>>accelerometer, similar to the IIO interface. It seems to *only* support
>>raw values AFAICT  though, not sensitivity adjustment, so my patch
>>gives the ability to have better sensor handling in the kernel from an
>>IIO point of view.
>>
> I likewise looked at this long ago (came out roughly concurrently
> with the similar lis3l02dq driver) came to roughly the same conclusion.

So Jonathan what do you say, should we simply merge this patch?

It will be two drivers in the kernel for the same hardware but one
of them is modern and uses IIO.

The misc driver maintainers doesn't seem to be moving anywhere
near IIO on its own whereas this patch establishes a base for
moving features over to generic IIO whenever someone finds the
time.

Yours,
Linus Walleij
