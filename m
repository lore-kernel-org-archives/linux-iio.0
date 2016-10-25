Return-Path: <john3909@gmail.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to 24MHz
From: John Syne <john3909@gmail.com>
In-Reply-To: <7024bec3-2ebe-db82-12e2-6d6bcc664c6b@ti.com>
Date: Tue, 25 Oct 2016 08:39:12 -0700
Cc: Mugunthan V N <mugunthanvnm@ti.com>,
 Lee Jones <lee.jones@linaro.org>,
 linux-iio@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>,
 Jonathan Cameron <jic23@kernel.org>,
 linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-Id: <893994DA-C6BB-4562-8207-1F75E6568A0B@gmail.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com> <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com> <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com> <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com> <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com> <7024bec3-2ebe-db82-12e2-6d6bcc664c6b@ti.com>
To: Vignesh R <vigneshr@ti.com>
List-ID: <linux-iio@vger.kernel.org>


> On Oct 24, 2016, at 11:37 PM, Vignesh R <vigneshr@ti.com> wrote:
>=20
>=20
>=20
> On Tuesday 25 October 2016 11:46 AM, John Syne wrote:
>>=20
>>> On Oct 24, 2016, at 11:01 PM, John Syne <john3909@gmail.com> wrote:
>>>=20
>>>>=20
>>>> On Oct 24, 2016, at 10:52 PM, Mugunthan V N <mugunthanvnm@ti.com> =
wrote:
>>>>=20
> [...]
>>>>>>>=20
>>>>>>> ---
>>>>>>> include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
>>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h =
b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>> index b9a53e0..96c4207 100644
>>>>>>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>> @@ -90,7 +90,7 @@
>>>>>>> /* Delay register */
>>>>>>> #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>>>>>>> #define STEPDELAY_OPEN(val)	((val) << 0)
>>>>>>> -#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>>>>> Wouldn=E2=80=99t this be better to add this to the devicetree?
>>>>>=20
>>>>> 	ti,chan-step-avg =3D <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
>>>>> 	ti,chan-step-opendelay =3D <0x500 0x500 0x500 0x500 0x500 0x500 =
0x500>;
>>>>> 	ti,chan-step-sampledelay =3D <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
>>>>=20
>>>> For a touch screen, there is not need to change in these parameter
>>>> settings, so my opinion is to keep it as is. Or am I missing =
something?
>>> I was thinking that if you are using this driver as an ADC, you may =
want the flexibility to make these changes in the DT. I=E2=80=99m doing =
this by connecting sensors to the ADC inputs. I=E2=80=99m not using this =
driver for a touchscreen.
>>=20
>=20
> ti_am335x_adc driver already supports above DT parameters and its upto
> the user to adjust these parameters as required.
>=20
>> Here is a DT overlay were this gets using on the BeagleBoneBlack. =20
>>=20
>> =
https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-AD=
C-00A0.dts
>>=20
>> Besides, these DT features are already implemented in the driver so =
it is just a matter of adding these entries to the am33xx.dtsi & =
am4372.dtsi, which you modified in this patch series.
>>=20
>=20
> Touchscreen driver (ti_am335x_tsc.c) does not support above DT =
parameters.
This patch series also modifies ti_am335x_adc.c

=
https://github.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/ti_a=
m335x_adc.c#L447

Regards,
John
>=20
> --=20
> Regards
> Vignesh
