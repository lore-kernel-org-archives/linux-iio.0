Return-Path: <SRS0=p/Q3=IB=electromag.com.au=rtresidd@kernel.org>
Subject: Re: [PATCH v4 1/1] iio: accell: mma8452: Reduce sleep time when data
 not ready
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
References: <1526028899-4995-1-git-send-email-rtresidd@electromag.com.au>
 <20180512121257.392d3685@archlinux>
From: Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <b407caab-6d9b-0cbf-d741-0f64d3e48689@electromag.com.au>
Date: Mon, 14 May 2018 09:53:59 +0800
MIME-Version: 1.0
In-Reply-To: <20180512121257.392d3685@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Thanks Jonathan

On 12/05/2018 7:12 PM, Jonathan Cameron wrote:

> On Fri, 11 May 2018 16:54:59 +0800
> Richard Tresidder <rtresidd@electromag.com.au> wrote:
>
>> Modified the sleep method when data is not ready to allow for sampling > 50sps to work.
>>
>> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.
>
> Thanks,
>
> Jonathan
>
