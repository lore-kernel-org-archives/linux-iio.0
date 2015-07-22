Return-Path: <knaack.h@gmx.de>
Message-ID: <55B00AF3.4020609@gmx.de>
Date: Wed, 22 Jul 2015 23:28:19 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "Dogaru, Vlad" <vlad.dogaru@intel.com>
Subject: Re: [PATCH 6/8] iio:magnetometer:bmc150_magn: protect
 runtime_resume with mutex
References: <cover.1437090791.git.knaack.h@gmx.de> <d6c36de684250b41333124b476b0d29bab00b22a.1437090791.git.knaack.h@gmx.de> <1F3AC3675D538145B1661F571FE1805F2F06BBA6@irsmsx105.ger.corp.intel.com>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F06BBA6@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Tirdea, Irina schrieb am 20.07.2015 um 19:45:
> 
> 
>> -----Original Message-----
>> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
>> Sent: 17 July, 2015 11:52
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Tirdea, Irina; Dogaru, Vlad
>> Subject: [PATCH 6/8] iio:magnetometer:bmc150_magn: protect runtime_resume with mutex
>>
>> Protect bmc150_magn_runtime_resume() with a mutex, as done with other
>> suspend/resume functions.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>> ---
>>  drivers/iio/magnetometer/bmc150_magn.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
>> index e1f804b2b244..ac0cdbde813b 100644
>> --- a/drivers/iio/magnetometer/bmc150_magn.c
>> +++ b/drivers/iio/magnetometer/bmc150_magn.c
>> @@ -1052,9 +1052,14 @@ static int bmc150_magn_runtime_resume(struct device *dev)
>>  {
>>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
>> +	int ret;
>>
>> -	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
>> -					  true);
>> +	mutex_lock(&data->mutex);
>> +	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
>> +					 true);
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
> 
> This function does not have mutex_lock/unlock because it is called with data->mutex locked.
> I should have added a comment to specify this.
> 
> Whenever we wake up the device, bmc150_magn_set_power_state is called after locking
> data->mutex. This in turn calls pm_runtime_get_sync which will immediately call
> bmc150_magn_runtime_resume. Trying to lock the mutex here would lead to a deadlock
> (e.g. when trying to read a value through sysfs _raw).
> 
> Since this driver uses autosuspend delay, the situation is different for runtime suspend since
> that is called after 2 seconds in a separate thread. This is why there is a mutex locked in runtime
> suspend but not in runtime resume.
> 

Yes, please add such a comment. As for me, it seems I have to dig a bit
deeper into power management magic - maybe another day ;-)
Thanks,

Hartmut

>>  }
>>  #endif
>>
>> --
>> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
