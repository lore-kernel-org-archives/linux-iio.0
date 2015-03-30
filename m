Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <20150330133307.GE1524@lahna.fi.intel.com>
References: <CAE1zotKAJBS2_rnYG9K0DxbvVP9-G4iGm_E+b5jQtHVYjiQwVA@mail.gmail.com>
	<20150326140430.GM1878@lahna.fi.intel.com>
	<CAE1zotL0Si3=dGLGPmq0CGhc+tsJwDxY8GYwh8fcHA-1jcBdqA@mail.gmail.com>
	<20150326144753.GO1878@lahna.fi.intel.com>
	<CAE1zot+67M96HbMnorYxEd06r=Aew=x830sCXoovBCCy_YMF7w@mail.gmail.com>
	<CAE1zot+MaycNK91yOMLAfdvo=f21S9hts9ufk4krBMJ7PNYogA@mail.gmail.com>
	<20150327100627.GW1878@lahna.fi.intel.com>
	<CACRpkda9pUqy9r9EUSfzC5ntqKpH_CywcLJLDXCUa25U_cgFgg@mail.gmail.com>
	<20150330095254.GB1524@lahna.fi.intel.com>
	<CAE1zotJCo2oUJLb3ETozxutFCXUD8gKZeUL-qWj-Y8gW0idr8Q@mail.gmail.com>
	<20150330133307.GE1524@lahna.fi.intel.com>
Date: Mon, 30 Mar 2015 16:52:49 +0300
Message-ID: <CAE1zot+CTmWaszPjuUj69WNgBgqJMccF48to-9txVPNfYu-GGg@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Octavian Purdila <octavian.purdila@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Robert Dolca <robert.dolca@gmail.com>, Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 30, 2015 at 4:33 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Mar 30, 2015 at 03:55:14PM +0300, Octavian Purdila wrote:
>> On Mon, Mar 30, 2015 at 12:52 PM, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>> > On Fri, Mar 27, 2015 at 11:36:25AM +0100, Linus Walleij wrote:
>> >> On Fri, Mar 27, 2015 at 11:06 AM, Mika Westerberg
>> >> <mika.westerberg@linux.intel.com> wrote:
>> >> > On Thu, Mar 26, 2015 at 06:28:19PM +0200, Octavian Purdila wrote:
>> >>
>> >> >> For the sleep case I think the GPIO controller needs to do the pin
>> >> >> enable and set input direction operation in it's irq_bus_sync_unlock.
>> >> >
>> >> > I wonder how DT handles all this? Is it the boot firmware that sets up
>> >> > the pins accordingly or is there something we are missing?
>> >>
>> >> DT systems mostly do not have firmware for power usecases, they
>> >> handle it all using pin control. I would more say that is a feature of
>> >> all-SW systems without power-firmware ideas, without ACPI and
>> >> without PSCI (well PSCI systems do not care about much more
>> >> than CPU power down in firmware anyway...)
>> >
>> > OK, thanks.
>> >
>> > In case of ACPI (where firmware does lot more) it is supposed to
>> > configure pins based on what is connected, if the firmware knows that.
>> > Due to bugs in the boot firmware that obviously does not happen in all
>> > cases (like this one).
>> >
>>
>> Ah, interesting, I was not aware that the firmware was supposed to do
>> the pin configuration. In this case I think your patch can be merged
>> as it is Mika, mine doesn't make sense anymore.
>
> Unfortunately because of bugs we can't rely that the firmware (BIOS)
> gets those always right :-(
>
>> This particular case is special since we did not performed the tests
>> on a full system that has the component integrated. We instead used
>> and I2C to USB bridge to which we connected the component and we
>> loaded the ACPI table dynamically.
>
> Regardless of how did the device appear this always works:
>
>   1) request the GPIO (with GPIOD_IN)
>   2) convert it to IRQ using gpiod_to_irq()
>
> Since we cannot be sure that the firmware has configured the pin
> properly, rather than adding automatic IRQ <-> GPIO translation for ACPI
> GpioInt I think we are better off if drivers explictly request their
> GPIOs and configure them as needed.


Yes, this is what we are doing now and it works well.

But I am not yet ready to give-up on the automatic IRQ <-> GPIO translation :)

What if we can do the pin configuration in gpiolib right after the
GPIO controller is initialized. I am thinking of searching the ACPI
namespace and looking for resources that have GpioInt entries for that
particular GPIO controller and use them to set the pins to input (and
ideally also set the other properties like pullups, pulldowns, etc.)
