Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38670 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbcADE7V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jan 2016 23:59:21 -0500
Received: by mail-wm0-f43.google.com with SMTP id b14so167862362wmb.1
        for <linux-iio@vger.kernel.org>; Sun, 03 Jan 2016 20:59:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0BBA92A2-6E6C-4CCA-A290-920CFB50FCAE@jic23.retrosnub.co.uk>
References: <CAAn_ec90t=N1e1m8aUcBZRb5wsRwiz56WUzFCWqTrVHHhcAuBA@mail.gmail.com>
	<566C0A32.3030104@kernel.org>
	<CAAn_ec_=9syP4j+g5GRMCB-+7vCWE1XqryE6KWUm=auUBZE=uQ@mail.gmail.com>
	<566C1493.7090002@jic23.retrosnub.co.uk>
	<CAAn_ec_5UcQ5GVFx=byU6sKJ9u33LmUzFvoRvVgTko4GfDHnOA@mail.gmail.com>
	<CAAn_ec8BMT9fPc06YOc14Eh+8vpQGJW_Lv-BOqDCqS5UbZF3iQ@mail.gmail.com>
	<7665C9F2-AA7C-404F-AC43-2D045E330030@jic23.retrosnub.co.uk>
	<CAAn_ec97uYM5vPogeRFFsfh8vUTb9H8SVrJYiWbBZmy9b9xBhQ@mail.gmail.com>
	<0BBA92A2-6E6C-4CCA-A290-920CFB50FCAE@jic23.retrosnub.co.uk>
Date: Mon, 4 Jan 2016 12:59:19 +0800
Message-ID: <CAAn_ec-UJn9DFt=HodPAVvmm4s_4zwq=DF8un8U2ngLB+XXNDw@mail.gmail.com>
Subject: Re: read /dev/iio:device0 return -1 (Invalid argument)
From: Julio Cruz <jcsistemas2001@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Previously, you help me about an issue related with data loss. You suggest
me to debug deep in the core elements. I will try to summarize the results
below for future reference.

When there is not data available in the buffer (kfifo), and the application
try to read data (using "read" function), it return zero (0).

If libiio will be used to read the data, there is a problem (detailed at
https://github.com/analogdevicesinc/libiio/issues/23). In brief, Paul
(pcercuei) suggest me that this issue must be manage by the driver, in this
case, return -EAGAIN when there is not data available [Resource temporarily
unavailable (POSIX.1)].

After review the core elements as suggested, I changed the line (in
function iio_read_first_n_kfifo of kfifo_buf.c) as below:

- return copied;
+ return copied == 0 ? -EAGAIN: copied;

Do you think will be OK like this?

Without this change, there is data loss (using libiio) because this will
drop data in the function read_all at local.c.

Thanks

On Sun, Dec 13, 2015 at 11:21 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 13 December 2015 14:42:08 GMT+00:00, Julio Cruz <jcsistemas2001@gmail.com> wrote:
>>Hi Jonathan,
>>
>>Below the content of all the files under scan_elements to check if
>>something is odd (using iio_info). I cannot distribute all the source
>>code, but I will re-make and share as below.
>>
>>Thanks again for any suggestion.
> Sorry, not spotted anything. I think you are going to need to chase the error through
>  the core elements.  There may well be a bug hiding there somewhere!
>
> J
>>
>>---------------------
>>Library version: 0.6 (git tag: 9d8aa76)
>>IIO context created with local backend.
>>Backend version: 0.6 (git tag: 9d8aa76)
>>Backend description string: Linux Board Custom
>>3.10.53-1.1.0_ga-boardcustom #94 SMP PREEMPT Sun Dec 13 16:17:57 CST
>>2015 armv7l
>>IIO context has 2 devices:
>>        trigger0: customdevice-dev0
>>                0 channels found:
>>        iio:device0: customdevice
>>                9 channels found:
>>                        voltage0: 0 (input)
>>                        3 channel-specific attributes found:
>>                                attr 0: en value: 1
>>                                attr 1: index value: 0
>>                                attr 2: type value: be:u24/32>>0
>>                        voltage1: 1 (input)
>>                        3 channel-specific attributes found:
>>                                attr 0: en value: 1
>>                                attr 1: type value: be:u24/32>>0
>>                                attr 2: index value: 1
>>                        voltage2: 2 (input)
>>                        3 channel-specific attributes found:
>>                                attr 0: en value: 1
>>                                attr 1: type value: be:u24/32>>0
>>                                attr 2: index value: 2
>>                        voltage3: 3 (input)
>>                        3 channel-specific attributes found:
>>                                attr 0: type value: be:u24/32>>0
>>                                attr 1: index value: 3
>>                                attr 2: en value: 1
>>                        voltage4: 4 (input)
>>                        3 channel-specific attributes found:
>>                                attr 0: en value: 1
>>                                attr 1: type value: be:u24/32>>0
>>                                attr 2: index value: 4
>>                        voltage5: 5 (input)
>>                        3 channel-specific attributes found:
>>                                attr 0: en value: 1
>>                                attr 1: index value: 5
>>                                attr 2: type value: be:u24/32>>0
>>                        voltage6: 6 (input)
>>                        3 channel-specific attributes found:
>>                                attr 0: index value: 6
>>                                attr 1: type value: be:u24/32>>0
>>                                attr 2: en value: 1
>>                        voltage7: 7 (input)
>>                        3 channel-specific attributes found:
>>                                attr 0: index value: 7
>>                                attr 1: type value: be:u24/32>>0
>>                                attr 2: en value: 1
>>                        voltage8: 8 (input)
>>                        3 channel-specific attributes found:
>>                                attr 0: index value: 8
>>                                attr 1: type value: be:u24/32>>0
>>                                attr 2: en value: 1
>>                1 device-specific attributes found:
>>                                attr 0: config1 value: 133
>>                Current trigger: trigger0(customde
>>---------------------
>>
>>--------------------
>>struct customdevice_state {
>>       struct spi_device       *spi;
>>
>>       bool sampling;
>>       bool irq_enabled;
>>
>>       uint8_t               *samples_data;
>>
>>       struct iio_trigger *trig;
>>
>>       struct mutex lock;
>>
>>
>>       /*
>>        * DMA (thus cache coherency maintenance) requires the
>>        * transfer buffers to live in their own cache lines.
>>        */
>>  uint8_t rx_buf[customdevice_SPI_MAX_FRAMESIZE] ____cacheline_aligned;
>>  uint8_t tx_buf[customdevice_SPI_MAX_FRAMESIZE] ____cacheline_aligned;
>>};
>>
>>static int customdevice_send_command(struct iio_dev *indio_dev,
>>unsigned char command)
>>{
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>       int ret;
>>
>>       if (iio_buffer_enabled(indio_dev))
>>              return -EBUSY;
>>
>>       mutex_lock(&st->lock);
>>       st->tx_buf[0] = command;
>>       ret = spi_write(st->spi, &st->tx_buf, 1);
>>       mutex_unlock(&st->lock);
>>
>>       return ret;
>>};
>>
>>static int customdevice_read_register(struct iio_dev *indio_dev,
>>unsigned char address,
>>       unsigned char *value)
>>{
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>       struct spi_transfer xfer;
>>       struct spi_message msg;
>>       int ret;
>>
>>       if (iio_buffer_enabled(indio_dev))
>>              return -EBUSY;
>>
>>       memset(&xfer, 0, sizeof(xfer));
>>       xfer.tx_buf = &st->tx_buf;
>>       xfer.rx_buf = &st->rx_buf;
>>       xfer.len = 3;
>>       xfer.delay_usecs = 2;
>>       xfer.cs_change = 0;
>>       xfer.bits_per_word = 8;
>>
>>       spi_message_init(&msg);
>>       spi_message_add_tail(&xfer, &msg);
>>
>>       mutex_lock(&st->lock);
>>       st->tx_buf[0] = customdevice_CMD_RREG | address;
>>       st->tx_buf[1] = 0;
>>       st->tx_buf[2] = 0;
>>       ret = spi_sync(st->spi, &msg);
>>       if (ret)
>>              goto out;
>>       *value = st->rx_buf[2];
>>out:
>>       mutex_unlock(&st->lock);
>>
>>       return ret;
>>};
>>
>>static int customdevice_write_register(struct iio_dev *indio_dev,
>>unsigned char address,
>>       unsigned char value)
>>{
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>       struct spi_transfer xfer;
>>       struct spi_message msg;
>>       int ret;
>>
>>       if (iio_buffer_enabled(indio_dev))
>>              return -EBUSY;
>>
>>       memset(&xfer, 0, sizeof(xfer));
>>       xfer.tx_buf = &st->tx_buf;
>>       xfer.rx_buf = &st->rx_buf;
>>       xfer.len = 3;
>>       xfer.delay_usecs = 2;
>>       xfer.cs_change = 0;
>>       xfer.bits_per_word = 8;
>>
>>       spi_message_init(&msg);
>>       spi_message_add_tail(&xfer, &msg);
>>
>>       mutex_lock(&st->lock);
>>       st->tx_buf[0] = customdevice_CMD_WREG | address;
>>       st->tx_buf[1] = 0;
>>       st->tx_buf[2] = value;
>>       ret = spi_sync(st->spi, &msg);
>>       if (ret)
>>              goto out;
>>out:
>>       mutex_unlock(&st->lock);
>>
>>       return ret;
>>};
>>
>>struct gpio customdevice_gpio_reset = { .label = "reset-gpio", .flags
>>= GPIOF_OUT_INIT_HIGH };
>>struct gpio customdevice_gpio_acquire = { .label = "acquire-gpio",
>>.flags =GPIOF_OUT_INIT_LOW };
>>
>>static void customdevice_reset_by_gpio(void)
>>{
>>       gpio_set_value_cansleep(customdevice_gpio_reset.gpio, 0);
>>       udelay(5);
>>       gpio_set_value_cansleep(customdevice_gpio_reset.gpio, 1);
>>       udelay(20);
>>       printk(KERN_ALERT "DEBUG: Passed %s %d GPIO setting
>>%s\n",__FUNCTION__,__LINE__, customdevice_gpio_reset.label);
>>}
>>
>>static void customdevice_acquire_by_gpio(bool enable)
>>{
>>       gpio_set_value_cansleep(customdevice_gpio_acquire.gpio, enable);
>>       printk(KERN_ALERT "DEBUG: Passed %s %d GPIO setting
>>%s\n",__FUNCTION__,__LINE__, customdevice_gpio_acquire.label);
>>}
>>
>>static int customdevice_init_io_from_dt(struct device *dev, struct gpio
>>*pgpio)
>>{
>>       struct device_node *np = dev->of_node;
>>
>>       int ret;
>>
>>       pgpio->gpio = of_get_named_gpio(np, pgpio->label, 0);
>>
>>       if (!gpio_is_valid(pgpio->gpio)) {
>>              return -EINVAL;
>>       } else {
>>              ret = devm_gpio_request_one(dev, pgpio->gpio,
>>pgpio->flags, pgpio->label);
>>              if (ret < 0) {
>>                     return ret;
>>              }
>>       }
>>
>>       return 0;
>>};
>>
>>static int customdevice_init_gpio_pins(struct iio_dev *indio_dev)
>>{
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>       struct device *dev = &st->spi->dev;
>>       int ret;
>>
>>     ret = customdevice_init_io_from_dt(dev, &customdevice_gpio_reset);
>>       printk(KERN_ALERT "DEBUG: Passed %s %d init GPIO RESET return
>>%d \n",__FUNCTION__,__LINE__, ret);
>>
>>   ret = customdevice_init_io_from_dt(dev, &customdevice_gpio_acquire);
>>       printk(KERN_ALERT "DEBUG: Passed %s %d init GPIO START return
>>%d \n",__FUNCTION__,__LINE__, ret);
>>       if (ret < 0)
>>              goto out;
>>
>>       gpio_set_value_cansleep(customdevice_gpio_acquire.gpio, 0);
>>       printk(KERN_ALERT "DEBUG: Passed %s %d GPIO setting
>>%s\n",__FUNCTION__,__LINE__, customdevice_gpio_acquire.label);
>>       gpio_set_value_cansleep(customdevice_gpio_reset.gpio, 1);
>>       printk(KERN_ALERT "DEBUG: Passed %s %d GPIO setting
>>%s\n",__FUNCTION__,__LINE__, customdevice_gpio_reset.label);
>>
>>       return 0;
>>
>>out:
>>       return ret;
>>};
>>#ifdef CONFIG_DEBUG_FS
>>static void customdevice_debugfs_init(struct iio_dev *indio_dev)
>>{
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>}
>>
>>static int customdevice_debugfs_reg_access(struct iio_dev *indio_dev,
>>                              unsigned reg, unsigned writeval,
>>                              unsigned *readval)
>>{
>>       unsigned char readdata;
>>       int ret;
>>
>>       if (readval == NULL) {
>>              printk(KERN_ALERT "DEBUG: Passed %s %d WRITE reg = %x
>>val = %x\n",__FUNCTION__,__LINE__, (unsigned char)reg, (unsigned
>>char)writeval);
>>              return customdevice_write_register(indio_dev, (unsigned
>>char)reg, (unsigned char)writeval);
>>       }
>>
>>       ret = customdevice_read_register(indio_dev, (unsigned char)reg,
>>&readdata);
>>       if (ret)
>>              return ret;
>>       *readval = (unsigned)readdata;
>>       printk(KERN_ALERT "DEBUG: Passed %s %d READ reg = %x val =
>>%x\n",__FUNCTION__,__LINE__, (unsigned char)reg, (unsigned
>>char)writeval);
>>       return 0;
>>}
>>
>>#else
>>
>>static inline void customdevice_debugfs_init(struct iio_dev *indio_dev)
>>{};
>>#define customdevice_debugfs_reg_access NULL
>>
>>#endif
>>
>>static int customdevice_startup(struct iio_dev *indio_dev, unsigned
>>long mask)
>>{
>>       unsigned char reg;
>>       int ret;
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>
>>       // enable conversions
>>       customdevice_acquire_by_gpio(true);
>>
>>       return 0;
>>}
>>
>>static int customdevice_shutdown(struct iio_dev *indio_dev)
>>{
>>       int ret;
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>
>>       // stop conversions
>>       customdevice_acquire_by_gpio(false);
>>
>>       return 0;
>>}
>>
>>static int customdevice_preenable(struct iio_dev *indio_dev)
>>{
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>       int ret;
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       ret = iio_sw_buffer_preenable(indio_dev);
>>       if (ret)
>>              return ret;
>>
>>   ret = customdevice_startup(indio_dev, *indio_dev->active_scan_mask);
>>       if (ret)
>>              return ret;
>>
>>       st->sampling = true;
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       return ret;
>>}
>>
>>static int customdevice_postenable(struct iio_dev *indio_dev)
>>{
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       iio_triggered_buffer_postenable(indio_dev);
>>
>>       if (st->spi->irq) {
>>              st->irq_enabled = true;
>>              enable_irq(st->spi->irq);
>>       }
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       return 0;
>>}
>>
>>static int customdevice_postdisable(struct iio_dev *indio_dev)
>>{
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       st->sampling = false;
>>
>>       return customdevice_shutdown(indio_dev);
>>}
>>
>>static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops
>>= {
>>       .preenable = &customdevice_preenable,
>>       .postenable = &customdevice_postenable,
>>       .predisable = &iio_triggered_buffer_predisable,
>>       .postdisable = &customdevice_postdisable,
>>};
>>
>>unsigned long int test = 0;
>>static irqreturn_t customdevice_trigger_handler(int irq, void *p)
>>{
>>       struct iio_poll_func *pf = p;
>>       struct iio_dev *indio_dev = pf->indio_dev;
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>       struct spi_transfer xfer;
>>       struct spi_message msg;
>>       int ret;
>>
>>       memset(&xfer, 0, sizeof(xfer));
>>       xfer.tx_buf = &st->tx_buf;
>>       xfer.rx_buf = &st->rx_buf;
>>xfer.len = indio_dev->num_channels*3; /*assuming all channels enabled*/
>>       xfer.delay_usecs = 2;
>>       xfer.cs_change = 0;
>>       xfer.bits_per_word = 8;
>>
>>       spi_message_init(&msg);
>>       spi_message_add_tail(&xfer, &msg);
>>       ret = spi_sync(st->spi, &msg);
>>       if (ret)
>>              goto err;
>>
>>       /* Unpacking data */
>>
>>       test++;
>>       st->samples_data[0] = (unsigned char)(test & 0xFF);
>>       st->samples_data[1] = (unsigned char)(test >> 8 & 0xFF);
>>       st->samples_data[2] = (unsigned char)(test >> 16 & 0xFF);
>>       st->samples_data[3] = (unsigned char)(test >> 24 & 0xFF);
>>
>>       iio_push_to_buffers(indio_dev, st->samples_data);
>>
>>err:
>>       iio_trigger_notify_done(indio_dev->trig);
>>       enable_irq(st->spi->irq);
>>
>>       return IRQ_HANDLED;
>>}
>>
>>static int customdevice_update_scan_mode(struct iio_dev *indio_dev,
>>       const unsigned long *scan_mask)
>>{
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>
>>       /* We have to make sure to output all zeros on the SDO line */
>>       memset(st->tx_buf, 0x00, customdevice_SPI_MAX_FRAMESIZE);
>>
>>       st->samples_data = krealloc(st->samples_data,
>>indio_dev->scan_bytes, GFP_KERNEL);
>>       if (!st->samples_data)
>>              return -ENOMEM;
>>
>>       return 0;
>>}
>>
>>// data leads channels
>>enum customdevice_channel_leads {
>>       CUSTOMDEVICE_1,
>>       CUSTOMDEVICE_2,
>>       CUSTOMDEVICE_3,
>>       CUSTOMDEVICE_4,
>>       CUSTOMDEVICE_5,
>>       CUSTOMDEVICE_6,
>>       CUSTOMDEVICE_7,
>>       CUSTOMDEVICE_8,
>>       CUSTOMDEVICE_9,
>>};
>>
>>#define customdevice_ADC_CHAN(_chan1, _scan_index, _extend_name) {
>> \
>>       .type = IIO_VOLTAGE,                            \
>>       .indexed = 1,                                   \
>>       .differential = 1,                            \
>>       .channel = (_chan1),                            \
>>       .scan_index = (_scan_index),                     \
>>       .scan_type = {                                   \
>>              .sign = 'u',                            \
>>              .realbits = 24,                            \
>>              .storagebits = 32,                     \
>>              .shift = 0,                            \
>>              .endianness = IIO_BE,                     \
>>       },                                          \
>>       .extend_name = (_extend_name),                     \
>>}
>>
>>static const struct iio_chan_spec customdevice_channels[] = {
>>       customdevice_ADC_CHAN(CUSTOMDEVICE_1, 0, "1"),
>>       customdevice_ADC_CHAN(CUSTOMDEVICE_2, 1, "2"),
>>       customdevice_ADC_CHAN(CUSTOMDEVICE_3, 2, "3"),
>>       customdevice_ADC_CHAN(CUSTOMDEVICE_4, 3, "4"),
>>       customdevice_ADC_CHAN(CUSTOMDEVICE_5, 4, "5"),
>>       customdevice_ADC_CHAN(CUSTOMDEVICE_6, 5, "6"),
>>       customdevice_ADC_CHAN(CUSTOMDEVICE_7, 6, "7"),
>>       customdevice_ADC_CHAN(CUSTOMDEVICE_8, 7, "8"),
>>       customdevice_ADC_CHAN(CUSTOMDEVICE_9, 8, "9"),
>>};
>>
>>static const struct iio_trigger_ops customdevice_trigger_ops = {
>>       .owner = THIS_MODULE,
>>};
>>
>>static irqreturn_t customdevice_trigger_irq(int irq, void *data)
>>{
>>       struct customdevice_state *st = data;
>>       struct iio_trigger *trig = st->trig;
>>
>>       if (!st->sampling) {
>>              disable_irq_nosync(irq);
>>              st->irq_enabled = false;
>>              return IRQ_HANDLED;
>>       }
>>
>>       iio_trigger_poll(trig, iio_get_time_ns());
>>       disable_irq_nosync(irq);
>>
>>       return IRQ_HANDLED;
>>}
>>
>>static struct iio_trigger *customdevice_allocate_trigger(struct
>>iio_dev *indio_dev,
>>       int irq)
>>{
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>       struct iio_trigger *trig;
>>       int ret;
>>
>>  trig = iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev->id);
>>       if (!trig)
>>              return NULL;
>>
>>       trig->dev.parent = indio_dev->dev.parent;
>>       trig->ops = &customdevice_trigger_ops;
>>
>>     ret = request_irq(irq, customdevice_trigger_irq, IRQF_TRIGGER_LOW,
>>                     trig->name, st);
>>       if (ret)
>>              return NULL;
>>
>>       indio_dev->trig = trig;
>>       iio_trigger_get(indio_dev->trig);
>>
>>       ret = iio_trigger_register(trig);
>>       if (ret) {
>>              free_irq(irq, trig);
>>              return NULL;
>>       }
>>
>>       return trig;
>>}
>>
>>
>>
>>static const struct iio_info customdevice_info = {
>>       .update_scan_mode = customdevice_update_scan_mode,
>>       .debugfs_reg_access = customdevice_debugfs_reg_access,
>>       .driver_module = THIS_MODULE,
>>};
>>
>>static int customdevice_inital_setup(struct iio_dev *indio_dev,
>>       struct customdevice_platform_data *pdata)
>>{
>>       int ret;
>>       unsigned char id;
>>
>>       ret = customdevice_init_gpio_pins(indio_dev);
>>       if (ret)
>>              return ret;
>>
>>       // reset device
>>       customdevice_reset_by_gpio();
>>       customdevice_acquire_by_gpio(false);
>>
>>       return ret;
>>}
>>
>>static int customdevice_probe(struct spi_device *spi)
>>{
>>     struct customdevice_platform_data *pdata = spi->dev.platform_data;
>>       struct iio_dev *indio_dev;
>>       struct customdevice_state *st;
>>       int ret;
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>
>>       indio_dev = iio_device_alloc(sizeof(*st));
>>       if (indio_dev == NULL)
>>              return -ENOMEM;
>>
>>       st = iio_priv(indio_dev);
>>
>>       mutex_init(&st->lock);
>>       spi_set_drvdata(spi, indio_dev);
>>       st->spi = spi;
>>
>>       indio_dev->dev.parent = &spi->dev;
>>       indio_dev->name = spi_get_device_id(spi)->name;
>>       indio_dev->modes = INDIO_DIRECT_MODE;
>>       indio_dev->info = &customdevice_info;
>>       indio_dev->channels = customdevice_channels;
>>       indio_dev->num_channels = ARRAY_SIZE(customdevice_channels);
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       ret = customdevice_inital_setup(indio_dev, pdata);
>>       if (ret)
>>              goto error_free;
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>  ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
>>       &customdevice_trigger_handler, &iio_triggered_buffer_setup_ops);
>>       if (ret)
>>              goto error_free;
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       st->irq_enabled = true;
>>       if (spi->irq)
>>         st->trig = customdevice_allocate_trigger(indio_dev, spi->irq);
>>
>>       ret = iio_device_register(indio_dev);
>>       if (ret)
>>              goto error_buffer_cleanup;
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       customdevice_debugfs_init(indio_dev);
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       return 0;
>>
>>error_buffer_cleanup:
>>       iio_triggered_buffer_cleanup(indio_dev);
>>error_free:
>>       iio_device_free(indio_dev);
>>
>>     printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
>>       return ret;
>>}
>>
>>static int customdevice_remove(struct spi_device *spi)
>>{
>>       struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>       struct customdevice_state *st = iio_priv(indio_dev);
>>
>>       iio_device_unregister(indio_dev);
>>       iio_triggered_buffer_cleanup(indio_dev);
>>       kfree(st->samples_data);
>>       mutex_destroy(&st->lock);
>>       iio_device_free(indio_dev);
>>
>>       return 0;
>>}
>>
>>static const struct of_device_id customdevice_dt_ids[] = {
>>       { .compatible = "customdevice" },
>>       { }
>>};
>>MODULE_DEVICE_TABLE(of, customdevice_dt_ids);
>>
>>static const struct spi_device_id customdevice_ids[] = {
>>       {"customdevice", 0},
>>       { }
>>};
>>MODULE_DEVICE_TABLE(spi, customdevice_ids);
>>
>>static struct spi_driver customdevice_driver = {
>>       .driver = {
>>              .name       = "customdevice",
>>              .owner       = THIS_MODULE,
>>              .of_match_table = of_match_ptr(customdevice_dt_ids),
>>       },
>>       .probe              = customdevice_probe,
>>       .remove              = customdevice_remove,
>>       .id_table       = customdevice_ids,
>>};
>>module_spi_driver(customdevice_driver);
>>--------------------
>>
>>On Sun, Dec 13, 2015 at 8:14 PM, Jonathan Cameron
>><jic23@jic23.retrosnub.co.uk> wrote:
>>>
>>>
>>> On 13 December 2015 10:44:29 GMT+00:00, Julio Cruz
>><jcsistemas2001@gmail.com> wrote:
>>>>Hi Jonathan,
>>>>
>>>>Right now, the app is able to read the data from /dev/iio:device0
>>with
>>>>success (not data loss). Currently, the app read 1 sample (with 9
>>>>channels of 4 bytes each one) every time (using "read" function).
>>>>
>>>>I still have some doubts about my implementation, because, sometimes
>>>>there is data lost.
>>>>
>>>>For example, when the app try to read more than 1 sample (for
>>example,
>>>>2 samples: 72 bytes, using "read"), the results are strange. For
>>>>instance, when the app is using libiio, the function
>>iio_buffer_refill
>>>>return -1 and is not able to receive data.
>>> That is definitely odd.
>>> Perhaps you could post the content of all the files under
>>scan_elements so we can
>>>  check nothing odd has happened with the channel definitions.
>>>
>>>
>>>  In this case, the buffer
>>>>(at iio_device_create_buffer) need to be setup with 1 sample to work.
>>>>
>>>>Below some assumptions/questions:
>>>>
>>>>- The buffer/length define the kfifo length (in samples, not in
>>>>bytes)?
>>> Number and of scans where a scan is one sample from all enabled
>>channels.
>>>
>>>> In this case, the buffer must be multiple of 36 bytes right?
>>> The one you are reading into should be.
>>>>- At user space, the application can read 36 bytes or more (i.e. 72,
>>>>...) (/dev/iio:device0) (but not less)? According with the buffer
>>>>length.
>>> Yes.
>>>
>>> So I have no idea what is going on. Can only suggest you add printks
>>to find out
>>>  what exactly is causing that error return
>>>
>>> Any chance you could post the driver?
>>>>
>>>>Thanks
>>>>
>>>>
>>>>On Sat, Dec 12, 2015 at 8:41 PM, Julio Cruz
>><jcsistemas2001@gmail.com>
>>>>wrote:
>>>>> OK, I understood! Thanks
>>>>>
>>>>> I will use 32 bits for storage in all the channels
>>>>>
>>>>> On Sat, Dec 12, 2015 at 8:35 PM, Jonathan Cameron
>>>>> <jic23@jic23.retrosnub.co.uk> wrote:
>>>>>> On 12/12/15 12:24, Julio Cruz wrote:
>>>>>>> HI Jonathan,
>>>>>> Hi Julio
>>>>>>
>>>>>> I've kept the list cc'd as this sort of conversation acts as
>>>>>> 'free' documentation solving other people's problems in future.
>>>>>>
>>>>>>>
>>>>>>> Thanks for your quick reply.
>>>>>>>
>>>>>>> When you mention the alignment, I remember some things that I did
>>>>>>> about it, as below.
>>>>>>>
>>>>>>> When I started testing the _trigger_handler, I found that the
>>>>driver
>>>>>>> calculate indio_dev->scan_bytes. This value is not clear to me
>>>>>>> because, for example, 1 channel is 3 bytes,
>>>>>> It shouldn't be. Padding is to the nearest power of 2 bytes so
>>>>should
>>>>>> be 4.  The non power of two realbits may have resulted in an
>>>>unexpected
>>>>>> path in which case we should add a sanity check to catch this.
>>>>>>> and for 2 channels is 8
>>>>>>> bytes (1 byte padding). The channel spec are realbits = 24 and
>>>>>>> storagebits = 24.
>>>>>> Storage bits should be a power of 2.  So in this case 32 bytes.
>>>>>> Might seem wasteful but processors handle aligned data a lot
>>>>>> more easily so to keep rates up it is usually better to burn a
>>small
>>>>>> amount of memory and keep everything aligned.
>>>>>>
>>>>>>  At that point, I fixed the frame buffer size to 27
>>>>>>> (used at iio_push_to_buffers) assuming that the same buffer could
>>>>be
>>>>>>> read at user space.
>>>>>>>
>>>>>>> Please, may I know if this approach is correct?
>>>>>> Sorry nope, the buffer structure assumes power of 2 alignment
>>>>everywhere.
>>>>>>>
>>>>>>> The SPI device send 9 channels, 3 bytes each one (for a total of
>>27
>>>>>>> bytes) and each channels is 24 bits width.
>>>>>> Unfortunately you'll have to do unpacking of this before pushing
>>to
>>>>the buffer.
>>>>>> It'll have to happen somewhere anyway (as userspace code would
>>need
>>>>to unpack
>>>>>> it otherwise).
>>>>>>
>>>>>> It's actually relatively unusual to find a device that does this
>>>>sort of
>>>>>> packing.  We have talked in the past about allowing this sort of
>>>>packing and
>>>>>> modifying the buffer infrastructure to accept it, but I'm
>>>>unconvinced that
>>>>>> it is worth the added complexity + cost in userspace complexity.
>>>>>>
>>>>>> Jonathan
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Julio
>>>>>>>
>>>>>>>
>>>>>>> On Sat, Dec 12, 2015 at 7:51 PM, Jonathan Cameron
>>>><jic23@kernel.org> wrote:
>>>>>>>> On 12/12/15 08:36, Julio Cruz wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I get an error trying to read /dev/iio:device0 in a custom
>>>>application
>>>>>>>>> (C/C++), however in a terminal the command "cat
>>/dev/iio_device0"
>>>>>>>>> return data.
>>>>>>>>>
>>>>>>>>> Below the procedure:
>>>>>>>>>
>>>>>>>>> - enable channels
>>>>>>>>> - setup trigger
>>>>>>>>> - setup buffer lenght
>>>>>>>>> - enable buffer (the SPI interrupt is setup properly and all
>>the
>>>>>>>>> trigger handler are done)
>>>>>>>>> - read /dev/iio_device0
>>>>>>>>>
>>>>>>>>> It's a SPI device acquiring 27 bytes @ 1KHz.
>>>>>>>> Reading this again after point 4 below this makes me ask the
>>>>question
>>>>>>>> what are you pushing into the buffer? 27 bytes seems unlikely
>>>>given
>>>>>>>> the alignment requirements.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Results:
>>>>>>>>>
>>>>>>>>> 1. Custom application (based on generic_buffer.c): function
>>>>'read'
>>>>>>>>> return -1 and strerror(errno) return "Invalid argument"
>>>>>>>>> 2. iio_readdev (libiio): show the message "Unable to refill
>>>>buffer:
>>>>>>>>> Input/output error"
>>>>>>>>> 3. In terminal, the command "cat /dev/iio_device0" show values
>>>>(no
>>>>>>>>> readable) while the buffer is enable.
>>>>>>>>>
>>>>>>>>> Any suggestion?
>>>>>>>>>
>>>>>>>>> Thanks for your help!
>>>>>>>> Sounds like you are ultimately getting that error from a call to
>>>>>>>>  iio_buffer_read_first_n_outer
>>>>>>>> so what can return -EINVAL (which is -1)?
>>>>>>>>
>>>>>>>> 1) Buffer not being allocated (seems unlikely - that's really
>>just
>>>>to
>>>>>>>> pick up on bugs in side the driver)
>>>>>>>> 2) read_first_n from the buffer not supplied - again not likely.
>>>>>>>> 3) wait_event_interruptible returns it - unlikely.
>>>>>>>> 4) read_first_n which comes from the buffer implementation is
>>>>returning -EINVAL
>>>>>>>> This last one seems most likely.
>>>>>>>>
>>>>>>>> So I am guessing you are using the kfifo buffer (most common
>>>>option).
>>>>>>>> Reasons this can return -EINVAL are
>>>>>>>> 1) kfifo not initialized (unlikely)
>>>>>>>> 2) Read length is less than the buffer element size (which is
>>the
>>>>full scan storage
>>>>>>>> size)
>>>>>>>> 3) an error from kfifo_to_user (unlikely)
>>>>>>>>
>>>>>>>> So I'm guessing you are reading too small an amount of data.
>>>>(tricky to chase
>>>>>>>> down without adding further printk's etc to the relevant bits of
>>>>kernel code)
>>>>>>>> If I've 'guessed' right, interesting question is how this came
>>>>about.
>>>>>>>> How many bytes is it trying to read?
>>>>>>>>
>>>>>>>> Note that IIO has strict alignment requirements - any element
>>must
>>>>be aligned
>>>>>>>> to it's own size and this will in some case add lots of padding.
>>>>The full buffer
>>>>>>>> element will be a multiple of the largest element in the scan.
>>If
>>>>you have a timestamp
>>>>>>>> for example at 64bits the whole buffer element will be a
>>multiple
>>>>of 8bytes.
>>>>>>>>
>>>>>>>> Jonathan
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>linux-iio" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at
>>>>http://vger.kernel.org/majordomo-info.html
>>>>>>>>>
>>>>>>>>
>>>>>>
>>>
>>> --
>>> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
