Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35360 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbcEWHnX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 May 2016 03:43:23 -0400
Received: by mail-oi0-f53.google.com with SMTP id x19so265095312oix.2
        for <linux-iio@vger.kernel.org>; Mon, 23 May 2016 00:43:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1463945969-18866-1-git-send-email-jic23@kernel.org>
References: <1463945969-18866-1-git-send-email-jic23@kernel.org>
Date: Mon, 23 May 2016 09:43:22 +0200
Message-ID: <CACRpkdYBueNxSa60EfTWsX7Surmvee8V0Qbgn+CrsA_joMmxQg@mail.gmail.com>
Subject: Re: [RFC] iio: accel: st_accel: Add lis3l02dq support
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 22, 2016 at 9:39 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> Time to finally kill off the venerable (it was one of my first drivers)
> lis3l02dq driver in favour of adding support in the st sensors framework.
>
> This does loose us the event support that driver always had, but I think
> that will reappear at some point and in the meantime the maintenance
> advantages of dropping the 'special' driver for this one part outweigh
> the issues.

Which events? Free-fall?

> It's worth noting this part is ancient and I may well be the only person
> who still has any on hardware running recent kernels.

What I learnt from my years in the kernel is that there is always
a bunch of silent users, also it has this nice feeling of completing
the ST sensor suite.

> It has a few 'quirks'.
>  - No WAI register so that just became optional.

Makes sense.

>  - It's too quick.  Even at slowest rate (280Hz) I can't read out fast
>    enough on my board (stargate 2) to beat new data coming in. Linus'
>    repeat read patch doesn't help in this case. It just means I get 10
>    readings before dying... So in reality this will get used with
>    software triggers only unless someone has this long out of production
>    device on a quick board.

What is the speed of the I2C bus on this system?
If it's running on the lowest speed 100kHz that may very
well be the cause of the problem, so check if it supports
high speed (400kHz) I2C.

The patch as such looks good.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
