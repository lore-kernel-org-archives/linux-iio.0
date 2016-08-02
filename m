Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33094 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591AbcHBCOk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Aug 2016 22:14:40 -0400
Received: by mail-pa0-f50.google.com with SMTP id b2so5477373pat.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Aug 2016 19:13:55 -0700 (PDT)
Date: Mon, 1 Aug 2016 18:12:45 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Brian Norris <computersforpeace@gmail.com>
Subject: iio: WARNING at kernel/sched/core.c:7630: do not call blocking ops
 when !TASK_RUNNING
Message-ID: <20160802011244.GA54171@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

I'm seeing the following warnings when I read from an IIO char device,
with CONFIG_DEBUG_ATOMIC_SLEEP=y. I'm testing a v4.4 kernel, but AFAICT,
nothing too relevant has changed between that and v4.7:

[   10.831289] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffc00026b610>] prepare_to_wait_event+0xb0/0x11c
[   10.845531] ------------[ cut here ]------------
[   10.850161] WARNING: at kernel/sched/core.c:7630
[   10.858672] Modules linked in: cfg80211 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables asix usbnet mii joydev snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device ppp_async ppp_generic slhc tun
[   10.878459] 
[   10.879953] CPU: 4 PID: 1844 Comm: BrowserBlocking Not tainted 4.4.14 #190
[   10.886817] Hardware name: Google Kevin (DT)
[   10.891085] task: ffffffc0e5a88000 ti: ffffffc0e2ce4000 task.ti: ffffffc0e2ce4000
[   10.898574] PC is at __might_sleep+0x64/0x90
[   10.902846] LR is at __might_sleep+0x64/0x90
[   10.907115] pc : [<ffffffc00024ed44>] lr : [<ffffffc00024ed44>] pstate: 60000145
[   10.914500] sp : ffffffc0e2ce7ba0
[   10.917813] x29: ffffffc0e2ce7ba0 x28: 0000000000000001 
[   10.923147] x27: 0000000000000000 x26: ffffffc0ed77b488 
[   10.928476] x25: ffffffc001082000 x24: 0000000000000000 
[   10.933809] x23: ffffffc0e2c49340 x22: 0000000000000000 
[   10.939139] x21: 0000000000000269 x20: ffffffc000c1314e 
[   10.944470] x19: ffffffc00114493e x18: 0000000000000000 
[   10.949798] x17: 0000000000000000 x16: ffffffc000372094 
[   10.955138] x15: 0000000000000000 x14: ffffffc0eacbb898 
[   10.960474] x13: ffffffc000c14919 x12: 0000000000000000 
[   10.965809] x11: 0000000000000000 x10: 0000000000001150 
[   10.971141] x9 : ffffffc0e2ce7920 x8 : ffffffc0e5a891b0 
[   10.976469] x7 : ffffffc000267934 x6 : ffffffc00024e7f0 
[   10.981805] x5 : 0000000000000000 x4 : 0000000000000001 
[   10.987138] x3 : 0000000000000000 x2 : cb88537fdc8ba60e 
[   10.992479] x1 : cb88537fdc8ba60e x0 : 0000000000000071 
[   10.997810] 

...

[   12.164333] ---[ end trace 45409966a9a76438 ]---
[   12.168942] Call trace:
[   12.171391] [<ffffffc00024ed44>] __might_sleep+0x64/0x90
[   12.176699] [<ffffffc000954774>] mutex_lock_nested+0x50/0x3fc
[   12.182440] [<ffffffc0007b9424>] iio_kfifo_buf_data_available+0x28/0x4c
[   12.189043] [<ffffffc0007b76ac>] iio_buffer_ready+0x60/0xe0
[   12.194608] [<ffffffc0007b7834>] iio_buffer_read_first_n_outer+0x108/0x1a8
[   12.201474] [<ffffffc000370d48>] __vfs_read+0x58/0x114
[   12.206606] [<ffffffc000371740>] vfs_read+0x94/0x118
[   12.211564] [<ffffffc0003720f8>] SyS_read+0x64/0xb4
[   12.216436] [<ffffffc000203cb4>] el0_svc_naked+0x24/0x28


Have any of you seen this kind of issue before (perhaps most IIO users
are not using CONFIG_DEBUG_ATOMIC_SLEEP)? If the WARNING is really
correct, then this problem has really been around a while. It looks like
we have a wait_event_interruptible() called, with this call chain in the
'condition' path:

  iio_buffer_ready()
    -> iio_buffer_data_available() (i.e., iio_kfifo_buf_data_available())
      -> mutex_lock()

Calling mutex_lock() means we clobber the TASK_INTERRUPTIBLE state with
TASK_RUNNING -- hence, the WARNING. Should this be using a spinlock
instead? Or is there some way to refactor this to avoid calling these
sleeping functions in the wait_event*() condition?

Regards,
Brian
