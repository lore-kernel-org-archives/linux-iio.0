Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82275503BCD
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794596; cv=none; b=X3cKnAjdjQ43pMdcAgoDBYf9huxtRz19hUieuHLKD9dl9OuGogDJIJjwQqTTtkhtjs+QBITlf4epS4k5jJmR3gw/CvPpRFds5Lq1smXJnm7TWkh5gqUW3u5XtSADkdBILhj/NM5SHkdBPJ7SUibZSCtn2MeLTBJb4vZBopLZujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794596; c=relaxed/simple;
	bh=dq6QOnsULa1GJAx3h1sZHwK3pgAlPPHl5DxoXUXImkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyDkUkDfvIc72l7Z7m73VC5z/dXYlL3nZi6A2rJ5i+X+EXyCI+L1FB3seDVd7guqK3Ix1wmcpXO4s+5ZdpZBczVNTtEjwLYqEa/ty5qBclN8ocqgyPF8PcUg/2JTBJGmbH7AAtvGDuB1ZseYjQxJDTXw0NgLCactYb75xP9sLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw+//27Y; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw+//27Y"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482ea739de2so2489961f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788794592; x=1789399392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HuBDL/aaH1UR1BM5pkVKYW965YZzYu0aSLt8mFhBVfw=;
        b=Bw+//27Y15r/tZ1YTFGV7ja5GQsBZAlE2n239M4eREPHsYH9HILVZvTu4Z7zCpKhf2
         D9Rl4Ji+GukU1S7lJ5idgPNY4nViO4/iEN3lBqv9JWRGJ+vpdwtaEBxinaauIlFAYosK
         c/6l2yLhzszddafnaNKtT4hQ/gn42DsGA818uBizud5abyzmoDPLtIbyOvqCJqh1tP3+
         P1RaOZNkNtaUFn6WzZmHXAD288Yx1B2J1A6nO+kCasvc5qyCUw3U82l7ds8qNoIw8BdM
         Sc2c+j6uXi0R7MjKRzZb3YDOpWG85BYQCdZk9pRnxM52nCFVp1N2xava/MSxLUekPWrA
         WXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794593; x=1789399393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuBDL/aaH1UR1BM5pkVKYW965YZzYu0aSLt8mFhBVfw=;
        b=LiEoU2XLXcLsjSBGGWFAx69fmDDON7wEgKE7chAeDTNFl5KXkECY39iLwaYqSrnzOG
         Jh7bjRuVeeQA0naLUZ8uRw/Nbx/VGzYTLBG3fbDnCt2ttyHqjMtVdCyQHSVuEFpw0aUe
         4JWH3kNpHbE8a0xPF1ySwrBunjYDXEKOVDJICxP4MajiflAXs/BmPzjkomyiQemkhK/n
         aH+dser28zss9kEcaknfahHxIGANkw3FKee0LSRsWvw74yj9aiKJnjIch1gzEpHTkNfU
         8/8vbZQvtwmUBShv1DtvBYboYGFHwXSnWiPF+25wIOTH58gM/70yTYNwa5en5Gr+vapB
         EwoA==
X-Forwarded-Encrypted: i=1; AKwUvBybY7dMAr7Lo+KDrYvH2dREczdwdl7gcK5epmog0JI/J5XfnU/N+zY+PbiiQ7fY90W6EmUmftEXgPg=@vger.kernel.org
X-Gm-Message-State: AFuF++kjNbD9nD5uxylsM3+SAkEePSCC/tdqErBoHZCjja4vUMaEf5UT
	IToazJZuAsIsTbHYf3B2KegeOiEQXmBP6pzwAHhMm+Y60x5eEmKDRDAWoVE6EGkd
X-Gm-Gg: AYBFou1UqV+JLW7J69/erVCd5NIp0LdxISyaKn0i1rUheN0gPfY2dtnI5ji7zlBIbtG
	ciTb1ZAy6c2R8/5J6Rd0TIkowuXaNE6c/0NjTfV9Uv0JTP50/7o9vavRT2C5ah3mZ0RG9TV25Hn
	b6rJdtOL9lO9LYhH0sLyDHDoQR+VWcsU/voZu7tdS35u1+Ma44Zm0e8k+PLuNaSA9n2H2nvIu7R
	kI/N6HSp/eEzP3FuCSdns9xkRfLEG5+WcdhrJF9BUYx6RIEM4Nxo98Hi4neNfRtgdyM0dQuj/pB
	OhPS/nDzzEATV8W6at+MVezP/IMchBW4p05i9g8q5yAm7figrIPG+/iNk8WW6lvvY2Q6YX3U2Mh
	oaAX3VAqfOh+Fc6eMFrUjbSMfdQ7X+hRL+1GXMUa+OSe+OCNr7wX42ks+VFl+Oq1iH65m4XG1Bc
	iAMNVkoLwR/QhZ5c5G20hTQ2q5ZYMmXB9sREU1kWr6QUwhCX8mb3Xw2imD0i3VLP5hCBYQuBjxZ
	3l+J41sy0LU2SAz3YkzdAcYNzGEyl6xp/V1sV7GNBrZi+/ZMHqt
X-Received: by 2002:a05:600c:8b25:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49cfc6ea704mr211565355e9.25.1788794592561;
        Mon, 07 Sep 2026 08:23:12 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.248.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm413785375e9.4.2026.09.07.08.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:23:12 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: ti-ads1015: Add support for label
Date: Mon,  7 Sep 2026 18:23:04 +0300
Message-ID: <20260907152304.4992-2-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907152304.4992-1-flaviu.nistor@gmail.com>
References: <20260907152304.4992-1-flaviu.nistor@gmail.com>
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
Changes in v3:
- Return datasheet_name of the channel in user space if label is not present in dts. 
- Link to v2: https://lore.kernel.org/all/20260902172230.5234-2-flaviu.nistor@gmail.com/
Changes in v2:
- Implement changes suggested by Andy Shevchenko. 
- Link to v1: https://lore.kernel.org/all/20260901184302.8127-2-flaviu.nistor@gmail.com/

 drivers/iio/adc/ti-ads1015.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 0fbfa4e499aa..7ad03fa2253d 100644
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
+	 * is missing for the channel, or channel is not defined.
+	 */
+	if (!name)
+		name = chan->datasheet_name;
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
 
@@ -861,7 +880,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
 	struct device *dev = &client->dev;
+	const char *label;
 	int i = -1;
+	int ret;
 
 	device_for_each_child_node_scoped(dev, node) {
 		u32 pval;
@@ -897,6 +918,15 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			}
 		}
 
+		if (fwnode_property_present(node, "label")) {
+			ret = fwnode_property_read_string(node, "label", &label);
+			if (ret) {
+				dev_err(dev, "invalid label on %pfw\n", node);
+				return ret;
+			}
+			data->channel_data[channel].label = label;
+		}
+
 		data->channel_data[channel].pga = pga;
 		data->channel_data[channel].data_rate = data_rate;
 
-- 
2.34.1

