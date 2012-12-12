Return-Path: <denis.ciocca@gmail.com>
From: Denis Ciocca <denis.ciocca@gmail.com>
Content-Type: text/plain; charset=us-ascii
Subject: question about driver for different sensors in the same ASIC
Date: Wed, 12 Dec 2012 20:19:45 +0100
Message-Id: <3BE6D37A-6EDA-4E4C-808F-1DEAEDE86DA3@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
To: lars@metafoo.de,
 jic23@kernel.org
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
List-ID: <linux-iio@vger.kernel.org>

Ho guys,

I have a 	question for you!
If I have two sensors (accelerometer and gyroscope for example) in the =
same ASIC with the same I2C address, I have to do only one driver (only =
probe I think) for the devices or it is possible execute two different =
probes (one for accelerometer and the other one for gyroscope) keeping =
separate the drivers?
Thanks,

Denis=
