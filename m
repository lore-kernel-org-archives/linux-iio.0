Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F235DA49
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262150; cv=none; b=Lje4bBzYp+9XTP6w+c/WECJ+TWqDChRjDZ69p/gp/lx01TaBuhdPZxxYdpxvm+UqJbhLj2SowZQnupilrZP1ii6RFAQd9LOuNjB4dAwbpfDbntTiulDlfXyqXbHJddcjQrSyLZPUZd3z6pJekecRMeuy8J89ZgDuCyHkR0eNqMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262150; c=relaxed/simple;
	bh=pfyc341zXwBMZUZMj3FlAUbHl7aoZPTE0DnxlgS3F+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLIkN4VcMZUC0T7brcWSjg8/GPZypEZvcGFlsSsFs+vVedU8DWtk43ZlFyms7lvtU7za8S59WKJSsSkd0oLSKC7WiCQ2R7Ddj6qBSQoMd7dzorjutECxv0Su8VsjpOtO5EobS4bigEWBUwwHt2akKu565qP78lDV/rKKRUXlBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9yGWpdI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9yGWpdI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bd2c147abaso26584995ad.3
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 00:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779262149; x=1779866949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/uTr0N6/dohQUIDQm2+TsDj3+wcu3fpVpKrvpLtD7k=;
        b=O9yGWpdIYqbAYXLRxZ0LVq345gExNXJQisM76xIlVWQHo5KApOFzydmcicoc5Tj5ep
         qPru9Qu5SHIiBgU5tSEHSB4Zawg43JtwZcoq/fQ59AGTjPUGQRzyGT50gcaQsoELtwH2
         e9EAwsn8nhOlqwi6u/1sbIDfTSpwRuDiKdWgcCIg3QIjDCdB6forxv3S+1Ciy26hT8SI
         3h+ZD8jT68l7jRoTqFpJcJLGNMOfub3TbvpjPb4NW95GvrxCHL07bd44KQqfhhW/p09J
         8x8osgtzAj0CXFDGLUmRaUPWWDuuwUHiVmy9fLIOwFViFN9qQyf2fV9fDZSB1k2zwbkA
         PFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262149; x=1779866949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/uTr0N6/dohQUIDQm2+TsDj3+wcu3fpVpKrvpLtD7k=;
        b=sYvlViFkVwrofKUlo4nIdQkrWmGA+4zQy4HXYSE/KXbH0NpBy3U1cURBrwsqF5vRf/
         +demgVluZ0U94SOVPjNoAnbhOM4ePL+YMzNatYS8cfOJPBMolxS4Ps0JdVWyKhOQZYsN
         N+xCHLzAGaQI303K+rcvWZSIpyZR7YxGjF61ziRGsQd7SWm+79AZ9myvcd9a4b41vP2X
         dOIgfxiMTVhwb5krtyRJ66vLDWIZ8/ZMvMpEUONUEX3+fSzPr85GMB2UpvajJvPCFmB0
         VGAcPVA9azfmyRsuh8W1jo9BW0sdCyAcTrGLswmYJKgSPSYflBoiF9nMJBAF0cI+h/vV
         ytwg==
X-Forwarded-Encrypted: i=1; AFNElJ/uUzuAeCzjQ9mYgKrVD/mrkmfmzp1CIpH/m69DRpRlNWUtRfurDCAzHCOlQ1lRHfT++VAFfJ0/EQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4BXB5ttNLkENijKZVU77OOkkTptVlreqMGoqmC8uHXWf0xTk
	mpvOhSEx0iKitsl1WevXEnc/I5Je4wQujTpIVUZY9IS+06uWdUXCIVoM
X-Gm-Gg: Acq92OHoFskCGcbF0jsYI4CKhw0XgtC+pEGnLl6ztC4FXoQh1Mc+rKgcdvF6k4zRC2g
	WUY9sCft5hUD384GFZaO0aM9LN1gfHLJubHedjQEokEG19kj4iMhCzpvB/TUNkAVxsOeOzMjLyZ
	0yPOlARZnAM7tOeD5bVa4a1v/IRAvBudX6kRQ8YfxPMcuqPETfA3wYtGw7NCFfE7Sp3K2M7WTB1
	eKrMNaAY7DRTxpJegmzWsh6xshb8GrirlnvhzPSvadR5jSemqnofivYYXSJ7BPTPCEEvodq0nSP
	j1xB0qXqjhbV2Zd5sQJ4ibfyWlHwjmgMsV+6YVkmAaGfb92YklRQ2uuTQCKp0P4hb4kgGsI5tEz
	n4OXPT9GGH4Lw4DOhABBDi/MC736T3eclQgHI+vw5K2BrepSvjQRGKG1q3PD9Gss50Bu7cYsKAe
	PFq0b/8awYg5iIr/GmPmiy8nH7BO5ZhLkrAoRCAtR25RmScl/O70owV1OUKWCZUOWSWLz5b+ytH
	rZ5QdBiVcNg93AyCF6aubu0ndD7kSfuIKJjFr5ViSe42v6L
X-Received: by 2002:a17:902:da82:b0:2b2:5491:e32f with SMTP id d9443c01a7336-2bd7e821ad6mr244788625ad.16.1779262148716;
        Wed, 20 May 2026 00:29:08 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f27csm206258595ad.25.2026.05.20.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:29:08 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/3] dt-bindings: iio: imu: add Open Sensor Fusion UART binding
Date: Wed, 20 May 2026 16:28:41 +0900
Message-ID: <20260520072843.3593-2-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520072843.3593-1-kimjinseob88@gmail.com>
References: <20260520072843.3593-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding for a UART-attached Open Sensor Fusion device.

The device is exposed as a serdev child node using the
opensensorfusion,osf-uart compatible string. Keep Raspberry Pi overlay and
test notes outside the binding.

The binding has been checked with dt_binding_check.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 .../iio/imu/opensensorfusion,osf-uart.yaml    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml
new file mode 100644
index 000000000..6f329c326
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/opensensorfusion,osf-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Open Sensor Fusion UART Sensor Aggregation Device
+
+maintainers:
+  - Jinseob Kim <kimjinseob88@gmail.com>
+
+description: |
+  Open Sensor Fusion is a UART-attached sensor aggregation device. The device
+  exposes an OSF protocol v0 data stream over its host UART interface and may
+  report capabilities and samples for multiple sensor classes.
+
+properties:
+  compatible:
+    const: opensensorfusion,osf-uart
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+        sensor {
+            compatible = "opensensorfusion,osf-uart";
+        };
+    };
+...
-- 
2.43.0

