Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:35131 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758394Ab3D2SZV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Apr 2013 14:25:21 -0400
Message-ID: <517EBBAA.3040503@metafoo.de>
Date: Mon, 29 Apr 2013 20:27:54 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 1/2] adc: exynos_adc: Convert to devm_ioremap_resource()
References: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org> <CAK9yfHxht4L38absFAbDkX2=ort5HV7W=Q2uU2BbncQhXJ4T_Q@mail.gmail.com> <516BDA77.5060402@jic23.retrosnub.co.uk> <CAK9yfHz-m3ZUvNuYYcfjCGksTPXK=m2t40qVJbfxdEaPst9OiQ@mail.gmail.com>
In-Reply-To: <CAK9yfHz-m3ZUvNuYYcfjCGksTPXK=m2t40qVJbfxdEaPst9OiQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/29/2013 07:18 PM, Sachin Kamat wrote:
> Hi Jonathan,
> 
> On 15 April 2013 16:16, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
>> On 15/04/13 09:22, Sachin Kamat wrote:
>>>
>>> On 3 April 2013 11:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>>
>>>> Use the newly introduced devm_ioremap_resource() instead of
>>>> devm_request_and_ioremap() which provides more consistent error handling.
>>>>
>>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>
>> Not sure why I missed this one.  I think I marked the entire thread
>> as not ready based on the responses to patch 2.  Clearly nothing wrong
>> with this one!  Will pick up for the next cycle now as I think it
>> is a cleanup rather than an actual bug fix?
>>
>> Thanks for the ping.
> 
> Looks like this patch has still not made it to your tree as I did not
> find it in Greg's pull request to Linus.
> I however saw two of my other iio patches in his pull request.

The IIO tree was already closed at that point, so "next cycle" refers to 3.11
in this case.

- Lars
