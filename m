Return-Path: <acourbot@nvidia.com>
Message-ID: <54E43F3A.700@nvidia.com>
Date: Wed, 18 Feb 2015 16:28:58 +0900
From: Alexandre Courbot <acourbot@nvidia.com>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Linus
 Walleij" <linus.walleij@linaro.org>, <kernel@pengutronix.de>, Mark Brown
	<broonie@linaro.org>
Subject: Re: [PATCH] iio: improve usage of gpiod API
References: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de> <54E3E61A.3040006@nvidia.com> <20150218071523.GH19388@pengutronix.de> <54E43D9E.9040008@nvidia.com> <20150218072550.GI19388@pengutronix.de>
In-Reply-To: <20150218072550.GI19388@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/18/2015 04:25 PM, Uwe Kleine-K=F6nig wrote:
> Hello Alexandre,
>
> On Wed, Feb 18, 2015 at 04:22:06PM +0900, Alexandre Courbot wrote:
>> On 02/18/2015 04:15 PM, Uwe Kleine-K=F6nig wrote:
>>> On Wed, Feb 18, 2015 at 10:08:42AM +0900, Alexandre Courbot wrote:
>>>> On 02/17/2015 06:21 PM, Uwe Kleine-K=F6nig wrote:
>>>>> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() function=
s)
>>>>> which appeared in v3.17-rc1, the gpiod_get* functions take an additio=
nal
>>>>> parameter that allows to specify direction and initial value for
>>>>> outputs.
>>>>>
>>>>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>>>>
>>>> Nice, thanks for taking the time to do this!
>>> I have some more, just didn't come around to wrap in commits and send
>>> out:
>>>
>>> 	http://git.pengutronix.de/?p=3Dukl/linux.git;a=3Dcommitdiff;h=3D1783b1=
7ba922f92d043bad650c0209de1c201080;hp=3De36f014edff70fc02b3d3d79cead1d58f28=
9332e
>>>
>>> I will do one patch a day ...
>>
>> That's great - do these cover all the uses of gpiod_get* that need
>> to be updated? If so, you could close this series with a final patch
>> that removes the macro definitions allowing variable arguments.
> That's
> http://git.pengutronix.de/?p=3Dukl/linux.git;a=3Dcommitdiff;h=3Dbc10c1078=
5a883133762280f9878d89f2e14ffc6;hp=3D474ad70e111489255eb622947d3a0a949680ed=
55
> :-)

Joy. :)
