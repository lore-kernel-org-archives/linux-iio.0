Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:56672 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab0GAJpU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2010 05:45:20 -0400
Message-ID: <4C2C642B.8080702@cam.ac.uk>
Date: Thu, 01 Jul 2010 10:47:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"sfking@fdwdc.com" <sfking@fdwdc.com>
Subject: Re: [RFC][PATCH]add Honeywell hmc5843 3-Axis Magnetometer (digital
 compass) driver.
References: <0680EC522D0CC943BC586913CF3768C003B3553F73@dbde02.ent.ti.com> <0680EC522D0CC943BC586913CF3768C003B3602F54@dbde02.ent.ti.com> <4C2BA065.8040903@cam.ac.uk> <0680EC522D0CC943BC586913CF3768C003B360303F@dbde02.ent.ti.com>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B360303F@dbde02.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/10 07:40, Datta, Shubhrajyoti wrote:
> 
> nitpick: move comment up to above the function.
>> +       /* Return the measurement value from the  specified channel */
>> +       struct i2c_client *client = to_i2c_client(dev);
>> +       s16 coordinate_val;
>> +       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +       s32 result;
> nitpick: New line after defs and before code.
>> +       result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
>> +       while (!(result & DATA_READY))
>> +               result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
>> +
>> +       result = i2c_smbus_read_word_data(client, this_attr->address);
>> +       if (result > 0) {
>  as coordinate_val is an s16 which not type cast to that?
>> +               coordinate_val  = (int)swab16((u16)result);
> curious line break below...
>> +               return sprintf(buf, "%d\n",
>> +                               coordinate_val);
> So, this is a raw value? (e.g. it will need scaling in userspace)
> 
> 
> Would you prefer to convert in SI units and then report?
That depends on whether it is a linear conversion.  If it is
linear the you can provide additional attributes to allow
userspace to rescale it.  Either option is fine here.
Call it _input if in SI units or _raw if it is a value that needs
conversion.  

Jonathan
> 
>> +       }
>> +       return result;
>> +}
> 
> 

