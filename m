Return-Path: <SRS0=8Hxl=J6=gmail.com=himanshujha199640@kernel.org>
Date: Sat, 14 Jul 2018 13:03:42 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dfrey@sierrawireless.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180714073341.GA6542@himanshu-Vostro-3559>
References: <1531311229-3586-1-git-send-email-himanshujha199640@gmail.com>
 <a33aa270-2c8b-7590-f1fc-1a22b4a8b2cf@sierrawireless.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a33aa270-2c8b-7590-f1fc-1a22b4a8b2cf@sierrawireless.com>
List-ID: <linux-iio@vger.kernel.org>

Hi David,

On Fri, Jul 13, 2018 at 01:42:35PM -0700, David Frey wrote:
> Hi Himanshu Jha,
> 
> First a bit of background.  I'm working on a device which will contain a
> bme680 sensor.  A colleague of mine started work on a Linux kernel driver
> for the chip a little while ago.  The (WIP) driver can be found here:
> https://github.com/mangOH/mangOH/tree/master/linux_kernel_modules/bme680

Great!

> This driver is written targeting an older kernel (3.18.x) because that's the
> kernel we're stuck on for now.  Rather than writing the driver from scratch,
> what we did was write the Linux kernel driver as a wrapper around the Bosch
> code.  My theory at the time was that Bosch made the chip, so they probably
> know what they're doing when it comes to writing a driver library.  After
> having looked at the code in more detail, I'm less confident that our
> approach was the best one.  I'm not attempting to upstream the driver built
> by my colleague and I'm not trying to request review of this code either.  I
> simply want to make you aware of it so that you can look at it to get some
> ideas.

Thanks for taking your time to review.

> I have included a number of comments on your driver below.  Keep up the good
> work!
> 
> >+++ b/drivers/iio/chemical/bme680.h
> >@@ -0,0 +1,99 @@
> >+/* SPDX-License-Identifier: GPL-2.0 */
> >+#ifndef BME680_H_
> >+#define BME680_H_
> >+
> >+#define BME680_REG_CHIP_I2C_ID			0xD0
> >+#define BME680_REG_CHIP_SPI_ID			0x50
> >+#define BME680_CHIP_ID_VAL			0x61
> Try to be consistent with the indenting of the defines.  I think this would
> be clearest:
> #define BME680_REG_X			0x00
> #define   BME680_X_FOO_EN_MASK		BIT(0)
> #define   BME680_X_BAR_MASK		GENMASK(3, 1)
> #define     BME680_BAR_VAL1		3
> #define     BME680_BAR_VAL2		7
> 
> This way the register, field definition and field values are all visually
> distinctive.

I have used this pattern everywhere where applicable. But not applied
for *_VAL, would definitely follow this up.

> >+#define BME680_REG_SOFT_RESET			0xE0
> The datasheet says that the soft reset register differs for I2C and SPI.
> For I2C it is 0xE0 and for SPI it is 0x60 when page 0 is selected.

That's really a stupid mistake :(
I have exported these individual initialization code in the I2C & SPI
drivers respectively but it slipped my mind somehow. This device has 
peculiar characteristics in register addressing.

I will correct this in next version.

> >+#define BME680_CMD_SOFTRESET			0xB6
> >+#define BME680_REG_STATUS			0x73
> >+#define   BME680_SPI_MEM_PAGE_BIT		BIT(4)
> >+#define   BME680_SPI_MEM_PAGE_1_VAL		1
> >+
> >+#define BME680_OSRS_TEMP_X(osrs_t)		((osrs_t) << 5)
> >+#define BME680_OSRS_PRESS_X(osrs_p)		((osrs_p) << 2)
> >+#define BME680_OSRS_HUMID_X(osrs_h)		((osrs_h) << 0)
> You could use the FIELD_PREP macro from <linux/bitfield.h> to eliminate the
> need for these macros.  For example:
> ctrl_meas_reg = FIELD_PREP(BME680_OSRS_TEMP_MASK, temp_val) |
>                 FIELD_PREP(BME680_OSRS_PRESS_MASK, press_val) |
>                 FIELD_PREP(BME880_MODE_MASK, mode_val);

Ah, yes! I didn't knew about these magic macros. It will remove some
log2() computation hacks from my code.

> >+
> >+#define BME680_REG_TEMP_MSB			0x22
> >+#define BME680_REG_PRESS_MSB			0x1F
> >+#define BM6880_REG_HUMIDITY_MSB			0x25
> >+#define BME680_REG_GAS_MSB			0x2A
> >+#define BME680_REG_GAS_R_LSB			0x2B
> >+#define   BME680_GAS_STAB_BIT			BIT(4)
> >+
> >+#define BME680_REG_CTRL_HUMIDITY		0x72
> >+#define   BME680_OSRS_HUMIDITY_MASK		GENMASK(2, 0)
> >+
> >+#define BME680_REG_CTRL_MEAS			0x74
> >+#define   BME680_OSRS_TEMP_MASK			GENMASK(7, 5)
> >+#define   BME680_OSRS_PRESS_MASK		GENMASK(4, 2)
> >+#define   BME680_MODE_MASK			GENMASK(1, 0)
> >+
> >+#define BME680_MODE_FORCED			BIT(0)
> >+#define BME680_MODE_SLEEP			0
> This should be:
> #define BME680_MODE_SLEEP			0
> #define BME680_MODE_FORCED			1

Yes, this is much clearer and removes ambiguity.

> >+/* Taken from Bosch BME680 API */
> 
> I think there should be a link to the Bosch code
> (https://github.com/BoschSensortec/BME680_driver/) somewhere within the
> comments of this file.  Maybe it belongs at the top of this file?

I planned to add:
https://github.com/BoschSensortec/BME680_driver/blob/63bb5336db4659519860832be2738c685133aa33/bme680.c#L876
to here and likewise to other compensate functions.
But these links may change(if somehow they plan to migrate to Gitlab),
long lines are not welcomed.

You could also notice that I haven't included datasheet link at the top
of this file. Well, most of the companies change the links when releasing
the new Revision(Rev. A,B,...) so it is likely that the link would be
dead/old lying at the top of source.

Therefore, I added both links to Bosch API and datasheet only in the
commmit log(also suggested by my mentor).

> >+static s32 bme680_compensate_temp(struct bme680_data *data,
> >+				  s32 adc_temp)
> >+{
> >+	struct bme680_calib *calib = &data->bme680;
> >+	s64 var1, var2, var3, calc_temp;
> >+
> >+	var1 = ((s32) adc_temp >> 3) - ((s32) calib->par_t1 << 1);
> >+	var2 = (var1 * (s32) calib->par_t2) >> 11;
> >+	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
> >+	var3 = ((var3) * ((s32) calib->par_t3 << 4)) >> 14;
> >+	data->t_fine = (s32) (var2 + var3);
> >+	calc_temp = (s16) (((data->t_fine * 5) + 128) >> 8);
> >+
> >+	return calc_temp;
> I think the meaning of the s32 returned should be documented.  Based on code
> elsewhere in the driver I'm guessing it's degrees celcius * 100. The same
> comment applies to the other compensate functions.

Yes, this function returns values like 3253(32.53degC), which I divide
in the read_temp() at last few lines:

	*val = bme680_compensate_temp();
	*val2 = 100;
	return IIO_VAL_FRACTIONAL;

You can only document when you have "official" references, I mean these
*should* have been documented in datasheet. And then we could say:

"Temperature has 100 degC .... Pg 21"

But these resolution information is what I got from Bosch when I
contacted them and also evident from README.md

https://github.com/BoschSensortec/BME680_driver/blob/63bb5336db4659519860832be2738c685133aa33/README.md#example-for-reading-all-sensor-data

	"printf("T: %.2f degC, P: %.2f hPa, H %.2f %%rH ",
				data.temperature / 100.0f,
				data.pressure / 100.0f,
				data.humidity / 1000.0f );"

And I am pretty sure they will add these information in the coming
revision of datasheet.

I have looked at the various family of sensors from Bosch and they even
mention the optimal oversampling ratio, filter coefficient, etc., for 
say "using in weather stations"(Take a look at bme280 datasheet)

[ market policy is what I heard somewhere ;) ]

> >+static int bme680_chip_config(struct bme680_data *data)
> >+{
> >+	struct device *dev = regmap_get_device(data->regmap);
> >+	int ret;
> >+	u8 osrs = BME680_OSRS_HUMID_X(data->oversampling_humid + 1);
> >+	/*
> >+	 * Highly recommended to set oversampling of humidity before
> >+	 * temperature/pressure oversampling.
> >+	 */
> I think you are referring to this snippet from the datasheet: "It is highly
> recommended to set first osrs_h<2:0> followed by osrs_t<2:0> and osrs_p<2:0>
> in one write command (see Section 3.3)."  My interpretation of this is that
> they are saying that you should do one bulk write rather than writing the
> fields individually.  Maybe they're just recommending this for efficiency
> reasons.  I'm not really sure though.  I read through section 3.3 and I
> couldn't find any justification to backup this rather prominent suggestion.

Yes, I referred to the same segment of article from datasheet.
But how do you do a bulk_write() for *two different* registers ?

We have humidity bit(osrs_h<2:0) at Ctrl_hum(0x72) register and
temperature(osrs_t), pressure bit(osrs_p) at Ctrl_meas(0x74) register.

So, I think it was setting humidity first perhaps and then doing the
rest.

Even Bosch is doing the reverse of what they say in the datasheet:
https://github.com/BoschSensortec/BME680_driver/blob/63bb5336db4659519860832be2738c685133aa33/bme680.c#L464

They are setting Temperature & Pressure _before_ humidity oversampling
setting. Weird!?

> >+static int bme680_read_temp(struct bme680_data *data,
> >+			    int *val, int *val2)
> >+{
> >+	struct device *dev = regmap_get_device(data->regmap);
> >+	int ret = 0;
> >+	__be32 tmp = 0;
> >+	s32 adc_temp, comp_temp;
> >+
> >+	/* set forced mode to trigger measurement */
> >+	ret = bme680_set_mode(data, true);
> >+	if (ret < 0)
> >+		return ret;
> >+
> >+	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
> >+			       (u8 *) &tmp, 3);
> >+	if (ret < 0) {
> >+		dev_err(dev, "failed to read temperature\n");
> >+		return ret;
> >+	}
> I think the value you're reading from the register may actually be from a
> previous request.  I think you need to poll meas_status_0 (0x1D) field
> new_data_0 (bit 7) to wait for new data after setting the mode to forced.
> You can see that's what Bosch's code does:
> https://github.com/BoschSensortec/BME680_driver/blob/63bb5336db4659519860832be2738c685133aa33/bme680.c#L1227

Yes, we can do that but, for a while, I am following my GSoC proposal
timeline. And I have planned these check_bits function later, but since
this check_bits function was imperative in gas sensing, therefore I
included them now.

My plan in incremental changes and this patch is kindof minimal. I have
tested the sensor several times and found no errors in readings for
T P H G readings so far.

The problem arises that this sensor is made to work in a T->P->H->G
fashion and every channel is mostly dependent on the other. And IIO
driver design pattern isn't the best choice it. You can't just take a
single channel readings by running Bosch Code because it is not designed
like that.

For instance: we need t_fine values for pressure/humidity compensation
functions which we only get when reading temperature. So, you need to
run the temperaure cycle if you need pressure/humidity values. And this
is what I did by doing a dummy read_temp(data, NULL, NULL) to get the t_fine
value.

I had also planned to add heater_profile_duration:
https://github.com/BoschSensortec/BME680_driver/blob/63bb5336db4659519860832be2738c685133aa33/bme680.c#L647

But what if I only read gas channel ?
Then this function needs to be tweaked accordingly.

But without these functions my code works fine, but I will surely add
them later.

There are also function that can be added for eg. to add a delay during
startup:

Start-up time -- tstartup -- Time to first communication -- 2ms

This delay should be added after power-on reset.

I am currently considering only the core functionality for now, later
incrementally add these function.

I am currenlty supplying default values for heater temperature & duration
at probe and planned to add syfs attributes for user to specify these
values. But somehow it got complicated and my mentor advised to just to
the needful now and later we can add various support interfaces. We can
also add interface for turning on/off optional IIR filter.

The another problem also arise is that each you want a reading, you need
to set the FORCED mode. But Bosch Code doesn't support individual
channel reading as we do in IIO, they don;t need to care about this
information.

But on other side in IIO, if you want pressure reading you do:

# cat in_pressure_humidityrelative
..
and then behind the scenes FORCED mode is set and you get the reading.

But then again, if you want temp & pressure both:

# cat in_temp_input in_pressure_humidityrelative
..

and here we set FORCED mode *twice* for every measurement.
And then datasheet say:

At Page 14/50
------------

3. Sensor usage
3.1 Sensor modes

"It is important to note that, further mode change commands or other
write commands to the control registers are ignored until
the mode change command has been executed. All control registers should
be set to the desired values before writing to the
mode register."

So, we need to take care of these stuff too!

And then there are a lot of things to discuss....

Thanks you so much for the feedback, David! :)

And if at some point I have said something stupid, then please forgive me.

I am a 3rd year undergrad student and started with IIO few months back, and
not a Bosch driver developer ;)

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
