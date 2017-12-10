Return-Path: <SRS0=ER7a=DG=nexb.com=pombredanne@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171209232507.18594-3-afaerber@suse.de>
References: <20171209232507.18594-1-afaerber@suse.de> <20171209232507.18594-3-afaerber@suse.de>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sun, 10 Dec 2017 09:50:14 +0100
Message-ID: <CAOFm3uFzy+bfKJ+WCRBuZb-8sWM1Yjgg-m-PaPp=iMYCWExPUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: magnetometer: Add Infineon TLV493D-A1B6
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Marius Tarcatu <marius.tarcatu@infineon.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Andreas,

On Sun, Dec 10, 2017 at 12:25 AM, Andreas F=C3=A4rber <afaerber@suse.de> wr=
ote:
> The Infineon TLV493D is a 3D magnetic sensor, A1B6 is I2C based.
>
> It is found among others on the Infineon 3D Magnetic Sensor 2Go Kit,
> which allows to detach the sensor as a breakout board.
>
> Cc: Marius Tarcatu <marius.tarcatu@infineon.com>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
[...]
> --- /dev/null
> +++ b/drivers/iio/magnetometer/tlv493d.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0+

Thank you++ for using the new SDPX ids!

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

--=20
Cordially
Philippe Ombredanne
