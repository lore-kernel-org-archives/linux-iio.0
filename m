Return-Path: <gregor.boirie@parrot.com>
Message-ID: <57D7B0F1.6030607@parrot.com>
Date: Tue, 13 Sep 2016 09:55:29 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Akinobu
 Mita <akinobu.mita@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Vlad
 Dogaru <ddvlad@gmail.com>, Ludovic Tancerel
	<ludovic.tancerel@maplehightech.com>, Marek Vasut <marex@denx.de>, Crestez
 Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v4 1/1] iio:pressure: initial zpa2326 barometer support
References: <cover.1473432897.git.gregor.boirie@parrot.com> <68c225245eb4f4972f5acaa56bdbf9d25971f0f7.1473432897.git.gregor.boirie@parrot.com> <d6122349-5e8c-6708-b5af-a38f9e8bb898@kernel.org>
In-Reply-To: <d6122349-5e8c-6708-b5af-a38f9e8bb898@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 09/10/2016 05:37 PM, Jonathan Cameron wrote:
> On 09/09/16 16:01, Gregor Boirie wrote:
>> Introduce driver for Murata ZPA2326 pressure and temperature sensor:
>> http://www.murata.com/en-us/products/productdetail?partno=ZPA2326-0311A-R
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> This looks pretty good to me now.  A few minor bits and bobs inline.
>
> I almost took it as is, but would like to have it sit on the list
> in it's current form for a few more days anyway so might as well get
> these few corners tidied up!
[...]
>
> +/*
> + * Debugfs stuff
> + *
> + * We want to prevent debugfs hooks from altering configuration while chip
> + * sampling is ongoing to preserve data consistency. Moreover, a few registers,
> + * when read, change hardware state, e.g. interrupt acknowlege on read. This is
> + * why debugfs read and write hooks acquire exclusive access to register space.
> + *
> + * Also note this is mostly unusable with power management enabled systems since
> + * registers content is lost during power off -> on transitions.
> + */
> It would be nice perhaps to tighten up the range of addresses that
> we are protecting.  Thus allow reading of any addresses that are not
> 'fragile'.  Only supported limited debug access is hardly a big
> issue however ;)
Quite frankly, I wonder if this debugfs stuff should not be thrown away 
given that
regmap already provides a way to access registers over debugfs (with 
very limited
protection...).
What do you think ?

[...]

Regards,
Grégor.
