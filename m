Return-Path: <SRS0=qc1z=GF=gmail.com=john3909@kernel.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by
 IIO_DEVICE_ATTR
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180310151045.4570e85d@archlinux>
Date: Wed, 14 Mar 2018 23:12:02 -0700
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 devel@driverdev.osuosl.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Message-Id: <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I have been looking at the IIO ABI docs and if I understand correctly, =
the idea is to use consistent naming conventions? So for example, =
looking at the ADE7854 datasheet, the naming matching the ADE7854 =
registers would be as follows:

{direction}_{type}_{index}_{modifier}_{info_mask}

AIGAIN	-	In_current_a_gain
AVGAIN	-	in_voltage_a_gain
BIGAIN	-	in_current_b_gain
BVGAIN	-	in_voltage_b_gain
=E2=80=94
How do we represent the rms and offset
AIRMSOS	-	in_current_a_rmsoffset
AVRMSOS	-	in_voltage_a_rmsoffset
=E2=80=94
Here I don=E2=80=99t understand how to represent both the phase and the =
active/reactive/apparent power components. Do we combine the phase and =
quadrature part like this
AVAGAIN		-	in_power_a_gain				/* =
apparent power */
=E2=80=94
AWGAIN		-	in_power_ai_gain				=
/* active power */
=E2=80=94
AVARGAIN	-	in_power_aq_gain				=
/* reactive power */
=E2=80=94
Now here it becomes more complicated. Not sure how this gets handled.=20
AFWATTOS	-	in_power_a_active/fundamental/offset
=E2=80=94
AWATTHR	-	in_energy_ai_accumulation
=E2=80=94
AVARHR		-	in_energy_aq_accumulation
=E2=80=94
IPEAK		-	in_current_peak
=E2=80=94

I=E2=80=99ll leave it there, because there are some even more =
complicated register naming issues.

Regards,
John





> On Mar 10, 2018, at 7:10 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>=20
> On Thu, 8 Mar 2018 21:37:33 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>=20
>> On 03/07, Jonathan Cameron wrote:
>>> On Tue, 6 Mar 2018 21:43:47 -0300
>>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>>>=20
>>>> The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, =
with a
>>>> tiny change in the name definition. This extra macro does not =
improve
>>>> the readability and also creates some checkpatch errors.
>>>>=20
>>>> This patch fixes the checkpatch.pl errors:
>>>>=20
>>>> staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) =
not
>>>> decimal permissions
>>>> staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) =
not
>>>> decimal permissions
>>>> staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) =
not
>>>> decimal permissions
>>>> staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) =
not
>>>> decimal permissions
>>>>=20
>>>> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> =20
>>>=20
>>> Hmm. I wondered a bit about this one. It's a correct patch in of
>>> itself but the interface in question doesn't even vaguely conform
>>> to any of defined IIO ABI.  Anyhow, it's still and improvement so
>>> I'll take it. =20
>>=20
>> I am not sure if I understood the comment about the ABI. The meter
>> interface is wrong because it uses things like IIO_DEVICE_ATTR? It
>> should use iio_info together with *write_raw and *read_raw. Right? Is =
it
>> the ABI problem that you refer?
> The ABI is about the userspace interface of IIO.  It is defined
> in Documentation/ABI/testing/sysfs-bus-iio*
> So this documents the naming of sysfs attributes and (more or less)
> describes a consistent interface to userspace across lots of different
> types of devices.
>=20
> A lot of these older drivers in staging involve a good deal of ABI =
that
> was not reviewed or discussed.  That is one of the biggest reasons we
> didn't take them out of staging in the first place.
>=20
> In order for generic userspace programs to have any idea what to do
> with these devices this all needs to be fixed.
>=20
> There may well be cases where we need to expand the existing ABI to
> cover new things.   That's fine, but it has to be done with full
> review of the relevant documentation patches.
>=20
> Incidentally if you want an easy driver to work on moving out of =
staging
> then first thing to do is to compare what it shows to userspace with =
these
> docs.  If it's totally different then you have a big job on your hands
> as often ABI can take a lot of discussion and a long time to establish
> a consensus.
>=20
> Jonathan
>=20
>=20
>>=20
>> Thanks :)
>>=20
>>> Applied to the togreg branch of iio.git and pushed out as testing
>>> for the autobuilders to play with it.
>>>=20
>>> I also added the removal of the header define which is no
>>> longer used.
>>>=20
>>> Please note, following discussions with Michael, I am going to send
>>> an email announcing an intent to drop these meter drivers next
>>> cycle unless someone can provide testing for any attempt to
>>> move them out of staging.  I'm still taking patches on the basis
>>> that 'might' happen - but I wouldn't focus on these until we
>>> have some certainty on whether they will be around long term!
>>>=20
>>> Jonathan
>>>=20
>>>> ---
>>>> drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
>>>> drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
>>>> 2 files changed, 20 insertions(+), 16 deletions(-)
>>>>=20
>>>> diff --git a/drivers/staging/iio/meter/ade7753.c =
b/drivers/staging/iio/meter/ade7753.c
>>>> index c44eb577dc35..275e8dfff836 100644
>>>> --- a/drivers/staging/iio/meter/ade7753.c
>>>> +++ b/drivers/staging/iio/meter/ade7753.c
>>>> @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
>>>> 		ade7753_read_16bit,
>>>> 		NULL,
>>>> 		ADE7753_PERIOD);
>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>> -		ade7753_read_8bit,
>>>> -		ade7753_write_8bit,
>>>> -		ADE7753_CH1OS);
>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>> -		ade7753_read_8bit,
>>>> -		ade7753_write_8bit,
>>>> -		ADE7753_CH2OS);
>>>> +
>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>> +			ade7753_read_8bit,
>>>> +			ade7753_write_8bit,
>>>> +			ADE7753_CH1OS);
>>>> +
>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>> +			ade7753_read_8bit,
>>>> +			ade7753_write_8bit,
>>>> +			ADE7753_CH2OS);
>>>>=20
>>>> static int ade7753_set_irq(struct device *dev, bool enable)
>>>> {
>>>> diff --git a/drivers/staging/iio/meter/ade7759.c =
b/drivers/staging/iio/meter/ade7759.c
>>>> index 1decb2b8afab..c078b770fa53 100644
>>>> --- a/drivers/staging/iio/meter/ade7759.c
>>>> +++ b/drivers/staging/iio/meter/ade7759.c
>>>> @@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
>>>> 		ade7759_read_16bit,
>>>> 		ade7759_write_16bit,
>>>> 		ADE7759_APGAIN);
>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>> -		ade7759_read_8bit,
>>>> -		ade7759_write_8bit,
>>>> -		ADE7759_CH1OS);
>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>> -		ade7759_read_8bit,
>>>> -		ade7759_write_8bit,
>>>> -		ADE7759_CH2OS);
>>>> +
>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>> +			ade7759_read_8bit,
>>>> +			ade7759_write_8bit,
>>>> +			ADE7759_CH1OS);
>>>> +
>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>> +			ade7759_read_8bit,
>>>> +			ade7759_write_8bit,
>>>> +			ADE7759_CH2OS);
>>>>=20
>>>> static int ade7759_set_irq(struct device *dev, bool enable)
>>>> { =20
>>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> =
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
