Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Karol Wrona <k.wrona@samsung.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2 1/5] misc: sensorhub: Add sensorhub driver
Date: Mon, 24 Nov 2014 13:35:55 +0100
Message-ID: <5942877.97OQIAaJx7@wuerfel>
In-Reply-To: <547318E0.8070407@samsung.com>
References: <1416593957-19788-1-git-send-email-k.wrona@samsung.com> <54707ECA.7090800@kernel.org> <547318E0.8070407@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Monday 24 November 2014 12:39:12 Karol Wrona wrote:
> It is possible that it can serve as input device sth else. So you are
> right about MFD.
> 
> The structure of mfd directory is flat. I wonder what can be better:
> just putting these sources inside mfd dir or to some new category inside mfd.
> Generally sensorhub will not differ than others mfd devs but in the near future 
> it can be that we end up with different (sensor)hubs or in my case with one core 
> driver with several interfaces, mcu's modes - sth like ssp-i2c.c etc.
> These drivers can grow in size as these devices will appear in different boards.

You should be able to abstract the interface differences using regmap for the
most part, so there would only be a small stub that is i2c or spi specific,
and a lot of mfd drivers have that.

> Also there is a question where firmware loader (stm32fwu) should be placed as it 
> is a library?

Can you describe what this library does? Is this for loading firmware into
device RAM or into flash? Does it always use USB?

	Arnd
