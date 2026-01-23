Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707562EF66E
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200733; cv=none; b=HO1K9DfAu1zBEkgHrvAF4FykBBZ8xba03gqtEZR5BLniOwIZ3dRS0FpPLurpq/ymcIokT1tNufbN3o/yjVsHJqpAhyrJxtoOQ/lHaZQQ+EgKcszmPd1JUZrDC/Ej/NKrPeufGjEzU9UeFRevYfL00KgsPnw6bWKkNqUDQcuvg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200733; c=relaxed/simple;
	bh=O20ziRwhKmAnSP9ctsHkGnisWSjXJS1ux9ZdETkvqns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwZ2Dke6e25YPHvnPNTsi1tztjYMT3+zB2NLxGnuUaWF0otSvF3ITCEvMarjfOYltWfZH/zTVGFg9OU77ExG242ADvDQNRMOOw6q4UhXAFB5iX8/Y7+zHhZ+0L+TmKhDYGieZUfbQY3gEf+exGFRgAnFquyPRqG+IqIddfkluFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mfRb2TZM; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mfRb2TZM"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-4042fe53946so854091fac.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200728; x=1769805528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmX79GnzdywzPzH2+K8k/JNfqckElyoOXGWVtE/G7r0=;
        b=mfRb2TZMcu/lPqzyzfsw5M4yKbBcKWt5gSmVomJoiF7GuGC5xcx5hS4jDdnfj7tytY
         ihNc22/DHk8G+HfNoj3/UEzlHvZIhUT4qUt2/Dh/1qVhV3q42AveWkgDJeWFerDHmRDA
         evsS3d0BcZ8LUC3c6qwv1z3fvnzynw45u7hUHIkUwOzkTNBgXUOxvmlZOZqP5TZjgna4
         2rLGRHDiqfEFLx84ydMtLk0zczJwYxLhwF6QJS7zZusVkdSSrDMdl2aSIYLj5n+uui4L
         a6POlTONvKAMdEPqYCqiJPw7lyQSZ14nAvj5H4oObZajjvT/PQ2VbWc9OJwY8lly80nv
         UFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200728; x=1769805528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmX79GnzdywzPzH2+K8k/JNfqckElyoOXGWVtE/G7r0=;
        b=Fck1XyhsMkdIrOUXoGKQEzMs7QPmZSYsoEL3n38b36vC4VafGBH5WgLWT6xsH5aAsv
         bVUrNv8TTx0iw5ixFtvRdWbwC07DRGzP4Y/J5oV/NzGwBQVOWk17VNYJgxfBcW6+/VW0
         nmeWBs+XdutmPXtLG7VGDoyEPNHoL5kIAYHJ+6cznxoIaHiHKW6Ec/+5J7o7Y8MehuWB
         GNFh8fnve5LTyj7Q0mA9hOafMSejS+jfbAfEBfnaU5SsvQ3pLlKiPgR7jhwQjQ9gukSK
         kroGf6Ug6BFmecYkJ6KHJsBe2OeancEm0TsSRJ5h8W5Lmsq4Q02xkFlJlKPuTnJPi6XB
         Xmgg==
X-Forwarded-Encrypted: i=1; AJvYcCXUr7unIc8ZxgwnsvWQ2MhibI7oNq6z48sVYm8KaA7TlungIq3i59H0TmBprJljyt8W2tNIMt8vVr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNklLrCO7+oVVwGXpbeVgiu09ddrERyCi2nwu4JO+uIeBlOPdc
	PM8Ykz6SkoexZPY8J34CHODfvT/cMFtewFOrFLF1Fgu8HP0mwhfR60Hr7BDSUKfmPvc=
X-Gm-Gg: AZuq6aId4D985S5OMnRDYtGk5toGSTijoOziSyrj47IK8OEoIRHQG2oGfs2tz/J2oVT
	wY73hYe0QNosEJt3ayrWzs349b6XYQOrRIFB1/xxrRwIqfbZLk83eLmL6GxrKSgkbGe4+X8iIxk
	/dZAy5pdITTGMFd8ZQSczgq2FFdgKBzzlUMNjugcZMsy5ulWBd5QMewGKViRn3PR0vveb3x9tdF
	dU24/VcsrtS5tg0212a6QSyWU/XxzP5NqGWWVqJqzQDmX2PSFEo9fOxi/+D9PF0utgLQi6QIyly
	7JTHlZ5GoNXkFb9PLhoX8KVMH/KZNOwOGNMT9ISsTz7zlzT3INZJLIeeHT+xGqLCgJI4AKSrOuZ
	y70Rm4yhmlbQoWjAjmjzSvMetuQXQXpd5LSsLz3FDyI0YiCUk94ly9vM4gJpxau/MJoYZz4GVPP
	hirklt0eQpa8eOfLSCdonMUpdc
X-Received: by 2002:a05:6870:ac22:b0:3e8:3176:a342 with SMTP id 586e51a60fabf-408ab4fffdemr2009501fac.22.1769200727566;
        Fri, 23 Jan 2026 12:38:47 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:47 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:28 -0600
Subject: [PATCH v6 5/9] spi: Documentation: add page on multi-lane support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-5-12af183c06eb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8955; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=O20ziRwhKmAnSP9ctsHkGnisWSjXJS1ux9ZdETkvqns=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9wqO06xg6Gv9V7NIzeqeI+yHWovm7g6//+Km
 /CjYq8yIb6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcKgAKCRDCzCAB/wGP
 wEX0CACDUlrSXSQQrT8YI6wCrnl/g5281Wzf1uIzVnQiRSpt+2z8h06M/wqpOLVoTMwJCv+Xdo4
 Ys9+rw9ELNHoUcTOwWXZT26XZIWOW81wqYAj4DQrJEauin+WvKIaAb0G32MF62OCeHBLPwHDUl7
 09luXjPNI2st81Cmxhw2TvHum9LXqcsgJfPsR82+xsI6IFqA/wJCiq8e4eoIdY6q7RRoehSvuMS
 5nm3Au3tOA5ODP07aPczyqTd5qNzKvTTlU8u+zYKDW32s1WLqeJm4YAerFrQfd2lEJl1lgOrtZP
 x303RGtPHWV3XWqETvfGseVAJm9MBxHrCKxzs34w+TJDl7IE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new page to Documentation/spi/ describing how multi-lane SPI
support works. This is uncommon functionality so it deserves its own
documentation page.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Fix copy/paste typo of wrong property names.

v5 changes:
* Fix tx/rx typo in stripe mode example.

v4 changes:
* New patch in v4.
---
 Documentation/spi/index.rst               |   1 +
 Documentation/spi/multiple-data-lanes.rst | 217 ++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
index 824ce42ed4f0..2c89b1ee39e2 100644
--- a/Documentation/spi/index.rst
+++ b/Documentation/spi/index.rst
@@ -9,6 +9,7 @@ Serial Peripheral Interface (SPI)
 
    spi-summary
    spidev
+   multiple-data-lanes
    butterfly
    spi-lm70llp
    spi-sc18is602
diff --git a/Documentation/spi/multiple-data-lanes.rst b/Documentation/spi/multiple-data-lanes.rst
new file mode 100644
index 000000000000..69cb532d052f
--- /dev/null
+++ b/Documentation/spi/multiple-data-lanes.rst
@@ -0,0 +1,217 @@
+====================================
+SPI devices with multiple data lanes
+====================================
+
+Some specialized SPI controllers and peripherals support multiple data lanes
+that allow reading more than one word at a time in parallel. This is different
+from dual/quad/octal SPI where multiple bits of a single word are transferred
+simultaneously.
+
+For example, controllers that support parallel flash memories have this feature
+as do some simultaneous-sampling ADCs where each channel has its own data lane.
+
+---------------------
+Describing the wiring
+---------------------
+
+The ``spi-tx-bus-width`` and ``spi-rx-bus-width`` properties in the devicetree
+are used to describe how many data lanes are connected between the controller
+and how wide each lane is. The number of items in the array indicates how many
+lanes there are, and the value of each item indicates how many bits wide that
+lane is.
+
+For example, a dual-simultaneous-sampling ADC with two 4-bit lanes might be
+wired up like this::
+
+    +--------------+    +----------+
+    | SPI          |    | AD4630   |
+    | Controller   |    | ADC      |
+    |              |    |          |
+    |          CS0 |--->| CS       |
+    |          SCK |--->| SCK      |
+    |          SDO |--->| SDI      |
+    |              |    |          |
+    |        SDIA0 |<---| SDOA0    |
+    |        SDIA1 |<---| SDOA1    |
+    |        SDIA2 |<---| SDOA2    |
+    |        SDIA3 |<---| SDOA3    |
+    |              |    |          |
+    |        SDIB0 |<---| SDOB0    |
+    |        SDIB1 |<---| SDOB1    |
+    |        SDIB2 |<---| SDOB2    |
+    |        SDIB3 |<---| SDOB3    |
+    |              |    |          |
+    +--------------+    +----------+
+
+It is described in a devicetree like this::
+
+    spi {
+        compatible = "my,spi-controller";
+
+        ...
+
+        adc@0 {
+            compatible = "adi,ad4630";
+            reg = <0>;
+            ...
+            spi-rx-bus-width = <4>, <4>; /* 2 lanes of 4 bits each */
+            ...
+        };
+    };
+
+In most cases, lanes will be wired up symmetrically (A to A, B to B, etc). If
+this isn't the case, extra ``spi-rx-lane-map`` and ``spi-tx-lane-map``
+properties are needed to provide a mapping between controller lanes and the
+physical lane wires.
+
+Here is an example where a multi-lane SPI controller has each lane wired to
+separate single-lane peripherals::
+
+    +--------------+    +----------+
+    | SPI          |    | Thing 1  |
+    | Controller   |    |          |
+    |              |    |          |
+    |          CS0 |--->| CS       |
+    |         SDO0 |--->| SDI      |
+    |         SDI0 |<---| SDO      |
+    |        SCLK0 |--->| SCLK     |
+    |              |    |          |
+    |              |    +----------+
+    |              |
+    |              |    +----------+
+    |              |    | Thing 2  |
+    |              |    |          |
+    |          CS1 |--->| CS       |
+    |         SDO1 |--->| SDI      |
+    |         SDI1 |<---| SDO      |
+    |        SCLK1 |--->| SCLK     |
+    |              |    |          |
+    +--------------+    +----------+
+
+This is described in a devicetree like this::
+
+    spi {
+        compatible = "my,spi-controller";
+
+        ...
+
+        thing1@0 {
+            compatible = "my,thing1";
+            reg = <0>;
+            ...
+        };
+
+        thing2@1 {
+            compatible = "my,thing2";
+            reg = <1>;
+            ...
+            spi-tx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for tx wire */
+            spi-rx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for rx wire */
+            ...
+        };
+    };
+
+
+The default values of ``spi-rx-bus-width`` and ``spi-tx-bus-width`` are ``<1>``,
+so these properties can still be omitted even when ``spi-rx-lane-map`` and
+``spi-tx-lane-map`` are used.
+
+----------------------------
+Usage in a peripheral driver
+----------------------------
+
+These types of SPI controllers generally do not support arbitrary use of the
+multiple lanes. Instead, they operate in one of a few defined modes. Peripheral
+drivers should set the :c:type:`struct spi_transfer.multi_lane_mode <spi_transfer>`
+field to indicate which mode they want to use for a given transfer.
+
+The possible values for this field have the following semantics:
+
+- :c:macro:`SPI_MULTI_BUS_MODE_SINGLE`: Only use the first lane. Other lanes are
+    ignored. This means that it is operating just like a conventional SPI
+    peripheral. This is the default, so it does not need to be explicitly set.
+
+    Example::
+
+        tx_buf[0] = 0x88;
+
+        struct spi_transfer xfer = {
+            .tx_buf = tx_buf,
+            .len = 1,
+        };
+
+        spi_sync_transfer(spi, &xfer, 1);
+
+    Assuming the controller is sending the MSB first, the sequence of bits
+    sent over the tx wire would be (right-most bit is sent first)::
+
+        controller    > data bits >     peripheral
+        ----------   ----------------   ----------
+            SDO 0    0-0-0-1-0-0-0-1    SDI 0
+
+- :c:macro:`SPI_MULTI_BUS_MODE_MIRROR`: Send a single data word over all of the
+    lanes at the same time. This only makes sense for writes and not
+    for reads.
+
+    Example::
+
+        tx_buf[0] = 0x88;
+
+        struct spi_transfer xfer = {
+            .tx_buf = tx_buf,
+            .len = 1,
+            .multi_lane_mode = SPI_MULTI_BUS_MODE_MIRROR,
+        };
+
+        spi_sync_transfer(spi, &xfer, 1);
+
+    The data is mirrored on each tx wire::
+
+        controller    > data bits >     peripheral
+        ----------   ----------------   ----------
+            SDO 0    0-0-0-1-0-0-0-1    SDI 0
+            SDO 1    0-0-0-1-0-0-0-1    SDI 1
+
+- :c:macro:`SPI_MULTI_BUS_MODE_STRIPE`: Send or receive two different data words
+    at the same time, one on each lane. This means that the buffer needs to be
+    sized to hold data for all lanes. Data is interleaved in the buffer, with
+    the first word corresponding to lane 0, the second to lane 1, and so on.
+    Once the last lane is used, the next word in the buffer corresponds to lane
+    0 again. Accordingly, the buffer size must be a multiple of the number of
+    lanes. This mode works for both reads and writes.
+
+    Example::
+
+        struct spi_transfer xfer = {
+            .rx_buf = rx_buf,
+            .len = 2,
+            .multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE,
+        };
+
+        spi_sync_transfer(spi, &xfer, 1);
+
+    Each rx wire has a different data word sent simultaneously::
+
+        controller    < data bits <     peripheral
+        ----------   ----------------   ----------
+            SDI 0    0-0-0-1-0-0-0-1    SDO 0
+            SDI 1    1-0-0-0-1-0-0-0    SDO 1
+
+    After the transfer, ``rx_buf[0] == 0x11`` (word from SDO 0) and
+    ``rx_buf[1] == 0x88`` (word from SDO 1).
+
+
+-----------------------------
+SPI controller driver support
+-----------------------------
+
+To support multiple data lanes, SPI controller drivers need to set
+:c:type:`struct spi_controller.num_data_lanes <spi_controller>` to a value
+greater than 1.
+
+Then the part of the driver that handles SPI transfers needs to check the
+:c:type:`struct spi_transfer.multi_lane_mode <spi_transfer>` field and implement
+the appropriate behavior for each supported mode and return an error for
+unsupported modes.
+
+The core SPI code should handle the rest.

-- 
2.43.0

