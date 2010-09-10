Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:44484 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab0IJLx5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Sep 2010 07:53:57 -0400
Message-ID: <4C8A1C54.6030603@cam.ac.uk>
Date: Fri, 10 Sep 2010 12:53:56 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Donggeun Kim <dg77.kim@samsung.com>
CC: linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org,
	kyungmin.park@samsung.com
Subject: Re: [PATCH] staging: iio: tmd2771x: Add tmd2771x proximity and ambient
 light sensor driver
References: <4C888599.1060400@samsung.com> <4C88CC17.5070902@cam.ac.uk> <4C8A181C.7080109@samsung.com>
In-Reply-To: <4C8A181C.7080109@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Donggeun,

...
>> If they were auxiliary adcs (measuring some pin input) they would be
>> in0_raw and in1_raw.  Here I believe they are providing raw access to
>> the readings on two different light sensors?  Can we have names that
>> give us some clue of the range that each of these sensors cover?
> Because overall structure is similar to tsl2563, 
> the channel 0 is resposive to both visible and infrared light and channel 1 is responsive to infraread light.
> I will change adc0 and adc1 into intensity_both_raw and intensity_ir_raw likewise in tsl2563.c file, respectively
>>> +	&dev_attr_adc0.attr,
>>> +	&dev_attr_adc1.attr,
>>> +	&dev_attr_illuminance0_input.attr,
>>> +	&dev_attr_power_on.attr,
>>
>> Please provide details on each of the next three attributes.  They are
>> non standard and so need to be documented.
> The device have bitfields for each proximity and light sensor.
> The proximity_en and light_en attributes are related to the corresponding bit fields in the register.
> And the device is in the sleep mode, after a power-on-reset.
> As soon as the power_on attribute is enabled, the device will move to the start state.
> It will then continue through proximity sensing state, wait state, light sensing state, and start state.
> This procedure will be continuing if the device does not enter into sleep mode.
> When wait_en attribute is disabled, the device jumps the wait state.
That makes sense. Please add a comment to the code somewhere to explain this.
>>> +	&dev_attr_wait_en.attr,
>>> +	&dev_attr_proximity_en.attr,
>>> +	&dev_attr_light_en.attr,
>>> +	&iio_const_attr_name.dev_attr.attr,
>>> +	NULL
>>> +};

...
>>
>> As this isn't done yet, can I confirm what exactly we have here?
>> I would propose updating to the new abi when it is confirmed
>> as a separate patch (so as not to delay your driver).
>>> +static struct attribute *tmd2771x_event_attributes[] = {
>>> +	&iio_event_attr_proximity_mag_either_rising_en.dev_attr.attr,
>>> +	&dev_attr_proximity_mag_pos_rising_value.attr,
>>> +	&dev_attr_proximity_mag_neg_rising_value.attr,
>> So we have a single enable for both directions. As this isn't
>> signed, I guess we can put a threshold on the value falling and
>> one on it rising?  So if our current is say 10, we can get an
>> event if it falls below 8 or rises above 20?
>> I think under the previous scheme this should have been
>> mag_pos_rising and mag_pos_falling (neg implies a theshold on the
>> actual negative value).  Is there any way of enabling only
>> one of these at a time?  Under the new scheme these will
>> be (if it doesn't change) proxmity_thresh_en,
>> proximity_thresh_rising_value and proximity_thresh_falling_value.
>>
> Actually, every raw data is positive number. I made some mistakes
> when naming the event attributes.
> The threshold values allows the user to define thresholds above and below a desired
> channel0 of light sensor and proximity level.
> An interrupt can be generated when the raw data exceeds the upper threshold value or
> falls below the lower threshold value.
> I'm not the proper attribute name, but I want to change it as belows:
> proximity_mag_either_rising_en -> proximity_thresh_en
> proximity_mag_pos_rising_value -> proximity_thresh_high_value
> proximity_mag_neg_rising_value -> proximity_thresh_low_value
Rising and falling rather than low and high as we care about the
direction of change causing the interrupt.  Again, don't worry too
much about these, now I know what they are I can sort them out along
with all other drivers when we have agreed what the final interface will be.
> proximity_mag_either_rising_period -> proximity_thresh_period
> light_mag_either_rising_en -> intensity_both_thresh_en
> light_mag_pos_rising_value -> intensity_both_thresh_high_value
> light_mag_neg_rising_value -> intensity_both_thresh_low_value
> light_mag_either_rising_period -> intensity_both_thresh_period
>>> +	&dev_attr_proximity_mag_either_rising_period.attr,
>>> +	&iio_event_attr_light_mag_either_rising_en.dev_attr.attr,
>>> +	&dev_attr_light_mag_pos_rising_value.attr,
>>> +	&dev_attr_light_mag_neg_rising_value.attr,
>>> +	&dev_attr_light_mag_either_rising_period.attr,

>>> +#define TMD2771X_POWERUP_WAIT_TIME		12
>>> +
>>
>> Please document this structure.  Kernel doc format ideally.
> Sorry. I'm not familiar with kernel doc format.
> Where sholud I locate it after making a document file?

Stick (with all elements documented...) the following in here.

/**
 * struct tmd2771x_platform_data - device instance specific data
 * @control_power_source:  function that controls power to the device
 * @power_on:  cache of poweron elements of TMD2771X_DEFAULT_COMMAND register
 * ...
 * @glass_attenuation: implementatation specific attenuation factor
 **/
>>> +struct tmd2771x_platform_data {
>>> +	void (*control_power_source)(int);
>>> +
>>> +	u8 power_on;			/* TMD2771X_PON   */
>>> +	u8 wait_enable;			/* TMD2771X_WEN  */
>>> +	u8 wait_long;			/* TMD2771X_WLONG */
>>> +	u8 wait_time;			/* 0x00 ~ 0xff	*/
>>> +
>>> +	/* Proximity */
>>> +	u8 ps_enable;			/* TMD2771X_PEN	*/
>>> +	u16 ps_interrupt_h_thres;	/* 0x0000 ~ 0xffff */
>>> +	u16 ps_interrupt_l_thres;	/* 0x0000 ~ 0xffff */
>>> +	u8 ps_interrupt_enable;		/* TMD2771X_PIEN */
>>> +	u8 ps_time;			/* 0x00 ~ 0xff	*/
>>> +	u8 ps_interrupt_persistence;	/* 0x00 ~ 0xf0 (top four bits) */
>>> +	u8 ps_pulse_count;		/* 0x00 ~ 0xff	*/
>>> +	u8 ps_drive_strength;		/* TMD2771X_PDRIVE_12MA ~
>>> +					   TMD2771X_PDRIVE_100MA */
>>> +	u8 ps_diode;			/* TMD2771X_PDIODE_CH0_DIODE ~
>>> +					   TMD2771X_PDIODE_BOTH_DIODE */
>>> +
>>> +	/* Ambient Light */
>>> +	u8 als_enable;			/* TMD2771X_AEN */
>>> +	u16 als_interrupt_h_thres;	/* 0x0000 ~ 0xffff */
>>> +	u16 als_interrupt_l_thres;	/* 0x0000 ~ 0xffff */
>>> +	u8 als_interrupt_enable;	/* TMD2771X_AIEN */
>>> +	u8 als_time;			/* 0x00 ~ 0xff */
>>> +	u8 als_interrupt_persistence;	/* 0x00 ~ 0x0f (bottom four bits) */
>>> +	u8 als_gain;			/* TMD2771X_AGAIN_1X ~
>>> +					   TMD2771X_AGAIN_120X */
>>> +	u8 glass_attenuation;
>>> +};
>>> +
>>> +#endif
>>> diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
>>> index 6083416..c74eb83 100644
>>> --- a/drivers/staging/iio/sysfs.h
>>> +++ b/drivers/staging/iio/sysfs.h
>>> @@ -330,6 +330,7 @@ struct iio_const_attr {
>>>  #define IIO_EVENT_CODE_ADC_BASE		500
>>>  #define IIO_EVENT_CODE_MISC_BASE	600
>>>  #define IIO_EVENT_CODE_LIGHT_BASE	700
>>> +#define IIO_EVENT_CODE_PROXIMITY_BASE	800
>>>  
>>>  #define IIO_EVENT_CODE_DEVICE_SPECIFIC	1000
>>>  
>>> @@ -367,4 +368,6 @@ struct iio_const_attr {
>>>  #define IIO_EVENT_CODE_RING_75_FULL	(IIO_EVENT_CODE_RING_BASE + 1)
>>>  #define IIO_EVENT_CODE_RING_100_FULL	(IIO_EVENT_CODE_RING_BASE + 2)
>>>  
>>> +#define IIO_EVENT_CODE_PROXIMITY_THRESH	IIO_EVENT_CODE_PROXIMITY_BASE
>>> +
>>>  #endif /* _INDUSTRIAL_IO_SYSFS_H_ */
>>
>> Thanks again.
>>
>> Jonathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> Thanks for reviewing.
You are welcome,

Jonathan
