Received: from mail.imp.bg.ac.rs (mail.imp.bg.ac.rs [147.91.50.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3453D9DDE;
	Wed, 18 Mar 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.91.50.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842751; cv=none; b=IibQxkr/IYI8vka/dtVLESBY8mcyASS4kQtFmIR6iFqtQ5xAPHYVao7LdGvPOvDZzldIwWXedKUA1kvpiK8NdvFSSWQnA3OfYuSeXGthUyCZPp43XaU67SPVPttPu8c7qdGxBgxoJLqWvpyAybOIv1v4XI5WxldtaVn3uvZRhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842751; c=relaxed/simple;
	bh=cQAGmSlQR1Chl+o3FaD7TGV4TUDdNjzJtS3cvC363xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIwU+hH+2cs8f+gTqSSngo3HX1eHfYjEn06iKK4icS8sKLQailHfmGVk9O9gRPQuKGz1RqqknHPjT2mYdhw3xuHxcLOvA6YGKJhCFlXdH8gmD9uP43OpjXt/2QAdVjMUQocjgJyJr3hFMXwvHF6+0BUPOsFgcakZ+IbK5rA6a9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs; spf=pass smtp.mailfrom=pupin.rs; dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b=bmVFfKW9; arc=none smtp.client-ip=147.91.50.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pupin.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b="bmVFfKW9"
Received: from localhost (localhost [127.0.0.1])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id EBC4B140C2733;
	Wed, 18 Mar 2026 14:57:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pupin.rs; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=dkim20260301; t=1773842267; bh=cQAGmSlQR1C
	hl+o3FaD7TGV4TUDdNjzJtS3cvC363xo=; b=bmVFfKW91y+odTZ+PDXX2VCz2Wg
	zWM+OqSqXnuK++kTt7Xp32D249L6xWDGOvCJWl4ydIPVpsCJogCXodMGfVOiWRWc
	7A7JGpZ80+SvxbBaR73qlka+Mn/RWc7+mtRuTLNWd7FkR7L35XWbZMabO3k5j1RL
	yLZue9wIgrXnlbeg=
X-Virus-Scanned: amavis at imp.bg.ac.rs
Received: from mail.imp.bg.ac.rs ([127.0.0.1])
 by localhost (mail.imp.bg.ac.rs [127.0.0.1]) (amavis, port 10024) with LMTP
 id 5keImWW3cX5P; Wed, 18 Mar 2026 14:57:47 +0100 (CET)
X-Comment: SPF check N/A for local connections - client-ip=147.91.52.78; helo=phyvm-virtualbox; envelope-from=david.marinovic@pupin.rs; receiver=jic23@kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.imp.bg.ac.rs BF70A140C271C
Received: from phyvm-VirtualBox (unknown [147.91.52.78])
	by mail.imp.bg.ac.rs (Postfix) with ESMTPS id BF70A140C271C;
	Wed, 18 Mar 2026 14:57:47 +0100 (CET)
From: =?UTF-8?q?David=20Marinovi=C4=87?= <david.marinovic@pupin.rs>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Marinovic <david.marinovic@pupin.rs>
Subject: [PATCH 2/3] dt-bindings: iio: dac: ltc2632: add LTC2654 compatible strings
Date: Wed, 18 Mar 2026 14:57:31 +0100
Message-ID: <20260318135736.91564-3-david.marinovic@pupin.rs>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260318135736.91564-1-david.marinovic@pupin.rs>
References: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
 <20260318135736.91564-1-david.marinovic@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Marinovic <david.marinovic@pupin.rs>

The LTC2654 is a quad-channel, 16-/12-bit DAC with internal
reference voltage and SPI interface, sharing the same 24-bit
SPI protocol as the LTC2632/2634/2636 family.

Add compatible strings for the following variants:
- lltc,ltc2654-l16: 16-bit, 2.5V internal reference
- lltc,ltc2654-l12: 12-bit, 2.5V internal reference
- lltc,ltc2654-h16: 16-bit, 4.096V internal reference
- lltc,ltc2654-h12: 12-bit, 4.096V internal reference

Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
---
 .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
index 733edc7d6d17..b22df24dee07 100644
--- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
@@ -4,14 +4,16 @@
 $id: http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
+title: Linear Technology LTC263x and LTC2654 Rail-to-Rail DAC
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
 
 description: |
-  Bindings for the Linear Technology LTC2632/2634/2636 DAC
-  Datasheet can be found here: https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
+  Bindings for the Linear Technology LTC2632/2634/2636/2654 DAC
+  Datasheet can be found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/2654f.pdf
 
 properties:
   compatible:
@@ -34,6 +36,10 @@ properties:
       - lltc,ltc2636-h12
       - lltc,ltc2636-h10
       - lltc,ltc2636-h8
+      - lltc,ltc2654-l16
+      - lltc,ltc2654-l12
+      - lltc,ltc2654-h16
+      - lltc,ltc2654-h12
 
   reg:
     maxItems: 1
-- 
2.50.1

