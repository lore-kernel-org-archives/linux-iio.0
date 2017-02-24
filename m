Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:41310 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdBXJq5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Feb 2017 04:46:57 -0500
Subject: Re: [PATCH v3 4/4] iio: accel: adxl345: Add SPI support
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
References: <cover.1487757223.git.eraretuya@gmail.com>
 <515297e48abd139993cab56dbf980711400d6534.1487757223.git.eraretuya@gmail.com>
 <CAHp75VdmB1YqY4YyntbvHUaK_9yjY8wFeX6i9hmMDaScajKNOw@mail.gmail.com>
 <cb64adc9-f468-11f8-4a8a-fd3f5779fee0@metafoo.de>
 <CAHp75VfbfRB_7Y2CRrJRYHqnJNMYD1hKScGr0HLSpFSGgJtymA@mail.gmail.com>
 <20170224091231.GC5012@Socrates-UM>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <13912e47-1e3e-e68e-1e91-4a174f33fda5@metafoo.de>
Date: Fri, 24 Feb 2017 10:22:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170224091231.GC5012@Socrates-UM>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/24/2017 10:12 AM, Eva Rachel Retuya wrote:
> On Thu, Feb 23, 2017 at 06:58:12PM +0200, Andy Shevchenko wrote:
>> On Thu, Feb 23, 2017 at 6:47 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> On 02/23/2017 05:43 PM, Andy Shevchenko wrote:
>>>> On Wed, Feb 22, 2017 at 12:23 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
>>>>> Add SPI driver that initializes SPI regmap for the adxl345 core driver.
>>>>> The driver supports the same functionality as I2C namely the x, y, z and
>>>>> scale readings.
>>
>>>>>  config ADXL345_I2C
>>>>>         tristate
>>>>>         select REGMAP_I2C
>>>>>
>>>>> +config ADXL345_SPI
>>>>> +       tristate
>>>>> +       select REGMAP_SPI
>>>>
>>>> Hmm...
>>>> I saw another pattern
>>>>
>>>> Library / core part is non-visible to user, while
>>>> SPI and I2C parts are selectable by user.
>>>>
>>>> Why do you use inverted pattern? What did I miss?
>>>
>>> The first version of the patch used the other pattern SPI/I2C visible.
>>> Jonathan suggested this other pattern. I prefer the explicit SPI/I2C visible
>>> pattern, but in the end it doesn't really matter as long as both work.
>>
>> Yes, but this pattern makes extra footprint of the kernel and
>> basically dead code when I would like, for example, to have SPI bus
>> enabled, I2C module available, but SPI module not compiled.
>>
>> Other one is when I want to have one compiled in, one as a module by
>> whatever reason.
>>
>> At the end I have no strong opinion, though rationale for the opposite is above.
>>
> 
> Hello Lars and Andy,
> 
> I'll revert to the explicit SPI/I2C pattern in order to give more
> freedom in configuring as per the scenarios previously stated.

Please check with Jonathan before you do, in the end he'll have to apply the
patch.

