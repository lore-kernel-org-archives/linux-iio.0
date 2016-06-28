Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35043 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbcF1Hef (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 03:34:35 -0400
Received: by mail-oi0-f44.google.com with SMTP id r2so11289999oih.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2016 00:34:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <651c3d5b-8199-5819-0a6a-e5aec246fa24@kernel.org>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
 <1466628819-29784-10-git-send-email-linus.walleij@linaro.org>
 <20160627074258.GA3142@vdogaru> <651c3d5b-8199-5819-0a6a-e5aec246fa24@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Jun 2016 09:34:34 +0200
Message-ID: <CACRpkdb89mMFHQFPs4a00ZcdWmvwHRVhhjc8TBLM25ZjGrzCvg@mail.gmail.com>
Subject: Re: [PATCH 9/9 v2] iio: pressure: bmp280: read calibration data once
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 27, 2016 at 8:57 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 27/06/16 08:42, Vlad Dogaru wrote:
>> On Wed, Jun 22, 2016 at 10:53:39PM +0200, Linus Walleij wrote:
>>> The calibration data is described as coming from an E2PROM and that
>>> means it does not change. Just read it once at probe time and store
>>> it in the device state container. Also toss the calibration data
>>> into the entropy pool since it is device unique.
>>
>> I think my initial thought when writing this was that regmap will take
>> care of the caching and not hit the i2c bus each time.  But I don't have
>> an issue with this change.  Other than that, series looks good to me.
>
> Good point. I must be half asleep.
>
> Linus, are we missing something? If not, I'd go without this one.

It's true that regmap does cache the contents of the registers,
cutting the I2C bus traffic bottleneck. But reading it out every time
still incurs a bulk read of 22 bytes from regmap, meaning 22 iterations
in regmap where each need to be checked individually for volatileness
etc in the regmap core, then this happens at every conversion.

Compared to just doing this once and keeping a copy around
it is wasteful, so still an optimization worth it IMO.

Don't get me wrong, regmap is optimized
(just check drivers/base/regmap/*) but it can never be as optimized
as reading just once.

Also Vlad seems to OK it?

Yours,
Linus Walleij
