Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57195 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab2GFJSy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jul 2012 05:18:54 -0400
Message-ID: <4FF6AAD1.2010304@kernel.org>
Date: Fri, 06 Jul 2012 10:07:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] IIO: Invensense MPU6050/MPU9150 driver submit
References: <b3538f7a1e57bd6429d390cefa7597f5@mail.gmail.com>
In-Reply-To: <b3538f7a1e57bd6429d390cefa7597f5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Ge,

Please don't get disheartened by this partial review.
Getting use to approaches to getting kernel drivers merged
can take a considerable time. It's not a trivial thing
to do even with a 'perfect' driver.  There is a lot of
nice / interesting stuff in your driver so I look forward
to seeing it move forward!  I doubt we'll get any more complex
hardware anytime soon!

Couple of major comments.

1) This first patch could benefit from breaking up futher. Right
now it's too big and cumbersome to review remotely quickly.
First separate off the docs into their own patch.
Then I'd pull out the DMP code into a follow up patch.
That way we can get the core stuff sorted relatively quickly
before it gets to complex.

Actually the best way to get this in would be to strip nearly
everything back so just have your basic data flow through
the fifo. No events or motion processing or anything unusual in
the first patch.  Then we can review that very quickly and get
something in place to make incremental extensions to.

All in all it is too big to get reviewed. Sorry, but patches
really need to be inline emails if you want to have a reasonable
chance of getting eyes on them. There are a number of people on the
mailing list who will take a look at new drivers when they
have a few minutes spare.  This first file has taken me over
2 hours to review and what I have done is far from thorough.

Anyhow some comments in line. Mostly the code looks pretty clean
and there are some good docs which always helps.

2) I may not have made it clear enough before, but you are
pretty much not going to succeeed in having your own versions
of drivers that already exist.  That sort of code replication gets
a lot of friction upstream.

What you need to do is to write a i2c master driver and then
attach your secondary devices to this.  Where you need additional
features in those drivers, propose them and if they are not too
invasive I doubt anyone will mind.  Although you only have a couple
of slave devices here, seeing your table of id's shows there will
be a lot more to come.

If there is an absolute reason why this approach won't work, you
need to convince people with a careful brief arguement 'before' this
goes anywhere.

Anyhow Ge good luck with this one. I might get a chance to take a look
at the other patches, but it'll be a while give their size. Sorry, but
the short easy to review ones tend to get attended to first!

Jonathan

 From 6d4093a59d77a68d4972f648ea9eba69e8598159 Mon Sep 17 00:00:00 2001
From: Ge Gao <ggao@invensense.com>
Date: Thu, 28 Jun 2012 10:58:12 -0700
Subject: [PATCH 1/4]     Invensense MPU6050/MPU9150 driver.

       --MPU6050/MPU9150 driver.
       --Secondary bus for AKM8975/AKM8963/AKM8972 support.
       --kernel fix for Kfifo poll support from Jonanthan.
       --Kfifo bug fix. Need to check available space before store.
       --add new IIO type for quaternion.

...
index 0000000..c4fa2c2
--- /dev/null
+++ b/drivers/staging/iio/imu/mpu6050/Kconfig
@@ -0,0 +1,6 @@
+#
+# inv-mpu-6050 drivers for Invensense MPU devices and combos
+#
+
+config INV_MPU6050_IIO
+	tristate "Invensense MPU6050 devices"
Will need to drop the !INV_MPU bit from the patch (and put it back in 
your local tree).
+	depends on I2C && SYSFS && IIO && IIO_KFIFO_BUF && !INV_MPU && 
!INV_MPU_IIO
+	default n
+	help
+	  This driver supports the Invensense MPU6050/MPU9150 devices. It also
+	  supports AKM8975/AKM8963/AKM8972 in the secondary bus.
Ideally you want to build this text up as stuff is added (guessing not 
all of this
is in the initial patch!)
+	  This driver can be built as a module. The module will be called
+	  inv-mpu6050-iio.
Not keen on the naming, inv-mpu6050 then if you need to change it for
your local tree do it in a patch there.

...

diff --git a/drivers/staging/iio/imu/mpu6050/README 
b/drivers/staging/iio/imu/mpu6050/README
new file mode 100644
index 0000000..806a956
--- /dev/null
+++ b/drivers/staging/iio/imu/mpu6050/README
@@ -0,0 +1,11 @@
+Kernel driver inv-mpu-iio
+Author: Invensense <http://invensense.com>
+
+Description
+-----------
+This document describes how to install the Invensense device driver into a
+Linux kernel. At the moment, this driver supports the
+MPU6050/MPU9150. The slave address of these four chips are
+0x68 or 0x69. However, the actual slave address depends on the board
+configuration. The driver does not assume anything about it.
+
I would have prefered the documentation in a separate patch.
Also, lots of this needs 'adjusting' to take into account that the
driver will be in the main tree.

+Files included in this package:
+Kconfig
+Makefile
+inv_mpu_core.c
+inv_mpu_misc.c
+inv_mpu_iio.h
+inv_mpu_ring.c
+dmpDefaultMPU6050.c
+dmpkey.h
+dmpmap.h
+mpu.h
+Including the driver in the Linux kernel
+----------------------------------------
+mpu.h should be added to "kernel/include/linux".
+Other files listed should be added to the drivers/staging/iio/imu/mpu
+directory (or another directory of your choosing). When building the
+kernel, the driver will not appear in menuconfig without modifications
+similar to those below:
+
+modify "drivers/staging/iio/imu/Kconfig" like
+source "drivers/staging/iio/imu/mpu/Kconfig"
+
+modify "drivers/staging/iio/imu/Makefile"
+obj-y += mpu/
+
+Board and Platform Data
+-----------------------
+The board file needs to be modified to register the device on an I2C 
bus. An
+i2c_board_info instance must be defined as seen below. The hardcoded 
value of
+140 corresponds to the GPIO input pin wired to the device's interrupt pin.
+This pin will most likely be different for your platform.
+platform data is for orientation matrix,  and secondary bus situations.
+For MPU9150, it is regarded as a MPU9150 and AKM8975 in the secondary.
+So the secondary i2c address must be filled.
+-----------------------------------------------------------------
+The board file is arch/arm/mach-omap2/board-omap4panda.c for panda board or
+modify the board file in your system as below:
+--------------------------------------------------------
good examples for the platform data.  I'm not sure I'd spend
as much time talking about how to register it for a given board.
That stuff is pretty standard.
+For AKM8963 in the secondary i2c bus of MPU6050,
+static struct mpu_platform_data gyro_platform_data = {
+	.int_config  = 0x10,
+	.level_shifter = 0,
+	.orientation = {  -1,  0,  0,
+			   0,  1,  0,
+			   0,  0, -1 },
+	.sec_slave_type = SECONDARY_SLAVE_TYPE_COMPASS,
+	.sec_slave_id   = COMPASS_ID_AK8963,
+	.secondary_i2c_addr = 0x0E
+};
...
+
+IIO subsystem
+----------------------------------------------
+successful installation will create two directories under 
/sys/bus/iio/devices
+iio:device0
+trigger0
+Under /dev/ diretory, a file "iio:device0" will also be created(or 
iio:deviceX, if
+you have more than one iio devices).
This stuff is all good, but ideally it would go in a more generic document
where it isn't already covered.  That way we don't have to edit more than
one if anything changes!
+Communicating with the driver in userspace
+------------------------------------------
+Upon installation, the driver generates several files in sysfs. If your
+platform is configured as detailed above, navigate to the following path to
+find these files:
+/sys/bus/iio/devices/iio:device0
+
+The list below provides a brief description for each file.
+--------------------------------------
Firstly these need documenting in 
Documentation/abi/testing/syfs-bus-iio-mpu6050 or
similar using the standard formats found in there.

+For MPU6050:
+temperature (Read-only)
+Read temperature data directly from the temperature register.
Not abi compliant in_temp_input probably.
+
+sampling_frequency (Read/write)
+Configure the ADC sampling rate and FIFO output rate.
+
+sampling_frequency_available(read-only)
+show commonly used frequency
+
+clock_source (Read-only)
+Check which clock-source is used by the chip.
What controls this?  I'd be tempted to drop it as not
terribly useful to the user if they can't change it.
Probably a debugging aid?
+
+power_state (Read/write)
+turn on/off the power supply
+
+self_test (read-only)
+read this entry trigger self test. The return value is D.
+D is the success/fail.
+For different chip, the result is different for success/fail.
+1 means success 0 means fail. The LSB of D is for gyro; the bit
+next to LSB of D is for accel. The bit 2 of D is for compass result.
That's in the magic value category.  If you do need a self test
like this, make it output a nice string to say what happened.

+
+key (read-only)
+show the key value of this driver. Used by MPL.
Define the acronym!
+
+gyro_matrix (read-only)
+show the orient matrix obtained from board file.
why?
+
+gyro_enable (read/write)
+enable/disable gyro functionality. affect raw_gyro. turn off this will
+shut down gyro and save power.
If the startup time is not horendous do this dynamically. E.g. bring it
up when a reading is requested or if it in use by the buffered interfaces.
+
+accl_enable (read/write)
+enable/disable accelerometer functionality. affect raw_accl.
+turn off this will shut down accel and save power.
+
+firmware_loaded (read/write)
+Flag indicate the whether firmware is loaded or not in the DMP engine.
+0 means no firmware loaded. 1 means firmware is already loaded . This
+flag can only be written as 0. 1 is updated internally.
Not sure this should be exposed to the users.   Firmware should always be
loaded and done automatically before the device interfaces appear.
If there is another reason for this, please give details.
+
+dmp_on(read/write)
+This entry controls whether to run DMP or not. To enable DMP ,
+firmware_loaded must be 1. write 1 to enable DMP and write 0 to disable 
dmp.
+
+dmp_in_on(read/write)
+This entry controls whether dmp interrupt is on/off. firmware_loaded must
+be 1. sometimes, it is desirable that interrupt is off while DMP is 
running.
This is definitely not something that should be exposed to userspace. Work
out when it is 'desirable' and do the appropriate control in driver.
+
+dmp_event_int_on(read/write)
+This entry controls whether dmp event interrupt is on/off. Setting this on
+would turn off the data interrupt and turn on the event interrupt. No data
+interrupt would be generated. Only when event happens, does an interrupt
+generate. This can be used in power saving mode when system is waiting for
+a special event to wake up.
Again, raw interrupt controls like this are not abi compliant and should not
be exposed to the user.  It is far from obvious when users will want 
this and when
they will not. If it is useful in power saving mode then enable it, if 
not don't..
+
+dmp_firmware (write only binary file)
+This is the entry that firmware code is loaded into. If the action is 
succeful,
+firmware_loaded will be updated as 1. In order to load new firmware,
+firmware_loaded flag should be set 0.
No. Sorry, but the kernel has standard ways of loading firmware. Those 
are what
you need to use.
+
+lpa_mode(read-write)
+Low power  accelerometer mode
+lpa_freq(read-write)
+low power acceleromter frequency.
Hmm.. There are drivers doing this sort of thing but it generalises very 
badly.
What result does it actually have on the accelerometer?  I'd much rather it
was controlled by dropping into this if they frequency was set appropriately
rather than via this exta control
+
+accel_matrix
+orient matrix for accel
in_accel_orientation_matrix perhaps?  Needs to be associated with the 
channels
explicitly.
+
+flick_lower,
+flick_upper,
+flick_counter,
+flick_message_on,
+flick_int_on,
+flick_axis,
+Flick related entry
That's pretty opaque. Thes probably want to be mapped to the standard 
event types
and those extended if necessary. Certainly don't want to be here.
+
+pedometer_time
+pedometer_steps,
+Pedometer related entry
Cool. Not see that before. Probably want to do that with a new channel 
type. No
reason we won't get more pedometers at some point.

+
+event_flick
+event_tap
+event_orientation
+event_display_orientation
+event related entry. These entry must use poll to read.
Using poll in sysfs is pretty heavily frowned upon except for extremely 
unlikely
error conditions.  These need to go through the event interface of iio. 
If we
need to extend that to handle them then by all means send patches to do so.
+
+tap_on
+control tap function of DMP
+
+dmp_int_on
+turn on/off dmp interrupt.
you have both dmp_in_on and dmp_int_on.  I don't like either ;)
+
+dmp_output_rate
+control dmp output rate when dmp is on.
That's another 'sampling frequency' for the relevant channels.
+
+tap_time
+tap_min_count
+tap_threshold
+tap related entries. control various parameters of tap function.
More stuff that needs to go through the event interface.
+
+orientation_on
+turn on/off orientation function of DMP.
Hmm.. Is this for power reasons?  We really need to start a discussion
about fine grained power control for this sort of device.  Right now I
think you may have to drop it or control it via the enabled channels on
the buffered interface.
+
+display_orientation_on
+turn on/off display orientation function of DMP.
+
+quaternion_on
+turn on/off quaterniion data output. must use DMP.
+-------------------------------------------------------------------
+for MPU9150 and secondary compass
+MPU9150 has every entry MPU6050 has. It has additional entries:
+
+compass_enable (read/write)
+enable this will enable compass function.
+
+compass_matrix (read-only)
+compass orient matrix
Need to map to normal channel types (or add one if this doesn't map
to a magnetometer?)
+----------------------------------------------------------------------------------
+low power accelerometer mode
+Lower power accelerometer mode is a special mode. It works only for 
accelerometer.
+It has two entries, lpa_mode and lpa_freq. Only MPU6050 and MPU9150 has 
this mode.
+To run low power accel mode, set lpa_mode to 1, set lpa_freq to 0~3, 
which corresponds
+to 1.25Hz, 5Hz, 20Hz, 40Hz. "gyro_enable" and "compass_enable" must be 
zero. "dmp_on"
+must be zero.
Then enable it automatically if the acceleration is all that is enabled 
and the frequency is
one of those.
+-----------------------------------------------------------------------------------
+dmp event.
+dmp event is event out by the DMP unit inside MPU. Only MPU6050 and 
MPU9150 supports this.
+There are four sysfs entreis, event_flick, event_tap and 
event_orientation and
entries
+event_display_orientation. These four events must
+be polled before read. The proper method to poll sysfs is:
+1. open file.
+2. dummy read.
+3. poll.
+4. once the poll passed, use fopen and fread to read the sysfs entry.
+5. interpret the data.
Nope. These need to come out of a proper event interface.  The load 
involved in doing
polling on sysfs is huge and gets very rude responses from GregKH and 
others.
As this patch will go via Greg after me, you really don't want to do this!
+------------------------------------------------------------------------------
+If streaming to a userspace application, the recommended way to access 
gyro/accel/compass
+data is via /dev/iio:device0. Follow these steps to get constant 
readings from
+the driver:
It will only be /dev/iio:device[0] if this is the first iio device added....
+
+1. Write a 1 to power_state to turn on the chip. This is the default 
setting
+   after installing the driver.
+2. Write the desired output rate to fifo_rate.
err. fifo_rate is documented.  It is probably what we would normally map to
sampling_frequency. I'm guessing there may be additional sampling 
frequencies
for the motion calculation units?  We may need to think hard about how 
to control
those?  To my mind there ought to be an 'ideal' set of values for a 
given output
rate from the firmware processing.
+3. write 1 to enable to turn on the event.
+4. Read /dev/iio:device0 to get a string of gyro/accel/compass data.
+5. Parse this string to obtain each gyro/accel/compass element.
+6. If dmp firmware code is loaded, using "dmp_on" to enable/disable dmp .
+7. If compass is enabled, output will have compass data.
+===========================================================================
+                    Recommended sysfs entry setup senquence
+1. without DMP firmware
+1.1 set "power_state" to 1,
+1.2 change scale and fifo rate value to your need.
+1.3 change gyro_enable and accle_enable and compass_enable to your 
needs. For example,
+if you want gyro only, set accl_enable to 0 or set accl_enable to zero 
and compass_enable to zero.
+If you want accel only, set gyro_enable to 0 or set gyro_enable to zero 
and compass_enable to zero.
+If you want compass only, disable gyro and accel.
+1.4 set "enable" to 1. you will get output you want.
+
+2. With DMP firmware
+2.1 set "power_state" to 1,
+2.2 write "0" to firmware_loaded if it is not zero already.
+2.3 load firmware into "dmp_firmware" as a whole. Don't split the DMP 
firmware image.
+2.4 make sure firmware_loaded is 1 after loading.
+2.5 make other configurations similar to the situation as without DMP 
firmware.
+2.6 set dmp_on to 1.
+2.7 set "enable" to 1.
+=======================================================
+The enable function is using enable entry under 
"/sys/bus/iio/devices/iio:device0/buffer"
+==========================================================
+test applications:
+Test application is mpu_iio
provided here?
+------------------------------------------
+To run with MPU9150/MPU6050:
+using the following command:
+for orientation/tap/flick/display orientation event:
+mpu_iio  -c 10 -l 3 -p
+for normal data print
+mpu_iio  -c 10 -l 3 -r
+----------------------------------------
+Please use mpu_iio.c and iio_utils.h as the sample code for your 
development.
diff --git a/drivers/staging/iio/imu/mpu6050/dmpDefaultMPU6050.c 
b/drivers/staging/iio/imu/mpu6050/dmpDefaultMPU6050.c
new file mode 100644
index 0000000..5803643
--- /dev/null
+++ b/drivers/staging/iio/imu/mpu6050/dmpDefaultMPU6050.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2012 Invensense, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include "dmpKey.h"
+#include "dmpmap.h"
+
Some of these are less than entirely obvious. Perhaps some comments
would help?
+#define CFG_27                  (2745)
...
+
I hate to point out the obvious, but a macro might
serve better here.
#define D(a, b) (a*256 + b)
+#define D_1_2                   (256 + 2)
+#define D_1_4                   (256 + 4)
...

+
+#define D_HOST_NO_MOT          (976)
+
So a lot of the above is about providing the config?
Loose the defines and put them straight into here
e.g.

static const struct tkeyLabel dmpTConfig[] = {
        {KEY_CFG_27, 2745}, etc.
+static const struct tKeyLabel dmpTConfig[] = {
+	{KEY_CFG_27,                    CFG_27},
+	{KEY_CFG_20,                    CFG_20},
....

+};
+#define NUM_LOCAL_KEYS (sizeof(dmpTConfig)/sizeof(dmpTConfig[0]))
kernel has ARRAY_SIZE macro
+
+static struct tKeyLabel keys[NUM_KEYS];
+
+unsigned short inv_dmp_get_address(unsigned short key)
+{
+	static int isSorted;
Is this going to play well if you have more than one of your chips present?
Possibly, I haven't really thought it through!
+	if (!isSorted) {
+		int kk;
+		for (kk = 0; kk < NUM_KEYS; ++kk) {
+			keys[kk].addr = 0xffff;
+			keys[kk].key = kk;
+		}
+		for (kk = 0; kk < NUM_LOCAL_KEYS; ++kk)
+			keys[dmpTConfig[kk].key].addr = dmpTConfig[kk].addr;
+		isSorted = 1;
+	}
+	if (key >= NUM_KEYS)
+		return 0xffff;
+	return keys[key].addr;
+}
+/**
+ *  @}
+ */
diff --git a/drivers/staging/iio/imu/mpu6050/dmpKey.h 
b/drivers/staging/iio/imu/mpu6050/dmpKey.h
new file mode 100644
index 0000000..e8e1951
--- /dev/null
+++ b/drivers/staging/iio/imu/mpu6050/dmpKey.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2012 Invensense, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef DMPKEY_H__
+#define DMPKEY_H__
+
Not sure the stringing them off the previous is a good idea.
If they really are always like this, then use an enum instead.
+#define KEY_CFG_25                  (0)
+#define KEY_CFG_24                  (KEY_CFG_25 + 1)
,,,

+
+struct tKeyLabel  {
+	unsigned short key;
+	unsigned short addr;
+};
+
This is an 'interesting' set of defines.
Why not just use the value in the code?
Or for that matter put them in order...

+#define DINA0A 0x0a
+#define DINA22 0x22
...
+
+#endif
diff --git a/drivers/staging/iio/imu/mpu6050/dmpmap.h 
b/drivers/staging/iio/imu/mpu6050/dmpmap.h
new file mode 100644
index 0000000..420e19d
--- /dev/null
+++ b/drivers/staging/iio/imu/mpu6050/dmpmap.h
@@ -0,0 +1,17 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+*/
+
+#ifndef DMPMAP_H
+#define DMPMAP_H
+
If we are going to have this, perhaps have some documenation?
Also it's only included from one place that I can see. Just flatten
it in there and drop this header.

+#define DMP_PTAT    0
+#define DMP_XGYR    2
...
+
+#endif
diff --git a/drivers/staging/iio/imu/mpu6050/inv_mpu_iio.h 
b/drivers/staging/iio/imu/mpu6050/inv_mpu_iio.h
new file mode 100644
index 0000000..0958d4a
--- /dev/null
+++ b/drivers/staging/iio/imu/mpu6050/inv_mpu_iio.h
@@ -0,0 +1,25 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+*/
+
+#ifndef _INV_MPU_IIO_H_
+#define _INV_MPU_IIO_H_
+
+#include <linux/i2c.h>
+#include <linux/kfifo.h>
+#include <linux/miscdevice.h>
+#include <linux/input.h>
+#include <linux/spinlock.h>
+#include "./mpu.h"
+#include "../../iio.h"
+#include "../../buffer.h"
Do these as <linux/iio/iio.h> etc.
Actually you seem to be on a somewhat out of data tree.  You'll
want to rebase on staging/staging-next before the next submission.

+#include "dmpKey.h"
+/**
Nice docs. Thanks.
+ *  struct inv_reg_map_s - Notable slave registers.
+ *  @sample_rate_div:	Divider applied to gyro output rate.
+ *  @lpf:		Configures internal LPF.
Spell it out, low_pass_filter (I guess?)
+ *  @bank_sel:		Selects between memory banks.
+ *  @user_ctrl:		Enables/resets the FIFO.
+ *  @fifo_en:		Determines which data will appear in FIFO.
+ *  @gyro_config:	gyro config register.
+ *  @accl_config:	accel config register
+ *  @fifo_count_h:	Upper byte of FIFO count.
+ *  @fifo_r_w:		FIFO register.
+ *  @raw_gyro		Address of first gyro register.
+ *  @raw_accl		Address of first accel register.
+ *  @temperature	temperature register
+ *  @int_enable:	Interrupt enable register.
+ *  @int_status:	Interrupt flags.
+ *  @pwr_mgmt_1:	Controls chip's power state and clock source.
+ *  @pwr_mgmt_2:	Controls power state of individual sensors.
+ *  @mem_start_addr:	Address of first memory read.
+ *  @mem_r_w:		Access to memory.
+ *  @prgm_strt_addrh	firmware program start address register
+ */
+struct inv_reg_map_s {
+	unsigned char sample_rate_div;
As in kernel, u8 is the right type to use.
+	unsigned char lpf;
....
+	const short *compass_st_lower;
+	short irq;
+	int accel_bias[3];
+	int gyro_bias[3];
I'd use fixed length types s16 perhaps?
+	short raw_gyro[3];
+	short raw_accel[3];
+	short raw_compass[3];
+	unsigned char compass_scale;
+	unsigned char i2c_addr;
+	unsigned char compass_divider;
+	unsigned char compass_counter;
+	unsigned char sample_divider;
+	unsigned char fifo_divider;
+	unsigned char orient_data;
+	unsigned char display_orient_data;
+	unsigned char tap_data;
+	enum inv_channel_num num_channels;
+	void *sl_handle;
+	unsigned int irq_dur_ns;
+	long long last_isr_time;
+#ifdef CONFIG_INV_TESTING
+	unsigned long i2c_readcount;
+	unsigned long i2c_writecount;
+#endif
+};
+

+	int (*setup)(struct inv_mpu_iio_s *);
+	int (*combine_data)(unsigned char *in, short *out);
+	int (*get_mode)(struct inv_mpu_iio_s *);
+	int (*set_lpf)(struct inv_mpu_iio_s *, int rate);
+	int (*set_fs)(struct inv_mpu_iio_s *, int fs);
+};
+
Are these specific to your handling or to the AKM chips themselves?
If the akm chips, should be in a separate header.
I'd much rather see a generic driver for these with the extra
hooks you need rather than rolling them into your driver and having
lots of code repitition.

+/* AKM definitions */
+#define REG_AKM_ID               0x00
+#define REG_AKM_STATUS           0x02
+#define REG_AKM_MEASURE_DATA     0x03
+#define REG_AKM_MODE             0x0A
+#define REG_AKM_ST_CTRL          0x0C

...
+	ATTR_COMPASS_ENABLE,
+	ATTR_POWER_STATE,
+	ATTR_FIRMWARE_LOADED,
Clear these out, or do them as a debugfs interface as some
other drivers use.
+#ifdef CONFIG_INV_TESTING
+	ATTR_I2C_COUNTERS,
+	ATTR_REG_WRITE,
+#endif
+};
+
+enum inv_accl_fs_e {
+	INV_FS_02G = 0,
+	INV_FS_04G,
+	INV_FS_08G,
+	INV_FS_16G,
+	NUM_ACCL_FSR
+};
...
+int inv_i2c_read_base(struct inv_mpu_iio_s *st, unsigned short i2c_addr,
+	unsigned char reg, unsigned short length, unsigned char *data);
This isn't defined anywhere that I can see? Each patch should stand on its
own. If I can't build them one at a time then I reject them.  This is
vital in a more general sense for kernel development as we HAVE to have
a bisectable set of patches.

+int inv_i2c_single_write_base(struct inv_mpu_iio_s *st,
+	unsigned short i2c_addr, unsigned char reg, unsigned char data);
+int inv_do_test(struct inv_mpu_iio_s *st, int self_test_flag,
+		int *gyro_result, int *accl_result);
+int mpu_memory_write(struct i2c_adapter *i2c_adap,
+			    unsigned char mpu_addr,
+			    unsigned short mem_addr,
+			    unsigned int len, unsigned char const *data);
+int mpu_memory_read(struct i2c_adapter *i2c_adap,
+			   unsigned char mpu_addr,
+			   unsigned short mem_addr,
+			   unsigned int len, unsigned char *data);
+int inv_hw_self_test(struct inv_mpu_iio_s *st);
+
+#define mem_w(a, b, c) mpu_memory_write(st->sl_handle,\
+			st->i2c_addr, a, b, c)
+#define mem_w_key(key, b, c) mpu_memory_write(st->sl_handle,\
+			st->i2c_addr, inv_dmp_get_address(key), b, c)
+#define inv_i2c_read(st, reg, len, data) \
+	inv_i2c_read_base(st, st->i2c_addr, reg, len, data)
+#define inv_i2c_single_write(st, reg, data) \
+	inv_i2c_single_write_base(st, st->i2c_addr, reg, data)
+#define inv_secondary_read(reg, len, data) \
+	inv_i2c_read_base(st, st->plat_data.secondary_i2c_addr, reg, len, data)
+#define inv_secondary_write(reg, data) \
+	inv_i2c_single_write_base(st, st->plat_data.secondary_i2c_addr, \
+		reg, data)
+#endif  /* #ifndef _INV_MPU_IIO_H_ */
+
diff --git a/drivers/staging/iio/imu/mpu6050/inv_mpu_ring.c 
b/drivers/staging/iio/imu/mpu6050/inv_mpu_ring.c
new file mode 100644
index 0000000..528da5f
--- /dev/null
+++ b/drivers/staging/iio/imu/mpu6050/inv_mpu_ring.c
@@ -0,0 +1,44 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+*/
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
...

+static void inv_scan_query(struct iio_dev *indio_dev)
+{
+	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
+	struct iio_buffer *ring = indio_dev->buffer;
+
+	if (iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_X) ||
+	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_Y) ||
+	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_Z))
+		st->chip_config.gyro_fifo_enable = 1;
st->chip_config.gyro_fifo_enable =
	iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_X) ||
	iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_Y) ||
         iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_GYRO_Z);
+	else
+		st->chip_config.gyro_fifo_enable = 0;
+
+	if (iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_ACCL_X) ||
+	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_ACCL_Y) ||
+	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_ACCL_Z))
+		st->chip_config.accl_fifo_enable = 1;
+	else
+		st->chip_config.accl_fifo_enable = 0;
+
+	if (iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_MAGN_X) ||
+	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_MAGN_Y) ||
+	    iio_scan_mask_query(indio_dev, ring, INV_MPU_SCAN_MAGN_Z))
+		st->chip_config.compass_fifo_enable = 1;
+	else
+		st->chip_config.compass_fifo_enable = 0;
+}
+
+/**
+ *  reset_fifo_itg() - Reset FIFO related registers.
+ *  @st:	Device driver instance.
+ */
+static int reset_fifo_itg(struct iio_dev *indio_dev)
+{
+	struct inv_reg_map_s *reg;
+	int result;
+	unsigned char val;
+	struct inv_mpu_iio_s  *st = iio_priv(indio_dev);
I'd just use st->reg directly, can't see why taking a copy
helps other than confusing me slightly ;)
+	reg = &st->reg;
+
+	inv_scan_query(indio_dev);
+	/* disable interrupt */
+	result = inv_i2c_single_write(st, reg->int_enable, 0);
+	if (result) {
+		pr_err("int_enable write failed\n");
+		return result;
+	}
+	/* disable the sensor output to FIFO */
+	result = inv_i2c_single_write(st, reg->fifo_en, 0);
+	if (result)
+		goto reset_fifo_fail;
....
+	return result;
+}
+

As functions go, this one currently doesn't seem to have
a great deal of point... drop it, you can always introduce
it later if it has more to do.
+/**
+ *  inv_reset_fifo() - Reset FIFO related registers.
+ *  @st:	Device driver instance.
+ */
+static int inv_reset_fifo(struct iio_dev *indio_dev)
+{
+	return reset_fifo_itg(indio_dev);
+}
+
....
+/**
+ *  inv_clear_kfifo() - clear time stamp fifo
+ *  @st:	Device driver instance.
+ */
+void inv_clear_kfifo(struct inv_mpu_iio_s *st)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&st->time_stamp_lock, flags);
+	kfifo_reset(&st->timestamps);
+	spin_unlock_irqrestore(&st->time_stamp_lock, flags);
+}
+
...
+
+/**
+ *  inv_read_fifo() - Transfer data from FIFO to ring buffer.
+ */
+irqreturn_t inv_read_fifo(int irq, void *dev_id)
+{
+
Bonus blank line here.  Yup, I'm getting nitpicky ;)
+	struct inv_mpu_iio_s *st = (struct inv_mpu_iio_s *)dev_id;
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	size_t bytes_per_datum;
+	int result;
+	unsigned char data[BYTES_FOR_DMP + QUATERNION_BYTES];
+	unsigned short fifo_count;
+	unsigned int copied;
+	s64 timestamp;
+	struct inv_reg_map_s *reg;
+	s64 buf[8];
+	unsigned char *tmp;
+	reg = &st->reg;
Given the number of repeats of checking if anything is turned on,
perhaps a inv_anything_enabled inline function might make for shorter 
easier to read
code.
+	if (!(st->chip_config.accl_fifo_enable |
+		st->chip_config.gyro_fifo_enable |
+		st->chip_config.dmp_on |
+		st->chip_config.compass_fifo_enable))
+		goto end_session;
...
+
+int inv_postenable(struct iio_dev *indio_dev)
+{
+	return set_inv_enable(indio_dev, true);
bonus blank line.  This formatting stuff does matter if you
are reviewing a lot of code. Makes it simpler to do.
+
+}
+
+int inv_predisable(struct iio_dev *indio_dev)
+{
+	return set_inv_enable(indio_dev, false);
+}
+
+static const struct iio_buffer_setup_ops inv_mpu_ring_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
+	.postenable = &inv_postenable,
+	.predisable = &inv_predisable,
+};
+
+int inv_mpu_configure_ring(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct inv_mpu_iio_s *st = iio_priv(indio_dev);
+	struct iio_buffer *ring;
+
+	ring = iio_kfifo_allocate(indio_dev);
+	if (!ring)
+		return -ENOMEM;
+	indio_dev->buffer = ring;
+	/* setup ring buffer */
+	ring->scan_timestamp = true;
+	indio_dev->setup_ops = &inv_mpu_ring_setup_ops;
+	/*scan count double count timestamp. should subtract 1. but
+	number of channels still includes timestamp*/
+	ret = request_threaded_irq(st->client->irq, inv_irq_handler,
+				   inv_read_fifo,
+				   IRQF_TRIGGER_RISING | IRQF_SHARED,
+				   "inv_irq", st);
+	if (ret)
+		goto error_iio_sw_rb_free;
+
+	return 0;
+error_iio_sw_rb_free:
+	iio_kfifo_free(indio_dev->buffer);
+	return ret;
+}

+/**
+ *  @}
+ */
+
diff --git a/drivers/staging/iio/imu/mpu6050/mpu.h 
b/drivers/staging/iio/imu/mpu6050/mpu.h
new file mode 100644
index 0000000..5105fb2
--- /dev/null
+++ b/drivers/staging/iio/imu/mpu6050/mpu.h
@@ -0,0 +1,15 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+*/
+
+/**
I may be missing something but is this kerneldoc? If not it doesn't
belong in a kernel driver...
+ *  @addtogroup  DRIVERS
+ *  @brief       Hardware drivers.
+ *
+ *  @{
+ *      @file    mpu.h
+ *      @brief   mpu definition
+ */
+
+#ifndef __MPU_H_
+#define __MPU_H_
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#endif
+
+enum secondary_slave_type {
+	SECONDARY_SLAVE_TYPE_NONE,
+	SECONDARY_SLAVE_TYPE_ACCEL,
+	SECONDARY_SLAVE_TYPE_COMPASS,
+	SECONDARY_SLAVE_TYPE_PRESSURE,
+
+	SECONDARY_SLAVE_TYPE_TYPES
+};
+
+};
+
+#define INV_PROD_KEY(ver, rev) (ver * 100 + rev)
blank line here please.
+/**
+ * struct mpu_platform_data - Platform data for the mpu driver
+ * @int_config:		Bits [7:3] of the int config register.
+ * @level_shifter:	0: VLogic, 1: VDD
+ * @orientation:	Orientation matrix of the gyroscope
+ * @sec_slave_type:     secondary slave device type, can be compass, 
accel, etc
+ * @sec_slave_id:       id of the secondary slave device
+ * @secondary_i2c_address: secondary device's i2c address
+ * @secondary_orientation: secondary device's orientation matrix
+ *
+ * Contains platform specific information on how to configure the 
MPU3050 to
+ * work on this platform.  The orientation matricies are 3x3 rotation 
matricies
+ * that are applied to the data to rotate from the mounting orientation 
to the
+ * platform orientation.  The values must be one of 0, 1, or -1 and 
each row and
+ * column should have exactly 1 non-zero value.
+ */
+struct mpu_platform_data {
why the __ versions?
+	__u8 int_config;
+	__u8 level_shifter;
+	__s8 orientation[9];
+	enum secondary_slave_type sec_slave_type;
+	enum ext_slave_id sec_slave_id;
+	__u16 secondary_i2c_addr;
+	__s8 secondary_orientation[9];
+	__u8 key[16];
+};
+
+#endif	/* __MPU_H_ */
-- 
1.7.0.4

