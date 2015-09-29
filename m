Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49998 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379AbbI2RU1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2015 13:20:27 -0400
Subject: Re: [PATCH v3 1/6] Add meas-spec sensors common part
To: "ludovic.tancerel@maplehightech.com"
	<ludovic.tancerel@maplehightech.com>
References: <1443189405-18516-1-git-send-email-ludovic.tancerel@maplehightech.com>
 <1443189405-18516-2-git-send-email-ludovic.tancerel@maplehightech.com>
 <560817E4.60003@kernel.org>
 <B38C52D7-9503-4273-A742-A2BB88D72229@maplehightech.com>
 <0FB52C7B-9AFB-4474-84F5-04319E937449@maplehightech.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	William.Markezana@meas-spec.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560AC857.5000505@kernel.org>
Date: Tue, 29 Sep 2015 18:20:23 +0100
MIME-Version: 1.0
In-Reply-To: <0FB52C7B-9AFB-4474-84F5-04319E937449@maplehightech.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/09/15 09:03, ludovic.tancerel@maplehightech.com wrote:
> Resent with formatting changes in my mail application,
> as it seems some html makes the server throw it away.
> 
> Ludovic
> 
>> Hello Jonathan, all,
>> thank you for reviewing
>>
>> for once, I will reply shortly.
>> Hopefully, the message will go through the mail server.
>>
>> Please have a look at comments below,
responses inline.
>> Regards,
>> Ludovic
>>
>>
>> Le 27 sept. 2015 à 18:23, Jonathan Cameron <jic23@kernel.org> a écrit :
>>
>>> On 25/09/15 14:56, Ludovic Tancerel wrote:
>>>> Measurement specialties drivers common part.
>>>> These functions are used by further drivers in the patchset: TSYS01, TSYS02D, HTU21, MS5637, MS8607
>>>>
>>>> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
>>> A few more bits and bobs inline.
>>>> ---
>>>> drivers/iio/common/Kconfig                     |   1 +
>>>> drivers/iio/common/Makefile                    |   1 +
>>>> drivers/iio/common/ms_sensors/Kconfig          |   6 +
>>>> drivers/iio/common/ms_sensors/Makefile         |   5 +
>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 645 +++++++++++++++++++++++++
>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.h |  53 ++
>>>> 6 files changed, 711 insertions(+)
>>>> create mode 100644 drivers/iio/common/ms_sensors/Kconfig
>>>> create mode 100644 drivers/iio/common/ms_sensors/Makefile
>>>> create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>>>> create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>>>>
>>>> diff —git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
>> …
>>>>
>>>> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>>>> new file mode 100644
>>>> index 0000000..4b1bc31
>>>> --- /dev/null
>>>> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>>>> @@ -0,0 +1,645 @@
>>>> +/*
>>>> + * Measurements Specialties driver common i2c functions
>>>> + *
>>>> + * Copyright (c) 2015 Measurement-Specialties
>>>> + *
>>>> + * Licensed under the GPL-2.
>>> Drop this blank line.
>> OK
>>>> + *
>>>> + */
>>>> +
>> …
>>>> +
>>>> +/**
>>>> + * ms_sensors_i2c_read_prom_word() - i2c prom word read function
>>>> + * @cli:	pointer to i2c client
>>>> + * @cmd:	PROM read cmd. Depends on device and prom id
>>>> + * @word:	pointer to word destination value
>>>> + *
>>>> + * Generic i2c prom word read function for Measurement Specialties devices.
>>>> + *
>>>> + * Return: 0 on success, negative errno otherwise.
>>>> + */
>>>> +int ms_sensors_i2c_read_prom_word(void *cli, int cmd, u16 *word)
>>>> +{
>>>> +	int ret;
>>>> +	struct i2c_client *client = (struct i2c_client *)cli;
>>> Why pass an void * given the function name says this will always be an i2c_client?
>>>
>>> Once that's removed this wrapper does very little and I'd be tempted to
>>> drop it in favour of direct calls to the smbus read.
>>
>> The void * is because this function might be used for the same chipset using SPI access (that is not supported yet).
>> I am passing the void *, to have common parameters for the future spi function.
>> This is the same for previous function ms_sensors_i2c_reset.
>>
>> That references functions written for tsys01 written in patch v2/6 :
>> "
>> 	dev_data->client = client;
>> 	dev_data->reset = ms_sensors_i2c_reset;
>> 	dev_data->read_prom_word = ms_sensors_i2c_read_prom_word;
>> 	dev_data->convert_and_read = ms_sensors_i2c_convert_and_read;
>> "
>> The same could be done but using a spi function. Isn’t that the appropriate approach ?
>> This is what I understood when looking at other drivers.
>>
>> These functions are also used in different drivers, so if I drop t he wrapper, I cannot reuse the function for TSYS01.
>>
>>>> +
>>>> +	ret = i2c_smbus_read_word_swapped(client, cmd);
>>>> +	if (ret < 0) {
>>>> +		dev_err(&client->dev, "Failed to read prom word\n");
>>>> +		return ret;
>>>> +	}
>>>> +	*word = ret;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL(ms_sensors_i2c_read_prom_word);
>>>> +
>>>> +/**
>>>> + * ms_sensors_i2c_convert_and_read() - i2c ADC conversion & read function
>>>> + * @cli:	pointer to i2c client
>>>> + * @conv:	ADC conversion command. Depends on device in use
>>>> + * @rd:		ADC read command. Depends on device in use
>>>> + * @delay:	usleep minimal delay after conversion command is issued
>>>> + * @adc:	pointer to ADC destination value
>>>> + *
>>>> + * Generic i2c ADC conversion & read function for Measurement Specialties
>>>> + * devices.
>>>> + * The function will issue conversion command, sleep appopriate delay, and
>>>> + * issue command to read ADC.
>>>> + *
>>>> + * Return: 0 on success, negative errno otherwise.
>>>> + */
>>>> +int ms_sensors_i2c_convert_and_read(void *cli, u8 conv, u8 rd,
>>>> +				    unsigned int delay, u32 *adc)
>>>> +{
>>>> +	int ret;
>>>> +	u32 buf = 0;
>>>> +	struct i2c_client *client = (struct i2c_client *)cli;
>>>> +
>>>> +	/* Trigger conversion */
>>>> +	ret = i2c_smbus_write_byte(client, conv);
>>>> +	if (ret)
>>>> +		goto err;
>>>> +	usleep_range(delay, delay + 1000);
>>>> +
>>>> +	/* Retrieve ADC value */
>>>> +	if (rd != MS_SENSORS_NO_READ_CMD)
>>>> +		ret = i2c_smbus_read_i2c_block_data(client, rd, 3, (u8 *)&buf);
>>>> +	else
>>>> +		ret = i2c_master_recv(client, (u8 *)&buf, 3);
>>>> +	if (ret < 0)
>>>> +		goto err;
>>>> +
>>>> +	dev_dbg(&client->dev, "ADC raw value : %x\n", be32_to_cpu(buf) >> 8);
>>>> +	*adc = be32_to_cpu(buf) >> 8;
>>>> +
>>>> +	return 0;
>>>> +err:
>>>> +	dev_err(&client->dev, "Unable to make sensor adc conversion\n");
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL(ms_sensors_i2c_convert_and_read);
>>>> +
>>>> +/**
>>>> + * ms_sensors_crc_valid() - CRC check function
>>>> + * @value:	input and CRC compare value
>>>> + *
>>>> + * Cyclic Redundancy Check function used in TSYS02D, HTU21, MS8607.
>>>> + * This function performs a x^8 + x^5 + x^4 + 1 polynomial CRC.
>>>> + * The argument contains CRC value in LSB byte while the bytes 1 and 2
>>>> + * are used for CRC computation.
>>>> + *
>>>> + * Return: 1 if CRC is valid, 0 otherwise.
>>> Can this be done with the standard kernel crc32 functions? (not dug into
>>> it enough to be sure!)
>>
>> I don’t think so.
>> CRC computation here is truly a 16-bits CRC check.
>> I have looked at crc16 lib but this a different polynomial used.
Fair enough.
>>
>>>> + */
>>>> +static bool ms_sensors_crc_valid(u32 value)
>>>> +{
>>>> +	u32 polynom = 0x988000;	/* x^8 + x^5 + x^4 + 1 */
>>>> +	u32 msb = 0x800000;
>>>> +	u32 mask = 0xFF8000;
>>>> +	u32 result = value & 0xFFFF00;
>>>> +	u8 crc = value & 0xFF;
>>>> +
>>>> +	while (msb != 0x80) {
>>>> +		if (result & msb)
>>>> +			result = ((result ^ polynom) & mask)
>>>> +				| (result & ~mask);
>>>> +		msb >>= 1;
>>>> +		mask >>= 1;
>>>> +		polynom >>= 1;
>>>> +	}
>>>> +
>>>> +	return result == crc;
>>>> +}
>>>> +
>>>> +/**
>>>> + * ms_sensors_i2c_read_serial() - i2c serial number read function
>>>> + * @cli:	pointer to i2c client
>>>> + * @sn:		pointer to 64-bits destination value
>>>> + *
>>>> + * Generic i2c serial number read function for Measurement Specialties devices.
>>>> + * This function is used for TSYS02d, HTU21, MS8607 chipset.
>>>> + * Refer to datasheet:
>>>> + *	http://www.meas-spec.com/downloads/HTU2X_Serial_Number_Reading.pdf
>>> THat's a first.  A whole datasheet on how the heck the serial number works!
>>>
>>> Got to wonder how anyone ever came up with that.  I'm going to conclude
>>> you got it right and not read any more ;)
>>
>> Please read below.
>> If you read the spec, you will understand why there is one,
>> the Serial Number shape is really far fetched … :)
>>
>>>> + *
>>>> + * Return: 0 on success, negative errno otherwise.
>>>> + */
>>>> +int ms_sensors_i2c_read_serial(struct i2c_client *client, u64 *sn)
>>>> +{
>>>> +	u8 i;
>>>> +	u64 rcv_buf = 0;
>>>> +	u16 send_buf;
>>>> +	int ret;
>>>> +
>>>> +	struct i2c_msg msg[2] = {
>>>> +		{
>>>> +		 .addr = client->addr,
>>>> +		 .flags = client->flags,
>>>> +		 .len = 2,
>>>> +		 .buf = (__u8 *)&send_buf,
>>>> +		 },
>>>> +		{
>>>> +		 .addr = client->addr,
>>>> +		 .flags = client->flags | I2C_M_RD,
>>>> +		 .buf = (__u8 *)&rcv_buf,
>>>> +		 },
>>>> +	};
>>>> +
>>>> +	/* Read MSB part of serial number */
>>>> +	send_buf = cpu_to_be16(MS_SENSORS_SERIAL_READ_MSB);
>>>> +	msg[1].len = 8;
>>>> +	ret = i2c_transfer(client->adapter, msg, 2);
>>>> +	if (ret < 0) {
>>>> +		dev_err(&client->dev, "Unable to read device serial number");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	rcv_buf = be64_to_cpu(rcv_buf);
>>>> +	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_buf);
>>>> +
>>>> +	for (i = 0; i < 64; i += 16) {
>>>> +		if (!ms_sensors_crc_valid((rcv_buf >> i) & 0xFFFF))
>>>> +			return -ENODEV;
>>>> +	}
>>>> +
>>> Umm. I'm really unclear what you are doing here.  You read into
>>> a 64 bit buffer, then do a hand endian swap and shift?  Should be possible
>>> to at least use standard functions to swap the byte order.
>>
>> There are several 8bits CRC interlaced in the bytes read containing serial number.
>> So the "for (i = 0; i < 64; i += 16)" is to check the different CRCs
>>
>> The « *sn = … » is meant to regroup the bytes in between CRC words and retrieve the 32bits first portion of the serial number.
>> The shape is [ SNB 3 , CRC, SNB 2, CRC, SNB 1, CRC, SNB 0, CRC ]
>> I considered unifying both in the loop but this is not simpler
>>
>> The second portion of serial number is read afterwards.
>>
>> I agree this is overly complex for getting a serial number,
>> but this is how it is implemented in the sensor, and it is a wish from measurement specialties to read it at sensor init.
>>
>> If you feel I should extract the SN bytes in a different way on the code below, let me know.
>> I can put it into a macro to improve readability ?
>>
>>>
>>>> +	*sn = (((rcv_buf >> 32) & 0xFF000000) |
>>>> +	       ((rcv_buf >> 24) & 0x00FF0000) |
>>>> +	       ((rcv_buf >> 16) & 0x0000FF00) |
>>>> +	       ((rcv_buf >> 8) & 0x000000FF)) << 16;
>>>> +
>>>>
>> …
All makes sense.  Perhaps the best bet is a comment giving 
a brief description of what is going on is the best bet.  The explanation
you put here is nice and clear so perhaps start from that.
>>
>>>> +int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
>>>> +				      int *temperature,
>>>> +				      unsigned int *pressure)
>>>> +{
>>>> +	int ret;
>>>> +	u32 t_adc, p_adc;
>>>> +	s32 dt, temp;
>>>> +	s64 off, sens, t2, off2, sens2;
>>>> +	u16 *prom = dev_data->prom, delay;
>>>> +	u8 i;
>>>> +
>>>> +	mutex_lock(&dev_data->lock);
>>>> +	i = dev_data->res_index * 2;
>>> This local variable seens rather unnecessary. Just put it inline in the
>>> calls.
>>
>> OK
>>
>>>> +	delay = ms_sensors_tp_conversion_time[dev_data->res_index];
>>>> +
>>>> +	ret = ms_sensors_i2c_convert_and_read(
>>>> +					dev_data->client,
>>>> +					MS_SENSORS_TP_T_CONVERSION_START + i,
>>>> +					MS_SENSORS_TP_ADC_READ,
>>>> +					delay, &t_adc);
>>>> +	if (ret) {
>>>> +		mutex_unlock(&dev_data->lock);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	
>>
>> …
>>
>>>> +
>>>> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>>>> new file mode 100644
>>>> index 0000000..918b8af
>>>> --- /dev/null
>>>> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
>>>> @@ -0,0 +1,53 @@
>>>> +/*
>>>> + * Measurements Specialties common sensor driver
>>>> + *
>>>> + * Copyright (c) 2015 Measurement-Specialties
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#ifndef _MS_SENSORS_I2C_H
>>>> +#define _MS_SENSORS_I2C_H
>>>> +
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/mutex.h>
>>>> +
>>>> +#define MS_SENSORS_TP_PROM_WORDS_NB		7
>>>> +
>>>> +struct ms_ht_dev {
>>>> +	struct i2c_client *client;
>>>> +	struct mutex lock; /* mutex protecting data structure */
>>>> +	u8 res_index;
>>>> +};
>>>> +
>>> kernel doc comments preferred.
>>
>> OK
>>>> +struct ms_tp_dev {
>>>> +	struct i2c_client *client;
>>>> +	struct mutex lock; /* mutex protecting data structure */
>>>> +	/* Added element for CRC computation */
>>>> +	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB + 1];
>>>> +	u8 res_index;
>>>> +};
>>>> +
>>>> +int ms_sensors_i2c_reset(void *cli, u8 cmd, unsigned int delay);
>>>> +int ms_sensors_i2c_read_prom_word(void *cli, int cmd, u16 *word);
>>>> +int ms_sensors_i2c_convert_and_read(void *cli, u8 conv, u8 rd,
>>>> +				    unsigned int delay, u32 *adc);
>>>> +int ms_sensors_i2c_read_serial(struct i2c_client *client, u64 *sn);
>>>> +ssize_t ms_sensors_i2c_show_serial(struct ms_ht_dev *dev_data, char *buf);
>>>> +ssize_t ms_sensors_i2c_write_resolution(struct ms_ht_dev *dev_data, u8 i);
>>>> +ssize_t ms_sensors_i2c_show_battery_low(struct ms_ht_dev *dev_data, char *buf);
>>>> +ssize_t ms_sensors_i2c_show_heater(struct ms_ht_dev *dev_data, char *buf);
>>>> +ssize_t ms_sensors_i2c_write_heater(struct ms_ht_dev *dev_data,
>>>> +				    const char *buf, size_t len);
>>>> +int ms_sensors_i2c_ht_read_temperature(struct ms_ht_dev *dev_data,
>>>> +				       s32 *temperature);
>>>> +int ms_sensors_i2c_ht_read_humidity(struct ms_ht_dev *dev_data,
>>>> +				    u32 *humidity);
>>>> +int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data);
>>>> +int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
>>>> +				      int *temperature,
>>>> +				      unsigned int *pressure);
>>> The presence or absense of _i2c in the function naming does feel rather
>>> random.  All of these functions ultimately make i2c calls so perhaps you
>>> can explain your reasoning behind having it in some and not others.
>>
>> The functions used were meant to have _i2c when there is no direct calls to  smbus functions.
>> I agree that is rather awkward, I will change and put i2c everywhere.
Fair enough. Though personally I'd drop it everywhere ;)
>>
>>>
>>>> +
>>>> +#endif /* _MS_SENSORS_I2C_H */
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

