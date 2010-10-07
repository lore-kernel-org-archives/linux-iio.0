Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:20608 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760563Ab0JGNlZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2010 09:41:25 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "greg@kroah.com" <greg@kroah.com>, Drivers <Drivers@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 7 Oct 2010 14:41:19 +0100
Subject: RE: [PATCH] staging: iio: adc: ad799x drop in_precision in favor of
 new in_type
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712F35A10061@LIMKCMBX1.ad.analog.com>
References: <1286456337-19789-1-git-send-email-michael.hennerich@analog.com>
 <4CADCA0D.3010202@cam.ac.uk>
In-Reply-To: <4CADCA0D.3010202@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2010-10-07:
> On 10/07/10 13:58, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> drop in_precision in favor of new in_type add sign and storagebits
>> to struct ad799x_chip_info properly mask the results based on
>> ad799x_chip_info:bits
> This also fixes the bug from the scan elements move (as a side effect).
> Normally I'd say that needed flagging up but seeing how short a time
> the driver has been in place, the chances of it having bitten anyone
> are pretty low!  Still if you re roll the patch it is probably worth
> adding a mention.
>
> Couple of minor queries below.
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/adc/ad799x.h      |    4 ++-
>>  drivers/staging/iio/adc/ad799x_core.c |   42
>>  +++++++++++++++++++++++--------- drivers/staging/iio/adc/ad799x_ring.c
>>  |    2 +- 3 files changed, 34 insertions(+), 14 deletions(-)
>> diff --git a/drivers/staging/iio/adc/ad799x.h
>> b/drivers/staging/iio/adc/ad799x.h
>> index 2325929..f023212 100644
>> --- a/drivers/staging/iio/adc/ad799x.h
>> +++ b/drivers/staging/iio/adc/ad799x.h
>> @@ -97,7 +97,9 @@ struct ad799x_state;  struct ad799x_chip_info {
>>      u8                              num_inputs;
>>      u8                              bits;
>> -    u16                             int_vref_mv;
>> +    u8                              storagebits;
>> +    char                            sign;
>> +    unsigned int                    int_vref_mv;
> Why the type change?  If it is needed, please submit as as separate
> patch as it definitely isn't conceptually linked to the rest we have
> here.

Not actually needed - I revert.

>>      bool                            monitor_mode;
>>      u16                             default_config;
>>      struct attribute_group          *dev_attrs;
>> diff --git a/drivers/staging/iio/adc/ad799x_core.c
>> b/drivers/staging/iio/adc/ad799x_core.c
>> index 2589856..a804515 100644
>> --- a/drivers/staging/iio/adc/ad799x_core.c
>> +++ b/drivers/staging/iio/adc/ad799x_core.c
>> @@ -123,17 +123,18 @@ static AD799X_SCAN_EL(5);  static
>> AD799X_SCAN_EL(6);  static AD799X_SCAN_EL(7);
>>
>> -static ssize_t ad799x_show_precision(struct device *dev,
>> +static ssize_t ad799x_show_type(struct device *dev,
>>                              struct device_attribute *attr,
>>                              char *buf)
>>  {
>> -    struct iio_dev *dev_info = dev_get_drvdata(dev);
>> -    struct ad799x_state *st = iio_dev_get_devdata(dev_info);
>> -    return sprintf(buf, "%d\n", st->chip_info->bits);
>> -}
>> +    struct iio_ring_buffer *ring = dev_get_drvdata(dev);
>> +    struct iio_dev *indio_dev = ring->indio_dev;
>> +    struct ad799x_state *st = indio_dev->dev_data;
>>
>> -static IIO_DEVICE_ATTR(in_precision, S_IRUGO, ad799x_show_precision,
>> -                   NULL, 0); +      return sprintf(buf, "%c%d/%d\n",
>> st->chip_info->sign, +                      st->chip_info->bits,
>> st->chip_info->storagebits); } static +IIO_DEVICE_ATTR(in_type,
>> S_IRUGO, ad799x_show_type, NULL, 0);
>>
>>  static int ad7991_5_9_set_scan_mode(struct ad799x_state *st,
> unsigned
>> mask)  { @@ -185,6 +186,7 @@ static ssize_t
>> ad799x_read_single_channel(struct device *dev,
>>              data = ret = ad799x_single_channel_from_ring(st, mask);
>>              if (ret < 0)
>>                      goto error_ret;
>> +
> Why the new line?

Got there by accident

>>              ret = 0;
>>      } else {
>>              switch (st->id) {
>> @@ -211,11 +213,11 @@ static ssize_t
> ad799x_read_single_channel(struct device *dev,
>>              if (ret < 0)
>>                      goto error_ret;
>> -            data = rxbuf[0] & 0xFFF;
>> +            data = rxbuf[0];
>>      }
>>
>>      /* Pretty print the result */
>> -    len = sprintf(buf, "%u\n", data);
>> +    len = sprintf(buf, "%u\n", data & ((1 << (st->chip_info->bits)) -
>> +1));
>>
>>  error_ret:
>>      mutex_unlock(&dev_info->mlock);
>> @@ -473,7 +475,7 @@ static struct attribute
> *ad7991_5_9_3_4_scan_el_attrs[] = {
>>      &iio_const_attr_in2_index.dev_attr.attr,
>>      &iio_scan_el_in3.dev_attr.attr,
>>      &iio_const_attr_in3_index.dev_attr.attr,
>> -    &iio_dev_attr_in_precision.dev_attr.attr,
>> +    &iio_dev_attr_in_type.dev_attr.attr,
>>      NULL,
>>  };
>> @@ -499,7 +501,7 @@ static struct attribute *ad7992_scan_el_attrs[]
>> =
> {
>>      &iio_const_attr_in0_index.dev_attr.attr,
>>      &iio_scan_el_in1.dev_attr.attr,
>>      &iio_const_attr_in1_index.dev_attr.attr,
>> -    &iio_dev_attr_in_precision.dev_attr.attr,
>> +    &iio_dev_attr_in_type.dev_attr.attr,
>>      NULL,
>>  };
>> @@ -543,7 +545,7 @@ static struct attribute
>> *ad7997_8_scan_el_attrs[]
> = {
>>      &iio_const_attr_in6_index.dev_attr.attr,
>>      &iio_scan_el_in7.dev_attr.attr,
>>      &iio_const_attr_in7_index.dev_attr.attr,
>> -    &iio_dev_attr_in_precision.dev_attr.attr,
>> +    &iio_dev_attr_in_type.dev_attr.attr,
>>      NULL,
>>  };
>> @@ -671,6 +673,8 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] = {
>>      [ad7991] = {
>>              .num_inputs = 4,
>>              .bits = 12,
>> +            .storagebits = 16,
> Why have storage bits if it is always 16?  It's also a characteristic of
> the buffer elements of the driver rather than the chip so it doesn't
> really make sense.

We use storagebits in in_type. In a different driver that I'm currently preparing for RFC.
I also use storagebits to characterize the buffer elements.
But here you're right it doesn't make too much sense.

>I'd prefer to see it generated as a round up integer
> multiple of 8 from the bits value.

Well that doesn't always work. There are devices that are 8-bit but require an 16-bit buffer.
I think you remember the need for the in_type shift extension.
They are type u8/16>>4

> That way the driver will nicely
> extend to 8 bit or 17bit+ devices should any exist.
>> +            .sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>>              .int_vref_mv = 4096,
>>              .dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
>>              .scan_attrs = &ad7991_5_9_3_4_scan_el_group, @@ -679,6
> +683,8 @@
>> static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>>      [ad7995] = {
>>              .num_inputs = 4,
>>              .bits = 10,
>> +            .storagebits = 16,
>> +            .sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>>              .int_vref_mv = 1024,
>>              .dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
>>              .scan_attrs = &ad7991_5_9_3_4_scan_el_group, @@ -687,6
> +693,8 @@
>> static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>>      [ad7999] = {
>>              .num_inputs = 4,
>>              .bits = 10,
>> +            .storagebits = 16,
>> +            .sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>>              .int_vref_mv = 1024,
>>              .dev_attrs = &ad7991_5_9_3_4_dev_attr_group,
>>              .scan_attrs = &ad7991_5_9_3_4_scan_el_group, @@ -695,6
> +703,8 @@
>> static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>>      [ad7992] = {
>>              .num_inputs = 2,
>>              .bits = 12,
>> +            .storagebits = 16,
>> +            .sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>>              .int_vref_mv = 4096,
>>              .monitor_mode = true,
>>              .default_config = AD7998_ALERT_EN, @@ -706,6 +716,8 @@ static
>> const struct ad799x_chip_info
> ad799x_chip_info_tbl[] = {
>>      [ad7993] = {
>>              .num_inputs = 4,
>>              .bits = 10,
>> +            .storagebits = 16,
>> +            .sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>>              .int_vref_mv = 1024,
>>              .monitor_mode = true,
>>              .default_config = AD7998_ALERT_EN, @@ -717,6 +729,8 @@ static
>> const struct ad799x_chip_info
> ad799x_chip_info_tbl[] = {
>>      [ad7994] = {
>>              .num_inputs = 4,
>>              .bits = 12,
>> +            .storagebits = 16,
>> +            .sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>>              .int_vref_mv = 4096,
>>              .monitor_mode = true,
>>              .default_config = AD7998_ALERT_EN, @@ -728,6 +742,8 @@ static
>> const struct ad799x_chip_info
> ad799x_chip_info_tbl[] = {
>>      [ad7997] = {
>>              .num_inputs = 8,
>>              .bits = 10,
>> +            .storagebits = 16,
>> +            .sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>>              .int_vref_mv = 1024,
>>              .monitor_mode = true,
>>              .default_config = AD7998_ALERT_EN, @@ -739,6 +755,8 @@ static
>> const struct ad799x_chip_info
> ad799x_chip_info_tbl[] = {
>>      [ad7998] = {
>>              .num_inputs = 8,
>>              .bits = 12,
>> +            .storagebits = 16,
>> +            .sign = IIO_SCAN_EL_TYPE_UNSIGNED,
>>              .int_vref_mv = 4096,
>>              .monitor_mode = true,
>>              .default_config = AD7998_ALERT_EN, diff --git
>> a/drivers/staging/iio/adc/ad799x_ring.c
>> b/drivers/staging/iio/adc/ad799x_ring.c
>> index d0217f8..c6871fa 100644
>> --- a/drivers/staging/iio/adc/ad799x_ring.c
>> +++ b/drivers/staging/iio/adc/ad799x_ring.c
>> @@ -53,7 +53,7 @@ int ad799x_single_channel_from_ring(struct
> ad799x_state *st, long mask)
>>              mask >>= 1;
>>      }
>> -    ret = be16_to_cpu(ring_data[count]) & 0xFFF;
>> +    ret = be16_to_cpu(ring_data[count]);
>>
>>  error_free_ring_data:
>>      kfree(ring_data);

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif


