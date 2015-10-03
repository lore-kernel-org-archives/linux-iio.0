Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44200 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbbJCKH2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Oct 2015 06:07:28 -0400
Subject: Re: [PATCH 2/2] iio: remove gpio interrupt probing from drivers that
 use a single interrupt
To: Bastien Nocera <hadess@hadess.net>,
	Octavian Purdila <octavian.purdila@intel.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1442998921-17665-1-git-send-email-octavian.purdila@intel.com>
 <1442998921-17665-3-git-send-email-octavian.purdila@intel.com>
 <1442999087.3658.22.camel@hadess.net>
Cc: srinivas.pandruvada@linux.intel.com, daniel.baluta@intel.com,
	irina.tirdea@intel.com, ao2@ao2.it, u.kleine-koenig@pengutronix.de,
	vlad.dogaru@intel.com, linus.walleij@linaro.org,
	tiberiu.a.breana@intel.com, javier@osg.samsung.com,
	dan.carpenter@oracle.com, geert@linux-m68k.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560FA8D9.9060104@kernel.org>
Date: Sat, 3 Oct 2015 11:07:21 +0100
MIME-Version: 1.0
In-Reply-To: <1442999087.3658.22.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/15 10:04, Bastien Nocera wrote:
> On Wed, 2015-09-23 at 12:02 +0300, Octavian Purdila wrote:
>> Commit 845c877009cf014b ("i2c / ACPI: Assign IRQ for devices that
>> have
>> GpioInt automatically") automatically asigns
> 
> assigns.
Fixed up description and applied to the togreg branch of iio.git.
Initially pushed out as testing.  Nice to finally clear this lot
out!  Now I just have to remember that we don't need this boiler
plate ever again.

Thanks,

Jonathan
> 
>>  the first ACPI GPIO
>> interrupt in client->irq, so we can remove the probing code from
>> drivers that use only one interrupt.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

