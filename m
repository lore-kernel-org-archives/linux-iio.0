Return-Path: <SRS0=dLK4=Z6=gmail.com=daniel.baluta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 17 Feb 2017 18:23:41 +0200
Message-ID: <CAEnQRZDey70TR=nU4rpFyVMqDuUFAGc2SpNCmraUO5x29n1+ow@mail.gmail.com>
Subject: Re: [RFC 0/4] iio: trigger: Add OF support and GPIO based trigger
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux@armlinux.org.uk,
	Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Feb 17, 2017 at 6:03 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> Hi,
>
> I send this as an RFC, as I'm digging to try to get as generic
> as possible GPIO based trigger support, as discussed earlier in
> other patchset "Add EXTI GPIO trigger support to STM32 ADC":
> https://www.spinics.net/lists/arm-kernel/msg559091.html
>
> Following various comments on this, I sent this RFC to address two
> topics, that I see as possible prerequisite:
> - Add trigger OF support
> - GPIO based trigger

I wonder if we could use configfs to create and configure
a GPIO based trigger.

You should just create another trigger type (look into
drivers/iio/trigger/iio-trig-hrtimer.c)
the userspace API will look like this:

# cd /config/iio/triggers
# insert your iio-trig-gpio
# setup the global parameters for the GPIO (the local params can be
set via dts/acpi)
# cd /config/iio/trigers/gpios/

#mkdir t1

And this will create an io-gpio-trigger named t1.

Not sure this fits your usecase but would be nice to consider.

thanks,
Daniel.
