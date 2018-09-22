Return-Path: <SRS0=zuIY=ME=gmail.com=himanshujha199640@kernel.org>
Date: Sat, 22 Sep 2018 20:26:58 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Song Qiang <songqiang1304521@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
	mark.rutland@arm.com, andriy.shevchenko@linux.intel.com,
	matt.ranostay@konsulko.com, tglx@linutronix.de, ak@it-klinger.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Message-ID: <20180922145658.GA4443@himanshu-Vostro-3559>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180922154658.752f2fbf@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180922154658.752f2fbf@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 22, 2018 at 03:46:58PM +0100, Jonathan Cameron wrote:
> On Tue, 18 Sep 2018 16:24:21 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
> > This driver was originally written by ST in 2016 as a misc input device
> > driver, and hasn't been maintained for a long time. I grabbed some code
> > from it's API and reformed it into an iio proximity device driver.
> > This version of driver uses i2c bus to talk to the sensor and
> > polling for measuring completes, so no irq line is needed.
> > It can be tested with reading from
> > /sys/bus/iio/devices/iio:deviceX/in_distance_input
> > 
> > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> There are a few bits and bobs in here, but as they are all minor and
> one at least was me giving you wrong advise, I've fixed it up.
> 
> Please check I haven't made a mess of it! 
> 
> Applied with changes to the togreg branch of iio.git and pushed out
> as testing (where it should be visible now) for the autobuilders to
> play with it.

The SPDX license identifier is inconsistent!

> +// SPDX-License-Identifier: GPL-2.0+

> +MODULE_LICENSE("GPL v2");

216         For 'GNU General Public License (GPL) version 2 only' use:
217           SPDX-License-Identifier: GPL-2.0
218         For 'GNU General Public License (GPL) version 2 or any later version' use:
219           SPDX-License-Identifier: GPL-2.0+


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
