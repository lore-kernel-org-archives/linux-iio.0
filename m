Return-Path: <SRS0=/R0c=4B=axentia.se=peda@kernel.org>
Subject: Re: [PATCH] iio: inkern: fix a static checker error
To: Lars-Peter Clausen <lars@metafoo.de>, <linux-kernel@vger.kernel.org>
References: <1492722117-19618-1-git-send-email-peda@axentia.se>
 <9b2138e1-11a1-a923-4c9c-7091b3e54f99@metafoo.de>
 <7b6ad5b7-a538-9007-8981-f36f9877a8e3@axentia.se>
 <60934fcd-214e-3618-84ff-46484197e737@axentia.se>
 <79712dbc-a367-7acc-dd6e-5e3892913e36@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <34d62036-3681-0e8d-398e-bdc867ae8377@axentia.se>
Date: Tue, 25 Apr 2017 19:11:25 +0200
MIME-Version: 1.0
In-Reply-To: <79712dbc-a367-7acc-dd6e-5e3892913e36@metafoo.de>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2017-04-25 18:01, Lars-Peter Clausen wrote:
> On 04/24/2017 11:32 AM, Peter Rosin wrote:
>> On 2017-04-20 23:13, Peter Rosin wrote:
>>> On 2017-04-20 23:12, Lars-Peter Clausen wrote:
>>>> On 04/20/2017 11:01 PM, Peter Rosin wrote:
>>>>> Avoid this smatch error:
>>>>> drivers/iio/inkern.c:751 iio_read_avail_channel_raw() error: double unlock 'mutex:&chan->indio_dev->info_exist_lock'
>>>>
>>>> Looks good, but it's not just the smatch error, this is a real issue. This
>>>> even seems to be a endless loop, always jumping back to err_unlock.
>>>
>>> Yes, it should probably go to stable too...
>>
>> Nope, not an endless loop, but I of course only noticed after sending
>> a v2 [1] which falsely stated just that. Ignore that v2 patch and take
>> this one instead, for the reasons stated in my followup [2] to that
>> message.
>>
>> Involving stable is probably not needed either...
> 
> Right, my fault for sending you the wrong way. Sorry for that.

No no, don't worry, I was already down that path without your help.

I just thought everybody would see the obvious bug and the urgency
when it was pointed out to them with a patch. Like you did. And I
was in a hurry for it to have a slim chance of getting in before
4.12 (but then -rc8 happened instead) so didn't spend a lot of time
crafting a thorough commit message (nor analyzing the problem, but
why would I when I had a very clear picture of an endless loop on
error?). But in the end it wasn't really that obvious, was it? And
not that urgent either. Stupid damn bug...

Cheers,
peda
