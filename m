Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60637 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162089AbbBDSkz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Feb 2015 13:40:55 -0500
Message-ID: <54D25670.8000408@kernel.org>
Date: Wed, 04 Feb 2015 17:27:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Viorel Suman <viorel.suman@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] iio: gyro: bmg160: optimize i2c transfers in trigger
 handler
References: <1422537352-1374-1-git-send-email-irina.tirdea@intel.com> <CAAH5R_OYTbY3AW-pA3-p4+Gzo3MdGYX0a52UtJTbt=F8HSOj0A@mail.gmail.com>
In-Reply-To: <CAAH5R_OYTbY3AW-pA3-p4+Gzo3MdGYX0a52UtJTbt=F8HSOj0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/01/15 04:03, Viorel Suman wrote:
> Hi,
> 
> You might need more space in "values" buffer, for more details please check the
> "iio_push_to_buffers_with_timestamp" description and implementation.
Whilst that function is a little 'odd', this patch doesn't change the use
of buffer (simply how it if filled).  The buffer is 16bytes long
(8 x s16) so should be fine (4 x 16 bit and 1 x 64 bit).

More problematically, we have using a new smbus capability here
(to read it one transaction).  It's one you can check for, so I'm guessing
we aren't guaranteed it is present.
I2C_FUNC_SMBUS_READ_I2C_BLOCK 
 
Jonathan
> 
> Regards,
> Viorel
> 
> 
> On Thu, Jan 29, 2015 at 3:15 PM, Irina Tirdea <irina.tirdea@intel.com <mailto:irina.tirdea@intel.com>> wrote:
> 
>     Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
>     enable/disable the bus at each i2c transfer and must wait for
>     the enable/disable to happen before sending the data.
> 
>     When reading data in the trigger handler, the bmg160 driver does
>     one i2c transfer for each axis. This has an impact on the frequency
>     of the gyroscope at high sample rates due to additional delays
>     introduced by the i2c bus at each transfer.
> 
>     Reading all axis values in one i2c transfer reduces the delays
>     introduced by the i2c bus.
> 
>     Signed-off-by: Irina Tirdea <irina.tirdea@intel.com <mailto:irina.tirdea@intel.com>>
>     Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com <mailto:srinivas.pandruvada@linux.intel.com>>
>     ---
>      drivers/iio/gyro/bmg160.c | 20 +++++++++++---------
>      1 file changed, 11 insertions(+), 9 deletions(-)
> 
>     diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
>     index 60451b3..814eb20 100644
>     --- a/drivers/iio/gyro/bmg160.c
>     +++ b/drivers/iio/gyro/bmg160.c
>     @@ -115,6 +115,7 @@ enum bmg160_axis {
>             AXIS_X,
>             AXIS_Y,
>             AXIS_Z,
>     +       AXIS_MAX,
>      };
> 
>      static const struct {
>     @@ -820,20 +821,21 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
>             struct iio_dev *indio_dev = pf->indio_dev;
>             struct bmg160_data *data = iio_priv(indio_dev);
>             int bit, ret, i = 0;
>     +       s16 values[AXIS_MAX];
> 
>             mutex_lock(&data->mutex);
>     -       for_each_set_bit(bit, indio_dev->buffer->scan_mask,
>     -                        indio_dev->masklength) {
>     -               ret = i2c_smbus_read_word_data(data->client,
>     -                                              BMG160_AXIS_TO_REG(bit));
>     -               if (ret < 0) {
>     -                       mutex_unlock(&data->mutex);
>     -                       goto err;
>     -               }
>     -               data->buffer[i++] = ret;
>     +       ret = i2c_smbus_read_i2c_block_data(data->client, BMG160_REG_XOUT_L,
>     +                                           sizeof(values), (u8 *) values);
>     +       if (ret < 0) {
>     +               mutex_unlock(&data->mutex);
>     +               goto err;
>             }
>             mutex_unlock(&data->mutex);
> 
>     +       for_each_set_bit(bit, indio_dev->buffer->scan_mask,
>     +                        indio_dev->masklength)
>     +               data->buffer[i++] = values[bit];
>     +
>             iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>                                                data->timestamp);
>      err:
>     --
>     1.9.1
> 
>     --
>     To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>     the body of a message to majordomo@vger.kernel.org <mailto:majordomo@vger.kernel.org>
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

