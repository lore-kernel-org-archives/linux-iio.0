Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41692 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbcHOPyg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 11:54:36 -0400
Subject: Re: [PATCH v2] iio: fix sched WARNING "do not call blocking ops when
 !TASK_RUNNING"
To: Brian Norris <briannorris@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <20160802011244.GA54171@google.com>
 <37ea974c-9ac6-5a40-0f0e-ee34ef605a08@metafoo.de>
 <20160802165732.GA3310@localhost>
 <9a6a7f54-0343-db74-57a2-9f747ae659cc@metafoo.de>
 <20160804082621.GA11331@localhost> <20160809001937.GA23658@google.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Brian Norris <computersforpeace@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f1206fbd-3c04-32b5-a898-86c3248661d2@kernel.org>
Date: Mon, 15 Aug 2016 16:54:32 +0100
MIME-Version: 1.0
In-Reply-To: <20160809001937.GA23658@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/08/16 01:19, Brian Norris wrote:
> When using CONFIG_DEBUG_ATOMIC_SLEEP, the scheduler nicely points out
> that we're calling sleeping primitives within the wait_event loop, which
> means we might clobber the task state:
> 
> [   10.831289] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffc00026b610>]
> [   10.845531] ------------[ cut here ]------------
> [   10.850161] WARNING: at kernel/sched/core.c:7630
> ...
> [   12.164333] ---[ end trace 45409966a9a76438 ]---
> [   12.168942] Call trace:
> [   12.171391] [<ffffffc00024ed44>] __might_sleep+0x64/0x90
> [   12.176699] [<ffffffc000954774>] mutex_lock_nested+0x50/0x3fc
> [   12.182440] [<ffffffc0007b9424>] iio_kfifo_buf_data_available+0x28/0x4c
> [   12.189043] [<ffffffc0007b76ac>] iio_buffer_ready+0x60/0xe0
> [   12.194608] [<ffffffc0007b7834>] iio_buffer_read_first_n_outer+0x108/0x1a8
> [   12.201474] [<ffffffc000370d48>] __vfs_read+0x58/0x114
> [   12.206606] [<ffffffc000371740>] vfs_read+0x94/0x118
> [   12.211564] [<ffffffc0003720f8>] SyS_read+0x64/0xb4
> [   12.216436] [<ffffffc000203cb4>] el0_svc_naked+0x24/0x28
> 
> To avoid this, we should (a la https://lwn.net/Articles/628628/) use the
> wait_woken() function, which avoids the nested sleeping while still
> handling races between waiting / wake-events.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
Looks good to me, but given Lars' involvement in the discussion I'd
like his review before applying this.

Jonathan
> ---
> v2:
>  * Only add/remove to/from the wait queue once per call
>  * Restore interruptability via explicit signal_pending() call
>  * Refactor to avoid nested loop
> 
> Note that I did not remove the first (semi-redundant) test for
> !indio_dev->info, so as to avoid disturbing the error codes used here.
> 
>  drivers/iio/industrialio-buffer.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 90462fcf5436..49bf9c59f117 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -107,6 +107,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  {
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>  	size_t datum_size;
>  	size_t to_wait;
>  	int ret;
> @@ -131,19 +132,29 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  	else
>  		to_wait = min_t(size_t, n / datum_size, rb->watermark);
>  
> +	add_wait_queue(&rb->pollq, &wait);
>  	do {
> -		ret = wait_event_interruptible(rb->pollq,
> -		      iio_buffer_ready(indio_dev, rb, to_wait, n / datum_size));
> -		if (ret)
> -			return ret;
> +		if (!indio_dev->info) {
> +			ret = -ENODEV;
> +			break;
> +		}
>  
> -		if (!indio_dev->info)
> -			return -ENODEV;
> +		if (!iio_buffer_ready(indio_dev, rb, to_wait, n / datum_size)) {
> +			if (signal_pending(current)) {
> +				ret = -ERESTARTSYS;
> +				break;
> +			}
> +
> +			wait_woken(&wait, TASK_INTERRUPTIBLE,
> +				   MAX_SCHEDULE_TIMEOUT);
> +			continue;
> +		}
>  
>  		ret = rb->access->read_first_n(rb, n, buf);
>  		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
>  			ret = -EAGAIN;
>  	 } while (ret == 0);
> +	remove_wait_queue(&rb->pollq, &wait);
>  
>  	return ret;
>  }
> 

