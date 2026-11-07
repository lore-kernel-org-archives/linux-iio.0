Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062133;
	b=oJcWrwvbGB2ZUwKv3a4RDkj56I0ywsaVk0W4ulipXktoxAsfp++ess0P88blY5aaUUxk
	 rN04rPcRXKWfhDg9OQ5mY0DCV0RVhKBbD4k334eA+lF1v0ZTz1NQjduHp2YEnOK4sSbLu
	 BR+GV3QJDdziBpUQurnNSi96pckNOol4whRS28eDQGtEhVrCxGXCYlTy1g7cv+t7yY16I
	 bt0bN+zVRkSrWy/rSn0Mr7562/uhwizRyMBRXfcPZdda2rmVkVdpDylR5HAxRQAJLacEV
	 r+M7XArbl8RXzFOcsbzYdQEf7ZkcRcmsytm+xyTsWZnj2+q2kw4ki8nuK2b6ZKT7ACA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=om0lfBri/dXE7qTmJH3bJ/Ln1rG6l10M7qtS9OoQ7+Q=;
	b=UhBfGx9DGJI1o2rlUFXss3bN9dxepcEDGgrkL8+R9qhrKyeHrER8tZzli8BBLBvkVSa7
	 3JSwrcgHQoLWc8PapYg94BUZIoc5GkzJccEZX04aTVMSjgSMh2bU/Vgjr6XV6yV+fc9Pi
	 h/Qgbkl8kRf4mH0ZHorRpOGXxoFbVW6QlUm3mw5J7h8SSmauvMNCGDJt/OGznQD4o62QZ
	 hy3DdlJysMPv4JjyQILMjBDkvrX9nqQtSxiwee1BkFq/l1hssNFrikI22/AyKTMLwsyHc
	 5W3uFN+c7nmWNipBHaibUBWSs7tawVu0EwYLzYAliHVOd1oTPqziSnn6Y54h5LP34Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ziGVGLMN;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7260A6F70
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 14:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E7260A6F70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ziGVGLMN
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a315ed211so611918eec.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 06:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062132; x=1794666932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=om0lfBri/dXE7qTmJH3bJ/Ln1rG6l10M7qtS9OoQ7+Q=;
        b=ziGVGLMNqUXQ8U1VTnRfThG3jVh8zg93kbmZORlw+G00NUSv2Xyn9S6KehkD0MkNf8
         g0DxZTEgo+8pZNX4yv49xVvnm0/ERfrS6fOmz5CrYcpTLDcCE3V+HWbZtzItXWG2YNCo
         l8KairNlDZJ7wUe6LyMgxJuJXRxAd7lhJDrU49ly9tP7uqhAbsIF+gLESXnAad2nR8fy
         LiyPbL3RkoFfX4x3N2CcXX83TP6XvwahBaV5AyHjdaJ97gDoP6r8X3AvqGOa6JoyXBvN
         QhMxhPSGPK0Zla344a+w1/06khlHjhAH8cgYsX9xgaVLPx0Tsgd/NPVXdvyuURQ5cFbP
         sxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062132; x=1794666932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=om0lfBri/dXE7qTmJH3bJ/Ln1rG6l10M7qtS9OoQ7+Q=;
        b=sZaIsWFcvPylCdS8DhZZUeja3FqPEViFxBy0LDL0RAdbsi72hg2QJ43bcs2KFglUBZ
         BhXVh65nnM98sO9G8wzMB7epvAbXV4+jV0EsME3y/L06BkBFNqe4hwsspAP9xrDgGu5K
         Vv9KgYnI0tXYKBzsDIRA0Y9UvF8noA14CdqBwRJYizfiCmYSagICkVMEpbhAltEi6ggR
         cCuG2m2EJzMBJ4hBUceCwQGVrB/tvbCylB+n5rMNTfkocheDdNmlR6ktOWSvtj9wfPIN
         gCfC74lstZOzv/004wDOZ1aGCdwZyURkuBVh3oKekJNXmY6qxudBcCetqk6zYPYAtxcb
         LM3g==
X-Forwarded-Encrypted: i=1; AKwUvBwJDE3wE12FvaeVtUPBmZefTqubIJkIKGCH2uGnfaTZJO6f4WUqntL2/HtGL42qP04deqZ/6WiM9PA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XfGD8nHSpAhacxb3/9xM1utv+0xrUvvQKFlTLrzFYE4Jq9csT
	F90L0x1ABJUYZ91ICJQXb5h+CMNZTmeglFMngky+AG6BTnRmO8IGl4hL868Gd/+g
X-Gm-Gg: AYBFou2Db2WQwergOcXclFN1adXZyohKUslCSeTBxvcXQvpqr4N6Yfr0w/nSCywZ5aq
	o8t9jsV03EPYMo+9uvRQN6TzO3xcH/t81CcW4f2oG//IW09trqWS4XbVQUJRUpzfgWI0M12i7mq
	fHOO/tD1yteVsPg2xWzJ7nMPA6WqKX8Q6MP9DnYIytZnbFAhYxyRGA+bKR7RChnuNp/TiG3eltw
	g8AwAyJZgxm6MuZgoa/wu0HdTJ+Px/IQ5wnrvPRW3SmGX7NCh+vRFXiFIdy6J9Tfyl39MtR1ArP
	du9mGzDG2BM6pvXeA9/TsKGIAe6Qq5m6lnWA7IzKLLptkwA3LG0yCrzxRadvQCUUcAMz9wunBDg
	m8c+i+8BLbm/rHmRQLlUgf3xpASsKt5XUp92lkUt6/mZXfURPb6FZTpmCN1JX3t9bdsrVedPa48
	9Qg1cCMJow+UzCCGxqldNkZ+YLYlKusKrxZ9t+XiZ94bkFj/gabjVx470Agbe5LyyKhkNYNm0Fb
	RsDtzpymUeUe3ypQFybq5zG2ZNNvn8nszkbVGeP5uieKVYQ5UBXJv9APfoLqyLcQCQM0IhoBmd8
	VEBSa2ulswSYSLRirUHbpltCOps/DSwbMrVSjUEC6i5BcslZQG95QyRNoodwIXUaOIXbiBT2rTA
	xeVenPXOlztSSzsVau5ktjgvRRrVTlcC7wdTduulUxwR1uBdmooXVVKvF6O0mDPZTAXRA8JJsfQ
	xppxBWNj9hzDD/Gw4VHkpwytlFMt/F8+3ipc5r8WgIww==
X-Received: by 2002:a05:7300:ce88:b0:36c:a351:fb31 with SMTP id 5a478bee46e88-370f6115d60mr3052748eec.7.1794062132061;
        Sat, 07 Nov 2026 06:35:32 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faac86a96sm16732990eec.29.2026.11.07.06.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:35:31 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: proximity: sx9310: fix semtech,proxraw-strength = <0>
Date: Sat,  7 Nov 2026 20:05:20 +0530
Message-ID: <20261107143523.465188-1-kapoorarnav43@gmail.com>
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

The binding allows semtech,proxraw-strength values of 0, 2, 4 and 8,
where 0 turns the PROXRAW filter off and the others select a strength of
1 - 1/N, i.e. register codes 1 to 3.

sx9310_get_default_reg() converts the property with ilog2(raw). For 0,
ilog2() returns -1, which FIELD_PREP() masks to 3 in the 2-bit RAWFILT
field. A board that asks for the filter to be off therefore gets the
strongest filter, the same as semtech,proxraw-strength = <8>.

Keep 0 as register code 0.

Fixes: 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
No in-tree DT uses semtech,proxraw-strength = <0> (sc7180-trogdor-lazor
uses 8), so this only affects out-of-tree boards. I checked the
mapping with a userspace copy of the ilog2()/FIELD_PREP() conversion:
0 and 8 both give RAWFILT = 3 before this patch, 0 gives 0 after it.

Compile-tested only (W=1); I don't have SX9310 hardware.

 drivers/iio/proximity/sx9310.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 2585b9c6fb69..a39277237d39 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -855,7 +855,8 @@ sx9310_get_default_reg(struct device *dev, int idx,
 		if (ret) {
 			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
 					reg_def->def);
-		} else {
+		} else if (raw) {
+			/* 0 means off; 2, 4 and 8 are codes 1 to 3. */
 			raw = ilog2(raw);
 		}
 

base-commit: 340d44bdf9db0f095f99845b5ad8628781d79b6f
-- 
2.53.0

