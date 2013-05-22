Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39013 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071Ab3EVVTp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 17:19:45 -0400
Message-ID: <519D366C.6050209@kernel.org>
Date: Wed, 22 May 2013 22:19:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] adc: exynos_adc: Convert to devm_ioremap_resource()
References: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org> <CAK9yfHxht4L38absFAbDkX2=ort5HV7W=Q2uU2BbncQhXJ4T_Q@mail.gmail.com> <516BDA77.5060402@jic23.retrosnub.co.uk> <CAK9yfHz-m3ZUvNuYYcfjCGksTPXK=m2t40qVJbfxdEaPst9OiQ@mail.gmail.com> <517EBBAA.3040503@metafoo.de> <CAK9yfHxwk77Otgu1FOu5eUAMpvNN8pVtK7UvxJ0BKLD3i2A_Gw@mail.gmail.com>
In-Reply-To: <CAK9yfHxwk77Otgu1FOu5eUAMpvNN8pVtK7UvxJ0BKLD3i2A_Gw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/30/2013 03:59 AM, Sachin Kamat wrote:
> On 29 April 2013 23:57, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 04/29/2013 07:18 PM, Sachin Kamat wrote:
>>> Hi Jonathan,
>>>
>>> On 15 April 2013 16:16, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
>>>> On 15/04/13 09:22, Sachin Kamat wrote:
>>>>>
>>>>> On 3 April 2013 11:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>>>>
>>>>>> Use the newly introduced devm_ioremap_resource() instead of
>>>>>> devm_request_and_ioremap() which provides more consistent error handling.
>>>>>>
>>>>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>>>
>>>> Not sure why I missed this one.  I think I marked the entire thread
>>>> as not ready based on the responses to patch 2.  Clearly nothing wrong
>>>> with this one!  Will pick up for the next cycle now as I think it
>>>> is a cleanup rather than an actual bug fix?
>>>>
>>>> Thanks for the ping.
>>>
>>> Looks like this patch has still not made it to your tree as I did not
>>> find it in Greg's pull request to Linus.
>>> I however saw two of my other iio patches in his pull request.
>>
>> The IIO tree was already closed at that point, so "next cycle" refers to 3.11
>> in this case.
> 
> Oh OK. Got it :)
> Thanks for the clarification.
> 
Now finally applied to the togreg branch of iio.git.
Will hopefully send upstream sometime over next few days at which point it will hit
linux-next and be ready for the next merge cycle.

Jonathan
