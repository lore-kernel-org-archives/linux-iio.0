Return-Path: <lars@metafoo.de>
Message-ID: <5264E86C.4090303@metafoo.de>
Date: Mon, 21 Oct 2013 10:40:12 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: core: Implement devm_iio_device_{register,unregister}
References: <1380256624-12588-1-git-send-email-sachin.kamat@linaro.org> <CAK9yfHx2dK1KSTQXoCtbhPaA9jYkyoC3_3NggAMio1TpPiY+9A@mail.gmail.com> <524C55A0.30008@metafoo.de> <CAK9yfHybAm3WXj=M13DmJ78S94APWaG9JTRas6ey4_1H9nTOxw@mail.gmail.com>
In-Reply-To: <CAK9yfHybAm3WXj=M13DmJ78S94APWaG9JTRas6ey4_1H9nTOxw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/21/2013 10:18 AM, Sachin Kamat wrote:
> Hi Lars,
> 
> On 2 October 2013 22:49, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 10/02/2013 06:54 PM, Sachin Kamat wrote:
>>> Hi,
>>>
>>> On 27 September 2013 10:07, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>> Add device managed devm_iio_device_{register,unregister}()
>>>> to automatically unregister IIO drivers thus leading to
>>>> simplified IIO driver code.
>>>>
>>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>>>> ---
>>>> Changes since v1:
>>>> Incorporated review comments from Lars-Peter Clausen
>>>> * Renamed variables
>>>> * Fixed the broken implementation
>>>> * Moved kernel doc from .h to .c file
>>>> ---
>>>
>>> Does this look good now?
>>>
>>
>> Yes, but I want to at least test it once before I ack it.
> 
> Any luck with testing this?
> 

Sorry, this somehow fell of the table, between a lot of travailing and an
upcoming release. I'm at a conference this week to, but I'll give it a try
first thing Monday morning.

- Lars
