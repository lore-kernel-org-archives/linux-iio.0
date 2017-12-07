Return-Path: <SRS0=pnoz=DD=free-electrons.com=quentin.schulz@kernel.org>
Subject: Re: [PATCH 3/8] mfd: axp20x: probe axp20x_adc driver for AXP813
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>,
 Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-iio@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
 <20171205080855.arr7vlgnxoxmyedd@flea.lan>
 <2021a653-d01e-f46f-2438-0760f579e0dc@free-electrons.com>
 <CAGb2v67nD+WAEEyridP1K=k_KgBprWmbNNL7FPdZWv9ZYdrjJg@mail.gmail.com>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <41fcadb9-4fa9-65e8-5ef3-5844bcba1b1d@free-electrons.com>
Date: Thu, 7 Dec 2017 10:03:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAGb2v67nD+WAEEyridP1K=k_KgBprWmbNNL7FPdZWv9ZYdrjJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi Chen-Yu,

On 07/12/2017 09:54, Chen-Yu Tsai wrote:
> On Thu, Dec 7, 2017 at 4:51 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> Hi Maxime,
>>
>> On 05/12/2017 09:08, Maxime Ripard wrote:
>>> On Mon, Dec 04, 2017 at 03:12:49PM +0100, Quentin Schulz wrote:
>>>> This makes the axp20x_adc driver probe with platform device id
>>>> "axp813-adc".
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>> ---
>>>>  drivers/mfd/axp20x.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>>>> index 2468b43..42e54d1 100644
>>>> --- a/drivers/mfd/axp20x.c
>>>> +++ b/drivers/mfd/axp20x.c
>>>> @@ -878,7 +878,9 @@ static struct mfd_cell axp813_cells[] = {
>>>>              .resources              = axp803_pek_resources,
>>>>      }, {
>>>>              .name                   = "axp20x-regulator",
>>>> -    }
>>>> +    }, {
>>>> +            .name                   = "axp813-adc",
>>>> +    },
>>>
>>> Any particular reason you're not adding it to the DT?
>>>
>>
>> No, no particular reason. It's just the way it is currently for AXP209
>> and AXP22x so did the same for AXP813.
>>
>> I'll add DT "support" in next version for all AXPs supported by this
>> driver. Or is it worthy of a small separate patch series?
> 
> IIRC there's no DT support because there's no need to reference
> it in the device tree.
> 

No current need but that does not mean there won't be a need later for
drivers to map IIO channels from the ADC driver (i.e. some components
wired to GPIOs of the PMIC for example).

Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
