Return-Path: <SRS0=KVi0=4B=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] iio: inkern: fix a static checker error
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1492722117-19618-1-git-send-email-peda@axentia.se>
 <9b2138e1-11a1-a923-4c9c-7091b3e54f99@metafoo.de>
 <7b6ad5b7-a538-9007-8981-f36f9877a8e3@axentia.se>
 <60934fcd-214e-3618-84ff-46484197e737@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <79712dbc-a367-7acc-dd6e-5e3892913e36@metafoo.de>
Date: Tue, 25 Apr 2017 18:01:39 +0200
MIME-Version: 1.0
In-Reply-To: <60934fcd-214e-3618-84ff-46484197e737@axentia.se>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/24/2017 11:32 AM, Peter Rosin wrote:
> On 2017-04-20 23:13, Peter Rosin wrote:
>> On 2017-04-20 23:12, Lars-Peter Clausen wrote:
>>> On 04/20/2017 11:01 PM, Peter Rosin wrote:
>>>> Avoid this smatch error:
>>>> drivers/iio/inkern.c:751 iio_read_avail_channel_raw() error: double unlock 'mutex:&chan->indio_dev->info_exist_lock'
>>>
>>> Looks good, but it's not just the smatch error, this is a real issue. This
>>> even seems to be a endless loop, always jumping back to err_unlock.
>>
>> Yes, it should probably go to stable too...
> 
> Nope, not an endless loop, but I of course only noticed after sending
> a v2 [1] which falsely stated just that. Ignore that v2 patch and take
> this one instead, for the reasons stated in my followup [2] to that
> message.
> 
> Involving stable is probably not needed either...

Right, my fault for sending you the wrong way. Sorry for that.
