Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <563F668D.7090804@kernel.org>
References: <1446956488-8262-1-git-send-email-mranostay@gmail.com>
	<563F668D.7090804@kernel.org>
Date: Sun, 8 Nov 2015 13:23:20 -0800
Message-ID: <CAKzfze-dhPiOksAdnGW=FjS346LxZ66kFMd30OiRKRg6U57+rw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: apds9960: correct ->last_busy count
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Nov 8, 2015 at 7:13 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 08/11/15 04:21, Matt Ranostay wrote:
>> Add missing pm_runtime_mark_last_busy to apds9960_set_power_state
>> function.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> Hi Matt,
>
> Could you elaborate on what the result of this not being there is?
> My first thought is that this probably wants to go as a fix, but for
> that I need details of what the effects of the 'bug' are.

Unless pm_runtime_mark_last_busy is called the
pm_runtime_put_autosuspend may put the device into suspend before the
delay time requested.


Thanks,

Matt


>
> Jonathan
>> ---
>>  drivers/iio/light/apds9960.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
>> index 7d269ef..f6a07dc 100644
>> --- a/drivers/iio/light/apds9960.c
>> +++ b/drivers/iio/light/apds9960.c
>> @@ -453,6 +453,7 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
>>                       usleep_range(data->als_adc_int_us,
>>                                    APDS9960_MAX_INT_TIME_IN_US);
>>       } else {
>> +             pm_runtime_mark_last_busy(dev);
>>               ret = pm_runtime_put_autosuspend(dev);
>>       }
>>
>>
>
