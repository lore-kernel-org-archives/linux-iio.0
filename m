Return-Path: <SRS0=EHtR=ZP=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <0c54c4d8-265c-112e-60f1-af21b73148ec@kernel.org>
References: <20170131100938.23660-1-linus.walleij@linaro.org>
 <CACRpkdYDMH9A=ezPkANRQXcqceEqn-A+oL2TxHyNkjmSms5AOA@mail.gmail.com> <0c54c4d8-265c-112e-60f1-af21b73148ec@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 Feb 2017 15:47:34 +0100
Message-ID: <CACRpkdYLwVEuOcjyGYo7U=57JY3-R2FCYnEBWFqL89iqm3yEDA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
	Andy Gross <andy.gross@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
	Stephen Boyd <sboyd@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rama Krishna Phani A <rphani@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jan 31, 2017 at 8:54 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> Applied this one as well with a spot of fuzz but all obvious stuff in the
> Makefile.
>
> However...
>
> ERROR: "qcom_vadc_decimation_from_dt" [drivers/iio/adc/qcom-spmi-vadc.ko] undefined!
> ERROR: "qcom_vadc_scale" [drivers/iio/adc/qcom-spmi-vadc.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
> make: *** [Makefile:1198: modules] Error 2
>
> I've fixed that up and some static declaration issue.
>
> Please do sanity check builds as modules!  It all needs to be one one object file
> when added to the $(magic)-m

Sorry :(

I guess I should really get better at that. I guess the sloppiness comes
from never using modules for anything on any system in the first place.

I did push a branch to my kernelorg git linux-integrator.git so I was
expecting the zerodaybuild to pick it up and build it and find these things
but apparently I doesn't. Mea culpa, need to check with Fenguang
about this.

> However, I can't see any way of keeping them module name as was (qcom-smpi-vadc.ko)
> without renaming one of the c files out of the way. Please check I haven't messed
> anything up.  The new naming is a bit naff, but I couldn't think of anything better
> off the top of my head!

It looks all right to me, there is a dangling space after
+obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
otherwise it looks fine.

> Actually this is enough of a mess I'm pulling these last two patches for now.
> Will push them out in a special testing2 branch for you to take a look at though.

By all means save it for whenever later or just tell me to resend after
v4.11-rc1. I have all time in the world.

Anyways, I cherry-picked a commit needed for a boot regression
and added a hacky DT patch and built and booted this!

The dmesg detects the device fine with nice calibration results,
lsiio reports it and the readings from the voltage ADCs work just
fine.

> I also temporarily changed the mfd dependencies to add COMPILE_TEST.
> Seems fine, so if you could do a patch adding that we'll get better build coverage.

I added || COMPILE_TEST to MFD_PM8XXX

Then I get the following with x86_64 allyesconfig:

  LD      drivers/iio/adc/built-in.o
drivers/iio/adc/qcom-pm8xxx-xoadc.o: In function `qcom_vadc_decimation_from_dt':
(.text+0x410): multiple definition of `qcom_vadc_decimation_from_dt'
drivers/iio/adc/qcom-spmi-vadc.o:(.text+0x410): first defined here
drivers/iio/adc/qcom-pm8xxx-xoadc.o: In function `qcom_vadc_scale':
(.text+0x0): multiple definition of `qcom_vadc_scale'
drivers/iio/adc/qcom-spmi-vadc.o:(.text+0x0): first defined here
../scripts/Makefile.build:446: recipe for target
'drivers/iio/adc/built-in.o' failed
make[5]: *** [drivers/iio/adc/built-in.o] Error 1
../scripts/Makefile.build:551: recipe for target 'drivers/iio/adc' failed
make[4]: *** [drivers/iio/adc] Error 2
../scripts/Makefile.build:551: recipe for target 'drivers/iio' failed

I looked at how you handle it in the Makefile, and it all makes sense to
me unfortunately, it's just this thing with baking several objects into one
module - it seems the Kbuild around that is easy to get wrong and
simply hard :(

I first naturally put all the common code into its own module and export
the symbols, simple. It just works, but that's just sooo.... ugly. So the
elegant solutions are hard to get right.

I can't figure it out right now, will get back to it after dinner or so.

Yours,
Linus Walleij
