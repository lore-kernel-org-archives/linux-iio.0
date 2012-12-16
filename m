Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46436 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab2LPL2a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Dec 2012 06:28:30 -0500
Message-ID: <50CDB05B.9000206@kernel.org>
Date: Sun, 16 Dec 2012 11:28:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: STMicroelectronics sensors driver
References: <1355404302-2239-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1355404302-2239-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/13/2012 01:11 PM, Denis CIOCCA wrote:
> Hi Jonathan & Lars-Peter,
> 
> I wrote this new patch to include the common library and device drivers
> for accel, magn and gyro.
> I didn't looked still for tx and rx buffers issue because I have to study
> better the problem.
Sure, though in this case it is just a case of making sure the cacheline
aligned elements are at the end of the structure.

> What do you think about this library?
> 
Couple of general things to do.

Run one or more static checkers over the code before posting (just saves time
in review by clearing out some standard issues)
(good  choices are sparse, smatch and coccicheck (coccinelle wrapper)).

Sparse gives:

drivers/iio/accel/st_accel_trigger.c:25:5: warning: symbol 'st_accel_trig_acc_set_state' was not declared. Should it be
static?
drivers/iio/accel/st_accel_trigger.c:49:30: warning: symbol 'st_accel_trigger_ops' was not declared. Should it be static?
  CC [M]  drivers/iio/accel/st_accel_trigger.o
  CHECK   drivers/iio/accel/st_accel_buffer.c
  CC [M]  drivers/iio/accel/st_accel_buffer.o
  CHECK   drivers/iio/accel/st_accel_core.c
  CC [M]  drivers/iio/accel/st_accel_core.o
  LD [M]  drivers/iio/accel/st_accel.o
  CHECK   drivers/iio/common/st_sensors/st_sensors_core.c
  CC [M]  drivers/iio/common/st_sensors/st_sensors_core.o
drivers/iio/common/st_sensors/st_sensors_core.c: In function 'st_sensors_set_enable':
drivers/iio/common/st_sensors/st_sensors_core.c:182:27: warning: 'odr_out.hz' may be used uninitialized in this function
  CHECK   drivers/iio/common/st_sensors/st_sensors_i2c.c
drivers/iio/common/st_sensors/st_sensors_i2c.c:21:14: warning: symbol 'st_sensors_i2c_get_irq' was not declared. Should
it be static?
  CC [M]  drivers/iio/common/st_sensors/st_sensors_i2c.o
  CHECK   drivers/iio/common/st_sensors/st_sensors_spi.c
drivers/iio/common/st_sensors/st_sensors_spi.c:22:14: warning: symbol 'st_sensors_spi_get_irq' was not declared. Should
it be static?
  CC [M]  drivers/iio/common/st_sensors/st_sensors_spi.o
  CHECK   drivers/iio/common/st_sensors/st_sensors_trigger.c
  CC [M]  drivers/iio/common/st_sensors/st_sensors_trigger.o
  CHECK   drivers/iio/common/st_sensors/st_sensors_buffer.c
  CC [M]  drivers/iio/common/st_sensors/st_sensors_buffer.o
  LD [M]  drivers/iio/common/st_sensors/st_sensors_triggered_buffer.o
  CHECK   drivers/iio/gyro/st_gyro_i2c.c
  CC [M]  drivers/iio/gyro/st_gyro_i2c.o
  CHECK   drivers/iio/gyro/st_gyro_spi.c
  CC [M]  drivers/iio/gyro/st_gyro_spi.o
  CHECK   drivers/iio/gyro/st_gyro_trigger.c
drivers/iio/gyro/st_gyro_trigger.c:23:5: warning: symbol 'st_gyro_trig_acc_set_state' was not declared. Should it be static?
drivers/iio/gyro/st_gyro_trigger.c:47:30: warning: symbol 'st_gyro_trigger_ops' was not declared. Should it be static?
  CC [M]  drivers/iio/gyro/st_gyro_trigger.o
  CHECK   drivers/iio/gyro/st_gyro_buffer.c
  CC [M]  drivers/iio/gyro/st_gyro_buffer.o
  CHECK   drivers/iio/gyro/st_gyro_core.c
drivers/iio/gyro/st_gyro_core.c:95:28: warning: symbol 'st_gyro_16bit_channels' was not declared. Should it be static?
  CC [M]  drivers/iio/gyro/st_gyro_core.o
  LD [M]  drivers/iio/gyro/st_gyro.o
  CHECK   drivers/iio/magnetometer/st_magn_i2c.c
  CC [M]  drivers/iio/magnetometer/st_magn_i2c.o
  CHECK   drivers/iio/magnetometer/st_magn_spi.c
  CC [M]  drivers/iio/magnetometer/st_magn_spi.o
  CHECK   drivers/iio/magnetometer/st_magn_trigger.c
drivers/iio/magnetometer/st_magn_trigger.c:43:30: warning: symbol 'st_magn_trigger_ops' was not declared. Should it be
static?
  CC [M]  drivers/iio/magnetometer/st_magn_trigger.o
  CHECK   drivers/iio/magnetometer/st_magn_buffer.c
  CC [M]  drivers/iio/magnetometer/st_magn_buffer.o
  CHECK   drivers/iio/magnetometer/st_magn_core.c
  CC [M]  drivers/iio/magnetometer/st_magn_core.o
  LD [M]  drivers/iio/magnetometer/st_magn.o
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
  Building modules, stage 2.
  MODPOST 226 modules


Coccinelle picks up various things including...
drivers/iio/common/st_sensors/st_sensors_spi.c:67:1-7: preceding lock on line 49
(basically you don't release the mutex on an error path).

Anyhow, these tools are a great help in catching some
types of problems.



