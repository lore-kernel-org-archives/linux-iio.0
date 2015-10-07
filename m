Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34827 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752697AbbJGApD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2015 20:45:03 -0400
Date: Wed, 7 Oct 2015 02:44:47 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Marek Vasut <marex@denx.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elpromaelectronics.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: mxs-lradc: Fix temperature offset
Message-ID: <20151007004447.GC3485@piout.net>
References: <1444141347-15301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <415576093.114803.1444157033983.JavaMail.open-xchange@oxbaltgw07.schlund.de>
 <561456ED.5010108@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <561456ED.5010108@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 07/10/2015 at 01:19:09 +0200, Marek Vasut wrote :
> >>/* The calculated value from the ADC is in Kelvin, we
> >>* want Celsius for hwmon so the offset is
> >>- * -272.15 * scale
> >>+ * -273.15 * scale
> >>*/
> >>- *val = -1075;
> >>- *val2 = 691699;
> >>+ *val = -1079;
> >>+ *val2 = 644268;
> >>
> >
> >i think it would be nice to break down the calculation of these magic values in
> >a second patch.
> 
> Indeed, I agree. I hope Alexandre can send another patch for that soon :-)
> 

On my side, I'm not sure this is worth more than a comment. If
necessary, I can write that the datasheet specifies that the scale is
4/1.012 here also.

Else you end up with something like that (naive implementation):

#define SCALE (4 * 1000 / 1012)

val = -273150000 * SCALE / 1000000;
val2 = 273150000 * SCALE + 1000000 * val;

I don't feel this is any clearer because we can't use floating points in
the kernel anyway.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
