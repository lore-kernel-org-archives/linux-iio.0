Return-Path: <SRS0=xfpC=LO=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH v3 20/30] iio: adc: sun4i-gpadc-iio: rework: device
 specific suspend & resume
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, eugen.hristev@microchip.com,
 rdunlap@infradead.org, vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
 quentin.schulz@bootlin.com, geert+renesas@glider.be, lukas@wunner.de,
 icenowy@aosc.io, arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-21-embed3d@gmail.com>
 <20180831090915.agbldint76ngj5jf@flea>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <ddd06c43-026e-2801-dc36-053d469e43f3@gmail.com>
Date: Fri, 31 Aug 2018 14:05:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180831090915.agbldint76ngj5jf@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 31.08.2018 11:09, Maxime Ripard wrote:
>> +static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)
> suspend is already a hook in the kernel, which hasn't the same meaning
> than runtime_suspend (and the same applies to resume), so we'd rather
> pick a better name. And all the functions (and the driver) use gpadc,
> please continue to use that prefix.

I agree.
For the newer sensors (from H3) the Sensor is referenced in the 
datasheets as Thermal Sensor short THS. So I would like to use for the 
newer sensors that prefix. Is that ok?

Philipp
