Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <20160221231751.GC1386@katana>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
	<20160221231751.GC1386@katana>
Date: Mon, 22 Feb 2016 11:43:49 +0200
Message-ID: <CAEnQRZAHiHFud_OdKiVrqzD2hoGwYMYFeOCt8a9LXCEhC8Dqbw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] iio: Fix ABBA deadlock in inv-mpu6050
From: Daniel Baluta <daniel.baluta@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ggao@invensense.com,
	Adriana Reus <adi.reus@gmail.com>, Crt Mori <cmo@melexis.com>,
	Michael Welling <mwelling@ieee.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 22, 2016 at 1:17 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Feb 18, 2016 at 05:53:05PM +0200, Daniel Baluta wrote:
>> Sending this as an RFC because I don't know if style fixes are appropriate
>> for this driver and also not sure if deadlock fix is the best solution.
>>
>> I2C people should only look at patches 8/9 and 9/9.
>>
>> The mpu6050 accel+gyro combo has an auxiliary I2C bus, allowing for
>> an auxiliary sensor to be connected (eg. a magnetometer).
>>
>> The mpu can either act as an I2C master (functionality not currently
>> implemented in the driver) or it can use a bypass multiplexer which
>> directly connects the auxiliary I2C bus pins to the main I2C bus pins [1]
>> Currently the driver implements the bypass mode via an I2C mux.
>>
>> This patchset fixes a deadlock in inv-mpu6050 IMU which happens when
>> magnetometer (on auxiliary I2C bus) runs in parallel with accel or gyro.
>>
>> First 7 patches do some cleanup in order to make INV MPU6050 code easier
>> to read.
>>
>> Patch number 8 allows passing NULL select callbacks to i2c_mux_master_xfer
>> and i2c_mux_smbus_xfer.
>>
>> Patch number 9 actually fixes the deadlock.
>
> We recently had a bigger patch series fixing locking problems related to
> muxes. I sadly didn't have the time to review it. Can you have a look if
> it helps your case?
>
> http://thread.gmane.org/gmane.linux.drivers.i2c/26169

Thanks Wolfram,

Will look into it.
