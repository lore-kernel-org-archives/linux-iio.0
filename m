Return-Path: <SRS0=Y16N=JW=st.com=denis.ciocca@kernel.org>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
        Stefan Wahren
	<stefan.wahren@i2se.com>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: st_accel: iis328dq support?
Date: Fri, 6 Jul 2018 17:16:47 +0000
Message-ID: <a6f99e89de9a47a8b1f97c71c41a8eeb@SFHDAG2NODE1.st.com>
References: <2bac9ecf-9d2e-967e-9020-1c950487d781@i2se.com>
 <20180706180201.000024a8@huawei.com>
In-Reply-To: <20180706180201.000024a8@huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan, Stefan,

LIS331DLH and IIS327DQ are compatible.
Mainly difference is the packaging since IIS is designed for industrial app=
lications.=20
If you can give it a shot will be great before adding the compatible string=
.

Br,
Denis


-----Original Message-----
From: Jonathan Cameron <jonathan.cameron@huawei.com>=20
Sent: Friday, July 6, 2018 10:02 AM
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>; Denis CIOCCA <denis.ci=
occa@st.com>; Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.or=
g
Subject: Re: st_accel: iis328dq support?

On Fri, 6 Jul 2018 09:18:53 +0200
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi,
> i want to use the ST IIS328DQ [1] on a ARM board with Linux. The iio=20
> subsystem has this st_accel driver. But i didn't find any reference to=20
> the IIS328DQ, so i started comparing the datasheets and found the ST=20
> LIS331DLH [2].

Given it reports the same WHO_AM_I of 0x32 it better be compatible or they =
are being very unhelpful!

>=20
> Since i didn't have the hardware yet, i've the following questions:
>=20
> Does the st_accel driver support the IIS328DQ?

Not if it's not listed - though it might work.

> Should i choose the st,lis331dlh compatible for devicetree?

Ideal is to add the addition compatible string and device name etc to the d=
river to support the part under this part number.

It's always nicer if a DT matches the part number on the part you can see o=
n the board!

Jonathan

p.s. If you don't fancy writing the patch, but will happily test it really =
is compatible, let us know and I'm sure someone else will pick it up if I d=
on't.

>=20
> Thanks in advance
> Stefan
>=20
> [1] - https://www.st.com/resource/en/datasheet/iis328dq.pdf
> [2] - https://www.st.com/resource/en/datasheet/cd00213470.pdf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
