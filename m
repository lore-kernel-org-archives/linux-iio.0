Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-026.synserver.de ([212.40.185.26]:1058 "EHLO
	smtp-out-026.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbbDGJjj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2015 05:39:39 -0400
Message-ID: <5523A5D8.4090809@metafoo.de>
Date: Tue, 07 Apr 2015 11:39:36 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Octavian Purdila <octavian.purdila@intel.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Robert Dolca <robert.dolca@gmail.com>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
References: <CAE1zotKAJBS2_rnYG9K0DxbvVP9-G4iGm_E+b5jQtHVYjiQwVA@mail.gmail.com>	<20150326140430.GM1878@lahna.fi.intel.com>	<CAE1zotL0Si3=dGLGPmq0CGhc+tsJwDxY8GYwh8fcHA-1jcBdqA@mail.gmail.com>	<20150326144753.GO1878@lahna.fi.intel.com>	<CAE1zot+67M96HbMnorYxEd06r=Aew=x830sCXoovBCCy_YMF7w@mail.gmail.com>	<CAE1zot+MaycNK91yOMLAfdvo=f21S9hts9ufk4krBMJ7PNYogA@mail.gmail.com>	<20150327100627.GW1878@lahna.fi.intel.com>	<CACRpkda9pUqy9r9EUSfzC5ntqKpH_CywcLJLDXCUa25U_cgFgg@mail.gmail.com>	<20150330095254.GB1524@lahna.fi.intel.com>	<CAE1zotJCo2oUJLb3ETozxutFCXUD8gKZeUL-qWj-Y8gW0idr8Q@mail.gmail.com>	<20150330133307.GE1524@lahna.fi.intel.com>	<CAE1zot+CTmWaszPjuUj69WNgBgqJMccF48to-9txVPNfYu-GGg@mail.gmail.com> <CACRpkdZBheNLLH_9ep4dHViNdsgNbZFRoFo3gMg3RYQhbj2_+g@mail.gmail.com>
In-Reply-To: <CACRpkdZBheNLLH_9ep4dHViNdsgNbZFRoFo3gMg3RYQhbj2_+g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/07/2015 11:35 AM, Linus Walleij wrote:
> On Mon, Mar 30, 2015 at 3:52 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
>> On Mon, Mar 30, 2015 at 4:33 PM, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>>> On Mon, Mar 30, 2015 at 03:55:14PM +0300, Octavian Purdila wrote:
>>>> On Mon, Mar 30, 2015 at 12:52 PM, Mika Westerberg
>>>> <mika.westerberg@linux.intel.com> wrote:
>>>>> On Fri, Mar 27, 2015 at 11:36:25AM +0100, Linus Walleij wrote:
>>>>>> On Fri, Mar 27, 2015 at 11:06 AM, Mika Westerberg
>>>>>> <mika.westerberg@linux.intel.com> wrote:
>>>>>>> On Thu, Mar 26, 2015 at 06:28:19PM +0200, Octavian Purdila wrote:
>>>>>>
>>>>>>>> For the sleep case I think the GPIO controller needs to do the pin
>>>>>>>> enable and set input direction operation in it's irq_bus_sync_unlock.
>>>>>>>
>>>>>>> I wonder how DT handles all this? Is it the boot firmware that sets up
>>>>>>> the pins accordingly or is there something we are missing?
>>>>>>
>>>>>> DT systems mostly do not have firmware for power usecases, they
>>>>>> handle it all using pin control. I would more say that is a feature of
>>>>>> all-SW systems without power-firmware ideas, without ACPI and
>>>>>> without PSCI (well PSCI systems do not care about much more
>>>>>> than CPU power down in firmware anyway...)
>>>>>
>>>>> OK, thanks.
>>>>>
>>>>> In case of ACPI (where firmware does lot more) it is supposed to
>>>>> configure pins based on what is connected, if the firmware knows that.
>>>>> Due to bugs in the boot firmware that obviously does not happen in all
>>>>> cases (like this one).
>>>>>
>>>>
>>>> Ah, interesting, I was not aware that the firmware was supposed to do
>>>> the pin configuration. In this case I think your patch can be merged
>>>> as it is Mika, mine doesn't make sense anymore.
>>>
>>> Unfortunately because of bugs we can't rely that the firmware (BIOS)
>>> gets those always right :-(
>>>
>>>> This particular case is special since we did not performed the tests
>>>> on a full system that has the component integrated. We instead used
>>>> and I2C to USB bridge to which we connected the component and we
>>>> loaded the ACPI table dynamically.
>>>
>>> Regardless of how did the device appear this always works:
>>>
>>>    1) request the GPIO (with GPIOD_IN)
>>>    2) convert it to IRQ using gpiod_to_irq()
>>>
>>> Since we cannot be sure that the firmware has configured the pin
>>> properly, rather than adding automatic IRQ <-> GPIO translation for ACPI
>>> GpioInt I think we are better off if drivers explictly request their
>>> GPIOs and configure them as needed.
>>
>>
>> Yes, this is what we are doing now and it works well.
>>
>> But I am not yet ready to give-up on the automatic IRQ <-> GPIO translation :)
>>
>> What if we can do the pin configuration in gpiolib right after the
>> GPIO controller is initialized. I am thinking of searching the ACPI
>> namespace and looking for resources that have GpioInt entries for that
>> particular GPIO controller and use them to set the pins to input (and
>> ideally also set the other properties like pullups, pulldowns, etc.)
>
> I would rather say that since the gpiolib and irqchip APIs are
> supposed to be orthogonal, the irqchip request/unmask or
> whatever functions are enabling IRQs should just go and poke
> the necessary bits in the GPIO registers to turn the pin into
> an input.

Yes, especially considering that for some controllers they actually are 
orthogonal. I.e. different bits need to be set depending on whether the pin 
should be used as a GPIO input or as a interrupt pin.

It may make sense to offer some helper functions or flags for those chips 
were the pin needs to be configured as input so the core can take care of it 
and not every driver needs to do it on its own.

- Lars
