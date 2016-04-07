Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:50042 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757019AbcDGRFd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 Apr 2016 13:05:33 -0400
Date: Thu, 7 Apr 2016 10:05:23 -0700
From: Tony Lindgren <tony@atomide.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Paul Walmsley <paul@pwsan.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@caiaq.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v3] iio: light: new driver for the ROHM BH1780
Message-ID: <20160407170522.GL16484@atomide.com>
References: <1459326847-9444-1-git-send-email-linus.walleij@linaro.org>
 <5700E7AF.6040903@kernel.org>
 <CACRpkdYkqzvu_fMcDPy8i0OCpGdGQ39S534HbCQL8T93gadKmQ@mail.gmail.com>
 <20160404074239.GT7800@tbergstrom-lnx.Nvidia.com>
 <20160404223546.GC8755@atomide.com>
 <CACRpkdbi=big65-yMXXipE1i_YSDo=7BMWDohXcVCpwSi5HMPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdbi=big65-yMXXipE1i_YSDo=7BMWDohXcVCpwSi5HMPg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [160405 00:51]:
> On Tue, Apr 5, 2016 at 12:35 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > Adding linux-omap to Cc. I suggest do a minimal patch to remove the
> > sysfs interface, then revert the patch if needed. I don't think
> > people are using it.
> 
> The old driver in misc is just using sysfs for everything, so removing the
> sysfs is like deleting the driver. Once the IIO driver is merged I guess
> I'll boldly post a patch to delete it and then a patch to activate the new
> driver in the OMAP defconfig.

OK

Tony
