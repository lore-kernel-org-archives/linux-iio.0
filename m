Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bounce-2.online.net ([62.210.16.44]:38614 "EHLO
        bounce-2.online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbdCIOww (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Mar 2017 09:52:52 -0500
Received: from [62.210.16.40] (helo=smtpauth-dc2-1.online.net)
        by bounce-dc2-2.online.net with esmtpa (Exim 4.82)
        (envelope-from <miguel.robles@farole.net>)
        id 1clz9A-0008L5-5T
        for linux-iio@vger.kernel.org; Thu, 09 Mar 2017 15:34:28 +0100
Received: from [78.249.61.217] (helo=miguel-Z170X-UD5-TH)
        by smtpauth-dc2-1.online.net with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <miguel.robles@farole.net>)
        id 1clz96-00031q-Ok
        for linux-iio@vger.kernel.org; Thu, 09 Mar 2017 15:34:24 +0100
Date: Thu, 9 Mar 2017 15:34:23 +0100
From: Miguel Robles <miguel.robles@farole.net>
To: linux-iio@vger.kernel.org
Subject: PROBLEM: iio: dummy: Oops after mkdir
Message-ID: <20170309143421.GA4623@miguel-Z170X-UD5-TH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello all,

I am beginning with Linux Kernel development. So I am trying to make
the IIO tasks posted on kernelnewbies DOT org.
But I got stuck with this problem that I am describing you hereafter
hoping that someone could bring me any feedback.

Many thanks,
Miguel ROBLES

----------
DESCRIPTION
-----------

After loading the corresponding IIO modules and mountig the configfs filesystem
I can not create an instance device with mkdir using the command:

$ sudo mkdir /config/iio/devices/dummy/my_dummy_device
Killed

I get the "Killed" message and looking at my syslog file, I got the warning
"refcount_t: increment on 0; use-after-free" followed by an "Oops" message.
When trying to execute the command one more time, the execution never finishes.


------
CONTEXT
-------

- Tried on 2 linux kernel releases:
      - kernel: 4.10 (commit: 4977ab6)
      - Kernel: 4.11 (commit: ec3b93a)

- Compiled with config file including the following options for IIO:

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y

CONFIG_IIO_CONFIGFS=m

- Modules loaded on following order:
  /fs/configfs/configfs.ko
  /drivers/iio/industrialio-configfs.ko
  /drivers/iio/industrialio-sw-device.ko
  /drivers/iio/industrialio-triggered-event.ko
  /drivers/iio/dummy/iio_dummy_evgen.ko
  /drivers/iio/dummy/iio_dummy.ko


-----
TRACE
-----

WARNING: CPU: 7 PID: 676 at lib/refcount.c:114 refcount_inc+0x37/0x40

refcount_t: increment on 0; use-after-free.

Modules linked in: iio_dummy(E) iio_dummy_evgen(E) industrialio_sw_device(E)
industrialio_configfs(E) configfs(E) binfmt_misc vmw_vsock_vmci_transport ...

CPU: 7 PID: 676 Comm: mkdir Tainted: G            E   4.11.0-rc1+ #4
Call Trace:
 dump_stack+0x63/0x90
  __warn+0xcb/0xf0
  warn_slowpath_fmt+0x5f/0x80
  refcount_inc+0x37/0x40
  config_item_get+0x1b/0x30 [configfs]
  link_obj+0x42/0x50 [configfs]
  link_group+0x19/0x70 [configfs]
  configfs_mkdir+0x168/0x3d0 [configfs]
  vfs_mkdir+0x10c/0x1b0
  SyS_mkdir+0xd0/0x100
  entry_SYSCALL_64_fastpath+0x1e/0xad
  RIP: 0033:0x7f29650b33f7
  RSP: 002b:00007ffcdd8babe8 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
  RAX: ffffffffffffffda RBX: 00007ffcdd8baed8 RCX: 00007f29650b33f7
  RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffcdd8bb82f
  RBP: 0000000000000002 R08: 00000000000001ff R09: 0000000000402b00
  R10: 00000000000001e5 R11: 0000000000000206 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

---[ end trace 71ffa6eaa306d186 ]---

BUG: unable to handle kernel paging request at ffffffffffffffb8

IP: link_obj+0x9/0x50 [configfs]
PGD 2d8e0c067
PUD 2d8e0e067
PMD 0

Oops: 0002 [#1] SMP
Modules linked in: iio_dummy(E) iio_dummy_evgen(E) industrialio_sw_device(E)
industrialio_con figfs(E) configfs(E) binfmt_misc vmw_vsock_vmci_transport ...

CPU: 7 PID: 676 Comm: mkdir Tainted: G        W   E   4.11.0-rc1+ #4
Hardware name: Gigabyte Technology Co., Ltd. Z170X-UD5 TH/Z170X-UD5 TH-CF, BIOS F2 09/04/2015
task: ffff9b5d4267e580 task.stack: ffffa71982eb8000
RIP: 0010:link_obj+0x9/0x50 [configfs]
RSP: 0018:ffffa71982ebbe10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff9b5be8404250 RCX: 0000000000000006
RDX: 0000000000000000 RSI: ffffffffffffff88 RDI: ffff9b5be8404250
RBP: ffffa71982ebbe38 R08: 0000000000000001 R09: 00000000000003fe
R10: 0000000000000004 R11: 00000000000003fe R12: ffffffffffffff88
R13: ffff9b5be84042b8 R14: ffff9b5d7b53b540 R15: ffff9b5be8404250
FS:  00007f29657a8800(0000) GS:ffff9b5d91dc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffb8 CR3: 000000043fa94000 CR4: 00000000003406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ? link_group+0x19/0x70 [configfs]
  link_group+0x45/0x70 [configfs]
  configfs_mkdir+0x168/0x3d0 [configfs]
  vfs_mkdir+0x10c/0x1b0
  SyS_mkdir+0xd0/0x100
  entry_SYSCALL_64_fastpath+0x1e/0xad
  RIP: 0033:0x7f29650b33f7
  RSP: 002b:00007ffcdd8babe8 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
  RAX: ffffffffffffffda RBX: 00007ffcdd8baed8 RCX: 00007f29650b33f7
  RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffcdd8bb82f
  RBP: 0000000000000002 R08: 00000000000001ff R09: 0000000000402b00
  R10: 00000000000001e5 R11: 0000000000000206 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Code: 8b 7a 48 4c 89 ee e8 f7 fd ff ff 48 8b 73 48 41 89 c6 eb 87 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 85 ff <48> 89 7e 30 48 89 e5 53 48 89 f3 74 2f e8 a5 28 00 00 48 89 43
  RIP: link_obj+0x9/0x50 [configfs] RSP: ffffa71982ebbe10
  CR2: ffffffffffffffb8
---[ end trace 71ffa6eaa306d187 ]---
