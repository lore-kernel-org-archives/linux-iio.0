Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50035 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752963AbcKENHn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 09:07:43 -0400
Subject: Re: [PATCH] iio: light and pressure: change data fields for ambient
 light and pressure sensor
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Ooi, Joyce" <joyce.ooi@intel.com>, Jiri Kosina <jikos@kernel.org>
References: <1478169814-24120-1-git-send-email-joyce.ooi@intel.com>
 <1478180144.27477.3.camel@linux.intel.com>
Cc: Song Hongyan <hongyan.song@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeer@pmeerw.net>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kweh Hock Leong <hock.leong.kweh@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Lay Kuan Loon <kuan.loon.lay@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7a8ea093-306e-8746-a23d-3bdb35dd1413@kernel.org>
Date: Sat, 5 Nov 2016 13:07:40 +0000
MIME-Version: 1.0
In-Reply-To: <1478180144.27477.3.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/16 13:35, Srinivas Pandruvada wrote:
> On Thu, 2016-11-03 at 18:43 +0800, Ooi, Joyce wrote:
>> Sensitivity Percent Relative is added for ambient light sensor as it
>> is
>> used based on HID Sensor Usages specifications.
> The same patch is submitted by Song Hongyan <hongyan.song@intel.com>
> . We may need new IIO ABI to specify relative percent hyst.
It is a particularly 'hideous' way of reporting something - particularly
as we head towards very low values.  Ah well. Yes, would need
some additional ABI.  We do already have ratio attributes so
maybe - 
hysteresis_ratio or something like that.   Ugly though.  Ah well.

Jonathan
> 
> Thanks,
> Srinivas
> 
>>
>> Other changes include adding HID_USAGE_SENSOR_LIGHT_ILLUM and
>> HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE for ambient light and pressure
>> sensor respectively to be in sync with HID Sensor Usages
>> specifications.
>>
>> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
>> ---
>>  drivers/iio/light/hid-sensor-als.c      | 10 ++++++++++
>>  drivers/iio/pressure/hid-sensor-press.c | 10 ++++++++++
>>  include/linux/hid-sensor-ids.h          |  1 +
>>  3 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/iio/light/hid-sensor-als.c
>> b/drivers/iio/light/hid-sensor-als.c
>> index 8bb1f90..6f3ca18 100644
>> --- a/drivers/iio/light/hid-sensor-als.c
>> +++ b/drivers/iio/light/hid-sensor-als.c
>> @@ -252,6 +252,16 @@ static int als_parse_report(struct
>> platform_device *pdev,
>>  			st->common_attributes.sensitivity.index,
>>  			st-
>>> common_attributes.sensitivity.report_id);
>>  	}
>> +	if (st->common_attributes.sensitivity.index < 0) {
>> +		sensor_hub_input_get_attribute_info(hsdev,
>> +			HID_FEATURE_REPORT, usage_id,
>> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY
>> _REL_PCT |
>> +			HID_USAGE_SENSOR_LIGHT_ILLUM,
>> +			&st->common_attributes.sensitivity);
>> +		dev_dbg(&pdev->dev, "Sensitivity index:report
>> %d:%d\n",
>> +			st->common_attributes.sensitivity.index,
>> +			st-
>>> common_attributes.sensitivity.report_id);
>> +	}
>>  	return ret;
>>  }
>>  
>> diff --git a/drivers/iio/pressure/hid-sensor-press.c
>> b/drivers/iio/pressure/hid-sensor-press.c
>> index 6848d8c..4cbbf88 100644
>> --- a/drivers/iio/pressure/hid-sensor-press.c
>> +++ b/drivers/iio/pressure/hid-sensor-press.c
>> @@ -249,6 +249,16 @@ static int press_parse_report(struct
>> platform_device *pdev,
>>  			st->common_attributes.sensitivity.index,
>>  			st-
>>> common_attributes.sensitivity.report_id);
>>  	}
>> +	if (st->common_attributes.sensitivity.index < 0) {
>> +		sensor_hub_input_get_attribute_info(hsdev,
>> +			HID_FEATURE_REPORT, usage_id,
>> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY
>> _ABS |
>> +			HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE,
>> +			&st->common_attributes.sensitivity);
>> +		dev_dbg(&pdev->dev, "Sensitivity index:report
>> %d:%d\n",
>> +			st->common_attributes.sensitivity.index,
>> +			st-
>>> common_attributes.sensitivity.report_id);
>> +	}
>>  	return ret;
>>  }
>>  
>> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-
>> sensor-ids.h
>> index f2ee90a..755f5e2 100644
>> --- a/include/linux/hid-sensor-ids.h
>> +++ b/include/linux/hid-sensor-ids.h
>> @@ -141,6 +141,7 @@
>>  /* Per data field properties */
>>  #define HID_USAGE_SENSOR_DATA_MOD_NONE				
>> 	0x00
>>  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		
>> 0x1000
>> +#define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT		
>> 0xE000
>>  
>>  /* Power state enumerations */
>>  #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x20
>> 0850

