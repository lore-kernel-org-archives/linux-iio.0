Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42303 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbCIKub (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 06:50:31 -0400
Message-ID: <54FD7AF2.8020605@kernel.org>
Date: Mon, 09 Mar 2015 10:50:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>
CC: Gwendal Grignou <gwendal@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iio: ak8975: fix AK09911 dependencies
References: <7968545.0Cq9DcaG85@wuerfel> <CAMuHMdU9x_OUReNMdZx+urZE3FDx2qz1m6gDRVp8qJ0r_QF5tA@mail.gmail.com>
In-Reply-To: <CAMuHMdU9x_OUReNMdZx+urZE3FDx2qz1m6gDRVp8qJ0r_QF5tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/15 10:27, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Wed, Jan 28, 2015 at 2:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> ak8975 depends on I2C and GPIOLIB, so any symbols that selects
>> ak8975 must have the same dependency, or we get build errors:
>>
>> drivers/iio/magnetometer/ak8975.c: In function 'ak8975_who_i_am':
>> drivers/iio/magnetometer/ak8975.c:393:2: error: implicit declaration of function 'i2c_smbus_read_i2c_block_data' [-Werror=implicit-function-declaration]
>>   ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
>>   ^
>> drivers/iio/magnetometer/ak8975.c: In function 'ak8975_set_mode':
>> drivers/iio/magnetometer/ak8975.c:431:2: error: implicit declaration of function 'i2c_smbus_write_byte_data' [-Werror=implicit-function-declaration]
>>   ret = i2c_smbus_write_byte_data(data->client,
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 57e73a423b1e85 ("iio: ak8975: add ak09911 and ak09912 support")
>> ---
>> I found this recent regression doing ARM randconfig builds, please apply
>>
>> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
>> index 4c7a4c52dd06..a5d6de72c523 100644
>> --- a/drivers/iio/magnetometer/Kconfig
>> +++ b/drivers/iio/magnetometer/Kconfig
>> @@ -18,6 +18,8 @@ config AK8975
>>
>>  config AK09911
>>         tristate "Asahi Kasei AK09911 3-axis Compass"
>> +       depends on I2C
>> +       depends on GPIOLIB
>>         select AK8975
>>         help
>>           Deprecated: AK09911 is now supported by AK8975 driver.
> 
> I just saw the AK8975/AK09911 config options disappear for a v4.0-rc3 m68k
> allmodconfig kernel. Apparently it built fine with !GPIOLIB before, as many
> gpiolib (consumer) functions have dummies for the !GPIOLIB case.
> 
> So I think the GPIOLIB dependency can be relaxed to "GPIOLIB || COMPILE_TEST".
> The same may be true for many other GPIOLIB consumer drivers.
> Will look into it and send patches...
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
Sounds likely and would be great to increase build coverage on these if we can.

Jonathan

