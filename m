Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9C23E34C
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608398; cv=none; b=BlFBX4yBr3dsHk6k9QJ8YNkEU/47PZ8Fy8RVwfXRrkpmraiAO/XnhlDQf7sGOQ/vKzvptRQXhsoBldDDhc/K2JMC4QN99Pc8pOpeNTh5DiCkDSrh+YiRW1Jlx0+q7/cIjwlRKRfCIcAkfQ8DtABpbacgQVZ+/UmkB/V8Rz/in5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608398; c=relaxed/simple;
	bh=DNGsEtjd1j4ZuRGsLgacguqxXG3+8LAwUt2gLAMGk9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpwG7kr83taqiKUHmcDlp7Uxifr9i5DUu/nPl4BcKs9ppwcGRQvLoqq0NdSoaI4FIiMzlVvlX4TikJ8alHE69cGcVqPKD8E/IAgsvcitXXrAQQ4IGJZ0AsnXkpcF7E5l129540go4zwvFlQJzRVFWsT3ZDGu3yCX7wp9AUCkPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8AiLcuo; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8AiLcuo"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-124a2dc92dbso231688c88.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 19:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770608398; x=1771213198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsSlquKVu8f3wrVapETiykNB45yqXfDUE6W57yKCxqc=;
        b=A8AiLcuopCS/h1ZmmEy+LoiF99rOl2HMldMwd1kc1C4O3+lmi6VHwdA61Ud5Ln66Bp
         yIcO/JyrI0En/hAH39E/5eyeU/eB6gcyG1Vy6QiU7Pj11gZsXtax29hCAKhYu8mFlfCD
         NcOfr9OmgMotRDFNh/qvfeSdxAq9OT2dD0lMv2x0U5qoSV2AgnDBHXFZ1rpr4tro9dkG
         ReW16YtBrrMmOpTjvYeSxfEJ9TCCsV501gG6UuHR6opxDD9d/2VBOy7zrA2pOjFxWvWv
         4WDhVb/dO2foCscCpL4uzEj+kdbtK20bU5IXFk6cKHgTleEVL8jz1nfhetMgfHK1UiUm
         Qauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608398; x=1771213198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UsSlquKVu8f3wrVapETiykNB45yqXfDUE6W57yKCxqc=;
        b=cfo/j75A3XdmBJJAynNEpDVa/AViHfyai0fBSBajdC+604J/fqHhOZ4CV8yBeEUOgp
         a2FfWfleICtljvqgWKn90zzPMfffTcmg/r3o93B0OXyDLzLIqKdhAQBhITdjwvW/voYw
         fD+xXfabjSGiaUBecXVyuPtkkFehuPNDRCIvBzA1MF1n1tmoQmss/24MS1MydD51hM7W
         7n9anmz2IajbIzN7ZunbLRrYc8uo1MZouOsk3WSZi2gpC0Ech9Ke/+CF8ssvTbvTs0up
         TDbNW93NnQ98L4M0SqD1zy3ZmyMt+1FtNFXIVkicmeM0FD/7nqn2uTs+w/ususgwea6R
         T3fQ==
X-Gm-Message-State: AOJu0YyITOkX/J/O99B5oSdJYQLukz039M6BQWHCxzRPO32dJr0aY84Q
	CdEowqbgjQKn4f88KvUlsA91aXkI1Lzd0H+PBIqBTrpJ6yjvn41Ltk2c
X-Gm-Gg: AZuq6aLwrFuTEs/8wRyWkhb1e3xINwUbJxszckqtGrN3ln2N9OYCw6QPObw3jR82l6I
	PscFuKnvgpybh8xjjf6HvGnJGDhazK3hY9h/jXL8t0uYUONUHBTChRA25CCHd/myW53H/fpXJqb
	A5eFav2MntCuxAd2MaCBsxXrMNmVMGBj/zY0dDpd7/HX7Vxad9H0UsNPkTSsOyMFW5A13P8fxnp
	mLYbMQsQa4M/Bvj6RtaMP52wFEW0aA8jpgFoPI+7iQMT2nHUBp4yqN7JngK864y/IxFLYFpNfYy
	5jz32hwkloXPu7YpRFQW2GlMg1dYKTw5dP8kxH/H95L4VHq8KtWmenl92jIjpU1u0QYo9wBcGaG
	bhhcWAVXvyNwTUNYQJGCv2EJv3fWTOJqMHqMfrpP+J2jsK1aFOpJ2GCAMg+v+HivA2tYI63AoYE
	oXo+41Q6SC1P4=
X-Received: by 2002:a05:7022:e1f:b0:122:8d:39d8 with SMTP id a92af1059eb24-12704020e78mr2435410c88.6.1770608397670;
        Sun, 08 Feb 2026 19:39:57 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af5ca2sm7682073eec.8.2026.02.08.19.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:39:57 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Mon, 09 Feb 2026 11:37:03 +0800
Subject: [PATCH 2/5] iio: proximity: hx9023s: Protect against division by
 zero in set_samp_freq
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-upstream-20260219-v1-2-2b4d74e309d1@gmail.com>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
In-Reply-To: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=DNGsEtjd1j4ZuRGsLgacguqxXG3+8LAwUt2gLAMGk9c=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJmdYT/Sjb12bWr+PTs7xfTOlAXBawLOTt9VdZRFXmkbc
 9+89xted5SyMAhyMMiKKbKcef2GNV/14Z7g364ZMHNYmUCGMHBxCsBERN8wMvRqz2Nl3XXIwfDF
 /9fzg7SflZoJ/f6k63PY2/7py//n5dwZGd7nWTe2Xr9z6nd9z5zO6g3+0lonvKesu7Vv+Xw1/kr
 3jwsB
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Avoid division by zero when sampling frequency is unspecified by
falling back to a default 100ms sampling period.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index ad839db6b326..eb4902d18d74 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -719,7 +719,11 @@ static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
 	struct device *dev = regmap_get_device(data->regmap);
 	unsigned int i, period_ms;
 
-	period_ms = div_u64(NANO, (val * MEGA + val2));
+	if (!val && !val2)
+		/* Fallback to a safe default sampling period */
+		period_ms = 100;
+	else
+		period_ms = div_u64(NANO, (val * MEGA + val2));
 
 	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
 		if (period_ms == hx9023s_samp_freq_table[i])

-- 
2.43.0

