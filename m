Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49466 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754693AbcIRKgp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:36:45 -0400
Subject: Re: [PATCH 15/15 v2] iio: accel: kxsd9: Support reading a mounting
 matrix
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
 <1472723089-25113-15-git-send-email-linus.walleij@linaro.org>
 <be4c1eba-a716-57dc-1e39-ddf7214e714a@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2c5df1ea-7f60-e913-a103-e7d0fdb8b3a9@kernel.org>
Date: Sun, 18 Sep 2016 11:36:43 +0100
MIME-Version: 1.0
In-Reply-To: <be4c1eba-a716-57dc-1e39-ddf7214e714a@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/16 17:51, Jonathan Cameron wrote:
> On 01/09/16 10:44, Linus Walleij wrote:
>> This adds support for the mounting matrix to the KXSD9 driver.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Well the identity matrix is nicely reported by my pre device tree
> board.
> 
> (yeah I know I could make it run off device tree but somehow
> it's never high on my list given I don't actually know of anyone
> other than me who still uses these ;)
> 
> So I'll give it a 
> Tested-by: Jonathan Cameron <jic23@kernel.org>
> 
> So all now tested as well as I'm going to on real hardware.
> No crashes and data is just as rubbish as I remember..
> 
> Will pick up once the fixes make it through.  Could
> conceivably not happen until after merge window. We will
> have to see.
> 
Applied.
> 
> Jonathan
>> ---
>> ChangeLog v1->v2:
>> - Rebase on the rest of the series.
>> ---
>>  drivers/iio/accel/kxsd9.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
>> index a28163b76e12..9af60ac70738 100644
>> --- a/drivers/iio/accel/kxsd9.c
>> +++ b/drivers/iio/accel/kxsd9.c
>> @@ -68,12 +68,14 @@
>>   * struct kxsd9_state - device related storage
>>   * @dev: pointer to the parent device
>>   * @map: regmap to the device
>> + * @orientation: mounting matrix, flipped axis etc
>>   * @regs: regulators for this device, VDD and IOVDD
>>   * @scale: the current scaling setting
>>   */
>>  struct kxsd9_state {
>>  	struct device *dev;
>>  	struct regmap *map;
>> +	struct iio_mount_matrix orientation;
>>  	struct regulator_bulk_data regs[2];
>>  	u8 scale;
>>  };
>> @@ -258,6 +260,20 @@ static const struct iio_buffer_setup_ops kxsd9_buffer_setup_ops = {
>>  	.postdisable = kxsd9_buffer_postdisable,
>>  };
>>  
>> +static const struct iio_mount_matrix *
>> +kxsd9_get_mount_matrix(const struct iio_dev *indio_dev,
>> +		       const struct iio_chan_spec *chan)
>> +{
>> +	struct kxsd9_state *st = iio_priv(indio_dev);
>> +
>> +	return &st->orientation;
>> +}
>> +
>> +static const struct iio_chan_spec_ext_info kxsd9_ext_info[] = {
>> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, kxsd9_get_mount_matrix),
>> +	{ },
>> +};
>> +
>>  #define KXSD9_ACCEL_CHAN(axis, index)						\
>>  	{								\
>>  		.type = IIO_ACCEL,					\
>> @@ -266,6 +282,7 @@ static const struct iio_buffer_setup_ops kxsd9_buffer_setup_ops = {
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>>  					BIT(IIO_CHAN_INFO_OFFSET),	\
>> +		.ext_info = kxsd9_ext_info,				\
>>  		.address = KXSD9_REG_##axis,				\
>>  		.scan_index = index,					\
>>  		.scan_type = {                                          \
>> @@ -403,6 +420,13 @@ int kxsd9_common_probe(struct device *dev,
>>  	indio_dev->modes = INDIO_DIRECT_MODE;
>>  	indio_dev->available_scan_masks = kxsd9_scan_masks;
>>  
>> +	/* Read the mounting matrix, if present */
>> +	ret = of_iio_read_mount_matrix(dev,
>> +				       "mount-matrix",
>> +				       &st->orientation);
>> +	if (ret)
>> +		return ret;
>> +
>>  	/* Fetch and turn on regulators */
>>  	st->regs[0].supply = kxsd9_reg_vdd;
>>  	st->regs[1].supply = kxsd9_reg_iovdd;
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

