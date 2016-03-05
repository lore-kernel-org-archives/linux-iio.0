Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56244 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbcCEPuT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 10:50:19 -0500
Subject: Re: [PATCH v4 1/1] staging: coding style cleanups for
 staging/iio/light/tsl2583 driver
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Bijosh Thykkoottathil <bijosh.t@hotmail.com>,
	gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <BLU436-SMTP1368781E78F120E82EF730980B90@phx.gbl>
 <8ECF82AD-7F64-4AB5-97CE-3188FA6B73CC@jic23.retrosnub.co.uk>
Cc: mahfouz.saif.elyazal@gmail.com, ciorneiioana@gmail.com,
	cristina.moraru09@gmail.com, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DB0036.7010904@kernel.org>
Date: Sat, 5 Mar 2016 15:50:14 +0000
MIME-Version: 1.0
In-Reply-To: <8ECF82AD-7F64-4AB5-97CE-3188FA6B73CC@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/02/16 18:49, Jonathan Cameron wrote:
> 
> 
> On 28 February 2016 17:31:11 GMT+00:00, Bijosh Thykkoottathil <bijosh.t@hotmail.com> wrote:
>> This patch fixes following coding style warning reported by check patch
>> script, in tsl2583 driver:
>>    - Block comments use a trailing */ on a separate line
>>
>> Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
> Excellent. I have a pull request out at the moment, so may be a few days before I apply this. 
> 
Ah, looks like Greg took a series of cleanup patches for this driver directly
so most if not all of this is originally in the tree.

Sorry about that, I never saw the relevant patches and don't think they were in my tree
until I did a merge today.

Jonathan
> Jonathan
>> ---
>> drivers/staging/iio/light/tsl2583.c | 30 ++++++++++++++++++++----------
>> 1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/staging/iio/light/tsl2583.c
>> b/drivers/staging/iio/light/tsl2583.c
>> index 3100d96..8c9e304 100644
>> --- a/drivers/staging/iio/light/tsl2583.c
>> +++ b/drivers/staging/iio/light/tsl2583.c
>> @@ -240,8 +240,10 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>> 		}
>> 	}
>>
>> -	/* clear status, really interrupt status (interrupts are off), but
>> -	 * we use the bit anyway - don't forget 0x80 - this is a command*/
>> +	/*
>> +	 * Clear status, really interrupt status (interrupts are off), but
>> +	 * we use the bit anyway - don't forget 0x80 - this is a command
>> +	 */
>> 	ret = i2c_smbus_write_byte(chip->client,
>> 				   (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |
>> 				    TSL258X_CMD_ALS_INT_CLR));
>> @@ -429,8 +431,10 @@ static int taos_chip_on(struct iio_dev *indio_dev)
>> 	chip->als_saturation = als_count * 922; /* 90% of full scale */
>> 	chip->als_time_scale = (als_time + 25) / 50;
>>
>> -	/* TSL258x Specific power-on / adc enable sequence
>> -	 * Power on the device 1st. */
>> +	/*
>> +	 * TSL258x Specific power-on / adc enable sequence
>> +	 * Power on the device 1st.
>> +	 */
>> 	utmp = TSL258X_CNTL_PWR_ON;
>> 	ret = i2c_smbus_write_byte_data(chip->client,
>> 					TSL258X_CMD_REG | TSL258X_CNTRL, utmp);
>> @@ -439,8 +443,10 @@ static int taos_chip_on(struct iio_dev *indio_dev)
>> 		return ret;
>> 	}
>>
>> -	/* Use the following shadow copy for our delay before enabling ADC.
>> -	 * Write all the registers. */
>> +	/*
>> +	 * Use the following shadow copy for our delay before enabling ADC.
>> +	 * Write all the registers.
>> +	 */
>> 	for (i = 0, uP = chip->taos_config; i < TSL258X_REG_MAX; i++) {
>> 		ret = i2c_smbus_write_byte_data(chip->client,
>> 						TSL258X_CMD_REG + i,
>> @@ -453,8 +459,10 @@ static int taos_chip_on(struct iio_dev *indio_dev)
>> 	}
>>
>> 	usleep_range(3000, 3500);
>> -	/* NOW enable the ADC
>> -	 * initialize the desired mode of operation */
>> +	/*
>> +	 * NOW enable the ADC
>> +	 * initialize the desired mode of operation
>> +	 */
>> 	utmp = TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL;
>> 	ret = i2c_smbus_write_byte_data(chip->client,
>> 					TSL258X_CMD_REG | TSL258X_CNTRL,
>> @@ -695,8 +703,10 @@ static ssize_t taos_luxtable_show(struct device
>> *dev,
>> 				  taos_device_lux[i].ch0,
>> 				  taos_device_lux[i].ch1);
>> 		if (taos_device_lux[i].ratio == 0) {
>> -			/* We just printed the first "0" entry.
>> -			 * Now get rid of the extra "," and break. */
>> +			/*
>> +			 * We just printed the first "0" entry.
>> +			 * Now get rid of the extra "," and break.
>> +			 */
>> 			offset--;
>> 			break;
>> 		}
> 

