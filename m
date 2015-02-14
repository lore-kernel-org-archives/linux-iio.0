Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36826 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbbBNAeH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Feb 2015 19:34:07 -0500
Message-ID: <54DE97FE.7080602@infradead.org>
Date: Fri, 13 Feb 2015 16:34:06 -0800
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
CC: LKML <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: linux-next: Tree for Feb 13 (iio/magnetometer/ak8975.c)
References: <20150213165615.1ad43047@canb.auug.org.au> <54DE97A1.2000607@infradead.org>
In-Reply-To: <54DE97A1.2000607@infradead.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/13/15 16:32, Randy Dunlap wrote:
> On 02/12/15 21:56, Stephen Rothwell wrote:
>> Hi all,
>>
>> Please do not add any material destined for v3.21 to your linux-next
>> included trees until after v3.20-rc1 has been released.
>>
>> Changes since 20150212:
> 
> on i386:  when CONFIG_I2C is not enabled:

Caused by AK09911 selecting AK8975 but AK09911 does not depend on I2C.

> ../drivers/iio/magnetometer/ak8975.c: In function 'ak8975_who_i_am':
> ../drivers/iio/magnetometer/ak8975.c:393:2: error: implicit declaration of function 'i2c_smbus_read_i2c_block_data' [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
>   ^
> ../drivers/iio/magnetometer/ak8975.c: In function 'ak8975_set_mode':
> ../drivers/iio/magnetometer/ak8975.c:431:2: error: implicit declaration of function 'i2c_smbus_write_byte_data' [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_write_byte_data(data->client,
>   ^
> ../drivers/iio/magnetometer/ak8975.c: In function 'wait_conversion_complete_gpio':
> ../drivers/iio/magnetometer/ak8975.c:555:2: error: implicit declaration of function 'i2c_smbus_read_byte_data' [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
>   ^
> ../drivers/iio/magnetometer/ak8975.c: In function 'ak8975_read_axis':
> ../drivers/iio/magnetometer/ak8975.c:650:2: error: implicit declaration of function 'i2c_smbus_read_word_data' [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_read_word_data(client, data->def->data_regs[index]);
>   ^
> ../drivers/iio/magnetometer/ak8975.c: At top level:
> ../drivers/iio/magnetometer/ak8975.c:846:1: warning: data definition has no type or storage class [enabled by default]
>  module_i2c_driver(ak8975_driver);
>  ^
> ../drivers/iio/magnetometer/ak8975.c:846:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
> ../drivers/iio/magnetometer/ak8975.c:846:1: warning: parameter names (without types) in function declaration [enabled by default]
> ../drivers/iio/magnetometer/ak8975.c:837:26: warning: 'ak8975_driver' defined but not used [-Wunused-variable]
>  static struct i2c_driver ak8975_driver = {
>                           ^
> cc1: some warnings being treated as errors
> make[4]: *** [drivers/iio/magnetometer/ak8975.o] Error 1
> 
> 


-- 
~Randy
