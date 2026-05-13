Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BF1D5ABA
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632543; cv=none; b=FO+Ar3BX7ZQGV1wm9ZS0MLcZe1+f1Ei6DIKyYtHfYIP7MhB24SFy0Wvs8FzlikiZe/dQZ6j4n7Yd9yCI2LNojH6fFexP3B1BBpKUlZrJS+6PkxJZnyO0tJKh8xlhcI6rWRaHjK6rRnvdLfJmoWW+aMvCWyUtH+lZOGInDih+uM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632543; c=relaxed/simple;
	bh=D2S769BEZJaWQITgEvZjnNgRTdfshYJY3a/nB/JW4ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abjCGUoS0vDWsUuXrUKKnFHSioELvDxCqov7QMgYrYLAKLqW/AqoWne9OehTEaZj5volF+8HjOrFN4TZuj6IXtDKgt9pH0iJU1HVsDeQ8eMcx2vezvs++WqI7OjJg97bbc9dxXRryrTokY2rRnNRirxAu9Fkx5C+ROhT4TXfZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ILzlIloB; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ILzlIloB"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-132c338a537so2340780c88.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 17:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778632541; x=1779237341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc2UE2akxQAzjNr5wziIui7yUcuJEuqdgN0QuQVwvGI=;
        b=ILzlIloBEo9jCbGq0vZAmMp7yDQrDgeWZaYg0dUA9JxAwq2mpxS1jlgo0DmMynKNKn
         nSgcQnbggROvUV/QGEWcogBVXGngXj6mC8aW75C2NLYacmGeBIBeMKeR/x3GKW5MTWbt
         n7dKnJ5QfNPN+TZwO/wX8QELQZIhoam5r2Eh/WrbhgVA+WHIfZwdNaSFkpGDBRt8pfbY
         PoI++AQ3enw8yu/QK4MQjxPSfSsyZB00vTjiklnd91BqkEePjCqxtUkSqGfQkF9iQyYp
         oJVXz0sCzqmzfeGeGShos6IF0PO18PFxbxOgO1WQUoEWp/C5nL6wzHUSwuAlrc08LSRI
         vHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778632541; x=1779237341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jc2UE2akxQAzjNr5wziIui7yUcuJEuqdgN0QuQVwvGI=;
        b=Z/jC5j3KJcAtxQdb9erJAzUO9Nlk8sdLnvuazbpPcrstKa0MeD1JcJgwme5f9qUKq/
         K6gu29iH7OWEHDypkzPfx1F8AzjYXWJVMkl4mLir7FyQuy9MqxnjdBqUGWXq4i+fJY8a
         kboGNkbMlhh/EMt8kVrEGXbpp5xEvEjluiJRQuiuSCzsBxQh667Fi/BwQ9KqGhqXkGvh
         ytD4sTvcBW/CXPxoU+WR88izzje77M2cmpkPPtjvtqkNgqQbI4ulP2KGGaxowb9/u/I3
         1QdUJf6RWuYwZWT+dYH+dEN5M+qhfXlc1U9BE2K7OnKD59bwPhY875mgDT/igCP9UF0T
         WgKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8z7/f7jUrCENjjgalFwmWWgJXxl6MpV9RX935tDkIlwQ+CnpsUoB+vwDfyL4y/l1ojhZ6+w4UVt00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ4YirgOyheTeb9W7ujuAt8raOLw93WEMt2aO63QYZdL1nTgNc
	hoT2ImkuxXeV3xGtM+nIHjmW/TT+6ST+mK0SnAdYI6vl4gD0wVJuf7k2Q5d6pczH1AU=
X-Gm-Gg: Acq92OEUObI6shixm/MyxhKPK2r/jjjVjZs56z0Rm1MUERnQAxiyVUB+oLZvbI40WIf
	UBmg6yqGFzkuEb9T0kHKfiHAAHwLJn9iCaCEgPjY8m4pVgrLPyDw81GRUCeA/2ydyVqr7UJ9kFs
	bLMAeZxZBsdIo3ICv4cLCk95iIOxphrKWQlBokKHi8jI/dwY1rR9/kRXNTE7uyBuSeL9WL3rY2N
	iexq7jMMpYGTqBdYYd725dlpPmNeOEsKEHo8a+qALxrCL8H/nEV/Grj9TPeOGILICZuzLiSBLsH
	RXiCMVr7zAlrQt/HJL+7ccEeEMlH/+CrqsIZpOAFJDuQxeyC5HDbmpPRi4+RHVQMzZyX5TfnWhv
	V2TeqQvgkc3D1wtAyrabLt3E1F/PajHdyMmWclqE4x3mazvEwEqAEe+U1jjDe/AO2uSgrShiIV+
	mNPDie+R+bH3ORB9fqKBdy1YeueTXekBw929xrQdFvSB7itAdO32fVNFMqZJCNQis4W7EkZ5p/F
	OuwQQ8qAeCZHhbVbj3cyPCBQVrfYBh7YiQIsuOHSquKhChy
X-Received: by 2002:a05:7300:7241:b0:2ee:7b2e:8a3e with SMTP id 5a478bee46e88-2ff936311e3mr3474885eec.1.1778632541186;
        Tue, 12 May 2026 17:35:41 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm18471381eec.0.2026.05.12.17.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 17:35:40 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: anand.ashok.dumbre@xilinx.com,
	andy@kernel.org,
	conall.ogriofa@amd.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	manish.narani@xilinx.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	salih.erim@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
	Jonathan.Cameron@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 3/3] iio: adc: xilinx-ams: refactor alarm mapping to table-driven approach
Date: Tue, 12 May 2026 21:31:52 -0300
Message-ID: <20260513003503.339418-4-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513003503.339418-1-guilherme.bozi@usp.br>
References: <20260513003503.339418-1-guilherme.bozi@usp.br>
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
 drivers/iio/adc/xilinx-ams.c | 161 +++++++++++++----------------------
 1 file changed, 58 insertions(+), 103 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 70a1f97f6dad..d38c4401dfce 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -102,6 +102,7 @@
 #define AMS_PS_SEQ_MASK			GENMASK(21, 0)
 #define AMS_PL_SEQ_MASK			GENMASK_ULL(59, 22)
 
+#define AMS_ALARM_NONE			0x000 /* not a real offset */
 #define AMS_ALARM_TEMP			0x140
 #define AMS_ALARM_SUPPLY1		0x144
 #define AMS_ALARM_SUPPLY2		0x148
@@ -763,9 +764,49 @@ static int ams_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+struct ams_alarm_map {
+	enum ams_ps_pl_seq scan_index;
+	unsigned int base_offset;
+};
+
+/*
+ * Array index matches enum ams_alarm_bit.
+ * Entries with base_offset == AMS_ALARM_NONE are unused/invalid
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
+	[AMS_ALARM_BIT_RESERVED] = { 0, AMS_ALARM_NONE },
+	[AMS_ALARM_BIT_SUPPLY7] = { AMS_SEQ_SUPPLY7, AMS_ALARM_SUPPLY7 },
+	[AMS_ALARM_BIT_SUPPLY8] = { AMS_SEQ_SUPPLY8, AMS_ALARM_SUPPLY8 },
+	[AMS_ALARM_BIT_SUPPLY9] = { AMS_SEQ_SUPPLY9, AMS_ALARM_SUPPLY9 },
+	[AMS_ALARM_BIT_SUPPLY10] = { AMS_SEQ_SUPPLY10, AMS_ALARM_SUPPLY10 },
+	[AMS_ALARM_BIT_VCCAMS] = { AMS_SEQ_VCCAMS, AMS_ALARM_VCCAMS },
+	[AMS_ALARM_BIT_TEMP_REMOTE] = { AMS_SEQ_TEMP_REMOTE, AMS_ALARM_TEMP_REMOTE },
+};
+
+static int ams_scan_index_to_event(int scan_index)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(alarm_map); i++) {
+		if (alarm_map[i].base_offset == AMS_ALARM_NONE)
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
@@ -779,36 +820,11 @@ static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
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
+	if (event < 0 || alarm_map[event].base_offset == AMS_ALARM_NONE)
 		return 0;
-	}
+
+	return alarm_map[event].base_offset + offset;
 }
 
 static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
@@ -821,49 +837,13 @@ static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
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
+	if (event >= ARRAY_SIZE(alarm_map))
+		return NULL;
+
+	if (alarm_map[event].base_offset == AMS_ALARM_NONE)
+		return NULL;
+
+	scan_index += alarm_map[event].scan_index;
 
 	for (i = 0; i < dev->num_channels; i++)
 		if (dev->channels[i].scan_index == scan_index)
@@ -877,43 +857,18 @@ static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
 
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

