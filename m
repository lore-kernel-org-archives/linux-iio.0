Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59259 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbcHPP17 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 11:27:59 -0400
Subject: Re: [PATCH v2] iio: fix sched WARNING "do not call blocking ops when
 !TASK_RUNNING"
To: Jonathan Cameron <jic23@kernel.org>,
	Brian Norris <briannorris@chromium.org>
References: <20160802011244.GA54171@google.com>
 <37ea974c-9ac6-5a40-0f0e-ee34ef605a08@metafoo.de>
 <20160802165732.GA3310@localhost>
 <9a6a7f54-0343-db74-57a2-9f747ae659cc@metafoo.de>
 <20160804082621.GA11331@localhost> <20160809001937.GA23658@google.com>
 <f1206fbd-3c04-32b5-a898-86c3248661d2@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Brian Norris <computersforpeace@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ca1428a5-9fa2-2de1-0d09-85d6c02cbf34@metafoo.de>
Date: Tue, 16 Aug 2016 17:27:53 +0200
MIME-Version: 1.0
In-Reply-To: <f1206fbd-3c04-32b5-a898-86c3248661d2@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/15/2016 05:54 PM, Jonathan Cameron wrote:
> On 09/08/16 01:19, Brian Norris wrote:
>> When using CONFIG_DEBUG_ATOMIC_SLEEP, the scheduler nicely points out
>> that we're calling sleeping primitives within the wait_event loop, which
>> means we might clobber the task state:
>>
>> [   10.831289] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffc00026b610>]
>> [   10.845531] ------------[ cut here ]------------
>> [   10.850161] WARNING: at kernel/sched/core.c:7630
>> ...
>> [   12.164333] ---[ end trace 45409966a9a76438 ]---
>> [   12.168942] Call trace:
>> [   12.171391] [<ffffffc00024ed44>] __might_sleep+0x64/0x90
>> [   12.176699] [<ffffffc000954774>] mutex_lock_nested+0x50/0x3fc
>> [   12.182440] [<ffffffc0007b9424>] iio_kfifo_buf_data_available+0x28/0x4c
>> [   12.189043] [<ffffffc0007b76ac>] iio_buffer_ready+0x60/0xe0
>> [   12.194608] [<ffffffc0007b7834>] iio_buffer_read_first_n_outer+0x108/0x1a8
>> [   12.201474] [<ffffffc000370d48>] __vfs_read+0x58/0x114
>> [   12.206606] [<ffffffc000371740>] vfs_read+0x94/0x118
>> [   12.211564] [<ffffffc0003720f8>] SyS_read+0x64/0xb4
>> [   12.216436] [<ffffffc000203cb4>] el0_svc_naked+0x24/0x28
>>
>> To avoid this, we should (a la https://lwn.net/Articles/628628/) use the
>> wait_woken() function, which avoids the nested sleeping while still
>> handling races between waiting / wake-events.
>>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Looks good to me, but given Lars' involvement in the discussion I'd
> like his review before applying this.

Looks good. Thanks Brian for fixing this.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
