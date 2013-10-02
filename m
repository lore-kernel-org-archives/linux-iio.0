Return-Path: <lars@metafoo.de>
Message-ID: <524C55A0.30008@metafoo.de>
Date: Wed, 02 Oct 2013 19:19:28 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: core: Implement devm_iio_device_{register,unregister}
References: <1380256624-12588-1-git-send-email-sachin.kamat@linaro.org> <CAK9yfHx2dK1KSTQXoCtbhPaA9jYkyoC3_3NggAMio1TpPiY+9A@mail.gmail.com>
In-Reply-To: <CAK9yfHx2dK1KSTQXoCtbhPaA9jYkyoC3_3NggAMio1TpPiY+9A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/02/2013 06:54 PM, Sachin Kamat wrote:
> Hi,
> 
> On 27 September 2013 10:07, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Add device managed devm_iio_device_{register,unregister}()
>> to automatically unregister IIO drivers thus leading to
>> simplified IIO driver code.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>> Changes since v1:
>> Incorporated review comments from Lars-Peter Clausen
>> * Renamed variables
>> * Fixed the broken implementation
>> * Moved kernel doc from .h to .c file
>> ---
> 
> Does this look good now?
> 

Yes, but I want to at least test it once before I ack it.
