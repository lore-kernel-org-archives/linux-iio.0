Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <11465aef98dbd52476a33c69e1cfb5ef@mail.gmail.com> <5001343D.5080302@kernel.org> <5001494F.2020207@kernel.org> <fc06c8a11ad2e9e9ce765635690d17f8@mail.gmail.com>
In-Reply-To: <fc06c8a11ad2e9e9ce765635690d17f8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: Invensense MPU6050/9150/6500 driver submission(resubmitted)
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 17 Jul 2012 07:18:42 +0100
To: Ge Gao <ggao@invensense.com>,Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Message-ID: <9114e834-011e-47dc-9c00-0998f2209ecd@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Ge Gao <ggao@invensense.com> wrote:

>   RE: Invensense MPU6050/9150/6500 driver submission(resubmitted)
>
>Dear Jonathan,
>
>   Thanks for your comments. I have fixed the code according to them. T
>he code is reduced more than 40%.  However, there are some comments
>that I
>don't understand. It is listed as below in red.
>
>Ge
>
>-----Original Message-----
>From: Jonathan Cameron [mailto:jic23@kernel.org <jic23@kernel.org>]
>Sent: Saturday, July 14, 2012 3:26 AM
>To: Ge Gao
>Cc: linux-iio@vger.kernel.org
>Subject: Re: Invensense MPU6050/9150/6500 driver
>submission(resubmitted)
>
>> +     &iio_dev_attr_gyro_enable.dev_attr.attr,
>
>> +     &dev_attr_temperature.attr,
>
>> +     &iio_dev_attr_clock_source.dev_attr.attr,
>
>> +     &iio_dev_attr_power_state.dev_attr.attr,
>
>> +     &dev_attr_reg_dump.attr,
>
>> +     &iio_dev_attr_self_test.dev_attr.attr,
>
>> +     &iio_dev_attr_key.dev_attr.attr,
>
>> +     &iio_dev_attr_gyro_matrix.dev_attr.attr,
>
>> +     &iio_dev_attr_sampling_frequency.dev_attr.attr,
>
>> +     &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>
>> +};
>
>> +
>
>> +static const struct attribute *inv_mpu6050_attributes[] = {
>
>> +     &iio_dev_attr_accl_enable.dev_attr.attr,
>
>> +     &iio_dev_attr_accl_matrix.dev_attr.attr,
>
>> +     &iio_dev_attr_lpa_mode.dev_attr.attr,
>
>> +     &iio_dev_attr_lpa_freq.dev_attr.attr,
>
>> +};
>
>> +
>
>> +static const struct attribute *inv_compass_attributes[] = {
>
>> +     &iio_dev_attr_compass_matrix.dev_attr.attr,
>
>> +     &iio_dev_attr_compass_enable.dev_attr.attr,
>
>> +};
>
>> +
>
>> +static struct attribute
>*inv_attributes[ARRAY_SIZE(inv_gyro_attributes) +
>
>> +                             ARRAY_SIZE(inv_mpu6050_attributes) +
>
>> +                             ARRAY_SIZE(inv_compass_attributes) +
>1];
>
>Don't do this. You have just limited yourself to only have one device
>
>attached
>
>to a given machine.  Please just have the relevant combinations
>statically
>
>defined.
>
>Ge: why is that? Inv_attributes is also a static variable. Its value
>can
>change according to different chip type. In the end, it is the same as
>some
>hard-coded attributes. For multiple devices in one machine, isn’t that
>each
>device has one separate directory “iio_deviceX” with private attributes
>in
>each directory?
>
Sorry, you are correct that this is fine.  I would prefer picking from a set of static arrays but what you have will work.
>> +
>
>> +static const struct attribute_group inv_attribute_group = {
>
>Why are these in there own group? Should be in the base group.
>
>Ge: What is “base” group? Isn’t this the standard way of doing it?.
No name.  Hence attributes would end up in iio:deviceX directory rather than one called mountain. This probably gets ignored anyway but lose the name for consistency.
>
>> +     .name = "mpu",
>
>> +     .attrs = inv_attributes
>
>> +};
>
>> +
>
>> +static const struct iio_info mpu_info = {
>
>> +     .driver_module = THIS_MODULE,
>
>> +     .read_raw = &mpu_read_raw,
>
>> +     .write_raw = &mpu_write_raw,
>
>> +     .attrs = &inv_attribute_group,
>
>> +};
>
>> +
>
>> +/**
>
>> + *  inv_setup_compass() - Configure compass.
>
>> + */
>
>This next bit is a very bad idea for the reasons stated above.
>
>You've ended up with more complex code and reduced flexibility.
>
>There will be people who will attach several of your devices
>
>to one machine, so please cater for them (it's the sort of thing
>
>I'd do for starters ;)
>
>Ge: Like I said, what the difference between the hardcoded attribute
>and the
>flexibly changeable ones. What would the IIO core do when multiple
>devices
>are connected to one machine in my case?
I missunderstood what you have done first time.  I guess dynamic building of that array might make sense once you have lots of sub devices...
>
>Thanks.
>
>> +     t_ind = 0;
>
>> +     memcpy(&inv_attributes[t_ind], inv_gyro_attributes,
>
>> +             sizeof(inv_gyro_attributes));
>
>> +     t_ind += ARRAY_SIZE(inv_gyro_attributes);
>
>> +
>
>> +     memcpy(&inv_attributes[t_ind], inv_mpu6050_attributes,
>
>> +                    sizeof(inv_mpu6050_attributes));
>
>> +     t_ind += ARRAY_SIZE(inv_mpu6050_attributes);
>
>> +
>
>> +     if (st->chip_config.has_compass) {
>
>> +             memcpy(&inv_attributes[t_ind], inv_compass_attributes,
>
>> +                    sizeof(inv_compass_attributes));
>
>> +             t_ind += ARRAY_SIZE(inv_compass_attributes);
>
>> +     }
>
>> +     inv_attributes[t_ind] = NULL;
>
>> +
>
>> +     st->secondary_client = *client;
>
>really? That's 'interesting'... the secondary client is the same as
>
>the primary one (up to a dereference).
>
>> +MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
>
>> +
>
>> +static struct i2c_driver inv_mpu_driver = {
>
>> +     .class = I2C_CLASS_HWMON,
>
>really? hwmon driver?
>
>Ge: Is there any other possibility? I can’t see other I2C classes.
None.  Don't specify one.
>
>> +     .probe          =       inv_mpu_probe,

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
