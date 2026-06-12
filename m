Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B8368D73;
	Fri, 12 Jun 2026 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266464; cv=none; b=eys4c8HwUh+X80s1ORoeQYI1GGeNIzIzImpCBJY0HG9/HUlOCTELKEeJCFQB9j45RPWy9af27tpG4MXqv0VfXuR2P4Get1Y3XQve3tdzdTrWtdKGjyOK/L4GpOeW8Q55JzM5ndisVlVb0urPdjYMOWpSFdkr1IKuz8GEZgULwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266464; c=relaxed/simple;
	bh=BeLoqxplsYfnqzROUrqBeM/UfO1xQHJ9t6fT3Ddyqr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDOHOaWY/lltVMfM0e+Hdb1CZLWi0n77wxIMNY8R+JoerxD3SH0lpEp3WJnk/XCPk0pWAQAZ+ptCOI2tl7xaIiVlRHm88GNjvL15Zo+iOFePZpUD/9EAW1TNCzhSxUDl01broiA7uw0VMZzLEpQZA/P3HMxBbZNIiAAwnn7uRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jCyfjaAC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pUVGiGlY; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jCyfjaAC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pUVGiGlY"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gcJN73cypz9v6Q;
	Fri, 12 Jun 2026 14:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781266455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eAuFDylynCVuPLU8pH5uAuFU4op1bo1aLROAwqFT1GQ=;
	b=jCyfjaACX7DKY3e++fPsXlQHmVq2DJfv2lLTuCIfnHajGE/c3JOKtCiWsTU2+5782WpY0P
	3uw3F0GbTEJsM01ZKzffKLdfJqToTCOij2qpFK17/7xuTTBQZu9pyJF1bddBVEURkr5aD/
	n9vaqIleO/DYHHz2ZXGvO+MWxaDu0W3aQjQyMDCtLBeCJoyru6OIfJDR8EWCGQ7MbtmAL0
	STuY9UMv5KhdDaXmqUr+6+hQnuso4l3ldKdaKwocJNq+WmuPyshNRmUXC6A0WCJFoBCH62
	KqQ/0rjzPuO7LbqulKDuPF4OW2B5JrgLhpP/zt5WnGoYYup6roJ+CNTcBbNW0A==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781266453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eAuFDylynCVuPLU8pH5uAuFU4op1bo1aLROAwqFT1GQ=;
	b=pUVGiGlYHztlLSMstu0U9/VQfSvD7EHgmF8AYY9L6Y8nKI0MBDMMlyEnmhFkiKU+YEp01H
	7i5e/dFNK+4SW6+38xlnDn6wc32t/FJqEcT1JtmycJNJbzlmDlHB/nMsUFMgmpg7EQS0wM
	Nl1jVN6U5ajxuodOm55j9QBh5iUoP7UaHzKCMS25cRL/6GT4P50mFe9WKYArXq+IdTkOFt
	9w+jb+WhbV4NZwuj1w+efeebGdPiHwY+Eu1TfA61WYZcXw7erzmzOjtW87yLt9tWTwWmXH
	MbRqKTgukrpYirbA2PO3CCatEFMtu/96cTo0CEvY3GSz9oPGlbGnOKlRf3ROjg==
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH] Documentation: ABI: testing: iio: minor cleanup
Date: Fri, 12 Jun 2026 14:13:43 +0200
Message-ID: <20260612121342.181358-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f5152074ee9ace75ea1
X-MBO-RS-META: phgstqdyxckes8ij5qkdmhmh5inza55j

Add parenthesis and dashes.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
 Documentation/ABI/testing/sysfs-bus-iio            | 10 +++++-----
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d8d6d85235b0..4ea5598e7cd2 100644
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
@@ -1528,9 +1528,9 @@ Description:
 		the unused bits, so to get a clean value the bits value must be
 		used to mask the buffer output value appropriately. The storagebits
 		value also specifies the data alignment. So s48/64>>2 will be a
-		signed 48 bit integer stored in a 64 bit location aligned to a 64
-		bit boundary. To obtain the clean value, shift right 2 and apply a
-		mask to zero the top 16 bits of the result.
+		signed 48-bit integer stored in a 64-bit location aligned to a
+		64-bit boundary. To obtain the clean value, shift right 2 and apply
+		a mask to zero the top 16 bits of the result.
 		For other storage combinations this attribute will be extended
 		appropriately.
 
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
index 28be1cabf112..d44eb5f8728b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -16,7 +16,7 @@ Description:
 		In bridge applications, such as strain gauges and load cells,
 		the bridge itself consumes the majority of the current in the
 		system. To minimize the current consumption of the system,
-		the bridge can be disconnected (when it is not being used
+		the bridge can be disconnected (when it is not being used)
 		using the bridge_switch_en attribute.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw
-- 
2.54.0

