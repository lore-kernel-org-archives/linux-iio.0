Return-Path: <alexandre.belloni@free-electrons.com>
Date: Thu, 23 Jul 2015 17:01:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rtc: fix drivers that consider 0 as a valid IRQ
 in client->irq
Message-ID: <20150723150119.GA14893@piout.net>
References: <1433512783-8183-1-git-send-email-octavian.purdila@intel.com>
 <1433512783-8183-3-git-send-email-octavian.purdila@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433512783-8183-3-git-send-email-octavian.purdila@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On 05/06/2015 at 16:59:43 +0300, Octavian Purdila wrote :
> Since patch "i2c / ACPI: Use 0 to indicate that device does not have
> interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
> change all driver's checks accordingly.
> 
> The same issue occurs when the device is instantiated via device tree
> with no IRQ, or from the i2c sysfs interface, even before the patch
> above.
> 
> [1] http://lkml.kernel.org/g/<1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Applied, thanks.

I included the final commit id instead of the link to the mailing list
redirector.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
