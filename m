Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8AA12C534
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464765; cv=none; b=LiYlhh3vx9wnrfxYLNgJZ+qo6YNToSZNV7qeAp3OrneT2eqfoIoWm9PPbSIZ62531+sCKXdquhy748Y5wzVRmqX3NSgZFRM4D0taTHJFM40ScIAudCoIMDNgs/+0/4468L6L7e692C42YEhesqw6bfmFlqMpc51xiICyCnWA7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464765; c=relaxed/simple;
	bh=kwRwajX0NpTQhq/ferE78iMulVMJWONC7haTFQi7XJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9bOB6TXRw104OyFmkSEssueB/WztCw2LteoQytNAEF4bYaYduxu8uy16VKdg9fQKaIrtYFi8ajj4sIJ+FZICOWVmi6MFlSOs1ihYT/GRsUa6GkV2GrvWUdxDPlrm2zUnGM5F0f2t6KZMc2r1i+Gkv4KF4v6IDS+dWTS9LwOe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBrcdlxD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBrcdlxD"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5175cb5946dso20095321cf.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781464763; x=1782069563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIMALptmH08hDIBGn9+50C8C0r6VnVr/CsdRlyfvq20=;
        b=EBrcdlxDcVDSGWsP9KANCJ41/mGJT09SxGnxSFr20cZs36sHdcDOddqC4i/UoOS2KA
         3LFvlumx7LWs718cQr1xAkS/S5BCPEDFpKc2dSLz+MwZDG6LvyMFqf4sZBA/V5TapsZS
         yj/u0JZuV8PuLlX3FdnDpm7Vux0iPMKSg++IIRIaFi73xgHpN9d8zRnl92Do6TkGAd/z
         2uFsBMOXPwC53+0YWjUBVsWGx6J9o23AeUVY+TzcoC6cHoPGvl9jukc/i7EkXyLAyEJn
         31E1kO6YaMzHlFA+ul2vY7+SooiHq1q+2L42HhEO/oOe9aLJS4uqdIDL+23InrQiunws
         FCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464763; x=1782069563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIMALptmH08hDIBGn9+50C8C0r6VnVr/CsdRlyfvq20=;
        b=Q3Qph3iRYH9XuReCBwQIJjULx6QwnBJfsZNoq+/xFwW7UWvIuOt1WYx4oV/jtjzd2c
         TJr9p58ESEbsY1LccHwOJPecCyzKgvlFVOZssMGUMC1iTgxLNT+7NXJcUeRNGNMA11vi
         J2FkmvlIowB1r8JT+8piGfI/vdq03Cj+1cLedNaL28w1eO1/CAWHM5Fou42f+5gdI1Bo
         klGszE1N6gC6r2MBnA+xREIPep4VQKJr2Q14SJPvDP4Lw6XVy5/bbfbehV79l+zLlYTI
         jyd8dsJyNUmK4rMxwvgaP/nAV/wuXrGw2r7uyw1Ud+na/N9DZOMoWn1ca7jl4/RrjYZQ
         AbDQ==
X-Forwarded-Encrypted: i=1; AFNElJ96TPDH4Yak5rawDGpyB/rohRAhP0YXscSp8zyR6dKn2r4TcGd5y8BVUcWQDcPqItY2rLaN1D91u/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJufgyLx4jvWjkbS9zONaFi3/BYrOBFM+cW+fL1hwfUIaCZiA
	oV4ovlphEjr7XgG/1H15tSAGDYory+nP1YS1oa80rzw+7a+1NnH7O5XR0snt6J/bjDA=
X-Gm-Gg: Acq92OEvFDGJ7oaBgbf/iQKBBN3L2CaZkuP7VUQ832bP+i74TmjtK2JdcDM5euf/z8a
	70qTadpWxetxFoDEC1vviH70hf9+YHjfVmXl2REFwXavPWan/LtoBOHOFQ+sRab6Fie4B4bybkc
	TjRHBaoEJRLW0cG908fwKXBwKhCZBXYc/07H4MNNH1kcbD4ZcaSH8WIx0uvdcw6mptv5+I66jpX
	tJtifVaSQihOdk+rhn7Gg5PjJ6qG6TP+u4tgmgv+/5KuXbgEkPQi7sttieOIJpBremuRyCoSPsH
	GH2fB1BIfWm0Kur3PlIuPZqZlqPClgRwJDy6uVmeHw3K6SiD3SfPQbn3yWx9BwGfbijP64dc3EM
	gzdYernV2ChaX4FAhrgwhZcAk/4YBBYnZN5y52AHS+ERN1Vl570KHgTMIF/MTNlhke0YFAA10V6
	68quJflRp6AH+ibF13DXrt/Lj5HZsDpiK0drJpjYOtIuHVxWz4747IKQyvsjZXQxmUcfDtS7Wtq
	r8f72zrhsWf
X-Received: by 2002:a05:622a:8d12:b0:50e:6139:492b with SMTP id d75a77b69052e-517fe52f307mr156447131cf.23.1781464763075;
        Sun, 14 Jun 2026 12:19:23 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:a8d1:8eec:5c3c:2f7e:d7e3:b1bd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61fb15sm82414491cf.5.2026.06.14.12.19.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 12:19:22 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] KASAN: slab-use-after-free in _raw_spin_lock_irqsave from hid-sensor-custom
Date: Sun, 14 Jun 2026 15:19:21 -0400
Message-ID: <178144969601.60470.12928355382146160896@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in _raw_spin_lock_irqsave from hid-sensor-custom

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/d82ac0d19fda016e81d7fa1ab028d967

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   73.157590][ T8356] BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:1300 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:166)
[   73.161235][ T8356] Write of size 4 at addr ffff88810eb72528 by task hid_sensor_cust/8356
[   73.163453][ T8356] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   73.163457][ T8356] Call Trace:
[   73.163461][ T8356]  <TASK>
[   73.163464][ T8356]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   73.163471][ T8356]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   73.163486][ T8356]  kasan_report (mm/kasan/report.c:595)
[   73.163495][ T8356]  kasan_check_range (mm/kasan/generic.c:? mm/kasan/generic.c:200)
[   73.163500][ T8356]  _raw_spin_lock_irqsave (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:1300 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:166)
[   73.163539][ T8356]  add_wait_queue (kernel/sched/wait.c:23)
[   73.163547][ T8356]  hid_sensor_custom_poll (include/linux/poll.h:45 drivers/hid/hid-sensor-custom.c:706)
[   73.163556][ T8356]  do_sys_poll (include/linux/poll.h:82 fs/select.c:877 fs/select.c:920 fs/select.c:1015)
[   73.163692][ T8356]  __x64_sys_poll (fs/select.c:1072 fs/select.c:1060 fs/select.c:1060)
[   73.163708][ T8356]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   73.163714][ T8356]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   73.163755][ T8356]  </TASK>
[   73.214615][ T8356] Freed by task 781 on cpu 1 at 72.569353s:
[   73.215524][ T8356]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   73.216247][ T8356]  kasan_save_free_info (mm/kasan/generic.c:584)
[   73.217018][ T8356]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   73.217739][ T8356]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[   73.218335][ T8356]  devres_release_all (drivers/base/devres.c:50 drivers/base/devres.c:547 drivers/base/devres.c:576)
[   73.219108][ T8356]  device_release_driver_internal (drivers/base/dd.c:598 drivers/base/dd.c:1357 drivers/base/dd.c:1375)
[   73.220034][ T8356]  bus_remove_device (drivers/base/bus.c:657)
[   73.220796][ T8356]  device_del (drivers/base/core.c:3895)
[   73.221458][ T8356]  platform_device_unregister (drivers/base/platform.c:797 drivers/base/platform.c:839)
[   73.222310][ T8356]  mfd_remove_devices_fn (drivers/mfd/mfd-core.c:385)
[   73.223121][ T8356]  device_for_each_child_reverse (drivers/base/core.c:4065)
[   73.224033][ T8356]  mfd_remove_devices (drivers/mfd/mfd-core.c:401)
[   73.224779][ T8356]  hid_device_remove (drivers/hid/hid-core.c:?)
[   73.225537][ T8356]  device_release_driver_internal (drivers/base/dd.c:619 drivers/base/dd.c:1352 drivers/base/dd.c:1375)
[   73.226449][ T8356]  bus_remove_device (drivers/base/bus.c:657)
[   73.227200][ T8356]  device_del (drivers/base/core.c:3895)
[   73.227857][ T8356]  hid_destroy_device (drivers/hid/hid-core.c:3064 drivers/hid/hid-core.c:3086)
[   73.228617][ T8356]  usbhid_disconnect (drivers/hid/usbhid/hid-core.c:1476)
[   73.238613][ T8356] The buggy address belongs to the object at ffff88810eb72400
[   73.238613][ T8356]  which belongs to the cache kmalloc-512 of size 512
[   73.240744][ T8356] The buggy address is located 296 bytes inside of
[   73.240744][ T8356]  freed 512-byte region [ffff88810eb72400, ffff88810eb72600)


Best,
Shuangpeng
