Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:59636 "EHLO
	5.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbH1II7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2015 04:08:59 -0400
Received: from mail425.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo69.mail-out.ovh.net (Postfix) with SMTP id 0ABBDFFA8E2
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2015 09:32:05 +0200 (CEST)
Mime-Version: 1.0
Date: Fri, 28 Aug 2015 07:32:02 +0000
Content-Type: text/plain; charset="utf-8"
Message-ID: <3d9e0164f7d0186d5c6385622dff7e4d@rainloop.corna.info>
From: "Nicola Corna" <nicola@corna.info>
Subject: Re: [PATCH 2/3] iio:humidity:si7020: added No Hold read mode
To: "Jean Delvare" <jdelvare@suse.de>,
	"Jonathan Cameron" <jic23@kernel.org>,
	"Wolfram Sang" <wsa@the-dreams.de>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,
	"Peter Meerwald" <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	"Hartmut Knaack" <knaack.h@gmx.de>
In-Reply-To: <1440686436.25403.13.camel@chaos.site>
References: <1440686436.25403.13.camel@chaos.site>
 <55D88078.5080006@kernel.org>
 <1440079909-1337-1-git-send-email-nicola@corna.info>
 <1440079909-1337-2-git-send-email-nicola@corna.info>
 <8bdb2c60fd1785b1d814277769881f08@rainloop.corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

August 27 2015 4:40 PM, "Jean Delvare" <jdelvare@suse.de> wrote:

> Le Sunday 23 August 2015 à 09:50 +0000, Nicola Corna a écrit :
> 
>> August 22 2015 4:00 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:
>>> On 20/08/15 15:11, Nicola Corna wrote:
>>> 
>>>> The Si7013/20/21 modules support 2 read modes:
>>>> * Hold mode, where the device stretches the clock until the end of the
>>>> measurement
>>>> * No Hold mode, where the device replies NACK for every I2C call during
>>>> the measurement
>>>> Here the No Hold mode is implemented, selectable with the boolean
>>>> parameter holdmode=N. The No Hold mode is less efficient, since it
>>>> requires multiple calls to the device, but it can be used as a fallback if
>>>> the clock stretching is not supported.
>>> 
>>> Interesting. Strikes me as something that should really be handled via the i2c
>>> core (and device tree or similar bindings) rather than inside a driver as
>>> a module parameter. Perhaps info provided to the i2c client driver
>>> via a check on whether the device supports clock stretching?
> 
> There currently is no way for bus drivers to report whether they support
> clock stretching or not. We could add a functionality flag for this,
> like:
> 
> #define I2C_FUNC_NO_CLK_STRETCH 0x00000040 /* No check for SCL low */
> 
> For example i2c-algo-bit would set this flag if no getscl callback is
> provided.

Something like this?

---
 drivers/i2c/algos/i2c-algo-bit.c | 5 ++++-
 include/uapi/linux/i2c.h         | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 899bede..618deb3 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -605,7 +605,10 @@ static u32 bit_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_NOSTART | I2C_FUNC_SMBUS_EMUL |
 	       I2C_FUNC_SMBUS_READ_BLOCK_DATA |
 	       I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
-	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
+	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING |
+	       (((struct i2c_algo_bit_data *)adap->algo_data)->getscl ?
+	       0 : I2C_FUNC_NO_CLK_STRETCH);
+
 }
 
 
diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index b0a7dd6..59e4b43 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -88,6 +88,7 @@ struct i2c_msg {
 #define I2C_FUNC_SMBUS_PEC		0x00000008
 #define I2C_FUNC_NOSTART		0x00000010 /* I2C_M_NOSTART */
 #define I2C_FUNC_SLAVE			0x00000020
+#define I2C_FUNC_NO_CLK_STRETCH		0x00000040 /* No check for SCL low */
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000
 #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000
-- 

Why do we have to use a negative flag? Doesn't it make more sense to use a
I2C_FUNC_CLK_STRETCH flag and add it to every device that supports it?

>> Reasonable, but we also have to consider that:
>> * it can happen that the device supports clock stretching but it is bugged
>> (like the Raspberry Pi)
> 
> I can't really see the difference between "supports clock stretching but
> it is bugged" and "does not support clock stretching.
> 
>> * with the clock stretching the i2c bus is completely locked until the end of
>> the measurement (which can take up to 22.8 ms), while with the No Hold mode the
>> bus is used every 2-6 ms for very short periods (with a i2c clock at 100 KHz,
>> each call takes 0.1 ms)
> 
> I2C puts no limit on clock stretching and SMBus allows for up to 50 ms,
> so hopefully 22.8 ms should be non-fatal in most cases. But I understand
> there may be latency concerns.
> 
>> In some cases the No Hold mode is preferable, even if the clock stretching is
>> supported and working.
> 
> Got it. But something like I2C_FUNC_NO_CLK_STRETCH would let drivers
> pick a sane default at least.

I've looked for similar situations in the kernel code and I've found this module
https://github.com/torvalds/linux/blob/master/Documentation/hwmon/shtc1
The situation is identical, but here the developer used shtc1_platform_data to
pass the parameter. This solution seems better to me (multiple instances can
have different parameters), but can a parameter in a platform_data be passed
with a userspace instantiation?

>>> I'd like input from Jean on this.
> 
> In fact you wanted input from Wolfram (Cc'd) as the new (you know, like
> for 3 years now) maintainer of the i2c subsystem ;-)
> 
> --
> Jean Delvare
> SUSE L3 Support
