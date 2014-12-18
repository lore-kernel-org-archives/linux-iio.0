Return-Path: <lars@metafoo.de>
Message-ID: <54930250.1050400@metafoo.de>
Date: Thu, 18 Dec 2014 17:35:28 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/11] iio: buffer: Make length attribute read only for
 buffers without set_length
References: <1417024517-7564-1-git-send-email-lars@metafoo.de> <1417024517-7564-11-git-send-email-lars@metafoo.de> <548ACCA7.7080706@kernel.org> <548ACD6B.30608@kernel.org>
In-Reply-To: <548ACD6B.30608@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/12/2014 12:11 PM, Jonathan Cameron wrote:
> On 12/12/14 11:08, Jonathan Cameron wrote:
>> On 26/11/14 17:55, Lars-Peter Clausen wrote:
>>> If a buffer implementation does not implement the set_length() callback the
>>> length will be static and can not be changed by userspace. Mark the length
>>> attribute as a read only property in this case so userspace is aware of this
>>> rather than just silently accepting any length value.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Nice little change.
>>
> Having said that I doubt that longterm this will apply to many devices
> as we'll be routing more and more hardware buffers through a software
> front end and that front end will be variable size...

We'll probably have something like a buffer_index field in channel struct.

>
> Anyhow, applied to the togreg branch of iio.git with fuzz etc
> from my earlier patch tweaking.

Thanks.
