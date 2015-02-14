Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33511 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbbBNLen (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Feb 2015 06:34:43 -0500
Message-ID: <54DF32D2.70105@kernel.org>
Date: Sat, 14 Feb 2015 11:34:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Andrey Smirnov <andrew.smirnov@gmail.com>
CC: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Revert e0922e5e3ccb78aa0152e93dfbd1755ac39c8582
References: <CAHQ1cqG313SrRWbBLaHm1gwmdTOXOqjviBaA8tEcsbv7m=n-Bg@mail.gmail.com>
In-Reply-To: <CAHQ1cqG313SrRWbBLaHm1gwmdTOXOqjviBaA8tEcsbv7m=n-Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/02/15 20:23, Andrey Smirnov wrote:
> Hi Jonathan,
> 
> Please revert patch e0922e5e3ccb78aa0152e93dfbd1755ac39c8582:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/iio/humidity/si7020.c?id=e0922e5e3ccb78aa0152e93dfbd1755ac39c8582
> 
> It incorrectly assumes that the level of indirection is not needed
> which is not true(probably because the driver incorrectly allocates
> sizeof(*client) instead of sizeof(*data) via devm_iio_device_alloc).
> If you look at the code of the probe function(see below) it is easy to
> see that what is being stored in the private memory of the IIO device
> instance is not a copy of a 'struct i2c_client' but a pointer to an
> instance passed as an argument to the probe function.
> 
> struct i2c_client **data;
> int ret;
> 
> < Some code skipped >
> 
> indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*client));
> if (!indio_dev)
> return -ENOMEM;
> 
> data = iio_priv(indio_dev);
> *data = client;
> 
> Without reverting this change any read of a raw value of this sensor
> leads to a kernel oops due to a NULL pointer de-reference on my
> hardware setup.
> 
> I will be sending a patch to fix the 'sizeof' mixup shortly.
> 
> Thank you,
> Andrey Smirnov
> 
Reverted in the fixes-togreg branch and cc'd to stable.

I'll pick up the fix as well in a minute.


