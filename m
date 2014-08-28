Return-Path: <lee.jones@linaro.org>
Date: Thu, 28 Aug 2014 08:11:23 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_adc: make sample delay, open
 delay, averaging DT parameters
Message-ID: <20140828071123.GE24579@lee--X1>
References: <1409141990-29627-1-git-send-email-vigneshr@ti.com>
 <1409141990-29627-2-git-send-email-vigneshr@ti.com>
 <20140827135635.GH6364@lee--X1>
 <53FEBA43.2000607@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53FEBA43.2000607@ti.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, 28 Aug 2014, Vignesh R wrote:
> On Wednesday 27 August 2014 07:26 PM, Lee Jones wrote:
> > On Wed, 27 Aug 2014, Vignesh R wrote:
> > 
> >> Number of averaging, open delay, sample delay are made DT parameters.
> >> By decreasing averaging and delays more samples can be obtained per
> >> second increasing performance of ADC. Previously the number of
> >> averages per step was fixed to 16. Making these parameters
> >> configurable will help in balancing speed vs accuracy.
> >> For each ADC step provide DT based paramters to set open delay,
> >> sample delay and number of averaging. One configurable step is
> >> used per ADC channel. Since there can be atmost 8 ADC channels,
> >> steps 16 to 8 are used for ADC.
> >>
> >> Signed-off-by: Vignesh R <vigneshr@ti.com>
> >> ---
> >>  .../bindings/input/touchscreen/ti-tsc-adc.txt      |   18 +++++++
> >>  drivers/iio/adc/ti_am335x_adc.c                    |   49 +++++++++++++++++---
> >>  include/linux/mfd/ti_am335x_tscadc.h               |    3 ++
> >>  3 files changed, 63 insertions(+), 7 deletions(-)
> > 
> > [...]
> > 
> >> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> >> index fb96c84..26d3e84 100644
> >> --- a/include/linux/mfd/ti_am335x_tscadc.h
> >> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> >> @@ -82,14 +82,17 @@
> > 
> > There are so many different formats at play here, it's difficult to
> > see what's happening where!
> 
> I did not understand "different formats". Please explain.

My complaint is with the existing layout, rather than your patch:

> #define STEPCONFIG_INP_AN4     STEPCONFIG_INP(4)
> #define STEPCONFIG_INP_ADCREFM STEPCONFIG_INP(8)
> #define STEPCONFIG_FIFO1       BIT(26)

Base10 MACROS.

#define STEPCONFIG_AVG_MAX     16

Base10 int.

> /* Delay register */
> #define STEPDELAY_OPEN_MASK    (0x3FFFF << 0)

Base16 shift.

> #define STEPDELAY_OPEN(val)    ((val) << 0)

MACRO shift.

> #define STEPCONFIG_OPENDLY     STEPDELAY_OPEN(0x098)

Base16 MACRO.

> #define STEPDELAY_OPEN_MAX     0x3FFFF

Base16 int.

> #define STEPDELAY_SAMPLE_MASK  (0xFF << 24)

Base16 shift.

> #define STEPDELAY_SAMPLE(val)  ((val) << 24)

MACRO shift.

> #define STEPCONFIG_SAMPLEDLY   STEPDELAY_SAMPLE(0)

24 shift of 0 (still zero?).

> #define STEPDELAY_SAMPLE_MAX   0xFF

Base16 int.

There is no consistency here, it's just a bunch of 'stuff', which
makes making sense of them all difficult.

> >>  #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
> >>  #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
> >>  #define STEPCONFIG_FIFO1	BIT(26)
> >> +#define STEPCONFIG_AVG_MAX	16
> >>  
> >>  /* Delay register */
> >>  #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
> >>  #define STEPDELAY_OPEN(val)	((val) << 0)
> > 
> > What's the point in shifting by zero?
> 
> I agree. But my patch did not add these lines. I can remove them. Do you
> want me to do this change as part of current patch or as a separate
> cleanup patch?

That's up to Jonathan.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
