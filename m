Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1459947832-23004-1-git-send-email-linus.walleij@linaro.org>
References: <1459947832-23004-1-git-send-email-linus.walleij@linaro.org>
Date: Wed, 6 Apr 2016 15:32:12 +0200
Message-ID: <CAPDyKFp+Ok2WBnRnwbHVLiV7K2kpsDqzjcEUWrL1JFa0vxxQHQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: light: new driver for the ROHM BH1780
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@caiaq.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

[...]

> +
> +static int bh1780_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)
> +{
> +       int ret;
> +       struct bh1780_data *bh1780;
> +       struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +       struct iio_dev *indio_dev;
> +
> +       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> +               return -EIO;
> +
> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*bh1780));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       bh1780 = iio_priv(indio_dev);
> +       bh1780->client = client;
> +       i2c_set_clientdata(client, bh1780);
> +
> +       /* Power up the device */
> +       ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_PON);
> +       if (ret < 0)
> +               return ret;
> +       msleep(BH1780_PON_DELAY);
> +       pm_runtime_get_noresume(&client->dev);
> +       pm_runtime_set_active(&client->dev);
> +       pm_runtime_enable(&client->dev);
> +
> +       ret = bh1780_read(bh1780, BH1780_REG_PARTID);
> +       if (ret < 0)
> +               goto out_disable_pm;
> +       dev_info(&client->dev,
> +                "Ambient Light Sensor, Rev : %lu\n",
> +                (ret & BH1780_REVMASK));
> +
> +       /*
> +        * As the device takes 250 ms to even come up with a fresh
> +        * measurement after power-on, do not shut it down unnecessarily.
> +        * Set autosuspend to a five seconds.
> +        */
> +       pm_runtime_set_autosuspend_delay(&client->dev, 5000);

I assume the parent device is the i2c controller for the sensor device!?

In the ux500 case, this i2c controller device resides in the VAPE PM
domain, thus when you keep the sensor device runtime resumed, it means
the VAPE PM domain will stay active.

Therefore, I am a bit concerned about the 5 s autosuspend delay here.
Do you have an idea of how a regular use case would be for the sensor?
In other words, at what frequency would you expect a new sensor value
to be read?

Moreover, what are the resume latency requirement of reading a new
sensor value? Is it a problem to have a 250 ms latency for each new
value?

> +       pm_runtime_use_autosuspend(&client->dev);
> +       pm_runtime_put(&client->dev);
> +
> +       indio_dev->dev.parent = &client->dev;
> +       indio_dev->info = &bh1780_info;
> +       indio_dev->name = id->name;
> +       indio_dev->channels = bh1780_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(bh1780_channels);
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       ret = iio_device_register(indio_dev);
> +       if (ret)
> +               goto out_disable_pm;
> +       return 0;
> +
> +out_disable_pm:
> +       pm_runtime_put_noidle(&client->dev);
> +       pm_runtime_disable(&client->dev);
> +       return ret;
> +}
> +
> +static int bh1780_remove(struct i2c_client *client)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +       iio_device_unregister(indio_dev);
> +       pm_runtime_get_sync(&client->dev);

I believe you want to power off as well:

bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_POFF);

> +       pm_runtime_put_noidle(&client->dev);
> +       pm_runtime_disable(&client->dev);
> +
> +       return 0;
> +}
> +

Otherwise this looks great!

Kind regards
Uffe
