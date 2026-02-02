Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446A38E5E3;
	Mon,  2 Feb 2026 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770074901; cv=none; b=E2ifusDy90//wzblm+HPgMAjSgSFMa1ovcxxhHwoegpuwoqi+83fE5+hxpGTL9qf80D2xXIvpNcV48T402dFU/wxD/rK/GuTZ95T1NmUpCYz7ecf6TI1VQCutkZBool0YOmVKsPVTUBAyRZ4n+gpaMJqpiYEyq1IfJ9ht6u/gOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770074901; c=relaxed/simple;
	bh=PAlkEZIS2giOjDTMSaINp6Fa0wRCaUgwsUVjhH40MMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYqx4Fdk3RPY2hcoRko3h9td/WSgCxa4PzN8Lx5fg+Z827zqxrRwDR6fxSf5k6WDEfrGeIXJXgGtQq922fPgFOSGXarlFKIcXjHzAYbGjCY0Ra4x8ufef6y/KXcl6A/WmdI6C2aP43yCAZl/6N0rWL+P5gXq9Z0p0NaAvJHMUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=bl8tjSGQ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="bl8tjSGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770074864; x=1770679664; i=spasswolf@web.de;
	bh=AI1TFqGKf4I7fMRcL3wiUW77sR+KfSlwcerxHxwPyLA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bl8tjSGQtA1JI41uQyLaYwad6TuVI6w9ckAr2VfW3uzskjz71oyumWIyTkXFPfOr
	 yVUwcg/hL0I7e6gGBwbS6mXIzdhTc2ME2JWTZ4iLM7CvOb1wx/ScnXHlF6LTygG2T
	 DPkKvzNZY2DL1fX88+sZSESnQueiePNT0utMxXlA/2LHHlBe0gawBkhJAXxB0LuJU
	 Ay4lacXlb41+3lF3jADAcmkZJ3aJ1PMOOVcEJ4ucsXjh1s1cxNSnHH7iWzFhJeUXL
	 pDQAjPM9OUOjU2He/68tKo3OmIYMW6tvpVDy7P0v4jQJg1PPs7dtkfGU/4nYWrS/o
	 dotNfIVEpuUfQiEfAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M3m5B-1vnKJX23nf-009MC5; Tue, 03 Feb 2026 00:27:44 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a threaded handler
Date: Tue,  3 Feb 2026 00:27:40 +0100
Message-ID: <20260202232741.13380-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113120541.YVf2vRA3@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DI7LwJdX3mAgQSzcDgNsycmypavqFwcMX9T1VthWBGHLEDrMQPA
 K1xfioIvObdA1AQQcCNMmijOmDOSYQvr/R5TcWJ2KaryqPqYs9Y9ShcV49n7sHj0hz12K1c
 dOrC90ju5GCq8UmajajQUZj+9AdsEG8KXnAfnu1UflMVx1HsffKQihJ3m4SqwBRDA1X1qlf
 5T39giZowNHbceisjS5tA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2QKpVVs3slE=;dgDgjJ1uwJgLmmViMJBOyG4LR2S
 +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

Since commit=20
aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT without a threaded han=
dler")
has been merged into linux-next the following warning appears when booting =
my=20
MSI Alpha 15 laptop (running linux-next-20260130 with debian stable/trixie):

[    8.436584] [   T1180] ------------[ cut here ]------------
[    8.436811] [   T1180] WARNING: kernel/irq/manage.c:1502 at __setup_irq+=
0x4fa/0x730, CPU#15: iio-sensor-prox/1180
[    8.436817] [   T1180] Modules linked in: rfcomm bnep nls_ascii nls_cp43=
7 vfat fat snd_hda_codec_generic btusb btrtl snd_hda_codec_atihdmi btintel =
snd_hda_codec_hdmi btbcm uvcvideo btmtk videobuf2_vmalloc videobuf2_memops =
snd_hda_intel uvc videobuf2_v4l2 snd_intel_dspcfg snd_hda_codec snd_acp3x_r=
n snd_soc_dmic snd_acp3x_pdm_dma bluetooth snd_hda_core snd_soc_core snd_hw=
dep videodev snd_pcm_oss snd_mixer_oss snd_pcm snd_rn_pci_acp3x hid_sensor_=
magn_3d hid_sensor_prox hid_sensor_accel_3d hid_sensor_als hid_sensor_gyro_=
3d videobuf2_common snd_acp_config snd_soc_acpi hid_sensor_trigger msi_wmi =
ecdh_generic ecc mc sparse_keymap wmi_bmof snd_timer k10temp snd snd_pci_ac=
p3x ccp ac soundcore industrialio_triggered_buffer battery kfifo_buf button=
 industrialio amd_pmc hid_sensor_iio_common joydev evdev mt7921e mt7921_com=
mon mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fu=
se nvme_fabrics efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 usbh=
id amdgpu amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm xhci_pci
[    8.437165] [   T1180]  drm_exec drm_panel_backlight_quirks xhci_hcd gpu=
_sched drm_suballoc_helper hid_sensor_hub drm_buddy mfd_core hid_multitouch=
 hid_generic drm_display_helper usbcore i2c_hid_acpi psmouse amd_sfh i2c_hi=
d drm_kms_helper nvme hid serio_raw nvme_core r8169 i2c_piix4 cec i2c_smbus=
 usb_common crc16 i2c_designware_platform i2c_designware_core
[    8.437185] [   T1180] CPU: 15 UID: 0 PID: 1180 Comm: iio-sensor-prox Ta=
inted: G        W           6.19.0-rc7-next-20260130-iiodebug-00002-g2875fe=
ff2cee #292 PREEMPT(full)=20
[    8.437188] [   T1180] Tainted: [W]=3DWARN
[    8.437189] [   T1180] Hardware name: Micro-Star International Co., Ltd.=
 Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[    8.437190] [   T1180] RIP: 0010:__setup_irq+0x4fa/0x730
[    8.437193] [   T1180] Code: e7 e8 ca 6f 00 00 e9 7e fd ff ff b8 01 00 0=
0 00 48 c7 c2 ff ff ff ff f3 48 0f bc d2 c4 e2 e9 f7 c0 48 89 43 48 e9 d8 f=
d ff ff <0f> 0b 85 c9 0f 85 8c 00 00 00 81 e2 00 00 01 00 0f 85 7d fb ff ff
[    8.437194] [   T1180] RSP: 0018:ffffc3b6c46d7c70 EFLAGS: 00010246
[    8.437196] [   T1180] RAX: 0000000000002000 RBX: ffffa04c05503e80 RCX: =
0000000000000000
[    8.437197] [   T1180] RDX: 0000000000000400 RSI: ffffa04c112e0e00 RDI: =
ffffffffc181cac0
[    8.437198] [   T1180] RBP: 0000000000000077 R08: 0000000000000000 R09: =
ffffa04c05503e80
[    8.437199] [   T1180] R10: 0000000000000001 R11: 0000000000000003 R12: =
0000000000000077
[    8.437200] [   T1180] R13: ffffa04c112e0e00 R14: ffffa04c112e0e00 R15: =
ffffa04c05503e80
[    8.437201] [   T1180] FS:  00007f447c23f940(0000) GS:ffffa04f2cb1d000(0=
000) knlGS:0000000000000000
[    8.437203] [   T1180] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.437204] [   T1180] CR2: 0000559507dd86d8 CR3: 0000000103b55000 CR4: =
0000000000750ef0
[    8.437205] [   T1180] PKRU: 55555554
[    8.437206] [   T1180] Call Trace:
[    8.437207] [   T1180]  <TASK>
[    8.437209] [   T1180]  request_threaded_irq+0xdf/0x170
[    8.437213] [   T1180]  iio_trigger_attach_poll_func.cold+0x3e/0x111 [in=
dustrialio]
[    8.437220] [   T1180]  __iio_update_buffers.cold+0x5c/0x70 [industriali=
o]
[    8.437224] [   T1180]  ? __entry_text_end+0x1021d7/0x1021db
[    8.437227] [   T1180]  ? _dev_info+0x6a/0x84
[    8.437232] [   T1180]  enable_store+0x95/0xe7 [industrialio]
[    8.437236] [   T1180]  kernfs_fop_write_iter+0x14b/0x200
[    8.437240] [   T1180]  vfs_write+0x21d/0x420
[    8.437244] [   T1180]  ksys_write+0x5e/0xd0
[    8.437246] [   T1180]  do_syscall_64+0x66/0x380
[    8.437250] [   T1180]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    8.437252] [   T1180] RIP: 0033:0x7f447c6459ee
[    8.437254] [   T1180] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 8=
9 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 0=
8 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[    8.437255] [   T1180] RSP: 002b:00007ffc44efa068 EFLAGS: 00000246 ORIG_=
RAX: 0000000000000001
[    8.437257] [   T1180] RAX: ffffffffffffffda RBX: 00007f447c23f940 RCX: =
00007f447c6459ee
[    8.437258] [   T1180] RDX: 0000000000000001 RSI: 00007ffc44efa210 RDI: =
0000000000000008
[    8.437259] [   T1180] RBP: 00007ffc44efa210 R08: 0000000000000000 R09: =
0000000000000000
[    8.437260] [   T1180] R10: 0000000000000000 R11: 0000000000000246 R12: =
0000000000000001
[    8.437261] [   T1180] R13: 0000559507d382a0 R14: 00007f447c78fee0 R15: =
0000000000000001
[    8.437263] [   T1180]  </TASK>
[    8.437264] [   T1180] ---[ end trace 0000000000000000 ]---

The warning appears because iio_triggered_buffer_setup_ext() (in=20
drivers/iio/buffer/industrialio-triggered-buffer.c) is called with thread =
=3D NULL
during the probe of the iio device and calls iio_alloc_pollfunc()
(in drivers/iio/industrialio-trigger.c) with thread =3D NULL and type =3D I=
RQF_ONESHOT.

A simple fix could be this:

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/i=
io/buffer/industrialio-triggered-buffer.c
index 9bf75dee7ff8..40eea3a44724 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_=
dev,
=20
        indio_dev->pollfunc =3D iio_alloc_pollfunc(h,
                                                 thread,
-                                                IRQF_ONESHOT,
+                                                thread ? IRQF_ONESHOT : 0,
                                                 indio_dev,
                                                 "%s_consumer%d",
                                                 indio_dev->name,


Are there any problems with this?

Bert Karwatzki
