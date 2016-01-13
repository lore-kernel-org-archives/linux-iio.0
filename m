Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:39551 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbcAMQSQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 13 Jan 2016 11:18:16 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 5F41B20995
	for <linux-iio@vger.kernel.org>; Wed, 13 Jan 2016 17:18:12 +0100 (CET)
Subject: Re: [PATCH v4] iio: mma8452: add freefall detection for Freescale's
 accelerometers
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1452686040-6421-1-git-send-email-martink@posteo.de>
 <alpine.DEB.2.02.1601131448290.21762@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <56967886.1000601@posteo.de>
Date: Wed, 13 Jan 2016 17:17:10 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1601131448290.21762@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2016-01-13 um 14:53 schrieb Peter Meerwald-Stadler:
> Hello,
> 
>> This adds freefall event detection to the supported devices. It adds
>> the in_accel_x&y&z_mag_falling_en iio event attribute, which activates
>> freefall mode.
>>
>> In freefall mode, the current acceleration magnitude (AND combination
>> of all axis values) is compared to the specified threshold.
>> If it falls under the threshold (in_accel_mag_falling_value),
>> the appropriate IIO event code is generated.
>>
>> This is what the sysfs "events" directory for these devices looks
>> like after this change:
>>
>> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_period
>> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_value
>> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_period
>> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_value
>> -r--r--r--    4096 Oct 23 08:45 in_accel_scale
>> -rw-r--r--    4096 Oct 23 08:45 in_accel_x&y&z_mag_falling_en
>> -rw-r--r--    4096 Oct 23 08:45 in_accel_x_mag_rising_en
>> -rw-r--r--    4096 Oct 23 08:45 in_accel_y_mag_rising_en
>> -rw-r--r--    4096 Oct 23 08:45 in_accel_z_mag_rising_en
> 
> I think it is a very good idea to have this for review, thanks!
> 
> minor comments below
> 
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> ---
>> revision history
>> ----------------
>> v1:
>>         initial post
>> v2:
>>         build all from correct event and channel spec structs
>> v3:
>>         rising and falling are treated as equal now. Until last time, I had
>>         misunderstood the iio events' user API definition. This works and
>>         values always reflect the current state of operation.
>> v4:
>> 	fix error that caused a build warning
>>
>>  drivers/iio/accel/mma8452.c | 156 +++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 139 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index ccc632a..9534c3a 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -15,7 +15,7 @@
>>   *
>>   * 7-bit I2C slave address 0x1c/0x1d (pin selectable)
>>   *
>> - * TODO: orientation / freefall events, autosleep
>> + * TODO: orientation events, autosleep
>>   */
>>  
>>  #include <linux/module.h>
>> @@ -416,6 +416,46 @@ fail:
>>  	return ret;
>>  }
>>  
>> +static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>> +{
>> +	int val;
>> +	const struct mma_chip_info *chip = data->chip_info;
>> +
>> +	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>> +	if (val < 0)
>> +		return val;
>> +
>> +	return !(val & MMA8452_FF_MT_CFG_OAE);
> 
> I'd appreciate a comment what the possible return values of this function 
> are and their purpose
> 

would it also be clearer if the return value would be bool?

>> +}
>> +
>> +static int mma8452_set_freefall_mode(struct mma8452_data *data, u8 state)
> 
> state seems to be used as a bool, maybe it should be bool
> 

You're right. I'll change this.

>> +{
>> +	int val, ret;
> 
> strictly, only one of the two variable is necessary
> 

true.

>> +	const struct mma_chip_info *chip = data->chip_info;
>> +
>> +	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>> +	if (val < 0)
>> +		return val;
>> +
>> +	if (state && !(mma8452_freefall_mode_enabled(data))) {
>> +		val |= BIT(idx_x + chip->ev_cfg_chan_shift);
>> +		val |= BIT(idx_y + chip->ev_cfg_chan_shift);
>> +		val |= BIT(idx_z + chip->ev_cfg_chan_shift);
>> +		val &= ~MMA8452_FF_MT_CFG_OAE;
>> +	} else if (!state && mma8452_freefall_mode_enabled(data)) {
>> +		val &= ~BIT(idx_x + chip->ev_cfg_chan_shift);
>> +		val &= ~BIT(idx_y + chip->ev_cfg_chan_shift);
>> +		val &= ~BIT(idx_z + chip->ev_cfg_chan_shift);
>> +		val |= MMA8452_FF_MT_CFG_OAE;
>> +	}
>> +
>> +	ret = mma8452_change_config(data, chip->ev_cfg, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>>  static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
>>  					   int val, int val2)
>>  {
>> @@ -609,12 +649,22 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
> 
> I find the return values of this functions difficult to understand, 
> comment would be good

This is part of struct iio_info so shouldn't it be documented elsewhere,
not in a driver?

thanks for reviewing!

                               martin


