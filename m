Return-Path: <robherring2@gmail.com>
MIME-Version: 1.0
In-Reply-To: <557D6184.90105@kernel.org>
References: <1432730872-14325-1-git-send-email-stefan@agner.ch>
 <1432730872-14325-2-git-send-email-stefan@agner.ch> <CAL_JsqK0YxgJ-k8kSs6XQj9n3FSg4QBd-GdFEfcafH7Cm4NreQ@mail.gmail.com>
 <14d469dedae9de1ce519fe90401e526e@agner.ch> <557D6184.90105@kernel.org>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 23 Jun 2015 09:27:36 -0500
Message-ID: <CAL_JsqLX88SFHPrAwaPMijW0_3mOge43FZ4Cw08WwdNVjZJ-WA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio: adc: vf610: implement configurable conversion modes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>, Shawn Guo <shawn.guo@linaro.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	Fugang Duan <B38611@freescale.com>, Sanchayan Maity <maitysanchayan@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jun 14, 2015 at 6:12 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 08/06/15 21:07, Stefan Agner wrote:
>> On 2015-06-08 19:49, Rob Herring wrote:
>>> On Wed, May 27, 2015 at 7:47 AM, Stefan Agner <stefan@agner.ch> wrote:
>>>> Support configurable conversion mode through sysfs. So far, the
>>>> mode used was low-power, which is enabled by default now. Beside
>>>> that, the modes normal and high-speed are selectable as well.
>>>>
>>>> Use the new device tree property which specifies the maximum ADC
>>>> conversion clock frequencies. Depending on the mode used, the
>>>> available resulting conversion frequency are calculated
>>>> dynamically.
>>>>
>>>> Acked-by: Fugang Duan <B38611@freescale.com>
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-bus-iio-vf610      |   7 +
>>>>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |   9 ++
>>>>  drivers/iio/adc/vf610_adc.c                        | 146 +++++++++++++++------
>>>>  3 files changed, 120 insertions(+), 42 deletions(-)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-vf610
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-vf610 b/Documentation/ABI/testing/sysfs-bus-iio-vf610
>>>> new file mode 100644
>>>> index 0000000..ecbc1f4
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-vf610
>>>> @@ -0,0 +1,7 @@
>>>> +What:          /sys/bus/iio/devices/iio:deviceX/conversion_mode
>>>> +KernelVersion: 4.2
>>>> +Contact:       linux-iio@vger.kernel.org
>>>> +Description:
>>>> +               Specifies the hardware conversion mode used. The three
>>>> +               available modes are "normal", "high-speed" and "low-power",
>>>> +               where the last is the default mode.
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>>>> index 1a4a43d..3eb40e2 100644
>>>> --- a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>>>> @@ -11,6 +11,13 @@ Required properties:
>>>>  - clock-names: Must contain "adc", matching entry in the clocks property.
>>>>  - vref-supply: The regulator supply ADC reference voltage.
>>>>
>>>> +Recommended properties:
>>>> +- fsl,adck-max-frequency: Maximum frequencies according to datasheets operating
>>>> +  requirements. Three values are required, depending on conversion mode:
>>>> +  - Frequency in normal mode (ADLPC=0, ADHSC=0)
>>>> +  - Frequency in high-speed mode (ADLPC=0, ADHSC=1)
>>>> +  - Frequency in low-power mode (ADLPC=1, ADHSC=0)
>>>
>>> Why is this "adck" rather than "adc"?
>>
>> That is the name of the clock according to the reference manual and data
>> sheet.
>>
>>> How is this related to today's patch adding min-sample-time?
>>
>> It is related in that this clock is the base to calculate the sampling
>> time, but otherwise not really related. Afaik, not respecting the
>> maximum clock frequency is probably more a issue for the SAR part of the
>> ADC.
> Rob, are you happy with Stefan's responses?

Yes, it is fine.

Rob
