Return-Path: <SRS0=03Bb=6V=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Tue, 18 Jul 2017 06:57:15 +0100
In-Reply-To: <20170718053808.13036-1-gehariprasath@gmail.com>
References: <20170718053808.13036-1-gehariprasath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] staging: iio: adc: add space around substraction operation
To: Hari Prasath <gehariprasath@gmail.com>,lars@metafoo.de
CC: gehariprasath@gmail.com,Michael Hennerich <Michael.Hennerich@analog.com>,Jonathan Cameron <jic23@kernel.org>,Hartmut Knaack <knaack.h@gmx.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-iio@vger.kernel.org,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <CEA59923-B6BE-4764-B466-651FE7D5B73F@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 18 July 2017 06:38:08 BST, Hari Prasath <gehariprasath@gmail=2Ecom> wro=
te:
>Fix checkpatch warning to add space around the substraction operation
>
>Signed-off-by: Hari Prasath <gehariprasath@gmail=2Ecom>
>---
> drivers/staging/iio/adc/ad7280a=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/staging/iio/adc/ad7280a=2Ec
>b/drivers/staging/iio/adc/ad7280a=2Ec
>index d5ab83f=2E=2Ed79e774 100644
>--- a/drivers/staging/iio/adc/ad7280a=2Ec
>+++ b/drivers/staging/iio/adc/ad7280a=2Ec
>@@ -745,14 +745,14 @@ static irqreturn_t ad7280_event_handler(int irq,
>void *private)
> }
>=20
> static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
>-		in_voltage-voltage_thresh_low_value,
>+		in_voltage - voltage_thresh_low_value,
> 		0644,
> 		ad7280_read_channel_config,
> 		ad7280_write_channel_config,
> 		AD7280A_CELL_UNDERVOLTAGE);
>=20
> static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
>-		in_voltage-voltage_thresh_high_value,
>+		in_voltage - voltage_thresh_high_value,
> 		0644,
> 		ad7280_read_channel_config,
> 		ad7280_write_channel_config,

Check what this code actually does=2E=20
Using checkpatch gives suggestions of where
to look for issues; it is not always right!

This change breaks the userspace ABI=2E

Jonathan

Ps when ever  I see a patch involving whitespace and this driver I know I =
am going to give roughly
this response having done so perhaps 10 times in the past! =20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
