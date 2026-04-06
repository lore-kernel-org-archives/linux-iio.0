Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AB346774
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775455565; cv=none; b=ETPaZSC+e9JOMaw6t48YTqrN4UMpDvQUQSRtFTrG5CtrZpZYfgfzvS+Ivq/VwUpU/NoZRUxTagDfYNZnB0gh1MfRSzP55b84SnToX08Q6jMtBs+T8CrPruU7wYdZ88zFv9vM3BoDa5D06VdkTftJ/Ncix05sjeQCdFs9cdqaFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775455565; c=relaxed/simple;
	bh=LFI5PfHPSliS+2E4Vwftm2dtrm4M1hoISi2YINtRi3Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjjYLoU1NLz9VlFvsjC43xoewy/KEj7BrZOlwygujmOIfI6BGlqZPw8GoX4haH2rWeuPan6xyr57RvOG3NZ7PFKmIIGSvmFe3lZFQaMHdFagRlTGjxcPDmG/twP2/092wXmoJAF/OsFVxliaiiVcW+5ZU8qJWDt2wZhvxm0OwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH2lKixT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH2lKixT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80CEDC4CEF7
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 06:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775455565;
	bh=LFI5PfHPSliS+2E4Vwftm2dtrm4M1hoISi2YINtRi3Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QH2lKixTJNOPq5RH9pWsrUyRTWLnp2IXQaIL6puG/YCwQwGuERUgxrM2QIz+LmQOn
	 E//E5yPShEED5X5fq5pSCRHDqHdcvSYjOpl8ZhsQ7vEwpMMA39hD6b6TD/RYXotYzQ
	 2Gk77afddQJOfjzpoFci7OCrsn48HGBkyZnjXxBgNvCC72qF8q7//Pc+HVgu0AIX2k
	 fKgAjZv1V5cS2wp/HhnBkyJiDxrElV17g9Bfpj7njJdjNcEsF9KllKBIf2hqpj3ajX
	 9oomYeqRQPr51ujO+lyrwl0hXJam9uRcLeV7uiWzvTo9zFn4NP6cATGkIG+MhMk7s4
	 reYXUMLXPihsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 736BBC3279F; Mon,  6 Apr 2026 06:06:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221256] On Boot - WARNING: kernel/irq/manage.c:1502 at
 __setup_irq+0x5bb/0x800, CPU#7: iio-sensor-prox/932
Date: Mon, 06 Apr 2026 06:06:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alain.cousinie@laposte.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221256-217253-ZLBmPGeYOP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221256-217253@https.bugzilla.kernel.org/>
References: <bug-221256-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221256

AlainC (alain.cousinie@laposte.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #6 from AlainC (alain.cousinie@laposte.net) ---
(In reply to Jonathan Cameron from comment #5)
> On Wed, 25 Mar 2026 09:38:48 +0000
> bugzilla-daemon@kernel.org wrote:
>=20
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D221256
> >=20
> > AlainC (alain.cousinie@laposte.net) changed:
> >=20
> >            What    |Removed                     |Added
> >
> -------------------------------------------------------------------------=
---
> >      Kernel Version|                            |7.0
> >          Regression|No                          |Yes
> >=20
> > --- Comment #4 from AlainC (alain.cousinie@laposte.net) ---
> > (In reply to Jonathan Cameron from comment #2)
> > > On Wed, 18 Mar 2026 10:10:29 +0000
> > > bugzilla-daemon@kernel.org wrote:
> > >=20=20=20
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D221256
> > > >=20
> > > >             Bug ID: 221256
> > > >            Summary: On Boot - WARNING: kernel/irq/manage.c:1502 at
> > > >                     __setup_irq+0x5bb/0x800, CPU#7: iio-sensor-prox=
/932
> > > >            Product: Drivers
> > > >            Version: 2.5
> > > >           Hardware: Intel
> > > >                 OS: Linux
> > > >             Status: NEW
> > > >           Severity: high
> > > >           Priority: P3
> > > >          Component: IIO
> > > >           Assignee: drivers_iio@kernel-bugs.kernel.org
> > > >           Reporter: alain.cousinie@laposte.net
> > > >         Regression: No
> > > >=20
> > > > Since the beginning of 7.0 rc1 to rc4, I have had a boot error.
> > > > (I recompile the kernel with each RC release)
> > > >=20
> > > > [    7.425262] ------------[ cut here ]------------
> > > > [    7.425264] WARNING: kernel/irq/manage.c:1502 at=20=20
> > > __setup_irq+0x5bb/0x800,=20=20
> > > > CPU#7: iio-sensor-prox/932
> > > > [    7.425270] Modules linked in: bnep at24 ee1004 spd5118 nls_ascii
> > > > nls_cp437
> > > > vfat fat snd_ctl_led snd_soc_skl_hda_dsp(+)
> > snd_soc_intel_sof_board_helpers
> > > > snd_sof_probes snd_soc_intel_hda_dsp_common snd_hda_codec_intelhdmi
> > > > snd_hda_codec_hdmi snd_hda_codec_alc269 snd_hda_codec_realtek_lib
> > > > snd_hda_scodec_component snd_hda_codec_generic snd_soc_dmic
> snd_hda_intel
> > > > snd_sof_pci_intel_mtl snd_sof_intel_hda_generic soundwire_intel
> > > > soundwire_generic_allocation snd_sof_intel_hda_sdw_bpt
> > > > snd_sof_intel_hda_common
> > > > snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda=20=20
> > > soundwire_cadence=20=20
> > > > snd_sof_pci snd_sof_xtensa_dsp intel_uncore_frequency snd_soc_sdw_u=
tils
> > > > intel_uncore_frequency_common x86_pkg_temp_thermal snd_sof
> > intel_powerclamp
> > > > coretemp iwlmld snd_sof_utils snd_hda_ext_core kvm_intel snd_hda_co=
dec
> > > > snd_hda_core mac80211 kvm snd_intel_dspcfg snd_hda_scodec_cs35l41_s=
pi
> > > > regmap_spi snd_intel_sdw_acpi snd_soc_acpi_intel_match
> > > > snd_soc_acpi_intel_sdca_quirks snd_soc_acpi snd_hwdep crc8
> soundwire_bus
> > > > snd_soc_sdca libarc4
> > > > [    7.425297]  intel_ipu6_isys snd_soc_core btusb videobuf2_dma_sg
> > > > hp_bioscfg(+) videobuf2_memops btmtk videobuf2_v4l2 btrtl irqbypass
> > > > mei_gsc_proxy iwlwifi videobuf2_common intel_rapl_msr
> ghash_clmulni_intel
> > > > snd_compress btbcm aesni_intel firmware_attributes_class ac97_bus
> btintel
> > > > snd_pcm_dmaengine snd_hda_scodec_cs35l41_i2c cfg80211 gf128mul
> > > > snd_hda_scodec_cs35l41 hp_wmi snd_pcm snd_soc_cs_amp_lib bluetooth
> > spi_nor
> > > > hid_sensor_magn_3d hid_sensor_accel_3d hid_sensor_gyro_3d=20=20
> > > hid_sensor_rotation=20=20
> > > > snd_soc_cs35l41_lib hid_sensor_trigger wmi_bmof snd_timer cs_dsp
> > > > processor_thermal_device_pci hid_sensor_iio_common pcspkr mtd intel=
_vpu
> > > > ov08x40
> > > > industrialio_triggered_buffer processor_thermal_device kfifo_buf snd
> > mei_me
> > > > industrialio v4l2_fwnode intel_skl_int3472_tps68470 tps68470_regula=
tor
> > > > processor_thermal_wt_hint v4l2_async mei clk_tps68470 soundcore
> > > > drm_shmem_helper rfkill serial_multi_instantiate videodev
> > > > platform_temperature_control intel_pmc_core
> processor_thermal_soc_slider
> > > > platform_profile processor_thermal_rfim mc
> > > > [    7.425325]  processor_thermal_rapl intel_skl_int3472_discrete
> > > > intel_skl_int3472_common intel_rapl_common joydev
> > processor_thermal_wt_req
> > > > pmt_telemetry intel_ipu6 processor_thermal_power_floor acpi_tad=20=
=20
> > > pmt_discovery=20=20
> > > > int3403_thermal processor_thermal_mbox intel_hid pmt_class ipu_brid=
ge
> > > > int340x_thermal_zone sparse_keymap intel_pmc_ssram_telemetry=20=20
> > > soc_button_array=20=20
> > > > acpi_pad ac igen6_edac button evdev binfmt_misc parport_pc ppdev lp
> > parport
> > > > i2c_dev msr nvme_fabrics efi_pstore nfnetlink efivarfs autofs4 uhci=
_hcd
> > > > ehci_pci ehci_hcd xe drm_ttm_helper drm_suballoc_helper gpu_sched
> > drm_gpuvm
> > > > drm_exec configfs drm_gpusvm_helper hid_sensor_custom hid_sensor_hub
> > usbhid
> > > > intel_ishtp_hid i915 hid_multitouch i2c_algo_bit drm_buddy ttm
> > > > drm_display_helper xhci_pci hid_generic xhci_hcd cec nvme i2c_hid_a=
cpi
> > > > i2c_hid
> > > > rc_core nvme_core ucsi_acpi psmouse hid drm_client_lib typec_ucsi
> > iTCO_wdt
> > > > drm_kms_helper intel_pmc_bxt typec watchdog video intel_ish_ipc rol=
es
> > > > nvme_keyring serio_raw drm usbcore thunderbolt nvme_auth
> int3400_thermal
> > > > battery
> > > > [    7.425359]  intel_ishtp i2c_i801 wmi intel_lpss_pci hkdf=20=20
> > > acpi_thermal_rel=20=20
> > > > fan intel_lpss i2c_smbus usb_common intel_vsec idma64
> > > > [    7.425366] CPU: 7 UID: 0 PID: 932 Comm: iio-sensor-prox Not tai=
nted
> > > > 7.0.0-rc4-meteor #1 PREEMPT(full)=20
> > > > [    7.425368] Hardware name: HP HP Spectre x360 2-in-1 Laptop
> > > > 14-eu0xxx/8C15,
> > > > BIOS F.16 12/16/2025
> > > > [    7.425368] RIP: 0010:__setup_irq+0x5bb/0x800
> > > > [    7.425370] Code: 94 24 f0 00 00 00 e9 cb fe ff ff b8 01 00 00 0=
0 48
> > c7=20=20
> > > c2=20=20
> > > > ff ff ff ff f3 48 0f bc d2 c4 e2 e9 f7 c0 49 89 47 48 e9 86 fd ff ff
> <0f>=20
> > > 0b=20=20
> > > > f6
> > > > c6 80 75 70 81 e2 00 00 01 00 0f 85 c5 fa ff ff 66 90 49
> > > > [    7.425371] RSP: 0018:ffffd1b2c740bb58 EFLAGS: 00010246
> > > > [    7.425373] RAX: 0000000000002000 RBX: ffff8d7942c91700 RCX:
> > > > 0000000000000000
> > > > [    7.425374] RDX: 0000000000000400 RSI: ffff8d7960d9ec00 RDI:
> > > > ffffffffc1876a80
> > > > [    7.425374] RBP: 00000000000000d2 R08: 0000000000000080 R09:
> > > > ffff8d7942c91700
> > > > [    7.425375] R10: 0000000000000000 R11: 0000000000000001 R12:
> > > > ffff8d7960d9ec00
> > > > [    7.425376] R13: ffff8d7960d9ec00 R14: 0000000000000400 R15:
> > > > ffff8d7942c91700
> > > > [    7.425377] FS:  00007f6716751980(0000) GS:ffff8d810f4e4000(0000)
> > > > knlGS:0000000000000000
> > > > [    7.425377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [    7.425378] CR2: 00007fff3d530fd0 CR3: 00000001282b2005 CR4:
> > > > 0000000000f72ef0
> > > > [    7.425379] PKRU: 55555554
> > > > [    7.425380] Call Trace:
> > > > [    7.425381]  <TASK>
> > > > [    7.425382]  ? __kmalloc_cache_noprof+0x12f/0x4b0
> > > > [    7.425385]  ? request_threaded_irq+0x96/0x1a0
> > > > [    7.425389]  ? __pfx_iio_pollfunc_store_time+0x10/0x10
> [industrialio]
> > > > [    7.425393]  request_threaded_irq+0xd9/0x1a0
> > > > [    7.425395]  iio_trigger_attach_poll_func+0xbe/0x1c0 [industrial=
io]
> > > > [    7.425398]  __iio_update_buffers+0xddd/0xed0 [industrialio]
> > > > [    7.425402]  enable_store+0x81/0xe0 [industrialio]
> > > > [    7.425405]  kernfs_fop_write_iter+0x149/0x200
> > > > [    7.425408]  vfs_write+0x363/0x530
> > > > [    7.425411]  __x64_sys_write+0x70/0xe0
> > > > [    7.425412]  do_syscall_64+0x118/0xd70
> > > > [    7.425416]  ? __x64_sys_openat+0xe9/0x230
> > > > [    7.425417]  ? do_syscall_64+0x118/0xd70
> > > > [    7.425418]  ? do_syscall_64+0x118/0xd70
> > > > [    7.425419]  ? do_syscall_64+0x118/0xd70
> > > > [    7.425420]  ? __sysvec_apic_timer_interrupt+0x58/0x140
> > > > [    7.425423]  ? irq_exit_rcu+0x41/0xe0
> > > > [    7.425425]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > [    7.425427] RIP: 0033:0x7f6716b596be
> > > > [    7.425429] Code: 08 0f 85 15 47 ff ff 49 89 fb 48 89 f0 48 89 d=
7 48
> > 89=20=20
> > > ce=20=20
> > > > 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05
> <c3>=20
> > > 90=20=20
> > > > 48
> > > > 83 ec 08 bf 01 00 00 00 e8 a2 e5 05 00 bf 01 00 00 00 89
> > > > [    7.425430] RSP: 002b:00007fff3d532238 EFLAGS: 00000246 ORIG_RAX:
> > > > 0000000000000001
> > > > [    7.425431] RAX: ffffffffffffffda RBX: 0000564c8378b310 RCX:
> > > > 00007f6716b596be
> > > > [    7.425432] RDX: 0000000000000001 RSI: 00007fff3d5323f0 RDI:
> > > > 0000000000000008
> > > > [    7.425432] RBP: 0000000000000001 R08: 0000000000000000 R09:
> > > > 0000000000000000
> > > > [    7.425433] R10: 0000000000000000 R11: 0000000000000246 R12:
> > > > 0000000000000001
> > > > [    7.425433] R13: 00007fff3d5323f0 R14: 0000000000000002 R15:
> > > > 0000000000000001
> > > > [    7.425434]  </TASK>
> > > > [    7.425435] ---[ end trace 0000000000000000 ]---=20=20
> > >=20
> > > There are a number of fixes working their way upstream for warnings f=
rom
> > > the tightening up of parameter checks on the irq_request functions.
> > >=20
> > > Bisection will tell you it was that change of checks rather than find
> > > the real problem.
> > >=20
> > > https://lore.kernel.org/all/20260220224514.471348-1-srinivas.
> > > pandruvada@linux.intel.com/
> > > would be my guess for what was hit here.  That's in a pull request
> waiting
> > > for GregKH to pick up and send on to Linus.
> > >=20
> > > It was an odd bit of usage. There was never actually an interrupt in =
use
> > > despite a handler being registered. That patch cleans that up whilst
> > > going through a dance to avoid an interface regressions. Took us a li=
ttle
> > > while to figure out the necessary dance.
> > >=20
> > > Jonathan
> > >=20
> > >=20
> > >=20
> > >=20=20=20
> > > >=20=20
> >=20
> > (In reply to AlainC from comment #3)
> > > I'm sorry, but I didn't quite understand what you were saying.
> > >=20
> > > I recompiled with the patch from=20
> > > https://lore.kernel.org/all/20260220224514.471348-1-srinivas.
> > > pandruvada@linux.intel.com/
> > > And the result is positive; there are no more errors.
> > >=20
> > > Alain=20=20
> >=20
> > The bug has been present since version 7.0-rc1.
> > Versions 6.19, including 6.19.9, are not affected.
> >=20
> We didn't queue this as a fix because other than an annoying warning mess=
age
> due to tightened sanity checks, it shouldn't actually break anything
> and the fix was complex so I didn't want to rush it in.
>=20
> We can backport anyway once it's merged though if needed.
>=20
> Jonathan

Thanks Jonathan.
Resolved in 7.0-rc7 with the mentioned patch.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
