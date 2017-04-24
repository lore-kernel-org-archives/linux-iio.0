Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:60197 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935621AbdDXUK1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Apr 2017 16:10:27 -0400
Message-ID: <1493064617.24567.182.camel@linux.intel.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
Date: Mon, 24 Apr 2017 23:10:17 +0300
In-Reply-To: <1493064330.24567.180.camel@linux.intel.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
         <1493064330.24567.180.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2017-04-24 at 23:05 +0300, Andy Shevchenko wrote:
> On Mon, 2017-04-24 at 21:28 +0200, Jan Kiszka wrote:
> > This is an upstream port of an IIO driver for the TI ADC108S102 and
> > ADC128S102. The former can be found on the Intel Galileo Gen2 and
> > the
> > Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
> > included.

> > +static const struct acpi_device_id adc1x8s102_acpi_ids[] = {
> > +	{ "INT3495",  (kernel_ulong_t)&adc1x8s102_setup_int3495 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, adc1x8s102_acpi_ids);

One more thing, please provide an excerpt from real DSDT that describes
this device.

And just in case one question, is that DSDT carved in stone?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
