Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42221 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934859AbcJYR1t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 13:27:49 -0400
Subject: Re: [PATCH v4 4/4] platform/chrome: cros_ec_dev - Register cros-ec
 sensors
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <1470045278-18161-1-git-send-email-enric.balletbo@collabora.com>
 <1470045278-18161-5-git-send-email-enric.balletbo@collabora.com>
 <94104b85-6dd7-01fa-85dc-ae1f16e47869@kernel.org>
 <e006874c-2960-f795-ef2a-2418b9381e48@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4ca629f0-2a53-c462-ac93-73588c87e873@kernel.org>
Date: Tue, 25 Oct 2016 18:27:44 +0100
MIME-Version: 1.0
In-Reply-To: <e006874c-2960-f795-ef2a-2418b9381e48@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/16 18:20, Jonathan Cameron wrote:
> On 15/08/16 16:31, Jonathan Cameron wrote:
>> On 01/08/16 10:54, Enric Balletbo i Serra wrote:
>>> Check whether the ChromeOS Embedded Controller is a sensor hub and in
>>> such case issue a command to get the number of sensors and register them
>>> all.
>>>
>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Just realised I don't have an Ack from Olof for these.
> 
> Olof - after much back and forth I'm taking the rest of
> this series via the IIO tree. If you are happy with the below
> then I'll pick this one up.
> 
> There will be an immutable branch needed for dependencies from
> mfd and getting the changes back to them (it's a mess).

Anyhow now applied to an immutable branch of iio.git
ib-iio-mfd-4.9rc1

Lee, up to you whether you want to pull this in or not.
For now only has these 4 patches.

Jonathan

p.s. Greg just a heads up that there will be a merge commit for
this in the next IIO pull request.
> 
> Jonathan
>>> ---
>>>
>>> Changes since v3:
>>>  - Remove Unnecessary ( ) around 'ret < 0'.
>>>  - Add Reviewed-by tag
>>>
>>>  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   4 +-
>>>  drivers/platform/chrome/cros_ec_dev.c              | 122 +++++++++++++++++++++
>>>  2 files changed, 124 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
>>> index 48edeba..d6c372b 100644
>>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
>>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
>>> @@ -51,7 +51,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>>>  	s16 data = 0;
>>>  	s64 val64;
>>>  	int i;
>>> -	int ret = IIO_VAL_INT;
>>> +	int ret;
>>>  	int idx = chan->scan_index;
>>>  
>>>  	mutex_lock(&st->core.cmd_lock);
>>> @@ -137,7 +137,7 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
>>>  {
>>>  	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
>>>  	int i;
>>> -	int ret = 0;
>>> +	int ret;
>>>  	int idx = chan->scan_index;
>> *raises eyebrows*
>>
>> Enough said?
>>
>> Was wondering why this patch had strayed into the IIO files.
>>
> I moved this to patch 2.
>>
>>>  
>>>  	mutex_lock(&st->core.cmd_lock);
>>> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
>>> index 7eb5307..47268ec 100644
>>> --- a/drivers/platform/chrome/cros_ec_dev.c
>>> +++ b/drivers/platform/chrome/cros_ec_dev.c
>>> @@ -18,6 +18,7 @@
>>>   */
>>>  
>>>  #include <linux/fs.h>
>>> +#include <linux/mfd/core.h>
>>>  #include <linux/module.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/slab.h>
>>> @@ -265,6 +266,123 @@ static void __remove(struct device *dev)
>>>  	kfree(ec);
>>>  }
>>>  
>>> +static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>>> +{
>>> +	/*
>>> +	 * Issue a command to get the number of sensor reported.
>>> +	 * Build an array of sensors driver and register them all.
>>> +	 */
>>> +	int ret, i, id, sensor_num;
>>> +	struct mfd_cell *sensor_cells;
>>> +	struct cros_ec_sensor_platform *sensor_platforms;
>>> +	int sensor_type[MOTIONSENSE_TYPE_MAX];
>>> +	struct ec_params_motion_sense *params;
>>> +	struct ec_response_motion_sense *resp;
>>> +	struct cros_ec_command *msg;
>>> +
>>> +	msg = kzalloc(sizeof(struct cros_ec_command) +
>>> +		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
>>> +	if (msg == NULL)
>>> +		return;
>>> +
>>> +	msg->version = 2;
>>> +	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>>> +	msg->outsize = sizeof(*params);
>>> +	msg->insize = sizeof(*resp);
>>> +
>>> +	params = (struct ec_params_motion_sense *)msg->data;
>>> +	params->cmd = MOTIONSENSE_CMD_DUMP;
>>> +
>>> +	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
>>> +	if (ret < 0 || msg->result != EC_RES_SUCCESS) {
>>> +		dev_warn(ec->dev, "cannot get EC sensor information: %d/%d\n",
>>> +			 ret, msg->result);
>>> +		goto error;
>>> +	}
>>> +
>>> +	resp = (struct ec_response_motion_sense *)msg->data;
>>> +	sensor_num = resp->dump.sensor_count;
>>> +	/* Allocate 2 extra sensors in case lid angle or FIFO are needed */
>>> +	sensor_cells = kzalloc(sizeof(struct mfd_cell) * (sensor_num + 2),
>>> +			       GFP_KERNEL);
>>> +	if (sensor_cells == NULL)
>>> +		goto error;
>>> +
>>> +	sensor_platforms = kzalloc(sizeof(struct cros_ec_sensor_platform) *
>>> +		  (sensor_num + 1), GFP_KERNEL);
>>> +	if (sensor_platforms == NULL)
>>> +		goto error_platforms;
>>> +
>>> +	memset(sensor_type, 0, sizeof(sensor_type));
>>> +	id = 0;
>>> +	for (i = 0; i < sensor_num; i++) {
>>> +		params->cmd = MOTIONSENSE_CMD_INFO;
>>> +		params->info.sensor_num = i;
>>> +		ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
>>> +		if (ret < 0 || msg->result != EC_RES_SUCCESS) {
>>> +			dev_warn(ec->dev, "no info for EC sensor %d : %d/%d\n",
>>> +				 i, ret, msg->result);
>>> +			continue;
>>> +		}
>>> +		switch (resp->info.type) {
>>> +		case MOTIONSENSE_TYPE_ACCEL:
>>> +			sensor_cells[id].name = "cros-ec-accel";
>>> +			break;
>>> +		case MOTIONSENSE_TYPE_GYRO:
>>> +			sensor_cells[id].name = "cros-ec-gyro";
>>> +			break;
>>> +		case MOTIONSENSE_TYPE_MAG:
>>> +			sensor_cells[id].name = "cros-ec-mag";
>>> +			break;
>>> +		case MOTIONSENSE_TYPE_PROX:
>>> +			sensor_cells[id].name = "cros-ec-prox";
>>> +			break;
>>> +		case MOTIONSENSE_TYPE_LIGHT:
>>> +			sensor_cells[id].name = "cros-ec-light";
>>> +			break;
>>> +		case MOTIONSENSE_TYPE_ACTIVITY:
>>> +			sensor_cells[id].name = "cros-ec-activity";
>>> +			break;
>>> +		default:
>>> +			dev_warn(ec->dev, "unknown type %d\n", resp->info.type);
>>> +			continue;
>>> +		}
>>> +		sensor_platforms[id].sensor_num = i;
>>> +		sensor_cells[id].id = sensor_type[resp->info.type];
>>> +		sensor_cells[id].platform_data = &sensor_platforms[id];
>>> +		sensor_cells[id].pdata_size =
>>> +			sizeof(struct cros_ec_sensor_platform);
>>> +
>>> +		sensor_type[resp->info.type]++;
>>> +		id++;
>>> +	}
>>> +	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
>>> +		sensor_platforms[id].sensor_num = sensor_num;
>>> +
>>> +		sensor_cells[id].name = "cros-ec-angle";
>>> +		sensor_cells[id].id = 0;
>>> +		sensor_cells[id].platform_data = &sensor_platforms[id];
>>> +		sensor_cells[id].pdata_size =
>>> +			sizeof(struct cros_ec_sensor_platform);
>>> +		id++;
>>> +	}
>>> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
>>> +		sensor_cells[id].name = "cros-ec-ring";
>>> +		id++;
>>> +	}
>>> +
>>> +	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
>>> +			      NULL, 0, NULL);
>>> +	if (ret)
>>> +		dev_err(ec->dev, "failed to add EC sensors\n");
>>> +
>>> +	kfree(sensor_platforms);
>>> +error_platforms:
>>> +	kfree(sensor_cells);
>>> +error:
>>> +	kfree(msg);
>>> +}
>>> +
>>>  static int ec_device_probe(struct platform_device *pdev)
>>>  {
>>>  	int retval = -ENOMEM;
>>> @@ -319,6 +437,10 @@ static int ec_device_probe(struct platform_device *pdev)
>>>  		goto dev_reg_failed;
>>>  	}
>>>  
>>> +	/* check whether this EC is a sensor hub. */
>>> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>>> +		cros_ec_sensors_register(ec);
>>> +
>>>  	return 0;
>>>  
>>>  dev_reg_failed:
>>>
>>
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

