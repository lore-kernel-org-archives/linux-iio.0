Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33063 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbeIVRmP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2018 13:42:15 -0400
Date: Sat, 22 Sep 2018 17:18:49 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, nicolas.ferre@microchip.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/2] iio: adc: at91: fix wrong channel number in
 triggered buffer mode
Message-ID: <20180922114849.GA3890@himanshu-Vostro-3559>
References: <1537447238-18674-2-git-send-email-eugen.hristev@microchip.com>
 <201809211544.zop1vk8B%fengguang.wu@intel.com>
 <20180922113616.2d849fb0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180922113616.2d849fb0@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 22, 2018 at 11:36:16AM +0100, Jonathan Cameron wrote:
> On Fri, 21 Sep 2018 15:26:03 +0800
> kbuild test robot <lkp@intel.com> wrote:
> 
> > Hi Eugen,
> This one is leaving me stumped...
> 
> Anyone care to point out what I'm missing that is wrong here?
> 
> Also Eugen, please don't cc stable on a patch directly.  It is fine to send
> a backport request once a patch has hit mainline, but before that it's just
> adding noise to a list as they won't take it directly anyway.

Song is correct on this one.

So, just replace the declaration to:

	struct iio_chan_spec const *chan;

and then warning goes away...

Another thing, its better not to reply the automated bot and instead to
the author by changing "From" address. :)

That is what I do often when replying to that thread.

https://lore.kernel.org/lkml/20180921182616.GA2077@himanshu-Vostro-3559/

And it nests properly in the given thread avoiding any noise to kbuild
bot.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
