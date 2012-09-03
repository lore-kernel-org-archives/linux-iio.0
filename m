Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46658 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502Ab2ICUJs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Sep 2012 16:09:48 -0400
Message-ID: <50450E8A.9030103@kernel.org>
Date: Mon, 03 Sep 2012 21:09:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 07/22] staging:iio:ad7793: Remove unused platform_data
 from device state struct
References: <1344616596-8026-1-git-send-email-lars@metafoo.de> <1344616596-8026-7-git-send-email-lars@metafoo.de> <502AA96C.3090105@kernel.org> <502B6688.6000904@metafoo.de> <5044DD49.1060703@metafoo.de>
In-Reply-To: <5044DD49.1060703@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/2012 05:39 PM, Lars-Peter Clausen wrote:
> On 08/15/2012 11:06 AM, Lars-Peter Clausen wrote:
>> On 08/14/2012 09:39 PM, Jonathan Cameron wrote:
>>> On 08/10/2012 05:36 PM, Lars-Peter Clausen wrote:
>>>> The platform data for the device is only used from within the drivers probe
>>>> callback, so there is no need to keep it around in the devices state struct.
>>>>
>>>> While we are at it mark the platform data struct as const.
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> ---
>>>>  drivers/staging/iio/adc/ad7793.c |   14 ++++++--------
>>>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
>>>> index 112e2b7..0ba598e 100644
>>>> --- a/drivers/staging/iio/adc/ad7793.c
>>>> +++ b/drivers/staging/iio/adc/ad7793.c
>>>> @@ -44,7 +44,6 @@ struct ad7793_state {
>>>>  	struct iio_trigger		*trig;
>>>>  	const struct ad7793_chip_info	*chip_info;
>>>>  	struct regulator		*reg;
>>>> -	struct ad7793_platform_data	*pdata;
>>>>  	wait_queue_head_t		wq_data_avail;
>>>>  	bool				done;
>>>>  	bool				irq_dis;
>>>> @@ -253,7 +252,8 @@ out:
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -static int ad7793_setup(struct ad7793_state *st)
>>>> +static int ad7793_setup(struct ad7793_state *st
>>>> +	const struct ad7793_platform_data *pdata)
>>> Really odd.  There's a missing comma between the arguments here...
>>> I'll fixup.
>>
>> I think this happened during a rebase and I never spotted it because it was
>> fixed up in a later commit. Reminds me to run a built tests on each individual
>> patch and not just the whole series together.
> 
> Ok, to avoid such mistakes in the future I've come up with the following one
> liner shell script. I though it might be worth sharing in case others find
> this useful as well.
> 
> #!/bin/sh
> EDITOR="sed -i 's/^\(pick .*\)$/\1\nexec make/'" git rebase -p -i $1
> 
> 
> Pass it a commit id and it will run `make` for each commit in the range of
> the passed commit up to HEAD. If make fails it will stop at the current commit.
> 
> E.g.
> 
> `./git-compiletest HEAD~10`
> 
Nice little script

All but 22 of this series are now merged and pull requests sent.

Thanks,

Jonathan
