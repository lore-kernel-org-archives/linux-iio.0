Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AC427A14
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105852; cv=none; b=PRLvVT6pEOj9lAzO3uUiFf9UVpj2TFecWz/aAEscO9GMvSK9LU56PPvwSQSXtLTUKp58Y4FaZJhL0xTZ6uZ5dHms6LtLSyZScpFNsipKDHY+sBmvqh5hLQE9e14l3O7uxXlYbdwAuVQx1I+ZkueCqesKb8ww1PVfDKvk/GQ/6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105852; c=relaxed/simple;
	bh=2aqPuaQcktVNpiy3IjCIIGpbqwcR7J6YOFv4WcRn2yI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NwP2rMdf/8F5QWYMukPPUYPzYmLnjwm7et0hVLwuVUTRMQNYk6RJpi9mcXCfGFQ7I7e/NzlFhLUc87WFE/5+bEamqJh4s5tV6nkSHXwAppXIEE9OYEc3WCIZvCdA/oolRaYTWQyx9+ElRaUnGBQQC5G6eZUKNi2Y/orM25BKVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmZtepuO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmZtepuO"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7477196a91.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105850; x=1781710650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3DYTRaj5o9JX7HjN2WJvEbzJSwnxUVlbxBFf+VFy4A=;
        b=FmZtepuOswrQk37r+sDyaxsMzgCfm3MBK3/LL+G+cEHpKov988MRqs6hEKMyvFt0TD
         0/oI0n3n43+DiJcKTj0cQ/tTNJ3Jh2KmpcOzrOQbJeoVPf2fdr+kBUbL/oN+B1RjvlRS
         bBo/xBnw0CnQNFHjTc/nha0ipCvp1zn50e3kEJxb/B+YqkVBCmQCk9EdDyAxOCN4ZEvF
         xxjAYKbGolVL+8cofTefZfQAClXHHULO0i+GDdMsrHzHiJf9Vq+U16PBePEw1wKHltLv
         5grcpurW+t3SNNaEvOq4i8EIHAwPeWclYmmJ0a6xN2hGXfHZ5UpPt1wIen2A9TK53BQB
         lOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105850; x=1781710650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3DYTRaj5o9JX7HjN2WJvEbzJSwnxUVlbxBFf+VFy4A=;
        b=SP5parq1WW6QtfEuHjh/Er9hvjvfM6619b5VolvPCSM2Duj7zOfXtV1o19X7QzaD9V
         nnSDBjWgappbIBHDSTGJrGbhOpSY0Qd1QDiMcjf4i6/4xJC0fO+du6XHRId5FOHoYCYU
         tsv5BqimQz5Koet7mvF2cjEziOoBzuLTc2ESt4BrwfgjxWk7WztqDY/mkuPf+r3g+/n4
         0UGsR+iuQefuAwMJL64b1vj6RtFkrTt1L3rRI3+fwIh3BMwB/Nsf6QVQm6+G8wjs8k2F
         o//YVfqYc/Ad0kmJDTcdO/d/l5OCGoCvmNgJmAOzlU+nPJeRjcPCAyY216PoCHH4deRg
         YnfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YsfY1GZkEjvmu6gFJDzd5pmabY24a/ypsWgoAL2xCGtjOt4SffHQw4xO/BK5Uj8Zv0dJpQTG3Ts8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPZsZTg9wPx73V5XvehKjGRhqyIgajCbRVYHZECYA4J6YuSGb
	YtnMgEhR/Ttw4amiG9dD9F0XScKaxwpFx3D60o9zIGeRvG4hPcrnDFbO
X-Gm-Gg: Acq92OGVW34VYV2PKsl05w7RRJRqW5uBS/txP+Eu0VQMrXNQqCmtlmU9+4HkES807B/
	i0mrop9aY4SzHrVwGlDVaY1zcbIVrv4yE5GEmwWNUg3NdOM70HBOjz1Y712Ap8rln4Y+DnkZX98
	1nNeqLmUF6F675ubFRwMn7bJwhAXyUkNJuioFQ7NefXssou7ki/4dd+WWjIAfBC0BOGgFVBOClF
	uGaIFxTH9ohALj5H1nllbNqmVdXmIc6cpH0n/CUvuqyi/KBxRZ3CDsIsHnPrAuguZPqxV9D19xq
	Dlbf7tnoOc3svout636l1b+cq564oVx5Y6U8efPHDxTv/ArTkRI2tTSBAlpYBd3KEeEhf6yDnki
	3EYsSUXM2lF57Uz6tx4w2cZv9e8GW3mx9jr3NwY+7ErLHS48+9m1+kT6xy4wdfDo65L6aglOWxh
	WoEDysH3pMVypRuiDin2cBeVYSbkkJlXNm8eu1YSYz0zyngOP1544fLNPNgWc=
X-Received: by 2002:a17:90b:3a46:b0:36d:7a76:827b with SMTP id 98e67ed59e1d1-370f0095b48mr28959386a91.14.1781105849749;
        Wed, 10 Jun 2026 08:37:29 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:29 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:05 +0530
Subject: [PATCH v2 4/7] iio: light: hid-sensor-prox: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-4-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/light/hid-sensor-prox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index edc9274a2c07..9059f00f0ced 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -166,7 +166,7 @@ static const struct iio_info prox_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -183,7 +183,7 @@ static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {

-- 
2.34.1

