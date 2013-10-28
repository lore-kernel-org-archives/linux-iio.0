Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <526E2EF8.9090005@metafoo.de>
References: <1380256624-12588-1-git-send-email-sachin.kamat@linaro.org>
	<526E2EF8.9090005@metafoo.de>
Date: Mon, 28 Oct 2013 15:13:24 +0530
Message-ID: <CAK9yfHy1rPomhe6fsCXLpLaQq_YA2cKevxMePNXfgVWP9vrRsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: core: Implement devm_iio_device_{register,unregister}
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 28 October 2013 15:01, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/27/2013 06:37 AM, Sachin Kamat wrote:
>> Add device managed devm_iio_device_{register,unregister}()
>> to automatically unregister IIO drivers thus leading to
>> simplified IIO driver code.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>
> Tested-by: Lars-Peter Clausen <lars@metafoo.de>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Thank you Lars.

-- 
With warm regards,
Sachin
