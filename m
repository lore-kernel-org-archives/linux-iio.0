Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:37169 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbcEWKm3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 May 2016 06:42:29 -0400
Subject: Re: Possible deadlock in mpu6050 on buffer disable?
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <a4502f91-d01f-5a65-efb9-5f26d065e851@intel.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5742DE92.5010400@metafoo.de>
Date: Mon, 23 May 2016 12:42:26 +0200
MIME-Version: 1.0
In-Reply-To: <a4502f91-d01f-5a65-efb9-5f26d065e851@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/23/2016 12:33 PM, Crestez Dan Leonard wrote:
> Hello,
> 
> I've been poking at this driver and I get some occasional deadlocks when
> disabling buffering. Here is a snippet from the kernel task dump (via
> echo t > /proc/sysrq-trigger):
> 
> [   57.562487] irq/56-mpu6500_ D ffff88003d7fbd08 13632   771      2
> 0x00000000
> [   57.563081]  ffff88003d7fbd08 ffff88003da4a1c0 ffffffff81988ae0
> ffff880000000026
> [   57.563614]  ffff88003d7fc000 ffff88003da4a1c0 ffff88003d4aa304
> 00000000ffffffff
> [   57.564221]  ffff88003d4aa308 ffff88003d7fbd20 ffffffff8147f280
> ffff88003d4aa300
> [   57.565242] Call Trace:
> [   57.565462]  [<ffffffff8147f280>] schedule+0x30/0x80
> [   57.565789]  [<ffffffff8147f4f9>] schedule_preempt_disabled+0x9/0x10
> [   57.566303]  [<ffffffff81480c8a>] __mutex_lock_slowpath+0x8a/0x100
> [   57.566704]  [<ffffffff810875a0>] ? irq_forced_thread_fn+0x60/0x60
> [   57.567202]  [<ffffffff81480d1a>] mutex_lock+0x1a/0x30
> [   57.567541]  [<ffffffff813bc31e>] inv_mpu6050_read_fifo+0x6e/0x230
> [   57.567934]  [<ffffffff810737d6>] ? put_prev_task_rt+0x16/0xa0
> [   57.568428]  [<ffffffff8147ed1c>] ? __schedule+0x32c/0x860
> [   57.568789]  [<ffffffff810875a0>] ? irq_forced_thread_fn+0x60/0x60
> [   57.569289]  [<ffffffff810875bb>] irq_thread_fn+0x1b/0x50
> [   57.569646]  [<ffffffff81087851>] irq_thread+0x111/0x190
> [   57.569997]  [<ffffffff81087690>] ? wake_threads_waitq+0x30/0x30
> [   57.570505]  [<ffffffff81087740>] ? irq_thread_dtor+0xb0/0xb0
> [   57.570875]  [<ffffffff8105eae4>] kthread+0xc4/0xe0
> [   57.571308]  [<ffffffff81482a92>] ret_from_fork+0x22/0x40
> [   57.571663]  [<ffffffff8105ea20>] ? kthread_worker_fn+0x160/0x160
> 
> VERSUS:
> 
> [   57.587592] test-iio-buffer D ffff88003d1a3c08 13808   798    791
> 0x00000004
> [   57.588193]  ffff88003d1a3c08 ffff88003db02d00 ffff88003d1a3be8
> ffffffff81106abc
> [   57.588772]  ffff88003d1a4000 ffff88003d5b72d0 0000000000000038
> ffff88003d5b729c
> [   57.589388]  ffff88003d5b7200 ffff88003d1a3c20 ffffffff8147f280
> ffff88003d5b7200
> [   57.589963] Call Trace:
> [   57.590211]  [<ffffffff81106abc>] ? kfree+0xec/0xf0
> [   57.590537]  [<ffffffff8147f280>] schedule+0x30/0x80
> [   57.590904]  [<ffffffff81086d14>] synchronize_irq+0x54/0x90
> [   57.591600]  [<ffffffff810772c0>] ? wake_atomic_t_function+0x60/0x60
> [   57.592073]  [<ffffffff81087ba6>] __free_irq+0x136/0x270
> [   57.592430]  [<ffffffff81087d54>] free_irq+0x34/0x80
> [   57.592760]  [<ffffffff813b93b5>] iio_trigger_detach_poll_func+0x75/0xa0
> [   57.593267]  [<ffffffff813b93f7>]
> iio_triggered_buffer_predisable+0x17/0x20
> [   57.593711]  [<ffffffff813b73ca>] iio_disable_buffers+0x3a/0xf0
> [   57.594164]  [<ffffffff813b8202>] __iio_update_buffers+0x222/0x4e0
> [   57.594559]  [<ffffffff813b865b>] iio_buffer_store_enable+0xab/0xc0
> [   57.594973]  [<ffffffff81308a23>] dev_attr_store+0x13/0x20
> [   57.595388]  [<ffffffff8116ff72>] sysfs_kf_write+0x32/0x40
> [   57.595734]  [<ffffffff8116f565>] kernfs_fop_write+0x115/0x170
> [   57.596170]  [<ffffffff8110b093>] __vfs_write+0x23/0xe0
> [   57.596526]  [<ffffffff8112755f>] ? __fd_install+0x1f/0xc0
> [   57.596871]  [<ffffffff811273da>] ? __alloc_fd+0x3a/0x170
> [   57.597308]  [<ffffffff81078b3d>] ? percpu_down_read+0xd/0x50
> [   57.597667]  [<ffffffff8110bf74>] vfs_write+0xa4/0x1a0
> [   57.598023]  [<ffffffff81109241>] ? filp_close+0x51/0x70
> [   57.598396]  [<ffffffff8110d251>] SyS_write+0x41/0xa0
> [   57.598717]  [<ffffffff8148289b>] entry_SYSCALL_64_fastpath+0x13/0x8f
> 
> The problem seems to be that inv_mpu6050_read_fifo takes
> indio_dev->mlock, the same lock taken by the IIO core when disabling the
> interrupt.
> 
> Does anyone have any clever ideas for fixing this? One way to do it
> would be to skip taking mlock in inv_mpu6050_read_fifo because most of
> the code does not touch shared fields. Only when an error happens does
> it call inv_reset_fifo. I think that call should simply be removed.

Yes, that's probably the way to go.

> As a more general principle isn't it a bad idea to take mlock in driver
> code? It seems much saner for drivers to use their own locks for their
> private data.

There are a few places where it is safe to use the mlock, like the driver
{read,write}_raw() callbacks, but that's pretty mich it.

