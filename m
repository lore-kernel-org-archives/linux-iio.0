Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36664 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbcCBQdk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2016 11:33:40 -0500
MIME-Version: 1.0
In-Reply-To: <20160301205052.GD1488@katana>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
	<1455810794-3188-10-git-send-email-daniel.baluta@intel.com>
	<20160301205052.GD1488@katana>
Date: Wed, 2 Mar 2016 18:33:38 +0200
Message-ID: <CAEnQRZAF-tAjDwJkUNEVQXYqWDt7RsH2bH81UBAMUhsoWEt73g@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] iio: imu: inv_mpu6050: Fix deadlock between i2c
 adapter lock and mpu lock
From: Daniel Baluta <daniel.baluta@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-i2c@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ge Gao <ggao@invensense.com>,
	Adriana Reus <adi.reus@gmail.com>, Crt Mori <cmo@melexis.com>,
	Michael Welling <mwelling@ieee.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 1, 2016 at 10:50 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Feb 18, 2016 at 05:53:14PM +0200, Daniel Baluta wrote:
>> From: Adriana Reus <adriana.reus@intel.com>
>>
>> This deadlock occurs if the accel/gyro and the sensor on the auxiliary
>> I2C (in my setup it's an ak8975) are working at the same time.
>>
>> Scenario:
>>
>>       T1                                      T2
>>      ====                                    ====
>> inv_mpu6050_read_fifo                  aux sensor op (eg. ak8975_read_raw)
>>         |                                     |
>> mutex_lock(&indio_dev->mlock)           i2c_transfer
>>         |                                     |
>> i2c transaction                         i2c adapter lock
>>         |                                     |
>> i2c adapter lock                        i2c_mux_master_xfer
>>                                               |
>>                                         inv_mpu6050_select_bypass
>>                                               |
>>                                         mutex_lock(&indio_dev->mlock)
>>
>> When we operate on an mpu sensor the order of locking is mpu lock
>> followed by the i2c adapter lock. However, when we operate the auxiliary
>> sensor the order of locking is the other way around.
>>
>> In order to avoid this enable the bypass mux bit once in the beginning
>> and remove the select/deselect_bypass functions.
>>
>> This patch moves the bypass enabling in a separate function
>> that is called once at probe and removes the functionality from
>> inv_mpu_select/deselect_bypass.
>>
>> Another advantage of this approach is that power-wise the mpu chip isn't
>> powered up at each auxiliary sensor i2c transaction so if only the
>> compass is used this would be more power efficient.
>
> I think the comments (power must be enabled on select) rendered this
> solution not acceptable. What about using mutex_trylock in
> inv_mpu6050_select_bypass() and returning -EAGAIN if the lock is already
> held?

Well, yes this would be a very good temporary solution. I'm afraid tough
that reading at high rates accel/gyro data will starve the aux sensor readings.

I looked into the I2C adapter / mux code but I got lost rapidly :). It
feels like
the natural solution would be for the I2C core to not hold the adapter lock
while doing transactions on the muxed child adapter.

Anyhow, sometimes starving is better than deadlocking so I will send a patch
with your suggestion.

thanks,
Daniel.
