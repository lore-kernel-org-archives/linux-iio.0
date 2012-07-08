Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Martin =?utf-8?q?Li=C5=A1ka?= <marxin.liska@gmail.com>
Subject: Re: ACPI ambient light sensor
Date: Sun, 8 Jul 2012 22:28:14 +0200
Cc: platform-driver-x86@vger.kernel.org,
 linux-iio@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>,
 Corentin Chary <corentin.chary@gmail.com>,
 joeyli <jlee@suse.com>,
 Len Brown <len.brown@intel.com>,
 pavel@denx.de,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Jonathan Cameron <jic23@kernel.org>
References: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com>
In-Reply-To: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201207082228.14318.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Martin Li=C5=A1ka,

> Hello,
>    Iconia Tab W500 contains Ambient Light Sensor (hid 0008), I started
> implementing IIO device drive having following questions:
>=20
>    - chip could offer following variables: illuminance, color chromaticity
>    and color temperature, how should I connect last 2 vars to any of IIO
>    CHANNEL types?
>    - I'm not sure how to connect an illuminance mapping to IIO
>    infrastructure?

See IIO_DEVICE_ATTR() maybe ?

> Thank you,
> Martin Li=C5=A1ka

Best regards,
Marek Vasut
