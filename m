Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39738 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcFSTqZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2016 15:46:25 -0400
Subject: Re: [PATCH 1/1] iio: fix config watermark initial value
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	laurentiu.palcu@intel.com
References: <1458810585-24555-1-git-send-email-irina.tirdea@intel.com>
 <56F3B217.8040206@metafoo.de> <56F90127.4000807@kernel.org>
 <CAEnQRZDhotQ2itD4wyhVd4Jf3XoZ8xpMpwV1owaFzNnPUFSSow@mail.gmail.com>
 <825785FF-441B-45D3-A4E5-469F85ABBB19@jic23.retrosnub.co.uk>
 <5762D174.4050401@metafoo.de>
Cc: Irina Tirdea <irina.tirdea@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a412e97b-ee76-2370-7bb2-5290c2007897@kernel.org>
Date: Sun, 19 Jun 2016 20:46:21 +0100
MIME-Version: 1.0
In-Reply-To: <5762D174.4050401@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/06/16 17:19, Lars-Peter Clausen wrote:
> On 06/16/2016 06:16 PM, Jonathan Cameron wrote:
>>
>>
>> On 16 June 2016 12:56:11 BST, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>>> On Mon, Mar 28, 2016 at 1:02 PM, Jonathan Cameron <jic23@kernel.org>
>>> wrote:
>>>> On 24/03/16 09:23, Lars-Peter Clausen wrote:
>>>>> On 03/24/2016 10:09 AM, Irina Tirdea wrote:
>>>>>> config structure is set to 0 when updating the buffers, so by
>>>>>> default config->watermark will be 0. When computing the minimum
>>>>>> between config->watermark and the buffer->watermark or
>>>>>> insert_buffer-watermark, this will always be 0 regardless of the
>>>>>> value set by the user for the buffer.
>>>>>>
>>>>>> Set as initial value for config->watermark the maximum allowed
>>>>>> value so that the minimum value will always be set from one of the
>>>>>> buffers.
>>>>>>
>>>>>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
>>>>>
>>>>> Looks good. This bug was my fault, sorry.
>>>>>
>>>>> Fixes: f0566c0c405d ("iio: Set device watermark based on watermark
>>> of all
>>>>> attached buffers")
>>>> Applied to the fixes-togreg-post-rc1 branch of iio.git and marked for
>>> stable.
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>>>>
>>>>>> ---
>>>>>>  drivers/iio/industrialio-buffer.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/iio/industrialio-buffer.c
>>> b/drivers/iio/industrialio-buffer.c
>>>>>> index b976332..90462fc 100644
>>>>>> --- a/drivers/iio/industrialio-buffer.c
>>>>>> +++ b/drivers/iio/industrialio-buffer.c
>>>>>> @@ -653,6 +653,7 @@ static int iio_verify_update(struct iio_dev
>>> *indio_dev,
>>>>>>      unsigned int modes;
>>>>>>
>>>>>>      memset(config, 0, sizeof(*config));
>>>>>> +    config->watermark = ~0;
>>>>>>
>>>>>>      /*
>>>>>>       * If there is just one buffer and we are removing it there is
>>> nothing
>>>>>>
>>>>>
>>>>
>>>> --
>>>
>>>
>>> Hi Jonathan,
>>>
>>> After a discussion with Laurentiu (Cc'ed), we noticed that this patch
>>> is not in the latest IIO (testing, togreg) tree.
>>>
>>> What is the path of an IIO fixes patch?
>>>
>>> thanks,
>>> Daniel.
>> Should be fixes-togreg then staging-linus then mainline.
> 
> To add to that once it is in mainline it will trickle down again through
> staging/next to iio/togreg. So there might be a fair amount of pipeline
> delay until it arrives in iio/{togreg,testing}.
> 
It's now in staging-next which is the upstream for togreg.
I've been a bit snowed under this week so it might be a little while yet
before I get my next pull request out to Greg and then do a fast
forward merge which will pull that change in.

Thanks,

Jonathan
