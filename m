Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1A3290B7
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471050; cv=none; b=hiDcJBMa2G6YfcVgae8KrHEHJfFY0EV8vUmDgNLncEe/vZS0JYwTITLyUEdnnm5BJL+SydPy4okwdWc9lIXSPOnctuaGIKp8d5uvfPB0JnIbdFH/rCULcJFEUc0Ynr/NbpgsAoClOk/ZcWnavfpx4Oz8iWIlBFvuep6XzdgE7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471050; c=relaxed/simple;
	bh=rRD7jpSwcujNjgl+xKWG3Qb5RJvnsyaYNAGZNVPtwcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qC54XhLVf1/A8YkK+FqKPNHyiiyKDrVhKO8quYICRMHRPgMdH5QBpWLG1CxKI9HmN7Iwypsgw6fkYmFjn3renklivna8M0wwvqNXIAeIik33AvEM7BkWtJJuW9ulK6Qja2ptMFuAzU7zztuuHjmrnunqHnhTzxQLA38j0PdCQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWgsKHrm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWgsKHrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DC2C4CEF7;
	Wed, 25 Mar 2026 20:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774471050;
	bh=rRD7jpSwcujNjgl+xKWG3Qb5RJvnsyaYNAGZNVPtwcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sWgsKHrmaiD5EYWVD3cbrkOjVAYdRq/xDaRSyG4zGeuAbiUarnfbi6svsDekOPPFy
	 uLzolpgY+JI24W87yn4A8dmOezezKDk2hq5hY0D+mhqAekR8PVcnXYBX1zB765jLrc
	 j7QEvzGU5elUERJ3ukPhJILFI6To9tvojoamT8DH/LK+9OkUQv3zCDbtEj21NUBM9K
	 zoZWna7I0tCsaDapaR7ph8uj7V5MUe1HfeqWSL1aybB0yuu6kJ6Z2dS8jR5GkT4/K2
	 9axiuNTA9EjMIHMOLqolcXB20YdtpUBN6FQpYmhMWq5IXql6CJzEDRKnvZWNEb3rIU
	 WI5/3Axks/qtw==
Date: Wed, 25 Mar 2026 20:37:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 221256] On Boot - WARNING: kernel/irq/manage.c:1502 at
 __setup_irq+0x5bb/0x800, CPU#7: iio-sensor-prox/932
Message-ID: <20260325203722.48d67ba6@jic23-huawei>
In-Reply-To: <bug-221256-217253-Hck3zIq7Dp@https.bugzilla.kernel.org/>
References: <bug-221256-217253@https.bugzilla.kernel.org/>
	<bug-221256-217253-Hck3zIq7Dp@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 09:38:48 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=221256
> 
> AlainC (alain.cousinie@laposte.net) changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>      Kernel Version|                            |7.0
>          Regression|No                          |Yes
> 
> --- Comment #4 from AlainC (alain.cousinie@laposte.net) ---
> (In reply to Jonathan Cameron from comment #2)
> > On Wed, 18 Mar 2026 10:10:29 +0000
> > bugzilla-daemon@kernel.org wrote:
> >   
> > > https://bugzilla.kernel.org/show_bug.cgi?id=221256
> > > 
> > >             Bug ID: 221256
> > >            Summary: On Boot - WARNING: kernel/irq/manage.c:1502 at
> > >                     __setup_irq+0x5bb/0x800, CPU#7: iio-sensor-prox/932
> > >            Product: Drivers
> > >            Version: 2.5
> > >           Hardware: Intel
> > >                 OS: Linux
> > >             Status: NEW
> > >           Severity: high
> > >           Priority: P3
> > >          Component: IIO
> > >           Assignee: drivers_iio@kernel-bugs.kernel.org
> > >           Reporter: alain.cousinie@laposte.net
> > >         Regression: No
> > > 
> > > Since the beginning of 7.0 rc1 to rc4, I have had a boot error.
> > > (I recompile the kernel with each RC release)
> > > 
> > > [    7.425262] ------------[ cut here ]------------
> > > [    7.425264] WARNING: kernel/irq/manage.c:1502 at  
> > __setup_irq+0x5bb/0x800,  
> > > CPU#7: iio-sensor-prox/932
> > > [    7.425270] Modules linked in: bnep at24 ee1004 spd5118 nls_ascii
> > > nls_cp437
> > > vfat fat snd_ctl_led snd_soc_skl_hda_dsp(+) snd_soc_intel_sof_board_helpers
> > > snd_sof_probes snd_soc_intel_hda_dsp_common snd_hda_codec_intelhdmi
> > > snd_hda_codec_hdmi snd_hda_codec_alc269 snd_hda_codec_realtek_lib
> > > snd_hda_scodec_component snd_hda_codec_generic snd_soc_dmic snd_hda_intel
> > > snd_sof_pci_intel_mtl snd_sof_intel_hda_generic soundwire_intel
> > > soundwire_generic_allocation snd_sof_intel_hda_sdw_bpt
> > > snd_sof_intel_hda_common
> > > snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda  
> > soundwire_cadence  
> > > snd_sof_pci snd_sof_xtensa_dsp intel_uncore_frequency snd_soc_sdw_utils
> > > intel_uncore_frequency_common x86_pkg_temp_thermal snd_sof intel_powerclamp
> > > coretemp iwlmld snd_sof_utils snd_hda_ext_core kvm_intel snd_hda_codec
> > > snd_hda_core mac80211 kvm snd_intel_dspcfg snd_hda_scodec_cs35l41_spi
> > > regmap_spi snd_intel_sdw_acpi snd_soc_acpi_intel_match
> > > snd_soc_acpi_intel_sdca_quirks snd_soc_acpi snd_hwdep crc8 soundwire_bus
> > > snd_soc_sdca libarc4
> > > [    7.425297]  intel_ipu6_isys snd_soc_core btusb videobuf2_dma_sg
> > > hp_bioscfg(+) videobuf2_memops btmtk videobuf2_v4l2 btrtl irqbypass
> > > mei_gsc_proxy iwlwifi videobuf2_common intel_rapl_msr ghash_clmulni_intel
> > > snd_compress btbcm aesni_intel firmware_attributes_class ac97_bus btintel
> > > snd_pcm_dmaengine snd_hda_scodec_cs35l41_i2c cfg80211 gf128mul
> > > snd_hda_scodec_cs35l41 hp_wmi snd_pcm snd_soc_cs_amp_lib bluetooth spi_nor
> > > hid_sensor_magn_3d hid_sensor_accel_3d hid_sensor_gyro_3d  
> > hid_sensor_rotation  
> > > snd_soc_cs35l41_lib hid_sensor_trigger wmi_bmof snd_timer cs_dsp
> > > processor_thermal_device_pci hid_sensor_iio_common pcspkr mtd intel_vpu
> > > ov08x40
> > > industrialio_triggered_buffer processor_thermal_device kfifo_buf snd mei_me
> > > industrialio v4l2_fwnode intel_skl_int3472_tps68470 tps68470_regulator
> > > processor_thermal_wt_hint v4l2_async mei clk_tps68470 soundcore
> > > drm_shmem_helper rfkill serial_multi_instantiate videodev
> > > platform_temperature_control intel_pmc_core processor_thermal_soc_slider
> > > platform_profile processor_thermal_rfim mc
> > > [    7.425325]  processor_thermal_rapl intel_skl_int3472_discrete
> > > intel_skl_int3472_common intel_rapl_common joydev processor_thermal_wt_req
> > > pmt_telemetry intel_ipu6 processor_thermal_power_floor acpi_tad  
> > pmt_discovery  
> > > int3403_thermal processor_thermal_mbox intel_hid pmt_class ipu_bridge
> > > int340x_thermal_zone sparse_keymap intel_pmc_ssram_telemetry  
> > soc_button_array  
> > > acpi_pad ac igen6_edac button evdev binfmt_misc parport_pc ppdev lp parport
> > > i2c_dev msr nvme_fabrics efi_pstore nfnetlink efivarfs autofs4 uhci_hcd
> > > ehci_pci ehci_hcd xe drm_ttm_helper drm_suballoc_helper gpu_sched drm_gpuvm
> > > drm_exec configfs drm_gpusvm_helper hid_sensor_custom hid_sensor_hub usbhid
> > > intel_ishtp_hid i915 hid_multitouch i2c_algo_bit drm_buddy ttm
> > > drm_display_helper xhci_pci hid_generic xhci_hcd cec nvme i2c_hid_acpi
> > > i2c_hid
> > > rc_core nvme_core ucsi_acpi psmouse hid drm_client_lib typec_ucsi iTCO_wdt
> > > drm_kms_helper intel_pmc_bxt typec watchdog video intel_ish_ipc roles
> > > nvme_keyring serio_raw drm usbcore thunderbolt nvme_auth int3400_thermal
> > > battery
> > > [    7.425359]  intel_ishtp i2c_i801 wmi intel_lpss_pci hkdf  
> > acpi_thermal_rel  
> > > fan intel_lpss i2c_smbus usb_common intel_vsec idma64
> > > [    7.425366] CPU: 7 UID: 0 PID: 932 Comm: iio-sensor-prox Not tainted
> > > 7.0.0-rc4-meteor #1 PREEMPT(full) 
> > > [    7.425368] Hardware name: HP HP Spectre x360 2-in-1 Laptop
> > > 14-eu0xxx/8C15,
> > > BIOS F.16 12/16/2025
> > > [    7.425368] RIP: 0010:__setup_irq+0x5bb/0x800
> > > [    7.425370] Code: 94 24 f0 00 00 00 e9 cb fe ff ff b8 01 00 00 00 48 c7  
> > c2  
> > > ff ff ff ff f3 48 0f bc d2 c4 e2 e9 f7 c0 49 89 47 48 e9 86 fd ff ff <0f>  
> > 0b  
> > > f6
> > > c6 80 75 70 81 e2 00 00 01 00 0f 85 c5 fa ff ff 66 90 49
> > > [    7.425371] RSP: 0018:ffffd1b2c740bb58 EFLAGS: 00010246
> > > [    7.425373] RAX: 0000000000002000 RBX: ffff8d7942c91700 RCX:
> > > 0000000000000000
> > > [    7.425374] RDX: 0000000000000400 RSI: ffff8d7960d9ec00 RDI:
> > > ffffffffc1876a80
> > > [    7.425374] RBP: 00000000000000d2 R08: 0000000000000080 R09:
> > > ffff8d7942c91700
> > > [    7.425375] R10: 0000000000000000 R11: 0000000000000001 R12:
> > > ffff8d7960d9ec00
> > > [    7.425376] R13: ffff8d7960d9ec00 R14: 0000000000000400 R15:
> > > ffff8d7942c91700
> > > [    7.425377] FS:  00007f6716751980(0000) GS:ffff8d810f4e4000(0000)
> > > knlGS:0000000000000000
> > > [    7.425377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    7.425378] CR2: 00007fff3d530fd0 CR3: 00000001282b2005 CR4:
> > > 0000000000f72ef0
> > > [    7.425379] PKRU: 55555554
> > > [    7.425380] Call Trace:
> > > [    7.425381]  <TASK>
> > > [    7.425382]  ? __kmalloc_cache_noprof+0x12f/0x4b0
> > > [    7.425385]  ? request_threaded_irq+0x96/0x1a0
> > > [    7.425389]  ? __pfx_iio_pollfunc_store_time+0x10/0x10 [industrialio]
> > > [    7.425393]  request_threaded_irq+0xd9/0x1a0
> > > [    7.425395]  iio_trigger_attach_poll_func+0xbe/0x1c0 [industrialio]
> > > [    7.425398]  __iio_update_buffers+0xddd/0xed0 [industrialio]
> > > [    7.425402]  enable_store+0x81/0xe0 [industrialio]
> > > [    7.425405]  kernfs_fop_write_iter+0x149/0x200
> > > [    7.425408]  vfs_write+0x363/0x530
> > > [    7.425411]  __x64_sys_write+0x70/0xe0
> > > [    7.425412]  do_syscall_64+0x118/0xd70
> > > [    7.425416]  ? __x64_sys_openat+0xe9/0x230
> > > [    7.425417]  ? do_syscall_64+0x118/0xd70
> > > [    7.425418]  ? do_syscall_64+0x118/0xd70
> > > [    7.425419]  ? do_syscall_64+0x118/0xd70
> > > [    7.425420]  ? __sysvec_apic_timer_interrupt+0x58/0x140
> > > [    7.425423]  ? irq_exit_rcu+0x41/0xe0
> > > [    7.425425]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [    7.425427] RIP: 0033:0x7f6716b596be
> > > [    7.425429] Code: 08 0f 85 15 47 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89  
> > ce  
> > > 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3>  
> > 90  
> > > 48
> > > 83 ec 08 bf 01 00 00 00 e8 a2 e5 05 00 bf 01 00 00 00 89
> > > [    7.425430] RSP: 002b:00007fff3d532238 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000001
> > > [    7.425431] RAX: ffffffffffffffda RBX: 0000564c8378b310 RCX:
> > > 00007f6716b596be
> > > [    7.425432] RDX: 0000000000000001 RSI: 00007fff3d5323f0 RDI:
> > > 0000000000000008
> > > [    7.425432] RBP: 0000000000000001 R08: 0000000000000000 R09:
> > > 0000000000000000
> > > [    7.425433] R10: 0000000000000000 R11: 0000000000000246 R12:
> > > 0000000000000001
> > > [    7.425433] R13: 00007fff3d5323f0 R14: 0000000000000002 R15:
> > > 0000000000000001
> > > [    7.425434]  </TASK>
> > > [    7.425435] ---[ end trace 0000000000000000 ]---  
> > 
> > There are a number of fixes working their way upstream for warnings from
> > the tightening up of parameter checks on the irq_request functions.
> > 
> > Bisection will tell you it was that change of checks rather than find
> > the real problem.
> > 
> > https://lore.kernel.org/all/20260220224514.471348-1-srinivas.
> > pandruvada@linux.intel.com/
> > would be my guess for what was hit here.  That's in a pull request waiting
> > for GregKH to pick up and send on to Linus.
> > 
> > It was an odd bit of usage. There was never actually an interrupt in use
> > despite a handler being registered. That patch cleans that up whilst
> > going through a dance to avoid an interface regressions. Took us a little
> > while to figure out the necessary dance.
> > 
> > Jonathan
> > 
> > 
> > 
> >   
> > >  
> 
> (In reply to AlainC from comment #3)
> > I'm sorry, but I didn't quite understand what you were saying.
> > 
> > I recompiled with the patch from 
> > https://lore.kernel.org/all/20260220224514.471348-1-srinivas.
> > pandruvada@linux.intel.com/
> > And the result is positive; there are no more errors.
> > 
> > Alain  
> 
> The bug has been present since version 7.0-rc1.
> Versions 6.19, including 6.19.9, are not affected.
> 
We didn't queue this as a fix because other than an annoying warning message
due to tightened sanity checks, it shouldn't actually break anything
and the fix was complex so I didn't want to rush it in.

We can backport anyway once it's merged though if needed.

Jonathan

