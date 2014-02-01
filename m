Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:57978 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbaBAF2M (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 1 Feb 2014 00:28:12 -0500
From: Marek Vasut <marex@denx.de>
To: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH 2/2] iio: Add AS3935 lightning sensor support
Date: Sat, 1 Feb 2014 06:28:04 +0100
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Matt Porter <matt.porter@linaro.org>,
	Koen Kooi <koen@dominion.thruhere.net>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Mark Brown <broonie@kernel.org>
References: <1391182703-2201-1-git-send-email-mranostay@gmail.com> <201402010412.24434.marex@denx.de> <CAKzfze8b6m__TprPoNthRZ=2h9D11MfK8Q-mR9=KWySP4aDnMA@mail.gmail.com>
In-Reply-To: <CAKzfze8b6m__TprPoNthRZ=2h9D11MfK8Q-mR9=KWySP4aDnMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201402010628.04324.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Saturday, February 01, 2014 at 06:03:22 AM, Matt Ranostay wrote:
> Duly noted. Will be fixed in the next rev... mutexs are pointless as you
> say.. only corner case would be if you were changing gain_boost and a event
> came in at the same time. But that wouldn't harm anything except slightly
> delay the gain_boost being updated by some  x microseconds.

Please stop top-posting ;-)

btw I think you might need a mutex around the entire:

+static void calibrate_as3935(struct as3935_state *st)
+{
+       /* mask disturber interrupt bit */
+       as3935_write(st, AS3935_INT, 1 << 5);
+
+       as3935_write(st, AS3935_CALIBRATE, 0x96);
+       as3935_write(st, AS3935_TUNE_CAP, 1 << 5 | st->tune_cap);
+
+       mdelay(2);
+       as3935_write(st, AS3935_TUNE_CAP, st->tune_cap);
+}

and similar functions where you do a bunch of register accesses. This is because 
you probably want to protect them against concurent execution so the chip won't 
be confused if a user were to poke something via SYSFS twice.

Best regards,
Marek Vasut
