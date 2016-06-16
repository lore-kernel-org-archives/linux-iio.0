Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51832 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbcFPQQb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2016 12:16:31 -0400
In-Reply-To: <CAEnQRZDhotQ2itD4wyhVd4Jf3XoZ8xpMpwV1owaFzNnPUFSSow@mail.gmail.com>
References: <1458810585-24555-1-git-send-email-irina.tirdea@intel.com> <56F3B217.8040206@metafoo.de> <56F90127.4000807@kernel.org> <CAEnQRZDhotQ2itD4wyhVd4Jf3XoZ8xpMpwV1owaFzNnPUFSSow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/1] iio: fix config watermark initial value
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 16 Jun 2016 17:16:17 +0100
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, laurentiu.palcu@intel.com
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Irina Tirdea <irina.tirdea@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>
Message-ID: <825785FF-441B-45D3-A4E5-469F85ABBB19@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 16 June 2016 12:56:11 BST, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>On Mon, Mar 28, 2016 at 1:02 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> On 24/03/16 09:23, Lars-Peter Clausen wrote:
>>> On 03/24/2016 10:09 AM, Irina Tirdea wrote:
>>>> config structure is set to 0 when updating the buffers, so by
>>>> default config->watermark will be 0. When computing the minimum
>>>> between config->watermark and the buffer->watermark or
>>>> insert_buffer-watermark, this will always be 0 regardless of the
>>>> value set by the user for the buffer.
>>>>
>>>> Set as initial value for config->watermark the maximum allowed
>>>> value so that the minimum value will always be set from one of the
>>>> buffers.
>>>>
>>>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
>>>
>>> Looks good. This bug was my fault, sorry.
>>>
>>> Fixes: f0566c0c405d ("iio: Set device watermark based on watermark
>of all
>>> attached buffers")
>> Applied to the fixes-togreg-post-rc1 branch of iio.git and marked for
>stable.
>>
>> Thanks,
>>
>> Jonathan
>>>
>>>> ---
>>>>  drivers/iio/industrialio-buffer.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/iio/industrialio-buffer.c
>b/drivers/iio/industrialio-buffer.c
>>>> index b976332..90462fc 100644
>>>> --- a/drivers/iio/industrialio-buffer.c
>>>> +++ b/drivers/iio/industrialio-buffer.c
>>>> @@ -653,6 +653,7 @@ static int iio_verify_update(struct iio_dev
>*indio_dev,
>>>>      unsigned int modes;
>>>>
>>>>      memset(config, 0, sizeof(*config));
>>>> +    config->watermark = ~0;
>>>>
>>>>      /*
>>>>       * If there is just one buffer and we are removing it there is
>nothing
>>>>
>>>
>>
>> --
>
>
>Hi Jonathan,
>
>After a discussion with Laurentiu (Cc'ed), we noticed that this patch
>is not in the latest IIO (testing, togreg) tree.
>
>What is the path of an IIO fixes patch?
>
>thanks,
>Daniel.
Should be fixes-togreg then staging-linus then mainline.

I probably messed up. Will check.

Jonathan

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
