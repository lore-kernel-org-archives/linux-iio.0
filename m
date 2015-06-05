Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54433 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751287AbbFEMyG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jun 2015 08:54:06 -0400
Date: Fri, 5 Jun 2015 14:54:04 +0200
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
Subject: Re: [PATCH v2 2/2] rtc: fix drivers that consider 0 as a valid IRQ
 in client->irq
Message-ID: <20150605125404.GI713@piout.net>
References: <1433508118-3938-1-git-send-email-octavian.purdila@intel.com>
 <1433508118-3938-3-git-send-email-octavian.purdila@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433508118-3938-3-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/2015 at 15:41:58 +0300, Octavian Purdila wrote :
> Since patch "i2c / ACPI: Use 0 to indicate that device does not have
> interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
> change all driver's checks accordingly.
> 
> The same issue occurs when the device is instantiated via device tree
> with no IRQ, or from the i2c sysfs interface, even before the patch
> above.
> 
> [1] https://lkml.org/lkml/2015/5/6/279
> 

lkml.org is not reliable and is currently losing messages. Like I
suggested, you should use the redirector at https://lkml.kernel.org/

That would be
http://lkml.kernel.org/g/<1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
