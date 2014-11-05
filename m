Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43506 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375AbaKEPx0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 10:53:26 -0500
Message-ID: <545A47F0.8040808@kernel.org>
Date: Wed, 05 Nov 2014 15:53:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>
CC: IIO <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3]iio:pressure:bmp280: read compensation data only at
 init
References: <5452E502.6060609@gmx.de> <20141031114709.GC24473@vdogaru> <5453E00B.7080703@gmx.de>
In-Reply-To: <5453E00B.7080703@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/14 19:16, Hartmut Knaack wrote:
> Vlad Dogaru schrieb am 31.10.2014 12:47:
>> On Fri, Oct 31, 2014 at 02:25:22AM +0100, Hartmut Knaack wrote:
>>> Compensation data is hard coded into the sensors, so it is sufficient to just
>>> read it once during device initialization. Therefor struct bmp280_comp should be
>>> part of bmp280_data (since the elements of bmp280_comp_temp and
>>> bmp280_comp_press have distinct names, they could be merged into bmp280_comp).
>>
>> My first version of the patch did this, but Jonathan suggested [1] that,
>> since we're using regmap, we can rely on it for caching the calibration
>> parameters.  I have no preference for either approach.
>>
> Indeed, I missed to have a closer look at that version, as I discarded it when your second or third version came out.
> So, one question remaining is, if your implementation was, what Jonathan had in mind when he gave the hint about using the regmap cache. I mainly see the disadvantage of copying to the buffer and from there to the variables (and depending on endianness even a conversion) for every single measurement.
Gah.  Now I have to remember what I was thinking!

Anyhow, I just didn't much like the double cache of these values.
The little endian conversions are pretty trivial...
The code only ended up a little involved because of the
structures to pass this data around.  Why not just have an enum saying what
data is where and pass the buffer.  Then do the little endian on demand and
let the compiler filter out the repeats?

So combine bmp280_read_compensation_press and bmp280_compensate_press
to something like...
enum {
	P1,
	P2,
	P3,
	P4,
	P5,
	P6,
	P7,
	P8,
	P9
}; // a rare occasion where maybe all on one line would be good ;)

int bmp280_compensate_press(struct bmp280_data *data)
{
	__le16 buf[BMP280_COMP_PRESS_REG_COUNT / 2];
	s64 var1, var2, p;

	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
			       buf, BMP280_COMP_PRESS_REG_COUNT);
	if (ret < 0) {
		dev_err(&data->client->dev,
			"failed to read pressure calibration parameters\n");
		return ret;
	}

	var1 = ((s64) data->t_fine) - 128000;
	var2 = var1 * var1 * (s64) le16_to_cpu(buf[P6]);
	var2 = var2 + ((var1 * (s64) le16_to_cpu(buf[P5])) << 17);
	var2 = var2 + (((s64) le16_to_cpu(buf[P4])) << 35);
	var1 = ((var1 * var1 * (s64) le16_to_cpu(buf[P3])) >> 8) +
		((var1 * (s64) le16_to_cpu(buf[P2])) << 12);
	var1 = (((((s64) 1) << 47) + var1)) * ((s64) le16_to_cpu(buf[P1])) >> 33;

	if (var1 == 0)
		return 0;

	p = ((((s64) 1048576 - adc_press) << 31) - var2) * 3125;
	p = div64_s64(p, var1);
	var1 = (((s64) le16_to_cpu(buf[P9]) * (p >> 13) * (p >> 13)) >> 25;
	var2 = (((s64) le16_to_cpu[buf[P8]) * p) >> 19;
	p = ((p + var1 + var2) >> 8) + (((s64) le16_to_cpu(buf[P7])) << 4);

	return (u32) p;
}

Just a thought.  I was never terribly fussed about this other than disliking
data duplication!
>> [1] http://www.spinics.net/lists/linux-iio/msg15099.html
>>
>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>> ---
>>> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
>>> index 4f6ae4d..36e425c 100644
>>> --- a/drivers/iio/pressure/bmp280.c
>>> +++ b/drivers/iio/pressure/bmp280.c
>>> @@ -68,10 +68,19 @@
>>>  #define BMP280_CHIP_ID			0x58
>>>  #define BMP280_SOFT_RESET_VAL		0xB6
>>>  
>>> +/* Compensation parameters. */
>>> +struct bmp280_comp {
>>> +	u16 dig_p1;
>>> +	s16 dig_p2, dig_p3, dig_p4, dig_p5, dig_p6, dig_p7, dig_p8, dig_p9;
>>> +	u16 dig_t1;
>>> +	s16 dig_t2, dig_t3;
>>> +};
>>> +
>>>  struct bmp280_data {
>>>  	struct i2c_client *client;
>>>  	struct mutex lock;
>>>  	struct regmap *regmap;
>>> +	struct bmp280_comp comp;
>>>  
>>>  	/*
>>>  	 * Carryover value from temperature conversion, used in pressure
>>> @@ -80,17 +89,6 @@ struct bmp280_data {
>>>  	s32 t_fine;
>>>  };
>>>  
>>> -/* Compensation parameters. */
>>> -struct bmp280_comp_temp {
>>> -	u16 dig_t1;
>>> -	s16 dig_t2, dig_t3;
>>> -};
>>> -
>>> -struct bmp280_comp_press {
>>> -	u16 dig_p1;
>>> -	s16 dig_p2, dig_p3, dig_p4, dig_p5, dig_p6, dig_p7, dig_p8, dig_p9;
>>> -};
>>> -
>>>  static const struct iio_chan_spec bmp280_channels[] = {
>>>  	{
>>>  		.type = IIO_PRESSURE,
>>> @@ -141,11 +139,11 @@ static const struct regmap_config bmp280_regmap_config = {
>>>  	.volatile_reg = bmp280_is_volatile_reg,
>>>  };
>>>  
>>> -static int bmp280_read_compensation_temp(struct bmp280_data *data,
>>> -					 struct bmp280_comp_temp *comp)
>>> +static int bmp280_read_compensation_temp(struct bmp280_data *data)
>>>  {
>>>  	int ret;
>>>  	__le16 buf[BMP280_COMP_TEMP_REG_COUNT / 2];
>>> +	struct bmp280_comp *comp = &data->comp;
>>>  
>>>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
>>>  			       buf, BMP280_COMP_TEMP_REG_COUNT);
>>> @@ -162,11 +160,11 @@ static int bmp280_read_compensation_temp(struct bmp280_data *data,
>>>  	return 0;
>>>  }
>>>  
>>> -static int bmp280_read_compensation_press(struct bmp280_data *data,
>>> -					  struct bmp280_comp_press *comp)
>>> +static int bmp280_read_compensation_press(struct bmp280_data *data)
>>>  {
>>>  	int ret;
>>>  	__le16 buf[BMP280_COMP_PRESS_REG_COUNT / 2];
>>> +	struct bmp280_comp *comp = &data->comp;
>>>  
>>>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
>>>  			       buf, BMP280_COMP_PRESS_REG_COUNT);
>>> @@ -196,11 +194,10 @@ static int bmp280_read_compensation_press(struct bmp280_data *data,
>>>   *
>>>   * Taken from datasheet, Section 3.11.3, "Compensation formula".
>>>   */
>>> -static s32 bmp280_compensate_temp(struct bmp280_data *data,
>>> -				  struct bmp280_comp_temp *comp,
>>> -				  s32 adc_temp)
>>> +static s32 bmp280_compensate_temp(struct bmp280_data *data, s32 adc_temp)
>>>  {
>>>  	s32 var1, var2;
>>> +	struct bmp280_comp *comp = &data->comp;
>>>  
>>>  	var1 = (((adc_temp >> 3) - ((s32) comp->dig_t1 << 1)) *
>>>  		((s32) comp->dig_t2)) >> 11;
>>> @@ -219,11 +216,10 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
>>>   *
>>>   * Taken from datasheet, Section 3.11.3, "Compensation formula".
>>>   */
>>> -static u32 bmp280_compensate_press(struct bmp280_data *data,
>>> -				   struct bmp280_comp_press *comp,
>>> -				   s32 adc_press)
>>> +static u32 bmp280_compensate_press(struct bmp280_data *data, s32 adc_press)
>>>  {
>>>  	s64 var1, var2, p;
>>> +	struct bmp280_comp *comp = &data->comp;
>>>  
>>>  	var1 = ((s64) data->t_fine) - 128000;
>>>  	var2 = var1 * var1 * (s64) comp->dig_p6;
>>> @@ -249,11 +245,6 @@ static int bmp280_read_temp(struct bmp280_data *data,
>>>  	int ret;
>>>  	__be32 tmp = 0;
>>>  	s32 adc_temp, comp_temp;
>>> -	struct bmp280_comp_temp comp;
>>> -
>>> -	ret = bmp280_read_compensation_temp(data, &comp);
>>> -	if (ret < 0)
>>> -		return ret;
>>>  
>>>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
>>>  			       (u8 *) &tmp, 3);
>>> @@ -263,7 +254,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
>>>  	}
>>>  
>>>  	adc_temp = be32_to_cpu(tmp) >> 12;
>>> -	comp_temp = bmp280_compensate_temp(data, &comp, adc_temp);
>>> +	comp_temp = bmp280_compensate_temp(data, adc_temp);
>>>  
>>>  	/*
>>>  	 * val might be NULL if we're called by the read_press routine,
>>> @@ -284,11 +275,6 @@ static int bmp280_read_press(struct bmp280_data *data,
>>>  	__be32 tmp = 0;
>>>  	s32 adc_press;
>>>  	u32 comp_press;
>>> -	struct bmp280_comp_press comp;
>>> -
>>> -	ret = bmp280_read_compensation_press(data, &comp);
>>> -	if (ret < 0)
>>> -		return ret;
>>>  
>>>  	/* Read and compensate temperature so we get a reading of t_fine. */
>>>  	ret = bmp280_read_temp(data, NULL);
>>> @@ -303,7 +289,7 @@ static int bmp280_read_press(struct bmp280_data *data,
>>>  	}
>>>  
>>>  	adc_press = be32_to_cpu(tmp) >> 12;
>>> -	comp_press = bmp280_compensate_press(data, &comp, adc_press);
>>> +	comp_press = bmp280_compensate_press(data, adc_press);
>>>  
>>>  	*val = comp_press;
>>>  	*val2 = 256000;
>>> @@ -375,6 +361,14 @@ static int bmp280_chip_init(struct bmp280_data *data)
>>>  		return ret;
>>>  	}
>>>  
>>> +	ret = bmp280_read_compensation_temp(data);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	ret = bmp280_read_compensation_press(data);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>>  	return ret;
>>>  }
>>>  
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
