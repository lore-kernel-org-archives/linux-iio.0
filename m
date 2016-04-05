Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36045 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbcDEHuX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Apr 2016 03:50:23 -0400
Received: by mail-oi0-f54.google.com with SMTP id y204so7609249oie.3
        for <linux-iio@vger.kernel.org>; Tue, 05 Apr 2016 00:50:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160404223546.GC8755@atomide.com>
References: <1459326847-9444-1-git-send-email-linus.walleij@linaro.org>
	<5700E7AF.6040903@kernel.org>
	<CACRpkdYkqzvu_fMcDPy8i0OCpGdGQ39S534HbCQL8T93gadKmQ@mail.gmail.com>
	<20160404074239.GT7800@tbergstrom-lnx.Nvidia.com>
	<20160404223546.GC8755@atomide.com>
Date: Tue, 5 Apr 2016 09:50:23 +0200
Message-ID: <CACRpkdbi=big65-yMXXipE1i_YSDo=7BMWDohXcVCpwSi5HMPg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: new driver for the ROHM BH1780
From: Linus Walleij <linus.walleij@linaro.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Paul Walmsley <paul@pwsan.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@caiaq.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux-OMAP <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 5, 2016 at 12:35 AM, Tony Lindgren <tony@atomide.com> wrote:

> Adding linux-omap to Cc. I suggest do a minimal patch to remove the
> sysfs interface, then revert the patch if needed. I don't think
> people are using it.

The old driver in misc is just using sysfs for everything, so removing the
sysfs is like deleting the driver. Once the IIO driver is merged I guess
I'll boldly post a patch to delete it and then a patch to activate the new
driver in the OMAP defconfig.

Yours,
Linus Walleij
