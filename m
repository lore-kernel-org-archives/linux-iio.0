Return-Path: <jic23@hermes.cam.ac.uk>
Message-ID: <502CB031.3040808@jic23.retrosnub.co.uk>
Date: Thu, 16 Aug 2012 09:32:49 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "Kim, Milo" <Milo.Kim@ti.com>, Jonathan Cameron <jic23@kernel.org>,
 "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: add iio_read_channel_offset() consumer api
References: <A874F61F95741C4A9BA573A70FE3998F41EEFD6E@DQHE02.ent.ti.com> <502CACFF.3000105@metafoo.de>
In-Reply-To: <502CACFF.3000105@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On 16/08/12 09:19, Lars-Peter Clausen wrote:
> On 08/16/2012 09:39 AM, Kim, Milo wrote:
>> This allows the iio consumer to get the offset of the channel.
>> The value of offset can be used when calculating the result such
>> as 'result = raw * scale + offset'.
> result = (raw + offset) * scale
>
> Otherwise it looks good, except for:
>
>> +/**
>> + * iio_read_channel_offset() - read offset from a given channel
>> + * @channel:		The channel being queried.
>> + * @val:		Offset Value read back.
>> + *
>> + * Note offset can be used in the consumer when calculating the result
>> + * such as 'result = raw * scale + offset'.
>> + */
> The documentation should go in the c file.
I've often wondered about this myself.  Looking quickly about it does
appear that it is more popular to do it in c file...  Guess I've been wrong
for quite some time.  For now it's probably better to keep this docs
in the header and do the move all in one go given all the other docs
are here in this header.

I can see the arguments either way, but have not as yet seen anyone
stamp their foot on what is the 'one true way'.

>
>> +int iio_read_channel_offset(struct iio_channel *chan, int *val);
>>   #endif
