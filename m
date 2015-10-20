Return-Path: <manabian@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5625F1B5.8000400@posteo.de>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
	<1445281210-3936-1-git-send-email-manabian@gmail.com>
	<5625F1B5.8000400@posteo.de>
Date: Tue, 20 Oct 2015 13:03:38 +0200
Message-ID: <CAGhQ9Vy72fG4AVNe_esOUd4d8=3UQj6Sada3_v7pZ1MEc=cjrA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: add Freescale MMA7455L/MMA7456L 3-axis
 accelerometer driver
From: Joachim  Eastwood <manabian@gmail.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 20 October 2015 at 09:48, Martin Kepplinger <martink@posteo.de> wrote:
> Am 2015-10-19 um 21:00 schrieb Joachim Eastwood:
>> Add support for Freescale MMA7455L/MMA7456L 3-axis in 10-bit mode for
>> I2C and SPI bus. This rather simple driver that currently doesn't
>> support all the hardware features of MMA7455L/MMA7456L.
>>
>> Tested on Embedded Artist's LPC4357 Dev Kit with MMA7455L on I2C bus.
>>
>> Data sheets for the two devices can be found here:
>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7455L.pdf
>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7456L.pdf
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>> Hi,
>>
>> This version address the comments from Lars-Peter Clausen, Peter
>> Meerwald and Martin Kepplinger. Thanks for all the constructive
>> feedback!
>>
>> Changes since v1:
>> * limit retries to 3 in mma7455_drdy
>> * remove mma7455_show_scale_avail
>> * use chan->address instead of chan->scan_index for reg addr
>> * check that val2 is 0 when setting sample freq
>> * use __le16 to hint about endianess in mma7455_trigger_handler
>> * fix endianess in mma7455_read_raw function
>> * add mma7456 id
>> * split it into several source files to support both i2c and spi
>>
>> I compared the register summary for MMA7455L/MMA7456L and I am
>> unable to find any difference at all.
>>
>>  drivers/iio/accel/Kconfig        |  22 +++
>>  drivers/iio/accel/Makefile       |   5 +
>>  drivers/iio/accel/mma7455.h      |  20 +++
>>  drivers/iio/accel/mma7455_core.c | 321 +++++++++++++++++++++++++++++++++++++++
>>  drivers/iio/accel/mma7455_i2c.c  |  57 +++++++
>>  drivers/iio/accel/mma7455_spi.c  |  53 +++++++
>>  6 files changed, 478 insertions(+)
>>  create mode 100644 drivers/iio/accel/mma7455.h
>>  create mode 100644 drivers/iio/accel/mma7455_core.c
>>  create mode 100644 drivers/iio/accel/mma7455_i2c.c
>>  create mode 100644 drivers/iio/accel/mma7455_spi.c
>>
>>  config MMA8452
>>       tristate "Freescale MMA8452Q Accelerometer Driver"
>>       depends on I2C
>> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
>> index ebd2675b2a02..dfb9289393fb 100644
>> --- a/drivers/iio/accel/Makefile
>
> You don't base your work on top of the current -next tree. But that's
> where this most likely will go, if integrated. Please make it apply to
> linux-next.

Sure I can based it off linux-next or would one of the branches on
git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git be better?


regards,
Joachim Eastwood
