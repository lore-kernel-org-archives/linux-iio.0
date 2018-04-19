Return-Path: <SRS0=m4dB=HI=freebsd.org=kevans@kernel.org>
MIME-Version: 1.0
In-Reply-To: <F1D7126A-B6ED-4A83-A941-5F39CED472CE@aosc.io>
References: <20180128232919.12639-1-embed3d@gmail.com> <20180128232919.12639-15-embed3d@gmail.com>
 <20180129095200.attg7cgvpifpchtn@flea.lan> <470ec61e-8b08-5193-ede1-01d02b2c865e@gmail.com>
 <CACNAnaGVSbk7czb+mcGTx1C=YwCWe1qqHQDQe9+PNifwEXovMw@mail.gmail.com> <F1D7126A-B6ED-4A83-A941-5F39CED472CE@aosc.io>
From: Kyle Evans <kevans@freebsd.org>
Date: Thu, 19 Apr 2018 10:19:30 -0500
Message-ID: <CACNAnaFMKDmvAUXJngKHWkeGLfjsgn5hhJszNk7Sg4BU98Oafw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 14/16] arm: dts: sun8i: h3: enable H3
 sid controller
To: icenowy@aosc.io
Cc: embed3d@gmail.com, Maxime Ripard <maxime.ripard@free-electrons.com>,
	lee.jones@linaro.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	Russell King <linux@armlinux.org.uk>, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, davem@davemloft.net, hans.verkuil@cisco.com,
	mchehab@kernel.org, rask@formelder.dk, clabbe.montjoie@gmail.com,
	sean@mess.org, krzk@kernel.org, quentin.schulz@free-electrons.com,
	edu.molinas@gmail.com, singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 19, 2018 at 10:13 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> =E4=BA=8E 2018=E5=B9=B44=E6=9C=8819=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
11:11:22, Kyle Evans <kevans@freebsd.org> =E5=86=99=E5=88=B0:
>>On Mon, Jan 29, 2018 at 6:03 AM, Philipp Rossak <embed3d@gmail.com>
>>wrote:
>>>
>>>
>>> On 29.01.2018 10:52, Maxime Ripard wrote:
>>>>
>>>> On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrote:
>>>>>
>>>>> This patch enables the the sid controller in the H3. It can be used
>>>>> for thermal calibration data.
>>>>>
>>>>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>>>>> ---
>>>>>   arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>>>>>   1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>> b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>> index 3f83f6a27c74..9bb5cc29fec5 100644
>>>>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>>> @@ -72,6 +72,13 @@
>>>>>                 };
>>>>>         };
>>>>>   +     soc {
>>>>> +               sid: eeprom@1c14000 {
>>>>> +                       compatible =3D "allwinner,sun8i-h3-sid";
>>>>> +                       reg =3D <0x01c14000 0x400>;
>>>>> +               };
>>>>> +       };
>>>>> +
>>>>
>>>>
>>>> Shouldn't you also use a nvmem-cells property to the THS node?
>>>>
>>>> Maxime
>>>>
>>>
>>> Oh seems like I forgot that.
>>> As related to the wiki [1] this should be 64 bit wide at the address
>>0x34. I
>>> will add that in the next version.
>>>
>>>
>>> [1]: http://linux-sunxi.org/SID_Register_Guide#eFUSE
>>>
>>> Thanks,
>>> Philipp
>>>
>>
>>Hi,
>>
>>Any chance this will see a v3 soon? I'm kind of interested in sid node
>>for h3. =3D)
>
> This patch is independent and can be easily sent out
> by its own.
>

Right- I had considered doing so, but wanted to make sure I wasn't
going to collide with this series if a v3 is imminent.
