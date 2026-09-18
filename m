Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC151EDFD
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755938; cv=none; b=aqdxHkjcE+hy410id1BtbfDOgcAHOeOiVR7i1Qj2l91jymtnqlWNMnBsT/oWxVqmxgVJ6erudFp8NU0/x541DDYQSFo6LK5WQZiWwU8S54NEFKQTe/eRx125l+HoxZB1oQ0j8tiGwh9egCud7HoLfs3nJ72DFxV9+kXctPo+UwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755938; c=relaxed/simple;
	bh=R9dGmC+v2bw7NAh5ww8FtZ986UH1u92ISE+NGE6Rr5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd7Nrai2QINSGHla1s6aT5vIys1FZsGgIomjf+ME0GPHkzRAbg52pb3zaLQdELx5IB6JcomXSUSuQtYsIUtfvApPlw78IYTPZQ9vlWPHH2gu+F6yHM9+k7PT2xbEIEPxS48DQom28jf4oXxqKZrleeeearbsiZZB8+/85c3cIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuDhUrlx; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuDhUrlx"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed9866so9766585ad.2
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755934; x=1790360734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s2CKXsU1UIOkbMCPUX3VEuk4lYZb15gx+txcbf/aJKQ=;
        b=BuDhUrlxhnKebOyxuOHfj0fzA4OdpGJp11GULD0VVXcPu3aVt1licKZgF/rwY+ewJC
         WUMX7fGpTcsjjU3gmtm/dH9hmk77t1Tpl+CjfSSIJiUdBEZRmAigflBnSgQYtbWOLI1A
         CtDmqYFyK7e8L28Xjg0AMFWhUiHzycvFeQLugBIEHcb/Bbyglpjer3CNQIR1v0lUPsW3
         med8s7ToVe3xsl59BYWaAUVZPUlTuNeZ12r3vsHJNnX1/tDsH+5xQHMOpdd2nYSYbCHl
         WCogODA9FYSMc6I1cjBpw6zUgsAuP0MBKO+lpJYPa/nSpsB3OHngeKVmVvxIPSUCXkO6
         hp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755934; x=1790360734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s2CKXsU1UIOkbMCPUX3VEuk4lYZb15gx+txcbf/aJKQ=;
        b=jNetmts9DEIebblC2WWQSmJrmTWcrxC1A9TO7ksHLbCZK3lirl68ZRxGbOvnM7K0Rk
         0X5/tQ4qCas3MHPWlYY8fQpHFm/eOr2E6dGTmsrKyzKlX8s9+afY4Uw5bVroLNERCSd0
         3gHR6Q/kkOwTgCJe266OOB+MHaBSixaJMx9t4dqSZPD/g4lnkSnKdaJK1RvtttAWTq0b
         sNQR2bBxRGXMUO+FohN2z66cye7caS81wbMfGhdcY2DlO4oGnH+FMibLaSDzt3GAvuVX
         ej7ToP8X5VAKvaa07c0EMfXE3++pZ9/3FtRpYwX8TAuD+IymhGi3f0NOLaJdahp1Vd2k
         UCBw==
X-Forwarded-Encrypted: i=1; AKwUvByW1BmNXRzoaQhg/5SAyyK/7X7QjpAel8pMOCKdn5+9E/Nsojfu2hHLLssCTO9sbrgtH6SCkiqFXd8=@vger.kernel.org
X-Gm-Message-State: AFuF++lBQGBDHRjUOhvKlV3d0k4L9i1ckFWlhNci5tito9T2ZavVVNLH
	yCHdyQL6k3uxLrq+ixGdhVkG753sGcaCeUNoUufhFLwoLEIM0VGxuZWZ1qT4mobL
X-Gm-Gg: AYBFou15h0SyVQjfyVIWApxqrcU5F3bvq9JPDKTQWdmaFDPVw3jZI6ROWXA3yaGL+Gg
	oWL94EEXZCsj2KP4OiBBDc2YbXgx3sxsCwOP24rp7OgzhrHP7Hk3gp+WDvAmBrCegr8tzO+XIXE
	ppm9KbCOrhcNUHNnL2dul459fUVcn1aJeBWT6BlPiC7vUAIQdU8lmI6igGb2DrnJobFjhdENv+Q
	BoYLFxlZ14RmL0BAgsMfOawqEOjzgKu6+8wqCXoD6VGQWCgLa0NzQr5k8d0GPqMG5OnbUylSIG+
	Vc/fqPcKdgz9fFrwuI1O3ZIDJZExH0SB7SZ87cfXTFp3lajm4+u8xWK5GamJPwYAtOgN41qTnJV
	9pIQArCUwZjhpVIKxmK6IVv1+O3wYsu6DhieoQhDDvF/iIyKMNx715ljyPh7cDXJ3OjIUDejjeH
	6Ozb60UpYuB5nlB+jNL39rtin4zCXs6SY+t9st0nhSXENnVpMSo17tVx0AvJ2eUB4TKVZQ1EnpV
	nnVNPx7SySXgxRO09nbQJQXDubuuthq4NFwka6JPNWQhCp6qS6qE2OYysE25xL2f5XpQ0e6qxc+
	SyzuVyqN
X-Received: by 2002:a17:902:8496:b0:2dd:c053:a6f6 with SMTP id d9443c01a7336-2ddc053a766mr7512155ad.40.1789755934291;
        Fri, 18 Sep 2026 11:25:34 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc16b49casm871895ad.7.2026.09.18.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:25:33 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andriy.shevchenko@intel.com,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	joshua.crofts1@gmail.com,
	u.kleine-koenig@baylibre.com,
	julianbraha@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v10 2/8] Documentation: iio: add Open Sensor Fusion driver overview
Date: Sat, 19 Sep 2026 03:24:40 +0900
Message-ID: <9fdbc924bf3387a4d33d1258ea21ac33abef65bb.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the supported OSF receiver profile, runtime sensor discovery,
IIO channel units, scale validation and session lifetime.

Link the project-maintained fixed wire specification instead of
duplicating its layouts and compatibility policy. Explain host IIO
timestamps and the explicit rebind needed after a changed inventory.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 Documentation/iio/index.rst              |  1 +
 Documentation/iio/open-sensor-fusion.rst | 77 ++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/iio/open-sensor-fusion.rst

diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index b02b879b053a..c2b7963348fd 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -40,4 +40,5 @@ Industrial I/O Kernel Drivers
    adxl345
    bno055
    ep93xx_adc
+   open-sensor-fusion
    opt4060
diff --git a/Documentation/iio/open-sensor-fusion.rst b/Documentation/iio/open-sensor-fusion.rst
new file mode 100644
index 000000000000..03ab36aca5f8
--- /dev/null
+++ b/Documentation/iio/open-sensor-fusion.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Open Sensor Fusion
+==================
+
+Open Sensor Fusion is a sensor aggregation hub interface. The Linux IIO driver
+receives device-to-host frames over UART and discovers sensor channels from
+capability reports. Device Tree describes the hub using the
+``opensensorfusion,osf`` compatible; individual sensors are discovered at
+runtime. See the binding in
+``Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml``.
+
+The OSF Device-to-Host 0.0 specification is maintained by the Open Sensor Fusion
+project. The canonical specification_ defines the wire layout, compatibility
+rules, reserved fields and physical units. This document describes the Linux
+receiver profile and its mapping to IIO.
+
+.. _specification: https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9cdea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.md
+
+Supported receive profile
+-------------------------
+
+The driver supports the fixed OSF0 frame layout with protocol major version 0.
+Compatible minor versions use the same known message layouts. The decoder
+requires exact lengths for known messages, validates CRC and bounds before
+interpreting payloads, and tolerates reserved padding. Unsupported majors and
+unknown message types are ignored. Unsupported capability entries are skipped
+individually. A CRC-valid application rejection consumes the complete frame;
+an invalid frame candidate is resynchronized without trusting its payload length.
+
+The receive path handles sensor samples, complete capability reports and
+device status. Its limits are 4096 bytes per frame and 16 supported sensor
+descriptors. These are implementation limits, not protocol-wide maxima.
+
+IIO mapping
+-----------
+
+The supported sensor classes map to:
+
+* accelerometer: ``IIO_ACCEL`` X/Y/Z, in m/s^2;
+* gyroscope: ``IIO_ANGL_VEL`` X/Y/Z, in rad/s;
+* magnetometer: ``IIO_MAGN`` X/Y/Z, in gauss;
+* temperature: ``IIO_TEMP``, in millidegrees Celsius.
+
+Each registered channel exposes signed ``RAW`` data and descriptor-derived
+``SCALE``. Multiplying RAW by SCALE gives a value in the channel's IIO unit.
+Buffered samples use signed 32-bit values with native CPU endianness. Active
+channels are packed into the scan, with initialized padding before an optional
+64-bit timestamp.
+
+Discovery and session lifetime
+------------------------------
+
+The driver validates all supported descriptors before registering IIO devices.
+An empty or entirely unsupported initial report leaves discovery open for a
+later supported report. Supported descriptors must advertise a nonzero scale.
+A sample's channel count, format and scale must match its registered descriptor
+before it can update the latest RAW cache or be published to a buffer. A
+rejected sample preserves previously accepted data.
+
+Repeated reports are compared by sensor type and index, independently of entry
+order. Reserved padding, advisory flags and unsupported additions do not change
+the supported inventory. A supported key appearing or disappearing, or a
+change in its channel count, format or scale, faults the bound session.
+
+After a session fault, new cache updates and buffer publication stop, and
+direct RAW reads fail. Existing IIO devices remain until driver teardown.
+An equivalent report does not clear the fault; explicit unbind/rebind starts
+fresh discovery. No fault-specific userspace ABI is exposed.
+
+Timestamps
+----------
+
+Buffered samples use the selected IIO host clock when they are pushed into
+the buffer. The device timestamp is not correlated with that clock and is not
+used as the IIO buffer timestamp. Device timestamp or sequence discontinuities
+alone do not start a new host session.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9463b8111d52..26b9b2862724 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20515,6 +20515,7 @@ OPEN SENSOR FUSION
 M:	Jinseob Kim <kimjinseob88@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
+F:	Documentation/iio/open-sensor-fusion.rst
 K:	opensensorfusion
 
 OPENCOMPUTE PTP CLOCK DRIVER
-- 
2.43.0

