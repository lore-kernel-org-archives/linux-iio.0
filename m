Return-Path: <shubhrajyoti@ti.com>
From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "sfking@fdwdc.com" <sfking@fdwdc.com>
Date: Thu, 1 Jul 2010 12:10:28 +0530
Subject: RE: [RFC][PATCH]add Honeywell hmc5843 3-Axis Magnetometer (digital
 compass) driver.
Message-ID: <0680EC522D0CC943BC586913CF3768C003B360303F@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C003B3553F73@dbde02.ent.ti.com>
 <0680EC522D0CC943BC586913CF3768C003B3602F54@dbde02.ent.ti.com>
 <4C2BA065.8040903@cam.ac.uk>
In-Reply-To: <4C2BA065.8040903@cam.ac.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


nitpick: move comment up to above the function.
> +       /* Return the measurement value from the  specified channel */
> +       struct i2c_client *client =3D to_i2c_client(dev);
> +       s16 coordinate_val;
> +       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> +       s32 result;
nitpick: New line after defs and before code.
> +       result =3D i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
> +       while (!(result & DATA_READY))
> +               result =3D i2c_smbus_read_byte_data(client, HMC5843_STATU=
S_REG);
> +
> +       result =3D i2c_smbus_read_word_data(client, this_attr->address);
> +       if (result > 0) {
 as coordinate_val is an s16 which not type cast to that?
> +               coordinate_val  =3D (int)swab16((u16)result);
curious line break below...
> +               return sprintf(buf, "%d\n",
> +                               coordinate_val);
So, this is a raw value? (e.g. it will need scaling in userspace)


Would you prefer to convert in SI units and then report?

> +       }
> +       return result;
> +}
