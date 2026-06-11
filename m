Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1138D404;
	Thu, 11 Jun 2026 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168226; cv=none; b=bluDCttS/zTaGZ703mW4wZ1o4aQRylYO3pQjsQRD11JWRrKhUrS/7JGIQWIYmOeKKeyN2SDWex3bAhPl8L6TfQy7j0922p5y+2MxNCzfBsfRPabXHTKVs4uvVkR/Ldap2YEQ54mTPshtUKdtNv4wk++OufiSh9z1EVRM76j3ZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168226; c=relaxed/simple;
	bh=RfcGbCGMVrNcsQdOPDJHGTzAW0T6R2l4L7uw4Wl8W1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jyzhOWs6VUzIxgPTjL5i5EyLFFnf/FrZbPE3zxTn4FAal9+En9XA+PY6LF+nm1kmu9CRYxfrlCRwOlmh+A99elo6lGnG0+06Axq31T3FGPTUY1L5eDJB/zpbYqPp3ZPioCJWLix1XGuchLNWKDI7cKKiDYX6lrKSssLb0279pnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mepEN2DY; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UmyV9qsp; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mepEN2DY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UmyV9qsp"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gbc311dFzz9tMq;
	Thu, 11 Jun 2026 10:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781168221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wNFcii07FzvcPEBWKQvN0dgoGNWgTDl31XzJlogED58=;
	b=mepEN2DYkthkvACY+8HJ6K0yjRKfHuf37BkpwigBLTr4qjEYdTAsQMp98N80OF4FY7J7e3
	llYbaQ/xyxAEzULqCXc/QqdAFhtkJTiMm4idGfXaC6L0XfT7Uy2Bs94tPF8bUZ4pZPusKd
	W/CP7rB7Wfy1MBSWrs11Ooa2ohcKZZ5ClO1EUh544JJ5hCe2avwYX6FmhdoB++l3R31mJd
	yXJotmUclmi5iNqSkzmHKBM/2MjAoEHDCopQwkfGxmdOKj+ujTuRZclnpJTft2pkkVM+pi
	ooU0jA54XlfWvvRF+BXVu6QiUMipqckFIKQrauR423j6Vhqyh94stYHjN0gh1Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=UmyV9qsp;
	spf=pass (outgoing_mbo_mout: domain of manuelebner@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=manuelebner@mailbox.org
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781168219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wNFcii07FzvcPEBWKQvN0dgoGNWgTDl31XzJlogED58=;
	b=UmyV9qsp3Xg8noBzFodG7QE6QQGilzMF+5mDaCxOCRzUKZdZthHobBiYp0Kec3PMBiTsXl
	wHKxPBSzcwn9SGuuCkLiPXxXujdpH2EwxZcpiq3uLf4xP9ZJZqxRKG92eR/UBdEtqKYuRt
	a8g96qOo2QFgtS/Fp1odAySwlifjQG0JAcR2873sQLV9Mw06eiN/XaAc0MbA+aZSJ+MQVL
	JBlvqlsd1rz/Ld3Hy3uTzGztjEA91Zub8wOki/uo21+L6vgPtta7NzTnLMnUd6tsRWRW7A
	Lo8bal8xnApDYHb5B6bC2mKbtmxza4cfJu7PSaLTboMwcD1Dzt0vt0eLiT3JSw==
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-iio@vger.kernel.org
Cc: Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH] Documentation: ABI: fix brackets and bracelets
Date: Thu, 11 Jun 2026 10:56:21 +0200
Message-ID: <20260611085620.127959-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: d3dg7p3j1sumah1ke4caejbfebrm34xw
X-MBO-RS-ID: 82f3dc802af3ecfe8ad
X-Rspamd-Queue-Id: 4gbc311dFzz9tMq

Fix missing and needless brackets
Fix missing bracelets

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
 Documentation/ABI/stable/sysfs-class-infiniband      | 4 ++--
 Documentation/ABI/testing/sysfs-bus-iio              | 4 ++--
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192   | 2 +-
 Documentation/ABI/testing/sysfs-firmware-dmi-entries | 2 +-
 Documentation/ABI/testing/sysfs-firmware-gsmi        | 2 +-
 Documentation/ABI/testing/sysfs-uevent               | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
index 694f23a03a28..e48a0d2fb4e5 100644
--- a/Documentation/ABI/stable/sysfs-class-infiniband
+++ b/Documentation/ABI/stable/sysfs-class-infiniband
@@ -157,8 +157,8 @@ Description:
 		all VLs from this port. This may include packets with errors.
 		This is 64 bit counter.
 
-		port_rcv_packets: (RO) Total number of packets (this may include
-		packets containing Errors. This is 64 bit counter.
+		port_rcv_packets: (RO) Total number of packets, this may include
+		packets containing Errors. This is a 64 bit counter.
 
 		link_downed: (RO) Total number of times the Port Training state
 		machine has failed the link error recovery process and downed
diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d8d6d85235b0..83471072cff0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -917,7 +917,7 @@ Description:
 
 		Note the driver will assume the last p events requested are
 		to be enabled where p is how many it supports (which may vary
-		depending on the exact set requested. So if you want to be
+		depending on the exact set requested). So if you want to be
 		sure you have set what you think you have, check the contents of
 		these attributes after everything is configured. Drivers may
 		have to buffer any parameters so that they are consistent when
@@ -973,7 +973,7 @@ Description:
 
 		Note the driver will assume the last p events requested are
 		to be enabled where p is however many it supports (which may
-		vary depending on the exact set requested. So if you want to be
+		vary depending on the exact set requested). So if you want to be
 		sure you have set what you think you have, check the contents of
 		these attributes after everything is configured. Drivers may
 		have to buffer any parameters so that they are consistent when
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
index 28be1cabf112..108ea0abbdb6 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -16,7 +16,7 @@ Description:
 		In bridge applications, such as strain gauges and load cells,
 		the bridge itself consumes the majority of the current in the
 		system. To minimize the current consumption of the system,
-		the bridge can be disconnected (when it is not being used
+		the bridge can be disconnected when it is not being used
 		using the bridge_switch_en attribute.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw
diff --git a/Documentation/ABI/testing/sysfs-firmware-dmi-entries b/Documentation/ABI/testing/sysfs-firmware-dmi-entries
index b6c23807b804..ed7d9d06a9ff 100644
--- a/Documentation/ABI/testing/sysfs-firmware-dmi-entries
+++ b/Documentation/ABI/testing/sysfs-firmware-dmi-entries
@@ -93,7 +93,7 @@ Description:
 		  /sys/firmware/dmi/entries/15-0/system_event_log
 
 		and has the following attributes (documented in the
-		SMBIOS / DMI specification under "System Event Log (Type 15)":
+		SMBIOS / DMI specification under "System Event Log (Type 15)"):
 
 		- area_length
 		- header_start_offset
diff --git a/Documentation/ABI/testing/sysfs-firmware-gsmi b/Documentation/ABI/testing/sysfs-firmware-gsmi
index 7a558354c1ee..88ca75d323d1 100644
--- a/Documentation/ABI/testing/sysfs-firmware-gsmi
+++ b/Documentation/ABI/testing/sysfs-firmware-gsmi
@@ -18,7 +18,7 @@ Description:
 
 		/sys/firmware/gsmi/vars:
 
-			This directory has the same layout (and
+			This directory has the same layout and
 			underlying implementation as /sys/firmware/efi/vars.
 			See `Documentation/ABI/*/sysfs-firmware-efi-vars`
 			for more information on how to interact with
diff --git a/Documentation/ABI/testing/sysfs-uevent b/Documentation/ABI/testing/sysfs-uevent
index 0b6227706b35..c15e18c47a0e 100644
--- a/Documentation/ABI/testing/sysfs-uevent
+++ b/Documentation/ABI/testing/sysfs-uevent
@@ -8,7 +8,7 @@ Description:
 
                 Recognized extended format is::
 
-			ACTION [UUID [KEY=VALUE ...]
+			ACTION [UUID [KEY=VALUE ...]]
 
                 The ACTION is compulsory - it is the name of the uevent
                 action (``add``, ``change``, ``remove``). There is no change
-- 
2.54.0

