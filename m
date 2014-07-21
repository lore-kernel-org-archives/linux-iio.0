Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43041 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322AbaGUPvh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 21 Jul 2014 11:51:37 -0400
Message-ID: <53CD3859.2090800@linux.intel.com>
Date: Mon, 21 Jul 2014 08:57:13 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Reyad Attiyat <reyad.attiyat@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: Kernel panic when hid-sensor-hub is removed
References: <CA+BWVURSgSNT-H03=YMEcakjcfNkoGgQ6TBNc9DwWOrJ=XT+Lg@mail.gmail.com>
In-Reply-To: <CA+BWVURSgSNT-H03=YMEcakjcfNkoGgQ6TBNc9DwWOrJ=XT+Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Reyad,
On 07/19/2014 12:42 PM, Reyad Attiyat wrote:
> Hey Srinivas,
>
> I noticed a kernel panic when the hid-sensor-hub is removed and a
> trigger/buffer has been setup. My device changes it's HID ID depending
> on which microsoft keyboard is attached. This change removes the USB
> device and reattaches it. I belive the kernel panic happens since it's
> trying to send a usb packet after the device is gone. The usb packet
> is created by hid_sensor_power_state() when the trigger predisabled
> callback is called.
>
> I have a fix that checks hid_device->status before calling
> hid_sensor_power_state() but I had to set hid_device->status, to
> removed, earlier in hid-core hid_destroy_device() for this to work.
>

I think this should be checked at the level of hid_hw_request. IIO level
device driver here shouldn't access hid device struct.
Check with Jiri, if not in the hid_hw_request may be can do in the
sensor_hub_set_feature.

Thanks,
Srinivas

> I'll post the kernel panic below.
> Do you think using hid_device status is appropriate or should some
> other variable be used, maybe one per hid sensor hub device?
>
>
> [  234.449988] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000058
> [  234.450134] IP: [<ffffffff8161746f>] hid_submit_ctrl+0x7f/0x290
> [  234.450234] PGD 0
> [  234.450275] Oops: 0002 [#1] PREEMPT SMP
> [  234.450348] Modules linked in: uinput ip6t_rpfilter ip6t_REJECT
> fuse xt_conntrack ebtable_nat ebtable_broute bridge stp llc
> ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6
> nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw
> ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
> iptable_security iptable_raw mwifiex_usb mwifiex cfg80211
> x86_pkg_temp_thermal rfkill coretemp kvm_intel hid_sensor_rotation
> hid_sensor_als hid_sensor_accel_3d hid_sensor_gyro_3d
> hid_sensor_magn_3d(O) hid_sensor_incl_3d hid_sensor_trigger kvm
> hid_sensor_iio_common industrialio_triggered_buffer
> snd_hda_codec_realtek kfifo_buf snd_hda_codec_generic
> snd_hda_codec_hdmi industrialio snd_hda_intel iTCO_wdt
> iTCO_vendor_support snd_hda_controller
> [  234.451613]  snd_hda_codec vfat fat crc32_pclmul snd_hwdep
> crc32c_intel uvcvideo snd_seq ghash_clmulni_intel videobuf2_vmalloc
> videobuf2_memops microcode videobuf2_core v4l2_common snd_seq_device
> videodev joydev snd_pcm hid_sensor_hub media snd_timer snd
> hid_multitouch i2c_i801 mei_me lpc_ich mei tpm_infineon soundcore
> tpm_tis tpm i2c_hid i2c_designware_platform i2c_designware_core
> binfmt_misc i915 i2c_algo_bit drm_kms_helper drm sd_mod i2c_core video
> [  234.452205] CPU: 2 PID: 39 Comm: khubd Tainted: G          IO
> 3.16.0-rc5+ #112
> [  234.452284] Hardware name: Microsoft Corporation Surface Pro
> 2/Surface Pro 2, BIOS 2.03.0250 09/06/2013
> [  234.452383] task: ffff880118aba6e0 ti: ffff8800daf80000 task.ti:
> ffff8800daf80000
> [  234.452461] RIP: 0010:[<ffffffff8161746f>]  [<ffffffff8161746f>]
> hid_submit_ctrl+0x7f/0x290
> [  234.452558] RSP: 0018:ffff8800daf83750  EFLAGS: 00010086
> [  234.452616] RAX: 0000000080000300 RBX: ffff88003f60c000 RCX: 0000000000000000
> [  234.452690] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff880117f78000
> [  234.452767] RBP: ffff8800daf83788 R08: 0000000000000001 R09: 0000000000000001
> [  234.452842] R10: 0000000000000001 R11: 0000000000000000 R12: ffff880117f78000
> [  234.452919] R13: ffff88003f11a290 R14: 000000000000000c R15: ffff880091cb3ab8
> [  234.452993] FS:  0000000000000000(0000) GS:ffff88011b000000(0000)
> knlGS:0000000000000000
> [  234.453077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  234.453139] CR2: 0000000000000058 CR3: 0000000001c11000 CR4: 00000000001407e0
> [  234.453216] Stack:
> [  234.453241]  ffff880117f3dcd0 ffff880117f78000 ffff88003f60c000
> ffff880117f78000
> [  234.453335]  ffff880117f78000 ffff88003f11a290 0000000000000000
> ffff8800daf837b0
> [  234.453431]  ffffffff81617707 ffff880117f78000 ffff88003f60c000
> 0000000000000013
> [  234.453527] Call Trace:
> [  234.453565]  [<ffffffff81617707>] usbhid_restart_ctrl_queue+0x87/0x140
> [  234.453641]  [<ffffffff81617a88>] usbhid_submit_report+0x2c8/0x370
> [  234.453711]  [<ffffffff81617b4a>] usbhid_request+0x1a/0x30
> [  234.453783]  [<ffffffffa020edfb>] sensor_hub_set_feature+0x8b/0xd0
> [hid_sensor_hub]
> [  234.453867]  [<ffffffffa02d9084>] hid_sensor_power_state+0x84/0x110
> [hid_sensor_trigger]
> [  234.453920]  [<ffffffffa02d9129>]
> hid_sensor_data_rdy_trigger_set_state+0x19/0x20 [hid_sensor_trigger]
> [  234.453981]  [<ffffffffa034d5b7>]
> iio_triggered_buffer_predisable+0xa7/0xb0 [industrialio]
> [  234.454035]  [<ffffffffa034cc4a>] iio_disable_all_buffers+0x3a/0xc0
> [industrialio]
> [  234.454084]  [<ffffffffa03487d3>] iio_device_unregister+0x53/0x80
> [industrialio]
> [  234.454130]  [<ffffffffa026c06a>] hid_accel_3d_remove+0x2a/0x50
> [hid_sensor_accel_3d]
> [  234.454179]  [<ffffffff814f433d>] platform_drv_remove+0x1d/0x40
> [  234.454217]  [<ffffffff814f18bf>] __device_release_driver+0x7f/0xf0
> [  234.454255]  [<ffffffff814f1955>] device_release_driver+0x25/0x40
> [  234.454293]  [<ffffffff814f121c>] bus_remove_device+0x11c/0x1a0
> [  234.454329]  [<ffffffff814ed7d6>] device_del+0x136/0x1e0
> [  234.454369]  [<ffffffff81512190>] ? mfd_cell_disable+0x80/0x80
> [  234.454406]  [<ffffffff814f41d1>] platform_device_del+0x21/0xc0
> [  234.454443]  [<ffffffff814f4282>] platform_device_unregister+0x12/0x30
> [  234.454482]  [<ffffffff815121d3>] mfd_remove_devices_fn+0x43/0x50
> [  234.454518]  [<ffffffff814ed3e3>] device_for_each_child+0x43/0x70
> [  234.454555]  [<ffffffff81512105>] mfd_remove_devices+0x25/0x30
> [  234.454595]  [<ffffffffa020ebd7>] sensor_hub_remove+0x87/0x140
> [hid_sensor_hub]
> [  234.454639]  [<ffffffff81607c5b>] hid_device_remove+0x6b/0xd0
> [  234.454677]  [<ffffffff814f18bf>] __device_release_driver+0x7f/0xf0
> [  234.454734]  [<ffffffff814f1955>] device_release_driver+0x25/0x40
> [  234.454765]  [<ffffffff814f121c>] bus_remove_device+0x11c/0x1a0
> [  234.454795]  [<ffffffff814ed7d6>] device_del+0x136/0x1e0
> [  234.454822]  [<ffffffff81607d47>] hid_destroy_device+0x27/0x60
> [  234.454852]  [<ffffffff81616972>] usbhid_disconnect+0x22/0x50
> [  234.454883]  [<ffffffff81568597>] usb_unbind_interface+0x77/0x2b0
> [  234.454914]  [<ffffffff814f18bf>] __device_release_driver+0x7f/0xf0
> [  234.454945]  [<ffffffff814f1955>] device_release_driver+0x25/0x40
> [  234.454975]  [<ffffffff814f121c>] bus_remove_device+0x11c/0x1a0
> [  234.455005]  [<ffffffff814ed7d6>] device_del+0x136/0x1e0
> [  234.456529]  [<ffffffff81565cd1>] usb_disable_device+0x91/0x2a0
> [  234.457652]  [<ffffffff8155b046>] usb_disconnect+0x96/0x2e0
> [  234.458812]  [<ffffffff8155d74a>] hub_thread+0xb5a/0x1840
> [  234.459947]  [<ffffffff817a1ffc>] ? _raw_spin_unlock_irq+0x2c/0x60
> [  234.461043]  [<ffffffff810edb10>] ? abort_exclusive_wait+0xb0/0xb0
> [  234.462179]  [<ffffffff8155cbf0>] ? hub_port_debounce+0x140/0x140
> [  234.463258]  [<ffffffff810c1379>] kthread+0xf9/0x110
> [  234.464328]  [<ffffffff810c1280>] ? insert_kthread_work+0x80/0x80
> [  234.465404]  [<ffffffff817a2dfc>] ret_from_fork+0x7c/0xb0
> [  234.466437]  [<ffffffff810c1280>] ? insert_kthread_work+0x80/0x80
> [  234.467431] Code: 8d 74 10 01 48 8b 87 a8 19 00 00 48 8b 53 30 48
> 8b 00 8b 80 70 ff ff ff c1 e0 08 84 c9 0f 85 e9 00 00 00 0d 00 00 00
> 80 4d 85 ff <89> 42 58 48 8b 43 30 44 89 b0 88 00 00 00 74 2e 48 8b bb
> 48 18
> [  234.468523] RIP  [<ffffffff8161746f>] hid_submit_ctrl+0x7f/0x290
> [  234.469501]  RSP <ffff8800daf83750>
> [  234.470430] CR2: 0000000000000058
> [  234.478900] ---[ end trace a68f124f1f3439e3 ]---
> [  234.478904] BUG: sleeping function called from invalid context at
> kernel/locking/rwsem.c:41
> [  234.478905] in_atomic(): 1, irqs_disabled(): 1, pid: 39, name: khubd
> [  234.478906] INFO: lockdep is turned off.
> [  234.478907] irq event stamp: 88244
> [  234.478908] hardirqs last  enabled at (88243): [<ffffffff817a1fa5>]
> _raw_spin_unlock_irqrestore+0x65/0x90
> [  234.478912] hardirqs last disabled at (88244): [<ffffffff817a297b>]
> _raw_spin_lock_irqsave+0x2b/0xa0
> [  234.478914] softirqs last  enabled at (88204): [<ffffffff8109cc0b>]
> __do_softirq+0x21b/0x4e0
> [  234.478917] softirqs last disabled at (88185): [<ffffffff8109d0b5>]
> irq_exit+0xc5/0xd0
> [  234.478919] Preemption disabled at:[<ffffffff816177f8>]
> usbhid_submit_report+0x38/0x370
>
> [  234.478924] CPU: 2 PID: 39 Comm: khubd Tainted: G      D   IO
> 3.16.0-rc5+ #112
> [  234.478926] Hardware name: Microsoft Corporation Surface Pro
> 2/Surface Pro 2, BIOS 2.03.0250 09/06/2013
> [  234.478927]  ffffffff81a4e169 ffff8800daf833b8 ffffffff8179924a
> 0000000000000000
> [  234.478929]  ffff8800daf833e0 ffffffff810cbf20 ffff880118a6e2b8
> ffff880118a6e328
> [  234.478932]  ffff8800daf836a8 ffff8800daf83408 ffffffff817a056a
> ffff8800daf83418
> [  234.478934] Call Trace:
> [  234.478937]  [<ffffffff8179924a>] dump_stack+0x4e/0x7a
> [  234.478940]  [<ffffffff810cbf20>] __might_sleep+0x170/0x260
> [  234.478942]  [<ffffffff817a056a>] down_read+0x2a/0xa0
> [  234.478946]  [<ffffffff810ad004>] exit_signals+0x24/0x130
> [  234.478948]  [<ffffffff81098d0d>] do_exit+0xbd/0xd90
> [  234.478952]  [<ffffffff8110ee35>] ? kmsg_dump+0x145/0x210
> [  234.478954]  [<ffffffff8110ed12>] ? kmsg_dump+0x22/0x210
> [  234.478958]  [<ffffffff8101e99b>] oops_end+0x9b/0xe0
> [  234.478961]  [<ffffffff81061c8c>] no_context+0x12c/0x300
> [  234.478963]  [<ffffffff81061eed>] __bad_area_nosemaphore+0x8d/0x220
> [  234.478965]  [<ffffffff81062093>] bad_area_nosemaphore+0x13/0x20
> [  234.478967]  [<ffffffff8106242e>] __do_page_fault+0xce/0x620
> [  234.478970]  [<ffffffff810ed684>] ? __wake_up+0x44/0x50
> [  234.478973]  [<ffffffff813e1017>] ? debug_smp_processor_id+0x17/0x20
> [  234.478976]  [<ffffffff810f623b>] ? get_lock_stats+0x2b/0x60
> [  234.478978]  [<ffffffff810f63de>] ? put_lock_stats.isra.29+0xe/0x30
> [  234.478980]  [<ffffffff810f681e>] ? lock_release_holdtime.part.30+0xde/0x160
> [  234.478983]  [<ffffffff813d689d>] ? trace_hardirqs_off_thunk+0x3a/0x3c
> [  234.478985]  [<ffffffff810629a2>] do_page_fault+0x22/0x30
> [  234.478988]  [<ffffffff817a4f68>] page_fault+0x28/0x30
> [  234.478991]  [<ffffffff8161746f>] ? hid_submit_ctrl+0x7f/0x290
> [  234.478993]  [<ffffffff81617707>] usbhid_restart_ctrl_queue+0x87/0x140
> [  234.478996]  [<ffffffff81617a88>] usbhid_submit_report+0x2c8/0x370
> [  234.478998]  [<ffffffff81617b4a>] usbhid_request+0x1a/0x30
> [  234.479004]  [<ffffffffa020edfb>] sensor_hub_set_feature+0x8b/0xd0
> [hid_sensor_hub]
> [  234.479008]  [<ffffffffa02d9084>] hid_sensor_power_state+0x84/0x110
> [hid_sensor_trigger]
> [  234.479011]  [<ffffffffa02d9129>]
> hid_sensor_data_rdy_trigger_set_state+0x19/0x20 [hid_sensor_trigger]
> [  234.479016]  [<ffffffffa034d5b7>]
> iio_triggered_buffer_predisable+0xa7/0xb0 [industrialio]
> [  234.479020]  [<ffffffffa034cc4a>] iio_disable_all_buffers+0x3a/0xc0
> [industrialio]
> [  234.479024]  [<ffffffffa03487d3>] iio_device_unregister+0x53/0x80
> [industrialio]
> [  234.479027]  [<ffffffffa026c06a>] hid_accel_3d_remove+0x2a/0x50
> [hid_sensor_accel_3d]
> [  234.479030]  [<ffffffff814f433d>] platform_drv_remove+0x1d/0x40
> [  234.479033]  [<ffffffff814f18bf>] __device_release_driver+0x7f/0xf0
> [  234.479036]  [<ffffffff814f1955>] device_release_driver+0x25/0x40
> [  234.479038]  [<ffffffff814f121c>] bus_remove_device+0x11c/0x1a0
> [  234.479040]  [<ffffffff814ed7d6>] device_del+0x136/0x1e0
> [  234.479042]  [<ffffffff81512190>] ? mfd_cell_disable+0x80/0x80
> [  234.479045]  [<ffffffff814f41d1>] platform_device_del+0x21/0xc0
> [  234.479047]  [<ffffffff814f4282>] platform_device_unregister+0x12/0x30
> [  234.479049]  [<ffffffff815121d3>] mfd_remove_devices_fn+0x43/0x50
> [  234.479051]  [<ffffffff814ed3e3>] device_for_each_child+0x43/0x70
> [  234.479053]  [<ffffffff81512105>] mfd_remove_devices+0x25/0x30
> [  234.479057]  [<ffffffffa020ebd7>] sensor_hub_remove+0x87/0x140
> [hid_sensor_hub]
> [  234.479059]  [<ffffffff81607c5b>] hid_device_remove+0x6b/0xd0
> [  234.479063]  [<ffffffff814f18bf>] __device_release_driver+0x7f/0xf0
> [  234.479065]  [<ffffffff814f1955>] device_release_driver+0x25/0x40
> [  234.479067]  [<ffffffff814f121c>] bus_remove_device+0x11c/0x1a0
> [  234.479069]  [<ffffffff814ed7d6>] device_del+0x136/0x1e0
> [  234.479071]  [<ffffffff81607d47>] hid_destroy_device+0x27/0x60
> [  234.479074]  [<ffffffff81616972>] usbhid_disconnect+0x22/0x50
> [  234.479076]  [<ffffffff81568597>] usb_unbind_interface+0x77/0x2b0
> [  234.479079]  [<ffffffff814f18bf>] __device_release_driver+0x7f/0xf0
> [  234.479081]  [<ffffffff814f1955>] device_release_driver+0x25/0x40
> [  234.479083]  [<ffffffff814f121c>] bus_remove_device+0x11c/0x1a0
> [  234.479085]  [<ffffffff814ed7d6>] device_del+0x136/0x1e0
> [  234.479088]  [<ffffffff81565cd1>] usb_disable_device+0x91/0x2a0
> [  234.479090]  [<ffffffff8155b046>] usb_disconnect+0x96/0x2e0
> [  234.479092]  [<ffffffff8155d74a>] hub_thread+0xb5a/0x1840
> [  234.479094]  [<ffffffff817a1ffc>] ? _raw_spin_unlock_irq+0x2c/0x60
> [  234.479096]  [<ffffffff810edb10>] ? abort_exclusive_wait+0xb0/0xb0
> [  234.479098]  [<ffffffff8155cbf0>] ? hub_port_debounce+0x140/0x140
> [  234.479101]  [<ffffffff810c1379>] kthread+0xf9/0x110
> [  234.479103]  [<ffffffff810c1280>] ? insert_kthread_work+0x80/0x80
> [  234.479106]  [<ffffffff817a2dfc>] ret_from_fork+0x7c/0xb0
> [  234.479107]  [<ffffffff810c1280>] ? insert_kthread_work+0x80/0x80
>
> Thanks,
> Reyad Attiyat
>

