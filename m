Return-Path: <martink@posteo.de>
Subject: Re: [PATCH] iio: mma8452: add support for MMA8451Q
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1452769329-17912-1-git-send-email-martink@posteo.de>
 <alpine.DEB.2.02.1601141233280.30595@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
 christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <56978EA7.3060507@posteo.de>
Date: Thu, 14 Jan 2016 13:03:51 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1601141233280.30595@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Am 2016-01-14 um 12:45 schrieb Peter Meerwald-Stadler:
> 
>> This adds support for this series' 14 bit accelerometer chip, MMA8451Q.
>> It's datasheet is available at the vendor's website:
>>
>> https://cache.freescale.com/files/sensors/doc/data_sheet/MMA8451Q.pdf
> 
> comments below
>  
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> ---
>>
>> This applies on top of
>> [PATCH v5] iio: mma8452: add freefall detection for Freescale's accelerometers
>> which should be in good shape (I think it already is) and accepted before this.
>>
>>
>> this is sent early for review, just for you to know what to expect for v4.6.
>>
>> thanks
>>                              martin
>>
>>
>>  .../devicetree/bindings/iio/accel/mma8452.txt      |  4 +-
>>  drivers/iio/accel/Kconfig                          |  2 +-
>>  drivers/iio/accel/mma8452.c                        | 46 ++++++++++++++++++----
>>  3 files changed, 42 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> index 3c10e85..165937e 100644
>> --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> @@ -1,8 +1,10 @@
>> -Freescale MMA8452Q, MMA8453Q, MMA8652FC or MMA8653FC triaxial accelerometer
>> +Freescale MMA8451Q, MMA8452Q, MMA8453Q, MMA8652FC or MMA8653FC
>> +triaxial accelerometer
>>  
>>  Required properties:
>>  
>>    - compatible: should contain one of
>> +    * "fsl,mma8451"
>>      * "fsl,mma8452"
>>      * "fsl,mma8453"
>>      * "fsl,mma8652"
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>> index edc29b1..0e02c36 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -143,7 +143,7 @@ config MMA8452
>>  	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  Say yes here to build support for the following Freescale 3-axis
>> -	  accelerometers: MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC.
>> +	  accelerometers: MMA8341Q, MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC.
> 
> should be MMA8451Q, not 8341
> 

thanks!

>>  
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called mma8452.
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 820a8a3..b46694e 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -1,6 +1,7 @@
>>  /*
>>   * mma8452.c - Support for following Freescale 3-axis accelerometers:
>>   *
>> + * MMA8451Q (14 bit)
>>   * MMA8452Q (12 bit)
>>   * MMA8453Q (10 bit)
>>   * MMA8652FC (12 bit)
>> @@ -85,8 +86,9 @@
>>  #define  MMA8452_INT_FF_MT			BIT(2)
>>  #define  MMA8452_INT_TRANS			BIT(5)
>>  
>> -#define  MMA8452_DEVICE_ID			0x2a
>> -#define  MMA8453_DEVICE_ID			0x3a
>> +#define MMA8451_DEVICE_ID			0x1a
>> +#define MMA8452_DEVICE_ID			0x2a
>> +#define MMA8453_DEVICE_ID			0x3a
> 
> extra whitespace cleanup here
> 

Isn't it ok to stash it in here in this case?

>>  #define MMA8652_DEVICE_ID			0x4a
>>  #define MMA8653_DEVICE_ID			0x5a
>>  
>> @@ -937,6 +939,14 @@ static struct attribute_group mma8452_event_attribute_group = {
>>  	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
>>  }
>>  
>> +static const struct iio_chan_spec mma8451_channels[] = {
>> +	MMA8452_CHANNEL(X, idx_x, 14),
>> +	MMA8452_CHANNEL(Y, idx_y, 14),
>> +	MMA8452_CHANNEL(Z, idx_z, 14),
>> +	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
>> +	MMA8452_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>> +};
>> +
>>  static const struct iio_chan_spec mma8452_channels[] = {
>>  	MMA8452_CHANNEL(X, idx_x, 12),
>>  	MMA8452_CHANNEL(Y, idx_y, 12),
>> @@ -970,6 +980,7 @@ static const struct iio_chan_spec mma8653_channels[] = {
>>  };
>>  
>>  enum {
>> +	mma8451,
>>  	mma8452,
>>  	mma8453,
>>  	mma8652,
>> @@ -977,17 +988,34 @@ enum {
>>  };
>>  
>>  static const struct mma_chip_info mma_chip_info_table[] = {
>> -	[mma8452] = {
>> -		.chip_id = MMA8452_DEVICE_ID,
>> -		.channels = mma8452_channels,
>> -		.num_channels = ARRAY_SIZE(mma8452_channels),
>> +	[mma8451] = {
>> +		.chip_id = MMA8451_DEVICE_ID,
>> +		.channels = mma8451_channels,
>> +		.num_channels = ARRAY_SIZE(mma8451_channels),
>>  		/*
>>  		 * Hardware has fullscale of -2G, -4G, -8G corresponding to
>> -		 * raw value -2048 for 12 bit or -512 for 10 bit.
>> +		 * raw value -8192 for 14 bit, -2048 for 12 bit or -512 for 10
>> +		 * bit.
>>  		 * The userspace interface uses m/s^2 and we declare micro units
>>  		 * So scale factor for 12 bit here is given by:
>> -		 *	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
>> +		 *      g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
> 
> this changes a tab to whitespace, probably not intended
> 

thanks!

>>  		 */
>> +		.mma_scales = { {0, 2394}, {0, 4788}, {0, 9576} },
>> +		.ev_cfg = MMA8452_TRANSIENT_CFG,
>> +		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
>> +		.ev_cfg_chan_shift = 1,
>> +		.ev_src = MMA8452_TRANSIENT_SRC,
>> +		.ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE,
>> +		.ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE,
>> +		.ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE,
>> +		.ev_ths = MMA8452_TRANSIENT_THS,
>> +		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
>> +		.ev_count = MMA8452_TRANSIENT_COUNT,
>> +	},
>> +	[mma8452] = {
>> +		.chip_id = MMA8452_DEVICE_ID,
>> +		.channels = mma8452_channels,
>> +		.num_channels = ARRAY_SIZE(mma8452_channels),
>>  		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
> 
> the first scale is 9577 here, the last scale for 8451 is 9576 -- probably 
> this should be the same value (rounding issue?)
> 

rounding issue, yes. I'll change it to 9577. The rest is ok.

Thanks Peter, for the good review!

>>  		.ev_cfg = MMA8452_TRANSIENT_CFG,
>>  		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
>> @@ -1168,6 +1196,7 @@ static int mma8452_reset(struct i2c_client *client)
>>  }
>>  
>>  static const struct of_device_id mma8452_dt_ids[] = {
>> +	{ .compatible = "fsl,mma8451", .data = &mma_chip_info_table[mma8451] },
>>  	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
>>  	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
>>  	{ .compatible = "fsl,mma8652", .data = &mma_chip_info_table[mma8652] },
>> @@ -1204,6 +1233,7 @@ static int mma8452_probe(struct i2c_client *client,
>>  		return ret;
>>  
>>  	switch (ret) {
>> +	case MMA8451_DEVICE_ID:
>>  	case MMA8452_DEVICE_ID:
>>  	case MMA8453_DEVICE_ID:
>>  	case MMA8652_DEVICE_ID:
>>
> 
