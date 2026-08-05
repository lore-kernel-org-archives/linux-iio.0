Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87703E9C17
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919087; cv=none; b=e3KblX1y1G3Jr18KYQT/7s4db52z8d+qzbF8IsPRII8bUoDj4CCpwM+t1xX1So0672B/WPdKZ2VA842NDppXisXC4XERC7O5N9L/yauQQGoAfdJcneC9bfPF24GBtPN99nvE19VzdhXZVmf2FN81Zq01mU12ZoAPA9mq2s97Iss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919087; c=relaxed/simple;
	bh=xbdXc93eVoEnHSc6HZmwLx7VOseAbmuXTYlOJgdHCsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVsg8cFTrvaIvVSKM8fjUPWGRB/dnTsGERtSeUeA7Oqz26uyeHAijVKN1xvy9DFA7tEzjqlKZFNkLlQCalFtpZqqBMXteS4WSwbMnL0sLFmUbAuR3xRr+1cVvsHePBDOgq5cQBmlirVRylZwe8a3Itw25uMhhcLuKNWUjXeR4fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzgfhLjb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzgfhLjb"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c2ae992beso47128f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785919084; x=1786523884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ve8270E6MOdj8YsOaSYLA5r25PubDk8jW4r4l/rs05g=;
        b=YzgfhLjbTO6RRXbSTLSsQO4IWHlkcsvWluvHK5iODWoNjpxGXkqvNgKjgOPunYN6RL
         rj4rXr4Z1pqfh6xGfGeEvafzOAkru5qTXmgK5s26hHjkgIhaLao48n25Fnpjm+ImIe6V
         inax94/QLiSB3UUBjiL1KCzYRDQxJWZLGEcV5SxM9xh58IsRQsIUudvPcIdgkBgOXxDW
         xcSruyrkNBg8SSAKX/apvDeT4duIaYtE8G/q75diueJOqIQx6yIq0ij/YO7gPgNEIK7n
         p9/XoOO11y8F6+Yyoiu1ReIZi+aKJmCPCMudFGhldVxC4330hbUWoyxXgo8hJ/RE8vg2
         LqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785919084; x=1786523884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ve8270E6MOdj8YsOaSYLA5r25PubDk8jW4r4l/rs05g=;
        b=ndXJa3hrlENDDArOWvzE7eqtCawkRll+SGe1hofZt8AFiw5u6Vio4Md/WToNQqNI6F
         QgxedY5lne9c4oQjz7DEFUVd8h5D7200kKNW8e2blWkVF1CmzS6I7gJKMlqSdQ+QlcL5
         gJi0eck6exqfsDEulCIeS6ucQYTUGGpyXJDl0xFkX5vupjwuFVe6sHOTwLrxuycUhHnZ
         czibmFVCX3pzuhPjxs+tOWmWvQlfxJtQOKRTo8hfE1QVgk91X07XLmuMWmKy2Lu7VYSD
         GciElnM+RjLg1lYrfMumkvIJ5lKAkaQlvkfoEl/SadH/bz2JqZP7UKfPPnUfdzptA2C6
         Qivg==
X-Gm-Message-State: AOJu0YyRzKYC1lrtVOJs0mtTVB/IQ2SMz/nmUTRQoRsb250uj6Nhrnjp
	zURpeaL1uFDkiE/9Tsn1iqWnW7r3FqQpikVk6diUbOI2IiKzeqz6fCkD4taw3Ee0
X-Gm-Gg: AR+sD11+gfMkfPwL3vC+G5HnXWwXlYw93qJtoGvRHvhX5JbQjCab+GPd5G+obrfeWZN
	A4X+qiybO4hln8mafKdSFsdO4hIUTlBtLhIHX/T0eVBrobZtjJcuJPXfB2r5WqLCvWMjxGIQTIV
	rSTSZ3gjUWAQSWG2bi+jJ1OM4DWo/zJDCxBbu5up9VNG0mPqJwBFj5Jxqsj467RtapCi122qBhl
	rmk14jxRdPB131T33suBt0+xQnbkSXzuMOfSxRK4PgNusBvzHAcZXqR0qqUcQWRGwXQRsh+68LT
	qUUgc42wbpXckQLNO5lfEjWYs1Mp7mQg/NJnmt8sGJNNrejN/gacUcBMpKSw4HRnWBDCKImEDuc
	K2njMoxTlQK8KXDIUCHb7fZeRCGIx0D5K+GvOwNi+qbpGpAkTaVL8+aahSj3q6d5w+lhsUT9g2t
	vUQuFyCMFy5KuD61gaOY1gZgrmmdHa0jCeNjxCIv5TZS+uy3wlSHuilTGilZF8SW8KWLbjcKAXs
	S4TMJCe0Zwe97xOvHVevcMsBUhSYWX8WNSf7JrW7wW2x/ohIsV5Kv+KCCqL0Pt0VNlpuUSLQ3FH
	XlQFUQjBWdh1MA==
X-Received: by 2002:a5d:5f83:0:b0:47f:80e0:53bf with SMTP id ffacd0b85a97d-47fec5322c9mr3831273f8f.3.1785919083806;
        Wed, 05 Aug 2026 01:38:03 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5d68sm6707621f8f.9.2026.08.05.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:38:03 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	joshua.crofts1@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Subject: [PATCH v3] iio: light: veml3328: reshape scale array for readability
Date: Wed,  5 Aug 2026 12:35:34 +0400
Message-ID: <20260805083532.92585-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>

The veml3328_scale_vals array is declared as a flattened [4][8] array,
so accessing a scale value requires calculating the offset of its
(val, val2) pair using gain_inx * 2.

Reshape the array as [4][4][2], with separate dimensions for integration
time, gain and the scale value pair. This removes the manual stride
calculation and makes the relationship between the indexes and values
explicit.

Add named integration-time indexes and use designated initializers for
veml3328_it_times and veml3328_scale_vals so both tables use the same
index definitions.

Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
---
Changes in v3:
- Add named integration-time indexes as suggested by Jonathan Cameron.
- Use designated initializers for veml3328_it_times and
  veml3328_scale_vals to keep both tables indexed consistently.

Changes in v2:
- Reshape veml3328_scale_vals as [4][4][2], as suggested by
  David Lechner.
- Update read and write paths to access the scale value pair directly.

drivers/iio/light/veml3328.c | 53 ++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
index 7ff1753925c4..df36c48204be 100644
--- a/drivers/iio/light/veml3328.c
+++ b/drivers/iio/light/veml3328.c
@@ -32,6 +32,11 @@
 #define VEML3328_REG_DATA_B		0x07
 #define VEML3328_REG_DATA_IR		0x08
 
+#define VEML3328_CONT_IT_50MSECS	0
+#define VEML3328_CONT_IT_100MSECS	1
+#define VEML3328_CONT_IT_200MSECS	2
+#define VEML3328_CONT_IT_400MSECS	3
+
 #define VEML3328_CONF_IT_MASK		GENMASK(5, 4)
 #define VEML3328_CONF_GAIN_MASK		GENMASK(11, 10)
 
@@ -89,21 +94,40 @@ static const struct iio_chan_spec veml3328_channels[] = {
  * Precomputed scale values (micro units).
  * Formula for calculation: 0.384 * (50000 / IT_us) * (1 / Gain)
  * Gain indexes: 0 (x0.5), 1 (x1), 2 (x2), 3 (x4)
- * IT indexes: 0 (50ms), 1 (100ms), 2 (200ms), 3 (400ms)
  */
-static const int veml3328_scale_vals[4][8] = {
-	{ 0, 768000, 0, 384000, 0, 192000, 0, 96000 },
-	{ 0, 384000, 0, 192000, 0, 96000,  0, 48000 },
-	{ 0, 192000, 0, 96000,  0, 48000,  0, 24000 },
-	{ 0, 96000,  0, 48000,  0, 24000,  0, 12000 },
+static const int veml3328_scale_vals[4][4][2] = {
+	[VEML3328_CONT_IT_50MSECS] = {
+		{ 0, 768000 },
+		{ 0, 384000 },
+		{ 0, 192000 },
+		{ 0, 96000 },
+	},
+	[VEML3328_CONT_IT_100MSECS] = {
+		{ 0, 384000 },
+		{ 0, 192000 },
+		{ 0, 96000 },
+		{ 0, 48000 },
+	},
+	[VEML3328_CONT_IT_200MSECS] = {
+		{ 0, 192000 },
+		{ 0, 96000 },
+		{ 0, 48000 },
+		{ 0, 24000 },
+	},
+	[VEML3328_CONT_IT_400MSECS] = {
+		{ 0, 96000 },
+		{ 0, 48000 },
+		{ 0, 24000 },
+		{ 0, 12000 },
+	},
 };
 
 /* integration times in microseconds */
 static const int veml3328_it_times[][2] = {
-	{ 0, 50 * USEC_PER_MSEC },
-	{ 0, 100 * USEC_PER_MSEC },
-	{ 0, 200 * USEC_PER_MSEC },
-	{ 0, 400 * USEC_PER_MSEC },
+	[VEML3328_CONT_IT_50MSECS] = { 0, 50 * USEC_PER_MSEC },
+	[VEML3328_CONT_IT_100MSECS] = { 0, 100 * USEC_PER_MSEC },
+	[VEML3328_CONT_IT_200MSECS] = { 0, 200 * USEC_PER_MSEC },
+	[VEML3328_CONT_IT_400MSECS] = { 0, 400 * USEC_PER_MSEC },
 };
 
 static int veml3328_power_down(struct veml3328_data *data)
@@ -184,9 +208,8 @@ static int veml3328_read_raw(struct iio_dev *indio_dev,
 		if (it_inx >= ARRAY_SIZE(veml3328_it_times) || gain_inx >= 4)
 			return -EINVAL;
 
-		/* Stride by 2 through the flattened array to match (val, val2) */
-		*val = veml3328_scale_vals[it_inx][gain_inx * 2];
-		*val2 = veml3328_scale_vals[it_inx][gain_inx * 2 + 1];
+		*val = veml3328_scale_vals[it_inx][gain_inx][0];
+		*val2 = veml3328_scale_vals[it_inx][gain_inx][1];
 
 		return IIO_VAL_INT_PLUS_MICRO;
 
@@ -282,8 +305,8 @@ static int veml3328_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		for (i = 0; i < 4; i++) {
-			if (val == veml3328_scale_vals[it_inx][i * 2] &&
-			    val2 == veml3328_scale_vals[it_inx][i * 2 + 1])
+			if (val == veml3328_scale_vals[it_inx][i][0] &&
+			    val2 == veml3328_scale_vals[it_inx][i][1])
 				break;
 		}
 
-- 
2.52.0

