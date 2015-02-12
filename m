Return-Path: <andrew.smirnov@gmail.com>
MIME-Version: 1.0
Date: Thu, 12 Feb 2015 12:23:33 -0800
Message-ID: <CAHQ1cqG313SrRWbBLaHm1gwmdTOXOqjviBaA8tEcsbv7m=n-Bg@mail.gmail.com>
Subject: Revert e0922e5e3ccb78aa0152e93dfbd1755ac39c8582
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kaptain Kernel <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Please revert patch e0922e5e3ccb78aa0152e93dfbd1755ac39c8582:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/iio/humidity/si7020.c?id=e0922e5e3ccb78aa0152e93dfbd1755ac39c8582

It incorrectly assumes that the level of indirection is not needed
which is not true(probably because the driver incorrectly allocates
sizeof(*client) instead of sizeof(*data) via devm_iio_device_alloc).
If you look at the code of the probe function(see below) it is easy to
see that what is being stored in the private memory of the IIO device
instance is not a copy of a 'struct i2c_client' but a pointer to an
instance passed as an argument to the probe function.

struct i2c_client **data;
int ret;

< Some code skipped >

indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*client));
if (!indio_dev)
return -ENOMEM;

data = iio_priv(indio_dev);
*data = client;

Without reverting this change any read of a raw value of this sensor
leads to a kernel oops due to a NULL pointer de-reference on my
hardware setup.

I will be sending a patch to fix the 'sizeof' mixup shortly.

Thank you,
Andrey Smirnov
