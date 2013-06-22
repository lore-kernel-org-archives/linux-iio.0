Return-Path: <lars@metafoo.de>
Message-ID: <51C5A6F0.80505@metafoo.de>
Date: Sat, 22 Jun 2013 15:30:24 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Wei Yongjun <weiyj.lk@gmail.com>, yongjun_wei@trendmicro.com.cn,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: dac: ad7303: fix error return code in ad7303_probe()
References: <CAPgLHd_7GTkOavGHctmaODV-gQBjRi5aiUF7+BR-FRnP8eCa7w@mail.gmail.com> <51C57E98.5020409@kernel.org>
In-Reply-To: <51C57E98.5020409@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/22/2013 12:38 PM, Jonathan Cameron wrote:
> On 06/18/2013 02:08 PM, Wei Yongjun wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> Fix to return a negative error code from the error handling
>> case instead of 0, as done elsewhere in this function.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> This one looks pretty obvious so I'll take it without waiting
> for any other comments.
> 
> Applied to togreg branch of iio.git
> 
> Thanks,


hm, I actually though I'd acked this patch, but looks like the mail didn't make
it through.

- Lars
