Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F832ED27;
	Fri, 17 Apr 2026 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776410715; cv=none; b=r3edbWLp9w0keVOMSLPirsRu9ZwTdjKUv9rpu8ACGN0NnB2vlJ6X63jyL7yoOjBH+jkyDskDiGIm7Rt8Wi2y+m954P3h2y+x1yPQvzkc/soSngQlXSaJ0YUgyDxUHiLPqUazFpnOjwaQTfBxaehLqIgESjvX0BXIBx65+TtflVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776410715; c=relaxed/simple;
	bh=5DPTnog7c5zxYJakej+rvDKNSSSurMqimBaXM17Gdvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9ufne0s12fXYKoHhWJFjOPM5nhJtJzlgVATcRTSzc+qOPfzIK4ITMx1y4//SrUAO187ZGoa/k9/4mmY/qHPiJ1UI2RAk9zzz4NTRpMXHfivxnu5zZvdeuzPKy1vJW/RJoIl+lBPD6lJYXMgPfqd3D5EUtIK49MuSJvAfYfTg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FC+RZAhi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FC+RZAhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776410714; x=1807946714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5DPTnog7c5zxYJakej+rvDKNSSSurMqimBaXM17Gdvs=;
  b=FC+RZAhipZEAdBniAoaPr3YCoZaoupw9OcBmS9QRjcE+HDoj4p6aP4IP
   P/X+fAkijRQr7h5nXoQxgi8mgCpXQ6sZmwGpsJY8+nkRtNhCsBd8Rvgtu
   VqIVegaWzJcTKFsj6T7kY1SUHI+Et3kcw5Opb+W5gjy/mwozS++/Tfbih
   pOhFhHs4BshVKRUsYMhcNPfV8sUgqLxFY/OzN8cth02JI/eC/XidqYluw
   1PNrjx2bIMLPukql7hWuWKkqlDxaM9xOO++kEg86hFAfnrDaBtxw2jYSU
   1FMKPJqXYDvhrmn0HnUVpZjO6mpAaZfrl2O3vuchN5TNZ4MtcY45vOz6j
   g==;
X-CSE-ConnectionGUID: dxV+eCGHRpqbX9mXDzNGkQ==
X-CSE-MsgGUID: 3sVdCBBuR+uakrhbFMN31g==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="80010480"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="80010480"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:25:13 -0700
X-CSE-ConnectionGUID: VJ6f/ytFT8u0gwIIz0wbWA==
X-CSE-MsgGUID: ikMj1Vm0SAO2RYjEs/akuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="235939876"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:25:11 -0700
Date: Fri, 17 Apr 2026 10:25:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gye976@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH] iio: buffer: fix warning in requesting threaded irq
Message-ID: <aeHgVChKIZpz541S@ashevche-desk.local>
References: <20260418002334.3643504-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260418002334.3643504-1-junxiao.chang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 18, 2026 at 08:23:34AM +0800, Junxiao Chang wrote:
> IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
> handler, this flag should not be set.
>=20
> This change fixes a warning during booting with kernel v7.0-rc3:

Please, read this
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#back=
traces-in-commit-messages
and act accordingly.

> [   18.322081] WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x=
2510, CPU#3: iio-sensor-prox/974
> [   18.322097] Modules linked in: snd_hda_intel snd_sof_pci_intel_mtl snd=
_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_in=
tel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda s=
oundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_soc_sdw_utils snd_sof s=
nd_sof_utils snd_hda_ext_core snd_hda_codec snd_hda_core snd_intel_dspcfg s=
nd_intel_sdw_acpi snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks s=
oundwire_generic_allocation snd_soc_acpi snd_hwdep soundwire_bus snd_soc_sd=
ca snd_soc_core snd_compress intel_uncore_frequency ac97_bus intel_uncore_f=
requency_common snd_pcm_dmaengine x86_pkg_temp_thermal intel_powerclamp snd=
_pcm coretemp snd_seq_midi snd_seq_midi_event kvm_intel snd_rawmidi i915(+)=
 binfmt_misc snd_seq kvm snd_seq_device snd_timer irqbypass prime_numbers c=
mdlinepart ghash_clmulni_intel processor_thermal_device_pci drm_buddy snd a=
esni_intel processor_thermal_device spi_nor ttm nls_iso8859_1 mei_gsc_proxy=
 intel_rapl_msr wmi_bmof rapl mtd intel_cstate drm_client_lib
> [   18.322243]  processor_thermal_wt_hint i2c_i801 hid_sensor_rotation hi=
d_sensor_incl_3d soundcore hid_sensor_accel_3d hid_sensor_prox hid_sensor_m=
agn_3d hid_sensor_custom_intel_hinge hid_sensor_als hid_sensor_gyro_3d plat=
form_temperature_control hid_sensor_trigger processor_thermal_soc_slider in=
dustrialio_triggered_buffer intel_pmc_core crc8 i2c_mux platform_profile kf=
ifo_buf processor_thermal_rfim i2c_smbus drm_display_helper hid_sensor_iio_=
common processor_thermal_rapl industrialio intel_vpu cec intel_rapl_common =
mei_me processor_thermal_wt_req rc_core drm_shmem_helper processor_thermal_=
power_floor mei idma64 i2c_algo_bit drm_kms_helper processor_thermal_mbox i=
nt3403_thermal pmt_telemetry int340x_thermal_zone pmt_discovery pmt_class i=
nt3400_thermal intel_pmc_ssram_telemetry acpi_thermal_rel intel_pmc_pwrm_te=
lemetry intel_hid input_leds acpi_tad acpi_pad sparse_keymap joydev mac_hid=
 sch_fq_codel msr parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysf=
s autofs4 hid_sensor_custom ucsi_acpi typec_ucsi hid_sensor_hub
> [   18.322391]  typec spi_pxa2xx_platform uas dw_dmac dw_dmac_core ahci u=
sb_storage usbhid hid_generic spi_pxa2xx_core libahci e1000e thunderbolt vm=
d video pinctrl_meteorpoint pinctrl_meteorlake wmi pinctrl_intel
> [   18.322435] CPU: 3 UID: 0 PID: 974 Comm: iio-sensor-prox Not tainted 7=
=2E0.0-rc3 #16 PREEMPT(lazy)
> [   18.322443] Hardware name: Intel Corporation Arrow Lake Client Platfor=
m/MTL-S UDIMM 1DPC EVCRB, BIOS MTLSEMI1.R00.5124.D41.2504210658 04/21/2025
> [   18.322447] RIP: 0010:__setup_irq+0x1639/0x2510
> [   18.322455] Code: b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0=
f 84 75 f0 ff ff 48 8b 7d c8 e8 21 ea 99 00 e9 67 f0 ff ff e8 87 2f 21 00 <=
0f> 0b 31 ff 44 89 ee e8 3b 25 21 00 45 85 ed 0f 84 f0 f1 ff ff bb
> [   18.322461] RSP: 0018:ffff8881387c7698 EFLAGS: 00010246
> [   18.322467] RAX: 0000000000000000 RBX: 0000000000002000 RCX: 000000000=
0000000
> [   18.322471] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [   18.322475] RBP: ffff8881387c7748 R08: 0000000000000000 R09: 000000000=
0000000
> [   18.322479] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000400
> [   18.322483] R13: 0000000000000000 R14: ffff888102718f20 R15: ffff88810=
2718f00
> [   18.322488] FS:  0000700e74a2a900(0000) GS:ffff8888ab3c4000(0000) knlG=
S:0000000000000000
> [   18.322493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.322497] CR2: 0000574bb155c068 CR3: 000000010ae6e006 CR4: 000000000=
0f72ef0
> [   18.322502] PKRU: 55555554
> [   18.322505] Call Trace:
> [   18.322507]  <TASK>
> [   18.322510]  ? kasan_save_track+0x14/0x40
> [   18.322519]  ? __kasan_kmalloc+0xc3/0xd0
> [   18.322525]  request_threaded_irq+0x2c7/0x490
> [   18.322533]  iio_trigger_attach_poll_func+0x353/0x6b0 [industrialio]
> [   18.322603]  ? __bitmap_equal+0xcb/0x1d0
> [   18.322614]  __iio_update_buffers+0x2420/0x2c70 [industrialio]
> [   18.322800]  ? do_syscall_64+0xcf/0x15d0
> [   18.322813]  ? __pfx___iio_update_buffers+0x10/0x10 [industrialio]
> [   18.322858]  ? __kasan_check_write+0x14/0x30
> [   18.322869]  ? __pfx_mutex_lock+0x10/0x10
> [   18.322877]  enable_store+0x183/0x270 [industrialio]
> [   18.322926]  ? __pfx_enable_store+0x10/0x10 [industrialio]
> [   18.322975]  ? __pfx__copy_from_iter+0x10/0x10
> [   18.322986]  ? __pfx_enable_store+0x10/0x10 [industrialio]
> [   18.323035]  dev_attr_store+0x5e/0x90
> [   18.323046]  ? __pfx_dev_attr_store+0x10/0x10
> [   18.323053]  sysfs_kf_write+0x1e8/0x290
> [   18.323062]  kernfs_fop_write_iter+0x406/0x5f0
> [   18.323068]  ? __pfx_sysfs_kf_write+0x10/0x10
> [   18.323076]  vfs_write+0x71c/0xea0

=2E..

>  	struct iio_buffer *buffer;
> +	unsigned long flags =3D 0;

This is less maintainable. When the assigned value is used in a conditional,
it's always better to have the assignment there.

>  	int ret;

=2E..

> +	if (thread)
> +		flags |=3D IRQF_ONESHOT;

	if (thread)
		flags =3D IRQF_ONESHOT;
	else
		flags =3D 0;

--=20
With Best Regards,
Andy Shevchenko


