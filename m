Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Greg KH <greg@kroah.com>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 8 Mar 2011 08:09:22 +0000
Subject: RE: [PATCH] Staging: IIO: Documentation: iio_utils: fix channel
 array generation.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177133FA8773AA@LIMKCMBX1.ad.analog.com>
References: <1299167403-18017-1-git-send-email-michael.hennerich@analog.com>
 <20110307214320.GA5639@kroah.com>
In-Reply-To: <20110307214320.GA5639@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Greg KH wrote on 2011-03-07:
> On Thu, Mar 03, 2011 at 04:50:03PM +0100, michael.hennerich@analog.com
> wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> The previous implementation flawed, in case some channels are not
>> enabled. The sorted array would then include channel information of
>> disabled channels, And misses the enabled ones, when the count is
>> reached. More troublesome, the loop would not even terminate.
>>
>> The fix is twofold:
>>
>> First we skip channels that are not enabled.
>> Then we use a tested bubble sort algorithm to sort the array.
>> Since we already allocated exactly the number of bytes we need.
>> We can exercise bubble sort on the original memory.
>> In all cases I've seen, the array is already sorted, so this sort
>> terminates immediately.
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/staging/iio/Documentation/iio_utils.h |   53 ++++++++++++++-
>>  --------- 1 files changed, 31 insertions(+), 22 deletions(-)
>> diff --git a/drivers/staging/iio/Documentation/iio_utils.h
>> b/drivers/staging/iio/Documentation/iio_utils.h
>> index 1b33c04..da10b4e 100644
>> --- a/drivers/staging/iio/Documentation/iio_utils.h
>> +++ b/drivers/staging/iio/Documentation/iio_utils.h
>> @@ -242,6 +242,25 @@ error_ret:
>>      return ret;
>>  }
>> +/**
>> + * bsort_channel_array_by_index() - reorder so that the array is in
>> +index order
>> + *
>> + **/
>> +
>> +inline void bsort_channel_array_by_index(struct iio_channel_info
>> +**ci_array, int cnt) {
>> +
>> +    struct iio_channel_info temp;
>> +    int x,y;
>> +
>> +    for(x=3D0; x<cnt; x++)
>> +            for(y=3D0; y<(cnt - 1); y++)
>> +                    if((*ci_array)[y].index > (*ci_array)[y+1].index) {
>> +                            temp =3D (*ci_array)[y+1];
>> +                            (*ci_array)[y+1] =3D (*ci_array)[y];
>> +                            (*ci_array)[y] =3D temp;
>> +                    }
>> +}
>
> This fails the checkpatch tool.  It might be documentation, but it
> still needs to follow the correct rules :)

This one slipped - updated patch on the way.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
