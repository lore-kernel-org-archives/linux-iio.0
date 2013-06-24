Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-229.synserver.de ([212.40.185.229]:1040 "EHLO
	smtp-out-229.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3FXRFU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2013 13:05:20 -0400
Message-ID: <51C87C59.7070606@metafoo.de>
Date: Mon, 24 Jun 2013 19:05:29 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, s.nawrocki@samsung.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH/RFC] iio: gp2ap002a00f: Add a driver for the device.
References: <1371470364-14475-1-git-send-email-j.anaszewski@samsung.com> <1371470364-14475-2-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1371470364-14475-2-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/17/2013 01:59 PM, Jacek Anaszewski wrote:
[...]
> +
> +/* Registers */
> +#define OP_REG			0x00 /* Basic operations */
> +#define ALS_REG			0x01 /* ALS related settings */
> +#define PS_REG			0x02 /* PS related settings */
> +#define LED_REG			0x03 /* LED reg */
> +#define TL_L_REG		0x04 /* ALS: Threshold low LSB */
> +#define TL_H_REG		0x05 /* ALS: Threshold low MSB */
> +#define TH_L_REG		0x06 /* ALS: Threshold high LSB */
> +#define TH_H_REG		0x07 /* ALS: Threshold high MSB */
> +#define PL_L_REG		0x08 /* PS: Threshold low LSB */
> +#define PL_H_REG		0x09 /* PS: Threshold low MSB */
> +#define PH_L_REG		0x0a /* PS: Threshold high LSB */
> +#define PH_H_REG		0x0b /* PS: Threshold high MSB */
> +#define D0_L_REG		0x0c /* ALS result: Clear/Illuminance LSB */
> +#define D0_H_REG		0x0d /* ALS result: Clear/Illuminance MSB */
> +#define D1_L_REG		0x0e /* ALS result: IR LSB */
> +#define D1_H_REG		0x0f /* ALS result: IR LSB */
> +#define D2_L_REG		0x10 /* PS result LSB */
> +#define D2_H_REG		0x11 /* PS result MSB */
> +#define REGS_NUM		0x12 /* Number of registers */
> +
> +/* OP_REG bits */
> +#define OP3_MASK		0x80 /* Software shutdown */
> +#define OP3_SHUTDOWN		0x00
> +#define OP3_OPERATION		0x80
> +#define OP2_MASK		0x40 /* Auto shutdown/Continuous operation  */
> +#define OP2_AUTO_SHUTDOWN	0x00
> +#define OP2_CONT_OPERATION	0x40
> +#define OP_MASK			0x30 /* Operating mode selection  */
> +#define OP_ALS_AND_PS		0x00
> +#define OP_ALS			0x10
> +#define OP_PS			0x20
> +#define OP_DEBUG		0x30
> +#define PROX_MASK		0x08 /* PS: detection/non-detection  */
> +#define PROX_NON_DETECT		0x00
> +#define PROX_DETECT		0x08
> +#define FLAG_P			0x04 /* PS: interrupt result  */
> +#define FLAG_A			0x02 /* ALS: interrupt result  */
> +#define TYPE_MASK		0x01 /* Output data type selection */
> +#define TYPE_MANUAL_CALC	0x00
> +#define TYPE_AUTO_CALC		0x01
> +
> +/* ALS_REG bits */
> +#define PRST_MASK		0xc0 /* Number of measurement cycles */
> +#define PRST_ONCE		0x00
> +#define PRST_4_CYCLES		0x40
> +#define PRST_8_CYCLES		0x80
> +#define PRST_16_CYCLES		0xc0
> +#define RES_A_MASK		0x38 /* ALS: Resolution (0.39ms - 800ms) */
> +#define RES_A_800ms		0x00
> +#define RES_A_400ms		0x08
> +#define RES_A_200ms		0x10
> +#define RES_A_100ms		0x18
> +#define RES_A_25ms		0x20
> +#define RES_A_6_25ms		0x28
> +#define RES_A_1_56ms		0x30
> +#define RES_A_0_39ms		0x38
> +#define RANGE_A_MASK		0x07 /* ALS: Max measurable range (x1 - x128) */
> +#define RANGE_A_x1		0x00
> +#define RANGE_A_x2		0x01
> +#define RANGE_A_x4		0x02
> +#define RANGE_A_x8		0x03
> +#define RANGE_A_x16		0x04
> +#define RANGE_A_x32		0x05
> +#define RANGE_A_x64		0x06
> +#define RANGE_A_x128		0x07
> +
> +/* PS_REG bits */
> +#define ALC_MASK		0x80 /* Auto light cancel */
> +#define ALC_ON			0x80
> +#define ALC_OFF			0x00
> +#define INTTYPE_MASK		0x40 /* Interrupt type setting */
> +#define INTTYPE_LEVEL		0x00
> +#define INTTYPE_PULSE		0x40
> +#define RES_P_MASK		0x38 /* PS: Resolution (0.39ms - 800ms)  */
> +#define RES_P_800ms_x2		0x00
> +#define RES_P_400ms_x2		0x08
> +#define RES_P_200ms_x2		0x10
> +#define RES_P_100ms_x2		0x18
> +#define RES_P_25ms_x2		0x20
> +#define RES_P_6_25ms_x2		0x28
> +#define RES_P_1_56ms_x2		0x30
> +#define RES_P_0_39ms_x2		0x38
> +#define RANGE_P_MASK		0x07 /* PS: Max measurable range (x1 - x128) */
> +#define RANGE_P_x1		0x00
> +#define RANGE_P_x2		0x01
> +#define RANGE_P_x4		0x02
> +#define RANGE_P_x8		0x03
> +#define RANGE_P_x16		0x04
> +#define RANGE_P_x32		0x05
> +#define RANGE_P_x64		0x06
> +#define RANGE_P_x128		0x07
> +
> +/* LED reg bits */
> +#define INTVAL_MASK		0xc0 /* Intermittent operating */
> +#define INTVAL_0		0x00
> +#define INTVAL_4		0x40
> +#define INTVAL_8		0x80
> +#define INTVAL_16		0xc0
> +#define IS_MASK			0x30 /* ILED drive peak current setting  */
> +#define IS_13_8mA		0x00
> +#define IS_27_5mA		0x10
> +#define IS_55mA			0x20
> +#define IS_110mA		0x30
> +#define PIN_MASK		0x0c /* INT terminal setting */
> +#define PIN_ALS_OR_PS		0x00
> +#define PIN_ALS			0x04
> +#define PIN_PS			0x08
> +#define PIN_PS_DETECT		0x0c
> +#define FREQ_MASK		0x02 /* LED modulation frequency */
> +#define FREQ_327_5kHz		0x00
> +#define FREQ_81_8kHz		0x02
> +#define RST			0x01 /* Software reset */
> +
> +#define SCAN_MODE_LIGHT_CLEAR	0
> +#define SCAN_MODE_LIGHT_IR	1
> +#define SCAN_MODE_PROXIMITY	2
> +#define CHAN_TIMESTAMP		3

The defines above should all have namespacing if possible.

> +
> +static unsigned long gp2ap002a00f_available_scan_masks[] = {
const

> +	0x01,
> +	0x02,
> +	0x04,

Maybe use BIT(SCAN_MODE_LIGHT_CLEAR), etc. to make this more clear

> +};
> +

> +
> +static int gp2ap002a00f_exec_cmd(struct gp2ap002a00f_data *data,
> +					enum gp2ap002a00f_cmd cmd)
> +{
> +	const u8 thresh_off_buf[2] = {0x00, 0x00};
> +	int err = 0;
> +
> +	switch (cmd) {
> +	case GP2AP002A00F_CMD_READ_RAW_CLEAR:
> +		if (data->cur_opmode != GP2AP002A00F_OPMODE_SHUTDOWN)
> +			return -EBUSY;
> +		err = gp2ap002a00f_set_operation_mode(data,
> +					GP2AP002A00F_CMD_READ_RAW_CLEAR);
> +		break;
> +	case GP2AP002A00F_CMD_READ_RAW_IR:
> +		if (data->cur_opmode != GP2AP002A00F_OPMODE_SHUTDOWN)
> +			return -EBUSY;
> +		err = gp2ap002a00f_set_operation_mode(data,
> +					GP2AP002A00F_CMD_READ_RAW_IR);
> +		break;
> +	case GP2AP002A00F_CMD_READ_RAW_PROXIMITY:
> +		if (data->cur_opmode != GP2AP002A00F_OPMODE_SHUTDOWN)
> +			return -EBUSY;
> +		err = gp2ap002a00f_set_operation_mode(data,
> +					GP2AP002A00F_CMD_READ_RAW_PROXIMITY);
> +		break;

There is a lot of copy'n paste here.

I think something like

	case GP2AP002A00F_CMD_READ_RAW_CLEAR:
	case GP2AP002A00F_CMD_READ_RAW_IR:
	case GP2AP002A00F_CMD_READ_RAW_PROXIMITY:
		if (data->cur_opmode != GP2AP002A00F_OPMODE_SHUTDOWN)
			return -EBUSY;
		err = gp2ap002a00f_set_operation_mode(data, cmd);
		break;
should also work.


>[...]
> +static int gp2ap002a00f_get_reg_cache_word(struct gp2ap002a00f_data *data,
> +					u8 reg_addr)
> +{
> +	return (data->reg_cache[reg_addr + 1] << 8) |
> +		data->reg_cache[reg_addr];
> +}

This looks like you want to use regmap.

> +
> +static irqreturn_t gp2ap002a00f_trigger_handler(int irq, void *data)
> +{
> +	struct iio_poll_func *pf = data;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct gp2ap002a00f_data *lgt = iio_priv(indio_dev);
> +	s64 time_ns;
> +	size_t d_size = 0;
> +	int i, ret;
> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask,
> +		indio_dev->masklength) {
> +		ret = i2c_smbus_read_i2c_block_data(lgt->client,
> +				GP2AP002A00F_DATA_REG(i), 2,
> +				&lgt->buffer[d_size]);
> +		if (ret < 0)
> +			goto done;
> +		d_size += 2;
> +	}
> +
> +	if (indio_dev->scan_timestamp)
> +		d_size += sizeof(s64);
> +
> +	lgt->buffer = kmalloc(d_size, GFP_KERNEL);

Does this make sense? You first write to the buffer in the loop above and
afterwards allocate it? The best is probably to allocate the buffer in
preenable, so you don't have to allocate and free a new buffer for each
transfer.

> +	if (lgt->buffer == NULL)
> +		goto done;
> +
> +	time_ns = iio_get_time_ns();
> +
> +	if (indio_dev->scan_timestamp)
> +		memcpy(lgt->buffer + d_size - sizeof(s64), &time_ns,
> +							sizeof(time_ns));
> +
> +	iio_push_to_buffers(indio_dev, lgt->buffer);
> +
> +	kfree(lgt->buffer);
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gp2ap002a00f_setup(struct gp2ap002a00f_data *data)
> +{
> +	int err = 0;
> +
> +	data->reg_cache[OP_REG] = OP3_SHUTDOWN;
> +	data->reg_cache[LED_REG] = INTVAL_0 | IS_110mA | FREQ_327_5kHz;
> +	data->reg_cache[ALS_REG] = RES_A_25ms | RANGE_A_x8;
> +	data->reg_cache[PS_REG] = ALC_ON | INTTYPE_LEVEL | RES_P_1_56ms_x2
> +				  | RANGE_P_x4;
> +
> +	err = i2c_smbus_write_i2c_block_data(data->client, OP_REG, REGS_NUM,
> +						&data->reg_cache[OP_REG]);
> +
> +	return err;
> +}
> +
> +static u8 get_reg_by_event_code(u64 event_code)
This needs namespacing

> +{
[...]
> +}
> +


> > +static const struct iio_buffer_setup_ops gp2ap002a00f_buffer_setup_ops = {
> +	.preenable = &gp2ap002a00f_buffer_preenable,
> +	.postenable = &iio_triggered_buffer_postenable,
> +	.predisable = &gp2ap002a00f_buffer_predisable,
> +};
> +
> +static int gp2ap002a00f_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct gp2ap002a00f_data *data;
> +	struct iio_dev *indio_dev;
> +	int err;
> +
> +	pr_info("gp2ap002a00f probe\n");
> +

The pr_info probably shouldn't be in the final version.

> +	/* Register with IIO */
> +	indio_dev = iio_device_alloc(sizeof(*data));
> +	if (indio_dev == NULL) {
> +		err = -ENOMEM;
> +		goto error_alloc;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +
> +	data->vled_reg = devm_regulator_get(&client->dev, "vled");
> +	if (IS_ERR(data->vled_reg)) {
> +		err = PTR_ERR(data->vled_reg);
> +		goto error_regulator_get;
> +	}
> +
> +	err = regulator_enable(data->vled_reg);
> +	if (err)
> +		goto error_free_data;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data->client = client;
> +	data->cur_opmode = GP2AP002A00F_OPMODE_SHUTDOWN;
> +
> +	init_waitqueue_head(&data->data_ready_queue);
> +
> +	err = gp2ap002a00f_setup(data);
> +	if (err < 0)
> +		goto error_free_data;
> +
> +	mutex_init(&data->lock);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = gp2ap002a00f_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(gp2ap002a00f_channels);
> +	indio_dev->info = &gp2ap002a00f_info;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = gp2ap002a00f_available_scan_masks;
> +
> +	err = iio_triggered_buffer_setup(indio_dev, NULL,
> +		&gp2ap002a00f_trigger_handler, &gp2ap002a00f_buffer_setup_ops);
> +
> +	err = devm_request_threaded_irq(&client->dev, client->irq,
> +				   &gp2ap002a00f_event_handler,
> +				   NULL,
> +				   IRQF_TRIGGER_FALLING,
> +				   "gp2ap002a00f_event",
> +				   indio_dev);

Using devm_... here means that the IRQ is freed after the data structures
which are used in the IRQ handler are used, so this will cause a
use-after-free bug.

> +	if (err < 0)
> +		goto error_uninit_buffer;
> +
> +	err = iio_device_register(indio_dev);
> +	if (err < 0)
> +		goto error_uninit_buffer;
> +
> +	return 0;
> +
> +error_uninit_buffer:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +error_free_data:
> +	regulator_disable(data->vled_reg);
> +error_regulator_get:
> +	iio_device_free(indio_dev);
> +error_alloc:
> +	return err;
> +}
> +
> +static int gp2ap002a00f_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct gp2ap002a00f_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	regulator_disable(data->vled_reg);
> +
> +	iio_device_free(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id gp2ap002a00f_id[] = {
> +	{ GP2A_I2C_NAME, 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, gp2ap002a00f_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id gp2ap002a00f_of_match[] = {
> +	{ .compatible = "sharp,gp2ap002a00f" },
> +	{ .compatible = "gp2ap002a00f" },

The second one obviously shouldn't be there.

> +	{ }
> +};
> +#endif
[...]
