Return-Path: <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: twl6030-gpadc support for twl6037
From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1437594062.2382998.330577153.4CE28783@webmail.messagingengine.com>
Date: Wed, 22 Jul 2015 22:12:23 +0200
Cc: Belisko Marek <marek.belisko@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Axel Lin <axel.lin@ingics.com>,
 linux-iio@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>,
 Samuel Ortiz <sameo@linux.intel.com>,
 Lee Jones <lee.jones@linaro.org>,
 linux-omap@vger.kernel.org,
 balajitk@ti.com,
 oleksandr.kozaruk@ti.com
Message-Id: <DEFD67FD-1E05-4968-989B-73D9277C178A@goldelico.com>
References: <CAAfyv354=J+iDgLcu9KRZSScGSzYrRsCMmUEc_tW84GfduSebw@mail.gmail.com> <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw@mail.gmail.com> <1437593628.2381718.330572297.2F6F1C50@webmail.messagingengine.com> <1437594062.2382998.330577153.4CE28783@webmail.messagingengine.com>
To: Graeme Gregory <gg@slimlogic.co.uk>
List-ID: <linux-iio@vger.kernel.org>


Am 22.07.2015 um 21:41 schrieb Graeme Gregory <gg@slimlogic.co.uk>:

>=20
>=20
> On Wed, 22 Jul 2015, at 08:33 PM, Graeme Gregory wrote:
>>=20
>>=20
>> On Wed, 22 Jul 2015, at 08:28 PM, Belisko Marek wrote:
>>> Adding also twl6030-gpadc driver authors to loop
>>>=20
>>> On Mon, Jul 20, 2015 at 8:57 AM, Belisko Marek =
<marek.belisko@gmail.com>
>>> wrote:
>>>> Hi all,
>>>>=20
>>>> I'm trying to figure out what is relation between palmas mfd driver
>>>> and twl-core for twl603x devices.
>>>> twl-core driver seems to be older than palmas driver but seems both
>>>> export same functionality (except that palmas have defined structs =
for
>>>> gpadc but functionality is missing). My main focus is to add =
support
>>>> for twl6037 to gpadc iio driver in iio/adc/twl6030-gpadc which is
>>>> using twl-core for twl6030 and twl6032. Adding twl6037 support =
should
>>>> be straightforward but dts file used in omap5-uevm using palmas =
driver
>>>> and not twl6030. So it's completely confusing to me how to proceed =
or
>>>> which direction is correct. Seems I'm missing some parts of puzzle =
;)
>>>> Thanks for any hints.
>>>>=20
>> Phoenix is twl6030, twl6032
>>=20
>> Palmas is twl6035, twl6037 and maybe others.
>>=20
>> Phoenix and Palmas are two totally different chips but marketing gave
>> them numbers near each other for unknown reasons.
>>=20
> Also this might be useful.
>=20
> =
https://github.com/slimlogic/linux/commit/312a6a1c8013fd056431c31567b43d8e=
ef40f333

That is basically what we are looking for.

We will give it a try asap and let you know results.

>=20
> A pre IIO palmas ADC driver which I never got around to upstreaming

Well, unless it already exists somewhere, it should be converterd to iio =
by updating the
driver structure to follow iio/adc/twl6030-gpadc.

> because TIpocalypse left me with no access to a palmas chip.

The OMAP5432EVM by SVtronics [1] comes with a twl6037 (and it is
supported by mainline device tree omap5-uevm.dts). And we hope
that the pyra-handheld.com hardware is finished soon. For hardware
bring-up it would be good to already have the gpadc available - so
we have some hen-and-egg situation here.

BR and thanks,
Nikolaus

[1]: http://www.svtronics.com/5432
