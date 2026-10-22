Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670045;
	b=lBLStGZe6vHkYG0GlPTAcOopYgBWpOQni0Vq9N+ncSYJfuRYWsh81gPxG6FuoflS1SGy
	 r4nCmTuu0ktdDS31PkJiOmw4KqpHJDk9e1+YSqpMQmH/pttdJm0HKs3OwumKjqqgp/a8E
	 mmfxFhE2c6vfo4AMW1l7/G0bYTIE/hYaZ3CRZCTpHwCeGFXf3foSwRuj4wvwZq8WFrJbs
	 DJjW32pac+T5kV9hBfC65/AjsWeLgCWzMUP2zpzY2pqnsuQv7hKbQaGMHU+AWvUF6etz1
	 gEVTm867Nv0DMw+A0nWYbpJkPK2OUjRWkto6paH05MgrihupT/hVpAfI0/IKoZDebcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=B+tKf5vPrDaOI5M5gTd4aFyXjI3r/OLdMYL4js+XQMM=;
	b=TYg5MUSc0fhBY1nOdrFG/JITRCA/IPiPJTw26Ze1MpRhjlfSygiCQszWnJQ919v8ehhl
	 rZKF2GmVVnFnHJw/AwecV0rmynPxonKaR9S64uAccpEz4bk6ksUX5CtH9lfepBNGcmQbu
	 Ak6C2vRvN1x7yRnR9tnc9XN3dwlq5prfGUWcGbcWIETRdnqwrVQEX3xMBQhyD4FFCGvxb
	 wqkJ5BQz5GA98tUlUFPtCCYs8VWsC4gA1r+udiMxmjgWBlYwbFKfRQUDgNG1zyJbwEPX/
	 DqCs9amAj1MJBqPtstj1ciKdRVxfXrGEyAvXqGHzV4XRVM6Y7+wWSXGww3sNaC1I4CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ilUWSbLg;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CB606A32E
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 11:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 730CB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ilUWSbLg
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1729520f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670044; x=1793274844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+tKf5vPrDaOI5M5gTd4aFyXjI3r/OLdMYL4js+XQMM=;
        b=ilUWSbLgURqsOyt2clQVainVmFtrQ8HtFTdtTVroPdpRj30kZDdBkaiS/Fd7VGuJI/
         d+Wo6Lyj7R4UqE6yFB39N4O2aptevAYfLKlxY3LlfRo6WvTu/TytMVDoGxCIZdrVAoGW
         jJCDCHeK2DSMawNPERdtKdFtksRH7rLW/7wj50rZbjSecarlQCzBEBamWRZesrZASEJN
         7rgPp9idzGgFASZZ0Ns26sL7m05fDk7T5bj3VPu7t/3FKvUNAmx3JupsNQEu8fUkaYaa
         0M7tZ23rFHZwk64wynaAjGfc22iu5uwM3PCx0ueYKWP0cRt4cN0bsvab63A0PMBL9Zny
         LXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670044; x=1793274844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+tKf5vPrDaOI5M5gTd4aFyXjI3r/OLdMYL4js+XQMM=;
        b=S+N4RL87HYQyB3iiVWu2DAc1y8rKTV001YDwLLm4OuQn7Bij5eBb4nQvnZocL6YjYi
         hij0TUq5gaMQTI0Fey1akKNMEsQXPLVdT+WeeHWL+XLb8/GL+j/cA04UQoFalmMjmOBh
         VSXlFbLo7jX1C/CXNaAhpMcq9H/A4bnV8lMreU4cwG0gM51J8aJZFiBsu5ZjGgXR4xop
         lTCafWQ/EPWfF/fFVv3BRCJfBcXz/ciPNqNmQ2g8KrbQGKkjA6p7h74iYWDNNKs9aeYk
         h1ZeBiBr2sgElist3FEK+8Ur+yeJUwSkmj82KnAlu27VL4bT4GTHodxoOWg1+JTRqCY4
         47EA==
X-Gm-Message-State: AFq9FYLeXv0CAxGJFTSsm1YshtSNBmMVL9aw3ZpKp+FYCT5OTwlkS8/J
	ylqIUlOYUZ9IHJB4hGZipJixJNsxOu2RAB0ebAgkVD466MHNwrTdPqyh4d0auhWywqE=
X-Gm-Gg: AYBFou1gPCQKgmraVrGwd+JIxKU/kXJKNVt9VKQShh/4cYFP6Lo/yrj3Dj+C3K19IC6
	bU+NxfLkz4yxWbnR6i8sEqlEKzr/ghr/Tmw3FyEeEUjeB1nryrq1LC0IFknv7Dk/vDvQ/brzhCL
	HqDpUuI6Y+lFutopZB/WRA8u1HpHjZz9CrNA0dYnrRVAXI1KreUoNS4O+CjCzvamLp5IRE8jOGj
	vNgnw0N1RCxSQJSLzNFAPBTv7EKf3H4/OTvTru95ASWFGvmu9v4eHWYg8+AmW74QxEwOUqT0pqA
	2Gtd8wVvWdS74Oo4GvijSAIcgNwL12LJYChyAMxrQX0W2mmaE3HMcFZGce+Cgmj6Lba48KFT+Bm
	PAgbQO0peSq5eaJ+MlWLbB4N7kGxOnqUraZTQ9NOgluVBhEurf3l01lhDHj+su0l+gfQwW+rQVi
	Omnxr/6/dHTHcBHvsPkClOMW+BN17baFNEMyhj8cxxhoyog+rkJfnoXt9317nZTAnJicMuFu3g1
	O9wZKSyb/+uaIDwssNdxmy6XT5c4RQhOYVogmtOScoOECWM8V8qRWTqtZiF9rDzGDLZVo1Yu1T7
	VQO4x+95aw==
X-Received: by 2002:a5d:5f42:0:b0:48d:f996:1814 with SMTP id ffacd0b85a97d-48e264fb916mr10239786f8f.57.1792670043786;
        Thu, 22 Oct 2026 04:54:03 -0700 (PDT)
Received: from localhost (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0b1sm12242746f8f.9.2026.10.22.04.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:54:03 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Date: Thu, 22 Oct 2026 13:53:59 +0200
Subject: [PATCH v3 3/4] iio: light: tsl2591: report saturation
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
Message-Id: <20261022-first-patch-v3-3-b792e89a429a@mycroftmind.com>
References: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
In-Reply-To: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Remes <jan.remes@mycroftmind.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0

From: Jan Remes <jan.remes@mycroftmind.com>

When the TSL2591 sensor is saturated, it reports its maximum value
(specific one for 100ms integration time, UINT16_MAX otherwise).

When either raw channel becomes saturated, return -EOVERFLOW (like
as73211 and si1133 do) instead of calculating an invalid number when
reading 'in_illuminance_input'. Keep existing behavior on raw channels.

Note: Datasheet versions differ in the saturation number for 100ms. Old
2013 datasheet lists it as 37888, newer versions say 36863. Use the new
value although the hardware can report up to 37888.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 8cfce720efb9..e3092ae77a11 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -139,7 +139,9 @@
 
 /* TSL2591 maximum values */
 #define TSL2591_MAX_ALS_INT_TIME_MS    600
+/* Maximal values per datasheet [v3-00] 2023-Feb-08 */
 #define TSL2591_ALS_MAX_VALUE	       (BIT(16) - 1)
+#define TSL2591_ALS_MAX_VALUE_100MS    36863
 
 /*
  * LUX calculations;
@@ -379,7 +381,7 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 	struct i2c_client *client = chip->client;
 	u8 als_data[TSL2591_NUM_DATA_REGISTERS];
 	int int_time_fval, gain_multi;
-	u16 als_ch0, als_ch1;
+	u16 als_ch0, als_ch1, als_max;
 	u64 lux;
 	u32 rem;
 	int ret;
@@ -417,6 +419,14 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 			return gain_multi;
 		}
 
+		/* Check for overflow; special case for 100ms integration time */
+		als_max = TSL2591_ALS_MAX_VALUE;
+		if (settings->als_int_time == TSL2591_CTRL_ALS_INTEGRATION_100MS)
+			als_max = TSL2591_ALS_MAX_VALUE_100MS;
+
+		if (als_ch0 >= als_max || als_ch1 >= als_max)
+			return -EOVERFLOW;
+
 		/* No visible light, this also catches C0DATA == 0 */
 		if (als_ch0 <= als_ch1) {
 			*val = 0;

-- 
2.53.0

