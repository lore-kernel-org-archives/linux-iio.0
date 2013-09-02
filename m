Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:17764 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab3IBJjg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2013 05:39:36 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MSH00FXKRYMMUA0@mailout4.w1.samsung.com> for
 linux-iio@vger.kernel.org; Mon, 02 Sep 2013 10:39:33 +0100 (BST)
Message-id: <52245CD4.5000703@samsung.com>
Date: Mon, 02 Sep 2013 11:39:32 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, kyungmin.park@samsung.com,
	s.nawrocki@samsung.com
Subject: Re: [PATCH/RFC v8] iio: gp2ap020a00f: Add a driver for the device
References: <1377702007-29813-1-git-send-email-j.anaszewski@samsung.com>
 <52222FC4.1080408@kernel.org>
In-reply-to: <52222FC4.1080408@kernel.org>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/2013 08:02 PM, Jonathan Cameron wrote:
> On 08/28/13 16:00, Jacek Anaszewski wrote:
>> Add a new driver for the ambient light/proximity sensor
>> device. The driver exposes three channels: light_clear
>> light_ir and proximity. It also supports triggered buffer,
>> high and low ambient light threshold event and proximity
>> detection events.
>>
>> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> This driver supports:
>>   - reading channels in 'one shot' mode through read_raw callback,
>>   - four events - rising and falling ambient light events and
>>     rising and falling proximity roc events.
>>   - triggers for all the three channels (triggers can't be enabled
>>     simultaneosly with proximity detection event)
>
> I'm a little confused by this statement.  Can these 3 triggers fire at
> different rates?  The buffering etc assumes scans across all available
> channels and that is indeed what you do in the trigger handler.

No, they fire at the same rate. The proximity detection event
can't be enabled in the same time as the triggers because there
are different interrupt modes dedicated to the proximity detection
event and the proximity threshold event which is exploited for the 
triggers. In the proximity detection interrupt mode (PIN_PS_DETECT)
there is single interrupt generated upon crossing the threshold.
If the interrupts should be generated upon every measurement
cycle, the PIN_PS, PIN_ALS or PIN_ALS_OR_PS mode should be set.
In those modes the interrupts are being generated if the low or high
threshold is crossed. Therefore, the illuminance events can be enabled 
simultaneously with triggers. Actually from the device point of view, 
they are enabled all the time, when not in the PIN_PS_DETECT mode. The 
interrupts are being generated when the output data falls below the low 
threshold or rises above the high threshold. In specific case, when the 
output value is 0 - no interrupt is being generated as it is impossible 
to set the low threshold to the value less than 0.
When both triggers and illuminance events are enabled the
generic_buffers application displays new samples of data
only if the thresholds are crossed.

This is why the triggers and events are so tightly coupled
in the driver. I hope that I didn't confuse you even more
by this explanation :)

>>
>> This is a follow-up of the previous series. The patch with
>> DT bindings documentation [1] for the driver has been already
>> acked [2]. This patch includes following improvements:
>>    - split event_handler to two handlers, for als and proximity
>>      events. It saves cpu resources as the proximity
>>      event is signalized with both rising and falling edges,
>>      whereas als events exploits only the falling one
>
> That is truely hideous.  Not that I can see a better way.
>
> I was going to ask which combinations of events are possible then
> noticed you lay it out clearly below!  Even by normal standards
> of odd hardware this is ugly.
>
> I do have a few  minor issues left in line.  I very nearly
> applied this as is, but given, unfortunately, it has taken me
> too long to review it to get it in within the upcoming merge cycle
> (which may open any time) we have plenty of time to clean these
> little things up.
>
>
>>    - the function gp2ap020a00f_adjust_lux_mode is now called
>>      from one common place - gp2ap020a00f_als_event_handler
>>    - brought back data_ready_queue, which cuts down the time
>>      needed for obtaining measurement result when accessing
>>      read_raw sysfs attribute
>>    - made slight adjustements in the code formating (one line
>>      exceeds 80 characters limit but I think it is acceptable
>>      in that case)
> Yup, not much that can be done sensibly about that one line so
> it is fine.
>
>>
>> [1] - http://www.spinics.net/lists/linux-iio/msg09768.html
>> [2] - http://www.spinics.net/lists/linux-iio/msg09772.html
>>
>> Thanks,
>> Jacek Anaszewski
>>
>>   drivers/iio/light/Kconfig        |   12 +
>>   drivers/iio/light/Makefile       |    1 +
>>   drivers/iio/light/gp2ap020a00f.c | 1618 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1631 insertions(+)
>>   create mode 100644 drivers/iio/light/gp2ap020a00f.c
>>
>
> <snip>
>> +/*
>> + * Copyright (C) 2013 Samsung Electronics Co., Ltd.
>> + * Author: Jacek Anaszewski <j.anaszewski@samsung.com>
>> + *
>> + * IIO features supported by the driver:
>> + *
>> + * Read-only raw channels:
>> + *   - illiminance_clear [lux]
>> + *   - illiminance_ir
>> + *   - proximity
>> + *
>> + * Triggered buffer:
>> + *   - illiminance_clear
>> + *   - illiminance_ir
>> + *   - proximity
>> + *
>> + * Events:
>> + *   - illuminance_clear (rising and falling)
>> + *   - proximity (rising and falling)
>> + *     - both falling and rising thresholds for the proximity events
>> + *       must be set to the values greater than 0.
>> + *
>> + * The driver supports triggered buffers for all the three
>> + * channels as well as high and low threshold events for the
>> + * illuminance_clear and proxmimity channels. Triggers
>> + * can be enabled simultaneously with both illuminance_clear
>> + * events. Proximity events cannot be enabled simultaneously
>> + * with any triggers or illuminance events. Enabling/disabling
>> + * one of the proximity events automatically enables/disables
>> + * the other one.
> Good description that clearly answered my main remaining question!
>> + *
>
> <snip>
>
>> +static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
>> +					enum gp2ap020a00f_cmd cmd)
>> +{
>> +	int err = 0;
>> +
>> +	switch (cmd) {
>> +	case GP2AP020A00F_CMD_READ_RAW_CLEAR:
>> +		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
>> +			return -EBUSY;
>> +		err = gp2ap020a00f_set_operation_mode(data,
>> +					GP2AP020A00F_OPMODE_READ_RAW_CLEAR);
>> +		break;
>> +	case GP2AP020A00F_CMD_READ_RAW_IR:
>> +		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
>> +			return -EBUSY;
>> +		err = gp2ap020a00f_set_operation_mode(data,
>> +					GP2AP020A00F_OPMODE_READ_RAW_IR);
>> +		break;
>> +	case GP2AP020A00F_CMD_READ_RAW_PROXIMITY:
>> +		if (data->cur_opmode != GP2AP020A00F_OPMODE_SHUTDOWN)
>> +			return -EBUSY;
>> +		err = gp2ap020a00f_set_operation_mode(data,
>> +					GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY);
>> +		break;
>> +	case GP2AP020A00F_CMD_TRIGGER_CLEAR_EN:
>> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
>> +			return -EBUSY;
>> +		if (!gp2ap020a00f_als_enabled(data))
>> +			err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_ALS,
>> +						GP2AP020A00F_ADD_MODE);
>> +		set_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &data->flags);
>> +		break;
>> +	case GP2AP020A00F_CMD_TRIGGER_CLEAR_DIS:
>> +		clear_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &data->flags);
>> +		if (gp2ap020a00f_als_enabled(data))
>> +			break;
>> +		err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_ALS,
>> +						GP2AP020A00F_SUBTRACT_MODE);
>> +		break;
>> +	case GP2AP020A00F_CMD_TRIGGER_IR_EN:
>> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
>> +			return -EBUSY;
>> +		if (!gp2ap020a00f_als_enabled(data))
>> +			err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_ALS,
>> +						GP2AP020A00F_ADD_MODE);
>> +		set_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &data->flags);
>> +		break;
>> +	case GP2AP020A00F_CMD_TRIGGER_IR_DIS:
>> +		clear_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &data->flags);
>> +		if (gp2ap020a00f_als_enabled(data))
>> +			break;
>> +		err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_ALS,
>> +						GP2AP020A00F_SUBTRACT_MODE);
>> +		break;
>> +	case GP2AP020A00F_CMD_TRIGGER_PROX_EN:
>> +		if (data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
>> +			return -EBUSY;
>> +		err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_PS,
>> +						GP2AP020A00F_ADD_MODE);
>> +		set_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &data->flags);
>> +		break;
>> +	case GP2AP020A00F_CMD_TRIGGER_PROX_DIS:
>> +		clear_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &data->flags);
>> +		err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_PS,
>> +						GP2AP020A00F_SUBTRACT_MODE);
>> +		break;
>> +	case GP2AP020A00F_CMD_ALS_HIGH_EV_EN:
>> +		if (test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
>> +							&data->flags) ||
>> +		    data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
>> +			return -EBUSY;
> EBUSY is fine for the case of proximity being enabled, but for the case
> where the event is already on we'd normally just expect to return 0
> rather than an error at all. Of course you wouldn't expect userspace to
> do this normally but it still isn't really an error.
>
> You do this quite a few times in this function.

OK, I will fix that.

>> +		if (!gp2ap020a00f_als_enabled(data)) {
>> +			err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_ALS,
>> +						GP2AP020A00F_ADD_MODE);
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +		set_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT, &data->flags);
>> +		err =  gp2ap020a00f_write_event_threshold(data,
>> +					GP2AP020A00F_THRESH_TH, true);
>> +		break;
>> +	case GP2AP020A00F_CMD_ALS_HIGH_EV_DIS:
>> +		if (!test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT, &data->flags))
>> +			return -EBUSY;
>> +		clear_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT, &data->flags);
>> +		if (!gp2ap020a00f_als_enabled(data)) {
>> +			err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_ALS,
>> +						GP2AP020A00F_SUBTRACT_MODE);
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +		err =  gp2ap020a00f_write_event_threshold(data,
>> +					GP2AP020A00F_THRESH_TH, false);
>> +		break;
>> +	case GP2AP020A00F_CMD_ALS_LOW_EV_EN:
>> +		if (test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
>> +							&data->flags) ||
>> +		    data->cur_opmode == GP2AP020A00F_OPMODE_PROX_DETECT)
>> +			return -EBUSY;
>> +		if (!gp2ap020a00f_als_enabled(data)) {
>> +			err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_ALS,
>> +						GP2AP020A00F_ADD_MODE);
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +		set_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT, &data->flags);
>> +		err =  gp2ap020a00f_write_event_threshold(data,
>> +					GP2AP020A00F_THRESH_TL, true);
>> +		break;
>> +	case GP2AP020A00F_CMD_ALS_LOW_EV_DIS:
>> +		if (!test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
>> +							&data->flags))
>> +			return -EBUSY;
>> +		clear_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT, &data->flags);
>> +		if (!gp2ap020a00f_als_enabled(data)) {
>> +			err = gp2ap020a00f_alter_opmode(data,
>> +						GP2AP020A00F_OPMODE_ALS,
>> +						GP2AP020A00F_SUBTRACT_MODE);
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +		err =  gp2ap020a00f_write_event_threshold(data,
>> +					GP2AP020A00F_THRESH_TL, false);
>> +		break;
>> +	case GP2AP020A00F_CMD_PROX_HIGH_EV_EN:
>> +		if (test_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT,
>> +							&data->flags) ||
>> +		    gp2ap020a00f_als_enabled(data) ||
>> +		    data->cur_opmode == GP2AP020A00F_OPMODE_PS)
>> +			return -EBUSY;
>> +		if (!gp2ap020a00f_prox_detect_enabled(data)) {
>> +			err = gp2ap020a00f_set_operation_mode(data,
>> +					GP2AP020A00F_OPMODE_PROX_DETECT);
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +		set_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT, &data->flags);
>> +		err =  gp2ap020a00f_write_event_threshold(data,
>> +					GP2AP020A00F_THRESH_PH, true);
>> +		break;
>> +	case GP2AP020A00F_CMD_PROX_HIGH_EV_DIS:
>> +		if (!test_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT,
>> +							&data->flags))
>> +			return -EBUSY;
>> +		clear_bit(GP2AP020A00F_FLAG_PROX_RISING_EVENT, &data->flags);
>> +		err = gp2ap020a00f_set_operation_mode(data,
>> +					GP2AP020A00F_OPMODE_SHUTDOWN);
>> +		if (err < 0)
>> +			return err;
>> +		err =  gp2ap020a00f_write_event_threshold(data,
>> +					GP2AP020A00F_THRESH_PH, false);
>> +		break;
>> +	case GP2AP020A00F_CMD_PROX_LOW_EV_EN:
>> +		if (test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
>> +							&data->flags) ||
>> +		    gp2ap020a00f_als_enabled(data) ||
>> +		    data->cur_opmode == GP2AP020A00F_OPMODE_PS)
>> +			return -EBUSY;
>> +		if (!gp2ap020a00f_prox_detect_enabled(data)) {
>> +			err = gp2ap020a00f_set_operation_mode(data,
>> +					GP2AP020A00F_OPMODE_PROX_DETECT);
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +		set_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT, &data->flags);
>> +		err =  gp2ap020a00f_write_event_threshold(data,
>> +					GP2AP020A00F_THRESH_PL, true);
>> +		break;
>> +	case GP2AP020A00F_CMD_PROX_LOW_EV_DIS:
>> +		if (!test_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT,
>> +							&data->flags))
>> +			return -EBUSY;
>> +		clear_bit(GP2AP020A00F_FLAG_PROX_FALLING_EVENT, &data->flags);
>> +		err = gp2ap020a00f_set_operation_mode(data,
>> +					GP2AP020A00F_OPMODE_SHUTDOWN);
>> +		if (err < 0)
>> +			return err;
>> +		err =  gp2ap020a00f_write_event_threshold(data,
>> +					GP2AP020A00F_THRESH_PL, false);
>> +		break;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>
>
>> +static irqreturn_t gp2ap020a00f_als_event_handler(int irq, void *data)
>> +{
>> +	struct iio_dev *indio_dev = data;
>> +	struct gp2ap020a00f_data *priv = iio_priv(indio_dev);
>> +	u8 op_reg_flags, d0_reg_buf[2];
>> +	unsigned int output_val, op_reg_val;
>> +	int thresh_val_id, ret;
>> +
>> +	mutex_lock(&priv->lock);
>> +
>> +	/* Read interrupt flags */
>> +	ret = regmap_read(priv->regmap, GP2AP020A00F_OP_REG,
>> +							&op_reg_val);
>> +	if (ret < 0)
>> +		goto unlock;
>> +
>> +	op_reg_flags = op_reg_val & (GP2AP020A00F_FLAG_A | GP2AP020A00F_FLAG_P
>> +					| GP2AP020A00F_PROX_DETECT);
>> +
>> +	op_reg_val &= (~GP2AP020A00F_FLAG_A & ~GP2AP020A00F_FLAG_P
>> +					& ~GP2AP020A00F_PROX_DETECT);
>> +
>> +	/* Clear interrupt flags (if not in INTTYPE_PULSE mode) */
>> +	if (priv->cur_opmode != GP2AP020A00F_OPMODE_PROX_DETECT) {
>> +		ret = regmap_write(priv->regmap, GP2AP020A00F_OP_REG,
>> +								op_reg_val);
>> +		if (ret < 0)
>> +			goto unlock;
>> +	}
>> +
>> +	if (op_reg_flags & GP2AP020A00F_FLAG_A) {
>> +		/* Check D0 register to assess if the lux mode
>> +		 * transition is required.
>> +		 */
>> +		ret = regmap_bulk_read(priv->regmap, GP2AP020A00F_D0_L_REG,
>> +							d0_reg_buf, 2);
>> +		if (ret < 0)
>> +			goto unlock;
>> +
>> +		output_val = le16_to_cpup((__le16 *)d0_reg_buf);
>> +
>> +		if (gp2ap020a00f_adjust_lux_mode(priv, output_val))
>> +			goto unlock;
>> +
>> +		gp2ap020a00f_output_to_lux(priv, &output_val);
>> +
>> +		/*
>> +		 * We need to check output value to distinguish
>> +		 * between high and low ambient light threshold event.
>> +		 */
>> +		if (test_bit(GP2AP020A00F_FLAG_ALS_RISING_EVENT,
>> +							&priv->flags)) {
>> +			thresh_val_id =
>> +			    GP2AP020A00F_THRESH_VAL_ID(GP2AP020A00F_TH_L_REG);
>> +			if (output_val > priv->thresh_val[thresh_val_id])
>> +				iio_push_event(indio_dev,
>> +				       IIO_MOD_EVENT_CODE(
>> +					    IIO_LIGHT,
>> +					    GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
>> +					    IIO_MOD_LIGHT_CLEAR,
>> +					    IIO_EV_TYPE_THRESH,
>> +					    IIO_EV_DIR_RISING),
>> +				       iio_get_time_ns());
>> +		}
>> +
>> +		if (test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EVENT,
>> +							&priv->flags)) {
>> +			thresh_val_id =
>> +			    GP2AP020A00F_THRESH_VAL_ID(GP2AP020A00F_TL_L_REG);
>> +			if (output_val < priv->thresh_val[thresh_val_id])
>> +				iio_push_event(indio_dev,
>> +				       IIO_MOD_EVENT_CODE(
>> +					    IIO_LIGHT,
>> +					    GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
>> +					    IIO_MOD_LIGHT_CLEAR,
>> +					    IIO_EV_TYPE_THRESH,
>> +					    IIO_EV_DIR_FALLING),
>> +				       iio_get_time_ns());
>> +		}
>> +	}
>> +
>> +	if (priv->cur_opmode == GP2AP020A00F_OPMODE_READ_RAW_CLEAR ||
>> +	    priv->cur_opmode == GP2AP020A00F_OPMODE_READ_RAW_IR ||
>> +	    priv->cur_opmode == GP2AP020A00F_OPMODE_READ_RAW_PROXIMITY) {
>> +		set_bit(GP2AP020A00F_FLAG_DATA_READY, &priv->flags);
>> +		wake_up(&priv->data_ready_queue);
>> +		goto unlock;
>> +	}
>> +
>> +	/* This fires off trigger handler. */
> That comment is missleading. It fires off the trigger, which in turn
> 'may' call the trigger_handler.
>
> You might want to only call this iff the trigger is enabled though...
>
>> +	irq_work_queue(&priv->work);
>> +unlock:
>> +	mutex_unlock(&priv->lock);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
>> +{
>> +	struct iio_poll_func *pf = data;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct gp2ap020a00f_data *lgt = iio_priv(indio_dev);
>> +	size_t d_size = 0;
>> +	__le32 light_lux;
>> +	int i, out_val, ret;
>> +
>> +	for_each_set_bit(i, indio_dev->active_scan_mask,
>> +		indio_dev->masklength) {
>> +		ret = regmap_bulk_read(lgt->regmap,
>> +				GP2AP020A00F_DATA_REG(i),
>> +				&lgt->buffer[d_size], 2);
>> +		if (ret < 0)
>> +			goto done;
>> +
>> +		if (i == GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR ||
>> +		    i == GP2AP020A00F_SCAN_MODE_LIGHT_IR) {
>> +			out_val = le16_to_cpup((__le16 *)&lgt->buffer[d_size]);
>> +			gp2ap020a00f_output_to_lux(lgt, &out_val);
>> +			light_lux = cpu_to_le32(out_val);
>> +			memcpy(&lgt->buffer[d_size], (u8 *)&light_lux, 4);
>> +			d_size += 4;
>> +		} else {
>> +			d_size += 2;
>> +		}
>> +	}
>> +
>> +	if (indio_dev->scan_timestamp) {
>> +		s64 *timestamp = (s64 *)((u8 *)lgt->buffer +
>> +						ALIGN(d_size, sizeof(s64)));
>> +		*timestamp = pf->timestamp;
>> +	}
>> +
>> +	iio_push_to_buffers(indio_dev, lgt->buffer);
>> +done:
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>
> <snip>
>> +static int gp2ap020a00f_write_prox_event_config(struct iio_dev *indio_dev,
>> +					u64 event_code, int state)
>> +{
>> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>> +	enum gp2ap020a00f_cmd cmd_high_ev, cmd_low_ev;
>> +	int err;
>> +
>> +	cmd_high_ev = state ? GP2AP020A00F_CMD_PROX_HIGH_EV_EN :
>> +			      GP2AP020A00F_CMD_PROX_HIGH_EV_DIS;
>> +	cmd_low_ev = state ? GP2AP020A00F_CMD_PROX_LOW_EV_EN :
>> +			     GP2AP020A00F_CMD_PROX_LOW_EV_DIS;
>> +
>> +	/*
>> +	 * In order to enable proximity detection feature in the device
>> +	 * both high and low threshold registers have to be written
>> +	 * with different values, greater than zero.
>> +	 */
>> +	if (state) {
>> +		if (data->thresh_val[GP2AP020A00F_THRESH_PL] == 0)
>> +			return -EINVAL;
>> +
>> +		if (data->thresh_val[GP2AP020A00F_THRESH_PH] == 0)
>> +			return -EINVAL;
>> +	}
>> +
>> +	err = gp2ap020a00f_exec_cmd(data, cmd_high_ev);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	err = gp2ap020a00f_exec_cmd(data, cmd_low_ev);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	free_irq(data->client->irq, indio_dev);
>> +
>
> Ouch, this is hideous.  Not your fault, just uggly hardware.
>
>> +	if (state)
>> +		err = request_threaded_irq(data->client->irq, NULL,
>> +					   &gp2ap020a00f_prox_event_handler,
>> +					   IRQF_TRIGGER_RISING |
>> +					   IRQF_TRIGGER_FALLING |
>> +					   IRQF_ONESHOT,
>> +					   "gp2ap020a00f_prox_event",
>> +					   indio_dev);
>> +	else {
>> +		err = request_threaded_irq(data->client->irq, NULL,
>> +					   &gp2ap020a00f_als_event_handler,
>> +					   IRQF_TRIGGER_FALLING |
>> +					   IRQF_ONESHOT,
>> +					   "gp2ap020a00f_als_event",
>> +					   indio_dev);
>> +	}
>> +
>> +	return err;
>> +}
>> +
>
> <snip>
>> +static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
>> +				struct iio_chan_spec const *chan, int *val)
>> +{
> To supress a gcc warning I'm seeing set cmd to something pr add a default
> with error return to the switch statement.
>> +	enum gp2ap020a00f_cmd cmd;
>> +	int err;
>> +
>> +	switch (chan->scan_index) {
>> +	case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
>> +		cmd = GP2AP020A00F_CMD_READ_RAW_CLEAR;
>> +		break;
>> +	case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
>> +		cmd = GP2AP020A00F_CMD_READ_RAW_IR;
>> +		break;
>> +	case GP2AP020A00F_SCAN_MODE_PROXIMITY:
>> +		cmd = GP2AP020A00F_CMD_READ_RAW_PROXIMITY;
>> +		break;
>> +	}
>> +
>> +	err = gp2ap020a00f_exec_cmd(data, cmd);
>> +	if (err < 0) {
>> +		dev_err(&data->client->dev,
>> +			"gp2ap020a00f_exec_cmd failed\n");
>> +		goto error_ret;
>> +	}
>> +
>> +	err = gp2ap020a00f_read_output(data, chan->address, val);
>> +	if (err < 0)
>> +		dev_err(&data->client->dev,
>> +			"gp2ap020a00f_read_output failed\n");
>> +
>> +	data->cur_opmode = GP2AP020A00F_OPMODE_SHUTDOWN;
>> +
>> +	if (cmd == GP2AP020A00F_CMD_READ_RAW_CLEAR ||
>> +	    cmd == GP2AP020A00F_CMD_READ_RAW_IR)
>> +		gp2ap020a00f_output_to_lux(data, val);
>> +
>> +error_ret:
>> +	return err;
>> +}
>> +
>
>
>> +static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>> +{
>> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>> +	int i, err = 0;
>> +
>> +	mutex_lock(&data->lock);
>> +
>
> This confuses me a little.  Do we actually have 3 different
> sources of interrupts or is it just the case that any of these
> being enabled results in a single interrupt once all three are
> available?

Besides PIN_PS_DETECT interrupt mode that I described above there
are three more: PIN_ALS, PIN_PS and PIN_ALS_OR_PS. The first two
enable ALS and proximity interrupts respectively and the third one
enables both. The device has also corresponding operation modes -
OP_ALS, OP_PS and OP_ALS_AND_PS, which enable only ALS block,
only PS block or both blocks in the device respectively.
The output data for both illuminance channels is generated
at one run, by ALS block. If one of them isn't enabled in the
scan config it is simply ignored by the driver. The proximity
output data is produced only when the PS block is enabled.
The exec_cmd functions checks what operation mode is currently
enabled and sets the device in the OP_ALS_AND_PS mode if the
scan mode corresponding to the one of the modes is already enabled.

>> +	/* Enable triggers according to the scan_mask */
>> +	for_each_set_bit(i, indio_dev->active_scan_mask,
>> +		indio_dev->masklength) {
>> +		switch (i) {
>> +		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
>> +			err = gp2ap020a00f_exec_cmd(data,
>> +					GP2AP020A00F_CMD_TRIGGER_CLEAR_EN);
>> +			break;
>> +		case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
>> +			err = gp2ap020a00f_exec_cmd(data,
>> +					GP2AP020A00F_CMD_TRIGGER_IR_EN);
>> +			break;
>> +		case GP2AP020A00F_SCAN_MODE_PROXIMITY:
>> +			err = gp2ap020a00f_exec_cmd(data,
>> +					GP2AP020A00F_CMD_TRIGGER_PROX_EN);
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (err < 0)
>> +		goto error_unlock;
>> +
>> +	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>> +	if (!data->buffer) {
>> +		err = -ENOMEM;
>> +		goto error_unlock;
>> +	}
>> +
>> +	err = iio_triggered_buffer_postenable(indio_dev);
>> +
>> +error_unlock:
>> +	mutex_unlock(&data->lock);
>> +
>> +	return err;
>> +}
>> +
>
>
> <snip>
>> +static int gp2ap020a00f_probe(struct i2c_client *client,
>> +				const struct i2c_device_id *id)
>> +{
>> +	struct gp2ap020a00f_data *data;
>> +	struct iio_dev *indio_dev;
>> +	struct regmap *regmap;
>> +	int err;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +
>> +	data->vled_reg = devm_regulator_get(&client->dev, "vled");
>> +	if (IS_ERR(data->vled_reg))
>> +		return PTR_ERR(data->vled_reg);
>> +
>> +	err = regulator_enable(data->vled_reg);
>> +	if (err)
>> +		return err;
>> +
>> +	regmap = devm_regmap_init_i2c(client, &gp2ap020a00f_regmap_config);
>> +	if (IS_ERR(regmap)) {
>> +		dev_err(&client->dev, "Regmap initialization failed.\n");
>> +		err = PTR_ERR(regmap);
>> +		goto error_regulator_disable;
>> +	}
>> +
>> +	/* Initialize device registers */
>> +	err = regmap_bulk_write(regmap, GP2AP020A00F_OP_REG,
>> +			gp2ap020a00f_reg_init_tab,
>> +			ARRAY_SIZE(gp2ap020a00f_reg_init_tab));
>> +
>> +	if (err < 0) {
>> +		dev_err(&client->dev, "Device initialization failed.\n");
>> +		goto error_regulator_disable;
>> +	}
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	data->client = client;
>> +	data->cur_opmode = GP2AP020A00F_OPMODE_SHUTDOWN;
>> +	data->regmap = regmap;
>> +	init_waitqueue_head(&data->data_ready_queue);
>> +
>> +	mutex_init(&data->lock);
>> +	indio_dev->dev.parent = &client->dev;
>> +	indio_dev->channels = gp2ap020a00f_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(gp2ap020a00f_channels);
>> +	indio_dev->info = &gp2ap020a00f_info;
>> +	indio_dev->name = id->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	/* Allocate buffer */
>> +	err = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
>> +		&gp2ap020a00f_trigger_handler, &gp2ap020a00f_buffer_setup_ops);
>> +	if (err < 0)
>> +		goto error_regulator_disable;
>> +
>> +	/* Allocate trigger */
>> +	data->trig = devm_iio_trigger_alloc(&client->dev, "%s-trigger",
>> +							indio_dev->name);
>> +	if (data->trig == NULL) {
>> +		err = -ENOMEM;
>> +		dev_err(&indio_dev->dev, "Failed to allocate iio trigger.\n");
>> +		goto error_uninit_buffer;
>> +	}
>> +
> Perhaps a comment here to explain that this needs to be enabled for read_raw
> calls to work?  (took me a minute to figure out why you requested it here).

I will remove this in the next patch as the interrupt handler can't
execute simultaneously with read_output function because of mutex lock.
Polling read_raw attribute currently works only because of timeout on
the data_ready_queue. I recklessly brought back that solution.
I am going to implement polling an interrupt flag in the read_channel
function and bring back lux mode adjustment there.

>> +	err = request_threaded_irq(client->irq, NULL,
>> +				   &gp2ap020a00f_als_event_handler,
>> +				   IRQF_TRIGGER_FALLING |
>> +				   IRQF_ONESHOT,
>> +				   "gp2ap020a00f_als_event",
>> +				   indio_dev);
>> +	if (err < 0) {
>> +		dev_err(&client->dev, "Irq request failed.\n");
>> +		goto error_uninit_buffer;
>> +	}
>> +
>> +	data->trig->ops = &gp2ap020a00f_trigger_ops;
>> +	data->trig->dev.parent = &data->client->dev;
>> +
>> +	init_irq_work(&data->work, gp2ap020a00f_iio_trigger_work);
>> +
>> +	err = iio_trigger_register(data->trig);
>> +	if (err < 0) {
>> +		dev_err(&client->dev, "Failed to register iio trigger.\n");
>> +		goto error_free_irq;
>> +	}
>> +
>> +	err = iio_device_register(indio_dev);
>> +	if (err < 0)
>> +		goto error_trigger_unregister;
>> +
>> +	return 0;
>> +
>> +error_trigger_unregister:
>> +	iio_trigger_unregister(data->trig);
>> +error_free_irq:
>> +	free_irq(client->irq, indio_dev);
>> +error_uninit_buffer:
>> +	iio_triggered_buffer_cleanup(indio_dev);
>> +error_regulator_disable:
>> +	regulator_disable(data->vled_reg);
>> +
>> +	return err;
>> +}
>> +
>
>
>

Thanks,
Jacek

