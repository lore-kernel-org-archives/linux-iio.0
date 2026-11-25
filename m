Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638156;
	b=P90m/LhRIRBr5amvkjl8WhzZEMID7MUdnEI23bx3SwNBN+CsZb80AMCr6fpzPt4QtbL6
	 xM2jsXGf/Q2WbIvnem3u382/mdAXovICv8QuCdwa2KqSfO1h7AyeTEKiUdgL0aDzv2MrB
	 7ygqd7SmlO4sPCnHnd1Cp2EQC98Jt5QIi3TlPwtHwzezPvV5KwOaaHwydPJogiJ/Q+BRm
	 KXGcTAeSxL9PRNaVcpcIH2LNOf3NhXzLT3DV/+3OZxRjR2JDJC6PISbJPmJ85TDOcoJwS
	 9m6o+sBZhAJ/G4tV8wTO1zInb5PsNEJp7qD8Z8ElwApunPFTeceXEVtRI9eWOzPR3iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638156;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=ipPQ25tiHkUanST2JzunfB//g2qXyMbHVdRkURBDgGY=;
	b=2+BEVFvQ5vVNZhEKhJLQVnhy9oei6IZbdvdnQEJInQxAQ5+IKXcTPgT91+cKpDB7etgX
	 GITcrqBQJs9bfL/5CuF+spUAvhiHNwtB6DHTEOFvjA1YJPXg7h5CMwsEJ93izFeh9u+aj
	 W/odgqdNoqrZOakHz6ujmKYS5xmyDr9EiemMzC5qYt1nsKRgZZJqjpbLHNDPlbkrPFjx9
	 5JBeC0jW7CSSzpr2KlKEFkKrN4FX0KP+JEOysZEXPwP6n7z6Lb93swex2uSLOnmHXP62U
	 vPAs+r2dTle3/v7QK3d7R4vgg1lPGB8ngG28HTtrKRdr1bxCkHNUoDzsHZYGD81mtrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C9606A33C
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 20:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 880C9606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4d5e645d1so40890037b3.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 12:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638156; x=1796242956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ipPQ25tiHkUanST2JzunfB//g2qXyMbHVdRkURBDgGY=;
        b=fSplBs898OtQpw8yemgLWZV4lbXiPxuQGvoN/0aWx6cHNQEzevexEry27TxIPhDMk2
         kjKV7iOj1T8v0n7xFAPdvfo7VAAf/0ubdRWQWibYn8DwldmeLNPHNsFDVRZLmv/Epvzr
         LUEF/8V0njiDylcydFZZzKz0feMKa6tnd5Bce0SynjpNM/JjgKNjyAiCA8RNpJfZ+AgQ
         XW17V022pLn2wabYZ8PjAe/sqj4g/DqXaDw4JJBA+Fi8aV3R1i4BXafvEy++k/R79QPB
         2nVwwKkcN9MpYmVqpIq2BRHzYX/iyMHccmpxvkzKApPr6uFk+KceyO3wyaVibs9IS+9h
         pH+w==
X-Gm-Message-State: APuU4Z+mSDC7iZMbawCa46s+AXoztfhcZGxlUIUzsKHvMF/RaO8EdQAV
	+Uplvw54Qj/Qa2xI3vdhQe3ktz/RbfTGCMaj7VEYTLnm46Ki7W3Ht6Ry
X-Gm-Gg: AZFdTZcTyGNpQpN+maVYeSggpo3/dkAZx1s1NEELV8WKwlEtwGIQJuok1hKOqQ2iAm2
	/T8L0dPn/RAe/KpzpgFcSiqRwxQQD2LT/Ykp0aTKW4pVmg3qBp8RP5CniNiTY6NNTT1NJPaMoFg
	mobBOz7neFqgZtunJBjTvk9zLpUGYs+SC1me8w2HsKa7j+p/W97pljsIviw+DmfIEMNU2nDmwlW
	SNa4+pf5sYPbPfHVof/KahvTeETRNt0pph5m05dhE+4akUqPvC8mV9XFSZChU6mL6496PaOV6mc
	2E7hIE2ppQ71v8D24ywk+JNP3piuyfUDqpAzFQcv75TcIpATie/nUF34nP0aa90xBeq3XSY7yA2
	0Lw0Or+yDaTZEPZXH0zElAIlkI1Xp+6p1a7AgLmUHlhWN/StWTywQqeCj9PnX09HjH0WSgDSB65
	cqmjm7eQtNxSwLi1KAZDC7KOiQHE3K1KejZayI7DZZEQor1EqAmlmB/+fP9nGzEeet5zfnUt/Ia
	aDL1HjYwVmTs3/54FRLmY4TP5/PcNgbUFBMcTrJnS3yZOzx33f1n130aMEYvcwe3x6VrhNrYLlq
	Szf8o7yiQyx0uhqHCSRlR+WKJBB2fGh8SvLX0S0+zxUjubBXfcZphU04tUyNOAsJEPdEwnmnuLc
	BzAu+q1gbvy3L/yMGyZ97R1Ih/TQB+bwCcDzy+xnmgy20TvygrTd9SmLDYgvOEbEjE0BY/2k/gP
	R3OzdhyhhWMfUpjd3nlTRwBA74
X-Received: by 2002:a05:690c:338e:b0:8b4:cd96:e2f0 with SMTP id 00721157ae682-8b52031b32dmr59760337b3.6.1795638155700;
        Wed, 25 Nov 2026 12:22:35 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201bb6c7sm77074377b3.6.2026.11.25.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:22:35 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 25 Nov 2026 15:22:29 -0500
Subject: [PATCH v2 2/6] iio: potentiometer: mcp4018: Report the available
 wiper positions
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-iio-ad5246-v2-2-8feeb630f0b6@telaak.dev>
References: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
In-Reply-To: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

Implement read_avail for the raw value, as ds1803, mcp4531, tpl0102 and
x9250 already do. User space then sees out_resistance0_raw_available,
and an in-kernel consumer can learn the wiper range with
iio_read_max_channel_raw() instead of hardcoding it.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/iio/potentiometer/mcp4018.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index b10b4b920dc0..d6387645853d 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -12,6 +12,8 @@
  * mcp4019	1	128		5, 10, 50, 100
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
@@ -49,9 +51,12 @@ static const struct iio_chan_spec mcp4018_channel = {
 	.output = 1,
 	.channel = 0,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 };
 
+static const int mcp4018_wiper_avail[] = { 0, 1, MCP4018_WIPER_MAX };
+
 static int mcp4018_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -93,9 +98,26 @@ static int mcp4018_write_raw(struct iio_dev *indio_dev,
 	return i2c_smbus_write_byte(data->client, val);
 }
 
+static int mcp4018_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*vals = mcp4018_wiper_avail;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(mcp4018_wiper_avail);
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info mcp4018_info = {
 	.read_raw = mcp4018_read_raw,
 	.write_raw = mcp4018_write_raw,
+	.read_avail = mcp4018_read_avail,
 };
 
 #define MCP4018_ID_TABLE(_name, cfg) {				\

-- 
Git-155)

