Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:35170 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbBRJzw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 04:55:52 -0500
Received: by wesp10 with SMTP id p10so87509wes.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2015 01:55:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150218072550.GI19388@pengutronix.de>
References: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<54E3E61A.3040006@nvidia.com>
	<20150218071523.GH19388@pengutronix.de>
	<54E43D9E.9040008@nvidia.com>
	<20150218072550.GI19388@pengutronix.de>
Date: Wed, 18 Feb 2015 11:55:51 +0200
Message-ID: <CAEnQRZAPOnhMvCei7AD8k-bz1ghC+2q6GrTEvKKJ-=6GXCaAGQ@mail.gmail.com>
Subject: Re: [PATCH] iio: improve usage of gpiod API
From: Daniel Baluta <daniel.baluta@intel.com>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	kernel@pengutronix.de, Mark Brown <broonie@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 18, 2015 at 9:25 AM, Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Alexandre,
>
> On Wed, Feb 18, 2015 at 04:22:06PM +0900, Alexandre Courbot wrote:
>> On 02/18/2015 04:15 PM, Uwe Kleine-König wrote:
>> >On Wed, Feb 18, 2015 at 10:08:42AM +0900, Alexandre Courbot wrote:
>> >>On 02/17/2015 06:21 PM, Uwe Kleine-König wrote:
>> >>>Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
>> >>>which appeared in v3.17-rc1, the gpiod_get* functions take an additional
>> >>>parameter that allows to specify direction and initial value for
>> >>>outputs.
>> >>>
>> >>>Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> >>
>> >>Nice, thanks for taking the time to do this!
>> >I have some more, just didn't come around to wrap in commits and send
>> >out:
>> >
>> >     http://git.pengutronix.de/?p=ukl/linux.git;a=commitdiff;h=1783b17ba922f92d043bad650c0209de1c201080;hp=e36f014edff70fc02b3d3d79cead1d58f289332e
>> >
>> >I will do one patch a day ...
>>
>> That's great - do these cover all the uses of gpiod_get* that need
>> to be updated? If so, you could close this series with a final patch
>> that removes the macro definitions allowing variable arguments.
> That's
> http://git.pengutronix.de/?p=ukl/linux.git;a=commitdiff;h=bc10c10785a883133762280f9878d89f2e14ffc6;hp=474ad70e111489255eb622947d3a0a949680ed55


Hi Uwe,

Please make sure you also fix this:

$ ack-grep devm_gpiod_get_index
imu/kmx61.c
1270: gpio = devm_gpiod_get_index(dev, KMX61_GPIO_NAME, 0);

accel/mma9551.c
421: gpio = devm_gpiod_get_index(dev, MMA9551_GPIO_NAME, i);

proximity/sx9500.c
621: gpio = devm_gpiod_get_index(dev, SX9500_GPIO_NAME, 0);

thanks,
Daniel.
