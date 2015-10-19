Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-193.synserver.de ([212.40.185.193]:1232 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753234AbbJSMYD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2015 08:24:03 -0400
Message-ID: <5624E0D4.6040205@metafoo.de>
Date: Mon, 19 Oct 2015 14:23:48 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Joachim Eastwood <manabian@gmail.com>
CC: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: add Freescale MMA7455L 3-axis accelerometer
 driver
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>	<5624C9C5.6000002@metafoo.de> <CAGhQ9VyMbSEEtvaT9R1Pdm4FQf0AzGYWHKMkTHn=rfRHecUXtw@mail.gmail.com>
In-Reply-To: <CAGhQ9VyMbSEEtvaT9R1Pdm4FQf0AzGYWHKMkTHn=rfRHecUXtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/2015 02:19 PM, Joachim Eastwood wrote:
>>> +static int __init mma7455_modinit(void)
>>> +{
>>> +     int ret;
>>> +#if IS_ENABLED(CONFIG_I2C)
>>> +     ret = i2c_add_driver(&mma7455_i2c_driver);
>>> +     if (ret)
>>> +             pr_err("failed to register MMA7455L I2C driver: %d\n", ret);
>>> +#endif
>>> +#if IS_ENABLED(CONFIG_SPI_MASTER)
>>> +     ret = spi_register_driver(&mma7455_spi_driver);
>>> +     if (ret)
>>> +             pr_err("failed to register MMA7455L SPI driver: %d\n", ret);
>>> +#endif
>>
>> I know there are a fair amount of bad examples in the IIO tree for this,
>> which do the same thing. But the SPI and the I2C parts should go into
>> different modules, otherwise you run into issues if one of them is built-in
>> while the other is built as a module. The bmg160 gyro driver is a good
>> example on how to do handle this.
> 
> Ok, I semi-copied from a ASoC CODEC driver. I'll take a look at how
> bmg160 handles it.

We deprecated this style in ASoC as well. All new drivers that support both
SPI and I2C always come with a foobar-spi.c and foobar-i2c.c file. Not all
drivers have been updated to this new scheme yet, but I think the majority
follows it by now.

