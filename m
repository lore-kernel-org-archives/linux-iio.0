Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58228 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752394AbbGWN04 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 09:26:56 -0400
Date: Thu, 23 Jul 2015 15:26:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: fix drivers that consider 0 as a valid IRQ
 in client->irq
Message-ID: <20150723132653.GT2853@piout.net>
References: <1433512783-8183-1-git-send-email-octavian.purdila@intel.com>
 <1433512783-8183-2-git-send-email-octavian.purdila@intel.com>
 <CAE1zotJ_u+ysf+HkD=4=Nv_mJ-4++SZxjKGMRkbKzYzyunLJUg@mail.gmail.com>
 <CACRpkdYE2HG3Cm74Hg9jXy2FwvwveqpbJbwTPKvmOm6aR7BNmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdYE2HG3Cm74Hg9jXy2FwvwveqpbJbwTPKvmOm6aR7BNmQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/07/2015 at 15:11:47 +0200, Linus Walleij wrote :
> On Thu, Jul 23, 2015 at 12:59 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
> > On Fri, Jun 5, 2015 at 4:59 PM, Octavian Purdila
> > <octavian.purdila@intel.com> wrote:
> >> Since patch "i2c / ACPI: Use 0 to indicate that device does not have
> >> interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
> >> change all driver's checks accordingly.
> >>
> >> The same issue occurs when the device is instantiated via device tree
> >> with no IRQ, or from the i2c sysfs interface, even before the patch
> >> above.
> >>
> >> [1] http://lkml.kernel.org/g/<1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
> >>
> >> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> >> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Hi Jonathan,
> >
> > Does this look OK to you? If so, could you pleas ACK the patch so that
> > Linus can pick it up in its for-next branch if/when needed?
> 
> Me or Torvalds?
> 
> This looks more like a Wolfram patch to me if it should not
> go through IIO.
> 

The first cover letter had:

"Linus, since the commit above was already merged in the GPIO tree,
should these fixes be merged also via the GPIO tree (with ACKs from
the others subsystem maintainers)?"

I believe it was referring to you ;). I can take the rtc patch if you
don't plan to take it.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
