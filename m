Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D33939AE
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791760491; cv=none; b=oyjTbGub+z2yEMdl3F9/YWiW3RTTFrGx0j+sJfx9faPjjRAzSpH+0Kti+9djqGrNnBZ7Q9RVlZDq9cmlBXfkjrGdxyvZV3cbOgOk3nFo6LiML+Kz84IVa0s2GimRglWqeBNzpRYBpPEVE9Ufs6M3F8Q3Xl1wFFFvRVbvHCGEym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791760491; c=relaxed/simple;
	bh=O1PAz8D97ydn1ggCEyHWzhfhZnHI0IFlq0uiqsftuW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe12hdWLOKTAhtPi3SNNOw/nbbDM0Jae2niUJnUPNCUe+YQ3UriOao/e6iNvsecsFXP1qZ31bolS+7pGIwTHPEjJKsVPnpesKho4x+2B521XmKe3652rf1jdPHnlZPXCreDOsTcnq+AvX6C6YDh+rJGJlrV9tJyd2WxNnJV9aYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWCXeNvl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWCXeNvl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-886e61fa30fso360832b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791760490; x=1792365290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F6zqR0qLGRg6/t6Ph88TseNLhZsL2OrkzmFRSjq7snE=;
        b=VWCXeNvlW6yRBC10fCdQMTJi4kqRhQiR7ou0/v8Bde16aRUX84bjVeAuUcSAhi/8PX
         VYVxGhdaNcZdu+a3xEO+f93LVo+qLSJwziUF5zc+WpenUsC+AHK9/L8gXvLdEaVmuc8L
         JnG9TouXC+LIZElFu2Fv3wcRCZYhSH18IuxjoquZS22WZicb38dVols7C6kTwwchl2AW
         ZRbkKQk5N3UR8axpHAthumbRLYKTkIRzhRFehB8WbGfGAOhwvwaLCFznFiVvQIM7ckJC
         AMIoyWBlRoHWTeA/zOG0wdVzQXwp2WnmbLLunGnKgf7OJHGwQpJwnQeGsfHi6mOqEthC
         pbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791760490; x=1792365290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F6zqR0qLGRg6/t6Ph88TseNLhZsL2OrkzmFRSjq7snE=;
        b=g3F+PJjKFABwt/EXp69g2S4Ftg3SDDfCzAv4j1zNxZOqS4CrQuKzbM07syWe1E99Dk
         MXpsHkkvqgW9NWFHwVo+6ntgbcSdibna7FCX7H4rgFm5Ams6WcrqVhTiCI+y2v+g7osI
         M68StyEpvj543dLPISy4S9L+MlZt/NWPMMcDIumn/K6u9Z3XTbizCvNKv929KYcUXN3w
         gHapwv9I4tfkOAKVHHrBQFWRuEtrzGlsiukp210v3N4PWOjQlXwoggxPJDfcE/ijuEQi
         xSnPjeC+TuZFar6eW9tMBoyxbmxgR2x7zHUMqDuHE2vHb76L2WzYJyY+LMM9qGNRddnf
         PFfA==
X-Forwarded-Encrypted: i=1; AKwUvByoZS65kse4sq+q9BDtLgtxPMbWYnqJrK0+gj8/ZyNP6oB1IYo956gB6mqlwRLGBnmoZ1Ldd9zvlr4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDB8SKqu1A1F6MMbcKGnRa3zaWxrd//3tTO1hHgTZcG5i6rCeo
	zKmsRaFLxZMfir6ujsSh9vmGzfUuCSxSQnoaYZk9gUhoUSwvJMGK2OE1
X-Gm-Gg: AYBFou3jlXZ/EygIe7/orqvRLUKicf9gb4DKGddR8kLxsK3h7bd1ql1IIPeguzonme0
	sg6NrRfwGIfJhHV9ZpyUVlfLNsqihnRDxCjY3tD8u35oAEhuCuwkbyoAQ2UfV5GVsnuUugoiNgx
	c/MbsUdIDIbi8o4rvVaO6NV6dC5aztWkvu6IAg/KGQRF29p7mGfBq6YRgU+1l0EBkmyJwCThqPP
	AMuyLUo3tf+fksu59CzIjnpwXiMUdlrsvZN3tJXCPADE+0mnXJ6UTkFhrh1Kfb091uGjh3TW1KI
	+FlbQpTNC/cxPwq1tyszJSHkKx3kHIgj/H5Z28wZz43n/GManimv/hUM0uQaS9WZwrEj06HZ/dw
	xa1xxmNBGiQglCf8HPXChZOvXCb/yxu9DUrxnbTVFKB1axOtnhl2AEKXUWyVP0LuNAaNaNjxtRu
	UXkMGJtCIDn1/S8jw0MHwFyOToza2ORPs9vokRxXIXXlnH+xNmFStTf3l7daH6x+DiGQcEeLhiC
	yo0uWU1jTxXTtRioFRl0YlcOBEVNT/l1aM975Gp+/uaQxORUzKAaujgWQXn0ZTfXtkoa7NgvE1Z
	11IcQnk=
X-Received: by 2002:a05:6a00:178a:b0:874:705d:f640 with SMTP id d2e1a72fcca58-897c73f76d3mr5738289b3a.34.1791760489656;
        Sun, 11 Oct 2026 16:14:49 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c48945dcsm3188917b3a.54.2026.10.11.16.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 16:14:49 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: kimjinseob88@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v11 2/8] Documentation: iio: add Open Sensor Fusion driver overview
Date: Mon, 12 Oct 2026 08:13:34 +0900
Message-ID: <20261011231340.42885-3-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011231340.42885-1-kimjinseob88@gmail.com>
References: <20261011231340.42885-1-kimjinseob88@gmail.com>
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
 Documentation/iio/open-sensor-fusion.rst | 81 ++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 3 files changed, 83 insertions(+)
 create mode 100644 Documentation/iio/open-sensor-fusion.rst

diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index d0fb32f4b80f079d837515c5f2451dd76d8f93c6..7f3654202ac457c2a8b3ade96d678426867c3362 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -42,4 +42,5 @@ Industrial I/O Kernel Drivers
    adxl345
    bno055
    ep93xx_adc
+   open-sensor-fusion
    opt4060
diff --git a/Documentation/iio/open-sensor-fusion.rst b/Documentation/iio/open-sensor-fusion.rst
new file mode 100644
index 0000000000000000000000000000000000000000..5d94a247ed8f351d92bfa2e1727d2004720015b6
--- /dev/null
+++ b/Documentation/iio/open-sensor-fusion.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Open Sensor Fusion
+==================
+
+Open Sensor Fusion is a sensor aggregation hub interface. The Linux IIO driver
+receives device-to-host frames over UART and discovers sensor channels from
+capability reports. Device Tree describes the hub using the
+``opensensorfusion,osf-green`` compatible with an ``opensensorfusion,osf``
+fallback; individual sensors are discovered at runtime. See the binding in
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
+interpreting payloads, and tolerates reserved padding. Unsupported major
+versions and unknown message types are ignored. Unsupported capability entries are skipped
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
+Each capability report is a complete inventory snapshot, not an incremental
+fragment. The driver validates all supported descriptors before registering
+IIO devices. An initial report containing supported descriptors establishes
+the supported inventory. An empty or entirely unsupported initial report
+establishes no supported inventory and leaves discovery open for a later
+supported complete report. Supported descriptors must advertise a nonzero scale.
+A sample's channel count, format and scale must match its registered descriptor
+before it can update the latest RAW cache or be published to a buffer. A
+rejected sample preserves previously accepted data.
+
+After inventory establishment, later complete reports continue to be processed.
+Equivalent supported inventories are idempotent. Reports are compared by sensor
+type and index, independently of entry order. Reserved padding, advisory flags and unsupported additions do not change
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
index edae5bf594fc3c72fb39e14b797c7b2eccc11471..86a3e5de2f01f7a1e9791724caa6e19df4e61d70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20541,6 +20541,7 @@ OPEN SENSOR FUSION
 M:	Jinseob Kim <kimjinseob88@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
+F:	Documentation/iio/open-sensor-fusion.rst
 K:	opensensorfusion
 
 OPENCOMPUTE PTP CLOCK DRIVER
