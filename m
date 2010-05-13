Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:48269 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758509Ab0EMKQx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2010 06:16:53 -0400
Message-ID: <4BEBD1EB.8050206@cam.ac.uk>
Date: Thu, 13 May 2010 11:18:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging:iio: adis16220 extract bin_attribute 	structures
 from state
References: <1273697625-9685-1-git-send-email-jic23@cam.ac.uk> 	<1273697625-9685-3-git-send-email-jic23@cam.ac.uk> <AANLkTikFuJnf5AVZHQfEyXmSgE-AGLCD1gpTi4H9WrKc@mail.gmail.com>
In-Reply-To: <AANLkTikFuJnf5AVZHQfEyXmSgE-AGLCD1gpTi4H9WrKc@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/13/10 04:06, Barry Song wrote:
> On Thu, May 13, 2010 at 4:53 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/staging/iio/accel/adis16220.h      |    3 -
>>  drivers/staging/iio/accel/adis16220_core.c |  106 +++++++++++++++-------------
>>  2 files changed, 56 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/staging/iio/accel/adis16220.h b/drivers/staging/iio/accel/adis16220.h
>> index 6b49f70..2abf485 100644
>> --- a/drivers/staging/iio/accel/adis16220.h
>> +++ b/drivers/staging/iio/accel/adis16220.h
>> @@ -141,9 +141,6 @@ struct adis16220_state {
>>        struct iio_dev                  *indio_dev;
>>        u8                              *tx;
>>        u8                              *rx;
>> -       struct bin_attribute            accel_bin;
>> -       struct bin_attribute            adc1_bin;
>> -       struct bin_attribute            adc2_bin;
>>        struct mutex                    buf_lock;
>>  };
>>
>> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
>> index 8b845d9..e60de4a 100644
>> --- a/drivers/staging/iio/accel/adis16220_core.c
>> +++ b/drivers/staging/iio/accel/adis16220_core.c
>> @@ -27,8 +27,6 @@
>>
>>  #define DRIVER_NAME            "adis16220"
>>
>> -static int adis16220_check_status(struct device *dev);
>> -
>>  /**
>>  * adis16220_spi_write_reg_8() - write single byte to a register
>>  * @dev: device associated with child of actual device (iio_dev or iio_trig)
>> @@ -133,8 +131,6 @@ static int adis16220_spi_read_reg_16(struct device *dev,
>>        mutex_lock(&st->buf_lock);
>>        st->tx[0] = ADIS16220_READ_REG(lower_reg_address);
>>        st->tx[1] = 0;
>> -       st->tx[2] = 0;
>> -       st->tx[3] = 0;
>>
>>        spi_message_init(&msg);
>>        spi_message_add_tail(&xfers[0], &msg);
>> @@ -275,23 +271,6 @@ static ssize_t adis16220_write_capture(struct device *dev,
>>        return -1;
>>  }
>>
>> -static int adis16220_self_test(struct device *dev)
>> -{
>> -       int ret;
>> -       ret = adis16220_spi_write_reg_16(dev,
>> -                       ADIS16220_MSC_CTRL,
>> -                       ADIS16220_MSC_CTRL_SELF_TEST_EN);
>> -       if (ret) {
>> -               dev_err(dev, "problem starting self test");
>> -               goto err_ret;
>> -       }
>> -
>> -       adis16220_check_status(dev);
>> -
>> -err_ret:
>> -       return ret;
>> -}
>> -
>>  static int adis16220_check_status(struct device *dev)
>>  {
>>        u16 status;
>> @@ -320,6 +299,23 @@ error_ret:
>>        return ret;
>>  }
>>
>> +static int adis16220_self_test(struct device *dev)
>> +{
>> +       int ret;
>> +       ret = adis16220_spi_write_reg_16(dev,
>> +                       ADIS16220_MSC_CTRL,
>> +                       ADIS16220_MSC_CTRL_SELF_TEST_EN);
>> +       if (ret) {
>> +               dev_err(dev, "problem starting self test");
>> +               goto err_ret;
>> +       }
>> +
>> +       adis16220_check_status(dev);
>> +
>> +err_ret:
>> +       return ret;
>> +}
>> +
>>  static int adis16220_initial_setup(struct adis16220_state *st)
>>  {
>>        int ret;
>> @@ -433,6 +429,15 @@ static ssize_t adis16220_accel_bin_read(struct kobject *kobj,
>>                                        ADIS16220_CAPT_BUFA);
>>  }
>>
>> +static struct bin_attribute accel_bin = {
>> +       .attr = {
>> +               .name = "accel_bin",
>> +               .mode = S_IRUSR,
> Here i can't understand why read permission is only given to
> user(probably root). Why not S_IRUGO which means
> (S_IRUSR|S_IRGRP|S_IROTH) ?
Good spot. That's what I get for lifting code from another
driver without thinking about it.
> 
>> +       },
>> +       .read = adis16220_accel_bin_read,
>> +       .size = ADIS16220_CAPTURE_SIZE,
>> +};
>> +
>>  static ssize_t adis16220_adc1_bin_read(struct kobject *kobj,
>>                                struct bin_attribute *attr,
>>                                char *buf, loff_t off,
>> @@ -447,6 +452,15 @@ static ssize_t adis16220_adc1_bin_read(struct kobject *kobj,
>>                                        ADIS16220_CAPT_BUF1);
>>  }
>>
>> +static struct bin_attribute adc1_bin = {
>> +       .attr = {
>> +               .name = "in0_bin",
>> +               .mode = S_IRUSR,
>> +       },
>> +       .read =  adis16220_adc1_bin_read,
>> +       .size = ADIS16220_CAPTURE_SIZE,
>> +};
>> +
>>  static ssize_t adis16220_adc2_bin_read(struct kobject *kobj,
>>                                struct bin_attribute *attr,
>>                                char *buf, loff_t off,
>> @@ -461,6 +475,16 @@ static ssize_t adis16220_adc2_bin_read(struct kobject *kobj,
>>                                        ADIS16220_CAPT_BUF2);
>>  }
>>
>> +
>> +static struct bin_attribute adc2_bin = {
>> +       .attr = {
>> +               .name = "in1_bin",
>> +               .mode = S_IRUSR,
>> +       },
>> +       .read =  adis16220_adc2_bin_read,
>> +       .size = ADIS16220_CAPTURE_SIZE,
>> +};
>> +
>>  static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16220_read_12bit_unsigned,
>>                ADIS16220_CAPT_SUPPLY);
>>  static IIO_CONST_ATTR(in_supply_scale, "0.0012207");
>> @@ -481,12 +505,12 @@ static IIO_DEV_ATTR_IN_RAW(1, adis16220_read_16bit, ADIS16220_CAPT_BUF2);
>>  static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL,
>>                adis16220_write_reset, 0);
>>
>> -#define IIO_DEV_ATTR_CAPTURE(_store)                   \
>> +#define IIO_DEV_ATTR_CAPTURE(_store)                           \
>>        IIO_DEVICE_ATTR(capture, S_IWUGO, NULL, _store, 0)
>>
>>  static IIO_DEV_ATTR_CAPTURE(adis16220_write_capture);
>>
>> -#define IIO_DEV_ATTR_CAPTURE_COUNT(_mode, _show, _store, _addr)        \
>> +#define IIO_DEV_ATTR_CAPTURE_COUNT(_mode, _show, _store, _addr)                \
>>        IIO_DEVICE_ATTR(capture_count, _mode, _show, _store, _addr)
>>
>>  static IIO_DEV_ATTR_CAPTURE_COUNT(S_IWUSR | S_IRUGO,
>> @@ -563,33 +587,15 @@ static int __devinit adis16220_probe(struct spi_device *spi)
>>                goto error_free_dev;
>>        regdone = 1;
>>
>> -       st->accel_bin.attr.name = "accel_bin";
>> -       st->accel_bin.attr.mode = S_IRUGO;
>> -       st->accel_bin.attr.owner = THIS_MODULE;
>> -       st->accel_bin.read = adis16220_accel_bin_read;
>> -       st->accel_bin.size = ADIS16220_CAPTURE_SIZE;
>> -
>> -       ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &st->accel_bin);
>> +       ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &accel_bin);
>>        if (ret)
>>                goto error_free_dev;
>>
>> -       st->adc1_bin.attr.name = "adc1_bin";
>> -       st->adc1_bin.attr.mode = S_IRUGO;
>> -       st->adc1_bin.attr.owner = THIS_MODULE;
>> -       st->adc1_bin.read = adis16220_adc1_bin_read;
>> -       st->adc1_bin.size = ADIS16220_CAPTURE_SIZE;
>> -
>> -       ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &st->adc1_bin);
>> +       ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &adc1_bin);
>>        if (ret)
>>                goto error_rm_accel_bin;
>>
>> -       st->adc2_bin.attr.name = "adc2_bin";
>> -       st->adc2_bin.attr.mode = S_IRUGO;
>> -       st->adc2_bin.attr.owner = THIS_MODULE;
>> -       st->adc2_bin.read = adis16220_adc2_bin_read;
>> -       st->adc2_bin.size = ADIS16220_CAPTURE_SIZE;
>> -
>> -       ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &st->adc2_bin);
>> +       ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &adc2_bin);
>>        if (ret)
>>                goto error_rm_adc1_bin;
>>
>> @@ -600,11 +606,11 @@ static int __devinit adis16220_probe(struct spi_device *spi)
>>        return 0;
>>
>>  error_rm_adc2_bin:
>> -       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->adc2_bin);
>> +       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &adc2_bin);
>>  error_rm_adc1_bin:
>> -       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->adc1_bin);
>> +       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &adc1_bin);
>>  error_rm_accel_bin:
>> -       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->accel_bin);
>> +       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &accel_bin);
>>  error_free_dev:
>>        if (regdone)
>>                iio_device_unregister(st->indio_dev);
>> @@ -627,9 +633,9 @@ static int adis16220_remove(struct spi_device *spi)
>>
>>        flush_scheduled_work();
>>
>> -       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->adc2_bin);
>> -       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->adc1_bin);
>> -       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &st->accel_bin);
>> +       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &adc2_bin);
>> +       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &adc1_bin);
>> +       sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &accel_bin);
>>        iio_device_unregister(indio_dev);
>>        kfree(st->tx);
>>        kfree(st->rx);
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

