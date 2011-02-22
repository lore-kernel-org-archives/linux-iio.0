Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4D6421A6.1080003@analog.com>
Date: Tue, 22 Feb 2011 21:50:46 +0100
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: michael.hennerich@analog.com
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: Documentation: iio_utils: Prevent buffer overflow
References: <1297887372-31564-1-git-send-email-michael.hennerich@analog.com> <4D640EAF.3070109@cam.ac.uk>
In-Reply-To: <4D640EAF.3070109@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On 02/22/2011 08:29 PM, Jonathan Cameron wrote:
> On 02/16/11 20:16, michael.hennerich@analog.com wrote:
>   
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> The first part of build_channel_array()identifies the number of enabled channels.
>> Further down this count is used to allocate the ci_array. The next section parses the
>> scan_elements directory again, and fills ci_array regardless if the channel is enabled or not.
>> So if less than available channels are enabled ci_array memory is overflowed.
>>     
> Good point. Oops...  I guess all my test cases actually had all channels enabled.
>   
>> This fix makes sure that we allocate enough memory. But the whole approach looks a bit
>> cumbersome to me. Why not allocate memory for MAX_CHANNLES, less say 64
>> (I never seen a part with more than that channels). And skip the first part entirely.
>>     
> Could do, but I'd rather keep this fully general and it's only slightly cumbersome.
> Probably better ways of writing this whole function though now I think about it...
> Perhaps some scandir magic as could get that to give a sorted list of _en
> attribute names saving the sorting of the array at the end.
>   
>>     
> Anyhow, definitely send this fix on!
>   
Given the fact that this is loose user space example code under the
Documentation folder.
- Does it really need to go into stable?
Same question applies to the other none style fixes to your example code.

>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>     
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>   
>> ---
>>  drivers/staging/iio/Documentation/iio_utils.h |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
>> index 4b023aa..bde2313 100644
>> --- a/drivers/staging/iio/Documentation/iio_utils.h
>> +++ b/drivers/staging/iio/Documentation/iio_utils.h
>> @@ -290,15 +290,17 @@ inline int build_channel_array(const char *device_dir,
>>                       fscanf(sysfsfp, "%u", &ret);
>>                       if (ret == 1)
>>                               (*counter)++;
>> +                     count++;
>>                       fclose(sysfsfp);
>>                       free(filename);
>>               }
>> -     *ci_array = malloc(sizeof(**ci_array)*(*counter));
>> +     *ci_array = malloc(sizeof(**ci_array)*count);
>>       if (*ci_array == NULL) {
>>               ret = -ENOMEM;
>>               goto error_close_dir;
>>       }
>>       seekdir(dp, 0);
>> +     count = 0;
>>       while (ent = readdir(dp), ent != NULL) {
>>               if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
>>                          "_en") == 0) {
>>     
>   


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
