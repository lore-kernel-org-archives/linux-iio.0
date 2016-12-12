Return-Path: <SRS0=CZSA=X3=goldelico.com=hns@kernel.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 3/8] drivers:input:tsc2007: add iio interface to read external ADC input and temperature
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <AC7B3C1C-C05B-45B5-8426-5225F151DC26@goldelico.com>
Date: Mon, 12 Dec 2016 22:21:25 +0100
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Sebastian Reichel <sre@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Michael Welling <mwelling@ieee.org>,
 =?windows-1252?Q?Mika_Penttil=E4?= <mika.penttila@nextfour.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Igor Grinberg <grinberg@compulab.co.il>,
 "Andrew F. Davis" <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Alexander Stein <alexander.stein@systec-electronic.com>,
 Eric Engestrom <eric@engestrom.ch>,
 Hans de Goede <hdegoede@redhat.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Denis Carikli <denis@eukrea.com>,
 Petr Cvek <petr.cvek@tul.cz>,
 linux-input@vger.kernel.org,
 devicetree <devicetree@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 linux-iio@vger.kernel.org,
 kernel@pyra-handheld.com,
 "Yann E. MORIN" <yann.morin.1998@free.fr>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Message-Id: <E4E31180-A686-4631-9713-519987C55F06@goldelico.com>
References: <cover.1479823354.git.hns@goldelico.com> <cover.1479823354.git.hns@goldelico.com> <99f236df48b03b3188e12f94a20097f8440db7a5.1479823354.git.hns@goldelico.com> <E42B1EF7-222E-46D6-878B-30C789CFBBC5@jic23.retrosnub.co.uk> <811B6F6A-2E3D-45B4-A984-74ABE0E37192@goldelico.com> <8d3fc752-e69c-f568-4f71-4f1768a3fffe@kernel.org> <AC7B3C1C-C05B-45B5-8426-5225F151DC26@goldelico.com>
To: Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,


> Am 27.11.2016 um 16:47 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Jonathan,
>=20
>> Am 27.11.2016 um 12:02 schrieb Jonathan Cameron <jic23@kernel.org>:
>>=20
>> On 24/11/16 18:05, H. Nikolaus Schaller wrote:
>>>=20
>>>> Am 24.11.2016 um 18:38 schrieb Jonathan Cameron =
<jic23@jic23.retrosnub.co.uk>:
>>>>=20
>>>>=20
>>>>=20
>>>> On 22 November 2016 14:02:30 GMT+00:00, "H. Nikolaus Schaller" =
<hns@goldelico.com> wrote:

>=20
>> - hence cc'd Yann and the Kbuild list
>> to see if they can offer some advices.

no response / advice so far.

>=20
> Thanks!
>=20
> BTW, the other tsc2007 and ads7846 patches could already be merged (if =
there
> are no more changes needed) since this one only depends on the result =
of applying
> all others before.

I wonder if input maintainers can already merge the other patches of =
this patch series?

BR and thanks,
Nikolaus=
