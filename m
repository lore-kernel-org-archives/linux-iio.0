Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:49347 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbcDTR7S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Apr 2016 13:59:18 -0400
Subject: Re: bmg160 driver
To: Patrick Doyle <wpdster@gmail.com>, linux-iio@vger.kernel.org
References: <CAF_dkJBTS9s6x4Fq+E5eJSRwsd=m6tRHZ9m8hotC6mLzeLberg@mail.gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5717C372.3070702@metafoo.de>
Date: Wed, 20 Apr 2016 19:59:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAF_dkJBTS9s6x4Fq+E5eJSRwsd=m6tRHZ9m8hotC6mLzeLberg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/20/2016 07:55 PM, Patrick Doyle wrote:
> Hello,
> I need to write a SPI mode Linux device driver for the Bosch BMI055
> IMU.  I notice that an I2C version of the driver for this part exists
> already (at least, in the 4.1 kernel I am using).  I was wondering if
> anyone knew of an existing SPI mode driver for this part, or if
> anybody had some hints or direction that they could give me regarding
> writing such a driver myself.

The latest IIO tree has SPI support. See
http://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/drivers/iio/gyro/bmg160_spi.c

