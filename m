Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <524C55A0.30008@metafoo.de>
References: <1380256624-12588-1-git-send-email-sachin.kamat@linaro.org>
	<CAK9yfHx2dK1KSTQXoCtbhPaA9jYkyoC3_3NggAMio1TpPiY+9A@mail.gmail.com>
	<524C55A0.30008@metafoo.de>
Date: Thu, 3 Oct 2013 22:23:58 +0530
Message-ID: <CAK9yfHzOo-7RgXcuwpcBckAiifkJ4DenTsjgT6E53jxOBD+LSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: core: Implement devm_iio_device_{register,unregister}
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 2 October 2013 22:49, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/02/2013 06:54 PM, Sachin Kamat wrote:
>> Hi,
>>
>> On 27 September 2013 10:07, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>> Add device managed devm_iio_device_{register,unregister}()
>>> to automatically unregister IIO drivers thus leading to
>>> simplified IIO driver code.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>> Changes since v1:
>>> Incorporated review comments from Lars-Peter Clausen
>>> * Renamed variables
>>> * Fixed the broken implementation
>>> * Moved kernel doc from .h to .c file
>>> ---
>>
>> Does this look good now?
>>
>
> Yes, but I want to at least test it once before I ack it.

 Sure. Looking forward to hear back after your testing.

-- 
With warm regards,
Sachin
