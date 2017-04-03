Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47362 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbdDCPGP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 11:06:15 -0400
Subject: Re: [PATCH 7/7] mfd: cros_ec: add RTC as mfd subdevice
To: Lee Jones <lee.jones@linaro.org>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
 <20170324174407.25401-8-enric.balletbo@collabora.com>
 <20170403142512.dlipwaocizisyipg@dell>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Olof Johansson <olof@lixom.net>, bleung@chromium.org,
        martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1e60b276-5327-5bbd-15c5-fd5c920e5ba6@collabora.com>
Date: Mon, 3 Apr 2017 17:06:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170403142512.dlipwaocizisyipg@dell>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 03/04/17 16:25, Lee Jones wrote:
> On Fri, 24 Mar 2017, Enric Balletbo i Serra wrote:
> 
>> From: Stephen Barber <smbarber@chromium.org>
>>
>> If the EC supports RTC host commands, expose an RTC device.
>>
>> Signed-off-by: Stephen Barber <smbarber@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>  drivers/mfd/cros_ec.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>> index bbc17ab..1ff88b1 100644
>> --- a/drivers/mfd/cros_ec.c
>> +++ b/drivers/mfd/cros_ec.c
>> @@ -51,6 +51,11 @@ static const struct mfd_cell ec_pd_cell = {
>>  	.pdata_size = sizeof(pd_p),
>>  };
>>  
>> +static const struct mfd_cell ec_rtc_cell = {
>> +	.name = "cros-ec-rtc",
>> +	.id   = -1,
> 
> Why -1?
> 
>> +};
>> +
>>  static irqreturn_t ec_irq_thread(int irq, void *data)
>>  {
>>  	struct cros_ec_device *ec_dev = data;
>> @@ -238,6 +243,15 @@ static void cros_ec_sensors_register(struct cros_ec_device *ec_dev)
>>  	kfree(msg);
>>  }
>>  
>> +static void cros_ec_rtc_register(struct cros_ec_device *ec_dev)
>> +{
>> +	int ret;
>> +
>> +	ret = mfd_add_devices(ec_dev->dev, 0, &ec_rtc_cell, 1, NULL, 0, NULL);
> 
> Why 0?
> 

Right, just maintained the one in the original. I think I can use
PLATFORM_DEVID_AUTO here?

>> +	if (ret)
>> +		dev_err(ec_dev->dev, "failed to add EC RTC\n");
>> +}
>> +
>>  int cros_ec_register(struct cros_ec_device *ec_dev)
>>  {
>>  	struct device *dev = ec_dev->dev;
>> @@ -287,6 +301,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>  	if (cros_ec_check_features(ec_dev, EC_FEATURE_MOTION_SENSE))
>>  		cros_ec_sensors_register(ec_dev);
>>  
>> +	/* Check whether this EC has RTC support */
>> +	if (cros_ec_check_features(ec_dev, EC_FEATURE_RTC))
>> +		cros_ec_rtc_register(ec_dev);
>> +
>>  	if (ec_dev->max_passthru) {
>>  		/*
>>  		 * Register a PD device as well on top of this device.
> 
