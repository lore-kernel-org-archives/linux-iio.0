Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39696 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbcFSTiH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2016 15:38:07 -0400
Subject: Re: [PATCH 2/2] iio: light: bh1780: assign a static name
To: Linus Walleij <linus.walleij@linaro.org>
References: <1464162027-24612-1-git-send-email-linus.walleij@linaro.org>
 <1464162027-24612-2-git-send-email-linus.walleij@linaro.org>
 <3c1a7937-3c90-9f26-c9fe-e2ffad140e06@kernel.org>
 <2730751a-3ab8-a083-6f2f-6b5b9d0acf62@kernel.org>
 <CACRpkdYTuJ65aTTyY7427ndYF6edJOVedGHXM_2iMjTQPf5X7g@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9b36d76c-70d8-6f9c-2571-0b56351e28c6@kernel.org>
Date: Sun, 19 Jun 2016 20:38:05 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdYTuJ65aTTyY7427ndYF6edJOVedGHXM_2iMjTQPf5X7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/06/16 19:04, Linus Walleij wrote:
> On Sun, Jun 19, 2016 at 1:25 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>>>> Using the struct i2c_device->id field for naming the light sensor
>>>> is a bad idea: when booting from the pure device tree this is NULL
> 
>> Hmm. Just revisiting this whilst reviewing another driver.  What the heck
>> is the 'right' way of getting hold of the registered name in this case?
>> I guess getting it from an of lookup if one has been used?
>> So of_device_match and then the name field?
> 
> Good question.
> 
> Some code like drivers/iio/magnetometer/ak8975.c uses this:
> dev_name(&client->dev)
> 
> Which will give a silly bus name like this (from /proc/interrupts):
> 
> 234:          0          0    pm8xxx 224 Edge      0-000c
> 
> "0-000c" (device 0x0c on i2c bus 0)
> 
> It will be unique but not very human readable.
The name field was always really intended to just be the part number.
There are lots of other ways of finding out 'where' it is.

Jonathan
> 
> Yours,
> Linus Walleij
> 

