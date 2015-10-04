Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51383 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbJDP5s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 11:57:48 -0400
Subject: Re: [PATCH 6/7] staging:iio:dummy: Add DMA buffer support
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1443797107-13391-1-git-send-email-lars@metafoo.de>
 <1443797107-13391-7-git-send-email-lars@metafoo.de>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	Andrey Yurovsky <andrey@snupi.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56114C77.3070909@kernel.org>
Date: Sun, 4 Oct 2015 16:57:43 +0100
MIME-Version: 1.0
In-Reply-To: <1443797107-13391-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/10/15 15:45, Lars-Peter Clausen wrote:
> Add a DMA buffer implementation to the IIO dummy driver. Similar to the
> existing kfifo based dummy buffer implementation the buffer is not
> connected to any real hardware, but rather emulates its behavior.
> 
> The dummy DMA buffer is meant to be used as a template for implementing DMA
> buffer support and can also be used to test the generic IIO DMA buffer
> infrastructure without having access to hardware that has DMA capabilities.
> 
> The dummy driver is split into two parts. The first part emulates the
> behavior of a typical DMA controller and converter while the second part
> implement a typical device driver for such a system. The separation of the
> two parts is intentionally kept very strict to be to make it clear which
> parts will be found in a driver for real hardware and which parts will be
> performed by the hardware and will not be part of the driver.
> 
> The type of the buffer used by the IIO dummy device has to be chosen at
> compile time and can either be the old FIFO based software triggered buffer
> or the DMA buffer. Given that the dummy device driver is mainly intended
> for testing the framework and providing a simple example to be used as a
> template for new drivers it is not critical that the buffer type can be
> chosen or changed at runtime.
I almost wonder if it's worth building two modules. One with the kfifo and
one with the dma buffer.

This is mainly to avoid confusing the distros who will wonder which
'fake' option to chose.

Whilst most people who will be looking at building this will be driver
developers wanting an example to mess around with, I can also see
userspace developers wanting to mess around with both options.  The flow
of data out of them is obviously very different.

Not sure how fiddly it would be to do though...

Perhaps lets leave it like this for now and see if we get anyone
asking to be able to use both.

Very nice bit of example code.  Thanks for doing this alongside
the 'real' versions.

This whole series clearly wants to be on the list for a while.
With this in place I might actually fire up a VM and mess around with it :)

J
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/Kconfig                       |  31 +-
>  drivers/staging/iio/Makefile                      |   3 +-
>  drivers/staging/iio/iio_simple_dummy.c            |   3 +
>  drivers/staging/iio/iio_simple_dummy.h            |   8 +
>  drivers/staging/iio/iio_simple_dummy_buffer_dma.c | 470 ++++++++++++++++++++++
>  5 files changed, 513 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/staging/iio/iio_simple_dummy_buffer_dma.c
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index 6d5b38d..166bad1 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -38,10 +38,39 @@ config IIO_SIMPLE_DUMMY_EVENTS
>  config IIO_SIMPLE_DUMMY_BUFFER
>  	bool "Buffered capture support"
>  	select IIO_BUFFER
> +	help
> +	  Add buffered data capture to the simple dummy driver.
> +
> +choice
> +	prompt "Buffer type"
> +	default IIO_SIMPLE_DUMMY_BUFFER_KFIFO
> +	depends on IIO_SIMPLE_DUMMY_BUFFER
> +	help
> +	  Select the type of the buffer used by the simple dummy driver.
> +
> +config IIO_SIMPLE_DUMMY_BUFFER_KFIFO
> +	bool "Triggered FIFO"
>  	select IIO_TRIGGER
>  	select IIO_KFIFO_BUF
>  	help
> -	  Add buffered data capture to the simple dummy driver.
> +	  Triggered buffer utilizing a software FIFO where a software routine is
> +	  responsible for transferring data between the converter and the FIFO.
> +
> +	  No real hardware is used for the dummy driver and the converter is
> +	  emulated by software.
> +
> +config IIO_SIMPLE_DUMMY_BUFFER_DMA
> +	bool "DMA"
> +	depends on HAS_DMA
> +	select IIO_BUFFER_DMA
> +	help
> +	  DMA buffer where a DMA controller is responsible for transferring data
> +	  between the data and the buffers memory region.
> +
> +	  No real hardware is used for the dummy driver and the converter as well as
> +	  the DMA controller are emulated by software.
> +
> +endchoice
>  
>  endif # IIO_SIMPLE_DUMMY
>  
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index d871061..3e27056 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -5,7 +5,8 @@
>  obj-$(CONFIG_IIO_SIMPLE_DUMMY) += iio_dummy.o
>  iio_dummy-y := iio_simple_dummy.o
>  iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_EVENTS) += iio_simple_dummy_events.o
> -iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER) += iio_simple_dummy_buffer.o
> +iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER_KFIFO) += iio_simple_dummy_buffer.o
> +iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER_DMA) += iio_simple_dummy_buffer_dma.o
>  
>  obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
>  
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index 381f90f..1302c63 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -229,11 +229,13 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>  			.shift = 0, /* zero shift */
>  		},
>  	},
> +#ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER_KFIFO
>  	/*
>  	 * Convenience macro for timestamps. 4 is the index in
>  	 * the buffer.
>  	 */
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
> +#endif
>  	/* DAC channel out_voltage0_raw */
>  	{
>  		.type = IIO_VOLTAGE,
> @@ -531,6 +533,7 @@ static const struct iio_info iio_dummy_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &iio_dummy_read_raw,
>  	.write_raw = &iio_dummy_write_raw,
> +	.update_scan_mode = iio_simple_dummy_update_scan_mode,
>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>  	.read_event_config = &iio_simple_dummy_read_event_config,
>  	.write_event_config = &iio_simple_dummy_write_event_config,
> diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
> index 5c2f4d0..339b22f 100644
> --- a/drivers/staging/iio/iio_simple_dummy.h
> +++ b/drivers/staging/iio/iio_simple_dummy.h
> @@ -126,4 +126,12 @@ void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
>  {};
>  
>  #endif /* CONFIG_IIO_SIMPLE_DUMMY_BUFFER */
> +
> +#ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER_DMA
> +int iio_simple_dummy_update_scan_mode(struct iio_dev *indio_dev,
> +	const unsigned long *scan_mask);
> +#else
> +#define iio_simple_dummy_update_scan_mode NULL
> +#endif
> +
>  #endif /* _IIO_SIMPLE_DUMMY_H_ */
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer_dma.c b/drivers/staging/iio/iio_simple_dummy_buffer_dma.c
> new file mode 100644
> index 0000000..f4bdcbb
> --- /dev/null
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer_dma.c
> @@ -0,0 +1,470 @@
> +/*
> + * Copyright 2013-2015 Analog Devices Inc.
> + *  Author: Lars-Peter Clausen <lars@metafoo.de>
> + * based on iio_simple_dummy_buffer.c
> + *  Copyright (c) 2011 Jonathan Cameron
> + *
> + * Licensed under the GPL-2.
> +  */
> +
> +#include <linux/bitmap.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/export.h>
> +#include <linux/fixp-arith.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer-dma.h>
> +
> +#include "iio_simple_dummy.h"
> +
> +/*
> + * The dummy DMA buffer driver implements a buffer for the IIO simple dummy
> + * device driver. The buffer driver uses the generic IIO DMA buffer
> + * infrastructure and can be used as a template when implementing drivers using
> + * this infrastructure as well as for testing the infrastructure without any
> + * actual DMA capable hardware being present.
> + *
> + * This dummy driver is divided into two sections. The first part emulates the
> + * behavior of a multi-channel converter and the attached DMA filling a buffer
> + * with waveforms from the enabled channels. This part provides functions for
> + * setting up the "DMA" and the "converter".
> + *
> + * The second part implements the typical driver structure that you'd expect
> + * from a DMA buffer driver. It uses the functions provided by part 1 to perform
> + * the "hardware" access.
> + *
> + * When using this driver as a template part 1 can be ignored.
> + */
> +
> +typedef void (*iio_dummy_dma_source_fn)(unsigned int, unsigned int, void *);
> +
> +struct iio_dummy_dma_source {
> +	iio_dummy_dma_source_fn fn;
> +	unsigned int period;
> +	unsigned int pos;
> +};
> +
> +struct iio_dummy_dma_transfer {
> +	struct list_head head;
> +
> +	/* Memory address and length of the transfer */
> +	void *addr;
> +	unsigned int length;
> +
> +	/* Data passed to the IRQ callback when the transfer completes */
> +	void *irq_data;
> +};
> +
> +struct iio_dummy_dma {
> +	/* IRQ routine for the dummy DMA */
> +	void (*irq_fn)(unsigned int, void *);
> +
> +	/* Pending DMA transfers */
> +	struct mutex transfer_list_lock;
> +	struct list_head transfer_list;
> +
> +	/* Used to emulate periodic completion of DMA transfers */
> +	struct delayed_work work;
> +
> +	/* Information about the connected data sources */
> +	unsigned int num_sources;
> +	struct iio_dummy_dma_source sources[4];
> +};
> +
> +static void iio_dummy_dma_buffer_fn_rect(unsigned int n, unsigned int period,
> +	void *data)
> +{
> +	/* 13 bit unsigned */
> +	if (n > period / 2)
> +		*(uint16_t *)data = 1 << 12;
> +	else
> +		*(uint16_t *)data = 0;
> +}
> +
> +static void iio_dummy_dma_buffer_fn_sine(unsigned int n, unsigned int period,
> +	void *data)
> +{
> +	/* 12 bit signed */
> +	*(int16_t *)data = fixp_sin32_rad(n, period) >> 20;
> +}
> +
> +static void iio_dummy_dma_buffer_fn_tri(unsigned int n, unsigned int period,
> +	void *data)
> +{
> +	unsigned int x;
> +
> +	if (n > period / 2)
> +		x = period - n;
> +	else
> +		x = n;
> +
> +	/* 11 bit signed */
> +	*(int16_t *)data = ((((1 << 11) - 1) * x) / (period / 2)) - (1 << 10);
> +}
> +
> +static void iio_dummy_dma_buffer_fn_saw(unsigned int n, unsigned int period,
> +	void *data)
> +{
> +	/* 16 bit signed */
> +	*(int16_t *)data = ((((1 << 16) - 1) * n) / period) - (1 << 15);
> +}
> +
> +static const struct iio_dummy_dma_source iio_dummy_dma_sources[] = {
> +	{
> +		.fn = iio_dummy_dma_buffer_fn_rect,
> +		.period = 1000,
> +	}, {
> +		.fn = iio_dummy_dma_buffer_fn_sine,
> +		.period = 2000,
> +	}, {
> +		.fn = iio_dummy_dma_buffer_fn_tri,
> +		.period = 5000,
> +	}, {
> +		.fn = iio_dummy_dma_buffer_fn_saw,
> +		.period = 6789,
> +	},
> +};
> +
> +static void iio_dummy_dma_schedule_next(struct iio_dummy_dma *dma)
> +{
> +	struct iio_dummy_dma_transfer *transfer;
> +	unsigned int num_samples;
> +
> +	if (list_empty(&dma->transfer_list))
> +		return;
> +
> +	transfer = list_first_entry(&dma->transfer_list,
> +		struct iio_dummy_dma_transfer, head);
> +
> +	num_samples = transfer->length / (dma->num_sources * sizeof(uint16_t));
> +
> +	/* 10000 SPS */
> +	schedule_delayed_work(&dma->work, msecs_to_jiffies(num_samples / 10));
> +}
> +
> +static void iio_dummy_dma_work(struct work_struct *work)
> +{
> +	struct iio_dummy_dma *dma = container_of(work, struct iio_dummy_dma,
> +		work.work);
> +	struct iio_dummy_dma_transfer *transfer;
> +	struct iio_dummy_dma_source *src;
> +	unsigned int num_samples;
> +	unsigned int i, j;
> +	void *data;
> +
> +	/* Get the next pending transfer and then fill it with data. */
> +	mutex_lock(&dma->transfer_list_lock);
> +	transfer = list_first_entry(&dma->transfer_list,
> +		struct iio_dummy_dma_transfer, head);
> +	list_del(&transfer->head);
> +	iio_dummy_dma_schedule_next(dma);
> +	mutex_unlock(&dma->transfer_list_lock);
> +
> +	/*
> +	 * For real hardware copying of the data will be done by the DMA in the
> +	 * background. Here it is done in software.
> +	 */
> +	num_samples = transfer->length / (dma->num_sources * sizeof(uint16_t));
> +	data = transfer->addr;
> +	for (i = 0; i < num_samples; i++) {
> +		for (j = 0; j < dma->num_sources; j++) {
> +			src = &dma->sources[j];
> +			src->fn(src->pos, src->period, data);
> +			src->pos = (src->pos + 1) % src->period;
> +			data += 2;
> +		}
> +	}
> +
> +	/* Generate "interrupt" */
> +	dma->irq_fn(num_samples * dma->num_sources * sizeof(uint16_t),
> +		transfer->irq_data);
> +	kfree(transfer);
> +}
> +
> +static int iio_dummy_dma_issue_transfer(struct iio_dummy_dma *dma, void *addr,
> +	unsigned int length, void *irq_data)
> +{
> +	struct iio_dummy_dma_transfer *transfer;
> +
> +	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
> +	if (!transfer)
> +		return -ENOMEM;
> +
> +	transfer->addr = addr;
> +	transfer->length = length;
> +	transfer->irq_data = irq_data;
> +
> +	mutex_lock(&dma->transfer_list_lock);
> +	list_add_tail(&transfer->head, &dma->transfer_list);
> +
> +	/* Start "DMA" transfer */
> +	iio_dummy_dma_schedule_next(dma);
> +	mutex_unlock(&dma->transfer_list_lock);
> +
> +	return 0;
> +}
> +
> +static void iio_dummy_dma_stop(struct iio_dummy_dma *dma)
> +{
> +	mutex_lock(&dma->transfer_list_lock);
> +	cancel_delayed_work(&dma->work);
> +	INIT_LIST_HEAD(&dma->transfer_list);
> +	mutex_unlock(&dma->transfer_list_lock);
> +}
> +
> +static void iio_dummy_dma_setup(struct iio_dummy_dma *dma,
> +	void (*irq_fn)(unsigned int, void *))
> +{
> +	INIT_LIST_HEAD(&dma->transfer_list);
> +	mutex_init(&dma->transfer_list_lock);
> +	INIT_DELAYED_WORK(&dma->work, iio_dummy_dma_work);
> +	dma->irq_fn = irq_fn;
We could make this look even closer to real dma by
using an irq_work like we are doing in the event simulator...

Only really makes sense to do that if we split the 'fake dma
engine out to a separate file / module'.  Mind you I think
most people can get the idea without needing the formal
split. Lets see what others think.
> +}
> +
> +/*
> + * Part two: Typical DMA driver implementation.
> + */
> +
> +struct iio_dummy_dma_buffer {
> +	/* Generic IIO DMA buffer base struct */
> +	struct iio_dma_buffer_queue queue;
> +
> +	/* Handle to the "DMA" controller */
> +	struct iio_dummy_dma dma;
> +
> +	/* List of submitted blocks */
> +	struct list_head block_list;
> +};
> +
> +static struct iio_dummy_dma_buffer *iio_buffer_to_dummy_dma_buffer(
> +	struct iio_buffer *buffer)
> +{
> +	return container_of(buffer, struct iio_dummy_dma_buffer, queue.buffer);
> +}
> +
> +static void iio_dummy_dma_buffer_irq(unsigned int bytes_transferred,
> +	void *data)
> +{
> +	struct iio_dma_buffer_block *block = data;
> +	struct iio_dma_buffer_queue *queue = block->queue;
> +	unsigned long flags;
> +
> +	/* Protect against races with submit() */
> +	spin_lock_irqsave(&queue->list_lock, flags);
> +	list_del(&block->head);
> +	spin_unlock_irqrestore(&queue->list_lock, flags);
> +
> +	/*
> +	 * Update actual number of bytes transferred. This might be less than
> +	 * the requested number, e.g. due to alignment requirements of the
> +	 * controller, but must be a multiple of the sample size.
> +	 */
> +	block->bytes_used = bytes_transferred;
> +
> +	/*
> +	 * iio_dma_buffer_block_done() must be called after the DMA transfer for
> +	 * the block that has been completed. This will typically be done from
> +	 * some kind of completion interrupt routine or callback.
> +	 */
> +	iio_dma_buffer_block_done(block);
> +}
> +
> +static int iio_dummy_dma_buffer_submit(struct iio_dma_buffer_queue *queue,
> +	struct iio_dma_buffer_block *block)
> +{
> +	struct iio_dummy_dma_buffer *buffer =
> +		iio_buffer_to_dummy_dma_buffer(&queue->buffer);
> +	unsigned long flags;
> +	int ret;
> +
> +	/*
> +	 * submit() is called when the buffer is active and a block becomes
> +	 * available. It should start a DMA transfer for the submitted block as
> +	 * soon as possible. submit() can be called even when a DMA transfer is
> +	 * already active. This gives the driver to prepare and setup the next
This tells (or allows?) the driver
> +	 * transfer to allow a seamless switch to the next block without losing
> +	 * any samples.
> +	 */
> +
> +	spin_lock_irqsave(&queue->list_lock, flags);
> +	list_add(&block->head, &buffer->block_list);
> +	spin_unlock_irqrestore(&queue->list_lock, flags);
> +
> +	ret = iio_dummy_dma_issue_transfer(&buffer->dma, block->vaddr,
> +		block->size, block);
> +	if (ret) {
> +		spin_lock_irqsave(&queue->list_lock, flags);
> +		list_del(&block->head);
> +		spin_unlock_irqrestore(&queue->list_lock, flags);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void iio_dummy_dma_buffer_abort(struct iio_dma_buffer_queue *queue)
> +{
> +	struct iio_dummy_dma_buffer *buffer =
> +		iio_buffer_to_dummy_dma_buffer(&queue->buffer);
> +
> +	/*
> +	 * When abort() is called is is guaranteed that that submit() is not
> +	 * called again until abort() has completed. This means no new blocks
> +	 * will be added to the list. Once the pending DMA transfers are
> +	 * canceled no blocks will be removed either. So it is save to release
> +	 * the uncompleted blocks still on the list.
> +	 *
> +	 * If a DMA does not support aborting transfers it is OK to keep the
> +	 * currently active transfers running. In that case the blocks
> +	 * associated with the transfer must not be marked as done until they
> +	 * are completed.  Otherwise their memory might be freed while the DMA
> +	 * transfer is still in progress.
> +	 *
> +	 * Special care needs to be taken if the DMA controller does not
> +	 * support aborting transfers but the converter will stop sending
> +	 * samples once disabled. In this case the DMA might get stuck until the
> +	 * converter is re-enabled.
> +	 */
> +	iio_dummy_dma_stop(&buffer->dma);
> +
> +	/*
> +	 * None of the blocks are any longer in use at this point, give them
At this point, none of the blocks are still in use... (original doesn't
parse well!)
> +	 * back.
> +	 */
> +	iio_dma_buffer_block_list_abort(queue, &buffer->block_list);
> +}
> +
> +static void iio_dummy_dma_buffer_release(struct iio_buffer *buf)
> +{
> +	struct iio_dummy_dma_buffer *buffer =
> +		iio_buffer_to_dummy_dma_buffer(buf);
> +
> +	/*
> +	 * This function is called when all references to the buffer have been
> +	 * dropped should free any memory or other resources associated with the
> +	 * buffer.
> +	 */
> +
> +	/*
> +	 * iio_dma_buffer_release() must be called right before freeing the
> +	 * memory.
> +	 */
> +	iio_dma_buffer_release(&buffer->queue);
> +	kfree(buffer);
> +}
> +
> +/*
> + * Most drivers will be able to use the default DMA buffer callbacks. But if
> + * necessary it is possible to overwrite certain functions with custom
> + * implementations. One exception is the release callback, which always needs to
> + * be implemented.
> + */
> +static const struct iio_buffer_access_funcs iio_dummy_dma_buffer_ops = {
> +	.read_first_n = iio_dma_buffer_read,
> +	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
> +	.set_length = iio_dma_buffer_set_length,
> +	.request_update = iio_dma_buffer_request_update,
> +	.enable = iio_dma_buffer_enable,
> +	.disable = iio_dma_buffer_disable,
> +	.data_available = iio_dma_buffer_data_available,
> +	.release = iio_dummy_dma_buffer_release,
> +
> +	.modes = INDIO_BUFFER_HARDWARE,
> +	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
> +};
> +
> +static const struct iio_dma_buffer_ops iio_dummy_dma_buffer_dma_ops = {
> +	.submit = iio_dummy_dma_buffer_submit,
> +	.abort = iio_dummy_dma_buffer_abort,
> +};
> +
> +/**
> + * iio_simple_dummy_update_scan_mode() - Update active channels
> + * @indio_dev: The IIO device
> + * @scan_mask: Scan mask with the new active channels
> + */
> +int iio_simple_dummy_update_scan_mode(struct iio_dev *indio_dev,
> +	const unsigned long *scan_mask)
> +{
> +	struct iio_dummy_dma_buffer *buffer =
> +		iio_buffer_to_dummy_dma_buffer(indio_dev->buffer);
> +	struct iio_dummy_dma *dma = &buffer->dma;
> +	unsigned int i, j;
> +
> +	/*
> +	 * Setup the converter to output the selected channels to the DMA. For
> +	 * real hardware the connection between the converter and the DMA will
> +	 * be in hardware, here we use the struct to exchange this information.
> +	 */
> +	j = 0;
> +	for_each_set_bit(i, scan_mask, indio_dev->masklength) {
> +		dma->sources[j] = iio_dummy_dma_sources[i];
> +		j++;
> +	}
> +
> +	dma->num_sources = j;
> +
> +	return 0;
> +}
> +
> +int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
> +{
> +	struct iio_dummy_dma_buffer *buffer;
> +
> +	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Setup DMA controller. For real hardware this should acquire and setup
> +	 * all resources that are necessary to operate the DMA controller, like
> +	 * IRQs, clocks, IO mem regions, etc.
> +	 */
> +	iio_dummy_dma_setup(&buffer->dma, iio_dummy_dma_buffer_irq);
> +
> +	/*
> +	 * For a real device the device passed to iio_dma_buffer_init() must be
> +	 * the device that performs the DMA transfers. Often this is not the
> +	 * device for the converter, but a dedicated DMA controller.
> +	 */
> +	dma_coerce_mask_and_coherent(&indio_dev->dev, DMA_BIT_MASK(32));
> +	iio_dma_buffer_init(&buffer->queue, &indio_dev->dev,
> +		&iio_dummy_dma_buffer_dma_ops);
> +	buffer->queue.buffer.access = &iio_dummy_dma_buffer_ops;
> +
> +	INIT_LIST_HEAD(&buffer->block_list);
> +
> +	indio_dev->buffer = &buffer->queue.buffer;
> +	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
> +
> +	return 0;
> +}
> +
> +/**
> + * iio_dummy_dma_unconfigure_buffer() - release buffer resources
> + * @indio_dev: device instance state
> + */
> +void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
> +{
> +	struct iio_dummy_dma_buffer *buffer =
> +		iio_buffer_to_dummy_dma_buffer(indio_dev->buffer);
> +
> +	/*
> +	 * Once iio_dma_buffer_exit() has been called none of the DMA buffer
> +	 * callbacks will be called. This means it is save to free any resources
> +	 * that are only used in those callbacks at this point. The memory for
> +	 * the buffer struct must not be freed since it might be still in use
> +	 * elsewhere. It will be freed in the buffers release callback.
> +	 */
> +	iio_dma_buffer_exit(&buffer->queue);
> +
> +	/*
> +	 * Drop our reference to the buffer. Since this might be the last one
> +	 * the buffer structure must no longer be accessed after this.
> +	 */
> +	iio_buffer_put(&buffer->queue.buffer);
> +}
> 

