Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6D3090C5
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856916; cv=none; b=XzvKCiWGuBb8QnxkVYwS4Ju5hkzYhe5RAKSKQYzLop6Pzh+fE4x28VBmA5Kkz2dEYF1xvUji5YIO0piiyqdw3/sCez297KqZd7Cqgo/zKmJLKJEezV/b9NPLv2w8VeZoGT0G1wOYlSA3fYrME0Scmzn5X0dl87nwr7W3zX8Z5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856916; c=relaxed/simple;
	bh=MqCMd9Zd/qG9WhHx9A+i28d4eBIHodI0dxaGD3oThPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BStPe3iLOyHJvL/bVAiTIEfu2CixaxjweMTBrXrrYdGK4FseJWimC4suBieC2JcVWFiwYKrGmVdGPwuV9f1KR1I2HSiS9R5I2iC9STRLEoJVsDvPEGIPUMlGtL6k2KYEzT5pACrlTqvsmC5bFJcDTiur3U3/mCLp8fhR9vjd1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmyTA4r0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmyTA4r0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAE6C2BCB7;
	Fri, 15 May 2026 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778856915;
	bh=MqCMd9Zd/qG9WhHx9A+i28d4eBIHodI0dxaGD3oThPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qmyTA4r0Iy5imjoX4Ctn5kWPmMBoGStlg6BtJ8Wav8StHTuFBbmrtiiUik5VHWrlG
	 9Paavi5mEDFxPcBwA6mYARfE7DYzbxHcarnu74GcqzgcdTLpDfAS2URglzsFF0zNMt
	 mE3QGnEc4PTfqAZVokthUps5qNDPYYkDBHwaB2T8AGGRax27qizVgrjRK+xzXj0y/1
	 DzRCdITEkzl+AG1HJm3F6iVifJH9zNEElWREeHr3i+/ALvWqQJDgZl2bA0B058YIU1
	 9LNn/bhiKX8hH4fly6AspTgfSh1WPMbeickIHZLp5qscciQrHGLbIjoC54h6rRiIov
	 srm34AzmB5muQ==
Date: Fri, 15 May 2026 15:55:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Damjan Georgievski <gdamjan@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: only set IRQF_ONESHOT when thread handler
 is provided
Message-ID: <20260515155508.4c606a23@jic23-huawei>
In-Reply-To: <CAEk1YH7jYFHPJFEZrsW9Nuzy0RAiYa_HdQfx3nbv=Wnp=2-qxw@mail.gmail.com>
References: <20260515-patch-iio-buffer-v1-1-667dac4e55e5@gmail.com>
	<agb5hiF6GhNwGa6c@ashevche-desk.local>
	<20260515152005.355fffaf@jic23-huawei>
	<CAEk1YH7jYFHPJFEZrsW9Nuzy0RAiYa_HdQfx3nbv=Wnp=2-qxw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 16:47:50 +0200
Damjan Georgievski <gdamjan@gmail.com> wrote:

> On Fri, 15 May 2026 at 16:20, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 15 May 2026 13:46:30 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > =20
> > > On Fri, May 15, 2026 at 12:46:00AM +0200, =D0=94=D0=B0=D0=BC=D1=98=D0=
=B0=D0=BD =D0=93=D0=B5=D0=BE =D1=80=D0=B3=D0=B8=D0=B5=D0=B2=D1=81=D0=BA=D0=
=B8 wrote: =20
> > > > iio_triggered_buffer_setup_ext() unconditionally passes IRQF_ONESHO=
T to
> > > > iio_alloc_pollfunc(), even when the caller provides no thread funct=
ion.
> > > > This causes a warning in __setup_irq() when the trigger is later
> > > > attached:
> > > >
> > > >   WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x4ee/0x700
> > > >
> > > > IRQF_ONESHOT keeps the IRQ masked until the threaded handler comple=
tes,
> > > > but with no threaded handler this is semantically wrong. Only set t=
he
> > > > flag when a thread function is actually provided. =20
> > >
> > > Yes, please read the mailing list archive and find the previous attem=
pt to fix
> > > this and the associated discussions.
> > > =20
> >
> >
> > Just to check - what is the driver in use?  The fixes so far all belong=
 in the
> > drivers, not papering over it in the core (note this is maybe the 3rd t=
ime
> > this same patch has been posted and rejected!) =20
>=20
>=20
> good to know,
> that's what I get for using AI :D
>=20
> this started happening after
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D043251b2dd1c2b0cd23f67830748493fd3d3ed0f
> was merged and that made "intel_ish_hid" successfully enable the
> ambient light sensor on the Thinkpad X9-14.
>=20
> Not sure which exactly driver ended up triggering the warning, is it
> possible it is " hid_sensor_prox"?

I believe hid should already be fixed.

c47ac75f5f24020cc0c8b835457a7637ad450939 iio: hid-sensors: Use software tri=
gger

Maybe something is missing however. Can you check if you have that commit?
I think due to it coming in late last cycle and me travelling it went in
during the last merge window.

Jonathan

>=20
>=20
> full warning is
>=20
> ar 30 02:21:11 kernel: ------------[ cut here ]------------
> Mar 30 02:21:11 kernel: WARNING: kernel/irq/manage.c:1502 at
> __setup_irq+0x4ee/0x700, CPU#3: iio-sensor-prox/878
> Mar 30 02:21:11 kernel: Modules linked in: uinput cmac algif_hash
> algif_skcipher af_alg bnep vfat fat snd_soc_sof_sdw snd_sof_probes
> snd_soc_intel_hda_dsp_common snd_soc_cs42l43 spi_cs42l43
> snd_soc_cs42l43_sdw pinctrl_cs42l43 snd_soc_cs35l56_sdw
> snd_soc_cs35l56 snd_soc_cs35l56_shared cs42l43_sdw snd_soc_cs_amp_lib
> regmap_sdw snd_soc_wm_adsp snd_hda_codec_intelhdmi cs_dsp cs42l43
> snd_hda_codec_hdmi snd_soc_dmic hid_sensor_prox hid_sensor_als
> hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
> hid_sensor_iio_common industrialio hid_sensor_custom hid_sensor_hub
> intel_ishtp_hid snd_hda_intel snd_sof_pci_intel_lnl
> snd_sof_pci_intel_mtl snd_sof_intel_hda_generic soundwire_intel
> snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_hda
> snd_sof_intel_hda_mlink snd_sof_intel_hda soundwire_cadence
> snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core
> intel_uncore_frequency intel_uncore_frequency_common
> x86_pkg_temp_thermal snd_hda_codec snd_hda_core xe intel_powerclamp
> snd_intel_dspcfg snd_intel_sdw_acpi
> Mar 30 02:21:11 kernel:  snd_soc_acpi_intel_match
> snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocation
> snd_soc_sdw_utils snd_soc_acpi coretemp intel_ipu7_isys(C) snd_hwdep
> videobuf2_dma_sg drm_gpusvm_helper soundwire_bus videobuf2_memops
> drm_gpuvm kvm_intel snd_soc_sdca videobuf2_v4l2 joydev gpu_sched
> videobuf2_common lenovo_wmi_other mousedev snd_ctl_led mei_gsc_proxy
> intel_rapl_msr wacom drm_buddy processor_thermal_device_pci
> snd_soc_core hid_multitouch lenovo_wmi_helpers kvm drm_exec
> processor_thermal_device lenovo_wmi_capdata drm_suballoc_helper
> processor_thermal_wt_hint snd_compress think_lmi iwlmld drm_ttm_helper
> ac97_bus irqbypass platform_temperature_control ttm snd_pcm_dmaengine
> firmware_attributes_class wmi_bmof snd_pcm rapl imx471 i2c_algo_bit
> thinkpad_acpi processor_thermal_soc_slider ucsi_acpi
> processor_thermal_rfim mac80211 v4l2_fwnode processor_thermal_rapl
> snd_timer drm_display_helper v4l2_async typec_ucsi platform_profile
> btintel_pcie intel_cstate intel_rapl_common intel_ipu7(C) pcspkr
> intel_uncore typec
> Mar 30 02:21:11 kernel:  videodev spi_nor processor_thermal_wt_req ptp
> snd intel_quicki2c intel_ish_ipc intel_skl_int3472_tps68470
> intel_pmc_core cec btintel mei_me soundcore pps_core
> processor_thermal_power_floor roles tps68470_regulator clk_tps68470
> pmt_telemetry libarc4 mtd video crc8 bluetooth mei iwlwifi intel_ishtp
> intel_vpu intel_thc thunderbolt processor_thermal_mbox mc ipu_bridge
> i2c_hid_acpi pmt_discovery i2c_hid pmt_class intel_pmc_ssram_telemetry
> int3400_thermal intel_hid intel_skl_int3472_discrete int3403_thermal
> soc_button_array int340x_thermal_zone acpi_pad sparse_keymap
> acpi_thermal_rel pinctrl_intel_platform acpi_tad
> intel_skl_int3472_common wmi intel_vsec cfg80211 mac_hid rfkill
> i2c_dev crypto_user pkcs8_key_parser nfnetlink dm_crypt encrypted_keys
> trusted asn1_encoder tee dm_mod nvme nvme_core nvme_keyring nvme_auth
> ghash_clmulni_intel hkdf aesni_intel spi_intel_pci spi_intel
> intel_lpss_pci intel_lpss idma64 serio_raw
> Mar 30 02:21:11 kernel: CPU: 3 UID: 0 PID: 878 Comm: iio-sensor-prox
> Tainted: G         C          7.0.0-rc6-00004-g7268ec6fe437 #1
> PREEMPT(full)  fa629251ef4a8846133b410c388e36cf95acdaa0
> Mar 30 02:21:11 kernel: Tainted: [C]=3DCRAP
> Mar 30 02:21:11 kernel: Hardware name: LENOVO 21QA0048RM/21QA0048RM,
> BIOS N4DET38W (1.21 ) 12/24/2025
> Mar 30 02:21:11 kernel: RIP: 0010:__setup_irq+0x4ee/0x700
> Mar 30 02:21:11 kernel: Code: 89 43 7c e8 44 f7 ff ff e9 f9 fe ff ff
> b8 01 00 00 00 48 c7 c1 ff ff ff ff f3 48 0f bc c9 48 d3 e0 49 89 45
> 48 e9 f2 fd ff ff <0f> 0b f6 c6 80 0f 85 8a 00 00 00 81 e2 00 00 01 00
> 0f 85 80 fb ff
> Mar 30 02:21:11 kernel: RSP: 0018:ffffd481c3303be0 EFLAGS: 00010246
> Mar 30 02:21:11 kernel: RAX: 0000000000002000 RBX: ffff8e5e909e9200
> RCX: 0000000000000000
> Mar 30 02:21:11 kernel: RDX: 0000000000000400 RSI: ffff8e5e909e9200
> RDI: ffffffffc1f74bc0
> Mar 30 02:21:11 kernel: RBP: 00000000000000c0 R08: 0000000000000080
> R09: ffff8e5eabf09480
> Mar 30 02:21:11 kernel: R10: 0000000000000000 R11: 0000000000000001
> R12: 00000000000000c0
> Mar 30 02:21:11 kernel: R13: ffff8e5eabf09480 R14: 0000000000000000
> R15: 0000000000000400
> Mar 30 02:21:11 kernel: FS:  00007f93f76ba880(0000)
> GS:ffff8e661f357000(0000) knlGS:0000000000000000
> Mar 30 02:21:11 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 30 02:21:11 kernel: CR2: 00000000019758a0 CR3: 000000011ee24005
> CR4: 0000000000f72ef0
> Mar 30 02:21:11 kernel: PKRU: 55555554
> Mar 30 02:21:11 kernel: Call Trace:
> Mar 30 02:21:11 kernel:  <TASK>
> Mar 30 02:21:11 kernel:  ? __kmalloc_cache_noprof+0x137/0x4a0
> Mar 30 02:21:11 kernel:  ? request_threaded_irq+0x93/0x190
> Mar 30 02:21:11 kernel:  ? __pfx_iio_pollfunc_store_time+0x10/0x10
> [industrialio 8913024fda2a34504d19f2663497ed55125b1226]
> Mar 30 02:21:11 kernel:  request_threaded_irq+0xd3/0x190
> Mar 30 02:21:11 kernel:  iio_trigger_attach_poll_func+0xbe/0x1c0
> [industrialio 8913024fda2a34504d19f2663497ed55125b1226]
> Mar 30 02:21:11 kernel:  __iio_update_buffers+0xa70/0xb60
> [industrialio 8913024fda2a34504d19f2663497ed55125b1226]
> Mar 30 02:21:11 kernel:  enable_store+0x81/0xe0 [industrialio
> 8913024fda2a34504d19f2663497ed55125b1226]
> Mar 30 02:21:11 kernel:  kernfs_fop_write_iter+0x14d/0x200
> Mar 30 02:21:11 kernel:  vfs_write+0x25d/0x480
> Mar 30 02:21:11 kernel:  ksys_write+0x73/0xf0
> Mar 30 02:21:11 kernel:  do_syscall_64+0x11c/0x15f0
> Mar 30 02:21:11 kernel:  ? __x64_sys_close+0x3d/0x80
> Mar 30 02:21:11 kernel:  ? do_syscall_64+0x11c/0x15f0
> Mar 30 02:21:11 kernel:  ? __x64_sys_close+0x3d/0x80
> Mar 30 02:21:11 kernel:  ? do_syscall_64+0x11c/0x15f0
> Mar 30 02:21:11 kernel:  ? do_syscall_64+0x11c/0x15f0
> Mar 30 02:21:11 kernel:  ? do_syscall_64+0x11c/0x15f0
> Mar 30 02:21:11 kernel:  ? irqentry_exit+0x2c3/0x5e0
> Mar 30 02:21:11 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Mar 30 02:21:11 kernel: RIP: 0033:0x7f93f7b36f32
> Mar 30 02:21:11 kernel: Code: 08 0f 85 c1 43 ff ff 49 89 fb 48 89 f0
> 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c
> 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e
> fa 55 bf 01 00
> Mar 30 02:21:11 kernel: RSP: 002b:00007ffdd277ac98 EFLAGS: 00000246
> ORIG_RAX: 0000000000000001
> Mar 30 02:21:11 kernel: RAX: ffffffffffffffda RBX: 000056336b998ad0
> RCX: 00007f93f7b36f32
> Mar 30 02:21:11 kernel: RDX: 0000000000000001 RSI: 00007ffdd277ae60
> RDI: 0000000000000008
> Mar 30 02:21:11 kernel: RBP: 00007ffdd277acc0 R08: 0000000000000000
> R09: 0000000000000000
> Mar 30 02:21:11 kernel: R10: 0000000000000000 R11: 0000000000000246
> R12: 0000000000000001
> Mar 30 02:21:11 kernel: R13: 0000000000000001 R14: 00007ffdd277ae60
> R15: 0000000000000002
> Mar 30 02:21:11 kernel:  </TASK>
> Mar 30 02:21:11 kernel: ---[ end trace 0000000000000000 ]---
>=20
>=20
> ps
> removed linux-kernel mailing list from Cc: since it's no longer
> relevant for this discussion
>=20

