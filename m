Return-Path: <SRS0=VdOV=BY=redhat.com=hdegoede@kernel.org>
Subject: Re: [PATCH] iio/accel/bmc150: Improve unlocking of a mutex in two
 functions
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <66d582a4-a77e-cd78-4215-49587ec2259e@users.sourceforge.net>
 <fb223eb2-ddab-396e-372e-e9496be8bf0f@redhat.com>
 <c32ea2ea-5961-6589-6b51-1184d9565a38@users.sourceforge.net>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <6a2c614a-4d0d-f2d2-1689-4c67a2fc3eea@redhat.com>
Date: Wed, 25 Oct 2017 18:22:02 +0200
MIME-Version: 1.0
In-Reply-To: <c32ea2ea-5961-6589-6b51-1184d9565a38@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 25-10-17 18:15, SF Markus Elfring wrote:
>> IMHO, if you do this, you should rework the function so that there is a single unlock call
>> at the end, not a separate one in in error label.
> 
> Thanks for your update suggestion.
> 
> Does it indicate that I may propose similar source code adjustments
> in this software area?
> 
> 
>> Could e.g. change this:
>>
>>          ret = bmc150_accel_set_power_state(data, false);
>>          mutex_unlock(&data->mutex);
>>          if (ret < 0)
>>                  return ret;
>>
>>          return IIO_VAL_INT;
>> }
>>
>> To:
>>
>>          ret = bmc150_accel_set_power_state(data, false);
>>          if (ret < 0)
>>                  goto unlock;
>>
>>      ret = IIO_VAL_INT;

If that is the only unlock in the function, then it is probably
best to keep things as is. In general gotos are considered
better then multiple unlocks, but not having either is even
better.


> How do you think about to use the following code variant then?
> 
> 	if (!ret)
> 		ret = IIO_VAL_INT;


I believe the goto unlock variant and setting ret = IIO_VAL_INT;
directly above the unlock label variant is better, because that
way the error handling is consistent between all steps and if
another step is later added at the end, the last step will
not require modification.

>> unlock:
>>          mutex_unlock(&data->mutex);
>>
>>          return ret;
>> }
>>
>> And also use the unlock label in the other cases, this is actually
>> quite a normal pattern. I see little use in a patch like this if there
>> are still 2 unlock paths after the patch.
> 
> How long should I wait for corresponding feedback before another small
> source code adjustment will be appropriate?

That is hard to say. I usually just do a new version when I've time,
seldomly someone complains I should have waited longer for feedback
(when I'm quite quick) but usually sending out a new version as soon
as you've time to work on a new version is best, since if you wait
you may then not have time for the entire next week or so, at least
that is my experience :)  There is really no clear rule here.

Regards,

Hans
