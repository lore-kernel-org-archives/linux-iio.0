Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <2730751a-3ab8-a083-6f2f-6b5b9d0acf62@kernel.org>
References: <1464162027-24612-1-git-send-email-linus.walleij@linaro.org>
 <1464162027-24612-2-git-send-email-linus.walleij@linaro.org>
 <3c1a7937-3c90-9f26-c9fe-e2ffad140e06@kernel.org> <2730751a-3ab8-a083-6f2f-6b5b9d0acf62@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 19 Jun 2016 20:04:42 +0200
Message-ID: <CACRpkdYTuJ65aTTyY7427ndYF6edJOVedGHXM_2iMjTQPf5X7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: bh1780: assign a static name
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jun 19, 2016 at 1:25 PM, Jonathan Cameron <jic23@kernel.org> wrote:

>>> Using the struct i2c_device->id field for naming the light sensor
>>> is a bad idea: when booting from the pure device tree this is NULL

> Hmm. Just revisiting this whilst reviewing another driver.  What the heck
> is the 'right' way of getting hold of the registered name in this case?
> I guess getting it from an of lookup if one has been used?
> So of_device_match and then the name field?

Good question.

Some code like drivers/iio/magnetometer/ak8975.c uses this:
dev_name(&client->dev)

Which will give a silly bus name like this (from /proc/interrupts):

234:          0          0    pm8xxx 224 Edge      0-000c

"0-000c" (device 0x0c on i2c bus 0)

It will be unique but not very human readable.

Yours,
Linus Walleij
