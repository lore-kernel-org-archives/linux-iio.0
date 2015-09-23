Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:46030 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbbIWJFA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2015 05:05:00 -0400
Message-ID: <1442999087.3658.22.camel@hadess.net>
Subject: Re: [PATCH 2/2] iio: remove gpio interrupt probing from drivers
 that use a single interrupt
From: Bastien Nocera <hadess@hadess.net>
To: Octavian Purdila <octavian.purdila@intel.com>, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: srinivas.pandruvada@linux.intel.com, daniel.baluta@intel.com,
	irina.tirdea@intel.com, ao2@ao2.it, u.kleine-koenig@pengutronix.de,
	vlad.dogaru@intel.com, linus.walleij@linaro.org,
	tiberiu.a.breana@intel.com, javier@osg.samsung.com,
	dan.carpenter@oracle.com, geert@linux-m68k.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2015 11:04:47 +0200
In-Reply-To: <1442998921-17665-3-git-send-email-octavian.purdila@intel.com>
References: <1442998921-17665-1-git-send-email-octavian.purdila@intel.com>
	 <1442998921-17665-3-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2015-09-23 at 12:02 +0300, Octavian Purdila wrote:
> Commit 845c877009cf014b ("i2c / ACPI: Assign IRQ for devices that
> have
> GpioInt automatically") automatically asigns

assigns.

>  the first ACPI GPIO
> interrupt in client->irq, so we can remove the probing code from
> drivers that use only one interrupt.
