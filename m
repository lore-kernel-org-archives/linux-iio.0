Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27160 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139AbcF1KVP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 28 Jun 2016 06:21:15 -0400
Date: Tue, 28 Jun 2016 13:21:11 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 9/9 v2] iio: pressure: bmp280: read calibration data once
Message-ID: <20160628102111.GB27798@vdogaru>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
 <1466628819-29784-10-git-send-email-linus.walleij@linaro.org>
 <20160627074258.GA3142@vdogaru>
 <651c3d5b-8199-5819-0a6a-e5aec246fa24@kernel.org>
 <CACRpkdb89mMFHQFPs4a00ZcdWmvwHRVhhjc8TBLM25ZjGrzCvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdb89mMFHQFPs4a00ZcdWmvwHRVhhjc8TBLM25ZjGrzCvg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jun 28, 2016 at 09:34:34AM +0200, Linus Walleij wrote:
> On Mon, Jun 27, 2016 at 8:57 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On 27/06/16 08:42, Vlad Dogaru wrote:
> >> On Wed, Jun 22, 2016 at 10:53:39PM +0200, Linus Walleij wrote:
> >>> The calibration data is described as coming from an E2PROM and that
> >>> means it does not change. Just read it once at probe time and store
> >>> it in the device state container. Also toss the calibration data
> >>> into the entropy pool since it is device unique.
> >>
> >> I think my initial thought when writing this was that regmap will take
> >> care of the caching and not hit the i2c bus each time.  But I don't have
> >> an issue with this change.  Other than that, series looks good to me.
> >
> > Good point. I must be half asleep.
> >
> > Linus, are we missing something? If not, I'd go without this one.
> 
> It's true that regmap does cache the contents of the registers,
> cutting the I2C bus traffic bottleneck. But reading it out every time
> still incurs a bulk read of 22 bytes from regmap, meaning 22 iterations
> in regmap where each need to be checked individually for volatileness
> etc in the regmap core, then this happens at every conversion.
> 
> Compared to just doing this once and keeping a copy around
> it is wasteful, so still an optimization worth it IMO.
> 
> Don't get me wrong, regmap is optimized
> (just check drivers/base/regmap/*) but it can never be as optimized
> as reading just once.
> 
> Also Vlad seems to OK it?

Yep, it's not a problem for me.  You're right about reading once being
more efficient and.

Thanks,
Vlad
