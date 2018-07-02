Return-Path: <SRS0=ezTa=JS=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807020810580.31530@fox.voss.local>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75VfR8JZaDbvzudW5mc4=nOoYM2EeXPMhUHCw1ovnPmGV5A@mail.gmail.com> <alpine.DEB.2.20.1807020810580.31530@fox.voss.local>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 2 Jul 2018 19:14:01 +0300
Message-ID: <CAHp75Vdr=e-8g2bF0oF+xSY_UL8wD8k2Azkhvg2_a7-bpOFn-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] IIO: st_sensors_i2c: improve device enumeration
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Xiongfeng Wang <xiongfeng.wang@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 2, 2018 at 9:41 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Fri, 29 Jun 2018, Andy Shevchenko wrote:
>
>> I'm not sure I understand how ->probe_new() is supposed to work
>> against i2c_id_table, but I don't care for legacy platform data
>> anyway.
>>
>> What I would like to point to is device_get_match_data() API which
>> should simplify / unify the case how you get driver data.
>
>
> This driver doesn't need any driver data/ platform_data beyond the
> i2c_id_table name (which has already been matched when probe()/ probe_new()
> is called), so strictly neither of_match_table nor apci_match_table would be
> necessary, because i2c DT/ ACPI enumeration also matches against i2c_table
> names.

Looking at the code I see still calls to acpi_match_data() and of_match_data().
Instead nowadays better to use device_get_match_data().

i2c_id_table should be removed from the module device table at least
(though you may continue to use it internally in the driver).

That's my understanding how it should be done.

-- 
With Best Regards,
Andy Shevchenko
