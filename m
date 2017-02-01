Return-Path: <SRS0=DfSw=ZO=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Wed, 01 Feb 2017 17:25:08 +0000
In-Reply-To: <28916f18-da40-cf0a-5bfa-2c8d53a7d83c@axentia.se>
References: <03B5A3CA1724CE4EAC32B27E39292A677FC7512D3A@AUSMAIL1.AUS.ADVANTECH.CORP> <WM!0e191e8021de721ce26bb7af83b55064556944dd1ba4a4c5ffd0cf5fa2a60dcb49d0a6722934d893c1817b0383068e28!@dgg.advantech.com> <273c851c-4623-652e-097b-5a3827205ebc@axentia.se> <WM!c988294410704f5fdb6034485f95e283ba8a11561dded8460b8f9f4c302e8d9d3b5dfd6fbd89ee21c83838f1af88f482!@dg.advantech.com> <03B5A3CA1724CE4EAC32B27E39292A677FC7512E85@AUSMAIL1.AUS.ADVANTECH.CORP> <WM!da6c96198354db7af9f225c848a09d5c6e064c622dbfcc6b4670fb1c3db17e0cc67ee54b34600a69dd8059b643e30774!@dg.advantech.com> <28916f18-da40-cf0a-5bfa-2c8d53a7d83c@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: kernel 4.10-rcx iio helper question
To: Peter Rosin <peda@axentia.se>,"Ken.Lin" <ken.lin@advantech.com>,"jic23@kernel.org" <jic23@kernel.org>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>,"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,Akshay Bhat <akshay.bhat@timesys.com>,"Peter.Stretz" <peter.stretz@advantech.com>,"Peter.Chiang" <peter.chiang@advantech.com>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <F39F301F-43CC-409D-9FCA-F9F057450BD8@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 1 February 2017 05:50:12 GMT+00:00, Peter Rosin <peda@axentia=2Ese> wro=
te:
>On 2017-02-01 01:42, Ken=2ELin wrote:
>>=20
>>=20
>>> -----Original Message-----
>>> From: Peter Rosin [mailto:peda@axentia=2Ese]
>>> Sent: Tuesday, January 31, 2017 1:10 PM
>>> To: Ken=2ELin; jic23@kernel=2Eorg
>>> Cc: knaack=2Eh@gmx=2Ede; pmeerw@pmeerw=2Enet; linux-iio@vger=2Ekernel=
=2Eorg;
>linux-
>>> kernel@vger=2Ekernel=2Eorg; Akshay Bhat; Peter=2EStretz; Peter=2EChian=
g
>>> Subject: Re: kernel 4=2E10-rcx iio helper question
>>>
>>> On 2017-01-31 19:19, Ken=2ELin wrote:
>>>> Hi,
>>>>
>>>> I find the latest kernel introduces new iio sys attributes=2E
>>>> https://patchwork=2Ekernel=2Eorg/patch/9391771/
>>>> https://patchwork=2Ekernel=2Eorg/patch/9391259/
>>>>
>>>> Is there anyone has some ideas about how the new iio sys attribute
>-
>>> in_pressure_scale_available works?
>>>> I'm not sure if it's the regression issue or it's just the usage
>issue or something
>>> when I tried to read in_pressure_scale_available attribute=2E
>>>
>>>> # cat /sys/bus/iio/devices/iio\:device1/in_pressure_scale_available
>>>> Segmentation fault
>>>
>>> What driver is providing iio:device1?
>>>
>>>> [ 3785=2E077014] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 00000000 [ 3785=2E085138] pgd =3D ecc3c000 [
>3785=2E087929]
>>>> [00000000] *pgd=3D87f91831 [ 3785=2E091563] Internal error: Oops:
>80000007
>>>> [#1] SMP ARM [ 3785=2E096806] Modules linked in:
>>>> [ 3785=2E099892] CPU: 1 PID: 1051 Comm: cat Not tainted
>>>> 4=2E10=2E0-rc5-00009-gffd8858-dirty #3
>>>
>>> Looks like you have a couple of local changes? What are those?
>>>
>>=20
>> I didn't make any changes to the iio drivers locally and MPL3115A2
>pressure/temperature sensor driver (drivers/iio/pressure/mpl3115=2Ec) is
>the driver which provides iio:device1=2E
>>=20
>>> My WAG is that you added the IIO_CHAN_INFO_SCALE bit to one of the
>>> =2Einfo_mask_*_available fields in the channel spec but failed to
>provide a
>>> =2Eread_avail operation in the driver=2E Am I close?
>>>
>>=20
>> I could read iio:device0/in_accel_scale and
>device0/in_accel_available, which are provided by NXP 3-axis
>accelerometers driver (drivers/iio/accel/mma8452=2Ec)=2E
>> The attribute iio:/device1/in_pressure_scale is missing unless I
>reverted the commits=2E
>> https://patchwork=2Ekernel=2Eorg/patch/9391771/
>> https://patchwork=2Ekernel=2Eorg/patch/9391259/
>
>Whoops, sorry for suggesting you did something wrong=2E=2E=2E
>
>Can you try this patch?
Gah=2E My eyes passed straight over that=2E

Thanks Ken, nice regression report and thank peda for the fix=2E

Phew, single driver bug rather than a general regression!

Jonathan
>
>Cheers,
>peda
>
>diff --git a/drivers/iio/pressure/mpl115=2Ec
>b/drivers/iio/pressure/mpl115=2Ec
>index 73f2f0c46e62=2E=2E8f2bce213248 100644
>--- a/drivers/iio/pressure/mpl115=2Ec
>+++ b/drivers/iio/pressure/mpl115=2Ec
>@@ -137,6 +137,7 @@ static const struct iio_chan_spec mpl115_channels[]
>=3D {
> 	{
> 		=2Etype =3D IIO_TEMP,
> 		=2Einfo_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>+		=2Einfo_mask_shared_by_type =3D
> 			BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),
> 	},
> };
>diff --git a/drivers/iio/pressure/mpl3115=2Ec
>b/drivers/iio/pressure/mpl3115=2Ec
>index cc3f84139157=2E=2E525644a7442d 100644
>--- a/drivers/iio/pressure/mpl3115=2Ec
>+++ b/drivers/iio/pressure/mpl3115=2Ec
>@@ -190,7 +190,7 @@ static const struct iio_chan_spec
>mpl3115_channels[] =3D {
> 	{
> 		=2Etype =3D IIO_PRESSURE,
> 		=2Einfo_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>-			BIT(IIO_CHAN_INFO_SCALE),
>+		=2Einfo_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
> 		=2Escan_index =3D 0,
> 		=2Escan_type =3D {
> 			=2Esign =3D 'u',
>@@ -203,7 +203,7 @@ static const struct iio_chan_spec
>mpl3115_channels[] =3D {
> 	{
> 		=2Etype =3D IIO_TEMP,
> 		=2Einfo_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>-			BIT(IIO_CHAN_INFO_SCALE),
>+		=2Einfo_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
> 		=2Escan_index =3D 1,
> 		=2Escan_type =3D {
> 			=2Esign =3D 's',

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
