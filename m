Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748937;
	b=YVxbeABOjDmcv8RcpiTqoGXE7Jvs1NoXVCltveOJkOsTz9JwpsU5s5TJG1PPcoxVifz7
	 mm1widVAMPK8iYBoqLDqmyhP2PkSeyaNy+swdegKM2oR1TTmZvOakgCbElOYBRsji2PxY
	 xeECWHKnkoYtBAzt/0/IiAnUVvuz3veNParkoE9YpgnIlItN7gb6kfG4S9UiuFhjgQkJ2
	 cgjQpzXeUim+VyyZBYaffs8eSxKN6qGD22KyY4cVMW2QwRi4VatprPDKrlqLLcbrtrmg7
	 WBWoGnzq+uSaW5JUPzMP7NOe2W0zdxWC3OERw7JgZeAOx0g3xZtL7ixF8n/h3TubgOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748937;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=mQMpD+fLV5CJKkZFiecRNC3PX+aEdx8cDJ8NvbBnsr0=;
	b=nvdtx3UiYos7kP/d02ieB+95YaYQecM5RUsJynE+EHsSXAXDbfSWRHcgCunNUI8L8CJQ
	 m/FNR7UXRYs7vAXsQ1tBqmt+qcJtZPhCwcySpPPDCTpq3QjLSY9J2vjSJ7g30zHQQQrrn
	 wfNmJ/ALrLoQZRw/HFm8t95pvdlVKOZuMw2kHxNRUNOT60EnhKYgXF0ELsu0uuy2s2Q0w
	 AbYIu2shaMQlw7kIIBkdgSYzUMi/TAr9HTuU2UaEP4GVJ8DHFunOseOohYFVl1XhMOl9E
	 Q/Fh3/uAaMMHyntJ/78+CKqDxIs/mEl91ieyIhEfAgwB/Kfd8Tn0h+FmRvLth/7uMFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5A606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F5A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748892ted829d02
X-QQ-Originating-IP: 1aGssj4OG+Q/r4t8pToZNFoVIHLJt54aOGg5vH5Rlbo=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7169322066803192688
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/18] iio: accel: add mount-matrix support to the remaining accelerometer drivers
Date: Fri, 27 Nov 2026 11:07:52 +0800
Message-ID: <5F08289E852625FC+20261127030810.3150676-1-hexin@hexin.host>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:hexin.host:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Mp6z4bZjgTSTy3PrPgbrk6y/CCEfJgvfGum70GfmyxnniYPNcjys/e39
	docouH3WMgEj+squ6UBZv1HUqgtkVf+DW259Obu3dq33fKbGps2ncIJ/CnMtPjWCXb+aGAe
	zSum8ae053XrZHkGw8madAO3UEDjO9HF/qaBuLxPgavqNFQGpMvlw2qCakrT5n8liZ1nJse
	9eA8C1zGYNDWhJ6/v4nt0kgFbOsfRmMIJ7y+FQkSgoTMaxn0/kXKz6J+RdakeQB1XwvfEoo
	B7+HhEGz3OHyVi3GU1Uhx7M1y5V4TScg661im28s2n9Wb3tcdGy+xwinHi6MXLk3YiK3qtR
	RBzXxaQ2lPlDQBVafep9yyxDgfgU+NTEdI7Crtp4ueQDgD9w+u2BHb9yA2pNpIrtsLMB9P/
	kP29WTdrLf+txwzSf0tbTYsW8asfYiPtCtHpgcllC9V2quvVsFXLfMod0BfluLAy4mcY0WE
	SZbmOq36hMAceXcIuQsTxEiOKzy/x7Gwi+irdZsB2tnv+NbHMFuG/ebRGkaXcDHUmnDRSo6
	XwewKmyNZxhq6RWrqhGLgNVP+xTz3a4G6Zh2Asdh+W+ILaUEEn7FpOd4zi49+ua5RgBh/Bz
	5WVOBMJBekbAjkm8+Gpr2GrmCd/ELbxAnslu5mqPLZ05WRFUEou0YKpRKcGfkaULhAij5dL
	H2gaI4b/I7Esa++Tuwyvrpc7H6Ja840FYiKDKql3RlKSFzDcYTUcyLEN3NlyMSNNqfK7ism
	h19CViGH5q6e0eOHmeO242o5r/Mbr6oWEhw0+5Q4KMllezAakZ17WzK91Z7T3xCASE9tM5Y
	i9nWQ+fmLeVKYVMzQH3METbKu4qp0W9G+tpafHQnRNtmAhC7bkfY3sHJ7510aU9Aeym7qz3
	+RGAOihLQOFz3a/YfUO60VvkoQ5Y/wYPVDnwvyHfnkWE+8uB66W/9sWfXfuURXjsjFF+kZe
	xkxBxM6hJVcesR9yGEoPNafa32+jbAoRgF3YX64WTOxFuI6N81j5uP35zYTaLRFPOFS0diF
	ZP75H94cEc3gQb4GDzSnbevjzClpA=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

The accelerometer drivers in the tree are inconsistent about honouring the
installation orientation described by the firmware.  Drivers such as kxcjk-1013,
mma8452, bmc150 or st_lis3dh read the "mount-matrix" property (ACPI _DSD on
x86/ACPI platforms, devicetree otherwise) and expose it as
in_accel_mount_matrix, while the drivers patched here silently ignore it.

That is not a cosmetic problem.  Without the property the kernel reports raw
sensor axes, so iio-sensor-proxy and the desktop see the wrong orientation for
any board whose sensor is not mounted axis-aligned with the display.  The
fallback used in that case, a udev/hwdb override, keys off the sensor modalias
plus DMI; it cannot work on platforms where every board reports the same DMI
strings (all of our D3000M boards report "PHYTIUM LTD / PHYTIUM D3000M"), so the
board's own firmware is the only place that can describe the orientation.

Each patch is mechanical and independent: store the matrix in the driver's
private data, add an IIO_MOUNT_MATRIX() ext_info entry to the accelerometer
channels, and read the property once in probe.  No behaviour changes for boards
that do not describe a matrix (iio_read_mount_matrix() falls back to the
identity matrix).

Base: v7.3.6.  Verified by compiling drivers/iio/accel (allmodconfig,
make M=drivers/iio/accel): 71 objects, no errors or warnings, and checkpatch.pl
is silent on all 18 patches (including --strict).  The stk8ba50 change was
additionally tested on hardware, a Phytium D3000M tablet whose STK8BA53 is
mounted rotated 180 degrees about X.

Deliberately not included, because the change does not fit the same pattern:
adis16201/adis16209 (channels come from adis.h macros), adxl313 (private data
in adxl313.h), sca3000 (channel macros in a header, two channel arrays),
mma9551/mma9553 (channel macros shared through mma9551.h), and the
hid-sensor/cros_ec/ssp drivers, which are not firmware-node devices.


He Xin (18):
  iio: accel: adxl345_core: support mount matrix
  iio: accel: adxl355_core: support mount matrix
  iio: accel: adxl367: support mount matrix
  iio: accel: adxl372: support mount matrix
  iio: accel: adxl380: support mount matrix
  iio: accel: bma220_core: support mount matrix
  iio: accel: bmi088-accel-core: support mount matrix
  iio: accel: da280: support mount matrix
  iio: accel: da311: support mount matrix
  iio: accel: dmard06: support mount matrix
  iio: accel: dmard09: support mount matrix
  iio: accel: dmard10: support mount matrix
  iio: accel: mma7455_core: support mount matrix
  iio: accel: msa311: support mount matrix
  iio: accel: mxc6255: support mount matrix
  iio: accel: sca3300: support mount matrix
  iio: accel: stk8312: support mount matrix
  iio: accel: stk8ba50: support mount matrix

 drivers/iio/accel/adxl345_core.c      | 20 ++++++++++++++++++++
 drivers/iio/accel/adxl355_core.c      | 20 ++++++++++++++++++++
 drivers/iio/accel/adxl367.c           | 20 ++++++++++++++++++++
 drivers/iio/accel/adxl372.c           | 24 ++++++++++++++++++++++++
 drivers/iio/accel/adxl380.c           | 20 ++++++++++++++++++++
 drivers/iio/accel/bma220_core.c       | 24 ++++++++++++++++++++++++
 drivers/iio/accel/bmi088-accel-core.c | 20 ++++++++++++++++++++
 drivers/iio/accel/da280.c             | 24 ++++++++++++++++++++++++
 drivers/iio/accel/da311.c             | 24 ++++++++++++++++++++++++
 drivers/iio/accel/dmard06.c           | 24 ++++++++++++++++++++++++
 drivers/iio/accel/dmard09.c           | 20 ++++++++++++++++++++
 drivers/iio/accel/dmard10.c           | 24 ++++++++++++++++++++++++
 drivers/iio/accel/mma7455_core.c      | 20 ++++++++++++++++++++
 drivers/iio/accel/msa311.c            | 20 ++++++++++++++++++++
 drivers/iio/accel/mxc6255.c           | 20 ++++++++++++++++++++
 drivers/iio/accel/sca3300.c           | 24 ++++++++++++++++++++++++
 drivers/iio/accel/stk8312.c           | 24 ++++++++++++++++++++++++
 drivers/iio/accel/stk8ba50.c          | 20 ++++++++++++++++++++
 18 files changed, 392 insertions(+)

-- 
2.53.0

