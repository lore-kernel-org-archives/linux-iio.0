Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87AE3D3339
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869663; cv=none; b=dZPySi1127wN+7bcq6tCEnqpuU6emasBNU2P9SzKbDJ8TO9yCEgkBhX6CPmNvpapkWbd2o5UOn6U++fGzp6070Ksiq2p/06yROE62wZ6CdMhJNsfD72pZR/1A1Rn1k9ETSre7J1bCMP+yz0bWLPuHJrkIJb64dWJG/+irjbUfow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869663; c=relaxed/simple;
	bh=+6NzsAXpxpUyYVYr7CrkYkFkcEajA1+j6cXX/jJG7dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXypZpmNZiCXffrL8FelPpQXBbpxVqccjAl23/jnKepQV1PZ4Wu1r/nAh7B0y5FP9N+DisKNQbv/CFdbhrTFkY9UVKDqjFsxQCj1RWOXa9AnXpvBiGM2/7tasRacDEHnuwiS8E4nz8H52WqPM7adAvQLlC9hpDt5El8IZLn70hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nu3Fial1; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nu3Fial1"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-459281bc13bso394687fac.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787869652; x=1788474452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDKoS7M6FWotXuFa/jW1tR0/zPrDl09a09em6cgDMYE=;
        b=nu3Fial1vggozbYaYq+p5EC4h4ifTPeUhRsAHdQXtlxfO2tvnY5S18FeL11RX+C+D8
         WJrmFfWIHSQYNb5A5Elvxgzzoq+PN4E/+e6ohKKHF8qwjAu6ndwOso47vwvCXt9bk9Ux
         3YPjUI9ZZw4bBpxAcxAJqZPn5WZ3ZU8LJ2pJACxrNzsUMsrAOV4UNyXXNB67Yw/6+uKx
         /a9vJMaePjFWH+4XzAywsfA0bI1ExfqPsxcj5r4ZezSz2jZ3FnaNu8sgQCf+3cb9i6Em
         04vW9mBuuMFb/S9Al14x0aNfLjt9nI9H4DFBFRoEFKIhO2nIhi8n1bhgccOAipnTvClb
         ZCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869652; x=1788474452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDKoS7M6FWotXuFa/jW1tR0/zPrDl09a09em6cgDMYE=;
        b=P5njZUcfRmjtDnW2CEFl2OXpA50U0KtMCyAp41qa4wK9CiGPBGwh/hS1O0R4UgUqsu
         x6s8YQkb0gQFa+s9pOG02xQzZbMTL2S8YU4dTCC/Tr3lQuL0zf4NnT0BJsYMFEl1XrKR
         tZm3lAnjq1SiB84vOB5l2vpaQumpCI7k7QwpGSA9KVyw+3kgGUhJy53HgTZRsj7VRyEY
         6qYz5As6X6tXI5HDwboUEnh00/YoTAtpq4t5uMNZAw0jvh9VnJSkT++2ZoPbC+bKw2t7
         EmJ3UE/L7sSrzpI4OdP9gK6g/f0XVqW1ddK/Uwl9KBAPWrY/mmPpeui9oD2h5ZuzDnvA
         iyPw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2jzizAKHUVzm4W+A4N531nyrER7ht/ZMdLYvbRNiWg9qEd8JIQtxdNU12VyzoW/RkGeHUjxnlRXA=@vger.kernel.org
X-Gm-Message-State: AFuF++nA+SWYQ/Sqf07yo0KvJzl64iQ8+G573qhTcTZmMhvxJ8DgWszJ
	w43rxFNRWrkrBeGYSdqfMbdFHdo0g5ZAu6zjyRu8rMy5Ys0XPDvIVFfCfLXpxIuGI1o=
X-Gm-Gg: AR+sD10JPbEFh25IE0VM8b1gJtWmtgos+X908XYIS01GpJPEerZImsZLJFOu7Tc++GM
	FtLohCvw2YncjJE0DTAOAxK8ooUelw5SBr97/ib/wL3sA7aAsnTPxiZVUcN/VCc8AoaO3e06iLX
	OJF8ivkoAoqIxvYwxNV1NMMi5Gti1Gh3cIkO8lxDXkqAQ7IfeSDaTIGS424K6b4I7iyaryiXTAE
	F4zjGmZGc3HKD5COhHF9rbxm9P3y3Ljqfd0W2xCgy/u2SdDzCTGR5v/y93Pqei0B1y/DltNXI5x
	9JGjH8Fhmr58MtMqbJeYMPCqc8ghfGXttnQOBL5ZyRen5ccLucH9BYwSy+lGPwEDOyMo+yBnE87
	n/cI5eBpW2r1yliIVqIuLDDvYGYuBwq0U5joClCaPKxjptLG/8ccwRR/cLhSVBRlHXe1PfYqS6u
	ECOFwwEmMGqdhuFdoQmnenDHXHjXGqmII/qE/YcMUbRNbICdy60tw1pZxadv0iwmYS9Q==
X-Received: by 2002:a05:6870:b2d3:b0:447:4e49:37e2 with SMTP id 586e51a60fabf-46837782b60mr3021180fac.13.1787869652003;
        Thu, 27 Aug 2026 15:27:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d288:6f77:e285:6925])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46736444b99sm3336392fac.3.2026.08.27.15.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:27:30 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 27 Aug 2026 17:27:03 -0500
Subject: [PATCH v2 2/2] iio: ABI: add sysfs attribute for _burnoutraw
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-iio-adc-ti-ads112c14-burnout-v2-2-00a1fab9e2d1@baylibre.com>
References: <20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com>
In-Reply-To: <20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+6NzsAXpxpUyYVYr7CrkYkFkcEajA1+j6cXX/jJG7dM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqkLnGmxf+CrV5k1AlvvJi8t46iy3xM2Sfrm6T7
 5/6V5r8qdmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapC5xgAKCRDCzCAB/wGP
 wK0XB/9iUk+UGF5DSBenOyxqCbqnLobSCsEfm2xuQtEwAwBtnBRLUGJHvoqGIK0x01faaTCiZjh
 daqbamjp3CgItjaDoqyz4+RpU4W1MiRSCBFD7OAe7EUlxgh5Z1jGLP9jwxIyrOo9u9fNPIn+FWj
 QoAmckzNGKtVBpnHAkRGrUwiMXPP0m3xSEnVhRCt0RbHVBndP2Mvq8HlWe9NmMtf/rCGxpXJHv2
 iwey3z7PgdwbrEU0kSn3mrIa3VwHSIuC/AvrZSF0Ial+wcoZIwgbxu78LphnDOuD8M6dCiLdGK9
 tlIOTpgEj3dsMF2fxf0iCcf1J67HLjnKxlhuRmR1XxWHoR60
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new _burnoutraw attribute to the IIO ADC ABI. This is likely only
applicable to ADCs (but is seen on multiple chips and vendors) so it
gets its own file instead of being added to the main IIO ABI file.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc b/Documentation/ABI/testing/sysfs-bus-iio-adc
new file mode 100644
index 000000000000..d45f0a4eb18e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc
@@ -0,0 +1,9 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_burnoutraw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_burnoutraw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_burnoutraw
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value from channel Y read using a single conversion with
+		the channel burnout current enabled. This is typically used
+		for diagnostic purposes to detect an open or shorted input.

-- 
2.43.0

