Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61BE244694
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148440; cv=none; b=HG/xYIu7QJg1AvkbhPmcpRmYgNwcZMGNfVDA77s9TyrrREKULMZCtBPSATdCaQdYXQ34vwRqLOrm/TeXFZ9/Spt9+h3p9gucZaHCPAsQgFH1tCrdw9fzRlBNpjwxirgdA70qL3HjR6FpS4eG7wRd++IWgKiyTzExNQnaExi6ZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148440; c=relaxed/simple;
	bh=ESa4zgB82WDyEdoFZl9mN7qSJr3JEOf6jr0xy6ffzxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtMrrO1It3bYHrhrwwyHM5syHGk+NH8SViypqZBbAtozQuVD8Los/Oeu+fzdeWjDqPcRH9TjwGD0jUKM490toYxLuZKQL5b1u8SwMrjjamOrW590Gjr5uTz540iMVmTqiy0SG25uq/vXptKMZY3fGkUQ95slMdLaxMqbob7GB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=j2Ozjz3w; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="j2Ozjz3w"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb64085c45so112796a34.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 17:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786148438; x=1786753238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hwqpzP24UA2fHMTxYLSqDw69rK/fygGat0tgP1v59qc=;
        b=j2Ozjz3w6czFxiX7H2hMRiFOfVV/UKvJgFYAKBr2qtBlU8m0dT2IWQgUnBpcuFMLlh
         MvlyGKx0wQy5j3hBsSxFrQfuUHY/1RoIXUv7nRxR6DB9ZBYFqfgNWbL2DbRkB6pHHuj8
         pIAjYg/aX014Y16ypuAoS28wMfzTKsFqCjGC0ua5Vukd7IWIaq+EdCeuMHWTFLMOWLz9
         sEEcaq2bA59MBBenZIXRzLQ0a+glBz0a89nJJ2CYInUrqnyVvuHpvPIhf+I4mA21l+WV
         SfORAKcC1nx76+koaiDof47MDzKGvHwgze4K92OTCdAnzOg0sFXoI6Rur3M26oR4MnVD
         tC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148438; x=1786753238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hwqpzP24UA2fHMTxYLSqDw69rK/fygGat0tgP1v59qc=;
        b=E0D1xAiKO0dGcElCsS0ehpBjIPQse9ZLGfpYrA0mzcI891sCYxRphvecRmeFl6gmPs
         1erv7wq+O1xnU5XyXBOQeErSzXczHM+9WjaPy/pGWRMGTXlc5/qJsAeXK5AS+Ye7YJdA
         RxESN8YaHvWAOCL8KCxWy8EDgzhgFvtbT2m82QiC4cXolG/q2WaASbA7UZ4H9OfNIEhe
         8MY1mjAgz/hTHrluXxf6V3jq8x7yKTY6PFkGSDZs+mWmXH9a1uxhOEDiOJZtsiViPFAa
         OnmXz83/gACewcpzRimkjaCBIJ1KmjCTzRk1Z5kep5DLWxg/5owh1PBj2CXYu3kDY+S1
         w/2g==
X-Gm-Message-State: AOJu0YylhIYA0IKGfMLPhXytx0qSQd9/RtV9aIKG7AGK6w1Q35KkevRi
	h0wcRRoNtljJsjbCQ3ZtTACt0d739fboN84H0cqKFuZfSJpsh85UPvuxiCixebpiCpUiC9hKDRN
	BbTKCcPI=
X-Gm-Gg: AR+sD105kK0JyAaW4E5jgGfR7T6rkX92/IJp9hVMb10PehrHw4PBe4n7OsGYQ4sIopx
	s0UdjBRzBTHHgM7R7HOSTgEd+UjKG84aSRPHOaSPUKrPqTY0JXs4DQpZ8tr4nVlcYbb5wZJerz1
	EawzOgTaUeNmhIvs0sX21MvRK/pTshjmUYDUDTOd56qqQJt3naQW9W06enM01iX7EoJXtQE8Bog
	JaJJ7Ub62YecyfLuFVuFjfjEIIRqkkiIUVJgjraMrgV4Mi4bHx2iCOgmLlk2QJzl7xku0bK3fmB
	rNAi2wEwWZWyFJ/kJxANuWMomsYWez6V/lvGqf0MpZ+m6QpmBG+6G/7yRO6eVd1Ne89Wjg441T3
	O5yYrf/pUJ39BfZ5aClzy2ja/IBeFVHHCliryw1XWWlhT7DIuzFcmIKYhdGgcEFIAHzM+ACyT7P
	y4JHb8mjU1jPjt7MhStg0pwPfaAPNFO6ZLmL68Gp9F6NqtSYM7ITEwzfIKGvaK2d0T
X-Received: by 2002:a05:6830:448d:b0:7e6:d54e:8fe3 with SMTP id 46e09a7af769-7f36930b186mr2604615a34.9.1786148437608;
        Fri, 07 Aug 2026 17:20:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5a7616sm2526147a34.8.2026.08.07.17.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:20:36 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 19:19:48 -0500
Subject: [PATCH 3/5] iio: ABI: add sinc4+sinc1+pf1 filter_type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iio-adc-ti-ads112c14-filter-support-v1-3-4d3ba00caf18@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6722; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ESa4zgB82WDyEdoFZl9mN7qSJr3JEOf6jr0xy6ffzxo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqdnY9VmoK+wsHJrd6IjBuaHdBr2aALTp3eILjc
 7FGg/lccbOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanZ2PQAKCRDCzCAB/wGP
 wK7ZB/9ZTfRPMU+xIVCYWke9cKsEjHUv2+My+RrDzWjeqx2pmsQPy5E9AcnqMHf2V4eFZ2lb6l2
 USu7n9fim9fLzFzYMU+S0bUb66106UVF92U2cI63Lh7INABJWfsG4j8nhT1UCeTpr+8xc0wEX6f
 DXPk0bHf3UZ5y1S4yOzA+LKLPEeoThK+5HG/SRAaf5uoW1vfWq2nD247lideZuCVshacEWgy3lr
 7YpWdcT3NZI7ZK+rYQXGC0WAuFBCyjrfh28dJSGDWmf2lEGxzFkgPcnI2h4AqtveVFgVNOJvvnR
 D/lCUJ04OpyW26yjpICLR1C+5YdBtsP2Scpk4iLqBo5eKhfF
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document "sinc4+sinc1+pf1" as a valid value for the filter_type
attributes (used by the ti-ads112c14 driver).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |   1 +
 drivers/iio/adc/ti-ads112c14.c          | 158 ++++++++++++++++----------------
 2 files changed, 80 insertions(+), 79 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a4f5595722ad..a8e1cb8e7490 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2380,6 +2380,7 @@ Description:
 		* "sinc4+lp" - Sinc4 + Low Pass Filter.
 		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
 		  time.
+		* "sinc4+sinc1+pf1" - Sinc4 + Sinc1 + device specific Post Filter 1.
 		* "sinc4+rej60" - Sinc4 + 60Hz rejection.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
 		  performance
diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index a73c0d6f0f65..ff22d0716abe 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -1358,85 +1358,6 @@ static const struct iio_info ads112c14_info = {
 	.read_label = ads112c14_read_label,
 };
 
-static int ads112c14_get_filter_type_from_state(struct ads112c14_channel_state *channel_state)
-{
-	switch (channel_state->filter_osr) {
-	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
-		return ADS112C14_FILTER_TYPE_SINC4;
-	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
-		return ADS112C14_FILTER_TYPE_SINC4_SINC1;
-	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS...ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
-		return ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1;
-	default:
-		return -EINVAL;
-	}
-}
-
-static int ads112c14_set_filter_type(struct iio_dev *indio_dev,
-				     struct iio_chan_spec const *chan,
-				     unsigned int val)
-{
-	struct ads112c14_data *data = iio_priv(indio_dev);
-	struct ads112c14_channel_state *channel_state;
-	int ret;
-
-	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
-	if (IIO_DEV_ACQUIRE_FAILED(claim))
-		return -EBUSY;
-
-	guard(mutex)(&data->lock);
-
-	channel_state = &data->channel_states[chan->scan_index];
-
-	ret = ads112c14_get_filter_type_from_state(channel_state);
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * channel_state->filter_osr affects multiple attributes, so don't modify
-	 * it if the filter type is already set to the requested value.
-	 */
-	if (ret == val)
-		return 0;
-
-	/* Otherwise, pick an arbitrary default for each type. */
-	switch (val) {
-	case ADS112C14_FILTER_TYPE_SINC4:
-		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
-		break;
-	case ADS112C14_FILTER_TYPE_SINC4_SINC1:
-		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
-		break;
-	case ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1:
-		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int ads112c14_get_filter_type(struct iio_dev *indio_dev,
-				     struct iio_chan_spec const *chan)
-{
-	struct ads112c14_data *data = iio_priv(indio_dev);
-	struct ads112c14_channel_state *channel_state;
-
-	guard(mutex)(&data->lock);
-
-	channel_state = &data->channel_states[chan->scan_index];
-
-	return ads112c14_get_filter_type_from_state(channel_state);
-}
-
-static const struct iio_enum ads112c14_filter_type_enum = {
-	.items = ads112c14_filter_type_names,
-	.num_items = ARRAY_SIZE(ads112c14_filter_type_names),
-	.set = ads112c14_set_filter_type,
-	.get = ads112c14_get_filter_type,
-};
-
 static bool ads112c14_using_drdy_trigger(struct iio_dev *indio_dev)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
@@ -1584,6 +1505,85 @@ static ssize_t ads112c14_read_burnout_raw(struct iio_dev *indio_dev,
 	return sysfs_emit(buf, "%d\n", val);
 }
 
+static int ads112c14_get_filter_type_from_state(struct ads112c14_channel_state *channel_state)
+{
+	switch (channel_state->filter_osr) {
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
+		return ADS112C14_FILTER_TYPE_SINC4;
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
+		return ADS112C14_FILTER_TYPE_SINC4_SINC1;
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS...ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
+		return ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads112c14_set_filter_type(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     unsigned int val)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_channel_state *channel_state;
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&data->lock);
+
+	channel_state = &data->channel_states[chan->scan_index];
+
+	ret = ads112c14_get_filter_type_from_state(channel_state);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * channel_state->filter_osr affects multiple attributes, so don't modify
+	 * it if the filter type is already set to the requested value.
+	 */
+	if (ret == val)
+		return 0;
+
+	/* Otherwise, pick an arbitrary default for each type. */
+	switch (val) {
+	case ADS112C14_FILTER_TYPE_SINC4:
+		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
+		break;
+	case ADS112C14_FILTER_TYPE_SINC4_SINC1:
+		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
+		break;
+	case ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1:
+		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ads112c14_get_filter_type(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_channel_state *channel_state;
+
+	guard(mutex)(&data->lock);
+
+	channel_state = &data->channel_states[chan->scan_index];
+
+	return ads112c14_get_filter_type_from_state(channel_state);
+}
+
+static const struct iio_enum ads112c14_filter_type_enum = {
+	.items = ads112c14_filter_type_names,
+	.num_items = ARRAY_SIZE(ads112c14_filter_type_names),
+	.set = ads112c14_set_filter_type,
+	.get = ads112c14_get_filter_type,
+};
+
 static const struct iio_chan_spec_ext_info ads112c14_ext_info[] = {
 	IIO_ENUM("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
 	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),

-- 
2.43.0

