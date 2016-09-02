Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <e069a51d-bf8d-ae70-6061-d3118491cd1d@metafoo.de>
References: <20160902132717.5839-1-cmo@melexis.com> <e069a51d-bf8d-ae70-6061-d3118491cd1d@metafoo.de>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 2 Sep 2016 15:48:55 +0200
Message-ID: <CAKv63uui0kh1wauc2LcpKmBs8U8XMAbg7=XPHA8dwzhnVxxQHA@mail.gmail.com>
Subject: Re: [PATCH] iio: fetch and enable regulators unconditionally
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux Iio <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>,
	Matt Ranostay <mranostay@gmail.com>, Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	Markus Pargmann <mpa@pengutronix.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 2 September 2016 at 15:40, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Hi,
>
> Thanks for the patch.
>
> On 09/02/2016 03:27 PM, Crt Mori wrote:
>> This patch is inspired by a comment of Jonathan Cameron on patch of
>> Linus Walleij commit aeb55fff3891834e07a3144159a7298a19696af8 ("iio: st_sensors: fetch and enable regulators unconditionally").
>>
>> The explanation for this change is same as in that patch:
>> "Supplies are *not* optional (optional means that the supply is
>> optional in the electrical sense, not the software sense) so we need to
>> get the and enable them at all times.
>
> Some supplies are optional. I.e. the part is able to operate (potentially
> with limited functionality) even if the optional external supply has not
> been connected to the pin.
>
> E.g. many converters have a built-in voltage reference but are able to
> optionally accept an external reference. The driver needs to know if the
> external reference is not connected or not to be able to allow or disallow
> applications to switch the part into external reference mode. This is the
> case for the ad7266 and ad5761 drivers and using regulator_get_optional() is
> correct here.
>
> Same seems to be true for the ads8688 and the fsl-imx-gcq, judging by how
> their code is structured.
>
> - Lars
OK, so the voltage reference part can have optional regulator, but if
it is supply voltage then it cannot.

What about the IS_ERR_OR_NULL() check? Is that suitable for the
optional regulators as well?
