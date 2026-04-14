Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54963C2770
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159058; cv=none; b=GSD0cWSjvLG4AIJn19YmKqcYdLE6fa9r1hlVrLHfY/HrRvRCpnOn2KqQ62GT3rY5nPiI6+oEgVbaRNwyE2m/SPxu9F1DGdM9lBCoowjZw55MnG+KiwC8Xp2dUCVkhgKGI/XK93clxX4YlQpeNT39A9vjLhjPLRvjAqlB2EgmIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159058; c=relaxed/simple;
	bh=BA7Y5tKCVZ4zvqm4akemcm6zExdZBDVPqGIUotLV504=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIVo1kvFXQNPixwWP/lfpn6jOTqpWS9Snfe0a/YbKXwQPioo2/G/MW/ikQAOcV0235eNj2LAiUIBfl9xuv3KZy51Z55RmwC85a6K0aXtlXidqb1PTPIfYmTsXOXjCPP9Ng1JWf0HgbchrbDGed/H/Csge+5yATwoXYiPM/Uh7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=C5eGfM48; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="C5eGfM48"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c156c4a9efso7348903eec.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776159056; x=1776763856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaFMZ05oqoCy3XWg3+SgdosFrFG8OPbj74rwzw8gq5o=;
        b=C5eGfM48FlnOZad5MANf2KeqdTbMh13IPRXWo2F79HMV9KEzg2YmbNYZoylSDvscnJ
         YuzMjpDg24tzLmaVXQ2x8ve3vcAxpVsmqphxppqt+lu088FmYWZQc9xfzf6zPSmi9uXn
         3ymRf8yBsA9ftepTdzRZyDijhNjKlTzpykGFXk6CV92Gzwr/Gs1At0+5YaeY80v+3lzV
         X1SXf7q+xmt5DJwgIWxcPiktTOuF4TRTWda8gxddksp8r23i7QmpSINFHXI0jVDy0Am0
         KF/lQSnVlq+iO9Kyc9yMy+J4DErMSL2g9nA16wp2SeE0SuhXvbn7cbN+u5GHYn/GNGKB
         bJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159056; x=1776763856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaFMZ05oqoCy3XWg3+SgdosFrFG8OPbj74rwzw8gq5o=;
        b=ZuziZ+fPIGoIpGSckqCnSY1K0V8d8PyxuTtdyZLk8diYPrK2IdYgjlzT8lX5j61rJg
         lZI/ESpUVa+i1LOy+N31KYj+sNZTGQBoJqqDLY7gWfC454Bf5nUTxMgCoIuXO48feQMk
         wMNzthfylw6+M2XQ2bqOF7guc0Py2eC3vP33dZ5GD59uWHiLCJ1WXMozkYY36ih0JzM5
         vSzGVPor4/FROf0s/jHlq7s6pklYQXaRNhdrh0+iZVNcpUMacODdXZnytPKbRSlMKlNy
         pCM74MlbUnaVDu60PiLJ/kQvMlGYYOK1yOqwr25iI/5grB9bpUY2PR9v/C6kgzZMYjEj
         epdA==
X-Forwarded-Encrypted: i=1; AFNElJ8hoURw6yI1JTWDrE9iNlZERe3geNDfvvbosJtZOkCxPYxLSKQhUWx4vPeO3pgc5rmVdIpbDyVrZX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsw7RPYlTrQMsQ+uYDM4WVeo5XrDh8rAjawoWS7z1uLa2LS5R
	BhvHCfOCXDin7Bh5267SCbpg/J5rMlPXqLdZl2MyYJr5APVMilrG/NrPwGIa4XQGggE=
X-Gm-Gg: AeBDiesXL2K/QQ71TcSDpAIY+7zX92oPj+jlFseTuG47CwZlbAbnPZtL8r1Ix+RB2sq
	yMyOhIuHdRfCoJEfFnndxy6o+k0WBNbj/xHJnz2cj0Ku0cLxJy1AgLgZ/o7AOCjPHEB8SntN7oi
	JGDjQ6uUu4c5LIY1WsOn8T3dwFgNX7RGImfB3hsKoOBfyL8vLv9l0+4EIdc9y9vQ0NstguNQypG
	CI7SxwB4Cri0P+VkZ/eqZkDKS+jyIxdgLtTFPS35hfb1xMAfMav07KLmoajpRp7v33+B/fHOu0n
	tJRxipEaSi0i4k4jS5mahjlcyO3Dr2izFlXIDCA09O9aGXqEyFW0wVjncr0/OJIv2QCs8pegJIK
	rVdgvyAEL/5eN1TCKQnant9irs9QQBBAWEqllelqF31JrU55C6nl0jeSSiejX6W+bjPaNxUetrw
	DBR4mszrGnhdo0BUBUjBbWl1E1zrqK6DPplsb2/8l4Or+qEz8D5O+4G+3+ZW34gOL2/U6Hg2PSB
	9/WwPzPPEH9TOmYJQtvyzdpM9LG7phiouNgBxBB0as6qv/AtEkuBZwrHWCe
X-Received: by 2002:a05:7300:6d05:b0:2dd:8ac2:9f7a with SMTP id 5a478bee46e88-2dd8ac2d269mr350220eec.11.1776159055830;
        Tue, 14 Apr 2026 02:30:55 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db6ac8sm20327599eec.26.2026.04.14.02.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:30:55 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Subject: [PATCH 3/3] iio: adc: xilinx-ams: refactor alarm mapping to table-driven approach
Date: Tue, 14 Apr 2026 06:29:30 -0300
Message-ID: <20260414093018.7153-4-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414093018.7153-1-guilherme.bozi@usp.br>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace multiple open-coded switch statements that map between
scan_index, alarm bits, and register offsets with a centralized
table-driven approach.

Introduce a struct-based alarm_map to describe the relationship
between scan indices and alarm offsets, and add a helper to
translate scan_index to event IDs. This removes duplicated logic
across ams_get_alarm_offset(), ams_event_to_channel(), and
ams_get_alarm_mask().

The new approach improves maintainability, reduces code size,
and makes it easier to extend or modify alarm mappings in the
future, while preserving existing behavior.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 drivers/iio/adc/xilinx-ams.c | 163 +++++++++++++----------------------
 1 file changed, 60 insertions(+), 103 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 1d84310b61a9..d5ed2e787641 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -102,6 +102,7 @@
 #define AMS_PS_SEQ_MASK			GENMASK(21, 0)
 #define AMS_PL_SEQ_MASK			GENMASK_ULL(59, 22)
 
+#define AMS_ALARM_INVALID		-1
 #define AMS_ALARM_TEMP			0x140
 #define AMS_ALARM_SUPPLY1		0x144
 #define AMS_ALARM_SUPPLY2		0x148
@@ -763,9 +764,51 @@ static int ams_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+struct ams_alarm_map {
+	enum ams_ps_pl_seq scan_index;
+	int base_offset;
+};
+
+/*
+ * Array index matches enum ams_alarm_bit.
+ * Entries with base_offset == AMS_ALARM_INVALID are unused/invalid
+ * (e.g. RESERVED) and must be skipped.
+ */
+static const struct ams_alarm_map alarm_map[] = {
+	[AMS_ALARM_BIT_TEMP] = { AMS_SEQ_TEMP, AMS_ALARM_TEMP },
+	[AMS_ALARM_BIT_SUPPLY1] = { AMS_SEQ_SUPPLY1, AMS_ALARM_SUPPLY1 },
+	[AMS_ALARM_BIT_SUPPLY2] = { AMS_SEQ_SUPPLY2, AMS_ALARM_SUPPLY2 },
+	[AMS_ALARM_BIT_SUPPLY3] = { AMS_SEQ_SUPPLY3, AMS_ALARM_SUPPLY3 },
+	[AMS_ALARM_BIT_SUPPLY4] = { AMS_SEQ_SUPPLY4, AMS_ALARM_SUPPLY4 },
+	[AMS_ALARM_BIT_SUPPLY5] = { AMS_SEQ_SUPPLY5, AMS_ALARM_SUPPLY5 },
+	[AMS_ALARM_BIT_SUPPLY6] = { AMS_SEQ_SUPPLY6, AMS_ALARM_SUPPLY6 },
+	[AMS_ALARM_BIT_RESERVED] = { 0, AMS_ALARM_INVALID },
+	[AMS_ALARM_BIT_SUPPLY7] = { AMS_SEQ_SUPPLY7, AMS_ALARM_SUPPLY7 },
+	[AMS_ALARM_BIT_SUPPLY8] = { AMS_SEQ_SUPPLY8, AMS_ALARM_SUPPLY8 },
+	[AMS_ALARM_BIT_SUPPLY9] = { AMS_SEQ_SUPPLY9, AMS_ALARM_SUPPLY9 },
+	[AMS_ALARM_BIT_SUPPLY10] = { AMS_SEQ_SUPPLY10, AMS_ALARM_SUPPLY10 },
+	[AMS_ALARM_BIT_VCCAMS] = { AMS_SEQ_VCCAMS, AMS_ALARM_VCCAMS },
+	[AMS_ALARM_BIT_TEMP_REMOTE] = { AMS_SEQ_TEMP_REMOTE, AMS_ALARM_TEMP_REMOTE }
+};
+
+static int ams_scan_index_to_event(int scan_index)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(alarm_map); i++) {
+		if (alarm_map[i].base_offset == AMS_ALARM_INVALID)
+			continue;
+
+		if (alarm_map[i].scan_index == scan_index)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
 {
-	int offset;
+	int offset, event;
 
 	if (scan_index >= AMS_PS_SEQ_MAX)
 		scan_index -= AMS_PS_SEQ_MAX;
@@ -779,36 +822,11 @@ static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
 		offset = 0;
 	}
 
-	switch (scan_index) {
-	case AMS_SEQ_TEMP:
-		return AMS_ALARM_TEMP + offset;
-	case AMS_SEQ_SUPPLY1:
-		return AMS_ALARM_SUPPLY1 + offset;
-	case AMS_SEQ_SUPPLY2:
-		return AMS_ALARM_SUPPLY2 + offset;
-	case AMS_SEQ_SUPPLY3:
-		return AMS_ALARM_SUPPLY3 + offset;
-	case AMS_SEQ_SUPPLY4:
-		return AMS_ALARM_SUPPLY4 + offset;
-	case AMS_SEQ_SUPPLY5:
-		return AMS_ALARM_SUPPLY5 + offset;
-	case AMS_SEQ_SUPPLY6:
-		return AMS_ALARM_SUPPLY6 + offset;
-	case AMS_SEQ_SUPPLY7:
-		return AMS_ALARM_SUPPLY7 + offset;
-	case AMS_SEQ_SUPPLY8:
-		return AMS_ALARM_SUPPLY8 + offset;
-	case AMS_SEQ_SUPPLY9:
-		return AMS_ALARM_SUPPLY9 + offset;
-	case AMS_SEQ_SUPPLY10:
-		return AMS_ALARM_SUPPLY10 + offset;
-	case AMS_SEQ_VCCAMS:
-		return AMS_ALARM_VCCAMS + offset;
-	case AMS_SEQ_TEMP_REMOTE:
-		return AMS_ALARM_TEMP_REMOTE + offset;
-	default:
+	event = ams_scan_index_to_event(scan_index);
+	if (event < 0 || alarm_map[event].base_offset == AMS_ALARM_INVALID)
 		return 0;
-	}
+
+	return alarm_map[event].base_offset + offset;
 }
 
 static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
@@ -821,49 +839,13 @@ static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
 		scan_index = AMS_PS_SEQ_MAX;
 	}
 
-	switch (event) {
-	case AMS_ALARM_BIT_TEMP:
-		scan_index += AMS_SEQ_TEMP;
-		break;
-	case AMS_ALARM_BIT_SUPPLY1:
-		scan_index += AMS_SEQ_SUPPLY1;
-		break;
-	case AMS_ALARM_BIT_SUPPLY2:
-		scan_index += AMS_SEQ_SUPPLY2;
-		break;
-	case AMS_ALARM_BIT_SUPPLY3:
-		scan_index += AMS_SEQ_SUPPLY3;
-		break;
-	case AMS_ALARM_BIT_SUPPLY4:
-		scan_index += AMS_SEQ_SUPPLY4;
-		break;
-	case AMS_ALARM_BIT_SUPPLY5:
-		scan_index += AMS_SEQ_SUPPLY5;
-		break;
-	case AMS_ALARM_BIT_SUPPLY6:
-		scan_index += AMS_SEQ_SUPPLY6;
-		break;
-	case AMS_ALARM_BIT_SUPPLY7:
-		scan_index += AMS_SEQ_SUPPLY7;
-		break;
-	case AMS_ALARM_BIT_SUPPLY8:
-		scan_index += AMS_SEQ_SUPPLY8;
-		break;
-	case AMS_ALARM_BIT_SUPPLY9:
-		scan_index += AMS_SEQ_SUPPLY9;
-		break;
-	case AMS_ALARM_BIT_SUPPLY10:
-		scan_index += AMS_SEQ_SUPPLY10;
-		break;
-	case AMS_ALARM_BIT_VCCAMS:
-		scan_index += AMS_SEQ_VCCAMS;
-		break;
-	case AMS_ALARM_BIT_TEMP_REMOTE:
-		scan_index += AMS_SEQ_TEMP_REMOTE;
-		break;
-	default:
-		break;
-	}
+	if (event < 0 || event >= ARRAY_SIZE(alarm_map))
+		return NULL;
+
+	if (alarm_map[event].base_offset == AMS_ALARM_INVALID)
+		return NULL;
+
+	scan_index += alarm_map[event].scan_index;
 
 	for (i = 0; i < dev->num_channels; i++)
 		if (dev->channels[i].scan_index == scan_index)
@@ -877,43 +859,18 @@ static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
 
 static int ams_get_alarm_mask(int scan_index)
 {
-	int bit = 0;
+	int bit = 0, event;
 
 	if (scan_index >= AMS_PS_SEQ_MAX) {
 		bit = AMS_PL_ALARM_START;
 		scan_index -= AMS_PS_SEQ_MAX;
 	}
 
-	switch (scan_index) {
-	case AMS_SEQ_TEMP:
-		return BIT(AMS_ALARM_BIT_TEMP + bit);
-	case AMS_SEQ_SUPPLY1:
-		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
-	case AMS_SEQ_SUPPLY2:
-		return BIT(AMS_ALARM_BIT_SUPPLY2 + bit);
-	case AMS_SEQ_SUPPLY3:
-		return BIT(AMS_ALARM_BIT_SUPPLY3 + bit);
-	case AMS_SEQ_SUPPLY4:
-		return BIT(AMS_ALARM_BIT_SUPPLY4 + bit);
-	case AMS_SEQ_SUPPLY5:
-		return BIT(AMS_ALARM_BIT_SUPPLY5 + bit);
-	case AMS_SEQ_SUPPLY6:
-		return BIT(AMS_ALARM_BIT_SUPPLY6 + bit);
-	case AMS_SEQ_SUPPLY7:
-		return BIT(AMS_ALARM_BIT_SUPPLY7 + bit);
-	case AMS_SEQ_SUPPLY8:
-		return BIT(AMS_ALARM_BIT_SUPPLY8 + bit);
-	case AMS_SEQ_SUPPLY9:
-		return BIT(AMS_ALARM_BIT_SUPPLY9 + bit);
-	case AMS_SEQ_SUPPLY10:
-		return BIT(AMS_ALARM_BIT_SUPPLY10 + bit);
-	case AMS_SEQ_VCCAMS:
-		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
-	case AMS_SEQ_TEMP_REMOTE:
-		return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
-	default:
+	event = ams_scan_index_to_event(scan_index);
+	if (event < 0)
 		return 0;
-	}
+
+	return BIT(event + bit);
 }
 
 static int ams_read_event_config(struct iio_dev *indio_dev,
-- 
2.47.3

