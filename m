Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01DA49EC62
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288193; cv=none; b=CuEGh27t+OxRMQLX80CMjBjyBXo3ZuDRcSRVGDOmyTbhPPkhEwc2TZPCRONWBlMqeeKbfBsElZbfSKQ7+PIOOzLmDrGrrGD7sWqPetljDxxbXQyH11NqDB7uGEM9QAHopoHXopbUMF4Ow6oMyaYMph+4BfH74ad6p3SFzgHfvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288193; c=relaxed/simple;
	bh=DH57RPYRxChSY8YwQPpl6oapIsXNooDhZSIJodJcGq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgDq8Wye9x8+KVphwOFMfjX5Vl3nyqR4rDCEVUWHtATeI93yb+k+5HjDL8dEuSs1Jy5hIk/vH+V/T7eKVBEFwQqw1TuY2y3YT7PQdZC4BhlLTE69kiDFVQKFtbhCwGuYAOED/w+OPQCPCjgsiyOvpxSXb1PqWZrssDUhstsNz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWX7agq2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWX7agq2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so1166875e9.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788288190; x=1788892990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6o11zFnIa7BvYQwN2OAtZDkmujzqm33bgxkL6mWOBE=;
        b=SWX7agq27EZvnAh0cz8UVwpkbgc1eFQC5+gjkdeML39MC7RT3rO3KlAbOA6hlH8r3X
         fh4Yvfnfox4ZgqmnXmLJ4ePbVHkDK77h+5daB3XE0SxWVG7tQuZ3saRju4goa8lwINPK
         dxcLNNU+9QAvQ6SdsA9KBy7/yDB5a6smtDAXHRxIrT3zo+RZrGqFdW0+FAKZegyMJjd6
         ZmUMU7JBDVY+X19Clf/HFXUdrpqBlYZlYvNL2ZOiLp/Ix8ovC3mQAULNDmivU4kLTJ83
         9MTds8Btn0GgH+IzcceVno0GLpJdrLpX1HANzoU4H+hQXFH3WAcXJdrTWgbjWZVCuoJz
         RfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788288190; x=1788892990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b6o11zFnIa7BvYQwN2OAtZDkmujzqm33bgxkL6mWOBE=;
        b=s/yK0D1az6U7+V/Gn8k37oJD7hY+9UerN6pj4zddaPniKsF6HL/1PTpv45pJJ4ZViC
         O0BUPT0hS9+yb77czPNCbamwXTxGobQPQQpbAfscB9TZ6Cfh/VhC98FYmkWX0eCA5UdV
         1Y6XTX1t3JrhXj6/I69oNdYJEgFqWqecDyqVTBJOg06MxfCpZsf5Cx7ZoUFmPsCWMGcL
         +aF53QLNY5cF2cOyrnYfYCgDAuXYLbXjw9YTwxDpOOiYwzAb1zFlPn6aadUvGbz/WUGD
         7bJoQZ9vbcXLUALxB34nJm7qaWjYO5htP3+gEV8DwD+VRbcQ6SdPfbuuhQA0moQbGCox
         mRsA==
X-Forwarded-Encrypted: i=1; AHgh+RqHibK/KirsRntJaCKYOsX3L20Maj83roG25mUPcmYrhgIzghlPWhf9VzOFPAUZyfcao6x+PvCk3kI=@vger.kernel.org
X-Gm-Message-State: AFuF++mEgeMQdS1iXoliJ/fBZtf82NcUPtnqM8V6IttnsR5qubdKBCBy
	PZxpgc3ehKrM7qK0Q27Fi5ttSas8tIYRF8+wghY3hKlHTOhN96m3WxrC
X-Gm-Gg: AR+sD129Z28hAykzTgqKkRwJxXTfmIav/jDKI1ufCu0oxLnkJRxfyEs5JytRSTwi29s
	h/d0rULD+zkYUdMQ4KOPoQ2pQGxSwp+jVjW45Ej31+uYSX2ceI04JaZKEfwXuzYohOt8g0/z3q5
	07WbGfa1KagGXVAiouiwBfiiUI6nUFu9EU4Ad/tTb1ZuNoBew2de4wsWRpb7SJVxq0im7uXunt/
	GDn5Ht0ZTdFfSq5Bd6lm5laIs4HbRCCHPHqoOPtLhMVnLFl26PvcULAiWmngAPVJjB9ZnhvmBIv
	VMTQkojS0gfKhhHEb0vvgT1xGXkFuTIU4ZHR45LTR50cba6HItDFpD2kAnaf2nsg6cn/2rf2iHr
	5Q0LCpMGKAv7DCodWjt2yB3HtT+cCv8ED3VKLyk0VijPHraqT/E2va7gLoNvQeN2+zVq0TjFe21
	ZLI+FMaDjc7zk6YLegwdT3jaMDaoiMICuamj3ctACWVcg2RUVvUkaRvcA/0v81cAM9UREhIr9D2
	ZeRBsMoLMfTIYUXkM87hQuajUqJ1L/X0bfj
X-Received: by 2002:a05:600c:1c0a:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-49b91c1dd3fmr585852285e9.1.1788288189974;
        Tue, 01 Sep 2026 11:43:09 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.67.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed30c0sm822987f8f.24.2026.09.01.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 11:43:09 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ti-ads1015: Add support for label
Date: Tue,  1 Sep 2026 21:43:02 +0300
Message-ID: <20260901184302.8127-2-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901184302.8127-1-flaviu.nistor@gmail.com>
References: <20260901184302.8127-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for label sysfs attribute similar to other adc devices. This is
particularly useful because the label can match the schematic signal name,
identifying channel voltages easier if label is defined via device tree.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 0fbfa4e499aa..399a3322732d 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -233,6 +233,7 @@ static const struct iio_event_spec ads1015_events[] = {
 struct ads1015_channel_data {
 	unsigned int pga;
 	unsigned int data_rate;
+	const char *label;
 };
 
 struct ads1015_thresh_data {
@@ -586,6 +587,22 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ads1015_read_label(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, char *label)
+{
+	struct ads1015_data *data = iio_priv(indio_dev);
+	const char *name = data->channel_data[chan->address].label;
+
+	/*
+	 * Avoid printing "(null)" in the console in case label property
+	 * is missing for the channel.
+	 */
+	if (!name)
+		name = "";
+
+	return sysfs_emit(label, "%s\n", name);
+}
+
 static int ads1015_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan, int val,
 			     int val2, long mask)
@@ -843,6 +860,7 @@ static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
 static const struct iio_info ads1015_info = {
 	.read_avail	= ads1015_read_avail,
 	.read_raw	= ads1015_read_raw,
+	.read_label	= ads1015_read_label,
 	.write_raw	= ads1015_write_raw,
 	.read_event_value = ads1015_read_event,
 	.write_event_value = ads1015_write_event,
@@ -853,6 +871,7 @@ static const struct iio_info ads1015_info = {
 static const struct iio_info tla2024_info = {
 	.read_avail	= ads1015_read_avail,
 	.read_raw	= ads1015_read_raw,
+	.read_label	= ads1015_read_label,
 	.write_raw	= ads1015_write_raw,
 };
 
@@ -862,6 +881,7 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 	struct ads1015_data *data = iio_priv(indio_dev);
 	struct device *dev = &client->dev;
 	int i = -1;
+	const char *label;
 
 	device_for_each_child_node_scoped(dev, node) {
 		u32 pval;
@@ -897,6 +917,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			}
 		}
 
+		if (!fwnode_property_read_string(node, "label", &label))
+			data->channel_data[channel].label = label;
+
 		data->channel_data[channel].pga = pga;
 		data->channel_data[channel].data_rate = data_rate;
 
-- 
2.34.1

