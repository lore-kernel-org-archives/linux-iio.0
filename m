Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42696 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbcK0Psn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 10:48:43 -0500
Subject: Re: [PATCH V5 2/2] iio: adc: spmi-vadc: Changes to support different
 scaling
To: Rama Krishna Phani A <rphani@codeaurora.org>,
        linux-iio@vger.kernel.org
References: <1479965465-30182-1-git-send-email-rphani@codeaurora.org>
 <1479965465-30182-3-git-send-email-rphani@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, cdevired@codeaurora.org,
        smohanad@codeaurora.org, mgautam@codeaurora.org,
        sivaa@codeaurora.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Julia.Lawall@lip6.fr
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <13ba4983-db04-4ea3-73c0-6b82a319322b@kernel.org>
Date: Sun, 27 Nov 2016 15:48:34 +0000
MIME-Version: 1.0
In-Reply-To: <1479965465-30182-3-git-send-email-rphani@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/11/16 05:31, Rama Krishna Phani A wrote:
> Several ADC channels are supported in PMIC which can be used to
> measure voltage, temperature, current etc. Different scaling can be
> applied on the obtained voltage to report in physical units. Scaling
> functionality can be different per channel. Add scaling support per
> channel. Every channel present in adc has an unique conversion formula
> for obtained voltage. Add support to report in Raw as well as in
> processed format. Scaling is applied when processed read is requested
> and is not applied when a Raw read is requested.
> 
> Signed-off-by: Rama Krishna Phani A <rphani@codeaurora.org>
I obviously didn't make it clear enough in last review.

If you can't return a value in response to reading a sysfs attribute, the
attribute should not exist.  See below for a suggestion on this.

Jonathan
> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 435 +++++++++++++++++++++++++++++----------
>  1 file changed, 326 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 93c0639..a4e5405 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -84,7 +84,7 @@
>  #define VADC_MAX_ADC_CODE			0xa800
>  
>  #define VADC_ABSOLUTE_RANGE_UV			625000
> -#define VADC_RATIOMETRIC_RANGE_UV		1800000
> +#define VADC_RATIOMETRIC_RANGE			1800
>  
>  #define VADC_DEF_PRESCALING			0 /* 1:1 */
>  #define VADC_DEF_DECIMATION			0 /* 512 */
> @@ -100,9 +100,23 @@
>  
>  #define KELVINMIL_CELSIUSMIL			273150
>  
> +#define PMI_CHG_SCALE_1				-138890
> +#define PMI_CHG_SCALE_2				391750000000
> +
>  #define VADC_CHAN_MIN			VADC_USBIN
>  #define VADC_CHAN_MAX			VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM
>  
> +/**
> + * struct vadc_map_pt - Map the graph representation for ADC channel
> + * @x: Represent the ADC digitized code.
> + * @y: Represent the physical data which can be temperature, voltage,
> + *     resistance.
> + */
> +struct vadc_map_pt {
> +	s32 x;
> +	s32 y;
> +};
> +
>  /*
>   * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
>   * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
> @@ -148,6 +162,9 @@ struct vadc_prescale_ratio {
>   *	start of conversion.
>   * @avg_samples: ability to provide single result from the ADC
>   *	that is an average of multiple measurements.
> + * @scale_fn: Represents the scaling function to convert voltage
> + *	physical units desired by the client for the channel.
> + *	Referenced from enum vadc_scale_fn_type.
>   */
>  struct vadc_channel_prop {
>  	unsigned int channel;
> @@ -156,6 +173,7 @@ struct vadc_channel_prop {
>  	unsigned int prescale;
>  	unsigned int hw_settle_time;
>  	unsigned int avg_samples;
> +	unsigned int scale_fn;
>  };
>  
>  /**
> @@ -186,6 +204,37 @@ struct vadc_priv {
>  	struct mutex		 lock;
>  };
>  
> +/**
> + * struct vadc_scale_fn - Scaling function prototype
> + * @scale: Function pointer to one of the scaling functions
> + *	which takes the adc properties, channel properties,
> + *	and returns the physical result.
> + */
> +struct vadc_scale_fn {
> +	int (*scale)(struct vadc_priv *, const struct vadc_channel_prop *,
> +		     u16, int *);
> +};
> +
> +/**
> + * enum vadc_scale_fn_type - Scaling function to convert ADC code to
> + *				physical scaled units for the channel.
> + * SCALE_DEFAULT: Default scaling to convert raw adc code to voltage (uV).
> + * SCALE_THERM_100K_PULLUP: Returns temperature in millidegC.
> + *				 Uses a mapping table with 100K pullup.
> + * SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
> + * SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
> + * SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
> + * SCALE_NONE: Do not use this scaling type.
> + */
> +enum vadc_scale_fn_type {
> +	SCALE_DEFAULT = 0,
> +	SCALE_THERM_100K_PULLUP,
> +	SCALE_PMIC_THERM,
> +	SCALE_XOTHERM,
> +	SCALE_PMI_CHG_TEMP,
> +	SCALE_NONE,
> +};
> +
>  static const struct vadc_prescale_ratio vadc_prescale_ratios[] = {
>  	{.num =  1, .den =  1},
>  	{.num =  1, .den =  3},
> @@ -197,6 +246,44 @@ struct vadc_priv {
>  	{.num =  1, .den = 10}
>  };
>  
> +/* Voltage to temperature */
> +static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
> +	{1758,	-40},
> +	{1742,	-35},
> +	{1719,	-30},
> +	{1691,	-25},
> +	{1654,	-20},
> +	{1608,	-15},
> +	{1551,	-10},
> +	{1483,	-5},
> +	{1404,	0},
> +	{1315,	5},
> +	{1218,	10},
> +	{1114,	15},
> +	{1007,	20},
> +	{900,	25},
> +	{795,	30},
> +	{696,	35},
> +	{605,	40},
> +	{522,	45},
> +	{448,	50},
> +	{383,	55},
> +	{327,	60},
> +	{278,	65},
> +	{237,	70},
> +	{202,	75},
> +	{172,	80},
> +	{146,	85},
> +	{125,	90},
> +	{107,	95},
> +	{92,	100},
> +	{79,	105},
> +	{68,	110},
> +	{59,	115},
> +	{51,	120},
> +	{44,	125}
> +};
> +
>  static int vadc_read(struct vadc_priv *vadc, u16 offset, u8 *data)
>  {
>  	return regmap_bulk_read(vadc->regmap, vadc->base + offset, data, 1);
> @@ -418,7 +505,7 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  	u16 read_1, read_2;
>  	int ret;
>  
> -	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE_UV;
> +	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE;
>  	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
>  
>  	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
> @@ -468,6 +555,51 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  	return ret;
>  }
>  
> +static int vadc_map_voltage_temp(const struct vadc_map_pt *pts,
> +				 u32 tablesize, s32 input, s64 *output)
> +{
> +	bool descending = 1;
> +	u32 i = 0;
> +
> +	if (!pts)
> +		return -EINVAL;
> +
> +	/* Check if table is descending or ascending */
> +	if (tablesize > 1) {
> +		if (pts[0].x < pts[1].x)
> +			descending = 0;
> +	}
> +
> +	while (i < tablesize) {
> +		if ((descending) && (pts[i].x < input)) {
> +			/* table entry is less than measured*/
> +			 /* value and table is descending, stop */
> +			break;
> +		} else if ((!descending) &&
> +				(pts[i].x > input)) {
> +			/* table entry is greater than measured*/
> +			/*value and table is ascending, stop */
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	if (i == 0) {
> +		*output = pts[0].y;
> +	} else if (i == tablesize) {
> +		*output = pts[tablesize - 1].y;
> +	} else {
> +		/* result is between search_index and search_index-1 */
> +		/* interpolate linearly */
> +		*output = (((s32)((pts[i].y - pts[i - 1].y) *
> +			(input - pts[i - 1].x)) /
> +			(pts[i].x - pts[i - 1].x)) +
> +			pts[i - 1].y);
> +	}
> +
> +	return 0;
> +}
> +
>  static void vadc_scale_calib(struct vadc_priv *vadc, u16 adc_code,
>  			     const struct vadc_channel_prop *prop,
>  			     s64 *scale_voltage)
> @@ -502,6 +634,77 @@ static int vadc_scale_volt(struct vadc_priv *vadc,
>  	return 0;
>  }
>  
> +static int vadc_scale_therm(struct vadc_priv *vadc,
> +			    const struct vadc_channel_prop *prop, u16 adc_code,
> +			    int *result_mdec)
> +{
> +	s64 voltage = 0, result = 0;
> +
> +	vadc_scale_calib(vadc, adc_code, prop, &voltage);
> +
> +	if (prop->calibration == VADC_CALIB_ABSOLUTE)
> +		voltage /= 1000;
> +
> +	vadc_map_voltage_temp(adcmap_100k_104ef_104fb,
> +			      ARRAY_SIZE(adcmap_100k_104ef_104fb),
> +			      voltage, &result);
> +	result *= 1000;
> +	*result_mdec = result;
> +
> +	return 0;
> +}
> +
> +static int vadc_scale_die_temp(struct vadc_priv *vadc,
> +			       const struct vadc_channel_prop *prop,
> +			       u16 adc_code, int *result_mdec)
> +{
> +	const struct vadc_prescale_ratio *prescale;
> +	s64 voltage = 0;
> +
> +	vadc_scale_calib(vadc, adc_code, prop, &voltage);
> +
> +	if (voltage > 0) {
> +		prescale = &vadc_prescale_ratios[prop->prescale];
> +		voltage = voltage * prescale->den;
> +		voltage /= (prescale->num * 2);
> +	} else {
> +		voltage = 0;
> +	}
> +
> +	voltage -= KELVINMIL_CELSIUSMIL;
> +	*result_mdec = voltage;
> +
> +	return 0;
> +}
> +
> +static int vadc_scale_chg_temp(struct vadc_priv *vadc,
> +			       const struct vadc_channel_prop *prop,
> +			       u16 adc_code, int *result_mdec)
> +{
> +	const struct vadc_prescale_ratio *prescale;
> +	s64 voltage = 0, result = 0;
> +
> +	vadc_scale_calib(vadc, adc_code, prop, &voltage);
> +
> +	prescale = &vadc_prescale_ratios[prop->prescale];
> +	voltage = voltage * prescale->den;
> +	voltage = div64_s64(voltage, prescale->num);
> +	voltage = ((PMI_CHG_SCALE_1) * (voltage * 2));
> +	voltage = (voltage + PMI_CHG_SCALE_2);
> +	result =  div64_s64(voltage, 1000000);
> +	*result_mdec = result;
> +
> +	return 0;
> +}
> +
> +static int vadc_scale(struct vadc_priv *vadc,
> +		      const struct vadc_channel_prop *prop, u16 adc_code,
> +		      int *scale)
> +{
> +	dev_err(vadc->dev, "Need a scale function\n");
> +	return 0;
> +}
> +
>  static int vadc_decimation_from_dt(u32 value)
>  {
>  	if (!is_power_of_2(value) || value < VADC_DECIMATION_MIN ||
> @@ -547,6 +750,15 @@ static int vadc_avg_samples_from_dt(u32 value)
>  	return __ffs64(value);
>  }
>  
> +static struct vadc_scale_fn scale_fn[] = {
> +	[SCALE_DEFAULT] = {vadc_scale_volt},
> +	[SCALE_THERM_100K_PULLUP] = {vadc_scale_therm},
> +	[SCALE_PMIC_THERM] = {vadc_scale_die_temp},
> +	[SCALE_XOTHERM] = {vadc_scale_therm},
> +	[SCALE_PMI_CHG_TEMP] = {vadc_scale_chg_temp},
> +	[SCALE_NONE] = {vadc_scale},
> +};
> +
>  static int vadc_read_raw(struct iio_dev *indio_dev,
>  			 struct iio_chan_spec const *chan, int *val, int *val2,
>  			 long mask)
> @@ -563,7 +775,7 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			break;
>  
> -		vadc_scale_volt(vadc, prop, adc_code, val);
> +		scale_fn[prop->scale_fn].scale(vadc, prop, adc_code, val);
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_RAW:
> @@ -606,23 +818,27 @@ struct vadc_channels {
>  	unsigned int prescale_index;
>  	enum iio_chan_type type;
>  	long info_mask;
> +	unsigned int scale_fn;
>  };
>  
> -#define VADC_CHAN(_dname, _type, _mask, _pre)				\
> +#define VADC_CHAN(_dname, _type, _mask, _pre, _scale)			\
>  	[VADC_##_dname] = {						\
>  		.datasheet_name = __stringify(_dname),			\
>  		.prescale_index = _pre,					\
>  		.type = _type,						\
> -		.info_mask = _mask					\
> +		.info_mask = _mask,					\
> +		.scale_fn = _scale					\
>  	},								\
>  
> -#define VADC_CHAN_TEMP(_dname, _pre)					\
> -	VADC_CHAN(_dname, IIO_TEMP, BIT(IIO_CHAN_INFO_PROCESSED), _pre)	\
> +#define VADC_CHAN_TEMP(_dname, _pre, _scale)				\
> +	VADC_CHAN(_dname, IIO_TEMP,					\
> +		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),	\
> +		_pre, _scale)						\
>  
> -#define VADC_CHAN_VOLT(_dname, _pre)					\
> +#define VADC_CHAN_VOLT(_dname, _pre, _scale)				\
>  	VADC_CHAN(_dname, IIO_VOLTAGE,					\
>  		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
> -		  _pre)							\
> +		  _pre, _scale)						\
In the SCALE_NONE case you are still creating the sysfs attributes to provide
processed.  Just have a variant of this macro that doesn't do this.

That way we don't end up with a sysfs attribute that always results in
an error!

#define VADC_CHAN_VOLT_NO_KNOWN_SCALEE(_dname, _pre) \
	VADC_CHAN(_dname, IIO_VOLTAGE, BIT(IIO_CHAN_INFO_RAW), _pre);

>  
>  /*
>   * The array represents all possible ADC channels found in the supported PMICs.
> @@ -630,106 +846,106 @@ struct vadc_channels {
>   * gaps in the array should be treated as reserved channels.
>   */
>  static const struct vadc_channels vadc_chans[] = {
> -	VADC_CHAN_VOLT(USBIN, 4)
> -	VADC_CHAN_VOLT(DCIN, 4)
> -	VADC_CHAN_VOLT(VCHG_SNS, 3)
> -	VADC_CHAN_VOLT(SPARE1_03, 1)
> -	VADC_CHAN_VOLT(USB_ID_MV, 1)
> -	VADC_CHAN_VOLT(VCOIN, 1)
> -	VADC_CHAN_VOLT(VBAT_SNS, 1)
> -	VADC_CHAN_VOLT(VSYS, 1)
> -	VADC_CHAN_TEMP(DIE_TEMP, 0)
> -	VADC_CHAN_VOLT(REF_625MV, 0)
> -	VADC_CHAN_VOLT(REF_1250MV, 0)
> -	VADC_CHAN_VOLT(CHG_TEMP, 0)
> -	VADC_CHAN_VOLT(SPARE1, 0)
> -	VADC_CHAN_VOLT(SPARE2, 0)
> -	VADC_CHAN_VOLT(GND_REF, 0)
> -	VADC_CHAN_VOLT(VDD_VADC, 0)
> -
> -	VADC_CHAN_VOLT(P_MUX1_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX2_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX3_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX4_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX5_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX6_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX7_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX8_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX9_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX10_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX11_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX12_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX13_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX14_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX15_1_1, 0)
> -	VADC_CHAN_VOLT(P_MUX16_1_1, 0)
> -
> -	VADC_CHAN_VOLT(P_MUX1_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX2_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX3_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX4_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX5_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX6_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX7_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX8_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX9_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX10_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX11_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX12_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX13_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX14_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX15_1_3, 1)
> -	VADC_CHAN_VOLT(P_MUX16_1_3, 1)
> -
> -	VADC_CHAN_VOLT(LR_MUX1_BAT_THERM, 0)
> -	VADC_CHAN_VOLT(LR_MUX2_BAT_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX3_XO_THERM, 0)
> -	VADC_CHAN_VOLT(LR_MUX4_AMUX_THM1, 0)
> -	VADC_CHAN_VOLT(LR_MUX5_AMUX_THM2, 0)
> -	VADC_CHAN_VOLT(LR_MUX6_AMUX_THM3, 0)
> -	VADC_CHAN_VOLT(LR_MUX7_HW_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX8_AMUX_THM4, 0)
> -	VADC_CHAN_VOLT(LR_MUX9_AMUX_THM5, 0)
> -	VADC_CHAN_VOLT(LR_MUX10_USB_ID, 0)
> -	VADC_CHAN_VOLT(AMUX_PU1, 0)
> -	VADC_CHAN_VOLT(AMUX_PU2, 0)
> -	VADC_CHAN_VOLT(LR_MUX3_BUF_XO_THERM, 0)
> -
> -	VADC_CHAN_VOLT(LR_MUX1_PU1_BAT_THERM, 0)
> -	VADC_CHAN_VOLT(LR_MUX2_PU1_BAT_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX3_PU1_XO_THERM, 0)
> -	VADC_CHAN_VOLT(LR_MUX4_PU1_AMUX_THM1, 0)
> -	VADC_CHAN_VOLT(LR_MUX5_PU1_AMUX_THM2, 0)
> -	VADC_CHAN_VOLT(LR_MUX6_PU1_AMUX_THM3, 0)
> -	VADC_CHAN_VOLT(LR_MUX7_PU1_AMUX_HW_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX8_PU1_AMUX_THM4, 0)
> -	VADC_CHAN_VOLT(LR_MUX9_PU1_AMUX_THM5, 0)
> -	VADC_CHAN_VOLT(LR_MUX10_PU1_AMUX_USB_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX3_BUF_PU1_XO_THERM, 0)
> -
> -	VADC_CHAN_VOLT(LR_MUX1_PU2_BAT_THERM, 0)
> -	VADC_CHAN_VOLT(LR_MUX2_PU2_BAT_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX3_PU2_XO_THERM, 0)
> -	VADC_CHAN_VOLT(LR_MUX4_PU2_AMUX_THM1, 0)
> -	VADC_CHAN_VOLT(LR_MUX5_PU2_AMUX_THM2, 0)
> -	VADC_CHAN_VOLT(LR_MUX6_PU2_AMUX_THM3, 0)
> -	VADC_CHAN_VOLT(LR_MUX7_PU2_AMUX_HW_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX8_PU2_AMUX_THM4, 0)
 -	VADC_CHAN_VOLT(LR_MUX9_PU2_AMUX_THM5, 0)
> -	VADC_CHAN_VOLT(LR_MUX10_PU2_AMUX_USB_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX3_BUF_PU2_XO_THERM, 0)
> -
> -	VADC_CHAN_VOLT(LR_MUX1_PU1_PU2_BAT_THERM, 0)
> -	VADC_CHAN_VOLT(LR_MUX2_PU1_PU2_BAT_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX3_PU1_PU2_XO_THERM, 0)
> -	VADC_CHAN_VOLT(LR_MUX4_PU1_PU2_AMUX_THM1, 0)
> -	VADC_CHAN_VOLT(LR_MUX5_PU1_PU2_AMUX_THM2, 0)
> -	VADC_CHAN_VOLT(LR_MUX6_PU1_PU2_AMUX_THM3, 0)
> -	VADC_CHAN_VOLT(LR_MUX7_PU1_PU2_AMUX_HW_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX8_PU1_PU2_AMUX_THM4, 0)
> -	VADC_CHAN_VOLT(LR_MUX9_PU1_PU2_AMUX_THM5, 0)
> -	VADC_CHAN_VOLT(LR_MUX10_PU1_PU2_AMUX_USB_ID, 0)
> -	VADC_CHAN_VOLT(LR_MUX3_BUF_PU1_PU2_XO_THERM, 0)
> +	VADC_CHAN_VOLT(USBIN, 4, SCALE_DEFAULT)
> +	VADC_CHAN_VOLT(DCIN, 4, SCALE_DEFAULT)
> +	VADC_CHAN_VOLT(VCHG_SNS, 3, SCALE_NONE)
> +	VADC_CHAN_VOLT(SPARE1_03, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(USB_ID_MV, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(VCOIN, 1, SCALE_DEFAULT)
> +	VADC_CHAN_VOLT(VBAT_SNS, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(VSYS, 1, SCALE_DEFAULT)
> +	VADC_CHAN_TEMP(DIE_TEMP, 0, SCALE_PMIC_THERM)
> +	VADC_CHAN_VOLT(REF_625MV, 0, SCALE_DEFAULT)
> +	VADC_CHAN_VOLT(REF_1250MV, 0, SCALE_DEFAULT)
> +	VADC_CHAN_VOLT(CHG_TEMP, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(SPARE1, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(SPARE2, 0, SCALE_PMI_CHG_TEMP)
> +	VADC_CHAN_VOLT(GND_REF, 0, SCALE_DEFAULT)
> +	VADC_CHAN_VOLT(VDD_VADC, 0, SCALE_DEFAULT)
> +
> +	VADC_CHAN_VOLT(P_MUX1_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX2_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX3_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX4_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX5_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX6_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX7_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX8_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX9_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX10_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX11_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX12_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX13_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX14_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX15_1_1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX16_1_1, 0, SCALE_NONE)
> +
> +	VADC_CHAN_VOLT(P_MUX1_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX2_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX3_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX4_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX5_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX6_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX7_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX8_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX9_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX10_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX11_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX12_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX13_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX14_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX15_1_3, 1, SCALE_NONE)
> +	VADC_CHAN_VOLT(P_MUX16_1_3, 1, SCALE_NONE)
> +
> +	VADC_CHAN_VOLT(LR_MUX1_BAT_THERM, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX2_BAT_ID, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX3_XO_THERM, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX4_AMUX_THM1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX5_AMUX_THM2, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX6_AMUX_THM3, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX7_HW_ID, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX8_AMUX_THM4, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX9_AMUX_THM5, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX10_USB_ID, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(AMUX_PU1, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(AMUX_PU2, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX3_BUF_XO_THERM, 0, SCALE_NONE)
> +
> +	VADC_CHAN_TEMP(LR_MUX1_PU1_BAT_THERM, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX2_PU1_BAT_ID, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX3_PU1_XO_THERM, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX4_PU1_AMUX_THM1, 0, SCALE_THERM_100K_PULLUP)
> +	VADC_CHAN_TEMP(LR_MUX5_PU1_AMUX_THM2, 0, SCALE_THERM_100K_PULLUP)
> +	VADC_CHAN_TEMP(LR_MUX6_PU1_AMUX_THM3, 0, SCALE_THERM_100K_PULLUP)
> +	VADC_CHAN_VOLT(LR_MUX7_PU1_AMUX_HW_ID, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX8_PU1_AMUX_THM4, 0, SCALE_THERM_100K_PULLUP)
> +	VADC_CHAN_TEMP(LR_MUX9_PU1_AMUX_THM5, 0, SCALE_THERM_100K_PULLUP)
> +	VADC_CHAN_VOLT(LR_MUX10_PU1_AMUX_USB_ID, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX3_BUF_PU1_XO_THERM, 0, SCALE_XOTHERM)
> +
> +	VADC_CHAN_TEMP(LR_MUX1_PU2_BAT_THERM, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX2_PU2_BAT_ID, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX3_PU2_XO_THERM, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX4_PU2_AMUX_THM1, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX5_PU2_AMUX_THM2, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX6_PU2_AMUX_THM3, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX7_PU2_AMUX_HW_ID, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX8_PU2_AMUX_THM4, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX9_PU2_AMUX_THM5, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX10_PU2_AMUX_USB_ID, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX3_BUF_PU2_XO_THERM, 0, SCALE_NONE)
> +
> +	VADC_CHAN_TEMP(LR_MUX1_PU1_PU2_BAT_THERM, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX2_PU1_PU2_BAT_ID, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX3_PU1_PU2_XO_THERM, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX4_PU1_PU2_AMUX_THM1, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX5_PU1_PU2_AMUX_THM2, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX6_PU1_PU2_AMUX_THM3, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX7_PU1_PU2_AMUX_HW_ID, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX8_PU1_PU2_AMUX_THM4, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX9_PU1_PU2_AMUX_THM5, 0, SCALE_NONE)
> +	VADC_CHAN_VOLT(LR_MUX10_PU1_PU2_AMUX_USB_ID, 0, SCALE_NONE)
> +	VADC_CHAN_TEMP(LR_MUX3_BUF_PU1_PU2_XO_THERM, 0, SCALE_NONE)
>  };
>  
>  static int vadc_get_dt_channel_data(struct device *dev,
> @@ -848,6 +1064,7 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
>  			return ret;
>  		}
>  
> +		prop.scale_fn = vadc_chans[prop.channel].scale_fn;
>  		vadc->chan_props[index] = prop;
>  
>  		vadc_chan = &vadc_chans[prop.channel];
> 

