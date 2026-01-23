Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9A2EDD45
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200732; cv=none; b=VhgbxiuXGIDUYnhfjsF+aYO3cXWB2ELlxet8Eewhym9kR6Cr0NzanHZldwtAiGHaFRTuRvxTyVHlSu6ro48M6wj2md+Ko7ggEQLdY8UNY1jBOyTDS5M3BmuKUg1r5cgDtSpE8nQiabpqJMR+r/UZISfg+ykQjaukOjjzTGxmLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200732; c=relaxed/simple;
	bh=LhhC/BLfQqXEBBBTB1yvmvgOHIE7YTE8dHc8kwu+3IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgGNjmka4TRArzKikN5EIDlnhLem3XSivfOYd4ZINulSGpyoETB80yB9AsKfwY6M1Z5lLXNOmSGgqj/s0RpaHeGBcyIig7RYBzIqmuHJhqTVj6Iza2eWQQXNU76LZX1ozIlXRtOWTwff6c3p8PBDRWhAZHCGYenmbC/mOJvZbDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LCsBmRcp; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LCsBmRcp"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4044d3ff57bso805036fac.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200726; x=1769805526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gap8Ic9mJCJ2EUZ4fRDAE5T4Vxf5aGNigPWsuyzfbU=;
        b=LCsBmRcpUII5JGSNiqsXYUpTfF8wrYhUsZLKiwrqZj6AVyOaa/E+HVi6x66ilvNGQA
         Xov/PthRvFi53aNz/zRNh4S2crF8a+R6gLOPvnrdLYDU3e/q58CBW0OC1ghFHfULpQEk
         0vSjdypRtEuHtYsBzZ7F2R+3zNu3xZQ9k04/Xd3uAqVfClLBAhOREtvmSA+tH4jZAhFp
         gVn8MekVQxVQy8RxNirDc67SGLHtVoGq1OVJrRGMlIkZkvc0217vG7PLaVJ21FZK4d4E
         rvQhAUhXev3RsNgDs/Pb2E+FL2iQuvyepMJ57f5U5ybpVgapjHL/iytjm7yJ4pwGiawk
         fzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200726; x=1769805526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7gap8Ic9mJCJ2EUZ4fRDAE5T4Vxf5aGNigPWsuyzfbU=;
        b=WLH/3WldK6k/fLAL1l6ViRiULLtFBpSIEB6tXEH8u1uz0hFYuV6xuqLy+Z91YO6QA4
         7H8p8NdJVTpDiySv2TlpfzVEjVwVzw0m58/7hsNegI+tXvOiIp0B96b4DM5ye2/FYRbh
         9MCDJz8JFNXLB66xl106gdxLC1XucngValwFXhzQ31jB3md87I/ZaPIr7qm+Yo8pBZCR
         GMnDFan2cTozv6in6zwYdGg8JWRhKPP8LbgqrcG243xb1lfe4uxdS6RoJOHMAAbqI3FN
         c/5D41p61rfJUw1HjbSwMBjMDbtBxVBXA9JSL3jzJrHJFmFA/elXoa3KpFXf/HYKsV+q
         iGIw==
X-Forwarded-Encrypted: i=1; AJvYcCUoXhlv+esie80QcVlHXGhvYo+LinGKEHTCqigemKSqf5ke7Qn4XZ4PaGwdDUwO+KodJfF3daoIYFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAun1WzFdT4jOHy5pwS9BjMT2/4psrpPIJrf2Tn13vQe2ZbcRg
	LiWIbQR4WF6+sBgcgrICwhuOmKif0bvLIWt8+1RBF/DZq2I+B+/nywK+wZpuXywGLe8=
X-Gm-Gg: AZuq6aK8xwjfklbWKPNLD4psKDetHWzn9BhkkIFOdSH4AzPD1oo3nUrZ6TXpgI+uPwO
	uSggsLPehXCuZGBn7bwZ5GEZb7JcERYzejUwK9f7iBH7WzD/kGy8DdLQQIpCNeB0W7fbAlOizP7
	SZSpaaG+exYw4S6Ae4euD/ZNarkyQt3qkSH57OeSOAd+R0nGpDFrzImSp2rhH5iK85WpDOG4ihu
	MJl7+GvuZqcNPwWpB4OEEe4e+MIcajEjRBozwl2XGkOlYZzjvdFzejc0p/UF/MCA1Eu1lkesab1
	qF+LDKbmnpD+n8bH9vpFRIcpzH1LfDmOUqv0OZ+ttBnJJC8H2yNK7k9mTHSp5Uzi/sS6NiMtkOt
	uGoZPrzOGsgfyBfcYtSIwo/vu/KO3SYauohkgPrfJUFx+IZvZCk1MamH5AHbkm+UdAz+ZPdyvG0
	THTpgNn4MV1eOWPA==
X-Received: by 2002:a05:6871:5225:b0:404:3805:1dde with SMTP id 586e51a60fabf-408ab3b3b5cmr2292518fac.8.1769200724771;
        Fri, 23 Jan 2026 12:38:44 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:26 -0600
Subject: [PATCH v6 3/9] spi: support controllers with multiple data lanes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-3-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10712;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=LhhC/BLfQqXEBBBTB1yvmvgOHIE7YTE8dHc8kwu+3IM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9wd27hUzKHTrSuRuTHG4+NYWPJ2gy3erffLx
 6p9md6dnECJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcHQAKCRDCzCAB/wGP
 wAodB/0b1Wp207Kf5a/+HihKEQXAvlHY+3opEv0f98N9Cs5JK6gOU0k3pK7YveR2vr9TDMXVpK/
 JhQmiwYWIp0NfNFIIQpHexCRN/4lOQqDtfATkLKsJteZN5K8vdNWcmVvAqJ4dSL4BYKyzp/xwAC
 9oQ0bNAcFiHoMhauMO73Lx0R9nUh7VfDTdYBf7jS67BRiH4YwnI1xFKfiNr1r+bO7vPDCAmuFig
 YUko+zSdzBJt8RP3B1HyDvNTnzMjbm6RUI3P98XvvgfcYP5DrZDLL8/ybQzCUI8you/kylMPhHU
 xpm0Y51DbWemtuTKfQQoWgJTUB0ZPwW3Px1U9KcVzQJBljy1
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for SPI controllers with multiple physical SPI data lanes.
(A data lane in this context means lines connected to a serializer, so a
controller with two data lanes would have two serializers in a single
controller).

This is common in the type of controller that can be used with parallel
flash memories, but can be used for general purpose SPI as well.

To indicate support, a controller just needs to set ctlr->num_data_lanes
to something greater than 1. Peripherals indicate which lane they are
connected to via device tree (ACPI support can be added if needed).

The spi-{tx,rx}-bus-width DT properties can now be arrays. The length of
the array indicates the number of data lanes, and each element indicates
the bus width of that lane. For now, we restrict all lanes to have the
same bus width to keep things simple. Support for an optional controller
lane mapping property is also implemented.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
- Use u8 instead of u32 for new fields in in struct spi_device to save
  memory.
- Add additional checking to ensure that the data lane map has at least
  as many entries as there are data lanes.
- Don't ignore error return from of_property_read_u32_index() (even
  though it shouldn't be technically possible to happen - that is why
  it just returns and doesn't have dev_err()).

v5 changes:
- Use of_property_read_variable_u32_array() for lane maps.

v4 changes:
- Update for changes in devicetree bindings.
- Don't put new fields in the middle of CS fields.
- Dropped acks since this was a significant rework.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

This patch has been seen in a different series [1] by Sean before:

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-4-sean.anderson@linux.dev/

Changes:
* Use u8 array instead of bitfield so that the order of the mapping is
  preserved. (Now looks very much like chip select mapping.)
* Added doc strings for added fields.
* Tweaked the comments.
---
 drivers/spi/spi.c       | 144 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/spi/spi.h |  22 ++++++++
 2 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 170b0f3a2156..3887fcf8ec86 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2354,8 +2354,8 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value, cs[SPI_DEVICE_CS_CNT_MAX];
-	int rc, idx;
+	u32 value, cs[SPI_DEVICE_CS_CNT_MAX], map[SPI_DEVICE_DATA_LANE_CNT_MAX];
+	int rc, idx, max_num_data_lanes;
 
 	/* Mode (clock phase/polarity/etc.) */
 	if (of_property_read_bool(nc, "spi-cpha"))
@@ -2370,7 +2370,65 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_CS_HIGH;
 
 	/* Device DUAL/QUAD mode */
-	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
+
+	rc = of_property_read_variable_u32_array(nc, "spi-tx-lane-map", map, 1,
+						 ARRAY_SIZE(map));
+	if (rc >= 0) {
+		max_num_data_lanes = rc;
+		for (idx = 0; idx < max_num_data_lanes; idx++)
+			spi->tx_lane_map[idx] = map[idx];
+	} else if (rc == -EINVAL) {
+		/* Default lane map is identity mapping. */
+		max_num_data_lanes = ARRAY_SIZE(spi->tx_lane_map);
+		for (idx = 0; idx < max_num_data_lanes; idx++)
+			spi->tx_lane_map[idx] = idx;
+	} else {
+		dev_err(&ctlr->dev,
+			"failed to read spi-tx-lane-map property: %d\n", rc);
+		return rc;
+	}
+
+	rc = of_property_count_u32_elems(nc, "spi-tx-bus-width");
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-tx-bus-width property: %d\n", rc);
+		return rc;
+	}
+	if (rc > max_num_data_lanes) {
+		dev_err(&ctlr->dev,
+			"spi-tx-bus-width has more elements (%d) than spi-tx-lane-map (%d)\n",
+			rc, max_num_data_lanes);
+		return -EINVAL;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is not present. */
+		spi->num_tx_lanes = 1;
+	} else {
+		u32 first_value;
+
+		spi->num_tx_lanes = rc;
+
+		for (idx = 0; idx < spi->num_tx_lanes; idx++) {
+			rc = of_property_read_u32_index(nc, "spi-tx-bus-width",
+							idx, &value);
+			if (rc)
+				return rc;
+
+			/*
+			 * For now, we only support all lanes having the same
+			 * width so we can keep using the existing mode flags.
+			 */
+			if (!idx)
+				first_value = value;
+			else if (first_value != value) {
+				dev_err(&ctlr->dev,
+					"spi-tx-bus-width has inconsistent values: first %d vs later %d\n",
+					first_value, value);
+				return -EINVAL;
+			}
+		}
+
 		switch (value) {
 		case 0:
 			spi->mode |= SPI_NO_TX;
@@ -2394,7 +2452,74 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
-	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
+	for (idx = 0; idx < spi->num_tx_lanes; idx++) {
+		if (spi->tx_lane_map[idx] >= spi->controller->num_data_lanes) {
+			dev_err(&ctlr->dev,
+				"spi-tx-lane-map has invalid value %d (num_data_lanes=%d)\n",
+				spi->tx_lane_map[idx],
+				spi->controller->num_data_lanes);
+			return -EINVAL;
+		}
+	}
+
+	rc = of_property_read_variable_u32_array(nc, "spi-rx-lane-map", map, 1,
+						 ARRAY_SIZE(map));
+	if (rc >= 0) {
+		max_num_data_lanes = rc;
+		for (idx = 0; idx < max_num_data_lanes; idx++)
+			spi->rx_lane_map[idx] = map[idx];
+	} else if (rc == -EINVAL) {
+		/* Default lane map is identity mapping. */
+		max_num_data_lanes = ARRAY_SIZE(spi->rx_lane_map);
+		for (idx = 0; idx < max_num_data_lanes; idx++)
+			spi->rx_lane_map[idx] = idx;
+	} else {
+		dev_err(&ctlr->dev,
+			"failed to read spi-rx-lane-map property: %d\n", rc);
+		return rc;
+	}
+
+	rc = of_property_count_u32_elems(nc, "spi-rx-bus-width");
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-rx-bus-width property: %d\n", rc);
+		return rc;
+	}
+	if (rc > max_num_data_lanes) {
+		dev_err(&ctlr->dev,
+			"spi-rx-bus-width has more elements (%d) than spi-rx-lane-map (%d)\n",
+			rc, max_num_data_lanes);
+		return -EINVAL;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is not present. */
+		spi->num_rx_lanes = 1;
+	} else {
+		u32 first_value;
+
+		spi->num_rx_lanes = rc;
+
+		for (idx = 0; idx < spi->num_rx_lanes; idx++) {
+			rc = of_property_read_u32_index(nc, "spi-rx-bus-width",
+							idx, &value);
+			if (rc)
+				return rc;
+
+			/*
+			 * For now, we only support all lanes having the same
+			 * width so we can keep using the existing mode flags.
+			 */
+			if (!idx)
+				first_value = value;
+			else if (first_value != value) {
+				dev_err(&ctlr->dev,
+					"spi-rx-bus-width has inconsistent values: first %d vs later %d\n",
+					first_value, value);
+				return -EINVAL;
+			}
+		}
+
 		switch (value) {
 		case 0:
 			spi->mode |= SPI_NO_RX;
@@ -2418,6 +2543,16 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
+	for (idx = 0; idx < spi->num_rx_lanes; idx++) {
+		if (spi->rx_lane_map[idx] >= spi->controller->num_data_lanes) {
+			dev_err(&ctlr->dev,
+				"spi-rx-lane-map has invalid value %d (num_data_lanes=%d)\n",
+				spi->rx_lane_map[idx],
+				spi->controller->num_data_lanes);
+			return -EINVAL;
+		}
+	}
+
 	if (spi_controller_is_target(ctlr)) {
 		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
@@ -3066,6 +3201,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->add_lock);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
+	ctlr->num_data_lanes = 1;
 	ctlr->target = target;
 	if (IS_ENABLED(CONFIG_SPI_SLAVE) && target)
 		ctlr->dev.class = &spi_target_class;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8bc616b00343..ec8a03ee0d4c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,9 @@
 /* Max no. of CS supported per spi device */
 #define SPI_DEVICE_CS_CNT_MAX 4
 
+/* Max no. of data lanes supported per spi device */
+#define SPI_DEVICE_DATA_LANE_CNT_MAX 8
+
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
@@ -174,6 +177,10 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
  *	(optional, NULL when not using a GPIO line)
+ * @tx_lane_map: Map of peripheral lanes (index) to controller lanes (value).
+ * @num_tx_lanes: Number of transmit lanes wired up.
+ * @rx_lane_map: Map of peripheral lanes (index) to controller lanes (value).
+ * @num_rx_lanes: Number of receive lanes wired up.
  *
  * A @spi_device is used to interchange data between an SPI target device
  * (usually a discrete chip) and CPU memory.
@@ -242,6 +249,12 @@ struct spi_device {
 
 	struct gpio_desc	*cs_gpiod[SPI_DEVICE_CS_CNT_MAX];	/* Chip select gpio desc */
 
+	/* Multi-lane SPI controller support. */
+	u8			tx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
+	u8			num_tx_lanes;
+	u8			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
+	u8			num_rx_lanes;
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -401,6 +414,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	SPI targets, and are numbered from zero to num_chipselects.
  *	each target has a chipselect signal, but it's common that not
  *	every chipselect is connected to a target.
+ * @num_data_lanes: Number of data lanes supported by this controller. Default is 1.
  * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @mode_bits: flags understood by this controller driver
  * @buswidth_override_bits: flags to override for this controller driver
@@ -576,6 +590,14 @@ struct spi_controller {
 	 */
 	u16			num_chipselect;
 
+	/*
+	 * Some specialized SPI controllers can have more than one physical
+	 * data lane interface per controller (each having it's own serializer).
+	 * This specifies the number of data lanes in that case. Other
+	 * controllers do not need to set this (defaults to 1).
+	 */
+	u16			num_data_lanes;
+
 	/* Some SPI controllers pose alignment requirements on DMAable
 	 * buffers; let protocol drivers know about these requirements.
 	 */

-- 
2.43.0

