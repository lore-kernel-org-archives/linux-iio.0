Return-Path: <vilhelm.gray@gmail.com>
Date: Mon, 13 Jun 2016 08:39:43 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: stx104: Add GPIO support for the Apex Embedded
 Systems STX104
Message-ID: <20160613123943.GB18880@sophia>
References: <1464975762-24052-1-git-send-email-vilhelm.gray@gmail.com>
 <CACRpkda+5LmMSFia=R8P=xqd8Hh6h-gvTqjaxqr0OqJH5pkFuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACRpkda+5LmMSFia=R8P=xqd8Hh6h-gvTqjaxqr0OqJH5pkFuw@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 13, 2016 at 02:15:43PM +0200, Linus Walleij wrote:
>On Fri, Jun 3, 2016 at 7:42 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> The Apex Embedded Systems STX104 device features eight lines of digital
>> I/O (four digital inputs and four digital outputs). This patch adds GPIO
>> support for these eight lines of digital I/O via GPIOLIB.
>>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> ---
>> Changes in v2:
>>   - Change GPIOLIB Kconfig selection to a dependency for the STX104 Kconfig
>>     option; STX104 should only be available to systems configured for GPIOLIB
>
>Are you sure? I just changed the GPIOLIB Kconfig so any arch/thing can
>select GPIOLIB, if this driver needs it, it can just select it now.

I did find it strange to get a Kconfig dependency warning message from
the kbuild bot for the m68k arch build. I shall revert back to select
GPIOLIB, since that was my original intention.

>> +static int stx104_gpio_get_direction(struct gpio_chip *chip,
>> +       unsigned int offset)
>> +{
>> +       if (offset < 4)
>> +               return 1;
>> +
>> +       return 0;
>> +}
>
>If this looks so...
>
>> +static int stx104_gpio_direction_input(struct gpio_chip *chip,
>> +       unsigned int offset)
>> +{
>> +       return 0;
>> +}
>> +
>> +static int stx104_gpio_direction_output(struct gpio_chip *chip,
>> +       unsigned int offset, int value)
>> +{
>> +       return 0;
>> +}
>
>These should return -EINVAL or -EIO or something if you try to
>set the direction to something the line does not support.

Thanks for the find, I'll fix this up and resubmit.

William Breathitt Gray
