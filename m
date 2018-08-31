Return-Path: <SRS0=xfpC=LO=gmail.com=embed3d@kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add
 support for H3 thermal sensor
To: icenowy@aosc.io, Maxime Ripard <maxime.ripard@bootlin.com>
Cc: mark.rutland@arm.com, geert+renesas@glider.be, linux-iio@vger.kernel.org,
 robh+dt@kernel.org, linux-sunxi@googlegroups.com, clabbe.montjoie@gmail.com,
 pmeerw@pmeerw.net, lee.jones@linaro.org, lars@metafoo.de,
 quentin.schulz@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
 devicetree@vger.kernel.org, arnd@arndb.de, vilhelm.gray@gmail.com,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
 rdunlap@infradead.org, arnaud.pouliquen@st.com,
 linux-kernel@vger.kernel.org, lukas@wunner.de, knaack.h@gmx.de,
 eugen.hristev@microchip.com, jic23@kernel.org
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180831091137.wkbbipssyd6mqfbt@flea>
 <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <247ac301-0f33-29d1-ead4-d76f54a226f9@gmail.com>
Date: Fri, 31 Aug 2018 13:58:52 +0200
MIME-Version: 1.0
In-Reply-To: <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 31.08.2018 11:51, Icenowy Zheng wrote:
> Personally I suggest to leave out all SID or calibration related
> patches here.
> 
> Currently we seems to be wrongly converting SID to big endian, however,
> the orgnization of the THS calibration data on H6 shows that it's
> surely little endian:
> 
> It consists a temperature value in 1/10 celsuis as unit, and some
> thermal register readout values, which are the values read out at the
> given temperature, and every value here (the temperature and the
> readout) are all half word length.
> 
> Let the temperature value be AABB, the two readout values be XXYY and
> ZZWW, the oragnization is:
> BB AA YY XX WW ZZ ** ** .
> 
> When converting the SID to big endian, it becomes:
> XX YY AA BB ** ** ZZ WW ,
> which is non-sense, and not able to do sub-word cell addressing.
> 
> Maxime, should I drop the LE2BE conversion in SID driver? (I doubt
> whether it will break compatibility.)
> 
> Philipp, could you delay to send any code that uses SID?

Yes for sure! I will move the related patches to the end of the series 
and add a DO-NOT-MERGE flag in the title. So I can get those also 
ready/reviewed but not merged.

Icenowy, do you know more about the A83T SID? From the general specs it 
could be the same like on the A64 or the H3.

Thanks,
Philipp
