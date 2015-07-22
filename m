Return-Path: <gg@slimlogic.co.uk>
Message-Id: <1437594062.2382998.330577153.4CE28783@webmail.messagingengine.com>
From: Graeme Gregory <gg@slimlogic.co.uk>
To: Belisko Marek <marek.belisko@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Axel Lin <axel.lin@ingics.com>,
 linux-iio@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org,
 "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, balajitk@ti.com,
 oleksandr.kozaruk@ti.com
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: twl6030-gpadc support for twl6037
Date: Wed, 22 Jul 2015 20:41:02 +0100
In-Reply-To: <1437593628.2381718.330572297.2F6F1C50@webmail.messagingengine.com>
References: <CAAfyv354=J+iDgLcu9KRZSScGSzYrRsCMmUEc_tW84GfduSebw@mail.gmail.com>
 <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw@mail.gmail.com>
 <1437593628.2381718.330572297.2F6F1C50@webmail.messagingengine.com>
List-ID: <linux-iio@vger.kernel.org>



On Wed, 22 Jul 2015, at 08:33 PM, Graeme Gregory wrote:
> 
> 
> On Wed, 22 Jul 2015, at 08:28 PM, Belisko Marek wrote:
> > Adding also twl6030-gpadc driver authors to loop
> > 
> > On Mon, Jul 20, 2015 at 8:57 AM, Belisko Marek <marek.belisko@gmail.com>
> > wrote:
> > > Hi all,
> > >
> > > I'm trying to figure out what is relation between palmas mfd driver
> > > and twl-core for twl603x devices.
> > > twl-core driver seems to be older than palmas driver but seems both
> > > export same functionality (except that palmas have defined structs for
> > > gpadc but functionality is missing). My main focus is to add support
> > > for twl6037 to gpadc iio driver in iio/adc/twl6030-gpadc which is
> > > using twl-core for twl6030 and twl6032. Adding twl6037 support should
> > > be straightforward but dts file used in omap5-uevm using palmas driver
> > > and not twl6030. So it's completely confusing to me how to proceed or
> > > which direction is correct. Seems I'm missing some parts of puzzle ;)
> > > Thanks for any hints.
> > >
> Phoenix is twl6030, twl6032
> 
> Palmas is twl6035, twl6037 and maybe others.
> 
> Phoenix and Palmas are two totally different chips but marketing gave
> them numbers near each other for unknown reasons.
> 
Also this might be useful.

https://github.com/slimlogic/linux/commit/312a6a1c8013fd056431c31567b43d8eef40f333

A pre IIO palmas ADC driver which I never got around to upstreaming
because TIpocalypse left me with no access to a palmas chip.

Graeme
