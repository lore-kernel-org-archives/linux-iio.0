Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <CAAfyv354=J+iDgLcu9KRZSScGSzYrRsCMmUEc_tW84GfduSebw@mail.gmail.com>
            <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw@mail.gmail.com>
            <1437593628.2381718.330572297.2F6F1C50@webmail.messagingengine.com>
            <1437594062.2382998.330577153.4CE28783@webmail.messagingengine.com>
            <CB1BA4C2-51EC-493D-A290-E506DE974605@goldelico.com>
            <1437657169.3419965.331206849.51D66A2E@webmail.messagingengine.com>
In-Reply-To: <1437657169.3419965.331206849.51D66A2E@webmail.messagingengine.com>
From: jic23@jic23.retrosnub.co.uk
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan
  <ldewangan@nvidia.com>, Belisko Marek <marek.belisko@gmail.com>,
  Jonathan Cameron <jic23@kernel.org>, Axel Lin <axel.lin@ingics.com>,
  linux-iio@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Samuel
  Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>,
  "linux-omap" <linux-omap@vger.kernel.org>, balajitk@ti.com,
  oleksandr.kozaruk@ti.com, Michael Mrozek <EvilDragon@openpandora.org>,
  Grazvydas Ignotas <notaz@openpandora.org>
Subject: Re: gpadc iio support for tlw6037/palmas [was: twl6030-gpadc
  support for twl6037]
Date: Thu, 23 Jul 2015 15:12:00 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-Id: <20150723141200.2801F431C5@saturn.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

Graeme Gregory writes: 

>  
> 
> On Thu, 23 Jul 2015, at 01:58 PM, Dr. H. Nikolaus Schaller wrote:
>> Hi Graeme, 
>> 
>> Am 22.07.2015 um 21:41 schrieb Graeme Gregory <gg@slimlogic.co.uk>: 
>> 
>> > 
>> > 
>> > On Wed, 22 Jul 2015, at 08:33 PM, Graeme Gregory wrote:
>> >> 
>> >> 
>> >> On Wed, 22 Jul 2015, at 08:28 PM, Belisko Marek wrote:
>> >>> Adding also twl6030-gpadc driver authors to loop
>> >>> 
>> >>> On Mon, Jul 20, 2015 at 8:57 AM, Belisko Marek <marek.belisko@gmail.com>
>> >>> wrote:
>> >>>> Hi all,
>> >>>> 
>> >>>> I'm trying to figure out what is relation between palmas mfd driver
>> >>>> and twl-core for twl603x devices.
>> >>>> twl-core driver seems to be older than palmas driver but seems both
>> >>>> export same functionality (except that palmas have defined structs for
>> >>>> gpadc but functionality is missing). My main focus is to add support
>> >>>> for twl6037 to gpadc iio driver in iio/adc/twl6030-gpadc which is
>> >>>> using twl-core for twl6030 and twl6032. Adding twl6037 support should
>> >>>> be straightforward but dts file used in omap5-uevm using palmas driver
>> >>>> and not twl6030. So it's completely confusing to me how to proceed or
>> >>>> which direction is correct. Seems I'm missing some parts of puzzle ;)
>> >>>> Thanks for any hints.
>> >>>> 
>> >> Phoenix is twl6030, twl6032
>> >> 
>> >> Palmas is twl6035, twl6037 and maybe others.
>> >> 
>> >> Phoenix and Palmas are two totally different chips but marketing gave
>> >> them numbers near each other for unknown reasons.
>> >> 
>> > Also this might be useful.
>> > 
>> > https://github.com/slimlogic/linux/commit/312a6a1c8013fd056431c31567b43d8eef40f333
>> > 
>> > A pre IIO palmas ADC driver which I never got around to upstreaming
>> > because TIpocalypse left me with no access to a palmas chip. 
>> 
>> We managed to integrate your code into our 4.1 kernel (needed minor fixes
>> mainly for
>> irq initialization) and it appears to work on the omap5432evm. Especially
>> channels
>> in6_channel and in7_channel in
>> /sys/bus/platform/drivers/palmas-gpadc/48070000.i2c:palmas@48:gpadc
>> show reasonable (and slightly fluctuating) volt values. 
>> 
>> Now the question is how to proceed. We could either write some
>> drivers/iio/adc/palmas-gpadc.c
>> wrapper around your driver, or could try this one which appears to be a
>> pure iio implementation: 
>>
> Pure IIO is better, one of the reasons my driver never got sent upstream
> is I knew IIO was due "real soon now" but I lost access to the chip and
> documentation before IIO landed in the kernel.
>  
>> https://android.googlesource.com/kernel/tegra.git/+/28f245bb8f590f61bb244f1b4d03f4b4919d32ea/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
>> https://android.googlesource.com/kernel/tegra/+/aaabb2e045f31e5a970109ffdaae900dd403d17e/drivers/staging/iio/adc/palmas_gpadc.c 
>> 
>> Do you think the latter has a chance to be accepted upstream? 
>> 
> I see nothing with a quick scan that looks controversial.
There are a few odd corners (based on a 20 second look). What
is the dual channel stuff about? 

Best bet might be to do a quick cleanup pass then post it as an
RFC to linux-iio.  Then we can take a proper look at it. 

> 
>> The reason we ask is that we neither want to write new code if something
>> exists nor base
>> our work on something that can not be upstreamed. 
>>
> I would base your product on the nvidia driver and if they are not
> planning to upstream then submit yourself.
Makes sense.
>  
> Graeme 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
