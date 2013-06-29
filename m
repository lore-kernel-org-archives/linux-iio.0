Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41871 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab3F2Jrg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 05:47:36 -0400
Message-ID: <51CEAD36.4070503@kernel.org>
Date: Sat, 29 Jun 2013 10:47:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Wei Yongjun <weiyj.lk@gmail.com>, yongjun_wei@trendmicro.com.cn,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: dac: ad7303: fix error return code in ad7303_probe()
References: <CAPgLHd_7GTkOavGHctmaODV-gQBjRi5aiUF7+BR-FRnP8eCa7w@mail.gmail.com> <51C57E98.5020409@kernel.org> <51C5A6F0.80505@metafoo.de> <51C5ADF8.8060206@kernel.org>
In-Reply-To: <51C5ADF8.8060206@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/22/2013 03:00 PM, Jonathan Cameron wrote:
> On 06/22/2013 02:30 PM, Lars-Peter Clausen wrote:
>> On 06/22/2013 12:38 PM, Jonathan Cameron wrote:
>>> On 06/18/2013 02:08 PM, Wei Yongjun wrote:
>>>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>>>
>>>> Fix to return a negative error code from the error handling
>>>> case instead of 0, as done elsewhere in this function.
>>>>
>>>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>> This one looks pretty obvious so I'll take it without waiting
>>> for any other comments.
>>>
>>> Applied to togreg branch of iio.git
>>>
>>> Thanks,
>>
>>
>> hm, I actually though I'd acked this patch, but looks like the mail didn't make
>> it through.
>>
>> - Lars
>>
> Added an ack as I hadn't pushed out to a public tree yet anyway.
Just for reference, the timing is such that I've moved this to the fixes-togreg
branch as from the IIO point of view we have now entered the next cycle.

Jonathan
