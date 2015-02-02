Return-Path: <lars@metafoo.de>
Message-ID: <54CFB84C.7090503@metafoo.de>
Date: Mon, 02 Feb 2015 18:47:56 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>
CC: Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: ad5686: fix optional reference voltage declaration
References: <54CFA1E7.4020907@bytesatwork.ch>
In-Reply-To: <54CFA1E7.4020907@bytesatwork.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/02/2015 05:12 PM, Urs Fässler wrote:
> When not using the "_optional" function, a dummy regulator is returned
> and the driver fails to initialize.
>
> Signed-off-by: Urs Fässler <urs.fassler@bytesatwork.ch>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

Added Jonathan to Cc.
