Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <516BDA77.5060402@jic23.retrosnub.co.uk>
References: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org>
	<CAK9yfHxht4L38absFAbDkX2=ort5HV7W=Q2uU2BbncQhXJ4T_Q@mail.gmail.com>
	<516BDA77.5060402@jic23.retrosnub.co.uk>
Date: Mon, 15 Apr 2013 16:37:24 +0530
Message-ID: <CAK9yfHxuBJ1DcNv9tDes7Hfz-W=rruWZX=H2YV_Kg8tO4xVEbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] adc: exynos_adc: Convert to devm_ioremap_resource()
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 15 April 2013 16:16, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> On 15/04/13 09:22, Sachin Kamat wrote:
>>
>> On 3 April 2013 11:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>
>>> Use the newly introduced devm_ioremap_resource() instead of
>>> devm_request_and_ioremap() which provides more consistent error handling.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Not sure why I missed this one.  I think I marked the entire thread
> as not ready based on the responses to patch 2.  Clearly nothing wrong
> with this one!  Will pick up for the next cycle now as I think it
> is a cleanup rather than an actual bug fix?

Yes this is a cleanup and hence can go in for 3.10-rc. Thanks.


-- 
With warm regards,
Sachin
