Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55550 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754276AbbFCKcX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Jun 2015 06:32:23 -0400
Date: Wed, 3 Jun 2015 13:32:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: change "client->irq >= 0" to "client->irq > 0"
Message-ID: <20150603103217.GQ4057@lahna.fi.intel.com>
References: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com>
 <1433280853-3988-3-git-send-email-octavian.purdila@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433280853-3988-3-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 03, 2015 at 12:34:13AM +0300, Octavian Purdila wrote:
> Since commit dab472eb931b ("i2c / ACPI: Use 0 to indicate that device
> does not have interrupt assigned"), 0 is not a valid i2c client irq
> anymore, so change all driver's checks accordingly.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>

In addition to Alexandre's comments, the change itself looks good to me
so once you address them,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks for taking care of this.
