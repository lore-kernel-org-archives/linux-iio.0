Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59537 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbbJYNz0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 09:55:26 -0400
Subject: Re: [PATCH v3 5/6] iio: Add generic DMA buffer infrastructure
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1444752629-3532-1-git-send-email-lars@metafoo.de>
 <1444752629-3532-6-git-send-email-lars@metafoo.de>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CDF4B.9040404@kernel.org>
Date: Sun, 25 Oct 2015 13:55:23 +0000
MIME-Version: 1.0
In-Reply-To: <1444752629-3532-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/10/15 17:10, Lars-Peter Clausen wrote:
> The traditional approach used in IIO to implement buffered capture requires
> the generation of at least one interrupt per sample. In the interrupt
> handler the driver reads the sample from the device and copies it to a
> software buffer. This approach has a rather large per sample overhead
> associated with it. And while it works fine for samplerates in the range of
> up to 1000 samples per second it starts to consume a rather large share of
> the available CPU processing time once we go beyond that, this is
> especially true on an embedded system with limited processing power. The
> regular interrupt also causes increased power consumption by not allowing
> the hardware into deeper sleep states, which is something that becomes more
> and more important on mobile battery powered devices.
> 
> And while the recently added watermark support mitigates some of the issues
> by allowing the device to generate interrupts at a rate lower than the data
> output rate, this still requires a storage buffer inside the device and
> even if it exists it is only a few 100 samples deep at most.
> 
> DMA support on the other hand allows to capture multiple millions or even
> more samples without any CPU interaction. This allows the CPU to either go
> to sleep for longer periods or focus on other tasks which increases overall
> system performance and power consumption. In addition to that some devices
> might not even offer a way to read the data other than using DMA, which
> makes DMA mandatory to use for them.
> 
> The tasks involved in implementing a DMA buffer can be divided into two
> categories. The first category is memory buffer management (allocation,
> mapping, etc.) and hooking this up the IIO buffer callbacks like read(),
> enable(), disable(), etc. The second category of tasks is to setup the
> DMA hardware and manage the DMA transfers. Tasks from the first category
> will be very similar for all IIO drivers supporting DMA buffers, while the
> tasks from the second category will be hardware specific.
> 
> This patch implements a generic infrastructure that take care of the former
> tasks. It provides a set of functions that implement the standard IIO
> buffer iio_buffer_access_funcs callbacks. These can either be used as is or
> be overloaded and augmented with driver specific code where necessary.
> 
> For the DMA buffer support infrastructure that is introduced in this series
> sample data is grouped by so called blocks. A block is the basic unit at
> which data is exchanged between the application and the hardware. The
> application is responsible for allocating the memory associated with the
> block and then passes the block to the hardware. When the hardware has
> captured the amount of samples equal to size of a block it will notify the
> application, which can then read the data from the block and process it.
> The block size can freely chosen (within the constraints of the hardware).
> This allows to make a trade-off between latency and management overhead.
> The larger the block size the lower the per sample overhead but the latency
> between when the data was captured and when the application will be able to
> access it increases, in a similar way smaller block sizes have a larger per
> sample management overhead but a lower latency. The ideal block size thus
> depends on system and application requirements.
> 
> For the time being the infrastructure only implements a simple double
> buffered scheme which allocates two blocks each with half the size of the
> configured buffer size. This provides basic support for capturing
> continuous uninterrupted data over the existing file-IO ABI. Future
> extensions to the DMA buffer infrastructure will give applications a more
> fine grained control over how many blocks are allocated and the size of
> each block. But this requires userspace ABI additions which are
> intentionally not part of this patch and will be added separately.
> 
> Tasks of the second category need to be implemented by a device specific
> driver. They can be hooked up into the generic infrastructure using two
> simple callbacks, submit() and abort().
> 
> The submit() callback is used to schedule DMA transfers for blocks. Once a
> DMA transfer has been completed it is expected that the buffer driver calls
> iio_dma_buffer_block_done() to notify. The abort() callback is used for
> stopping all pending and active DMA transfers when the buffer is disabled.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
I like this stuff a lot.  Good to have it in and am looking forward to seeing
just how many devices can actually support this stuff.

Anyhow,

Applied.
> ---
>  drivers/iio/buffer/Kconfig                   |   9 +
>  drivers/iio/buffer/Makefile                  |   1 +
>  drivers/iio/buffer/industrialio-buffer-dma.c | 683 +++++++++++++++++++++++++++
>  include/linux/iio/buffer-dma.h               | 152 ++++++
>  4 files changed, 845 insertions(+)
>  create mode 100644 drivers/iio/buffer/industrialio-buffer-dma.c
>  create mode 100644 include/linux/iio/buffer-dma.h
> 
> diff --git a/drivers/iio/buffer/Kconfig b/drivers/iio/buffer/Kconfig
> index 0a7b2fd..b2fda1a 100644
> --- a/drivers/iio/buffer/Kconfig
> +++ b/drivers/iio/buffer/Kconfig
> @@ -9,6 +9,15 @@ config IIO_BUFFER_CB
>  	  Should be selected by any drivers that do in-kernel push
>  	  usage.  That is, those where the data is pushed to the consumer.
>  
> +config IIO_BUFFER_DMA
> +	tristate
> +	help
> +	  Provides the generic IIO DMA buffer infrastructure that can be used by
> +	  drivers for devices with DMA support to implement the IIO buffer.
> +
> +	  Should be selected by drivers that want to use the generic DMA buffer
> +	  infrastructure.
> +
>  config IIO_KFIFO_BUF
>  	tristate "Industrial I/O buffering based on kfifo"
>  	help
> diff --git a/drivers/iio/buffer/Makefile b/drivers/iio/buffer/Makefile
> index 4d193b9..bda3f11 100644
> --- a/drivers/iio/buffer/Makefile
> +++ b/drivers/iio/buffer/Makefile
> @@ -4,5 +4,6 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_IIO_BUFFER_CB) += industrialio-buffer-cb.o
> +obj-$(CONFIG_IIO_BUFFER_DMA) += industrialio-buffer-dma.o
>  obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
>  obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> new file mode 100644
> index 0000000..212cbed
> --- /dev/null
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -0,0 +1,683 @@
> +/*
> + * Copyright 2013-2015 Analog Devices Inc.
> + *  Author: Lars-Peter Clausen <lars@metafoo.de>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/workqueue.h>
> +#include <linux/mutex.h>
> +#include <linux/sched.h>
> +#include <linux/poll.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dma.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/sizes.h>
> +
> +/*
> + * For DMA buffers the storage is sub-divided into so called blocks. Each block
> + * has its own memory buffer. The size of the block is the granularity at which
> + * memory is exchanged between the hardware and the application. Increasing the
> + * basic unit of data exchange from one sample to one block decreases the
> + * management overhead that is associated with each sample. E.g. if we say the
> + * management overhead for one exchange is x and the unit of exchange is one
> + * sample the overhead will be x for each sample. Whereas when using a block
> + * which contains n samples the overhead per sample is reduced to x/n. This
> + * allows to achieve much higher samplerates than what can be sustained with
> + * the one sample approach.
> + *
> + * Blocks are exchanged between the DMA controller and the application via the
> + * means of two queues. The incoming queue and the outgoing queue. Blocks on the
> + * incoming queue are waiting for the DMA controller to pick them up and fill
> + * them with data. Block on the outgoing queue have been filled with data and
> + * are waiting for the application to dequeue them and read the data.
> + *
> + * A block can be in one of the following states:
> + *  * Owned by the application. In this state the application can read data from
> + *    the block.
> + *  * On the incoming list: Blocks on the incoming list are queued up to be
> + *    processed by the DMA controller.
> + *  * Owned by the DMA controller: The DMA controller is processing the block
> + *    and filling it with data.
> + *  * On the outgoing list: Blocks on the outgoing list have been successfully
> + *    processed by the DMA controller and contain data. They can be dequeued by
> + *    the application.
> + *  * Dead: A block that is dead has been marked as to be freed. It might still
> + *    be owned by either the application or the DMA controller at the moment.
> + *    But once they are done processing it instead of going to either the
> + *    incoming or outgoing queue the block will be freed.
> + *
> + * In addition to this blocks are reference counted and the memory associated
> + * with both the block structure as well as the storage memory for the block
> + * will be freed when the last reference to the block is dropped. This means a
> + * block must not be accessed without holding a reference.
> + *
> + * The iio_dma_buffer implementation provides a generic infrastructure for
> + * managing the blocks.
> + *
> + * A driver for a specific piece of hardware that has DMA capabilities need to
> + * implement the submit() callback from the iio_dma_buffer_ops structure. This
> + * callback is supposed to initiate the DMA transfer copying data from the
> + * converter to the memory region of the block. Once the DMA transfer has been
> + * completed the driver must call iio_dma_buffer_block_done() for the completed
> + * block.
> + *
> + * Prior to this it must set the bytes_used field of the block contains
> + * the actual number of bytes in the buffer. Typically this will be equal to the
> + * size of the block, but if the DMA hardware has certain alignment requirements
> + * for the transfer length it might choose to use less than the full size. In
> + * either case it is expected that bytes_used is a multiple of the bytes per
> + * datum, i.e. the block must not contain partial samples.
> + *
> + * The driver must call iio_dma_buffer_block_done() for each block it has
> + * received through its submit_block() callback, even if it does not actually
> + * perform a DMA transfer for the block, e.g. because the buffer was disabled
> + * before the block transfer was started. In this case it should set bytes_used
> + * to 0.
> + *
> + * In addition it is recommended that a driver implements the abort() callback.
> + * It will be called when the buffer is disabled and can be used to cancel
> + * pending and stop active transfers.
> + *
> + * The specific driver implementation should use the default callback
> + * implementations provided by this module for the iio_buffer_access_funcs
> + * struct. It may overload some callbacks with custom variants if the hardware
> + * has special requirements that are not handled by the generic functions. If a
> + * driver chooses to overload a callback it has to ensure that the generic
> + * callback is called from within the custom callback.
> + */
> +
> +static void iio_buffer_block_release(struct kref *kref)
> +{
> +	struct iio_dma_buffer_block *block = container_of(kref,
> +		struct iio_dma_buffer_block, kref);
> +
> +	WARN_ON(block->state != IIO_BLOCK_STATE_DEAD);
> +
> +	dma_free_coherent(block->queue->dev, PAGE_ALIGN(block->size),
> +					block->vaddr, block->phys_addr);
> +
> +	iio_buffer_put(&block->queue->buffer);
> +	kfree(block);
> +}
> +
> +static void iio_buffer_block_get(struct iio_dma_buffer_block *block)
> +{
> +	kref_get(&block->kref);
> +}
> +
> +static void iio_buffer_block_put(struct iio_dma_buffer_block *block)
> +{
> +	kref_put(&block->kref, iio_buffer_block_release);
> +}
> +
> +/*
> + * dma_free_coherent can sleep, hence we need to take some special care to be
> + * able to drop a reference from an atomic context.
> + */
> +static LIST_HEAD(iio_dma_buffer_dead_blocks);
> +static DEFINE_SPINLOCK(iio_dma_buffer_dead_blocks_lock);
> +
> +static void iio_dma_buffer_cleanup_worker(struct work_struct *work)
> +{
> +	struct iio_dma_buffer_block *block, *_block;
> +	LIST_HEAD(block_list);
> +
> +	spin_lock_irq(&iio_dma_buffer_dead_blocks_lock);
> +	list_splice_tail_init(&iio_dma_buffer_dead_blocks, &block_list);
> +	spin_unlock_irq(&iio_dma_buffer_dead_blocks_lock);
> +
> +	list_for_each_entry_safe(block, _block, &block_list, head)
> +		iio_buffer_block_release(&block->kref);
> +}
> +static DECLARE_WORK(iio_dma_buffer_cleanup_work, iio_dma_buffer_cleanup_worker);
> +
> +static void iio_buffer_block_release_atomic(struct kref *kref)
> +{
> +	struct iio_dma_buffer_block *block;
> +	unsigned long flags;
> +
> +	block = container_of(kref, struct iio_dma_buffer_block, kref);
> +
> +	spin_lock_irqsave(&iio_dma_buffer_dead_blocks_lock, flags);
> +	list_add_tail(&block->head, &iio_dma_buffer_dead_blocks);
> +	spin_unlock_irqrestore(&iio_dma_buffer_dead_blocks_lock, flags);
> +
> +	schedule_work(&iio_dma_buffer_cleanup_work);
> +}
> +
> +/*
> + * Version of iio_buffer_block_put() that can be called from atomic context
> + */
> +static void iio_buffer_block_put_atomic(struct iio_dma_buffer_block *block)
> +{
> +	kref_put(&block->kref, iio_buffer_block_release_atomic);
> +}
> +
> +static struct iio_dma_buffer_queue *iio_buffer_to_queue(struct iio_buffer *buf)
> +{
> +	return container_of(buf, struct iio_dma_buffer_queue, buffer);
> +}
> +
> +static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
> +	struct iio_dma_buffer_queue *queue, size_t size)
> +{
> +	struct iio_dma_buffer_block *block;
> +
> +	block = kzalloc(sizeof(*block), GFP_KERNEL);
> +	if (!block)
> +		return NULL;
> +
> +	block->vaddr = dma_alloc_coherent(queue->dev, PAGE_ALIGN(size),
> +		&block->phys_addr, GFP_KERNEL);
> +	if (!block->vaddr) {
> +		kfree(block);
> +		return NULL;
> +	}
> +
> +	block->size = size;
> +	block->state = IIO_BLOCK_STATE_DEQUEUED;
> +	block->queue = queue;
> +	INIT_LIST_HEAD(&block->head);
> +	kref_init(&block->kref);
> +
> +	iio_buffer_get(&queue->buffer);
> +
> +	return block;
> +}
> +
> +static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
> +{
> +	struct iio_dma_buffer_queue *queue = block->queue;
> +
> +	/*
> +	 * The buffer has already been freed by the application, just drop the
> +	 * reference.
> +	 */
> +	if (block->state != IIO_BLOCK_STATE_DEAD) {
> +		block->state = IIO_BLOCK_STATE_DONE;
> +		list_add_tail(&block->head, &queue->outgoing);
> +	}
> +}
> +
> +/**
> + * iio_dma_buffer_block_done() - Indicate that a block has been completed
> + * @block: The completed block
> + *
> + * Should be called when the DMA controller has finished handling the block to
> + * pass back ownership of the block to the queue.
> + */
> +void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
> +{
> +	struct iio_dma_buffer_queue *queue = block->queue;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&queue->list_lock, flags);
> +	_iio_dma_buffer_block_done(block);
> +	spin_unlock_irqrestore(&queue->list_lock, flags);
> +
> +	iio_buffer_block_put_atomic(block);
> +	wake_up_interruptible_poll(&queue->buffer.pollq, POLLIN | POLLRDNORM);
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_block_done);
> +
> +/**
> + * iio_dma_buffer_block_list_abort() - Indicate that a list block has been
> + *   aborted
> + * @queue: Queue for which to complete blocks.
> + * @list: List of aborted blocks. All blocks in this list must be from @queue.
> + *
> + * Typically called from the abort() callback after the DMA controller has been
> + * stopped. This will set bytes_used to 0 for each block in the list and then
> + * hand the blocks back to the queue.
> + */
> +void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
> +	struct list_head *list)
> +{
> +	struct iio_dma_buffer_block *block, *_block;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&queue->list_lock, flags);
> +	list_for_each_entry_safe(block, _block, list, head) {
> +		list_del(&block->head);
> +		block->bytes_used = 0;
> +		_iio_dma_buffer_block_done(block);
> +		iio_buffer_block_put_atomic(block);
> +	}
> +	spin_unlock_irqrestore(&queue->list_lock, flags);
> +
> +	wake_up_interruptible_poll(&queue->buffer.pollq, POLLIN | POLLRDNORM);
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_block_list_abort);
> +
> +static bool iio_dma_block_reusable(struct iio_dma_buffer_block *block)
> +{
> +	/*
> +	 * If the core owns the block it can be re-used. This should be the
> +	 * default case when enabling the buffer, unless the DMA controller does
> +	 * not support abort and has not given back the block yet.
> +	 */
> +	switch (block->state) {
> +	case IIO_BLOCK_STATE_DEQUEUED:
> +	case IIO_BLOCK_STATE_QUEUED:
> +	case IIO_BLOCK_STATE_DONE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/**
> + * iio_dma_buffer_request_update() - DMA buffer request_update callback
> + * @buffer: The buffer which to request an update
> + *
> + * Should be used as the iio_dma_buffer_request_update() callback for
> + * iio_buffer_access_ops struct for DMA buffers.
> + */
> +int iio_dma_buffer_request_update(struct iio_buffer *buffer)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +	struct iio_dma_buffer_block *block;
> +	bool try_reuse = false;
> +	size_t size;
> +	int ret = 0;
> +	int i;
> +
> +	/*
> +	 * Split the buffer into two even parts. This is used as a double
> +	 * buffering scheme with usually one block at a time being used by the
> +	 * DMA and the other one by the application.
> +	 */
> +	size = DIV_ROUND_UP(queue->buffer.bytes_per_datum *
> +		queue->buffer.length, 2);
> +
> +	mutex_lock(&queue->lock);
> +
> +	/* Allocations are page aligned */
> +	if (PAGE_ALIGN(queue->fileio.block_size) == PAGE_ALIGN(size))
> +		try_reuse = true;
> +
> +	queue->fileio.block_size = size;
> +	queue->fileio.active_block = NULL;
> +
> +	spin_lock_irq(&queue->list_lock);
> +	for (i = 0; i < 2; i++) {
> +		block = queue->fileio.blocks[i];
> +
> +		/* If we can't re-use it free it */
> +		if (block && (!iio_dma_block_reusable(block) || !try_reuse))
> +			block->state = IIO_BLOCK_STATE_DEAD;
> +	}
> +
> +	/*
> +	 * At this point all blocks are either owned by the core or marked as
> +	 * dead. This means we can reset the lists without having to fear
> +	 * corrution.
> +	 */
> +	INIT_LIST_HEAD(&queue->outgoing);
> +	spin_unlock_irq(&queue->list_lock);
> +
> +	INIT_LIST_HEAD(&queue->incoming);
> +
> +	for (i = 0; i < 2; i++) {
> +		if (queue->fileio.blocks[i]) {
> +			block = queue->fileio.blocks[i];
> +			if (block->state == IIO_BLOCK_STATE_DEAD) {
> +				/* Could not reuse it */
> +				iio_buffer_block_put(block);
> +				block = NULL;
> +			} else {
> +				block->size = size;
> +			}
> +		} else {
> +			block = NULL;
> +		}
> +
> +		if (!block) {
> +			block = iio_dma_buffer_alloc_block(queue, size);
> +			if (!block) {
> +				ret = -ENOMEM;
> +				goto out_unlock;
> +			}
> +			queue->fileio.blocks[i] = block;
> +		}
> +
> +		block->state = IIO_BLOCK_STATE_QUEUED;
> +		list_add_tail(&block->head, &queue->incoming);
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&queue->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_request_update);
> +
> +static void iio_dma_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> +	struct iio_dma_buffer_block *block)
> +{
> +	int ret;
> +
> +	/*
> +	 * If the hardware has already been removed we put the block into
> +	 * limbo. It will neither be on the incoming nor outgoing list, nor will
> +	 * it ever complete. It will just wait to be freed eventually.
> +	 */
> +	if (!queue->ops)
> +		return;
> +
> +	block->state = IIO_BLOCK_STATE_ACTIVE;
> +	iio_buffer_block_get(block);
> +	ret = queue->ops->submit(queue, block);
> +	if (ret) {
> +		/*
> +		 * This is a bit of a problem and there is not much we can do
> +		 * other then wait for the buffer to be disabled and re-enabled
> +		 * and try again. But it should not really happen unless we run
> +		 * out of memory or something similar.
> +		 *
> +		 * TODO: Implement support in the IIO core to allow buffers to
> +		 * notify consumers that something went wrong and the buffer
> +		 * should be disabled.
> +		 */
> +		iio_buffer_block_put(block);
> +	}
> +}
> +
> +/**
> + * iio_dma_buffer_enable() - Enable DMA buffer
> + * @buffer: IIO buffer to enable
> + * @indio_dev: IIO device the buffer is attached to
> + *
> + * Needs to be called when the device that the buffer is attached to starts
> + * sampling. Typically should be the iio_buffer_access_ops enable callback.
> + *
> + * This will allocate the DMA buffers and start the DMA transfers.
> + */
> +int iio_dma_buffer_enable(struct iio_buffer *buffer,
> +	struct iio_dev *indio_dev)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +	struct iio_dma_buffer_block *block, *_block;
> +
> +	mutex_lock(&queue->lock);
> +	queue->active = true;
> +	list_for_each_entry_safe(block, _block, &queue->incoming, head) {
> +		list_del(&block->head);
> +		iio_dma_buffer_submit_block(queue, block);
> +	}
> +	mutex_unlock(&queue->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_enable);
> +
> +/**
> + * iio_dma_buffer_disable() - Disable DMA buffer
> + * @buffer: IIO DMA buffer to disable
> + * @indio_dev: IIO device the buffer is attached to
> + *
> + * Needs to be called when the device that the buffer is attached to stops
> + * sampling. Typically should be the iio_buffer_access_ops disable callback.
> + */
> +int iio_dma_buffer_disable(struct iio_buffer *buffer,
> +	struct iio_dev *indio_dev)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +
> +	mutex_lock(&queue->lock);
> +	queue->active = false;
> +
> +	if (queue->ops && queue->ops->abort)
> +		queue->ops->abort(queue);
> +	mutex_unlock(&queue->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_disable);
> +
> +static void iio_dma_buffer_enqueue(struct iio_dma_buffer_queue *queue,
> +	struct iio_dma_buffer_block *block)
> +{
> +	if (block->state == IIO_BLOCK_STATE_DEAD) {
> +		iio_buffer_block_put(block);
> +	} else if (queue->active) {
> +		iio_dma_buffer_submit_block(queue, block);
> +	} else {
> +		block->state = IIO_BLOCK_STATE_QUEUED;
> +		list_add_tail(&block->head, &queue->incoming);
> +	}
> +}
> +
> +static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
> +	struct iio_dma_buffer_queue *queue)
> +{
> +	struct iio_dma_buffer_block *block;
> +
> +	spin_lock_irq(&queue->list_lock);
> +	block = list_first_entry_or_null(&queue->outgoing, struct
> +		iio_dma_buffer_block, head);
> +	if (block != NULL) {
> +		list_del(&block->head);
> +		block->state = IIO_BLOCK_STATE_DEQUEUED;
> +	}
> +	spin_unlock_irq(&queue->list_lock);
> +
> +	return block;
> +}
> +
> +/**
> + * iio_dma_buffer_read() - DMA buffer read callback
> + * @buffer: Buffer to read form
> + * @n: Number of bytes to read
> + * @user_buffer: Userspace buffer to copy the data to
> + *
> + * Should be used as the read_first_n callback for iio_buffer_access_ops
> + * struct for DMA buffers.
> + */
> +int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
> +	char __user *user_buffer)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +	struct iio_dma_buffer_block *block;
> +	int ret;
> +
> +	if (n < buffer->bytes_per_datum)
> +		return -EINVAL;
> +
> +	mutex_lock(&queue->lock);
> +
> +	if (!queue->fileio.active_block) {
> +		block = iio_dma_buffer_dequeue(queue);
> +		if (block == NULL) {
> +			ret = 0;
> +			goto out_unlock;
> +		}
> +		queue->fileio.pos = 0;
> +		queue->fileio.active_block = block;
> +	} else {
> +		block = queue->fileio.active_block;
> +	}
> +
> +	n = rounddown(n, buffer->bytes_per_datum);
> +	if (n > block->bytes_used - queue->fileio.pos)
> +		n = block->bytes_used - queue->fileio.pos;
> +
> +	if (copy_to_user(user_buffer, block->vaddr + queue->fileio.pos, n)) {
> +		ret = -EFAULT;
> +		goto out_unlock;
> +	}
> +
> +	queue->fileio.pos += n;
> +
> +	if (queue->fileio.pos == block->bytes_used) {
> +		queue->fileio.active_block = NULL;
> +		iio_dma_buffer_enqueue(queue, block);
> +	}
> +
> +	ret = n;
> +
> +out_unlock:
> +	mutex_unlock(&queue->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
> +
> +/**
> + * iio_dma_buffer_data_available() - DMA buffer data_available callback
> + * @buf: Buffer to check for data availability
> + *
> + * Should be used as the data_available callback for iio_buffer_access_ops
> + * struct for DMA buffers.
> + */
> +size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buf);
> +	struct iio_dma_buffer_block *block;
> +	size_t data_available = 0;
> +
> +	/*
> +	 * For counting the available bytes we'll use the size of the block not
> +	 * the number of actual bytes available in the block. Otherwise it is
> +	 * possible that we end up with a value that is lower than the watermark
> +	 * but won't increase since all blocks are in use.
> +	 */
> +
> +	mutex_lock(&queue->lock);
> +	if (queue->fileio.active_block)
> +		data_available += queue->fileio.active_block->size;
> +
> +	spin_lock_irq(&queue->list_lock);
> +	list_for_each_entry(block, &queue->outgoing, head)
> +		data_available += block->size;
> +	spin_unlock_irq(&queue->list_lock);
> +	mutex_unlock(&queue->lock);
> +
> +	return data_available;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_data_available);
> +
> +/**
> + * iio_dma_buffer_set_bytes_per_datum() - DMA buffer set_bytes_per_datum callback
> + * @buffer: Buffer to set the bytes-per-datum for
> + * @bpd: The new bytes-per-datum value
> + *
> + * Should be used as the set_bytes_per_datum callback for iio_buffer_access_ops
> + * struct for DMA buffers.
> + */
> +int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd)
> +{
> +	buffer->bytes_per_datum = bpd;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_set_bytes_per_datum);
> +
> +/**
> + * iio_dma_buffer_set_length - DMA buffer set_length callback
> + * @buffer: Buffer to set the length for
> + * @length: The new buffer length
> + *
> + * Should be used as the set_length callback for iio_buffer_access_ops
> + * struct for DMA buffers.
> + */
> +int iio_dma_buffer_set_length(struct iio_buffer *buffer, int length)
> +{
> +	/* Avoid an invalid state */
> +	if (length < 2)
> +		length = 2;
> +	buffer->length = length;
> +	buffer->watermark = length / 2;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_set_length);
> +
> +/**
> + * iio_dma_buffer_init() - Initialize DMA buffer queue
> + * @queue: Buffer to initialize
> + * @dev: DMA device
> + * @ops: DMA buffer queue callback operations
> + *
> + * The DMA device will be used by the queue to do DMA memory allocations. So it
> + * should refer to the device that will perform the DMA to ensure that
> + * allocations are done from a memory region that can be accessed by the device.
> + */
> +int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
> +	struct device *dev, const struct iio_dma_buffer_ops *ops)
> +{
> +	iio_buffer_init(&queue->buffer);
> +	queue->buffer.length = PAGE_SIZE;
> +	queue->buffer.watermark = queue->buffer.length / 2;
> +	queue->dev = dev;
> +	queue->ops = ops;
> +
> +	INIT_LIST_HEAD(&queue->incoming);
> +	INIT_LIST_HEAD(&queue->outgoing);
> +
> +	mutex_init(&queue->lock);
> +	spin_lock_init(&queue->list_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_init);
> +
> +/**
> + * iio_dma_buffer_exit() - Cleanup DMA buffer queue
> + * @queue: Buffer to cleanup
> + *
> + * After this function has completed it is safe to free any resources that are
> + * associated with the buffer and are accessed inside the callback operations.
> + */
> +void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
> +{
> +	unsigned int i;
> +
> +	mutex_lock(&queue->lock);
> +
> +	spin_lock_irq(&queue->list_lock);
> +	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +		if (!queue->fileio.blocks[i])
> +			continue;
> +		queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
> +	}
> +	INIT_LIST_HEAD(&queue->outgoing);
> +	spin_unlock_irq(&queue->list_lock);
> +
> +	INIT_LIST_HEAD(&queue->incoming);
> +
> +	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +		if (!queue->fileio.blocks[i])
> +			continue;
> +		iio_buffer_block_put(queue->fileio.blocks[i]);
> +		queue->fileio.blocks[i] = NULL;
> +	}
> +	queue->fileio.active_block = NULL;
> +	queue->ops = NULL;
> +
> +	mutex_unlock(&queue->lock);
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_exit);
> +
> +/**
> + * iio_dma_buffer_release() - Release final buffer resources
> + * @queue: Buffer to release
> + *
> + * Frees resources that can't yet be freed in iio_dma_buffer_exit(). Should be
> + * called in the buffers release callback implementation right before freeing
> + * the memory associated with the buffer.
> + */
> +void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue)
> +{
> +	mutex_destroy(&queue->lock);
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_release);
> +
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("DMA buffer for the IIO framework");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> new file mode 100644
> index 0000000..767467d
> --- /dev/null
> +++ b/include/linux/iio/buffer-dma.h
> @@ -0,0 +1,152 @@
> +/*
> + * Copyright 2013-2015 Analog Devices Inc.
> + *  Author: Lars-Peter Clausen <lars@metafoo.de>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#ifndef __INDUSTRIALIO_DMA_BUFFER_H__
> +#define __INDUSTRIALIO_DMA_BUFFER_H__
> +
> +#include <linux/list.h>
> +#include <linux/kref.h>
> +#include <linux/spinlock.h>
> +#include <linux/mutex.h>
> +#include <linux/iio/buffer.h>
> +
> +struct iio_dma_buffer_queue;
> +struct iio_dma_buffer_ops;
> +struct device;
> +
> +struct iio_buffer_block {
> +	u32 size;
> +	u32 bytes_used;
> +};
> +
> +/**
> + * enum iio_block_state - State of a struct iio_dma_buffer_block
> + * @IIO_BLOCK_STATE_DEQUEUED: Block is not queued
> + * @IIO_BLOCK_STATE_QUEUED: Block is on the incoming queue
> + * @IIO_BLOCK_STATE_ACTIVE: Block is currently being processed by the DMA
> + * @IIO_BLOCK_STATE_DONE: Block is on the outgoing queue
> + * @IIO_BLOCK_STATE_DEAD: Block has been marked as to be freed
> + */
> +enum iio_block_state {
> +	IIO_BLOCK_STATE_DEQUEUED,
> +	IIO_BLOCK_STATE_QUEUED,
> +	IIO_BLOCK_STATE_ACTIVE,
> +	IIO_BLOCK_STATE_DONE,
> +	IIO_BLOCK_STATE_DEAD,
> +};
> +
> +/**
> + * struct iio_dma_buffer_block - IIO buffer block
> + * @head: List head
> + * @size: Total size of the block in bytes
> + * @bytes_used: Number of bytes that contain valid data
> + * @vaddr: Virutal address of the blocks memory
> + * @phys_addr: Physical address of the blocks memory
> + * @queue: Parent DMA buffer queue
> + * @kref: kref used to manage the lifetime of block
> + * @state: Current state of the block
> + */
> +struct iio_dma_buffer_block {
> +	/* May only be accessed by the owner of the block */
> +	struct list_head head;
> +	size_t bytes_used;
> +
> +	/*
> +	 * Set during allocation, constant thereafter. May be accessed read-only
> +	 * by anybody holding a reference to the block.
> +	 */
> +	void *vaddr;
> +	dma_addr_t phys_addr;
> +	size_t size;
> +	struct iio_dma_buffer_queue *queue;
> +
> +	/* Must not be accessed outside the core. */
> +	struct kref kref;
> +	/*
> +	 * Must not be accessed outside the core. Access needs to hold
> +	 * queue->list_lock if the block is not owned by the core.
> +	 */
> +	enum iio_block_state state;
> +};
> +
> +/**
> + * struct iio_dma_buffer_queue_fileio - FileIO state for the DMA buffer
> + * @blocks: Buffer blocks used for fileio
> + * @active_block: Block being used in read()
> + * @pos: Read offset in the active block
> + * @block_size: Size of each block
> + */
> +struct iio_dma_buffer_queue_fileio {
> +	struct iio_dma_buffer_block *blocks[2];
> +	struct iio_dma_buffer_block *active_block;
> +	size_t pos;
> +	size_t block_size;
> +};
> +
> +/**
> + * struct iio_dma_buffer_queue - DMA buffer base structure
> + * @buffer: IIO buffer base structure
> + * @dev: Parent device
> + * @ops: DMA buffer callbacks
> + * @lock: Protects the incoming list, active and the fields in the fileio
> + *   substruct
> + * @list_lock: Protects lists that contain blocks which can be modified in
> + *   atomic context as well as blocks on those lists. This is the outgoing queue
> + *   list and typically also a list of active blocks in the part that handles
> + *   the DMA controller
> + * @incoming: List of buffers on the incoming queue
> + * @outgoing: List of buffers on the outgoing queue
> + * @active: Whether the buffer is currently active
> + * @fileio: FileIO state
> + */
> +struct iio_dma_buffer_queue {
> +	struct iio_buffer buffer;
> +	struct device *dev;
> +	const struct iio_dma_buffer_ops *ops;
> +
> +	struct mutex lock;
> +	spinlock_t list_lock;
> +	struct list_head incoming;
> +	struct list_head outgoing;
> +
> +	bool active;
> +
> +	struct iio_dma_buffer_queue_fileio fileio;
> +};
> +
> +/**
> + * struct iio_dma_buffer_ops - DMA buffer callback operations
> + * @submit: Called when a block is submitted to the DMA controller
> + * @abort: Should abort all pending transfers
> + */
> +struct iio_dma_buffer_ops {
> +	int (*submit)(struct iio_dma_buffer_queue *queue,
> +		struct iio_dma_buffer_block *block);
> +	void (*abort)(struct iio_dma_buffer_queue *queue);
> +};
> +
> +void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block);
> +void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
> +	struct list_head *list);
> +
> +int iio_dma_buffer_enable(struct iio_buffer *buffer,
> +	struct iio_dev *indio_dev);
> +int iio_dma_buffer_disable(struct iio_buffer *buffer,
> +	struct iio_dev *indio_dev);
> +int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
> +	char __user *user_buffer);
> +size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
> +int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
> +int iio_dma_buffer_set_length(struct iio_buffer *buffer, int length);
> +int iio_dma_buffer_request_update(struct iio_buffer *buffer);
> +
> +int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
> +	struct device *dma_dev, const struct iio_dma_buffer_ops *ops);
> +void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue);
> +void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue);
> +
> +#endif
> 

