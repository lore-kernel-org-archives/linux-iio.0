Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Shawn Guo <shawn.guo@linaro.org>, Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>
Date: Thu, 21 Nov 2013 12:41:24 +0100
Subject: Re: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
Message-ID: <528DF164.8060009@st.com>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Maxime, everyone,

only one point: it's possible to use the same names with DT? (using _=20
instead of -)
Why only for i2c?

Thanks,
Denis

> Hi everyone,
>
> This is an attempt at adding the DT probing to the st_sensors
> accelerometers and gyroscopes.
>
> It's somewhat hackish, because the core actively checks for the value
> of the device at probe time, and DT probing generates a quite
> different name.
>
> I first tried to turn the function st_sensors_check_device_support the
> other way around, with the "leaf" providing the sensor structure, and
> the function checking that it's consistent with the WAI stored in the
> sensor. However, it turned to be a quite intrusive change, so I'm
> sending the easiest one, to try to get some feedback :)
>
> Thanks!
> Maxime
>
> Maxime Ripard (3):
>    iio: accel: Add device tree probing for STMicro accelerometers
>    iio: accel: Add device tree probing for STMicro gyroscopes
>    ARM: cfa10057: Add the accelerometer and gyroscope to the device tree
>
>   .../devicetree/bindings/iio/accel/st_accel_i2c.txt | 22 +++++++++++++++
>   .../devicetree/bindings/iio/gyro/st_gyro_i2c.txt   | 20 +++++++++++++
>   arch/arm/boot/dts/imx28-cfa10057.dts               | 13 +++++++++
>   drivers/iio/accel/st_accel_i2c.c                   | 33 +++++++++++++++=
+++++++
>   drivers/iio/gyro/st_gyro_i2c.c                     | 31 +++++++++++++++=
+++++
>   5 files changed, 119 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/accel/st_accel=
_i2c.txt
>   create mode 100644 Documentation/devicetree/bindings/iio/gyro/st_gyro_i=
2c.txt
>
