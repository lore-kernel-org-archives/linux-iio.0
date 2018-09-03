Return-Path: <SRS0=XUT0=LR=aosc.io=icenowy@kernel.org>
Date: Mon, 03 Sep 2018 19:01:47 +0800
In-Reply-To: <20180903102022.fkxfkxadkt4vpbmb@flea>
References: <20180830154518.29507-1-embed3d@gmail.com> <20180830154518.29507-22-embed3d@gmail.com> <20180831091137.wkbbipssyd6mqfbt@flea> <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io> <20180903102022.fkxfkxadkt4vpbmb@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [linux-sunxi] Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
To: maxime.ripard@bootlin.com,Maxime Ripard <maxime.ripard@bootlin.com>
CC: Philipp Rossak <embed3d@gmail.com>,mark.rutland@arm.com,geert+renesas@glider.be,linux-iio@vger.kernel.org,robh+dt@kernel.org,linux-sunxi@googlegroups.com,clabbe.montjoie@gmail.com,pmeerw@pmeerw.net,lee.jones@linaro.org,lars@metafoo.de,quentin.schulz@bootlin.com,linux@armlinux.org.uk,wens@csie.org,devicetree@vger.kernel.org,arnd@arndb.de,vilhelm.gray@gmail.com,broonie@kernel.org,linux-arm-kernel@lists.infradead.org,rdunlap@infradead.org,arnaud.pouliquen@st.com,linux-kernel@vger.kernel.org,lukas@wunner.de,knaack.h@gmx.de,eugen.hristev@microchip.com,jic23@kernel.org
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <AFDFF5AB-8BF6-4461-A5C2-D628A2F22E2E@aosc.io>
List-ID: <linux-iio@vger.kernel.org>



=E4=BA=8E 2018=E5=B9=B49=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=886:=
20:22, Maxime Ripard <maxime=2Eripard@bootlin=2Ecom> =E5=86=99=E5=88=B0:
>On Fri, Aug 31, 2018 at 05:51:41PM +0800, Icenowy Zheng wrote:
>> Personally I suggest to leave out all SID or calibration related
>> patches here=2E
>>=20
>> Currently we seems to be wrongly converting SID to big endian,
>however,
>> the orgnization of the THS calibration data on H6 shows that it's
>> surely little endian:
>>=20
>> It consists a temperature value in 1/10 celsuis as unit, and some
>> thermal register readout values, which are the values read out at the
>> given temperature, and every value here (the temperature and the
>> readout) are all half word length=2E
>>=20
>> Let the temperature value be AABB, the two readout values be XXYY and
>> ZZWW, the oragnization is:
>> BB AA YY XX WW ZZ ** ** =2E
>>=20
>> When converting the SID to big endian, it becomes:
>> XX YY AA BB ** ** ZZ WW ,
>> which is non-sense, and not able to do sub-word cell addressing=2E
>>=20
>> Maxime, should I drop the LE2BE conversion in SID driver? (I doubt
>> whether it will break compatibility=2E)
>
>This is exposed to the userspace, so no=2E

Please note the LE2BE totally breaks the SID addressing=2E

Without it dropped all cells must be referenced with
4 byte word as unit, and half word addressing of
SID is thus not possible=2E The driver will also need then to split
the half words if needed=2E

I think this is kind of hardware misbehavior, and not a simple
UAPI change, so the UAPI stability shouldn't affect this change=2E

>
>Maxime
>>=20
