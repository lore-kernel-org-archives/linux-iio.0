Return-Path: <SRS0=bgJP=DH=free-electrons.com=quentin.schulz@kernel.org>
Subject: Re: [PATCH 5/8] power: supply: axp20x_battery: add support for AXP813
To: Jonathan Cameron <jic23@kernel.org>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
 linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
 lee.jones@linaro.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, icenowy@aosc.io, linux-sunxi@googlegroups.com,
 thomas.petazzoni@free-electrons.com
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <545d3aa6339c9e33060d651c42d652d0b848c06b.1512396054.git-series.quentin.schulz@free-electrons.com>
 <20171210164910.415da6f5@archlinux>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <873410df-046e-bd86-584d-0d35b9d8c993@free-electrons.com>
Date: Mon, 11 Dec 2017 09:35:43 +0100
MIME-Version: 1.0
In-Reply-To: <20171210164910.415da6f5@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On 10/12/2017 17:49, Jonathan Cameron wrote:
> On Mon,  4 Dec 2017 15:12:51 +0100
> Quentin Schulz <quentin.schulz@free-electrons.com> wrote:
> 
>> The X-Powers AXP813 PMIC has got some slight differences from
>> AXP20X/AXP22X PMICs:
>>  - the maximum voltage supplied by the PMIC is 4.35 instead of 4.36/4.24
>>  for AXP20X/AXP22X,
>>  - the constant charge current formula is different,
>>
>> It also has a bit to tell whether the battery percentage returned by the
>> PMIC is valid.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> I'd use switch statements when matching the IDs as that'll be more elegant
> as you perhaps add further devices going forward...
> 
> Other than that, looks good to me.
> 

Well, I was wondering if it shouldn't be better to define a structure
for each device containing their quirks, functions, etc... like it is
done for the ADC or the ACIN power supply driver part.

struct axp20x_data {
	bool	has_valid_fg_reg;
	void 	constant_charge_current_to_raw(struct axp20x_batt_ps *axp, int *val);
	void 	raw_to_constant_charge_current(struct axp20x_batt_ps *axp, int *val);
	int 	get_max_voltage(struct axp20x_batt_ps *axp, int *val);
	[...]
};

static const struct of_device_id axp20x_battery_ps_id[] = {
	{ .compatible = "x-powers,axp209-battery-power-supply", .data = (void
*)&axp209_data, }, {}
};

void probe()
{
	[...]
	axp20x_batt->info = of_device_get_match_data(&pdev->dev);
	[...]
}

Sebastian, any objection on doing this?

Thanks,
Quentin

> Jonathan
> 
>> ---
>>  drivers/power/supply/axp20x_battery.c | 44 +++++++++++++++++++++++++++-
>>  1 file changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
>> index 7494f0f..cb30302 100644
>> --- a/drivers/power/supply/axp20x_battery.c
>> +++ b/drivers/power/supply/axp20x_battery.c
>> @@ -46,6 +46,8 @@
>>  #define AXP20X_CHRG_CTRL1_TGT_4_2V	(2 << 5)
>>  #define AXP20X_CHRG_CTRL1_TGT_4_36V	(3 << 5)
>>  
>> +#define AXP813_CHRG_CTRL1_TGT_4_35V	(3 << 5)
>> +
>>  #define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
>>  #define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
>>  
>> @@ -123,10 +125,41 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>>  	return 0;
>>  }
>>  
>> +static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>> +					  int *val)
>> +{
>> +	int ret, reg;
>> +
>> +	ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
> 
> You could do a lookup based from a table instead which might
> be ever so slightly more elegant..
> 
>> +	case AXP20X_CHRG_CTRL1_TGT_4_1V:
>> +		*val = 4100000;
>> +		break;
>> +	case AXP20X_CHRG_CTRL1_TGT_4_15V:
>> +		*val = 4150000;
>> +		break;
>> +	case AXP20X_CHRG_CTRL1_TGT_4_2V:
>> +		*val = 4200000;
>> +		break;
>> +	case AXP813_CHRG_CTRL1_TGT_4_35V:
>> +		*val = 4350000;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static void raw_to_constant_charge_current(struct axp20x_batt_ps *axp, int *val)
>>  {
>>  	if (axp->axp_id == AXP209_ID)
>>  		*val = *val * 100000 + 300000;
>> +	else if (axp->axp_id == AXP813_ID)
>> +		*val = *val * 200000 + 200000;
>>  	else
>>  		*val = *val * 150000 + 300000;
> 
> Switch?
> 
>>  }
>> @@ -135,6 +168,8 @@ static void constant_charge_current_to_raw(struct axp20x_batt_ps *axp, int *val)
>>  {
>>  	if (axp->axp_id == AXP209_ID)
>>  		*val = (*val - 300000) / 100000;
>> +	else if (axp->axp_id == AXP813_ID)
>> +		*val = (*val - 200000) / 200000;
>>  	else
>>  		*val = (*val - 300000) / 150000;
>>  }
>> @@ -269,7 +304,8 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>>  		if (ret)
>>  			return ret;
>>  
>> -		if (axp20x_batt->axp_id == AXP221_ID &&
>> +		if ((axp20x_batt->axp_id == AXP221_ID ||
>> +		     axp20x_batt->axp_id == AXP813_ID) &&
>>  		    !(reg & AXP22X_FG_VALID))
>>  			return -EINVAL;
>>  
>> @@ -284,6 +320,9 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>>  		if (axp20x_batt->axp_id == AXP209_ID)
>>  			return axp20x_battery_get_max_voltage(axp20x_batt,
>>  							      &val->intval);
>> +		else if (axp20x_batt->axp_id == AXP813_ID)
>> +			return axp813_battery_get_max_voltage(axp20x_batt,
>> +							      &val->intval);
>>  		return axp22x_battery_get_max_voltage(axp20x_batt,
>>  						      &val->intval);
> 
> Worth converting to a switch statement to make it more elegant for future
> devices?
> 
>>  
>> @@ -467,6 +506,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
>>  	}, {
>>  		.compatible = "x-powers,axp221-battery-power-supply",
>>  		.data = (void *)AXP221_ID,
>> +	}, {
>> +		.compatible = "x-powers,axp813-battery-power-supply",
>> +		.data = (void *)AXP813_ID,
>>  	}, { /* sentinel */ },
>>  };
>>  MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
