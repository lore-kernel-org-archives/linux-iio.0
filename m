Return-Path: <mfuzzey@parkeon.com>
Message-ID: <55520AD8.5070100@parkeon.com>
Date: Tue, 12 May 2015 16:14:48 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 4/9] iio: mma8452: Basic support for transient events.
References: <20150219141553.27001.18825.stgit@localhost> <20150219141602.27001.51592.stgit@localhost> <54EDBF33.1060309@kernel.org> <5540D422.6070204@parkeon.com> <554CC0EE.2060009@kernel.org>
In-Reply-To: <554CC0EE.2060009@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/05/15 15:58, Jonathan Cameron wrote:
> On 29/04/15 08:52, Martin Fuzzey wrote:
>> On 25/02/15 13:25, Jonathan Cameron wrote:
>>> On 19/02/15 14:16, Martin Fuzzey wrote:
>>>> The event is triggered when the highpass filtered absolute acceleration
>>>> exceeds the threshold.
>>>>
>>>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
>>> you in_accel_transient_scale isn't documented.
>>> Why do we need this naming at all?
>>> Ah. It's not clear this is just the event rather than the underlying channel.
>> Sorry, not understanding you here.
>>
>> Are you saying it's not clear in the documentation (which is the next
>> patch "iio: doc: Describe scale attributes for event thresholds" that
>> you've already applied) or in the code?
> oops, I suspect I didn't like the naming of the attribute being somewhat
> ambiguous.
>
> Also, whilst the next patch is documentation, it doesn't seem to include
> this particular attribute...

Ah, I think you are confusing the attribute name and the local variable 
name.
in_accel_transient_scale is just the local variable name.

The attribute name is events/in_accel_scale and that is documented in 
the patch you have already merged.


$ git show d1bd4867b0959d5221dc528ccf60c8534aae865d
commit d1bd4867b0959d5221dc528ccf60c8534aae865d
Author: Martin Fuzzey <mfuzzey@parkeon.com>
Date:   Thu Feb 19 15:16:04 2015 +0100

     iio: doc: Describe scale attributes for event thresholds

     Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
     Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/Documentation/ABI/testing/sysfs-bus-iio 
b/Documentation/ABI/testing/sysfs-bus-iio
index 9a70c31..9230709 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -661,6 +661,24 @@ Description:
                 value is in raw device units or in processed units (as _raw
                 and _input do on sysfs direct channel read attributes).

+What:          /sys/.../events/in_accel_scale
...


>> The code is:
>> /*
>>   * Threshold is configured in fixed 8G/127 steps regardless of
>>   * currently selected scale for measurement.
>>   */
>> static IIO_CONST_ATTR_NAMED(accel_transient_scale, in_accel_scale, "0.617742");
>>
>> static struct attribute *mma8452_event_attributes[] = {
>>      &iio_const_attr_accel_transient_scale.dev_attr.attr,
>>      NULL,
>> };
>>
>> static struct attribute_group mma8452_event_attribute_group = {
>>      .attrs = mma8452_event_attributes,
>>      .name = "events",
>> };
>>
>> #define MMA8452_CHANNEL(axis, idx) { \
>>      .type = IIO_ACCEL, \
>> ...
>>      .num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
>> }
>>
>>
>> That seems fairly clear to me.
>>
>>> Perhaps, make it an event parameter instead... e.g. add scale to the ev_info
>>> array like we do for hysteresis etc.
>> But doing that would create a read/write attribute in sysfs whereas the above code creates a read only attribute and makes it clear that the attribute is a constant through the use of IIO_CONST_ATTR_NAMED
>>
>> Once this is sorted out I'll send another (hopefully last) respin with the remaining remarks fixed.
>>
>> Regards,
>>
>> Martin
>>
>>> Otherwise, looks good to me.
>>>
>>> Again, Peter's input would be good.
>>>
>>>
