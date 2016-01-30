Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53396 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895AbcA3Pt2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 10:49:28 -0500
Subject: Re: [PATCH 16/22] iio: imu: Fix dependencies for !HAS_IOMEM archs
To: Richard Weinberger <richard@nod.at>,
	Paul Bolle <pebolle@tiscali.nl>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-17-git-send-email-richard@nod.at>
 <1453767342.17181.26.camel@tiscali.nl> <56A72BB3.9090206@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACDB85.50300@kernel.org>
Date: Sat, 30 Jan 2016 15:49:25 +0000
MIME-Version: 1.0
In-Reply-To: <56A72BB3.9090206@nod.at>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/16 08:17, Richard Weinberger wrote:
> Am 26.01.2016 um 01:15 schrieb Paul Bolle:
>> On ma, 2016-01-25 at 23:24 +0100, Richard Weinberger wrote:
>>> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
>>> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
>>
>>>  config INV_MPU6050_IIO
>>>  	tristate "Invensense MPU6050 devices"
>>>  	depends on I2C && SYSFS
>>> +	depends on I2C_MUX
>>
>> Nit: if I parsed the v4.5-rc1 tree correctly I2C_MUX depends I2C. So
>> just
>> 	depends on I2C_MUX && SYSFS
>>
>> should also do the trick. Is it clearer to mention both I2C and I2C_MUX
>> explicitly?
> 
> I don't have a strong opinion on that. In general I'm a fan of explicit
> dependencies but in this case, you are right, also an implicit one should to it.
> Let's see what maintainers think. :-)
I find it hard to care ;)

Anyhow, the version as stands applied to the rather odd fixes-post-4.5rc1 branch
that I currently have in iio.git - will unwind that now we are post said version
sometime in next few days (this on is only there because I needed to take patch
06 through that branch).

Jonathan
> 
> Thanks,
> //richard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

