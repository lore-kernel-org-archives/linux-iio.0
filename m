Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34761 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbcDZXOK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2016 19:14:10 -0400
Date: Tue, 26 Apr 2016 18:07:55 -0500
From: Michael Welling <mwelling@ieee.org>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, mranostay@gmail.com,
	jic23@kernel.org, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org
Subject: Re: Regression in inv_mpu6050: 4.6.0-rc5
Message-ID: <20160426230755.GA6235@deathstar>
References: <20160426232651.099a18d7@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160426232651.099a18d7@lxorguk.ukuu.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 26, 2016 at 11:26:51PM +0100, One Thousand Gnomes wrote:
> 
> This now causes us to crash and burn on the ASUS T100TA Baytrail/T
> platforms
>

I believe this regression has already been patched.

Check the latest commits in linux-next.

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c

See if the latest patches fix your issue.

> [    9.308605] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
> [    9.310735] IP: [<ffffffffc046622e>] inv_mpu_probe+0x5e/0x110 [inv_mpu6050_i2c]
> [    9.312876] PGD 0 
> [    9.314956] Oops: 0000 [#1] SMP 
> [    9.317018] Modules linked in: inv_mpu6050_i2c(+) aes_x86_64 lrw gf128mul inv_mpu6050 glue_helper ablk_helper cryptd industrialio_triggered_buffer kfifo_buf industrialio snd_intel_sst_acpi snd_intel_sst_core i2c_mux snd_soc_rt5640 snd_soc_sst_mfld_platform snd_soc_rl6231 snd_soc_sst_match input_leds snd_soc_core hci_uart snd_compress snd_pcm_dmaengine lpc_ich snd_pcm btbcm snd_seq_midi btintel snd_seq_midi_event bluetooth snd_rawmidi wmi snd_seq snd_seq_device dw_dmac snd_timer dw_dmac_core soc_button_array snd soundcore processor_thermal_device int3402_thermal ac97_bus int3403_thermal int3400_thermal i2c_designware_platform intel_soc_dts_iosf int340x_thermal_zone acpi_thermal_rel acpi_pad i2c_designware_core pwm_lpss_platform pwm_lpss ipv6 autofs4 i915 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect
> [    9.326919]  sysimgblt fb_sys_fops drm mmc_block hid_generic usbhid i2c_hid video hid sdhci_acpi sdhci
> [    9.332174] CPU: 3 PID: 326 Comm: systemd-udevd Not tainted 4.6.0-rc5+ #3
> [    9.334899] Hardware name: ASUSTeK COMPUTER INC. T100TA/T100TA, BIOS T100TA.307 05/09/2014
> [    9.337655] task: ffff8800706dde80 ti: ffff880035928000 task.ti: ffff880035928000
> [    9.340428] RIP: 0010:[<ffffffffc046622e>]  [<ffffffffc046622e>] inv_mpu_probe+0x5e/0x110 [inv_mpu6050_i2c]
> [    9.343286] RSP: 0018:ffff88003592bad8  EFLAGS: 00010287
> [    9.346132] RAX: ffff88003523e000 RBX: ffff880070d57000 RCX: ffff880070e51a40
> [    9.349006] RDX: ffff880070e51a20 RSI: 00000000000000cf RDI: ffff88003523e000
> [    9.351863] RBP: ffff88003592bb08 R08: ffff88007558c9f8 R09: ffff880070e51a40
> [    9.354713] R10: ffff880070e51a38 R11: 0000000000000000 R12: 0000000000000000
> [    9.357569] R13: ffff880070d57000 R14: ffffffffc04661d0 R15: ffff880070d57004
> [    9.360431] FS:  00007f56017618c0(0000) GS:ffff880078980000(0000) knlGS:0000000000000000
> [    9.363330] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.366226] CR2: 0000000000000018 CR3: 00000000359f6000 CR4: 00000000001006e0
> [    9.369140] Stack:
> [    9.371988]  ffffffff81303a32 00000000000000cf ffff880070d57020 ffffffffc04670c0
> [    9.374883]  ffff880070d57020 ffff880070d57000 ffff88003592bb40 ffffffff8141ea6b
> [    9.377769]  ffff880070d57020 0000000000000000 ffffffffc0468038 0000000000000029
> [    9.380650] Call Trace:
> [    9.383493]  [<ffffffff81303a32>] ? acpi_dev_pm_attach+0x85/0xa2
> [    9.386382]  [<ffffffff8141ea6b>] i2c_device_probe+0xfb/0x1b0
> [    9.389260]  [<ffffffff8138be67>] driver_probe_device+0x227/0x440
> [    9.392130]  [<ffffffff8138c14c>] __driver_attach+0xcc/0xf0
> [    9.395000]  [<ffffffff8138c080>] ? driver_probe_device+0x440/0x440
> [    9.397875]  [<ffffffff81389a07>] bus_for_each_dev+0x67/0xb0
> [    9.400759]  [<ffffffff8138b599>] driver_attach+0x19/0x20
> [    9.403636]  [<ffffffff8138b031>] bus_add_driver+0x1e1/0x280
> [    9.406539]  [<ffffffffc0076000>] ? 0xffffffffc0076000
> [    9.409424]  [<ffffffff8138c8bb>] driver_register+0x5b/0xd0
> [    9.412278]  [<ffffffff8141f666>] i2c_register_driver+0x26/0x90
> [    9.415171]  [<ffffffffc0076017>] inv_mpu_driver_init+0x17/0x19 [inv_mpu6050_i2c]
> [    9.418058]  [<ffffffff810003de>] do_one_initcall+0xae/0x1f0
> [    9.420972]  [<ffffffff8113f07b>] ? kmem_cache_alloc+0x2b/0xc0
> [    9.423856]  [<ffffffff810fbfa3>] do_init_module+0x55/0x1c5
> [    9.426770]  [<ffffffff810c0733>] load_module+0x2123/0x2730
> [    9.429664]  [<ffffffff810bd8f0>] ? __symbol_put+0x50/0x50
> [    9.432537]  [<ffffffff810c0fb6>] SYSC_finit_module+0xe6/0x120
> [    9.435382]  [<ffffffff810c1009>] SyS_finit_module+0x9/0x10
> [    9.438212]  [<ffffffff8152819f>] entry_SYSCALL_64_fastpath+0x17/0x93
> [    9.441015] Code: 00 00 00 31 c9 31 d2 48 89 df 48 c7 c6 e0 70 46 c0 e8 37 e7 f3 c0 48 3d 00 f0 ff ff 48 89 c7 0f 87 94 00 00 00 8b b3 d0 02 00 00 <45> 8b 44 24 18 31 c9 4c 89 e2 e8 b3 b9 06 00 85 c0 78 4f 48 8b 
> [    9.446976] RIP  [<ffffffffc046622e>] inv_mpu_probe+0x5e/0x110 [inv_mpu6050_i2c]
> [    9.449967]  RSP <ffff88003592bad8>
> [    9.452844] CR2: 0000000000000018
> [    9.455673] ---[ end trace d9e48d40f1079c34 ]---
> 
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
