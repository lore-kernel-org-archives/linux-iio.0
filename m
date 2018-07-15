Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40040 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeGOKF7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jul 2018 06:05:59 -0400
Date: Sun, 15 Jul 2018 15:13:29 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Frey <dfrey@sierrawireless.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180715094329.GA6917@himanshu-Vostro-3559>
References: <1531311229-3586-1-git-send-email-himanshujha199640@gmail.com>
 <a33aa270-2c8b-7590-f1fc-1a22b4a8b2cf@sierrawireless.com>
 <20180714073341.GA6542@himanshu-Vostro-3559>
 <20180715101036.06d763e2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180715101036.06d763e2@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Jul 15, 2018 at 10:10:36AM +0100, Jonathan Cameron wrote:
> On Sat, 14 Jul 2018 13:03:42 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > Hi David,
> > 
> > On Fri, Jul 13, 2018 at 01:42:35PM -0700, David Frey wrote:
> > > Hi Himanshu Jha,
> > > 
> > > First a bit of background.  I'm working on a device which will contain a
> > > bme680 sensor.  A colleague of mine started work on a Linux kernel driver
> > > for the chip a little while ago.  The (WIP) driver can be found here:
> > > https://github.com/mangOH/mangOH/tree/master/linux_kernel_modules/bme680  
> > 
> > Great!
> > 
> > > This driver is written targeting an older kernel (3.18.x) because that's the
> > > kernel we're stuck on for now.  Rather than writing the driver from scratch,
> > > what we did was write the Linux kernel driver as a wrapper around the Bosch
> > > code.  My theory at the time was that Bosch made the chip, so they probably
> > > know what they're doing when it comes to writing a driver library.  After
> > > having looked at the code in more detail, I'm less confident that our
> > > approach was the best one.  I'm not attempting to upstream the driver built
> > > by my colleague and I'm not trying to request review of this code either.  I
> > > simply want to make you aware of it so that you can look at it to get some
> > > ideas.  
> > 
> > Thanks for taking your time to review.
> > 
> > > I have included a number of comments on your driver below.  Keep up the good
> > > work!
> > >   
> > > >+++ b/drivers/iio/chemical/bme680.h
> > > >@@ -0,0 +1,99 @@
> > > >+/* SPDX-License-Identifier: GPL-2.0 */
> > > >+#ifndef BME680_H_
> > > >+#define BME680_H_
> > > >+
> > > >+#define BME680_REG_CHIP_I2C_ID			0xD0
> > > >+#define BME680_REG_CHIP_SPI_ID			0x50
> > > >+#define BME680_CHIP_ID_VAL			0x61  
> > > Try to be consistent with the indenting of the defines.  I think this would
> > > be clearest:
> > > #define BME680_REG_X			0x00
> > > #define   BME680_X_FOO_EN_MASK		BIT(0)
> > > #define   BME680_X_BAR_MASK		GENMASK(3, 1)
> > > #define     BME680_BAR_VAL1		3
> > > #define     BME680_BAR_VAL2		7
> > > 
> > > This way the register, field definition and field values are all visually
> > > distinctive.  
> > 
> > I have used this pattern everywhere where applicable. But not applied
> > for *_VAL, would definitely follow this up.
> > 
> > > >+#define BME680_REG_SOFT_RESET			0xE0  
> > > The datasheet says that the soft reset register differs for I2C and SPI.
> > > For I2C it is 0xE0 and for SPI it is 0x60 when page 0 is selected.  
> > 
> > That's really a stupid mistake :(
> > I have exported these individual initialization code in the I2C & SPI
> > drivers respectively but it slipped my mind somehow. This device has 
> > peculiar characteristics in register addressing.
> > 
> > I will correct this in next version.
> > 
> > > >+#define BME680_CMD_SOFTRESET			0xB6
> > > >+#define BME680_REG_STATUS			0x73
> > > >+#define   BME680_SPI_MEM_PAGE_BIT		BIT(4)
> > > >+#define   BME680_SPI_MEM_PAGE_1_VAL		1
> > > >+
> > > >+#define BME680_OSRS_TEMP_X(osrs_t)		((osrs_t) << 5)
> > > >+#define BME680_OSRS_PRESS_X(osrs_p)		((osrs_p) << 2)
> > > >+#define BME680_OSRS_HUMID_X(osrs_h)		((osrs_h) << 0)  
> > > You could use the FIELD_PREP macro from <linux/bitfield.h> to eliminate the
> > > need for these macros.  For example:
> > > ctrl_meas_reg = FIELD_PREP(BME680_OSRS_TEMP_MASK, temp_val) |
> > >                 FIELD_PREP(BME680_OSRS_PRESS_MASK, press_val) |
> > >                 FIELD_PREP(BME880_MODE_MASK, mode_val);  
> > 
> > Ah, yes! I didn't knew about these magic macros. It will remove some
> > log2() computation hacks from my code.
> > 
> > > >+
> > > >+#define BME680_REG_TEMP_MSB			0x22
> > > >+#define BME680_REG_PRESS_MSB			0x1F
> > > >+#define BM6880_REG_HUMIDITY_MSB			0x25
> > > >+#define BME680_REG_GAS_MSB			0x2A
> > > >+#define BME680_REG_GAS_R_LSB			0x2B
> > > >+#define   BME680_GAS_STAB_BIT			BIT(4)
> > > >+
> > > >+#define BME680_REG_CTRL_HUMIDITY		0x72
> > > >+#define   BME680_OSRS_HUMIDITY_MASK		GENMASK(2, 0)
> > > >+
> > > >+#define BME680_REG_CTRL_MEAS			0x74
> > > >+#define   BME680_OSRS_TEMP_MASK			GENMASK(7, 5)
> > > >+#define   BME680_OSRS_PRESS_MASK		GENMASK(4, 2)
> > > >+#define   BME680_MODE_MASK			GENMASK(1, 0)
> > > >+
> > > >+#define BME680_MODE_FORCED			BIT(0)
> > > >+#define BME680_MODE_SLEEP			0  
> > > This should be:
> > > #define BME680_MODE_SLEEP			0
> > > #define BME680_MODE_FORCED			1  
> > 
> > Yes, this is much clearer and removes ambiguity.
> > 
> > > >+/* Taken from Bosch BME680 API */  
> > > 
> > > I think there should be a link to the Bosch code
> > > (https://github.com/BoschSensortec/BME680_driver/) somewhere within the
> > > comments of this file.  Maybe it belongs at the top of this file?  
> > 
> > I planned to add:
> > https://github.com/BoschSensortec/BME680_driver/blob/63bb5336db4659519860832be2738c685133aa33/bme680.c#L876
> > to here and likewise to other compensate functions.
> > But these links may change(if somehow they plan to migrate to Gitlab),
> > long lines are not welcomed.
> 
> Looks like github does the same trick kernel.org does in allowing shortened hashes.

$ git log --abbrev-commit ...

> I think
> 
> https://github.com/BoschSensortec/BME680_driver/blob/63bb5336/bme680.c#L876
> Is the same thing and under 80 chars (just) :)

Ah, yes :)
Perfect!

> > You could also notice that I haven't included datasheet link at the top
> > of this file. Well, most of the companies change the links when releasing
> > the new Revision(Rev. A,B,...) so it is likely that the link would be
> > dead/old lying at the top of source.
> 
> Even though this happens, it's better to have something than nothing
> perhaps.

Sure! Will add both links in next version.

> > Yes, we can do that but, for a while, I am following my GSoC proposal
> > timeline. And I have planned these check_bits function later, but since
> > this check_bits function was imperative in gas sensing, therefore I
> > included them now.
> > 
> > My plan in incremental changes and this patch is kindof minimal. I have
> > tested the sensor several times and found no errors in readings for
> > T P H G readings so far.
> > 
> > The problem arises that this sensor is made to work in a T->P->H->G
> > fashion and every channel is mostly dependent on the other. And IIO
> > driver design pattern isn't the best choice it. You can't just take a
> > single channel readings by running Bosch Code because it is not designed
> > like that.
> > 
> > For instance: we need t_fine values for pressure/humidity compensation
> > functions which we only get when reading temperature. So, you need to
> > run the temperaure cycle if you need pressure/humidity values. And this
> > is what I did by doing a dummy read_temp(data, NULL, NULL) to get the t_fine
> > value.
> 
> This pattern isn't that unusual in devices.   Normally you do it pretty
> much the way you have.  The sysfs interface in IIO is just interested
> in data presentation, we don't care what you have to do to get it ;)

OK. I agree, but will create a new thread for some
clarification/rectification of IIO core.

> This will fit much better when doing buffered interfaces anyway which
> naturally grab sets of channels.

Yes, I think so it work better in that way.
Also, for industrial use I think buffered interface is a better option.

> > Thanks you so much for the feedback, David! :)
> > 
> > And if at some point I have said something stupid, then please forgive me.
> > 
> > I am a 3rd year undergrad student and started with IIO few months back, and
> > not a Bosch driver developer ;)
> > 
> Going well so far ;)

Thanks Jonathan again :)

Well it is better to hint developers that you're a student, else I had a
discussion in the past where some senior developer was explaining me
about CPU profiling (I don't remember exactly) and it didn't even hit me
for the next two weeks ;)

But I would like David to review the patches in the next version too.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
