Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:11950 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933897AbcAZIR7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jan 2016 03:17:59 -0500
Subject: Re: [PATCH 16/22] iio: imu: Fix dependencies for !HAS_IOMEM archs
To: Paul Bolle <pebolle@tiscali.nl>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-17-git-send-email-richard@nod.at>
 <1453767342.17181.26.camel@tiscali.nl>
Cc: user-mode-linux-devel@lists.sourceforge.net,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Richard Weinberger <richard@nod.at>
Message-ID: <56A72BB3.9090206@nod.at>
Date: Tue, 26 Jan 2016 09:17:55 +0100
MIME-Version: 1.0
In-Reply-To: <1453767342.17181.26.camel@tiscali.nl>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 26.01.2016 um 01:15 schrieb Paul Bolle:
> On ma, 2016-01-25 at 23:24 +0100, Richard Weinberger wrote:
>> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
>> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> 
>>  config INV_MPU6050_IIO
>>  	tristate "Invensense MPU6050 devices"
>>  	depends on I2C && SYSFS
>> +	depends on I2C_MUX
> 
> Nit: if I parsed the v4.5-rc1 tree correctly I2C_MUX depends I2C. So
> just
> 	depends on I2C_MUX && SYSFS
> 
> should also do the trick. Is it clearer to mention both I2C and I2C_MUX
> explicitly?

I don't have a strong opinion on that. In general I'm a fan of explicit
dependencies but in this case, you are right, also an implicit one should to it.
Let's see what maintainers think. :-)

Thanks,
//richard
