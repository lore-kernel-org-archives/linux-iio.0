Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47496 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbbHOOu6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 10:50:58 -0400
Subject: Re: [PATCH v3 3/6] iio: bmg160: Use generic dev_drvdata
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Markus Pargmann <mpa@pengutronix.de>
References: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
 <1439391009-6051-4-git-send-email-mpa@pengutronix.de>
 <1439395504.2244.36.camel@spandruv-desk3.jf.intel.com>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF51D1.3090506@kernel.org>
Date: Sat, 15 Aug 2015 15:50:57 +0100
MIME-Version: 1.0
In-Reply-To: <1439395504.2244.36.camel@spandruv-desk3.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/15 17:05, Srinivas Pandruvada wrote:
> On Wed, 2015-08-12 at 16:50 +0200, Markus Pargmann wrote:
>> i2c_get_clientdata() is specifically for i2c. Replace it with the
>> generic dev_get/set_drvdata() to support different protocols.
>>
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied.
>> ---
>>  drivers/iio/gyro/bmg160.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
>> index 4701ea17baea..6eab91ba8977 100644
>> --- a/drivers/iio/gyro/bmg160.c
>> +++ b/drivers/iio/gyro/bmg160.c
>> @@ -1020,7 +1020,7 @@ static int bmg160_probe(struct i2c_client *client,
>>  		return -ENOMEM;
>>  
>>  	data = iio_priv(indio_dev);
>> -	i2c_set_clientdata(client, indio_dev);
>> +	dev_set_drvdata(&client->dev, indio_dev);
>>  	data->dev = &client->dev;
>>  
>>  	ret = bmg160_chip_init(data);
>> @@ -1154,7 +1154,7 @@ static int bmg160_remove(struct i2c_client *client)
>>  #ifdef CONFIG_PM_SLEEP
>>  static int bmg160_suspend(struct device *dev)
>>  {
>> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>  	struct bmg160_data *data = iio_priv(indio_dev);
>>  
>>  	mutex_lock(&data->mutex);
>> @@ -1166,7 +1166,7 @@ static int bmg160_suspend(struct device *dev)
>>  
>>  static int bmg160_resume(struct device *dev)
>>  {
>> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>  	struct bmg160_data *data = iio_priv(indio_dev);
>>  
>>  	mutex_lock(&data->mutex);
>> @@ -1182,7 +1182,7 @@ static int bmg160_resume(struct device *dev)
>>  #ifdef CONFIG_PM
>>  static int bmg160_runtime_suspend(struct device *dev)
>>  {
>> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>  	struct bmg160_data *data = iio_priv(indio_dev);
>>  	int ret;
>>  
>> @@ -1197,7 +1197,7 @@ static int bmg160_runtime_suspend(struct device *dev)
>>  
>>  static int bmg160_runtime_resume(struct device *dev)
>>  {
>> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>  	struct bmg160_data *data = iio_priv(indio_dev);
>>  	int ret;
>>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

