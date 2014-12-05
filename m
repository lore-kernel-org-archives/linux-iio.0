Return-Path: <k.wrona@samsung.com>
Message-id: <548211FC.2050901@samsung.com>
Date: Fri, 05 Dec 2014 21:13:48 +0100
From: Karol Wrona <k.wrona@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [PATCH v3 0/5] iio: common: ssp_sensors: Add sensorhub driver
References: <1417809290-9662-1-git-send-email-k.wrona@samsung.com>
In-reply-to: <1417809290-9662-1-git-send-email-k.wrona@samsung.com>
Content-type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/05/2014 08:54 PM, Karol Wrona wrote:
> This patchset adds support for sensorhub. It is an external mcu which
> manages and collects data from several sensors i.e. on Galaxy Gear 2 watch.
>
> It contains:
> - spi driver for sensorhub device
> - DT binding for the device
> - IIO common utils for ssp sensors (iio kfifo setup helpers, pre/post callbacks)
> - IIO accelerometer driver
> - IIO gyroscope driver
>
> For now the driver supports "traditional" sensors but new ones types are
> intended to be used.
>
>>>From v1:
>    - Adopted to new stm32fwu v5
>    - Fixed sensors' data process callbacks
>    - Fixed comments style
>
>>>From v2:
>    - Fixes after Hartmut Knaack review
>    - Sensorhub driver was moved from misc to iio after the discussion with Arnd
>      and Jonathan
>    - Firmware upgrade is not supported in this patchset. I hope it will be
>      applied when it will find its own place in the tree.

I noticed that I left "Change-Id". I will fix it and resend after review.
