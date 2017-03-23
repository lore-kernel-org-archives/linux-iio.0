Return-Path: <SRS0=z9zl=3A=google.com=raltherr@kernel.org>
MIME-Version: 1.0
In-Reply-To: <aee01198-3af6-6218-7f3e-9558adcdf526@free-electrons.com>
References: <20170321204828.31303-1-raltherr@google.com> <20170321204828.31303-2-raltherr@google.com>
 <5f245e55-4d4a-b744-3351-e8215432c315@free-electrons.com> <CAPLgG=kVsNake71fFLc2NsoMtrtG0_6Fb6XHep3dQKVuRgOmbA@mail.gmail.com>
 <aee01198-3af6-6218-7f3e-9558adcdf526@free-electrons.com>
From: Rick Altherr <raltherr@google.com>
Date: Thu, 23 Mar 2017 09:57:17 -0700
Message-ID: <CAPLgG=mbBJd8+2vdGUO1RVnTJkgCcy4SCJG_YMmXKnq+zAW4EA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: Aspeed AST2400/AST2500 ADC
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	William Breathitt Gray <vilhelm.gray@gmail.com>, Andreas Klinger <ak@it-klinger.de>, Rob Herring <robh@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marek.vasut+renesas@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Crestez Dan Leonard <leonard.crestez@intel.com>, Akinobu Mita <akinobu.mita@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Maxime Ripard <maxime.ripard@free-electrons.com>,
	Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 23, 2017 at 12:52 AM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Hi,
>
> On 22/03/2017 21:46, Rick Altherr wrote:
>> On Wed, Mar 22, 2017 at 12:21 AM, Quentin Schulz
>> <quentin.schulz@free-electrons.com> wrote:
>>> Hi,
>>>
>>> On 21/03/2017 21:48, Rick Altherr wrote:
>>>> Aspeed AST2400/AST2500 BMC SoCs include a 16 channel, 10-bit ADC. Low
>>>> and high threshold interrupts are supported by the hardware but are not
>>>> currently implemented.
>>>>
>>>> Signed-off-by: Rick Altherr <raltherr@google.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Rewritten as an IIO device
>>>> - Renamed register macros to describe the register's purpose
>>>> - Replaced awkward reading of 16-bit data registers with readw()
>>>> - Added Kconfig dependency on COMPILE_TEST
>>>>
> [...]
>>>> +#define ASPEED_ADC_CHAN(_idx, _addr) {                               \
>>>> +     .type = IIO_VOLTAGE,                                    \
>>>> +     .indexed = 1,                                           \
>>>> +     .channel = (_idx),                                      \
>>>> +     .address = (_addr),                                     \
>>>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
>>>> +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |  \
>>>> +                             BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
>>>> +}
>>>> +
>>>> +static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
>>>> +     ASPEED_ADC_CHAN(0, 0x10),
>>>> +     ASPEED_ADC_CHAN(1, 0x12),
>>>> +     ASPEED_ADC_CHAN(2, 0x14),
>>>> +     ASPEED_ADC_CHAN(3, 0x16),
>>>> +     ASPEED_ADC_CHAN(4, 0x18),
>>>> +     ASPEED_ADC_CHAN(5, 0x1A),
>>>> +     ASPEED_ADC_CHAN(6, 0x1C),
>>>> +     ASPEED_ADC_CHAN(7, 0x1E),
>>>> +     ASPEED_ADC_CHAN(8, 0x20),
>>>> +     ASPEED_ADC_CHAN(9, 0x22),
>>>> +     ASPEED_ADC_CHAN(10, 0x24),
>>>> +     ASPEED_ADC_CHAN(11, 0x26),
>>>> +     ASPEED_ADC_CHAN(12, 0x28),
>>>> +     ASPEED_ADC_CHAN(13, 0x2A),
>>>> +     ASPEED_ADC_CHAN(14, 0x2C),
>>>> +     ASPEED_ADC_CHAN(15, 0x2E),
>>>
>>> It would make sense to name the registers (the _addr parameter of your
>>> macro) so it's easier to understand what it refers to.
>>>
>>
>> I agree with Joel on this.  There isn't really a better name than
>> ADC_CHAN_0_DATA.  I'll change the macro parameter to _data_reg_addr to
>> make that clearer.
>>
>
> Is it the name in the datasheet?
>

No, the datasheet has such helpful register names as ADC10 where 0x10
is the offset in the register map.

> [...]
>>>> +     indio_dev->name = dev_name(&pdev->dev);
>>>
>>> This isn't good practice (cf.: https://lkml.org/lkml/2017/1/28/145 end
>>> of the mail in the probe function). Better name it aspeed-adc or even
>>> better to have a different name per compatible: ast2400-adc or ast2500-adc.
>>
>> Ack.  Will use aspeed-adc to avoid parsing the compatible match and
>> stripping the 'aspeed,' prefix.
>>
>
> You don't need to parse the compatible match. You could use the data
> void pointer in your struct of_device_id
> (http://lxr.free-electrons.com/source/include/linux/mod_devicetable.h#L234)
> like it's done here: https://lkml.org/lkml/2017/3/21/675
> (sun4i_gpadc_of_id).
>

I figured that out a bit later and did so in v3 I sent out last night.

> Note: please reply to all :)

Whoops.  Looks like I did that for all the replies I did yesterday.

>
> Quentin
>
> --
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
