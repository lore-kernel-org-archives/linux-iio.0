Return-Path: <matthias.bgg9ab33xy531gmail.com@bounce.antispameurope.com>
Message-ID: <4CBDD1FA.1090103@gmail.com>
Date: Tue, 19 Oct 2010 19:14:34 +0200
From: Matthias Brugger <matthias.bgg@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, matthias <mensch0815@googlemail.com>,
        shubhrajyoti@ti.com
Subject: Re: [PATCH] iio - add barometer bmp085
References: <4CB81BF0.1080802@gmail.com> <4CB82AFD.3040401@cam.ac.uk>
In-Reply-To: <4CB82AFD.3040401@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

some comments on your comments below.
Afterwards I'll send the patch.

Jonathan Cameron schrieb:
> On 10/15/10 10:16, Matthias Brugger wrote:
>> This patch adds:
>> - digital barometer support to the iio subsytem
>> - Bosch Sensortec bmp085 driver
>>
>> I resend the patches I sent yesterday, because I merged them to one.
>> Also the comments and the define has been deleted and so, from my point of view is ready to merge.
> One quick comment about patch submissions in general. When it's an updated
> version of a previously posted patch, the title should be something like
> [PATCH V2] iio - add barometer bmp085.  Makes it easy down the line to make
> sure you have the right patch!.
> 
> To sumarise the important inline comments:
> 
> As a general rule, if you know the size of the storage of a give value
> (because it is comming from hardware) it is better to use fixed sized
> types.  u16 and friends.  It's way too unpredictable how large a long or
> a short might be.

not quite sure if I changed it everywhere. Would you mind
double-check it once again?

>> +/* Barometer types of attribute */
>> +
>> +#define IIO_DEV_ATTR_BARO_PRESSURE(_mode, _show, _store, _addr)	\
>> +	IIO_DEVICE_ATTR(baro_pressure, _mode, _show, NULL, _addr)
> If it's processed (i.e. si units) it needs to be baro_pressure_input.
> If raw it needs to be baro_pressure_raw and conversion factors etc provided.

It is in pascal, so I assume it's ok to use the _input suffix.

>> +#include "bmp085.h"
>> +
>> +int oss = 3;
>> +module_param(oss, int , S_IRUSR);
>> +MODULE_PARM_DESC(oss, "Oversampling setting [0-3]");
> Not convinced this should be a module parameter.  Better to use a combination
> of board config (for default on a given board) and appropriate sysfs attribute
> to allow it to be changed.  Still, fine for initial merge, we can change this
> later.
Well maybe this needs another iteration, because oss means
oversampling_setting which describes the sampling methode of the
hardware (ultra low power, standard, high resolution, ultra high
resolution). The conversion time depends on this. So maybe we should
provide this information through strings instead of the oss number.

>> +	up = (((unsigned long) ret1 << 16) | ((unsigned long) ret2 << 8)
>> +				| (unsigned long) xlsb) >> (8 - data->oss);
>> +	data->up = up;
>> +
>> +	pressure = bmp085_calc_pressure(client, up);
> Why cache the pressure?
>> +	data->pressure = pressure;
It's not necessary here but later on we might put it in a
ring_buffer or something. For now we can delete it from the source
and header files.


>> + * In standard mode, the temperature has to be reat every second before the
>> + * pressure can be reat. We leave this semantics to the userspace, if later
> past tense of read is infact read not reat.
>> + * on a trigger based reading will be implemented, this should be taken into
>> + * account.
> Ouch, that's an uggly requirement.
Maybe we should read the temperature everytime before reading the
pressure, or we should put a trigger as Shubhrajyoti proposed.
(Sorry I have not had a look on your driver...).

>> + */
>> +static ssize_t barometer_show_pressure(struct device *dev,
>> +		struct device_attribute *da, char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct bmp085_data *data = indio_dev->dev_data;
>> +	struct i2c_client *client = data->client;
>> +	long status;
>> +
>> +	status = bmp085_read_pressure(client);
>> +	if (status < 0)
>> +		dev_warn(&client->dev, "error reading pressure: %ld\n", status);
>> +
> Why cache the preesure?
See above.
>> +	data->pressure = status;
>> +
>> +	return sprintf(buf, "%ld\n", data->pressure);
>> +}

>> +	if (mutex_is_locked(&data->bmp085_lock))
>> +		mutex_unlock(&data->bmp085_lock);
> Something weird is occuring if you can get here without the lock
> being unlocked.
That's true for now, but if you use triggers, it might be different,
 right? Anyway for now I deleted the lines.

>> +	long temp;
> Why long?  Looking at the code this always looks to be
> 16 bit to me, so s16 would be more appropraite.
As I mentioned beforehand, for now we can delete this anyway. We
just have to think about the shorts in the code...
> 
>> +	long pressure;
>> +

Regards,
Matthias
