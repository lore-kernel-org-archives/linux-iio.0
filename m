Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:65401 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbbCIUFP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 16:05:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iio: ak8975: fix AK09911 dependencies
Date: Mon, 09 Mar 2015 21:05:02 +0100
Message-ID: <3043946.mVD7WvMa1C@wuerfel>
In-Reply-To: <54FD7AF2.8020605@kernel.org>
References: <7968545.0Cq9DcaG85@wuerfel> <CAMuHMdU9x_OUReNMdZx+urZE3FDx2qz1m6gDRVp8qJ0r_QF5tA@mail.gmail.com> <54FD7AF2.8020605@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday 09 March 2015 10:50:26 Jonathan Cameron wrote:
> >> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> >> index 4c7a4c52dd06..a5d6de72c523 100644
> >> --- a/drivers/iio/magnetometer/Kconfig
> >> +++ b/drivers/iio/magnetometer/Kconfig
> >> @@ -18,6 +18,8 @@ config AK8975
> >>
> >>  config AK09911
> >>         tristate "Asahi Kasei AK09911 3-axis Compass"
> >> +       depends on I2C
> >> +       depends on GPIOLIB
> >>         select AK8975
> >>         help
> >>           Deprecated: AK09911 is now supported by AK8975 driver.
> > 
> > I just saw the AK8975/AK09911 config options disappear for a v4.0-rc3 m68k
> > allmodconfig kernel. Apparently it built fine with !GPIOLIB before, as many
> > gpiolib (consumer) functions have dummies for the !GPIOLIB case.
> > 
> > So I think the GPIOLIB dependency can be relaxed to "GPIOLIB || COMPILE_TEST".
> > The same may be true for many other GPIOLIB consumer drivers.
> > Will look into it and send patches...

The reason for this dependency is the 'select AK8975', which causes a Kconfig
warning if GPIOLIB is disabled. I do not see an actual dependency on gpiolib
in the ak8975 driver, but relaxing this means we have to remove the dependency
for both of them together, not just for AK09911.

	Arnd
