Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243142;
	b=y0yclzmxEs8dj1CCzDV4lkY/t7SnXgWH4DQk8Mht2UINs6AN8hKYqF2R/Ev3rejHeIXf
	 IWDB+v3C//txBUn2bud/t+i0XrfpI76FNjpFS9Ve/8JLPJclmhe3y5DIwvLkH5Trbi1ot
	 YYb/N3EDhRJZLqreT//bnOMbSdPFPzZqZEZiCuVlMF5zGh4mrg6kXVcnjTdU6uaAIFPsP
	 P3KUk1YG7f7GHZ33649wH6teq1HeIAby2Y6Mp1miTqf9ZEFtUOkbM+GjOchSGqLbjqq8p
	 1OCjQdnG1ZvlPxZjh0jym2IJBqkv5tJy9qz77Cng4wpMr28KdXy3sagW3axpPZvCHYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ySvK1Qww1m+6lBZm5Vkp2gRHrdkHvyjpb9ej1XMBokk=;
	b=blywrAuwv8no0LGytsJcdJmcdzZMLHNQSULz3fOl0KpTN9RHo+/xagLveJ2ofmKT2ln+
	 v75EmQrj5oMe3NGXsK3qKqfR0T9TTjIeeT48q4CgRSW56HduaN32g2a8zJVLARFVcIbUA
	 MiPc7ERKNxkrVtage5osXpG+QauWgeTTtKHARkMOu+UF2XPVqxGvOLEQfYLBqnRaJO+6p
	 MVOwcnBbxo6YREgaHoZTbfDmkOL4yFORJP8cH1GWbckVkug7SAGV7QgEccATP90VuRGLT
	 tjtOSq4jQGlSfsSeeNdgoIkWqGHD+BPk1GV0AX2yVkMvpfXdhvypAluHaN/kReH8Sew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ieth6GAC;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E399606A33B
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E399606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ieth6GAC
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so412165c88.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243141; x=1794847941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ySvK1Qww1m+6lBZm5Vkp2gRHrdkHvyjpb9ej1XMBokk=;
        b=ieth6GACgAFU7Z++EedxO+r8dfIKama+UF4MIItnmJTMx2iBemeTr2SBX05lH/Vzl0
         EyXkX0FcgtltyDll3mo+iLBLoU83SmQ5azPBhnX0jOD8lsfk2G36X88BHu2L2p9OZlbj
         DIOkRKMvPt++9eApOA1l5sA3LfeWB6ph2NAT+NHlQht1rHt3hDZw88GaJOGJTTdeb9hv
         eFcVV0ApzhmLT/2BvKiaKw7FYhki7cA+V4yNsyS9iyzKJTarB3t3pkqyeoSN8quC352O
         dOotmaPPpPQgqko2W/X9DUa48dWrerHMbfZNxkOPvGEIQzZNFslYDDGKDhWoLGp20wy8
         d4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243141; x=1794847941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ySvK1Qww1m+6lBZm5Vkp2gRHrdkHvyjpb9ej1XMBokk=;
        b=icXppXByrRVw4UGVam0SDVuRcRP3QL7N1O7l8rdRqAYTlS0xxa4/s9tInxE8nC6RDq
         wVnV5+XY+PttZIEuQRZyGEIFWpj72gi6PKP04MqreVyIqot8eVYG9O5PXwp86xtYvors
         deP9IByv1KsDPBMEMEKw36Wop8b7euXw1gU07ArQ8PE/8nHxnvR/iTnrH2aUEmkOdbb/
         OWA/oS+PCAMzqQijwlf6ipu+BATZLhKerA4ihqR/suFbwtWCZdeiPGLThzAgevszQKJ7
         GSxMtBGRP7MlN1JEaidpVG02uNglDXv6E0l1gYEVlndqlw7pzh28HkA71cmZRnd3PuuD
         dc1g==
X-Forwarded-Encrypted: i=1; AL+hErE2SOSTLUf+YZstWMUsPevHyPE2rz6oFBF2HktWDBzMez58GI5SQ+j+sdyfJfC2jhgPAf6aa2nFnE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9I9E+hyGXOJrABQAVFroxCZumbVxaOKcK0XuVeV7kN54AqO8NP
	9JFmUsur9hEHq+M/eRlp3Zm3Z3PxGXCBvbjfN6XQuOwvncVOIVOvWR8N
X-Gm-Gg: AYBFou0dlBQ9ze0FfE1PeQpRQxD6koJWNH5AeDIH90LOLOSrdwkXPrvEJ0J9U923uZA
	HW2TywVXTXB54mtCFGzLPvoCYD1yXvndBmLNJZpAOPV1kGLeq9GQVo/Kv4kBDvBYLLiqkaAFP+g
	u6IC7PuOYlym2YOjTZISjM1+V+8Ej8JRx3dWKXeNiZMEe3N/S5KKgZ05mRQHFHIs7NIIVCyVvOi
	r4ZKPt+Z+PdSKcQw2w0YtckXaWDSSHLIxlCGPwvuisMkaZUL3a+TMvtU6iz1PpOVe9I5ZZ1I97J
	puGuDi8OXrZLNBblVGY1pGalVHBvASunc79elHlp5oByrGS+FvXDoCveGQXUKr2IsHWNvYbxNLm
	TiQWk1Y9N9/JUP7oJjwe5beg0xYlUIRTD4H/ggrCBl3yVKREyUT9dm0b6urOzqMHqI0quZXS1ZQ
	sFJ7agYJMV5JxkY7wEIVzuYHmHhJ1tLMUOSN7tFvDljrKBub11c4S71Z9v28cU/CDeuGIFvVimf
	/thShrDAdEoYbwcG+OUcANlWfXxgHIS/yZ+27measUyEP1hx2F82Um75RVAzERyD8JzjxCoCpBX
	jDk6Wm8vRP8HYfkKtOCuM+LWwq/T/hnXvLO1kHesDC0viNk+YXFJbSKe4IsVgAvlONburUPP2BW
	RQdmdCt8C1T1DOyvq60P0QJrlndfI6bVvAKE9HgCamJqz2YHS2t/0cupxYV0U92vBz1w6qFMxNH
	J24l3ZST8L5Hj9bh1sXSRdIscMIzwCFnHSrPZffhiWMlc=
X-Received: by 2002:a05:701a:ca05:b0:143:5266:48ee with SMTP id a92af1059eb24-1b3b6025e09mr15837c88.42.1794243141357;
        Mon, 09 Nov 2026 08:52:21 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890584sm307041c88.3.2026.11.09.08.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:52:20 -0800 (PST)
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
Subject: [PATCH v2 2/2] iio: proximity: sx9360: reject out-of-range hardware gain values
Date: Mon,  9 Nov 2026 22:21:53 +0530
Message-ID: <20261109165200.305266-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109165200.305266-1-kapoorarnav43@gmail.com>
References: <20261109165200.305266-1-kapoorarnav43@gmail.com>
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

sx9360_write_gain() passes the value from userspace to ilog2() and then
FIELD_PREP() into the 3-bit PROX_CTRL0 gain field without checking it,
so some values silently program a gain unrelated to the one requested,
and the write still reports success:

  - 16 to 255 write gain codes 4 to 7, which the driver does not
    advertise, and the next read reports gains of 16 to 128;
  - 256 and larger wrap around in the field, e.g. 256 sets a gain of 1;
  - 0 and negative values write code 7 (read back as 128), because
    ilog2(0) is -1 and a negative int becomes a large unsigned value.

Return -EINVAL for values <= 0 and for values above the gain of 8 code.
FIELD_FIT() is not enough here, as the field also holds codes 4 to 7,
which the driver doesn't support. Values between the supported gains
of 1, 2, 4 and 8 are still rounded down, as before.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2a9b37df8f62..ede20dfcdd80 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -68,6 +68,7 @@
 #define SX9360_REG_PROX_CTRL0_PHM	0x41
 #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
 #define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9360_REG_PROX_CTRL0_GAIN_8		0x3
 #define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9360_REG_PROX_CTRL1		0x42
@@ -625,7 +626,13 @@ static int sx9360_write_gain(struct sx_common_data *data,
 {
 	unsigned int gain, reg;
 
+	if (val <= 0)
+		return -EINVAL;
+
 	gain = ilog2(val);
+	if (gain > SX9360_REG_PROX_CTRL0_GAIN_8)
+		return -EINVAL;
+
 	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
 	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);
 
-- 
2.53.0

