Return-Path: <mark.rutland@arm.com>
Date: Thu, 15 Aug 2013 13:59:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>,
   "tony@atomide.com" <tony@atomide.com>,
   "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>,
   "rnayak@ti.com" <rnayak@ti.com>,
   "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
   "kishon@ti.com" <kishon@ti.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
   "grant.likely@linaro.org" <grant.likely@linaro.org>,
   "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
   "lars@metafoo.de" <lars@metafoo.de>,
   "sameo@linux.intel.com" <sameo@linux.intel.com>,
   "ch.naveen@samsung.com" <ch.naveen@samsung.com>,
   "poeschel@lemonage.de" <poeschel@lemonage.de>,
   "milo.kim@ti.com" <milo.kim@ti.com>, "balajitk@ti.com" <balajitk@ti.com>,
   "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>,
   "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
   "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
   "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
   "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
   "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 0/2] TWL6030, TWL6032 GPADC driver
Message-ID: <20130815125906.GA32421@e106331-lin.cambridge.arm.com>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
 <20130815091216.GB28366@e106331-lin.cambridge.arm.com>
 <520CB566.2050201@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <520CB566.2050201@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Aug 15, 2013 at 12:03:02PM +0100, Jonathan Cameron wrote:
> 
> >> The changes to the original driver:
> >> - device tree adaptation;
> > 
> > I couldn't see a binding document in this series or in mainline. Have I
> > looked in the wrong places?
> 
> Nothing explicit supplied, but does it need one given it is doing only
> iio bindings (bindings/iio/iio-bindings.txt)
> plus twl child bindings
> (bindings/mfd/twl-family.txt)

Every binding needs to be documented.

> 
> If it does, I guess absolutely everything does, then fair enough!
> I guess that would make sense as there is no way for someone writing
> a device tree to know that there is nothing else to be specified.

Yup, that's why. Also, Linux isn't necessarily the only consumer, and
other consumers shouldn't need to read Linux code to figure out how a
particular binding is supposed to look.

Cheers,
Mark.
