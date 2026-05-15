Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB363AF64F
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856486; cv=pass; b=Ksh4/h/XXZ+WAYuGvlU7kKpKrmFWD/ajmF5Pyk1jmbzEVCxgEGl9wodY345qGIs6JQjfR35QpQbPDrVptABKx/ZVQd5lCgFojpl32cFCpT/nSZwi6o1qjr7mD30b0GdOccgSdLzO4BaNlO1yVXep//vn7BR3vhYCWXJ5wXNvwJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856486; c=relaxed/simple;
	bh=OrdUXNFFat/pes1xe0Lk/MaS/1fcsYBoDXvMjSdptEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejG7CqVY/dZH3roETX1VDx185vCHHKsYO8ilOVA4pamlEECprmfdod9bkvM36sg4QX7BzJxPW5lPs076Pb//30nKnjucOPUjRFN2F1kPNogFuRCs7o7ktTWlxT6z7Gl8A9anR4tKbv19v3ahe+r4zHLNMVFy4F9QOIOCjMLC7Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWbhZg7M; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWbhZg7M"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c5361142fso12439537d50.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 07:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778856482; cv=none;
        d=google.com; s=arc-20240605;
        b=i8zknrOLHWcOqRnqYifkCDflNhmJCWlQ04sXD3cZgJ1opwOEemI/SbDU887JuZPUHh
         4wM3i2Eiv158UrOsRaZ3kKW17bwTnA2yXTePCyuXZXzE+Iq+S3xj7Fq2VOHAYHvTPR6C
         WRqJmWamdEaK7e7Qk/FyC5LWP7e1CSJAkz8lzbdcJooSENoJPREfFScLEfre5Yst4tVZ
         vFlJ0N87dcn9RkGBSaxP5+XXx1nhJPPo+NcluqbETOH1811BKK22lZjll9QL3hkZhycF
         GJ0TT8oyihx3BQODFe78ug0UrmL/6QGiwdCRfySpBAZSHMxV+H1U85752Rv2+jFaA8c7
         XfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kytz3XEtMb+uyLTxXaRTxu2mz0pmY/3oaNtcKjfhtP4=;
        fh=upYTu8eCXimOK+0lzEhVzI17dgiu1qDLv7kqe9MaYpk=;
        b=PH254AYWmV8fFg9APlYVdPyxOiVHn5/AVH8tra37CgnuZAMFCpA7rAuZq7QzGagb3r
         JPFQ75IJR+HH1/UASHO7nIZz35jdMyckHyLIyEtTKSowQ0ek1MMEWldiQGFwQC8gvO1K
         tBFawxSH0e2UiZMAOU27YvNVTx0CXfP6jVqUgy4uMixrR2lc14RSI56fbM58YSaQN/ab
         kVPgRiGTje3TucwsF16eisa9KCMqrudab/ArOWVwNet7BnWdPBcY8aMMZBgTIEqKwMpm
         jW8iI4fH5MOkILMd6k3+yHN2o+KbMDVc8THEkcw6jyvKznNSgjT5pZ0t1zjWWSllJWdw
         /e+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778856482; x=1779461282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kytz3XEtMb+uyLTxXaRTxu2mz0pmY/3oaNtcKjfhtP4=;
        b=OWbhZg7MnBXXAIWr5ADzdur4L4wtwcRwEmWMRw/y6C8Q8Jq281kzXgsgEc95PDg9L/
         cjZnuhH3qocV+xPCFuGm9SfYMGsDy8PEqnDdg6yNHI7vMI0eX8j+3RBjM2ygHRMNeDO/
         fAhpIU8GerUifHEluc0pZAsayAe+YbFqdGZCKnElrQLyFX0uPRzjLab1SIOlZsgEq56o
         ACk56tnEwGN9Milgi+xBnrZbpsGaWlJfYgj8AoBpIDBHyAhfcUsCqGaCH5xDUYIYw9r3
         rtdzwdhcMmYncL5auxHevKL8Fq6sVWPcRIYnJvhyal3enkIRC5Q3MVuEcxpgeiGzFW+n
         9/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778856482; x=1779461282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kytz3XEtMb+uyLTxXaRTxu2mz0pmY/3oaNtcKjfhtP4=;
        b=SWmaMxhUMfbDqM9+QnNWjOfhvXzUNmtmE6D06DIlgVS/6/kRVDyHnJcDwQTRBgh85L
         cDxut2ZsG0I8WTKN3X4/sh+Wh2DnxOrtK2/TXRXKXOqinv/RgLR8+HBsq9j3P0mVxZ1l
         1F99CpHqD8ug8YQrvMqLDLHqRF/4FwplQpqV1s3FTwuRRvmT1zMRfK24cetBPd6qMsr2
         FspLAZdeu74iz5pVFOA42Sb7ZqzvAK28ed56OzxuFnyfxT/jbcZnj0HClq8BXxHIDA4r
         drxiQpsHfqQQjmFCWD2V+PcL9e5cny25Ait9aTiKrPH13u2U7I1HPicjI0jK3ywH0nyh
         y85A==
X-Forwarded-Encrypted: i=1; AFNElJ+V2pBibE0CZt0j1lHH6KdJiupwi7mMaex+kxL+Vyd6LLzZKZ7R5nBbcovurKyO9/oY+YpIIP4543A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUvP/7B7zuc9MD18wXc5HXQu1IWQvlmpAz6uoPx5dVsmOLr79
	aSTkb+L88bk8nm/NS2g06HWxPlzowRi6g44sMhdOeHl8ijBWLKhR3+/E1aScw+s50ujDHTnWmHf
	SzmwNxaJwHmgLSov0Hd7ueRG6XHcobyA=
X-Gm-Gg: Acq92OHnDbPLfe6Fawgi+eFPA2qd2qNLj3OWlX0Xh6TiBK7vQjpE2kMHV0jzh+VIYRt
	4sUJsnkeouGVxoSURPFAuyTp/fPnW2GuvjLBPcT1GgfnP4UWvGEF2SJn4VtRj9ObZdRptGkR5cc
	5abs3BT1sBjT7qewtQZq8T87dtDngq7DqjJDUOvA1dpkKbKFlLpl5E7S4M1WT/MsCJfoUXdjbcr
	fJ0BePg4z5BLhqj5fWsTbF3yOqTD13wMgT0LrZn8ALkU5fgPQXHAK6HFcb21BGP7Evr1VZWK8uE
	v7FnWp4=
X-Received: by 2002:a05:690c:c4e3:b0:7ba:f907:145c with SMTP id
 00721157ae682-7c95cfd9c2dmr48141817b3.33.1778856482212; Fri, 15 May 2026
 07:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-patch-iio-buffer-v1-1-667dac4e55e5@gmail.com>
 <agb5hiF6GhNwGa6c@ashevche-desk.local> <20260515152005.355fffaf@jic23-huawei>
In-Reply-To: <20260515152005.355fffaf@jic23-huawei>
From: Damjan Georgievski <gdamjan@gmail.com>
Date: Fri, 15 May 2026 16:47:50 +0200
X-Gm-Features: AVHnY4JRoWgT72VAx1APmdP9hU7ewKE9ChtJRvIUbKHzdcJ6cmeGQxTpgnYhzPU
Message-ID: <CAEk1YH7jYFHPJFEZrsW9Nuzy0RAiYa_HdQfx3nbv=Wnp=2-qxw@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: only set IRQF_ONESHOT when thread handler is provided
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 at 16:20, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 15 May 2026 13:46:30 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Fri, May 15, 2026 at 12:46:00AM +0200, =D0=94=D0=B0=D0=BC=D1=98=D0=
=B0=D0=BD =D0=93=D0=B5=D0=BE =D1=80=D0=B3=D0=B8=D0=B5=D0=B2=D1=81=D0=BA=D0=
=B8 wrote:
> > > iio_triggered_buffer_setup_ext() unconditionally passes IRQF_ONESHOT =
to
> > > iio_alloc_pollfunc(), even when the caller provides no thread functio=
n.
> > > This causes a warning in __setup_irq() when the trigger is later
> > > attached:
> > >
> > >   WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x4ee/0x700
> > >
> > > IRQF_ONESHOT keeps the IRQ masked until the threaded handler complete=
s,
> > > but with no threaded handler this is semantically wrong. Only set the
> > > flag when a thread function is actually provided.
> >
> > Yes, please read the mailing list archive and find the previous attempt=
 to fix
> > this and the associated discussions.
> >
>
>
> Just to check - what is the driver in use?  The fixes so far all belong i=
n the
> drivers, not papering over it in the core (note this is maybe the 3rd tim=
e
> this same patch has been posted and rejected!)


good to know,
that's what I get for using AI :D

this started happening after
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D043251b2dd1c2b0cd23f67830748493fd3d3ed0f
was merged and that made "intel_ish_hid" successfully enable the
ambient light sensor on the Thinkpad X9-14.

Not sure which exactly driver ended up triggering the warning, is it
possible it is " hid_sensor_prox"?


full warning is

ar 30 02:21:11 kernel: ------------[ cut here ]------------
Mar 30 02:21:11 kernel: WARNING: kernel/irq/manage.c:1502 at
__setup_irq+0x4ee/0x700, CPU#3: iio-sensor-prox/878
Mar 30 02:21:11 kernel: Modules linked in: uinput cmac algif_hash
algif_skcipher af_alg bnep vfat fat snd_soc_sof_sdw snd_sof_probes
snd_soc_intel_hda_dsp_common snd_soc_cs42l43 spi_cs42l43
snd_soc_cs42l43_sdw pinctrl_cs42l43 snd_soc_cs35l56_sdw
snd_soc_cs35l56 snd_soc_cs35l56_shared cs42l43_sdw snd_soc_cs_amp_lib
regmap_sdw snd_soc_wm_adsp snd_hda_codec_intelhdmi cs_dsp cs42l43
snd_hda_codec_hdmi snd_soc_dmic hid_sensor_prox hid_sensor_als
hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
hid_sensor_iio_common industrialio hid_sensor_custom hid_sensor_hub
intel_ishtp_hid snd_hda_intel snd_sof_pci_intel_lnl
snd_sof_pci_intel_mtl snd_sof_intel_hda_generic soundwire_intel
snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_hda
snd_sof_intel_hda_mlink snd_sof_intel_hda soundwire_cadence
snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core
intel_uncore_frequency intel_uncore_frequency_common
x86_pkg_temp_thermal snd_hda_codec snd_hda_core xe intel_powerclamp
snd_intel_dspcfg snd_intel_sdw_acpi
Mar 30 02:21:11 kernel:  snd_soc_acpi_intel_match
snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocation
snd_soc_sdw_utils snd_soc_acpi coretemp intel_ipu7_isys(C) snd_hwdep
videobuf2_dma_sg drm_gpusvm_helper soundwire_bus videobuf2_memops
drm_gpuvm kvm_intel snd_soc_sdca videobuf2_v4l2 joydev gpu_sched
videobuf2_common lenovo_wmi_other mousedev snd_ctl_led mei_gsc_proxy
intel_rapl_msr wacom drm_buddy processor_thermal_device_pci
snd_soc_core hid_multitouch lenovo_wmi_helpers kvm drm_exec
processor_thermal_device lenovo_wmi_capdata drm_suballoc_helper
processor_thermal_wt_hint snd_compress think_lmi iwlmld drm_ttm_helper
ac97_bus irqbypass platform_temperature_control ttm snd_pcm_dmaengine
firmware_attributes_class wmi_bmof snd_pcm rapl imx471 i2c_algo_bit
thinkpad_acpi processor_thermal_soc_slider ucsi_acpi
processor_thermal_rfim mac80211 v4l2_fwnode processor_thermal_rapl
snd_timer drm_display_helper v4l2_async typec_ucsi platform_profile
btintel_pcie intel_cstate intel_rapl_common intel_ipu7(C) pcspkr
intel_uncore typec
Mar 30 02:21:11 kernel:  videodev spi_nor processor_thermal_wt_req ptp
snd intel_quicki2c intel_ish_ipc intel_skl_int3472_tps68470
intel_pmc_core cec btintel mei_me soundcore pps_core
processor_thermal_power_floor roles tps68470_regulator clk_tps68470
pmt_telemetry libarc4 mtd video crc8 bluetooth mei iwlwifi intel_ishtp
intel_vpu intel_thc thunderbolt processor_thermal_mbox mc ipu_bridge
i2c_hid_acpi pmt_discovery i2c_hid pmt_class intel_pmc_ssram_telemetry
int3400_thermal intel_hid intel_skl_int3472_discrete int3403_thermal
soc_button_array int340x_thermal_zone acpi_pad sparse_keymap
acpi_thermal_rel pinctrl_intel_platform acpi_tad
intel_skl_int3472_common wmi intel_vsec cfg80211 mac_hid rfkill
i2c_dev crypto_user pkcs8_key_parser nfnetlink dm_crypt encrypted_keys
trusted asn1_encoder tee dm_mod nvme nvme_core nvme_keyring nvme_auth
ghash_clmulni_intel hkdf aesni_intel spi_intel_pci spi_intel
intel_lpss_pci intel_lpss idma64 serio_raw
Mar 30 02:21:11 kernel: CPU: 3 UID: 0 PID: 878 Comm: iio-sensor-prox
Tainted: G         C          7.0.0-rc6-00004-g7268ec6fe437 #1
PREEMPT(full)  fa629251ef4a8846133b410c388e36cf95acdaa0
Mar 30 02:21:11 kernel: Tainted: [C]=3DCRAP
Mar 30 02:21:11 kernel: Hardware name: LENOVO 21QA0048RM/21QA0048RM,
BIOS N4DET38W (1.21 ) 12/24/2025
Mar 30 02:21:11 kernel: RIP: 0010:__setup_irq+0x4ee/0x700
Mar 30 02:21:11 kernel: Code: 89 43 7c e8 44 f7 ff ff e9 f9 fe ff ff
b8 01 00 00 00 48 c7 c1 ff ff ff ff f3 48 0f bc c9 48 d3 e0 49 89 45
48 e9 f2 fd ff ff <0f> 0b f6 c6 80 0f 85 8a 00 00 00 81 e2 00 00 01 00
0f 85 80 fb ff
Mar 30 02:21:11 kernel: RSP: 0018:ffffd481c3303be0 EFLAGS: 00010246
Mar 30 02:21:11 kernel: RAX: 0000000000002000 RBX: ffff8e5e909e9200
RCX: 0000000000000000
Mar 30 02:21:11 kernel: RDX: 0000000000000400 RSI: ffff8e5e909e9200
RDI: ffffffffc1f74bc0
Mar 30 02:21:11 kernel: RBP: 00000000000000c0 R08: 0000000000000080
R09: ffff8e5eabf09480
Mar 30 02:21:11 kernel: R10: 0000000000000000 R11: 0000000000000001
R12: 00000000000000c0
Mar 30 02:21:11 kernel: R13: ffff8e5eabf09480 R14: 0000000000000000
R15: 0000000000000400
Mar 30 02:21:11 kernel: FS:  00007f93f76ba880(0000)
GS:ffff8e661f357000(0000) knlGS:0000000000000000
Mar 30 02:21:11 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 30 02:21:11 kernel: CR2: 00000000019758a0 CR3: 000000011ee24005
CR4: 0000000000f72ef0
Mar 30 02:21:11 kernel: PKRU: 55555554
Mar 30 02:21:11 kernel: Call Trace:
Mar 30 02:21:11 kernel:  <TASK>
Mar 30 02:21:11 kernel:  ? __kmalloc_cache_noprof+0x137/0x4a0
Mar 30 02:21:11 kernel:  ? request_threaded_irq+0x93/0x190
Mar 30 02:21:11 kernel:  ? __pfx_iio_pollfunc_store_time+0x10/0x10
[industrialio 8913024fda2a34504d19f2663497ed55125b1226]
Mar 30 02:21:11 kernel:  request_threaded_irq+0xd3/0x190
Mar 30 02:21:11 kernel:  iio_trigger_attach_poll_func+0xbe/0x1c0
[industrialio 8913024fda2a34504d19f2663497ed55125b1226]
Mar 30 02:21:11 kernel:  __iio_update_buffers+0xa70/0xb60
[industrialio 8913024fda2a34504d19f2663497ed55125b1226]
Mar 30 02:21:11 kernel:  enable_store+0x81/0xe0 [industrialio
8913024fda2a34504d19f2663497ed55125b1226]
Mar 30 02:21:11 kernel:  kernfs_fop_write_iter+0x14d/0x200
Mar 30 02:21:11 kernel:  vfs_write+0x25d/0x480
Mar 30 02:21:11 kernel:  ksys_write+0x73/0xf0
Mar 30 02:21:11 kernel:  do_syscall_64+0x11c/0x15f0
Mar 30 02:21:11 kernel:  ? __x64_sys_close+0x3d/0x80
Mar 30 02:21:11 kernel:  ? do_syscall_64+0x11c/0x15f0
Mar 30 02:21:11 kernel:  ? __x64_sys_close+0x3d/0x80
Mar 30 02:21:11 kernel:  ? do_syscall_64+0x11c/0x15f0
Mar 30 02:21:11 kernel:  ? do_syscall_64+0x11c/0x15f0
Mar 30 02:21:11 kernel:  ? do_syscall_64+0x11c/0x15f0
Mar 30 02:21:11 kernel:  ? irqentry_exit+0x2c3/0x5e0
Mar 30 02:21:11 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Mar 30 02:21:11 kernel: RIP: 0033:0x7f93f7b36f32
Mar 30 02:21:11 kernel: Code: 08 0f 85 c1 43 ff ff 49 89 fb 48 89 f0
48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c
89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e
fa 55 bf 01 00
Mar 30 02:21:11 kernel: RSP: 002b:00007ffdd277ac98 EFLAGS: 00000246
ORIG_RAX: 0000000000000001
Mar 30 02:21:11 kernel: RAX: ffffffffffffffda RBX: 000056336b998ad0
RCX: 00007f93f7b36f32
Mar 30 02:21:11 kernel: RDX: 0000000000000001 RSI: 00007ffdd277ae60
RDI: 0000000000000008
Mar 30 02:21:11 kernel: RBP: 00007ffdd277acc0 R08: 0000000000000000
R09: 0000000000000000
Mar 30 02:21:11 kernel: R10: 0000000000000000 R11: 0000000000000246
R12: 0000000000000001
Mar 30 02:21:11 kernel: R13: 0000000000000001 R14: 00007ffdd277ae60
R15: 0000000000000002
Mar 30 02:21:11 kernel:  </TASK>
Mar 30 02:21:11 kernel: ---[ end trace 0000000000000000 ]---


ps
removed linux-kernel mailing list from Cc: since it's no longer
relevant for this discussion

--=20
damjan
