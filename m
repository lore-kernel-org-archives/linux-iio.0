Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415259;
	b=Nynjc30d3P7atqcihUymeCB/Zf4IjBkDJV642tlyCOHqIhSgVpWTnqyiFdsM6YttnKgf
	 uekmynygAKks01z/POl2EpwKbjIFL2f1wShX/B21aSXZhOGsRygxUVBuahvSYPMsrVXjE
	 2OVSZXlZtBuDT10/HOQq4gJ4TFCurFFmBPkwplsyIfqWVe1yPURSFkv7dBSnosbbyNRc5
	 mOODNHRMS8NrYlw43xHbbZDfsVVoRqBLtEjSqE7UUmPkB1UktIkA53TA9bRNMeBhzL90l
	 Y+8CqY8rj5ZHEIcZHrsJ7nYrqTk5bFBljRpj3zVrOq1i6vi3oKszT8MybPvPCPtZ1Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hU66dGPCrYHzM6DvcebvStQj80xp1zTkZ01vqrLFXZA=;
	b=ShXm249y4PznPXqcwBOme5eHmaYnS52DYHZzfRL8ZZpEwnkGdlnd6wBsUEjnqfKs4BEb
	 VmG0TcOIasMPEuvGmrdd6muKMbVZQXb1idFwvsQGghBHFO6K68ksJttYCXzIRzg2TwLRn
	 AQUY0aorz6hspnfMZvYleedNj6GRHYcUwd2UqEfp0bWXsMuKTdCLiWLhweaQyfrBH+Zo4
	 OwUlsdi/wA5sTDGg/BSwUZV/5j29pM5JX65fz8FyWClmxI/B4lQ5lbFmQjalvkQAr3/LV
	 O+WWgw/WabO9h0s6qCKN4wf4aTvAMF1QRmqglJpdaTe9WRTjgsqPGNeAOohP07eVxNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CEzVdSd0;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D4606A88E
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 16:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F15D4606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CEzVdSd0
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-372bdb942dbso4316777eec.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 08:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415258; x=1795020058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hU66dGPCrYHzM6DvcebvStQj80xp1zTkZ01vqrLFXZA=;
        b=CEzVdSd0515WKw9RZY3/MOQyKCnhatou4SezjMjesDl52x0FbFPjHww9GSOxmLjAvM
         XzJq458IAFRscZCx+jC9XTRyXKc9xB8WlkCI4MZ4eVYLR/6T/DGwet/vcESteVpNX7qk
         yLEURgq486WKKY5jQE1Qz6fOd6GGiwjimeEobcDkvxc9EbYNdOBSZF9yRzZabOKafVgD
         scNCfmhOn9J5hKrEyX8MHDpQrpWZo7z9eiLGzW4QEwueKThii0EFNDHK1LaQk/O5NmvO
         kCHth3mYGRETvvc0TRqjPeZTI1CrCHg7OE2A1pzxBBo3YfG0xznsqx5NJXFMPC7UJhJo
         Atfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415258; x=1795020058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hU66dGPCrYHzM6DvcebvStQj80xp1zTkZ01vqrLFXZA=;
        b=XvZAVci+u3UqPg1+WFxIcN3UpKy7dGT/f/8CGPqrqTQYbJuZmlJElsqOMHJBYa5rZz
         6mxM+sYVy2AtjIVlxQIpGDr8thKNhYHTUy/pK58m62Bb/a7yilHtZT1W8d2zVnG2GIl8
         X28YXJ5S4lxRWBYlu1v0vgMjzJOQHi+BcEBXvFiqhrmYSiAQ9iEAjI/+UV2II8tOQttz
         xKcApNJPOMzXc739W9rcPJlPVVJ4FTB3x2eUxdShE4OzgyVnC8zGVcZITeh7zhLOjVJT
         JNQeypiaRkvhWSRujui0tpPGoeSBwBkF/8XaqLkuLb7bR+uJjMetFuZJ2mnBv8HtEhsY
         a8ug==
X-Forwarded-Encrypted: i=1; AL+hErFMy9rDZsK0TX96uv04jJdSh9o26nfSAGNHNsz5RrY6n39QGKlBRhNNptxOzSFYFj0rJQQMx/9/lXs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NuGCwFyFe7KnZmxrerrkScPpri5BUtfUvNDsLvxiJLG7Qt0dC
	NkoUoWTHa0BpsXCV37m/XsU2DEhxcoUtnwxrjRItK9Ld5Dtj2sGfO/BD
X-Gm-Gg: AYBFou3TvNENdU/cFaGqQmzSwyftJYnV0jD3G8Ic+NMPZnuoPAIznYLZwLAoIRKcG5P
	w8Br7PznNjaIBTuEKcuN1RaAl3vSYwzblMDRl4R0j2o+hi299hAHMFuZ5puDmfePI+oUO2gbtfx
	1JYQT5vG1ENghqnlEnZEX2rDkZpVsx/Q84UXpVqES+LLKW9D64pwPg6taUYRAWnRn0VE60E+HFX
	TnkQiI8Mt0htfr4Vw9xhrfNp4oHieiUifkY8sx3bgqlayPx/RMyGYPI6tUtCK4KHwxM0cTEOJly
	7Xc+ik4SWvbfuWPqHHhqymIDbsM/5fL/KjxtNCkE10juBezYzTFsuxdrBjbCwCE3aXCLXCawH71
	Ahzfaw2+DQe9Sr+kckqYc3ATR1PFursAVtk2UP/+wPzWIOTaMlhRuCZBBX6TPKescqatiYUG82Q
	SL13wNNkVsme5kmrLFJOIV98kHPT5WKqIifgsbOAZzoSZy90M7e0GZuZqe3f1/jE5c500/89MM+
	x5f0qpN/1en1iCXFrkB005p9GiGhI6pJC4hoh5lzkJ34rYB3pv/xirrkPK5Vn4mf4hK0mZTBN8z
	fCVmw1puvuzKBiTQ/c9UiwXv5D222EUn8KFQeWbCi8QaCh4Dvp9vN5XnrIKQaiLAbd5G8Zup0Mc
	+vWs2Un5yKEWwc5o4YI3PnyQxkgLOUvykgLAyNPLjtoOyBdp19BwINOV4RMeIxrjkdZfcXNgssf
	1ltMVwU5kAE6XhSpg35W2+pgSmGDA/DL1AQWZeOW2KmA==
X-Received: by 2002:a05:693c:8004:b0:36c:dbac:705d with SMTP id 5a478bee46e88-3768617335dmr3164693eec.15.1794415258050;
        Wed, 11 Nov 2026 08:40:58 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e76e2sm19158013eec.24.2026.11.11.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:40:57 -0800 (PST)
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
Subject: [PATCH v3 1/2] iio: proximity: sx9310: reject out-of-range hardware gain values
Date: Wed, 11 Nov 2026 22:10:36 +0530
Message-ID: <20261111164041.341776-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164041.341776-1-kapoorarnav43@gmail.com>
References: <20261111164041.341776-1-kapoorarnav43@gmail.com>
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

sx9310_write_gain() passes the value from userspace to ilog2() and then
FIELD_PREP() into a 2-bit gain field without checking it, so some
values silently program a gain unrelated to the one requested, and the
write still reports success:

  - 16 and larger wrap around in the 2-bit field, e.g. 16 sets a gain
    of 1 and 32 a gain of 2;
  - 0 and negative values set the maximum gain of 8, because ilog2(0)
    is -1 and a negative int becomes a large unsigned value.

Return -ERANGE for values <= 0 and for values whose ilog2() does not
fit in the gain field. Values between the supported gains of 1, 2, 4
and 8 are still rounded down, as before, and the gain read back
reflects what was applied.

Fixes: 227c83faa2f8 ("iio: sx9310: Support hardware gain factor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9310.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 2585b9c6fb69..f0280b79b56f 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -665,16 +665,23 @@ static int sx9310_write_gain(struct sx_common_data *data,
 {
 	unsigned int gain, mask;
 
+	if (val <= 0)
+		return -ERANGE;
+
 	gain = ilog2(val);
 
 	switch (chan->channel) {
 	case 0:
 	case 3:
+		if (!FIELD_FIT(SX9310_REG_PROX_CTRL3_GAIN0_MASK, gain))
+			return -ERANGE;
 		mask = SX9310_REG_PROX_CTRL3_GAIN0_MASK;
 		gain = FIELD_PREP(SX9310_REG_PROX_CTRL3_GAIN0_MASK, gain);
 		break;
 	case 1:
 	case 2:
+		if (!FIELD_FIT(SX9310_REG_PROX_CTRL3_GAIN12_MASK, gain))
+			return -ERANGE;
 		mask = SX9310_REG_PROX_CTRL3_GAIN12_MASK;
 		gain = FIELD_PREP(SX9310_REG_PROX_CTRL3_GAIN12_MASK, gain);
 		break;
-- 
2.53.0

