Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440063CB;
	Fri, 17 Apr 2026 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776385769; cv=none; b=YLgzlrx9YK+o14q6roS6pH/BqbFt847m4BQF1U2k4uREc2BikBLJkJHaP9TenCfZLp98sZjVp8tZVaqBMLJYpRWoMltoyuQXLh2kncnVG/28EWHLOHndafa9RuWSol9BXLzVOU8klbfDC7ocoyp2fd5jvzvYd68K74KgyPm0ptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776385769; c=relaxed/simple;
	bh=w3KzewaqSR/F4Ted4YsQScaPGEr/h8Rg5GTjj4Hb2PU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h0AUVXIswx/Jc73Y9EHo4y2NBSOlhFuCjK8p7ZTjjglzTgzyUpzmUc75GLn+TS4B6F+KoycFVpmIMol4qj+rigatEcdZngJ/STNjLQ0dFup2KZVIZ1ZvWKZry+67SFlU1nSMq4pdleairiGGMGvyygK9Xe4g1CHlx2IMk2cOpAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5wVQmc+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5wVQmc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776385768; x=1807921768;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w3KzewaqSR/F4Ted4YsQScaPGEr/h8Rg5GTjj4Hb2PU=;
  b=T5wVQmc+Ncpe0A4u/4cUcgc64yEVLSeViBl3TbVXaKfiPCnUV9zj3+Ax
   mBlc+PFi5b5b91MREAs7jMxmmEKK+3B5JOUPhmKNsiSBBiJFkZCjHvJH9
   JIug4kFRoFieHdNYNz1hqbKRjaTDqBfNPG69IRm9hyb+lUFw0y/dybdcu
   kWoaUQo71yDcdBiRX/h+eF6YOXLGBaWbFBh/uA1jna0HCAH4sPjuqFmQj
   TbLEHONOdvzscDfzUeSBJpNn9gtir4HLCOJm+a9zLC3LftMioy5s23fXG
   5KcChnP1Rvy4QwjSeA9D82v45sh5AuvCU9VO19V8yIjE8R3solDvQQGXa
   w==;
X-CSE-ConnectionGUID: lUBIx2OxRu+7srzCy5Xo+g==
X-CSE-MsgGUID: 6qgW2h9hQHWcIhiNUk+lNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="80998736"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="80998736"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:29:27 -0700
X-CSE-ConnectionGUID: P1aez2PsQEy2rmH3A6oiqQ==
X-CSE-MsgGUID: X8ehzYhJT2CjcncbCh5bMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226535651"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:29:24 -0700
From: Junxiao Chang <junxiao.chang@intel.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gye976@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lars@metafoo.de,
	junxiao.chang@intel.com
Subject: [PATCH] iio: buffer: fix warning in requesting threaded irq
Date: Sat, 18 Apr 2026 08:23:34 +0800
Message-ID: <20260418002334.3643504-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
handler, this flag should not be set.

This change fixes a warning during booting with kernel v7.0-rc3:

[   18.322081] WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x25=
10, CPU#3: iio-sensor-prox/974
[   18.322097] Modules linked in: snd_hda_intel snd_sof_pci_intel_mtl snd_s=
of_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_inte=
l_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda sou=
ndwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_soc_sdw_utils snd_sof snd=
_sof_utils snd_hda_ext_core snd_hda_codec snd_hda_core snd_intel_dspcfg snd=
_intel_sdw_acpi snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks sou=
ndwire_generic_allocation snd_soc_acpi snd_hwdep soundwire_bus snd_soc_sdca=
 snd_soc_core snd_compress intel_uncore_frequency ac97_bus intel_uncore_fre=
quency_common snd_pcm_dmaengine x86_pkg_temp_thermal intel_powerclamp snd_p=
cm coretemp snd_seq_midi snd_seq_midi_event kvm_intel snd_rawmidi i915(+) b=
infmt_misc snd_seq kvm snd_seq_device snd_timer irqbypass prime_numbers cmd=
linepart ghash_clmulni_intel processor_thermal_device_pci drm_buddy snd aes=
ni_intel processor_thermal_device spi_nor ttm nls_iso8859_1 mei_gsc_proxy i=
ntel_rapl_msr wmi_bmof rapl mtd intel_cstate drm_client_lib
[   18.322243]  processor_thermal_wt_hint i2c_i801 hid_sensor_rotation hid_=
sensor_incl_3d soundcore hid_sensor_accel_3d hid_sensor_prox hid_sensor_mag=
n_3d hid_sensor_custom_intel_hinge hid_sensor_als hid_sensor_gyro_3d platfo=
rm_temperature_control hid_sensor_trigger processor_thermal_soc_slider indu=
strialio_triggered_buffer intel_pmc_core crc8 i2c_mux platform_profile kfif=
o_buf processor_thermal_rfim i2c_smbus drm_display_helper hid_sensor_iio_co=
mmon processor_thermal_rapl industrialio intel_vpu cec intel_rapl_common me=
i_me processor_thermal_wt_req rc_core drm_shmem_helper processor_thermal_po=
wer_floor mei idma64 i2c_algo_bit drm_kms_helper processor_thermal_mbox int=
3403_thermal pmt_telemetry int340x_thermal_zone pmt_discovery pmt_class int=
3400_thermal intel_pmc_ssram_telemetry acpi_thermal_rel intel_pmc_pwrm_tele=
metry intel_hid input_leds acpi_tad acpi_pad sparse_keymap joydev mac_hid s=
ch_fq_codel msr parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs =
autofs4 hid_sensor_custom ucsi_acpi typec_ucsi hid_sensor_hub
[   18.322391]  typec spi_pxa2xx_platform uas dw_dmac dw_dmac_core ahci usb=
_storage usbhid hid_generic spi_pxa2xx_core libahci e1000e thunderbolt vmd =
video pinctrl_meteorpoint pinctrl_meteorlake wmi pinctrl_intel
[   18.322435] CPU: 3 UID: 0 PID: 974 Comm: iio-sensor-prox Not tainted 7.0=
.0-rc3 #16 PREEMPT(lazy)
[   18.322443] Hardware name: Intel Corporation Arrow Lake Client Platform/=
MTL-S UDIMM 1DPC EVCRB, BIOS MTLSEMI1.R00.5124.D41.2504210658 04/21/2025
[   18.322447] RIP: 0010:__setup_irq+0x1639/0x2510
[   18.322455] Code: b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f =
84 75 f0 ff ff 48 8b 7d c8 e8 21 ea 99 00 e9 67 f0 ff ff e8 87 2f 21 00 <0f=
> 0b 31 ff 44 89 ee e8 3b 25 21 00 45 85 ed 0f 84 f0 f1 ff ff bb
[   18.322461] RSP: 0018:ffff8881387c7698 EFLAGS: 00010246
[   18.322467] RAX: 0000000000000000 RBX: 0000000000002000 RCX: 00000000000=
00000
[   18.322471] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[   18.322475] RBP: ffff8881387c7748 R08: 0000000000000000 R09: 00000000000=
00000
[   18.322479] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00400
[   18.322483] R13: 0000000000000000 R14: ffff888102718f20 R15: ffff8881027=
18f00
[   18.322488] FS:  0000700e74a2a900(0000) GS:ffff8888ab3c4000(0000) knlGS:=
0000000000000000
[   18.322493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.322497] CR2: 0000574bb155c068 CR3: 000000010ae6e006 CR4: 0000000000f=
72ef0
[   18.322502] PKRU: 55555554
[   18.322505] Call Trace:
[   18.322507]  <TASK>
[   18.322510]  ? kasan_save_track+0x14/0x40
[   18.322519]  ? __kasan_kmalloc+0xc3/0xd0
[   18.322525]  request_threaded_irq+0x2c7/0x490
[   18.322533]  iio_trigger_attach_poll_func+0x353/0x6b0 [industrialio]
[   18.322603]  ? __bitmap_equal+0xcb/0x1d0
[   18.322614]  __iio_update_buffers+0x2420/0x2c70 [industrialio]
[   18.322800]  ? do_syscall_64+0xcf/0x15d0
[   18.322813]  ? __pfx___iio_update_buffers+0x10/0x10 [industrialio]
[   18.322858]  ? __kasan_check_write+0x14/0x30
[   18.322869]  ? __pfx_mutex_lock+0x10/0x10
[   18.322877]  enable_store+0x183/0x270 [industrialio]
[   18.322926]  ? __pfx_enable_store+0x10/0x10 [industrialio]
[   18.322975]  ? __pfx__copy_from_iter+0x10/0x10
[   18.322986]  ? __pfx_enable_store+0x10/0x10 [industrialio]
[   18.323035]  dev_attr_store+0x5e/0x90
[   18.323046]  ? __pfx_dev_attr_store+0x10/0x10
[   18.323053]  sysfs_kf_write+0x1e8/0x290
[   18.323062]  kernfs_fop_write_iter+0x406/0x5f0
[   18.323068]  ? __pfx_sysfs_kf_write+0x10/0x10
[   18.323076]  vfs_write+0x71c/0xea0

Fixes: 23f2d735a932 ("iio: Add helper function for initializing triggered b=
uffers")
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/i=
io/buffer/industrialio-triggered-buffer.c
index 9bf75dee7ff86..e0fc51bd78bee 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -44,6 +44,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_=
dev,
 	const struct iio_dev_attr **buffer_attrs)
 {
 	struct iio_buffer *buffer;
+	unsigned long flags =3D 0;
 	int ret;
=20
 	/*
@@ -62,9 +63,11 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio=
_dev,
 		goto error_ret;
 	}
=20
+	if (thread)
+		flags |=3D IRQF_ONESHOT;
 	indio_dev->pollfunc =3D iio_alloc_pollfunc(h,
 						 thread,
-						 IRQF_ONESHOT,
+						 flags,
 						 indio_dev,
 						 "%s_consumer%d",
 						 indio_dev->name,
--=20
2.43.0

