Return-Path: <lars@metafoo.de>
Message-ID: <5044DD49.1060703@metafoo.de>
Date: Mon, 03 Sep 2012 18:39:37 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 drivers@analog.com
Subject: Re: [PATCH 07/22] staging:iio:ad7793: Remove unused platform_data
 from device state struct
References: <1344616596-8026-1-git-send-email-lars@metafoo.de> <1344616596-8026-7-git-send-email-lars@metafoo.de> <502AA96C.3090105@kernel.org> <502B6688.6000904@metafoo.de>
In-Reply-To: <502B6688.6000904@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/15/2012 11:06 AM, Lars-Peter Clausen wrote:
> On 08/14/2012 09:39 PM, Jonathan Cameron wrote:
>> On 08/10/2012 05:36 PM, Lars-Peter Clausen wrote:
>>> The platform data for the device is only used from within the drivers probe
>>> callback, so there is no need to keep it around in the devices state struct.
>>>
>>> While we are at it mark the platform data struct as const.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>>  drivers/staging/iio/adc/ad7793.c |   14 ++++++--------
>>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
>>> index 112e2b7..0ba598e 100644
>>> --- a/drivers/staging/iio/adc/ad7793.c
>>> +++ b/drivers/staging/iio/adc/ad7793.c
>>> @@ -44,7 +44,6 @@ struct ad7793_state {
>>>  	struct iio_trigger		*trig;
>>>  	const struct ad7793_chip_info	*chip_info;
>>>  	struct regulator		*reg;
>>> -	struct ad7793_platform_data	*pdata;
>>>  	wait_queue_head_t		wq_data_avail;
>>>  	bool				done;
>>>  	bool				irq_dis;
>>> @@ -253,7 +252,8 @@ out:
>>>  	return ret;
>>>  }
>>>  
>>> -static int ad7793_setup(struct ad7793_state *st)
>>> +static int ad7793_setup(struct ad7793_state *st
>>> +	const struct ad7793_platform_data *pdata)
>> Really odd.  There's a missing comma between the arguments here...
>> I'll fixup.
> 
> I think this happened during a rebase and I never spotted it because it was
> fixed up in a later commit. Reminds me to run a built tests on each individual
> patch and not just the whole series together.

Ok, to avoid such mistakes in the future I've come up with the following one
liner shell script. I though it might be worth sharing in case others find
this useful as well.

#!/bin/sh
EDITOR="sed -i 's/^\(pick .*\)$/\1\nexec make/'" git rebase -p -i $1


Pass it a commit id and it will run `make` for each commit in the range of
the passed commit up to HEAD. If make fails it will stop at the current commit.

E.g.

`./git-compiletest HEAD~10`

- Lars
