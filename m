Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Ben Gardiner <bengardiner@nanometrics.ca>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 19 Nov 2010 15:41:12 +0000
Subject: RE: [PATCH] staging: iio: adc: Enable driver support for ad7887 AD
 converter
Message-ID: <544AC56F16B56944AEC3BD4E3D591771312EE154D3@LIMKCMBX1.ad.analog.com>
References: <1290097328-6236-1-git-send-email-michael.hennerich@analog.com>
 <AANLkTi=sefrxCJM1n0E_9E4HYzMfuA_F-66evZr794X6@mail.gmail.com>
In-Reply-To: <AANLkTi=sefrxCJM1n0E_9E4HYzMfuA_F-66evZr794X6@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Ben Gardiner wrote on 2010-11-19:
> Hi Michael,
>
> I'm new to IIO and was reading this post as part of my familiarization
> with the framework. I can't really comment on the meat of this work
> but I did notice a couple references to 'i2c' in the comments. I hope
> you don't mind: I can only contribute this minor nitpick.

Thanks a lot for your review.
I'll fix it up.


> On Thu, Nov 18, 2010 at 11:22 AM,  <michael.hennerich@analog.com>
> wrote:
>> [...] +static int __devinit ad7887_probe(struct spi_device *spi) [...]
>> +       /* Estabilish that the iio_dev is a child of the i2c device */
>> [...] +/** + * ad7887_poll_func_th() th of trigger launched polling to
>> ring +buffer + * + * As sampling only occurs on i2c comms occuring,
>> leave +timestamping until + * then.  Some triggers will generate their
>> own time stamp. +Currently + * there is no way of notifying them when
>> no one cares. + **/ [...]
>
> Best Regards,
> Ben Gardiner
>
> ---
> Nanometrics Inc.
> http://www.nanometrics.ca

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
