Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
	<6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
Date: Tue, 24 May 2016 13:40:52 +0200
Message-ID: <CACRpkdbch1dhUTdCMxLqLHY_cfmgtFvxKoBaCwf7w=RjV0vh7A@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: st_sensors: Use level interrupts
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, May 13, 2016 at 8:43 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:

> As far as I can tell DRDY for ST sensors behaves as a level rather than
> edge interrupt. Registering for IRQF_TRIGGER_RISING instead of
> IRQF_TRIGGER_HIGH mostly works except when the sampling frequency is
> high enough that new samples come before the new ones are read
> completely. In that case the interrupt line remains high, no more rising
> edges occur and the iio buffer stalls.
>
> Configuring the interrupt as IRQF_TRIGGER_HIGH makes it work as
> expected. This patch makes it so that st_sensors_trigger interrupt
> request code doesn't mangle the request flags into IRQF_TRIGGER_RISING.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>

The analysis is probably correct: the sensors will hold the line low
until the values have been read and no data is ready in the pipe.

This is delicate when the sensors are used with GPIO controllers
as interrupt line handlers, because some of them (like mine
on Ux500) do not support level interrupts :(

That means that requesting the interrupt will fail.

What we need to do is try to request a level IRQ, and if that
fails, try to request an edge IRQ or we will regress existing platforms.

And then, as Jonathan says, use the approach in the other
approach for those systems that only do edge IRQs.

For the level IRQ, IRQF_ONESHOT must be used, or the
irq handler will lock up I suspect.

Keeping my loop in the irq thread from the other patch will likely
also get the events closer in time I suspect? But for a level IRQ
it is not strictly needed.

If we can agree on a version of this patch that tries first
level, then edge IRQ, I can rebase my patch on top of it
and test.

Yours,
Linus Walleij
