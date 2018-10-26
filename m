Return-Path: <SRS0=Vi+J=NG=linux.intel.com=andriy.shevchenko@kernel.org>
Date: Fri, 26 Oct 2018 15:12:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan O'Donovan <dan@emutex.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Carlos Iglesias <carlos.iglesias@emutex.com>,
	Nicola Lunghi <nicola.lunghi@emutex.com>,
	Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
Message-ID: <20181026121228.GE10650@smile.fi.intel.com>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
 <1540481742-23596-3-git-send-email-dan@emutex.com>
 <20181025174638.GB10650@smile.fi.intel.com>
 <c17cf6de-846b-aed3-7745-4f635495873e@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c17cf6de-846b-aed3-7745-4f635495873e@emutex.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 26, 2018 at 11:13:01AM +0100, Dan O'Donovan wrote:
> On 10/25/2018 06:46 PM, Andy Shevchenko wrote:
> > On Thu, Oct 25, 2018 at 04:35:41PM +0100, Dan O'Donovan wrote:

> >> +	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */

> > Looking how driver is organized and what ACPI can provide I would highly
> > recommend to look forward to PTYP field for utilization of the type of the HW.

> > Maybe it would not work with published BIOSes, but would be good for the future
> > (in that case anybody can utilize that _HID + PTYP pair on their platforms).

> Thanks Andy for your review and feedback.  Your _HID + PTYP suggestion sounds
> interesting, but I couldn't find any information in the ACPI spec or elsewhere
> about how/when/where to use it.  

I stand corrected, it's not in the spec, rather de facto use of it in some
cases, see below.

> It isn't used in the UP Squared ACPI tables.
> Do you have any links or other information you could share about it? Thanks!

As far as I can find the following code in the kernel and thus real ACPI tables
in the wild that utilize it.

drivers/acpi/dptf/dptf_power.c:84:      status = acpi_evaluate_integer(acpi_dev->handle, "PTYP", NULL, &ptype);
drivers/platform/x86/intel_cht_int33fe.c:101:   status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
drivers/thermal/int340x_thermal/int3403_thermal.c:237:  status = acpi_evaluate_integer(priv->adev->handle, "PTYP",


-- 
With Best Regards,
Andy Shevchenko
