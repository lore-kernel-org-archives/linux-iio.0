Return-Path: <SRS0=111V=GH=gmail.com=vilhelm.gray@kernel.org>
Date: Sat, 17 Mar 2018 15:15:55 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 1/8] iio: stx104: Implement get_multiple callback
Message-ID: <20180317191555.GA14672@sophia>
References: <cover.1521301345.git.vilhelm.gray@gmail.com>
 <14a09900bf4642495ebe4072b9eb02769dbc4c5e.1521301345.git.vilhelm.gray@gmail.com>
 <CAHp75Vci2sMWPC2Sij5WzNtSi_2b3f1PC5qn3-hiSf8xrCpcBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAHp75Vci2sMWPC2Sij5WzNtSi_2b3f1PC5qn3-hiSf8xrCpcBQ@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Mar 17, 2018 at 08:51:07PM +0200, Andy Shevchenko wrote:
>On Sat, Mar 17, 2018 at 5:49 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>> The Apex Embedded Systems STX104 series of devices provides 4 TTL
>> compatible lines of inputs accessed via a single 4-bit port. Since four
>> input lines are acquired on a single port input read, the STX104 GPIO
>> driver may improve multiple input reads by utilizing a get_multiple
>> callback. This patch implements the stx104_gpio_get_multiple function
>> which serves as the respective get_multiple callback.
>
>> +static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
>> +       unsigned long *bits)
>> +{
>> +       struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
>> +
>
>> +       *bits = inb(stx104gpio->base);
>
>I think on LE and BE if will give you different results.

That may be true for a memcpy operation, but in this case I'm relying on
the standard C evaluation rules. I expect we should be fine with the
returned byte assigned to an unsigned long, since it'll be evaluated by
its value rather than memory representation.

William Breathitt Gray

>
>> +
>> +       return 0;
>> +}
>
>
>
>-- 
>With Best Regards,
>Andy Shevchenko
