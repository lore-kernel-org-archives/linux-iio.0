Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117988;
	b=P9KHze3ww3/yHS7o3tqWq7owY43uVeiX6Q6miFZbnldupj7RNjE/9HQUlBFOyF1I8SiJ
	 XLT4fZaFuig1KXxkp+3H5IpVySG+R4XAJq1k9rUM9dTh8gQFv4bS2t18NM2NgjGk8Epk0
	 piX709X4cfi6bxAreC2ddlCo9ulZGnlzSIHW4Z+KYnS9+MC0S+7faTgU+GNCzOjzloWrW
	 wNLlnhrc95J9HfQBCuby3SZnH0geJ09f3H6PkBijErrxTHVQG8jqlfCiFVSMi/mOygq4V
	 vnR/WZzfgpHD/avckLcN0iiFAysMPNjhBLDLzF2w5wk9ag1Ee4GzZAEF46GGOija/uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117988;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JHqnh8HFZXcfg5Bs0iN7aIm4Zk/RzkzYfzVPGJj8jBw=;
	b=O+p/uTWSEErob+/+Cn/eIKCFKhLPNMEXzQdKlvRhcSvra5d8ZnJ5BegE5rm8WdGD6uOV
	 Zbxv56YTzSXy4YFcHIVQr6J2CUh47hfAN13iFztWuzK80zhlml4sYn3orc5OBxj0D4rYW
	 4zDSimrbWmIsPVNxWf7/JUpe6539wm1jkd/ucRAMJ6rsTT6IBsYwueisC7eypNTLoN4V2
	 nUVLmrxYAB6lK4YeXRnM5YLIE8EK4vx7pe5lg/E9S1YHBl0RvfL7ejryeexoxNifO4fYx
	 ltawd6QxILc5LgJm3iyBHwjCgHXzS++X73a2hNysdWhTdDh3r/a+cVZKRJPdP/G84/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HwAXIM0w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA67606A325;
	Tue, 27 Oct 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HwAXIM0w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB5F1F01825;
	Tue, 27 Oct 2026 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117987;
	bh=JHqnh8HFZXcfg5Bs0iN7aIm4Zk/RzkzYfzVPGJj8jBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HwAXIM0wQ2cdheKBWbZHlqVVP+S/eZL4h9PDvkHLhEB9+7Yr6GnNKORywYginxV3M
	 3jnQvJ/2LS5tPlhglym3BXlmlTIxNB2wV9/GwZcpu4ERSOA58uugjNnxQJWyVs1N9Q
	 51WDvFJsTvN5aJ09Gl7I9pXDrZIjM0QE3cYC+n4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:15 +0100
Subject: [PATCH 11/15] iio: hid-sensors: fix a division by zero
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-11-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Shi Hao <i.shihao.999@gmail.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=UZ5MjDoqa+KWSX7qnJ57nq+fwWzyKDKvYAgn0tEKlhI=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjP/0XGedMX/Qeu8qzF/bYQZnV4m+p/1OWl+MT/52
 YOkuvk/OmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi6zcyLLjAdW838/Wz5nWz
 z/7JDX7g5vdr92WG+bmdNdta/qw7wzjZNfrwtWsaTvs2vQUA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

convert_to_vtf_format() divides the micro part of a value by
10^(6 + exp).  The unit exponent of a HID field is a nibble and goes
down to -8.  For -7 and -8 the argument of int_pow() is negative, which
the unsigned parameter turns into a huge power of ten: 0 modulo 2^64.
The division by it is a divide error.  The exponent comes from the report
descriptor of the sensor hub, the value from a write to the hysteresis
attribute of the IIO device.

Multiply by 10^(-exp - 6) in these two cases.

Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and trigger")
Cc: stable <stable@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Shi Hao <i.shihao.999@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 9e7c26e37880..3b0985d500ae 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -140,7 +140,10 @@ static u32 convert_to_vtf_format(int size, int exp, int val1, int val2)
 	if (val1 < 0 || val2 < 0)
 		sign = -1;
 	exp = hid_sensor_convert_exponent(exp);
-	if (exp < 0) {
+	if (exp < -6) {
+		value = abs(val1) * int_pow(10, -exp);
+		value += abs(val2) * int_pow(10, -exp - 6);
+	} else if (exp < 0) {
 		divisor = int_pow(10, 6 + exp);
 		value = abs(val1) * int_pow(10, -exp);
 		value += abs(val2) / divisor;

-- 
2.56.0

