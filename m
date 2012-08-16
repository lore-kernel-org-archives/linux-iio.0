Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <A874F61F95741C4A9BA573A70FE3998F41EEF1F7@DQHE02.ent.ti.com> <502B62AC.2030801@metafoo.de> <A874F61F95741C4A9BA573A70FE3998F41EEFD05@DQHE02.ent.ti.com>
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F41EEFD05@DQHE02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: [PATCH v2] iio: adc: add new lp8788 adc driver
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 16 Aug 2012 06:36:16 +0100
To: "Kim, Milo" <Milo.Kim@ti.com>,Lars-Peter Clausen <lars@metafoo.de>,"jic23@cam.ac.uk" <jic23@cam.ac.uk>
CC: "jic23@kernel.org" <jic23@kernel.org>,"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,"sameo@linux.intel.com" <sameo@linux.intel.com>
Message-ID: <f1f77ced-be0d-4501-b38d-91a796170649@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



"Kim, Milo" <Milo.Kim@ti.com> wrote:

>> > +	switch (mask) {
>> > +	case IIO_CHAN_INFO_RAW:
>> > +		*val =3D result;
>> > +		return IIO_VAL_INT;
>> > +	case IIO_CHAN_INFO_SCALE:
>> > +		*val =3D adc_const[id] * ((result * 1000 + 500) / 1000);
>>=20
>> This looks wrong. The IIO_CHAN_INFO_SCALE attribute is the factor by
>> which
>> IIO_CHAN_INFO_RAW needs to be multiplied to get the value in the
>proper
>> unit,
>> which is specified in the IIO ABI spec. E.g. milli volts for
>voltages.
>>=20
>> What you return here seems to be the IIO_CHAN_INFO_PROCESSED
>attribute.
>> Which
>> basically is raw * scale.
>
>Thanks a lot for your review.
>
>Any way to get the result with offset value in the iio-consumer side?
>What I need is as below.
>
>  result =3D raw * scale + offset
>
>At this moment, there are two apis() for reading the iio channel
>- iio_read_channel_raw() and iio_read_channel_scale().
>
>Does it sound good if I add iio_read_channel_offset() consumer api
>using IIO_CHAN_INFO_OFFSET?

Yes. Please add that.
>
>Best Regards,
>Milo

--=20
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
