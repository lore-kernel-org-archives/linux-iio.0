Return-Path: <jic23@kernel.org>
Message-ID: <502D4271.9080104@kernel.org>
Date: Thu, 16 Aug 2012 19:56:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Kim, Milo" <Milo.Kim@ti.com>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: add iio_read_channel_offset() consumer api
References: <A874F61F95741C4A9BA573A70FE3998F41EEFD6E@DQHE02.ent.ti.com> <alpine.DEB.2.01.1208160940380.3550@pmeerw.net> <A874F61F95741C4A9BA573A70FE3998F41EEFDA0@DQHE02.ent.ti.com>
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F41EEFDA0@DQHE02.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/16/2012 08:49 AM, Kim, Milo wrote:
>>>  int iio_read_channel_scale(struct iio_channel *chan, int *val,
>>>  			   int *val2);
>>>
>>> +/**
>>> + * iio_read_channel_offset() - read offset from a given channel
>>> + * @channel:		The channel being queried.
>>
>> the parameter is 'chan', not 'channel'
>>
> 
> Oops, this is copy-and-paste disaster.
> The description of iio_read_channel_scale() also needs correction.
> Thanks for catching this !
good point.  Feel free to send a separate patch fixing that ;)
> 
> After getting other feedbacks, separate patch will be submitted.
> 
> Best Regards,
> Milo
> 
