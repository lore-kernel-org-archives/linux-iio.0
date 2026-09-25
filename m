Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B174F648C
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371694; cv=none; b=c0SbhKWpcB1odrWD5CHOZ5Ur9ThgF4WRsmZP4oFB4LS1VXHOiA5wMiH81ndvoGbr2EcEc4ekQn03mqkBfjonFOL+qkapS+VuTHzWPXp/vhWH1b+BFFtjBttTdDEKv4K4B4f1/668QxnsMvNq9ToIAJR6XYJte64WGNpezRo6ZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371694; c=relaxed/simple;
	bh=CgeYv9g+tpjuDbqL4O71K+vFEGZzLnqWD/zKWEXcd2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWRE7+q4afZYjHg8yztoq8SZSntk0CrIOMM/IaAdHANtpKBJJ0y/q9iJIbbVvHWmEz0DgK0r3slYvwmvpvwCi/4lR2gbxpLOly2KaGOuKlu/vlOtE938ZxsPhtUq2P25wLJQ+DHbc31tDHa3M8Ih09gAVrDH7dwLQO/qMp/gn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hAH2yiSY; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hAH2yiSY"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae6b200fso954556eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790371692; x=1790976492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X44pU0XgGoR3GRoElvuukGKYjdjpqUUlAP8QVmREOUg=;
        b=hAH2yiSY04MD3GihCL+p8C1H7asuDAp19KPmoy434hVGoWVwNe2h7QThVFk4b0HUbJ
         cOvxxJp5gey9rs6UovsNtMfd9uaGbd/BbSXD3MKsITnokBOHYsnWPB4MyCjpXcR3eHze
         exFSiKNgQZT/OJZJw3y1y6LsKmkddMgbgqeozDJqYautnDO8UhDnGIfBR6ZHSRv+d3In
         f9DuZDVxSJFyLJJxTAFpeh9+I6rUwza7Je+xSWj8xnZd2i4rdJRJbjO2ypYMUAn6GL1y
         s1XL06gaC1SFhBpmzSWRE+mW27nAk/sRcOHJT+DxEHBa0kwZCYA09T+YrOwXlfJOmCrJ
         VQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790371692; x=1790976492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X44pU0XgGoR3GRoElvuukGKYjdjpqUUlAP8QVmREOUg=;
        b=PHrgTei5YI8YEvF5YNwoXFV9mG3JAolrkKpFACEJ4FK85DqUNLstg1uxlnSwHI4h4o
         z7i2dEqzYqpC6INijtgCfJi+mBQD+6ooAtZd88PLx92k9VEgwJVdKnIyWv8A2SQE+uDY
         KcQCM8qK9PZol73babDVP9LBz0Y/SEahGJS2pRTdwmi+Dj9eLOo5xKSKCPdjWv+w/z5S
         0fKNZgn7z/qXthJoqYXd49FzmPuPxBBioZxqLSreqf2wDhsNgP5fwdG/PepgACs9xM+8
         uSuaZgQmyYUKPU5/gunNvSL17Prbzirdj2FBXOpZ4MGZZMoGa/zd8OWApUn2MmaOiWFJ
         KlCA==
X-Forwarded-Encrypted: i=1; AKwUvBzgzWhp6PRUxpBxcGHrMI+1DvxF8/WS7x/qR5uM+gelrN/oF1vA3TLi0NeJvjwuRtiqddzQ9VP81OE=@vger.kernel.org
X-Gm-Message-State: AFuF++kyzshS7KDPKi5dvfZpZqX2TJ+KYrWmoj3wm3kZpkPmIp7fgCXC
	fQ5fRn/uGVPfZWo6Mwut0IxHj9tOVQ1ZsAel09hcmzGbh1eP/bjwWObFeHdqkAMCXN4=
X-Gm-Gg: AYBFou3d+MOiw4qy8tU9tYwGnmwbuhqaCIhoWQ5GxQXUcIL9nqiyUAu/N6t8TuUcgdT
	EVDwhXxDY94LUgWZ8obIuMUPEDUPkH/QYH54t7x7mxYFb+R1UeLqYmEUjghwOOL20Az9vEOPaRd
	Vk2/3UnhORZEDFPsSZhmUSwrEv7OxSuXhuniq0P1ZmGRL9M8bN80T6FDqLJj14hhvQ3BsnqEcGN
	dkEyWlFWJtazGDdjKdmEqZjJUOJX5LKH14ClN2U7f0kgdClaARKGNAKMLPm7OIgTbpiKsEOUGbI
	NJweEu5wl4rHZhxDQWPMC6OzIXwFEE16PtnT7kH/wPVLU5Tlz6Cg4GDxblRuhdL2diEqfO6GMw6
	0lEig9G5X+eLeLbda0rgcpM45t7AemwnkrAqcAurIIScQbhU4TEy5Z/cRh96pfdeD7hS7NgzmV3
	dTT8MUDaSiywO1IVcgsHolEy2iuTcTcKpW3HKuZ7WlcZkrNc3RO6b/BAJhy8uSbateT6nMNX9V5
	3c=
X-Received: by 2002:a05:6820:61b:b0:6b1:858:28a9 with SMTP id 006d021491bc7-6d43e31f964mr6714781eaf.9.1790371691995;
        Fri, 25 Sep 2026 14:28:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a0e:55f3:1b40:7bc6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm3568385a34.26.2026.09.25.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:28:11 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 25 Sep 2026 16:27:44 -0500
Subject: [PATCH 2/2] iio: adc: ti-ads112c14: fix settlingtime creep on
 write back
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-v1-2-1fd53e7242e8@baylibre.com>
References: <20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-v1-0-1fd53e7242e8@baylibre.com>
In-Reply-To: <20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-v1-0-1fd53e7242e8@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2629; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=CgeYv9g+tpjuDbqL4O71K+vFEGZzLnqWD/zKWEXcd2k=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqtudhiVJnBdVdFwGSXPkGTy2hljWwJWQkFyW5Z
 pL4MVrOjLaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarbnYQAKCRDCzCAB/wGP
 wKAkCACcgrgJnfE88uwC6HJ2vsCZJ/pDsNtiaMSm94oHpbS9mEwUJQRQjadILGUzi2nYGMC/Luk
 W/gqTGoAkK3ozSf9nGFxxk1LTz4FRUVrrCKhdZHaPSKJBd+7qlfYq5/f7uq3Q0pnSybIhui4gxB
 wlcwLvAQPh8/8ZMo60zOD/rFkxElxiJ5q1YuAEn0t6dzGQp/b9xjpL/TjBzeszy759XY0udItZ/
 iM4uXgYFEiPdeEqsdTRuh4cFtei0nzJgS9PBb8/htxjnsCB1GVzhicd5U9rPaJSUGozEEFMoQHu
 cr91kpcTHCR7kJV3rORlZHaCSNh6GGds2B7JHBdNuxYKlSYf
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix the settlingtime attribute so that writing back the value that was
read does not change the setting.

Reading the attribute rounds the total settling time down to the nearest
microsecond. Writing it subtracted the fixed latency (also rounded down
to the nearest microsecond) and then rounded the remaining delay up to
the next tmod period. These don't agree, so writing back the value just
read could select the next higher DELAY value, causing the settling time
to creep up on each write.

Instead, convert the requested total settling time to tmod periods
(rounding up) and compare that against the fixed latency plus delay in
tmod periods. This picks the smallest DELAY value that reads back as
greater than or equal to the requested value.

Fixes: 839cbb1e2331 ("iio: adc: ti-ads112c14: add settlingtime attribute")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/message/20260910-iio-adc-ti-ads112c14-filter-support-v3-9-e5a9b27ddb1a%40baylibre.com
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 483f159e2836..3f46ebb3d84d 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -655,29 +655,22 @@ static int ads112c14_find_delay_for_settling_time_us(struct ads112c14_data *data
 						     struct ads112c14_channel_state *channel_state,
 						     s64 settling_time_us, u8 *delay)
 {
-	u64 delay_us, delay_tmod_needed;
-	u32 fixed_latency_us;
-	int ret, fmod_Hz;
+	int latency_tmod, fmod_Hz;
+	u64 total_tmod_needed;
 	u8 i;
 
-	ret = ads112c14_get_settling_time_us(data, channel_state, 0, &fixed_latency_us);
-	if (ret)
-		return ret;
-
-	if (settling_time_us <= fixed_latency_us) {
-		*delay = 0;
-		return 0;
-	}
-
 	fmod_Hz = ads112c14_get_fmod_Hz(data, channel_state);
 	if (fmod_Hz <= 0)
 		return -EINVAL;
 
-	delay_us = settling_time_us - fixed_latency_us;
-	delay_tmod_needed = DIV_ROUND_UP_ULL(delay_us * fmod_Hz, USEC_PER_SEC);
+	latency_tmod = ads112c14_get_latency_tmod(channel_state);
+	if (latency_tmod < 0)
+		return latency_tmod;
+
+	total_tmod_needed = DIV_ROUND_UP_ULL(settling_time_us * fmod_Hz, USEC_PER_SEC);
 
-	for (i = 1; i < ADS112C14_DELAY_MAX; i++) {
-		if (ads112c14_delay_to_tmod(i) >= delay_tmod_needed)
+	for (i = 0; i < ADS112C14_DELAY_MAX; i++) {
+		if (latency_tmod + ads112c14_delay_to_tmod(i) >= total_tmod_needed)
 			break;
 	}
 

-- 
2.43.0

