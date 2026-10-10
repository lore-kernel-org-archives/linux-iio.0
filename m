Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A555381C4
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791664569; cv=none; b=lRL+ZcezYgb5X100f1ScO6MlIEg73gU1ZaQH4S03NV7ju8kY27Y55fQowiQGxFxQkoE36Gdg7h5B7YsDrTLUSLFqXBozfFp99jPUAeEkbPSVXVPXubDr7Ar6vPjTOupHgj9/T6x3lMpRDU8FVxTh8jQ32Mixcw7MnOoEDbRIdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791664569; c=relaxed/simple;
	bh=1JIjt/4eCLSxrb3tLr63KubNxZJF0BWFV2FZ7rLw3vY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwIiWcxPD3iWwE9O8EsOngCe5mYLPLSPTyyHzWvXSIrAHBIYppGYzEXXRvjClU8vSB0z28jYwR7Oryz/9YJz9cwIenCjJbmSQy/0kuZov6DHMCJofjGwifmoMXnTVwrF2/ESZLj5TTy9J2a2stuTXJMjQjL0MUOXfsi/JUtJv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpRWntLJ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpRWntLJ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9179dd18658so12051846d6.2
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791664567; x=1792269367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JatCAGb05kOUkJmB3490eEgBdJ9DYTFJy/rDzZOPXQw=;
        b=KpRWntLJeLwjBqtcAWPWlQ+1VmVeJhZxvUny7n7siYyA+Z41504TJWUsUkaCFnlybo
         tGv33AMPKGUy9ohO9KqyKMD2uF9pvnjrFadErvWYIxp3IG/CW9x8xtUEQQL81U/Uh+EJ
         2FU7fdz5gACln6c4pDRI9PomrdfgLVPsoW7OZ5RtNWiA53B7/lVnuYtv7FEbHHt+FPLg
         rImp5cRx9m4yQkPih1cQTMPhpv2QNoGFd/e9qEMfbI/T8aB1Hj4Fk6DSstlDMj/R/N6u
         G7MpYxy5ZLXx87Ll91Yy1lx1y/LMtpbH1inXjYbdkKZTSXczkyWzaCYvheFTEhXbC/Nb
         qvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791664567; x=1792269367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JatCAGb05kOUkJmB3490eEgBdJ9DYTFJy/rDzZOPXQw=;
        b=zNbsmYGnk8TOOIB0NsedhQm6y6EWghIJK1LJOHek+bgAmkcT/wV7s6kV7NpKdaqLl/
         rxDZ2pI1PmACNMuagIk6sgh+pbHFGapl7HH/MxriDkSQeq8eaSDNUJcfU7LvctiR/Met
         mjjGL9fK+C7vULbT1QSdGMttguUlWrl2NERqhcHpNefzF8SI1zP7Y9wgGZcMh7k3UhlN
         mdveKDOnZVWy4jifW08P7dyoyXhPiS/UX1t+eaQgNFc9a8ZOoZGzoPaeS3Uw/9NXgjee
         buAzKDAvZ8LOCXGNzGW0T9gOx9JFnxDRX2NYvdZv6u74QSbye0d6ojLqFqhDkFmKaY5q
         ZFJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNu71BoqIMTFONfDuviAc7kN9Pgo3JwVsaDCtYjEspUGxiwAyrhu5ikkXanm2sSJB148nRFAxCEos=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzXpzLFy0EJL+v3HAjI++MWNGo0rIF2mDDaERX+IAMTiejSwur
	cT2QjF7E+n+T5lbbwWNvkbynw8KEOFlEZ8/IdHA/PaLkEyXPyQtqZwmnF1PNjQ==
X-Gm-Gg: AYBFou3K99fE2uLXELl7FiT+sa8gxSaToCa1OvsnYupugyozFCZAXmdz4jjU8a6d6+9
	eLl57L9ymuQKEs4n3sKFx0lWviLPV+MKm3GCvk1y1/eSHQdv1Yz9inKQct/1B/VvYZSBx5ZcXUN
	+m6McR+anGk63kpU+s65xkjm78LGuuUReo200pAGjb001T0pkEWoaBRvGmK8x2y3QrJqg8hDRMQ
	0NueXmqDD8uCuXG7MgO/hnpvilP/KS917csc2Hmkv39WuGdXbQYlToK0D4SsSPwAccDRRhEPmVK
	XR+rLSoQOynfrd2lLmiRiZyLbuiU2le5CtW8Q14vza4AJMIxg+AGSdzMP1Uf9YD11lmTGddi27U
	Ry7PvYeONcZBJTMypV9rrmQhC2dAeKxgAxVsp76vucGsf252hDrnVaaSWd7uz0+OfeyqL5oL5Hl
	wYKi8JAQv8o4K9XlYVe8VIDwU57oLk3rnxwujlruEdFBLL1o/3IAHK3KxvgMFoDYrZhTulBS4Av
	xP/GxneTxcDS0LQa6XaEWgw
X-Received: by 2002:a05:620a:8086:b0:93e:74e5:2b3a with SMTP id af79cd13be357-93ebd1dfda8mr834194285a.28.1791664566971;
        Sat, 10 Oct 2026 13:36:06 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9847f37sm495930685a.10.2026.10.10.13.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 13:36:06 -0700 (PDT)
From: Dingisoul <dingiso.kernel@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [BUG] iio: gyro: mpu3050: use-after-free via trigger left on iio_trigger_list after unbind
Date: Sat, 10 Oct 2026 16:36:01 -0400
Message-Id: <20261010203601.1686148-1-dingiso.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in mpu3050_drdy_trigger_set_state

on commit: a90ee4305c4a (2026-10-07)

Root cause: mpu3050_trigger_probe() registers the data-ready trigger with
the non-devm iio_trigger_register(), with drvdata pointing at indio_dev:

    static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
    {
        ...
        mpu3050->trig->dev.parent = dev;
        mpu3050->trig->ops = &mpu3050_trigger_ops;
        iio_trigger_set_drvdata(mpu3050->trig, indio_dev);

        ret = iio_trigger_register(mpu3050->trig);  /* device_add() pins trig; no unregister on remove */
        if (ret)
            goto err_iio_trigger;

        indio_dev->trig = iio_trigger_get(mpu3050->trig);

        return 0;
    }

mpu3050_common_remove() tears down everything else, but never calls
iio_trigger_unregister() on mpu3050->trig:

    void mpu3050_common_remove(struct device *dev)
    {
        struct iio_dev *indio_dev = dev_get_drvdata(dev);
        struct mpu3050 *mpu3050 = iio_priv(indio_dev);

        iio_device_unregister(indio_dev);  /* devm frees indio_dev's storage once this returns */
        pm_runtime_get_sync(dev);
        pm_runtime_put_noidle(dev);
        pm_runtime_disable(dev);
        if (mpu3050->irq)
            free_irq(mpu3050->irq, mpu3050->trig);
        iio_triggered_buffer_cleanup(indio_dev);
        mpu3050_power_down(mpu3050);
        /* trig is never unregistered: still on the global iio_trigger_list */
    }

So after unbind, the trigger is still alive and discoverable by name on
the global trigger list, with drvdata still pointing at the now-freed
indio_dev. Any other IIO device with a triggered buffer can select it by
name via trigger/current_trigger and enable its buffer, which reaches
the leaked trigger's ->set_trigger_state() op:

    static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
                                              bool enable)
    {
        struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
        struct mpu3050 *mpu3050 = iio_priv(indio_dev);  /* indio_dev is freed -- UAF read */
        ...

The reproducer and .config files are here.
https://gist.github.com/dingiso/985aa3eb2786b62f80e2e6780e9af090

I'm happy to test debug patches or provide additional information.

[   24.039594][ T8117] BUG: KASAN: slab-use-after-free in mpu3050_drdy_trigger_set_state (./include/linux/iio/iio.h:980 drivers/iio/gyro/mpu3050-core.c:957)
[   24.039630][ T8117] Read of size 8 at addr ffff888030621388 by task repro/8117
[   24.039634][ T8117] 
[   24.039644][ T8117] Tainted: [E]=UNSIGNED_MODULE
[   24.039645][ T8117] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   24.039648][ T8117] Call Trace:
[   24.039650][ T8117]  <TASK>
[   24.039651][ T8117]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   24.039663][ T8117]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   24.039682][ T8117]  kasan_report (mm/kasan/report.c:595)
[   24.039690][ T8117]  mpu3050_drdy_trigger_set_state (./include/linux/iio/iio.h:980 drivers/iio/gyro/mpu3050-core.c:957)
[   24.039709][ T8117]  iio_trigger_attach_poll_func (drivers/iio/industrialio-trigger.c:308)
[   24.039715][ T8117]  __iio_update_buffers (drivers/iio/industrialio-buffer.c:1207 drivers/iio/industrialio-buffer.c:1324)
[   24.039747][ T8117]  enable_store (drivers/iio/industrialio-buffer.c:1414)
[   24.039765][ T8117]  kernfs_fop_write_iter (fs/kernfs/file.c:345)
[   24.039769][ T8117]  vfs_write (fs/read_write.c:595 fs/read_write.c:687)
[   24.039786][ T8117]  ksys_write (fs/read_write.c:739)
[   24.039795][ T8117]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[   24.039799][ T8117]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   24.039803][ T8117] RIP: 0033:0x7fe293245473
[   24.039807][ T8117] Code: 8b 15 21 2a 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
All code
========
   0:	8b 15 21 2a 0e 00    	mov    0xe2a21(%rip),%edx        # 0xe2a27
   6:	f7 d8                	neg    %eax
   8:	64 89 02             	mov    %eax,%fs:(%rdx)
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	eb b7                	jmp    0xffffffffffffffcb
  14:	0f 1f 00             	nopl   (%rax)
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 55                	ja     0x87
  32:	c3                   	ret
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 28          	sub    $0x28,%rsp
  3b:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 55                	ja     0x5d
   8:	c3                   	ret
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 28          	sub    $0x28,%rsp
  11:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
[   24.039810][ T8117] RSP: 002b:00007fff7856e628 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   24.039815][ T8117] RAX: ffffffffffffffda RBX: 00007fff7856e6e0 RCX: 00007fe293245473
[   24.039818][ T8117] RDX: 0000000000000001 RSI: 000056386e819159 RDI: 0000000000000003
[   24.039820][ T8117] RBP: 0000000000000003 R08: 0000000000004000 R09: 00007fe2932e90c0
[   24.039822][ T8117] R10: 0000000000000000 R11: 0000000000000246 R12: 000056386e819159
[   24.039824][ T8117] R13: 00007fff7856ea60 R14: 00007fff7856ea60 R15: 0000563885c1635b
[   24.039827][ T8117]  </TASK>
[   24.039829][ T8117] 
[   24.039830][ T8117] Freed by task 8117:
[   24.039832][ T8117]  kasan_save_stack (mm/kasan/common.c:57)
[   24.039835][ T8117]  kasan_save_track (mm/kasan/common.c:78)
[   24.039838][ T8117]  kasan_save_free_info (mm/kasan/generic.c:584)
[   24.039841][ T8117]  __kasan_slab_free (mm/kasan/common.c:264 mm/kasan/common.c:296)
[   24.039844][ T8117]  kfree (./include/linux/kasan.h:235 mm/slub.c:2748 mm/slub.c:6509 mm/slub.c:6802)
[   24.039849][ T8117]  device_release (drivers/base/core.c:2645)
[   24.039854][ T8117]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 ./include/linux/kref.h:65 lib/kobject.c:737)
[   24.039859][ T8117]  release_nodes (drivers/base/devres.c:546)
[   24.039862][ T8117]  devres_release_group (drivers/base/devres.c:739)
[   24.039865][ T8117]  i2c_device_remove (drivers/i2c/i2c-core-base.c:637)
[   24.039871][ T8117]  device_release_driver_internal (drivers/base/dd.c:1349 drivers/base/dd.c:1372)
[   24.039874][ T8117]  bus_remove_device (drivers/base/bus.c:664)
[   24.039878][ T8117]  device_del (drivers/base/core.c:3965)
[   24.039882][ T8117]  device_unregister (drivers/base/core.c:4006)
[   24.039885][ T8117]  delete_device_store (drivers/i2c/i2c-core-base.c:1369)
[   24.039889][ T8117]  kernfs_fop_write_iter (fs/kernfs/file.c:345)
[   24.039892][ T8117]  vfs_write (fs/read_write.c:595 fs/read_write.c:687)
[   24.039895][ T8117]  ksys_write (fs/read_write.c:739)
[   24.039899][ T8117]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[   24.039901][ T8117]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
(Full KASAN report, including the trailing slab/page-owner and memory-state info after this point, is in the gist as kasan_report_full.txt. Lines starting with "?" above are stack-scanned frames, not reliable return addresses, and have been omitted here.)

Best,
Dingisoul
