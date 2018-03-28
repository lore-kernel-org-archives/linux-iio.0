Return-Path: <SRS0=f2Op=GS=invensense.com=JManeyrol@kernel.org>
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Martin Kelly <mkelly@xevo.com>, Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: How to handle missing timestamps? (was Re: [PATCH] iio: imu:
 inv_mpu6050: improve missing timestamp handling)
Date: Wed, 28 Mar 2018 15:13:07 +0000
Message-ID: <CY4PR1201MB0184E34B46C1C56A7C38CFC9C4A30@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <20180324000240.19519-1-mkelly@xevo.com>
 <20180324123519.0acba88e@archlinux>
 <7c1718f2fc324eb6b959257a80e136cdCY4PR1201MB0184E4503B2B1EEA7F24C41DC4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
 <cc66bed2-ef59-ea75-d26d-f5ed55b55a65@xevo.com>
 <CY4PR1201MB0184826F66D8C1439D2FA6D1C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>,<d18234ce-f311-17df-1281-26ea3f035e13@xevo.com>
In-Reply-To: <d18234ce-f311-17df-1281-26ea3f035e13@xevo.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hello,

loosing data at 50Hz is really strange. I am currently running an old MPU-6=
500 at 200Hz on I2C @400KHz without any issue (using HiKey board).

Can you tell me what is the chip you are using, the board (CPU+freq) and th=
e I2C bus speed?

Anyway, your solution seems to be good, better then putting 0 for timestamp=
s.

Best regards,
JB
 =20
From: Martin Kelly <mkelly@xevo.com>
Sent: Wednesday, March 28, 2018 2:34:02 AM
To: Jean-Baptiste Maneyrol; Jonathan Cameron
Cc: linux-iio@vger.kernel.org
Subject: Re: How to handle missing timestamps? (was Re: [PATCH] iio: imu: i=
nv_mpu6050: improve missing timestamp handling)
=A0=20

On 03/27/2018 01:47 AM, Jean-Baptiste Maneyrol wrote:
> Hello,
>=20
> this raises a good question of which interrupts we are missing (the oldes=
t ones or the newest ones).
>=20
> My bet would be that we are loosing interrupts from the newest data (the =
irq thread can take too much time and we loose interrupt). In this case man=
ual timestamping would rather be:
>=20
> sample 0 (oldest timestamp): interrupt timestamp
> sample 1: interrupt timestamp + 0.1 seconds
> sample 2: interrupt timestamp + 0.2 seconds
> sample 3 (newest timestamp): interrupt timestamp + 0.3 seconds
>=20
> Can you check with your setup that this is really what is happening?
>=20

Yes, good point. I did a lot of testing and determined that the sequence=20
of events is something like this:

IRQ --> timestamp
new datum
new datum
new datum
IRQ --> timestamp

Specifically:
- At 50 Hz, interrupts are being generated at about 30 Hz.
- The timestamps in the FIFO correspond to the *newest* data, not the=20
oldest.

I tried interpolating using both assumptions: timestamps corresponding=20
to oldest and then to newest data. Using timestamps corresponding to=20
oldest data, we get timestamps that are not monotonically increasing and=20
thus time moving backwards as the data flows. Using timestamps=20
corresponding to oldest data, we get monotonically increasing time as it=20
should be, and the data looks pretty consistent.

What I settled on is to use the newer timestamps we see to backdate the=20
older data, the ones we remove first from the FIFO. It appears to be=20
working nicely.

I sent a v2 of the patch that does this interpolation.
    =
