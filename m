Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53D365A13
	for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385835; cv=none; b=So8X7pTnvHMD43dCVH8jGKfLfzidsmGl7qTQ4UhBC6rm6mGKR/uxpoXahex0c6T+VL+09gG3XOyFzRE7u0SOlveB3iTcCohkkPH4Br+cVOGjzPyeYhhSKkX+Xxn1y4gzaPyJAV36Scd1M2GER2RvcWDQLYth0/rxvEuHj/omrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385835; c=relaxed/simple;
	bh=HvdcY64wwj6yKrUznV7bRCe8usHRBMf57Oq+/AXGEHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/7PL8wEKVDee9sUV2dpuMmepmYc+1zb+D8ovwUM33PgYolJmBDJ4jC1ndjW+GIbcBFnejLPCvINCn4squxM3HCugdWyZy6Fo4V0LIyw7gRyUwk5FCw46DF+aTFbnAd4LEghCHx6cmlriHjkqkrcpwQ/5oLEUs+E2XXUbUlX8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A548CDbS; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A548CDbS"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-126ea4b77adso2395366c88.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773385831; x=1773990631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUnIQ3kV5awtDgkOm3CYYafXRIfx9tiRKxdFzWmypfo=;
        b=A548CDbSLp/xbulUP3csRJazgir/mL4bYUvqBoP6ddZns4jyJfgeGzQN0OhcXVQ6hw
         rGJJeTL+ZZvhIpL4+3uSFUz9heiuqV82ELRlvNEi3uJZ84DfqudTTnH3wuqrSTOIAo9o
         JHU2EttsT4HSY5IGL36Mjk2XWF6h0Los915wAEWc5Cj1dQ4mFau7eRXVsqFutJjs4fbr
         Sq1wIcTRZWC2+529RJfegl7sIOiEk3nfVy3GIlwQ+g9dmVCf+iMfWrq7zATC6cOeiHrL
         SPNprYiiPrfONtEqwZBB3vdYy7NFWjldiVHb+s0jj1M90X86/1DgbonM81/ufYq4fvSm
         3F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385831; x=1773990631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUnIQ3kV5awtDgkOm3CYYafXRIfx9tiRKxdFzWmypfo=;
        b=e4Uq3gyyhUL270ewfwlY8Hu4IiByf7tRHfZUnAtsv7lm0KjYP8Lugq2Jq4svKWdubc
         CfJ2rSngbwjEyGlJDzE03752cunuGmTfPfYsdWgu9DzIqybSRKP6+L7wl9ScmQOGzRB3
         qX2mL5onOAN+A05qhSacjgl01zm692o+5BLtEZk/euCl4lvG+ZCEdLQ7DgKzqrQ9nuyh
         QKYKrK+EzddWcEbp/neiUAdkYIiD8nMRdF9xX+2lyYVoBk7wXtc494etzZNq0J3eK9he
         fkxIZKkdBJiFpMvwIawBy/U5xUucFtLhzANY4Q9ZuPe+kgZDNQkwYF+EewExIsL9NJ9p
         kEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVctHY/AutXmjYnspLfhW2oWs7pz9DeBsWg8k28aouxiUdXIp7KwLulUYhqhDuzTgzJhRpI771LAMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+77xPMrl0rfwxYL8uZCc3j3zYW+1g3F42TI+9P0SwHP9Ie+J8
	Dqb+hJWEXnU4P8ZMc/vofvGNdlI2tgUck6lj/pJzAg931y+c1HHtxcE+
X-Gm-Gg: ATEYQzwJdPoqIFnanqXGVPDJ9J2PAXghnluHrgQr/k1mOAI1EVa6lWOgx7hU9+TgE2n
	upXujw5Ze71uJF9V9LxpmvWw3qjl7UdKVNUy64uRwv6WS2dDMqVGpFNGPFAZIpkZPg4MiqNiGx9
	GW4ZahV91wCRTYQngqtpD1TlEGRop7uSq7fYQSnIdgeGvsRXUgeMjmIJNtMBzMthUbCdhT1zWSs
	J4pzED+DwYqqgptmxriNm0ivhVGdDf0MlZ0pEtItxFSlwzz3RULzbxEyP3wpeeQloecc+vkQ53g
	J/5c2UUNW+pZ8w4gV+6iXgvuUh7acHegIGkOZLx5DPRz7T69GNnnpaDfxhRQyCIh/M+w+dhakQK
	XakNW2gevE+gKYsrOD2xRuUv/Zp6L9cdmKz3KPFxFhBKnUUf+LBho4lpaotCtMn+S8k5A1oiAY8
	s3WINd4EcRLOdWZXH3+xkZNj6cRac7VKKIyRR+NCU6jgn/MzCrBi6JuvikTgUiVzU7NPOPdalDA
	6v9vVd608LG23ovUIp64Jp6U62Kz8lBg2wYwWl4/hPmwCTWxpsN1ftlk7B65/uNqw3CiRldY3Db
	AWpY6sQJMQ==
X-Received: by 2002:a05:7022:6b97:b0:128:d3de:c9e4 with SMTP id a92af1059eb24-128f3dea833mr1030853c88.30.1773385830555;
        Fri, 13 Mar 2026 00:10:30 -0700 (PDT)
Received: from Lewboski.localdomain ([181.191.143.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62b2100sm1122603c88.8.2026.03.13.00.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 00:10:30 -0700 (PDT)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Peter Rosin <peda@axentia.se>,
	Marius Cristea <marius.cristea@microchip.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Benson Leung <bleung@chromium.org>,
	Jyoti Bhayana <jbhayana@google.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Ariana Lazar <ariana.lazar@microchip.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kurt Borja <kuurtb@gmail.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH v2] iio: cleanup: uintptr_t to unsigned long
Date: Fri, 13 Mar 2026 04:10:14 -0300
Message-ID: <20260313071014.2102-1-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313013435.25731-1-tomasborquez13@gmail.com>
References: <20260313013435.25731-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus has been explicit that uintptr_t should not be used in the kernel.

The iio_chan_spec_ext_info struct uses uintptr_t for the private field
and in its read/write function pointer signatures. Jonathan Cameron noted
this should be cleaned up in one go across all users [1].

Update the struct definition in iio.h and backend.h, along with all
drivers implementing or using iio_chan_spec_ext_info callbacks.

No functional change intended.

[1] https://lore.kernel.org/linux-iio/20260111122034.174c754c@jic23-huawei/

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/iio/adc/ad7124.c                      |  2 +-
 drivers/iio/adc/ad7173.c                      |  2 +-
 drivers/iio/adc/ad7192.c                      |  2 +-
 drivers/iio/adc/ad7280a.c                     |  8 ++++----
 drivers/iio/adc/envelope-detector.c           |  8 ++++----
 drivers/iio/adc/mcp3564.c                     |  2 +-
 drivers/iio/adc/pac1921.c                     |  6 +++---
 drivers/iio/adc/stm32-adc.c                   |  2 +-
 drivers/iio/adc/stm32-dfsdm-adc.c             |  4 ++--
 drivers/iio/afe/iio-rescale.c                 |  4 ++--
 drivers/iio/amplifiers/hmc425a.c              |  4 ++--
 drivers/iio/chemical/sunrise_co2.c            |  8 ++++----
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  4 ++--
 drivers/iio/common/scmi_sensors/scmi_iio.c    |  2 +-
 drivers/iio/dac/ad3530r.c                     |  4 ++--
 drivers/iio/dac/ad5064.c                      |  4 ++--
 drivers/iio/dac/ad5380.c                      |  4 ++--
 drivers/iio/dac/ad5446.c                      |  4 ++--
 drivers/iio/dac/ad5504.c                      |  4 ++--
 drivers/iio/dac/ad5592r-base.c                |  2 +-
 drivers/iio/dac/ad5624r_spi.c                 |  4 ++--
 drivers/iio/dac/ad5686.c                      |  4 ++--
 drivers/iio/dac/ad5755.c                      |  4 ++--
 drivers/iio/dac/ad5758.c                      |  4 ++--
 drivers/iio/dac/ad5766.c                      |  4 ++--
 drivers/iio/dac/ad5770r.c                     |  4 ++--
 drivers/iio/dac/ad5791.c                      |  4 ++--
 drivers/iio/dac/ad7303.c                      |  4 ++--
 drivers/iio/dac/ad8460.c                      | 16 +++++++--------
 drivers/iio/dac/adi-axi-dac.c                 |  4 ++--
 drivers/iio/dac/ltc2632.c                     |  4 ++--
 drivers/iio/dac/ltc2664.c                     |  8 ++++----
 drivers/iio/dac/ltc2688.c                     | 14 ++++++-------
 drivers/iio/dac/max22007.c                    |  4 ++--
 drivers/iio/dac/max5821.c                     |  4 ++--
 drivers/iio/dac/mcp4725.c                     |  4 ++--
 drivers/iio/dac/mcp4728.c                     |  4 ++--
 drivers/iio/dac/mcp47feb02.c                  |  4 ++--
 drivers/iio/dac/stm32-dac.c                   |  4 ++--
 drivers/iio/dac/ti-dac082s085.c               |  4 ++--
 drivers/iio/dac/ti-dac5571.c                  |  4 ++--
 drivers/iio/dac/ti-dac7311.c                  |  4 ++--
 drivers/iio/frequency/adf4350.c               |  4 ++--
 drivers/iio/frequency/adf4371.c               |  4 ++--
 drivers/iio/frequency/adf4377.c               |  4 ++--
 drivers/iio/frequency/admv1013.c              |  4 ++--
 drivers/iio/frequency/admv1014.c              |  4 ++--
 drivers/iio/industrialio-backend.c            |  4 ++--
 drivers/iio/industrialio-core.c               |  8 ++++----
 drivers/iio/light/ltr501.c                    |  2 +-
 drivers/iio/light/stk3310.c                   |  2 +-
 drivers/iio/light/vcnl4000.c                  |  2 +-
 drivers/iio/multiplexer/iio-mux.c             |  4 ++--
 drivers/iio/proximity/isl29501.c              |  4 ++--
 drivers/iio/proximity/sx9324.c                |  2 +-
 drivers/iio/trigger/stm32-timer-trigger.c     |  4 ++--
 include/linux/iio/backend.h                   |  8 ++++----
 include/linux/iio/iio.h                       | 20 +++++++++----------
 58 files changed, 137 insertions(+), 137 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 5c1a8f886bcc..5e9fcb65554e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1054,7 +1054,7 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
 }
 
 static ssize_t ad7124_write_syscalib(struct iio_dev *indio_dev,
-				     uintptr_t private,
+				     unsigned long private,
 				     const struct iio_chan_spec *chan,
 				     const char *buf, size_t len)
 {
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index f76a9e08f39e..828d7034e2b0 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -367,7 +367,7 @@ static int ad7173_get_syscalib_mode(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
-				     uintptr_t private,
+				     unsigned long private,
 				     const struct iio_chan_spec *chan,
 				     const char *buf, size_t len)
 {
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8b1664f6b102..076bd9a28315 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -245,7 +245,7 @@ static int ad7192_get_syscalib_mode(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad7192_write_syscalib(struct iio_dev *indio_dev,
-				     uintptr_t private,
+				     unsigned long private,
 				     const struct iio_chan_spec *chan,
 				     const char *buf, size_t len)
 {
diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..0862462dc8ce 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -469,7 +469,7 @@ static int ad7280_chain_setup(struct ad7280_state *st)
 }
 
 static ssize_t ad7280_show_balance_sw(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad7280_state *st = iio_priv(indio_dev);
@@ -480,7 +480,7 @@ static ssize_t ad7280_show_balance_sw(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
-				       uintptr_t private,
+				       unsigned long private,
 				       const struct iio_chan_spec *chan,
 				       const char *buf, size_t len)
 {
@@ -511,7 +511,7 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
-					 uintptr_t private,
+					 unsigned long private,
 					 const struct iio_chan_spec *chan,
 					 char *buf)
 {
@@ -533,7 +533,7 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
-					  uintptr_t private,
+					  unsigned long private,
 					  const struct iio_chan_spec *chan,
 					  const char *buf, size_t len)
 {
diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 5b16fe737659..107d0c42be03 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -228,7 +228,7 @@ static int envelope_detector_read_raw(struct iio_dev *indio_dev,
 }
 
 static ssize_t envelope_show_invert(struct iio_dev *indio_dev,
-				    uintptr_t private,
+				    unsigned long private,
 				    struct iio_chan_spec const *ch, char *buf)
 {
 	struct envelope *env = iio_priv(indio_dev);
@@ -237,7 +237,7 @@ static ssize_t envelope_show_invert(struct iio_dev *indio_dev,
 }
 
 static ssize_t envelope_store_invert(struct iio_dev *indio_dev,
-				     uintptr_t private,
+				     unsigned long private,
 				     struct iio_chan_spec const *ch,
 				     const char *buf, size_t len)
 {
@@ -267,7 +267,7 @@ static ssize_t envelope_store_invert(struct iio_dev *indio_dev,
 }
 
 static ssize_t envelope_show_comp_interval(struct iio_dev *indio_dev,
-					   uintptr_t private,
+					   unsigned long private,
 					   struct iio_chan_spec const *ch,
 					   char *buf)
 {
@@ -277,7 +277,7 @@ static ssize_t envelope_show_comp_interval(struct iio_dev *indio_dev,
 }
 
 static ssize_t envelope_store_comp_interval(struct iio_dev *indio_dev,
-					    uintptr_t private,
+					    unsigned long private,
 					    struct iio_chan_spec const *ch,
 					    const char *buf, size_t len)
 {
diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 36675563829e..f2cebdbff84b 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -533,7 +533,7 @@ static const struct iio_chan_spec_ext_info mcp3564_ext_info[] = {
 		.name = "boost_current_gain_available",
 		.shared = IIO_SHARED_BY_ALL,
 		.read = iio_enum_available_read,
-		.private = (uintptr_t)&mcp3564_current_boost_mode_enum,
+		.private = (unsigned long)&mcp3564_current_boost_mode_enum,
 	},
 	{ }
 };
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index bce7185953ec..e1de1cf8d2a4 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -768,7 +768,7 @@ static const struct iio_info pac1921_iio = {
 };
 
 static ssize_t pac1921_read_shunt_resistor(struct iio_dev *indio_dev,
-					    uintptr_t private,
+					    unsigned long private,
 					    const struct iio_chan_spec *chan,
 					    char *buf)
 {
@@ -787,7 +787,7 @@ static ssize_t pac1921_read_shunt_resistor(struct iio_dev *indio_dev,
 }
 
 static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
-					    uintptr_t private,
+					    unsigned long private,
 					    const struct iio_chan_spec *chan,
 					    const char *buf, size_t len)
 {
@@ -862,7 +862,7 @@ static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
  * instead.
  */
 static ssize_t pac1921_read_scale_avail(struct iio_dev *indio_dev,
-					uintptr_t private,
+					unsigned long private,
 					const struct iio_chan_spec *chan,
 					char *buf)
 {
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 46106200bb86..28adf4d23e4c 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2008,7 +2008,7 @@ static const struct iio_chan_spec_ext_info stm32_adc_ext_info[] = {
 		.name = "trigger_polarity_available",
 		.shared = IIO_SHARED_BY_ALL,
 		.read = iio_enum_available_read,
-		.private = (uintptr_t)&stm32_adc_trig_pol,
+		.private = (unsigned long)&stm32_adc_trig_pol,
 	},
 	{ }
 };
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 9664b9bd75d4..85073bbee9cb 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -740,7 +740,7 @@ static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
 }
 
 static ssize_t dfsdm_adc_audio_get_spiclk(struct iio_dev *indio_dev,
-					  uintptr_t priv,
+					  unsigned long priv,
 					  const struct iio_chan_spec *chan,
 					  char *buf)
 {
@@ -774,7 +774,7 @@ static int dfsdm_adc_set_samp_freq(struct iio_dev *indio_dev,
 }
 
 static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
-					  uintptr_t priv,
+					  unsigned long priv,
 					  const struct iio_chan_spec *chan,
 					  const char *buf, size_t len)
 {
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index ecaf59278c6f..19a490f2427a 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -255,7 +255,7 @@ static const struct iio_info rescale_info = {
 };
 
 static ssize_t rescale_read_ext_info(struct iio_dev *indio_dev,
-				     uintptr_t private,
+				     unsigned long private,
 				     struct iio_chan_spec const *chan,
 				     char *buf)
 {
@@ -267,7 +267,7 @@ static ssize_t rescale_read_ext_info(struct iio_dev *indio_dev,
 }
 
 static ssize_t rescale_write_ext_info(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      struct iio_chan_spec const *chan,
 				      const char *buf, size_t len)
 {
diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 4dbf894c7e3b..da982aa95be1 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -232,7 +232,7 @@ static const struct iio_info hmc425a_info = {
 };
 
 static ssize_t ltc6373_read_powerdown(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      char *buf)
 {
@@ -242,7 +242,7 @@ static ssize_t ltc6373_read_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc6373_write_powerdown(struct iio_dev *indio_dev,
-				       uintptr_t private,
+				       unsigned long private,
 				       const struct iio_chan_spec *chan,
 				       const char *buf,
 				       size_t len)
diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
index 158be9d798d2..a978d07b8a68 100644
--- a/drivers/iio/chemical/sunrise_co2.c
+++ b/drivers/iio/chemical/sunrise_co2.c
@@ -234,7 +234,7 @@ static int sunrise_calibrate(struct sunrise_dev *sunrise,
 }
 
 static ssize_t sunrise_cal_factory_write(struct iio_dev *iiodev,
-					 uintptr_t private,
+					 unsigned long private,
 					 const struct iio_chan_spec *chan,
 					 const char *buf, size_t len)
 {
@@ -259,7 +259,7 @@ static ssize_t sunrise_cal_factory_write(struct iio_dev *iiodev,
 }
 
 static ssize_t sunrise_cal_background_write(struct iio_dev *iiodev,
-					    uintptr_t private,
+					    unsigned long private,
 					    const struct iio_chan_spec *chan,
 					    const char *buf, size_t len)
 {
@@ -316,7 +316,7 @@ static const struct iio_enum sunrise_error_statuses_enum = {
 };
 
 static ssize_t sunrise_error_status_read(struct iio_dev *iiodev,
-					 uintptr_t private,
+					 unsigned long private,
 					 const struct iio_chan_spec *chan,
 					 char *buf)
 {
@@ -369,7 +369,7 @@ static const struct iio_chan_spec_ext_info sunrise_concentration_ext_info[] = {
 		.name = "error_status_available",
 		.shared = IIO_SHARED_BY_ALL,
 		.read = iio_enum_available_read,
-		.private = (uintptr_t)&sunrise_error_statuses_enum,
+		.private = (unsigned long)&sunrise_error_statuses_enum,
 	},
 	{ }
 };
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 5133755c2ea6..1df2c77424d3 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -431,7 +431,7 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 EXPORT_SYMBOL_GPL(cros_ec_motion_send_host_cmd);
 
 static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
-		uintptr_t private, const struct iio_chan_spec *chan,
+		unsigned long private, const struct iio_chan_spec *chan,
 		const char *buf, size_t len)
 {
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
@@ -460,7 +460,7 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
 }
 
 static ssize_t cros_ec_sensors_id(struct iio_dev *indio_dev,
-				  uintptr_t private,
+				  unsigned long private,
 				  const struct iio_chan_spec *chan, char *buf)
 {
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 5136ad9ada04..5fe0ab359f0b 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -368,7 +368,7 @@ static const struct iio_info scmi_iio_info = {
 };
 
 static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
-					  uintptr_t private,
+					  unsigned long private,
 					  const struct iio_chan_spec *chan,
 					  char *buf)
 {
diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index b97b46090d80..b78c0581de0f 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -134,7 +134,7 @@ static const struct iio_enum ad3530r_powerdown_mode_enum = {
 };
 
 static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
-					 uintptr_t private,
+					 unsigned long private,
 					 const struct iio_chan_spec *chan,
 					 char *buf)
 {
@@ -145,7 +145,7 @@ static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
-					 uintptr_t private,
+					 unsigned long private,
 					 const struct iio_chan_spec *chan,
 					 const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 84be5174babd..bd8973ae4305 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -273,7 +273,7 @@ static const struct iio_enum ltc2617_powerdown_mode_enum = {
 };
 
 static ssize_t ad5064_read_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+	unsigned long private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5064_state *st = iio_priv(indio_dev);
 
@@ -281,7 +281,7 @@ static ssize_t ad5064_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
-	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	 unsigned long private, const struct iio_chan_spec *chan, const char *buf,
 	 size_t len)
 {
 	struct ad5064_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 8b813cee7625..005829440ee1 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -77,7 +77,7 @@ enum ad5380_type {
 };
 
 static ssize_t ad5380_read_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+	unsigned long private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5380_state *st = iio_priv(indio_dev);
 
@@ -85,7 +85,7 @@ static ssize_t ad5380_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5380_write_dac_powerdown(struct iio_dev *indio_dev,
-	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	 unsigned long private, const struct iio_chan_spec *chan, const char *buf,
 	 size_t len)
 {
 	struct ad5380_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 46a2eadb1d9b..9ae9633f0a57 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -54,7 +54,7 @@ static const struct iio_enum ad5446_powerdown_mode_enum = {
 };
 
 static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
-					 uintptr_t private,
+					 unsigned long private,
 					 const struct iio_chan_spec *chan,
 					 char *buf)
 {
@@ -64,7 +64,7 @@ static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
-					  uintptr_t private,
+					  unsigned long private,
 					  const struct iio_chan_spec *chan,
 					  const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 355bcb6a8ba0..58f35d3908ff 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -166,7 +166,7 @@ static const struct iio_enum ad5504_powerdown_mode_enum = {
 };
 
 static ssize_t ad5504_read_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+	unsigned long private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
@@ -175,7 +175,7 @@ static ssize_t ad5504_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	unsigned long private, const struct iio_chan_spec *chan, const char *buf,
 	size_t len)
 {
 	bool pwr_down;
diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 4720733d66b2..1aecae4db92d 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -451,7 +451,7 @@ static const struct iio_info ad5592r_info = {
 };
 
 static ssize_t ad5592r_show_scale_available(struct iio_dev *iio_dev,
-					   uintptr_t private,
+					   unsigned long private,
 					   const struct iio_chan_spec *chan,
 					   char *buf)
 {
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 13aefe769bad..8c0f98e0e78b 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -113,7 +113,7 @@ static const struct iio_enum ad5624r_powerdown_mode_enum = {
 };
 
 static ssize_t ad5624r_read_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+	unsigned long private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5624r_state *st = iio_priv(indio_dev);
 
@@ -122,7 +122,7 @@ static ssize_t ad5624r_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5624r_write_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	unsigned long private, const struct iio_chan_spec *chan, const char *buf,
 	size_t len)
 {
 	bool pwr_down;
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4b18498aa074..c31180af33ff 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -53,7 +53,7 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 };
 
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
-		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+		unsigned long private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
@@ -62,7 +62,7 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
-					  uintptr_t private,
+					  unsigned long private,
 					  const struct iio_chan_spec *chan,
 					  const char *buf,
 					  size_t len)
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index d0e5f35462b1..3c368b168a85 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -487,7 +487,7 @@ static int ad5755_write_raw(struct iio_dev *indio_dev,
 	return ad5755_write(indio_dev, reg, val);
 }
 
-static ssize_t ad5755_read_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
+static ssize_t ad5755_read_powerdown(struct iio_dev *indio_dev, unsigned long priv,
 	const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
@@ -496,7 +496,7 @@ static ssize_t ad5755_read_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
 			  (bool)(st->pwr_down & (1 << chan->channel)));
 }
 
-static ssize_t ad5755_write_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
+static ssize_t ad5755_write_powerdown(struct iio_dev *indio_dev, unsigned long priv,
 	struct iio_chan_spec const *chan, const char *buf, size_t len)
 {
 	bool pwr_down;
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 4ed4fda76ea9..d06576fd4c3a 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -567,7 +567,7 @@ static int ad5758_write_raw(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5758_read_powerdown(struct iio_dev *indio_dev,
-				     uintptr_t priv,
+				     unsigned long priv,
 				     const struct iio_chan_spec *chan,
 				     char *buf)
 {
@@ -577,7 +577,7 @@ static ssize_t ad5758_read_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
-				      uintptr_t priv,
+				      unsigned long priv,
 				      struct iio_chan_spec const *chan,
 				      const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
index f6a0a0d84fef..d09ab5abe0e4 100644
--- a/drivers/iio/dac/ad5766.c
+++ b/drivers/iio/dac/ad5766.c
@@ -355,7 +355,7 @@ static const struct iio_enum ad5766_dither_scale_enum = {
 };
 
 static ssize_t ad5766_read_ext(struct iio_dev *indio_dev,
-			       uintptr_t private,
+			       unsigned long private,
 			       const struct iio_chan_spec *chan,
 			       char *buf)
 {
@@ -379,7 +379,7 @@ static ssize_t ad5766_read_ext(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5766_write_ext(struct iio_dev *indio_dev,
-				 uintptr_t private,
+				 unsigned long private,
 				 const struct iio_chan_spec *chan,
 				 const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index cd47cb1c685c..d5b8245b764e 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -426,7 +426,7 @@ static int ad5770r_store_output_range(struct ad5770r_state *st,
 }
 
 static ssize_t ad5770r_read_dac_powerdown(struct iio_dev *indio_dev,
-					  uintptr_t private,
+					  unsigned long private,
 					  const struct iio_chan_spec *chan,
 					  char *buf)
 {
@@ -436,7 +436,7 @@ static ssize_t ad5770r_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5770r_write_dac_powerdown(struct iio_dev *indio_dev,
-					   uintptr_t private,
+					   unsigned long private,
 					   const struct iio_chan_spec *chan,
 					   const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index ae7297f08398..e0236bc9517a 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -185,7 +185,7 @@ static const struct iio_enum ad5791_powerdown_mode_enum = {
 };
 
 static ssize_t ad5791_read_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+	unsigned long private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5791_state *st = iio_priv(indio_dev);
 
@@ -193,7 +193,7 @@ static ssize_t ad5791_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5791_write_dac_powerdown(struct iio_dev *indio_dev,
-	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	 unsigned long private, const struct iio_chan_spec *chan, const char *buf,
 	 size_t len)
 {
 	bool pwr_down;
diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index a88cc639047d..da28ce1473af 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -61,7 +61,7 @@ static int ad7303_write(struct ad7303_state *st, unsigned int chan,
 }
 
 static ssize_t ad7303_read_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+	unsigned long private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad7303_state *st = iio_priv(indio_dev);
 
@@ -70,7 +70,7 @@ static ssize_t ad7303_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
-	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
+	 unsigned long private, const struct iio_chan_spec *chan, const char *buf,
 	 size_t len)
 {
 	struct ad7303_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index 6e45686902dd..34b1eb69738c 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -173,7 +173,7 @@ static int ad8460_set_hvdac_word(struct ad8460_state *state, int index, int val)
 				 &state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
 }
 
-static ssize_t ad8460_dac_input_read(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t ad8460_dac_input_read(struct iio_dev *indio_dev, unsigned long private,
 				     const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad8460_state *state = iio_priv(indio_dev);
@@ -187,7 +187,7 @@ static ssize_t ad8460_dac_input_read(struct iio_dev *indio_dev, uintptr_t privat
 	return sysfs_emit(buf, "%u\n", reg);
 }
 
-static ssize_t ad8460_dac_input_write(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t ad8460_dac_input_write(struct iio_dev *indio_dev, unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      const char *buf, size_t len)
 {
@@ -204,7 +204,7 @@ static ssize_t ad8460_dac_input_write(struct iio_dev *indio_dev, uintptr_t priva
 	return ad8460_set_hvdac_word(state, private, reg);
 }
 
-static ssize_t ad8460_read_symbol(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t ad8460_read_symbol(struct iio_dev *indio_dev, unsigned long private,
 				  const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad8460_state *state = iio_priv(indio_dev);
@@ -218,7 +218,7 @@ static ssize_t ad8460_read_symbol(struct iio_dev *indio_dev, uintptr_t private,
 	return sysfs_emit(buf, "%lu\n", FIELD_GET(AD8460_PATTERN_DEPTH_MSK, reg));
 }
 
-static ssize_t ad8460_write_symbol(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t ad8460_write_symbol(struct iio_dev *indio_dev, unsigned long private,
 				   const struct iio_chan_spec *chan,
 				   const char *buf, size_t len)
 {
@@ -238,7 +238,7 @@ static ssize_t ad8460_write_symbol(struct iio_dev *indio_dev, uintptr_t private,
 				  FIELD_PREP(AD8460_PATTERN_DEPTH_MSK, sym));
 }
 
-static ssize_t ad8460_read_toggle_en(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t ad8460_read_toggle_en(struct iio_dev *indio_dev, unsigned long private,
 				     const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad8460_state *state = iio_priv(indio_dev);
@@ -252,7 +252,7 @@ static ssize_t ad8460_read_toggle_en(struct iio_dev *indio_dev, uintptr_t privat
 	return sysfs_emit(buf, "%ld\n", FIELD_GET(AD8460_APG_MODE_ENABLE_MSK, reg));
 }
 
-static ssize_t ad8460_write_toggle_en(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t ad8460_write_toggle_en(struct iio_dev *indio_dev, unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      const char *buf, size_t len)
 {
@@ -272,7 +272,7 @@ static ssize_t ad8460_write_toggle_en(struct iio_dev *indio_dev, uintptr_t priva
 	return ret;
 }
 
-static ssize_t ad8460_read_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t ad8460_read_powerdown(struct iio_dev *indio_dev, unsigned long private,
 				     const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad8460_state *state = iio_priv(indio_dev);
@@ -286,7 +286,7 @@ static ssize_t ad8460_read_powerdown(struct iio_dev *indio_dev, uintptr_t privat
 	return sysfs_emit(buf, "%ld\n", FIELD_GET(AD8460_HVDAC_SLEEP_MSK, reg));
 }
 
-static ssize_t ad8460_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t ad8460_write_powerdown(struct iio_dev *indio_dev, unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 451fad34e7ee..43b454a27ae0 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -433,7 +433,7 @@ static int axi_dac_phase_set(struct axi_dac_state *st,
 	return len;
 }
 
-static int axi_dac_ext_info_set(struct iio_backend *back, uintptr_t private,
+static int axi_dac_ext_info_set(struct iio_backend *back, unsigned long private,
 				const struct iio_chan_spec *chan,
 				const char *buf, size_t len)
 {
@@ -457,7 +457,7 @@ static int axi_dac_ext_info_set(struct iio_backend *back, uintptr_t private,
 	}
 }
 
-static int axi_dac_ext_info_get(struct iio_backend *back, uintptr_t private,
+static int axi_dac_ext_info_get(struct iio_backend *back, unsigned long private,
 				const struct iio_chan_spec *chan, char *buf)
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 105f939f7e54..761ad4baff03 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -128,7 +128,7 @@ static int ltc2632_write_raw(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2632_read_dac_powerdown(struct iio_dev *indio_dev,
-					  uintptr_t private,
+					  unsigned long private,
 					  const struct iio_chan_spec *chan,
 					  char *buf)
 {
@@ -139,7 +139,7 @@ static ssize_t ltc2632_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2632_write_dac_powerdown(struct iio_dev *indio_dev,
-					   uintptr_t private,
+					   unsigned long private,
 					   const struct iio_chan_spec *chan,
 					   const char *buf,
 					   size_t len)
diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
index 67f14046cf77..08e1352a145a 100644
--- a/drivers/iio/dac/ltc2664.c
+++ b/drivers/iio/dac/ltc2664.c
@@ -284,7 +284,7 @@ static int ltc2664_write_raw(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2664_reg_bool_get(struct iio_dev *indio_dev,
-				    uintptr_t private,
+				    unsigned long private,
 				    const struct iio_chan_spec *chan,
 				    char *buf)
 {
@@ -313,7 +313,7 @@ static ssize_t ltc2664_reg_bool_get(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2664_reg_bool_set(struct iio_dev *indio_dev,
-				    uintptr_t private,
+				    unsigned long private,
 				    const struct iio_chan_spec *chan,
 				    const char *buf, size_t len)
 {
@@ -363,7 +363,7 @@ static ssize_t ltc2664_reg_bool_set(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2664_dac_input_read(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      char *buf)
 {
@@ -381,7 +381,7 @@ static ssize_t ltc2664_dac_input_read(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2664_dac_input_write(struct iio_dev *indio_dev,
-				       uintptr_t private,
+				       unsigned long private,
 				       const struct iio_chan_spec *chan,
 				       const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index 02f408229681..a5792cf68dcb 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -344,7 +344,7 @@ static int ltc2688_write_raw(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2688_dither_toggle_set(struct iio_dev *indio_dev,
-					 uintptr_t private,
+					 unsigned long private,
 					 const struct iio_chan_spec *chan,
 					 const char *buf, size_t len)
 {
@@ -369,7 +369,7 @@ static ssize_t ltc2688_dither_toggle_set(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2688_reg_bool_get(struct iio_dev *indio_dev,
-				    uintptr_t private,
+				    unsigned long private,
 				    const struct iio_chan_spec *chan,
 				    char *buf)
 {
@@ -385,7 +385,7 @@ static ssize_t ltc2688_reg_bool_get(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2688_reg_bool_set(struct iio_dev *indio_dev,
-				    uintptr_t private,
+				    unsigned long private,
 				    const struct iio_chan_spec *chan,
 				    const char *buf, size_t len)
 {
@@ -421,7 +421,7 @@ static ssize_t ltc2688_dither_freq_avail(const struct ltc2688_state *st,
 }
 
 static ssize_t ltc2688_dither_freq_get(struct iio_dev *indio_dev,
-				       uintptr_t private,
+				       unsigned long private,
 				       const struct iio_chan_spec *chan,
 				       char *buf)
 {
@@ -446,7 +446,7 @@ static ssize_t ltc2688_dither_freq_get(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2688_dither_freq_set(struct iio_dev *indio_dev,
-				       uintptr_t private,
+				       unsigned long private,
 				       const struct iio_chan_spec *chan,
 				       const char *buf, size_t len)
 {
@@ -482,7 +482,7 @@ static ssize_t ltc2688_dither_freq_set(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2688_dac_input_read(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      char *buf)
 {
@@ -506,7 +506,7 @@ static ssize_t ltc2688_dac_input_read(struct iio_dev *indio_dev,
 }
 
 static ssize_t ltc2688_dac_input_write(struct iio_dev *indio_dev,
-				       uintptr_t private,
+				       unsigned long private,
 				       const struct iio_chan_spec *chan,
 				       const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/max22007.c b/drivers/iio/dac/max22007.c
index 182ac7155a89..0834f49840f2 100644
--- a/drivers/iio/dac/max22007.c
+++ b/drivers/iio/dac/max22007.c
@@ -275,7 +275,7 @@ static const struct iio_info max22007_info = {
 };
 
 static ssize_t max22007_read_dac_powerdown(struct iio_dev *indio_dev,
-					   uintptr_t private,
+					   unsigned long private,
 					   const struct iio_chan_spec *chan,
 					   char *buf)
 {
@@ -294,7 +294,7 @@ static ssize_t max22007_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t max22007_write_dac_powerdown(struct iio_dev *indio_dev,
-					    uintptr_t private,
+					    unsigned long private,
 					    const struct iio_chan_spec *chan,
 					    const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index e7e29359f8fe..6ce59516064b 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -77,7 +77,7 @@ static const struct iio_enum max5821_powerdown_mode_enum = {
 };
 
 static ssize_t max5821_read_dac_powerdown(struct iio_dev *indio_dev,
-					  uintptr_t private,
+					  unsigned long private,
 					  const struct iio_chan_spec *chan,
 					  char *buf)
 {
@@ -107,7 +107,7 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 }
 
 static ssize_t max5821_write_dac_powerdown(struct iio_dev *indio_dev,
-					   uintptr_t private,
+					   unsigned long private,
 					   const struct iio_chan_spec *chan,
 					   const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 23b9e3a09ec8..eef50058dc55 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -179,7 +179,7 @@ static int mcp4725_set_powerdown_mode(struct iio_dev *indio_dev,
 }
 
 static ssize_t mcp4725_read_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+	unsigned long private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct mcp4725_data *data = iio_priv(indio_dev);
 
@@ -187,7 +187,7 @@ static ssize_t mcp4725_read_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t mcp4725_write_powerdown(struct iio_dev *indio_dev,
-	 uintptr_t private, const struct iio_chan_spec *chan,
+	 unsigned long private, const struct iio_chan_spec *chan,
 	 const char *buf, size_t len)
 {
 	struct mcp4725_data *data = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
index 4f30b99110b7..7de6389e637e 100644
--- a/drivers/iio/dac/mcp4728.c
+++ b/drivers/iio/dac/mcp4728.c
@@ -236,7 +236,7 @@ static int mcp4728_set_powerdown_mode(struct iio_dev *indio_dev,
 }
 
 static ssize_t mcp4728_read_powerdown(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      char *buf)
 {
@@ -246,7 +246,7 @@ static ssize_t mcp4728_read_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t mcp4728_write_powerdown(struct iio_dev *indio_dev,
-				       uintptr_t private,
+				       unsigned long private,
 				       const struct iio_chan_spec *chan,
 				       const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index b218f0c3a0bd..05c77fad2579 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -626,7 +626,7 @@ static int mcp47feb02_set_powerdown_mode(struct iio_dev *indio_dev, const struct
 	return 0;
 }
 
-static ssize_t mcp47feb02_read_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t mcp47feb02_read_powerdown(struct iio_dev *indio_dev, unsigned long private,
 					 const struct iio_chan_spec *ch, char *buf)
 {
 	struct mcp47feb02_data *data = iio_priv(indio_dev);
@@ -635,7 +635,7 @@ static ssize_t mcp47feb02_read_powerdown(struct iio_dev *indio_dev, uintptr_t pr
 	return sysfs_emit(buf, "%d\n", data->chdata[ch->address].powerdown);
 }
 
-static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, unsigned long private,
 					  const struct iio_chan_spec *ch, const char *buf,
 					  size_t len)
 {
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index b860e18d52a1..2c4c5e2329e0 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -195,7 +195,7 @@ static int stm32_dac_set_powerdown_mode(struct iio_dev *indio_dev,
 }
 
 static ssize_t stm32_dac_read_powerdown(struct iio_dev *indio_dev,
-					uintptr_t private,
+					unsigned long private,
 					const struct iio_chan_spec *chan,
 					char *buf)
 {
@@ -208,7 +208,7 @@ static ssize_t stm32_dac_read_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
-					 uintptr_t private,
+					 unsigned long private,
 					 const struct iio_chan_spec *chan,
 					 const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
index 715870c8a9c4..51569e624f97 100644
--- a/drivers/iio/dac/ti-dac082s085.c
+++ b/drivers/iio/dac/ti-dac082s085.c
@@ -115,7 +115,7 @@ static const struct iio_enum ti_dac_powerdown_mode = {
 };
 
 static ssize_t ti_dac_read_powerdown(struct iio_dev *indio_dev,
-				     uintptr_t private,
+				     unsigned long private,
 				     const struct iio_chan_spec *chan,
 				     char *buf)
 {
@@ -125,7 +125,7 @@ static ssize_t ti_dac_read_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ti_dac_write_powerdown(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 455d61fc3f13..954c5e9bfe68 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -162,7 +162,7 @@ static const struct iio_enum dac5571_powerdown_mode = {
 };
 
 static ssize_t dac5571_read_powerdown(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      char *buf)
 {
@@ -172,7 +172,7 @@ static ssize_t dac5571_read_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
-				       uintptr_t private,
+				       unsigned long private,
 				       const struct iio_chan_spec *chan,
 				       const char *buf, size_t len)
 {
diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
index 5c1c5213962f..e1c381d107c6 100644
--- a/drivers/iio/dac/ti-dac7311.c
+++ b/drivers/iio/dac/ti-dac7311.c
@@ -104,7 +104,7 @@ static const struct iio_enum ti_dac_powerdown_mode = {
 };
 
 static ssize_t ti_dac_read_powerdown(struct iio_dev *indio_dev,
-				     uintptr_t private,
+				     unsigned long private,
 				     const struct iio_chan_spec *chan,
 				     char *buf)
 {
@@ -114,7 +114,7 @@ static ssize_t ti_dac_read_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ti_dac_write_powerdown(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      const char *buf, size_t len)
 {
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 3883b63dcc3c..6303260d9cca 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -260,7 +260,7 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 }
 
 static ssize_t adf4350_write(struct iio_dev *indio_dev,
-				    uintptr_t private,
+				    unsigned long private,
 				    const struct iio_chan_spec *chan,
 				    const char *buf, size_t len)
 {
@@ -320,7 +320,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
 }
 
 static ssize_t adf4350_read(struct iio_dev *indio_dev,
-				   uintptr_t private,
+				   unsigned long private,
 				   const struct iio_chan_spec *chan,
 				   char *buf)
 {
diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index d6dc7827fb41..0e0d002fe472 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -334,7 +334,7 @@ static int adf4371_set_freq(struct adf4371_state *st, unsigned long long freq,
 }
 
 static ssize_t adf4371_read(struct iio_dev *indio_dev,
-			    uintptr_t private,
+			    unsigned long private,
 			    const struct iio_chan_spec *chan,
 			    char *buf)
 {
@@ -377,7 +377,7 @@ static ssize_t adf4371_read(struct iio_dev *indio_dev,
 }
 
 static ssize_t adf4371_write(struct iio_dev *indio_dev,
-			     uintptr_t private,
+			     unsigned long private,
 			     const struct iio_chan_spec *chan,
 			     const char *buf, size_t len)
 {
diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index ce3a396624c3..4fea3c5a39c1 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -804,7 +804,7 @@ static int adf4377_init(struct adf4377_state *st)
 	return 0;
 }
 
-static ssize_t adf4377_read(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t adf4377_read(struct iio_dev *indio_dev, unsigned long private,
 			    const struct iio_chan_spec *chan, char *buf)
 {
 	struct adf4377_state *st = iio_priv(indio_dev);
@@ -823,7 +823,7 @@ static ssize_t adf4377_read(struct iio_dev *indio_dev, uintptr_t private,
 	}
 }
 
-static ssize_t adf4377_write(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t adf4377_write(struct iio_dev *indio_dev, unsigned long private,
 			     const struct iio_chan_spec *chan, const char *buf,
 			     size_t len)
 {
diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index b852378b3f68..10d52823220c 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -257,7 +257,7 @@ static int admv1013_write_raw(struct iio_dev *indio_dev,
 }
 
 static ssize_t admv1013_read(struct iio_dev *indio_dev,
-			     uintptr_t private,
+			     unsigned long private,
 			     const struct iio_chan_spec *chan,
 			     char *buf)
 {
@@ -286,7 +286,7 @@ static ssize_t admv1013_read(struct iio_dev *indio_dev,
 }
 
 static ssize_t admv1013_write(struct iio_dev *indio_dev,
-			      uintptr_t private,
+			      unsigned long private,
 			      const struct iio_chan_spec *chan,
 			      const char *buf, size_t len)
 {
diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index 25e8cd8135ad..320cafde3c9d 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -360,7 +360,7 @@ static int admv1014_write_raw(struct iio_dev *indio_dev,
 }
 
 static ssize_t admv1014_read(struct iio_dev *indio_dev,
-			     uintptr_t private,
+			     unsigned long private,
 			     const struct iio_chan_spec *chan,
 			     char *buf)
 {
@@ -402,7 +402,7 @@ static ssize_t admv1014_read(struct iio_dev *indio_dev,
 }
 
 static ssize_t admv1014_write(struct iio_dev *indio_dev,
-			      uintptr_t private,
+			      unsigned long private,
 			      const struct iio_chan_spec *chan,
 			      const char *buf, size_t len)
 {
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 1afd00763da9..4e73a2065dee 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -620,7 +620,7 @@ static struct iio_backend *iio_backend_from_indio_dev_parent(const struct device
  * RETURNS:
  * Number of bytes written to buf, negative error number on failure.
  */
-ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
+ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, unsigned long private,
 				 const struct iio_chan_spec *chan, char *buf)
 {
 	struct iio_backend *back;
@@ -656,7 +656,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_get, "IIO_BACKEND");
  * RETURNS:
  * Buffer length on success, negative error number on failure.
  */
-ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
+ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, unsigned long private,
 				 const struct iio_chan_spec *chan,
 				 const char *buf, size_t len)
 {
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 22eefd048ba9..eab4fb9a1413 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -522,7 +522,7 @@ static ssize_t iio_write_channel_ext_info(struct device *dev,
 }
 
 ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
-	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
+	unsigned long priv, const struct iio_chan_spec *chan, char *buf)
 {
 	const struct iio_enum *e = (const struct iio_enum *)priv;
 	unsigned int i;
@@ -545,7 +545,7 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
 EXPORT_SYMBOL_GPL(iio_enum_available_read);
 
 ssize_t iio_enum_read(struct iio_dev *indio_dev,
-	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
+	unsigned long priv, const struct iio_chan_spec *chan, char *buf)
 {
 	const struct iio_enum *e = (const struct iio_enum *)priv;
 	int i;
@@ -564,7 +564,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
 EXPORT_SYMBOL_GPL(iio_enum_read);
 
 ssize_t iio_enum_write(struct iio_dev *indio_dev,
-	uintptr_t priv, const struct iio_chan_spec *chan, const char *buf,
+	unsigned long priv, const struct iio_chan_spec *chan, const char *buf,
 	size_t len)
 {
 	const struct iio_enum *e = (const struct iio_enum *)priv;
@@ -598,7 +598,7 @@ static int iio_setup_mount_idmatrix(const struct device *dev,
 	return 0;
 }
 
-ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
+ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, unsigned long priv,
 			      const struct iio_chan_spec *chan, char *buf)
 {
 	const struct iio_mount_matrix *mtx;
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 4d99ae336f61..e4bc395cb330 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -522,7 +522,7 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 }
 
 static ssize_t ltr501_read_near_level(struct iio_dev *indio_dev,
-				      uintptr_t priv,
+				      unsigned long priv,
 				      const struct iio_chan_spec *chan,
 				      char *buf)
 {
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index a75a83594a7e..09dfd1921180 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -148,7 +148,7 @@ static const struct iio_event_spec stk3310_events[] = {
 };
 
 static ssize_t stk3310_read_near_level(struct iio_dev *indio_dev,
-				       uintptr_t priv,
+				       unsigned long priv,
 				       const struct iio_chan_spec *chan,
 				       char *buf)
 {
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 5e03c3d8874b..f1348218d196 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1587,7 +1587,7 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
 }
 
 static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
-					uintptr_t priv,
+					unsigned long priv,
 					const struct iio_chan_spec *chan,
 					char *buf)
 {
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index b742ca9a99d1..cc42b7bdcc09 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -175,7 +175,7 @@ static const struct iio_info mux_info = {
 	.write_raw = mux_write_raw,
 };
 
-static ssize_t mux_read_ext_info(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t mux_read_ext_info(struct iio_dev *indio_dev, unsigned long private,
 				 struct iio_chan_spec const *chan, char *buf)
 {
 	struct mux *mux = iio_priv(indio_dev);
@@ -195,7 +195,7 @@ static ssize_t mux_read_ext_info(struct iio_dev *indio_dev, uintptr_t private,
 	return ret;
 }
 
-static ssize_t mux_write_ext_info(struct iio_dev *indio_dev, uintptr_t private,
+static ssize_t mux_write_ext_info(struct iio_dev *indio_dev, unsigned long private,
 				  struct iio_chan_spec const *chan,
 				  const char *buf, size_t len)
 {
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index f69db6f2f380..718a49744a32 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -256,7 +256,7 @@ static u32 isl29501_register_write(struct isl29501_private *isl29501,
 }
 
 static ssize_t isl29501_read_ext(struct iio_dev *indio_dev,
-				 uintptr_t private,
+				 unsigned long private,
 				 const struct iio_chan_spec *chan,
 				 char *buf)
 {
@@ -378,7 +378,7 @@ static unsigned int isl29501_find_corr_exp(unsigned int val,
 }
 
 static ssize_t isl29501_write_ext(struct iio_dev *indio_dev,
-				  uintptr_t private,
+				  unsigned long private,
 				  const struct iio_chan_spec *chan,
 				  const char *buf, size_t len)
 {
diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index c7b2d03c23bc..3b2bc82b808c 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -174,7 +174,7 @@
 static const char * const sx9324_cs_pin_usage[] = { "HZ", "MI", "DS", "GD" };
 
 static ssize_t sx9324_phase_configuration_show(struct iio_dev *indio_dev,
-					       uintptr_t private,
+					       unsigned long private,
 					       const struct iio_chan_spec *chan,
 					       char *buf)
 {
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 3b9a3a6cbb25..702a2b4c32f8 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -669,7 +669,7 @@ static const struct iio_enum stm32_enable_mode_enum = {
 };
 
 static ssize_t stm32_count_get_preset(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      char *buf)
 {
@@ -682,7 +682,7 @@ static ssize_t stm32_count_get_preset(struct iio_dev *indio_dev,
 }
 
 static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
-				      uintptr_t private,
+				      unsigned long private,
 				      const struct iio_chan_spec *chan,
 				      const char *buf, size_t len)
 {
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 4d15c2a9802c..60bb2ae4724b 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -167,10 +167,10 @@ struct iio_backend_ops {
 			    struct iio_buffer *buffer);
 	int (*extend_chan_spec)(struct iio_backend *back,
 				struct iio_chan_spec *chan);
-	int (*ext_info_set)(struct iio_backend *back, uintptr_t private,
+	int (*ext_info_set)(struct iio_backend *back, unsigned long private,
 			    const struct iio_chan_spec *chan,
 			    const char *buf, size_t len);
-	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
+	int (*ext_info_get)(struct iio_backend *back, unsigned long private,
 			    const struct iio_chan_spec *chan, char *buf);
 	int (*interface_type_get)(struct iio_backend *back,
 				  enum iio_backend_interface_type *type);
@@ -242,10 +242,10 @@ int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
 int iio_backend_data_stream_disable(struct iio_backend *back);
 int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address);
-ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
+ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, unsigned long private,
 				 const struct iio_chan_spec *chan,
 				 const char *buf, size_t len);
-ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
+ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, unsigned long private,
 				 const struct iio_chan_spec *chan, char *buf);
 int iio_backend_interface_type_get(struct iio_backend *back,
 				   enum iio_backend_interface_type *type);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a9ecff191bd9..8c244cd4a28d 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -50,12 +50,12 @@ struct iio_dev;
 struct iio_chan_spec_ext_info {
 	const char *name;
 	enum iio_shared_by shared;
-	ssize_t (*read)(struct iio_dev *, uintptr_t private,
+	ssize_t (*read)(struct iio_dev *, unsigned long private,
 			struct iio_chan_spec const *, char *buf);
-	ssize_t (*write)(struct iio_dev *, uintptr_t private,
+	ssize_t (*write)(struct iio_dev *, unsigned long private,
 			 struct iio_chan_spec const *, const char *buf,
 			 size_t len);
-	uintptr_t private;
+	unsigned long private;
 };
 
 /**
@@ -82,11 +82,11 @@ struct iio_enum {
 };
 
 ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
-	uintptr_t priv, const struct iio_chan_spec *chan, char *buf);
+	unsigned long priv, const struct iio_chan_spec *chan, char *buf);
 ssize_t iio_enum_read(struct iio_dev *indio_dev,
-	uintptr_t priv, const struct iio_chan_spec *chan, char *buf);
+	unsigned long priv, const struct iio_chan_spec *chan, char *buf);
 ssize_t iio_enum_write(struct iio_dev *indio_dev,
-	uintptr_t priv, const struct iio_chan_spec *chan, const char *buf,
+	unsigned long priv, const struct iio_chan_spec *chan, const char *buf,
 	size_t len);
 
 /**
@@ -103,7 +103,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 	.shared = (_shared), \
 	.read = iio_enum_read, \
 	.write = iio_enum_write, \
-	.private = (uintptr_t)(_e), \
+	.private = (unsigned long)(_e), \
 }
 
 /**
@@ -120,7 +120,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 	.name = (_name "_available"), \
 	.shared = _shared, \
 	.read = iio_enum_available_read, \
-	.private = (uintptr_t)(_e), \
+	.private = (unsigned long)(_e), \
 }
 
 /**
@@ -132,7 +132,7 @@ struct iio_mount_matrix {
 	const char *rotation[9];
 };
 
-ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
+ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, unsigned long priv,
 			      const struct iio_chan_spec *chan, char *buf);
 int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix);
 
@@ -150,7 +150,7 @@ typedef const struct iio_mount_matrix *
 	.name = "mount_matrix", \
 	.shared = (_shared), \
 	.read = iio_show_mount_matrix, \
-	.private = (uintptr_t)(_get), \
+	.private = (unsigned long)(_get), \
 }
 
 /**
-- 
2.43.0
