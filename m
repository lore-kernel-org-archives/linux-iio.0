Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38073 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800AbcBHVXd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 8 Feb 2016 16:23:33 -0500
Date: Mon, 8 Feb 2016 15:23:28 -0600
From: Rob Herring <robh@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: adc: add support for
 ADC0831/ADC0832/ADC0834/ADC0838 chips
Message-ID: <20160208212328.GA1069@rob-hp-laptop>
References: <1454836456-17033-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454836456-17033-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 07, 2016 at 06:14:16PM +0900, Akinobu Mita wrote:
> This adds ADC0831/ADC0832/ADC0834/ADC0838 8-bit ADC driver.
> I have tested with ADC0831 and ADC0832.  The remaining ADC0834 and
> ADC0838 are very similar to ADC0832.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> ---
> * v2 (Most changes are suggested by Jonathan Cameron)
> - rename driver name from ti-adc083x to ti-adc0832
> - simplify read_raw() by moving lock
> - fix remove() of driver with correct unwinding
> - enable untested chips (adc0831, adc0834, adc0838)
> - fix adc0831_adc_conversion as a result of testing
> 
>  .../devicetree/bindings/iio/adc/ti-adc0832.txt     |  19 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ti-adc0832.c                       | 288 +++++++++++++++++++++
>  4 files changed, 318 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc0832.txt
>  create mode 100644 drivers/iio/adc/ti-adc0832.c
> 
