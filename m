Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117980;
	b=UAJiSmN1AKU6Xc8OJDCqAC8Sbn0oulrOv1rLKxHeL5NK50UnK+oA0lAn1s2HRiTH5mUh
	 zMmmqyzwXEmq+FaRTDpIf2tVo1yww618W/kAZC3OeSfAiGez6Hu276/ZtN68vYDqoKDJG
	 xOxoqAw5fQBeQDnm6ynm57tHS90My6EAOoT+uydRTVTyPzNT47z3C9vM+TAX+u08kXxbT
	 U/Oj6LFKThi0I2BqdsfRSq8Vjf7rzWfBfyrTBYNBAhslbooTjT2CfaNV08XwdfCx9U6ph
	 cts3EVyyAoOmCHOcJMnc3Rn8h7mKG4POq2ODz6s3a3SdxOblM2ygjkoliXdkN8GlX5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117980;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MWPKwF8PkmGMpTVndrcj2+qEF6Pn4yAVOtzdN5EuWhQ=;
	b=PgnlGGqxNNIQm7VMjgZ979NzEZgFmJv8FDlmhPgWy5rDlESjB3sAriRyk+NkfMT/UZhk
	 GJ/cBdulfSekFPMlES++pl4x2OlrVZUNfbvTgIIF+sBX38ai9gl7hvu6ccMH5iC5tE2yB
	 pQekBWBS5GtySWpkBPXrtgejm3WJ/QEtT4GwSByTPRfw+q5zVjuRuK2XAbMziRFWBsmqg
	 aLPbyqcN+7ihiUZzoxp3FNn4ubw2BTrLerdCKjFlN1cNSLl30BWe1hkR8KdbxGF58bnU8
	 l9hbXoEYg3nsljgMvtlAmDADOsgl7CB6eTkH85ppUeFDMkrhLDa/rrBzfu7h1vME+kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mnykeYUP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657560A2639;
	Tue, 27 Oct 2026 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mnykeYUP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0660F1F031E6;
	Tue, 27 Oct 2026 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117979;
	bh=MWPKwF8PkmGMpTVndrcj2+qEF6Pn4yAVOtzdN5EuWhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mnykeYUPmsqxxP4u9s8Fg+l6eHZ3QGPZMjjfJTvGUmsSTJy9NGtarBJ5Qz85Djpiv
	 jMTZwbb2UZTPmb1X1KntagYqalJZsBR66dDWCE1mNavACq1O1qU7BN6d6IKmpl2sul
	 Zb3fVUNbtPz4SksR2+1TpRxgAmqMCAXgF4vuhDDI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:12 +0100
Subject: [PATCH 08/15] iio: light: apds9306: push events to the IIO device
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
Message-Id: <20261027-llm-char-misc-iio-v1-8-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=SYcVlvYb88RSPohL+loEyOrPdvazM4viWT/6N5kyNNM=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjPNvLxzxaXfCw2OFCrOFL/59eHk9uccQd9TizJal
 79Yd0p4c0csC4MgE4OsmCLLl208R/dXHFL0MrQ9DTOHlQlkCAMXpwBMRLqDYX645I4vWSxvV+os
 j/x0msWmQ/bQQieGeWpXdtxhXP/ljVnX89IL9Ye+3Lu8qwYA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

Reading a light channel while threshold events are enabled can push an
event through a pointer that is not an IIO device, corrupting memory or
crashing the kernel.

apds9306_read_data() derives indio_dev with dev_to_iio_dev(data->dev),
but data->dev is the I2C client's device, not the device embedded in
struct iio_dev. When the status register read by the poll loop has
APDS9306_ALS_INT_STAT_MASK set, the bogus pointer is passed to
iio_push_event() and iio_get_time_ns(), which dereference the event
interface and clock id of a structure that does not exist.

The bug was found by code inspection and has not been reproduced.

Fix by taking the IIO device from the I2C client's driver data, which
probe sets with i2c_set_clientdata().

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Cc: stable <stable@kernel.org>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/apds9306.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 7dd41136734f..79138422221d 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -462,7 +462,7 @@ static int apds9306_power_state(struct apds9306_data *data, bool state)
 static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 {
 	struct device *dev = data->dev;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct apds9306_regfields *rf = &data->rf;
 	u64 ev_code;
 	int ret, delay, intg_time, intg_time_idx, repeat_rate_idx, int_src;

-- 
2.56.0

