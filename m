Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:33044 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbcCFPv3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 6 Mar 2016 10:51:29 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 891C320923
	for <linux-iio@vger.kernel.org>; Sun,  6 Mar 2016 16:51:24 +0100 (CET)
Subject: Re: [PATCH 4/4] iio: mma8452: add low_power mode
To: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1456993444-21320-1-git-send-email-martink@posteo.de>
 <1456993444-21320-5-git-send-email-martink@posteo.de>
 <56DB19FA.8090403@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <56DC51A3.4000604@posteo.de>
Date: Sun, 6 Mar 2016 16:49:55 +0100
MIME-Version: 1.0
In-Reply-To: <56DB19FA.8090403@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2016-03-05 um 18:40 schrieb Jonathan Cameron:
> On 03/03/16 08:24, Martin Kepplinger wrote:
>> This adds a mode of operation that consumes less power by lesser
>> oversampling. It's exposed in IIO sysfs as in_accelX_power_mode, as
>> documented.
>>
>> It consumes roughly half the power the default low_noise mode does.
>> See the datasheet for details.
>>
>> Signed-off-by: Martin Kepplinger <martink@posteo.de>
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> This is in the datasheet as oversampling.  So why are we not using the oversampling
> interface rather than adding a new one?
> 
> It's obvious that with the interactions with sampling rate that this won't be trivial
> to support, but it doesn't look that hard.  For a given sampling_frequency only
> certain oversampling rations are possible, but that's not exactly unusual.
> 
> That way everything is explicit, whereas with this approach people will need to
> read the datasheet to know if setting the power mode is having any effect at all.
> 
> That will also allow appropriate trade offs to use the low noise / low power version
> if the oversampling ratio is appropriate.  All this stuff is clearly given in 
> table 59 of the datasheet google gave me.
> (actually as control mechanisms go for this sort of setting I think this one is
> reasonably elegant as such hardware goes!)
> 
> Jonathan
> 

True, that way a more accurate way of describing the hardware would be
possible. I figured power_mode already is an ABI and used in another
driver, and very convenient to use.

How about having both, so that the connection to saving power is obvious
for users? This way I would have to extend "power_modes_available" to
have 4 modes, but no reading of the data sheet would be necessary to
understand it all.

It would not be trivial but doable and I could redo this by supporting
oversampling ABI first, and try to add this power_mode knob seperately?

                       martin

>> ---
>>  drivers/iio/accel/mma8452.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 5ca0d16..5b5abec 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -75,6 +75,9 @@
>>  #define  MMA8452_CTRL_DR_DEFAULT		0x4 /* 50 Hz sample frequency */
>>  #define MMA8452_CTRL_REG2			0x2b
>>  #define  MMA8452_CTRL_REG2_RST			BIT(6)
>> +#define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
>> +#define  MMA8452_CTRL_REG2_MODS_NORMAL		0x00
>> +#define  MMA8452_CTRL_REG2_MODS_LOW_POWER	0x1b
>>  #define MMA8452_CTRL_REG4			0x2d
>>  #define MMA8452_CTRL_REG5			0x2e
>>  #define MMA8452_OFF_X				0x2f
>> @@ -950,6 +953,56 @@ static struct attribute_group mma8452_event_attribute_group = {
>>  	.attrs = mma8452_event_attributes,
>>  };
>>  
>> +static const char * const mma8452_power_modes[] = {"low_noise", "low_power"};
>> +
>> +static int mma8452_get_power_mode(struct iio_dev *indio_dev,
>> +				  const struct iio_chan_spec *chan)
>> +{
>> +	struct mma8452_data *data = iio_priv(indio_dev);
>> +	int reg;
>> +
>> +	reg = i2c_smbus_read_byte_data(data->client,
>> +				       MMA8452_CTRL_REG2);
>> +	if (reg < 0)
>> +		return reg;
>> +
>> +	return !(reg & MMA8452_CTRL_REG2_MODS_MASK);
>> +}
>> +
>> +static int mma8452_set_power_mode(struct iio_dev *indio_dev,
>> +				  const struct iio_chan_spec *chan,
>> +				  unsigned int mode)
>> +{
>> +	struct mma8452_data *data = iio_priv(indio_dev);
>> +	int reg;
>> +
>> +	reg = i2c_smbus_read_byte_data(data->client,
>> +				       MMA8452_CTRL_REG2);
>> +	if (reg < 0)
>> +		return reg;
>> +
>> +	reg &= ~MMA8452_CTRL_REG2_MODS_MASK;
>> +	if (mode)
>> +		reg |= MMA8452_CTRL_REG2_MODS_LOW_POWER;
>> +	else
>> +		reg |= MMA8452_CTRL_REG2_MODS_NORMAL;
>> +
>> +	return mma8452_change_config(data, MMA8452_CTRL_REG2, reg);
>> +}
>> +
>> +static const struct iio_enum mma8452_power_mode_enum = {
>> +	.items = mma8452_power_modes,
>> +	.num_items = ARRAY_SIZE(mma8452_power_modes),
>> +	.get = mma8452_get_power_mode,
>> +	.set = mma8452_set_power_mode,
>> +};
>> +
>> +static const struct iio_chan_spec_ext_info mma8452_ext_info[] = {
>> +	IIO_ENUM("power_mode", true, &mma8452_power_mode_enum),
>> +	IIO_ENUM_AVAILABLE("power_mode", &mma8452_power_mode_enum),
>> +	{ },
>> +};
>> +
>>  #define MMA8452_FREEFALL_CHANNEL(modifier) { \
>>  	.type = IIO_ACCEL, \
>>  	.modified = 1, \
>> @@ -987,6 +1040,7 @@ static struct attribute_group mma8452_event_attribute_group = {
>>  	}, \
>>  	.event_spec = mma8452_transient_event, \
>>  	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
>> +	.ext_info = mma8452_ext_info, \
>>  }
>>  
>>  #define MMA8652_CHANNEL(axis, idx, bits) { \
>> @@ -1007,6 +1061,7 @@ static struct attribute_group mma8452_event_attribute_group = {
>>  	}, \
>>  	.event_spec = mma8452_motion_event, \
>>  	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
>> +	.ext_info = mma8452_ext_info, \
>>  }
>>  
>>  static const struct iio_chan_spec mma8451_channels[] = {
>>
> 

