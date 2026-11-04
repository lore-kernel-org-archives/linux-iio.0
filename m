Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810740;
	b=xkF8+I/tKkROxvjUxo8eYzA+uOI8ZSLYs4EjrsGSRHZjD58EZPnO33VA9r5rx1BCrvtG
	 HEM966IIaGrD/GmOljy6VroglfLNt9AlR7ddpx+ieSnvsajimXrgV2tvkIXKwx6bWmHfh
	 JsCbKlGw4P6rFC3tlo2I/A0T55kK4jTPYVad0vOiC54dfX3xiQx+Wnl5fvAoSTmi1Ee+p
	 DSpkpUvIox0pNLUS41lXcHYPEVjNFiOiuuZ+Q24U3czs6qCuq9RHvmWsA2mm3gwF2tPfA
	 lW/KA6ddgdn5Om35RW1qf3tgdl7fuSy9jEuKCkXUVzL2XZ6RKhOahPjKoC4aTfw8U0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ubnY4McmoFrrH8E8woK0Dx2b09gWWGMhkGbARjItHnU=;
	b=tvJIU1uvi9MbquQjhwXWWXbOwrYLaQogTWSsHLE0Tx37AjMLaravcGRHCC1h92wLoJJP
	 lB3TSZdKiHZSd7AJ69cEx376wkgnn2BFEgKQxxPxbmxTr8ZdtqbogM1dDdg+dZsgO4Tb6
	 mbGjcFOjpaxvI1XfGb+0uTf0YehFBAw1eg/pYK9mG2gPLCYcHFCjBzdeJsbcowv1hHe0H
	 RJvKuCb1rUnVxKKKFHrxXb4/46HsqJ/aHGo6knbTKJs8EILWLwVvOjUsni1/ptbPG6Hku
	 HTW2TigN6PWMa3eng5vTO8uC2aSbFR2YGQG4iT59X8xyb1/1nqkjiG52pDvVAwY83yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uv3ybTOG;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F35606D801
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 16:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52F35606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uv3ybTOG
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36d6e342f98so847318eec.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810738; x=1794415538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ubnY4McmoFrrH8E8woK0Dx2b09gWWGMhkGbARjItHnU=;
        b=Uv3ybTOGXwY8Lox7OZJ0Ofmp4Gi2o3uTLQ9p+FZtDRp0V+yPofXQ2BEVufCAdMbgdo
         yStRALcgk5v7iM4wln+y3fSbnUYRZ2nkhg6nKQdKAvFpEu38xUn/oI7OQPsKlODwLevT
         Dc0KiyEGbBq3sd4zs/i8E6fpsrhZd35evsZLUE3jKaFbGhv0S4aA0lRfuyJHcdpvIHi7
         3zueXs50v4mOgsKJ86nwk8c1lrbJc55ha7CRgc3ApKr+KNHN9C8sXmXij4G0D/CTYLqr
         8Q1RM7WBtjksi+mQbvMdp9gKH1xUPGUXeOA2Ktkr9YUzm6cK3pD5mfM53xuG+6VtHTse
         jF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810738; x=1794415538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ubnY4McmoFrrH8E8woK0Dx2b09gWWGMhkGbARjItHnU=;
        b=MiNZLD1MRdQlFSbQCpYTfcRcg9giRhC9NpphCfqzHNxLs2eRoDqfAPwMBIoqpUJFiC
         B0s+kww8XLTgWMvd/32zwdq/9RCGMNFM4J7/nMheQM5zZJrN+q4BJ+51IMMAsoKsGT41
         pf7HViRsfDcFxF5zsnSctXWyq9VTKYysQXCnRbm4Nph5CflrrSMEXDUEWbwl3q8mjNKx
         u6TVyYpjsbfQ2jERxY3eTFV2cdBV2dPKguzfZ/2UUtAjwrGG21nQr4q8QSKPgNBQ1jnh
         0bJAlmX/ljTcIwNiTkou+y1Vt5PMX8I7qp2IyNtrsDt5VjxAvJHucGztu1agRzNetNt4
         gDyA==
X-Forwarded-Encrypted: i=1; AKwUvBythEdMp8CzE8m9MsNqgiX337qHa9O1v52aP0lBW9U13OjrG/7fz4+oP3y+/kW9SXOT51YZnNEDMZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z91szW8CZA4btQ0IwFKZF1/Sqfd8M4DHLE+Ec6mlb7zRTj82LVm
	0Km5DTMEvc6Fn0Udg4lWOi0Btnq2JRDTsJGMNDNe44sEyXtvf/UbBMJN
X-Gm-Gg: AYBFou0z0liWccc1G328guC9EHhQ4LjQmc0oUGsn4LxLcqegiupCSvy4hHrzyN/8NZu
	FGIY6cNDuO/xIhnAtSL/N21Gt64Ghf8R75ObQmHJ0jMvu6rIauntOsrWi/13S69LcHqukleYGtK
	afs/2SREuafRTaQ0Swk/iVh0VHEZiP4japBT+tSaCzoznAUiU+7nz+cda5khOvoOGKKmTj/y44p
	B07Xd8o33vjehub85p+ujEi6/dsVUISEVkmOu/8vR4XqBplz5t6FRmAIV5clrePRN2OAFxkKa7t
	N2EIpCqm7JMRYMH2eVYwEez4IMBj0Uyvnn2pRfNDomPHcKN7qC6wpRCzbtmFKmOJUZ/CEhCgl+R
	UMF3GB8W6/jtw8stqIlv8OzBwGdHa1T8mfIr7uAIAf29II8J7XPPuoiILYgsIF84uOTt0dS2y0w
	uEmwSbYyiy6n08/P8JOGgZ+QKkBiv/erwo+Q8katABj7B+Ak7kp94REMePI5J7ZxGzdTC2PC0Wi
	XTA12N1lcuTNSrHfq29ucEU6RalgLx7QyWUgMbOexpFYRvilrSZiylb7P8IUmfgaTMKu9v2tjP8
	vGuUVm119pJ/IKLzXnPDCaKRAw1Jc/C61RrBp/LKKtCc1yDhQc0wkbKnDWIa7wq5+6pKcNduiiR
	vrHArF7/lWZ/up3j5tlalcyEMT6jWvhFlA8y+NEwhc9qgSFXBHVZHxp4vNztaQiXZ4uvLH/UnJG
	2unBpIbNesYKUbW/mBF3X59DzXESMVv/lgXyaaDzBXbA==
X-Received: by 2002:a05:693c:88cb:20b0:36a:1e50:e45 with SMTP id 5a478bee46e88-36a423624d5mr23360620eec.9.1793810738064;
        Wed, 04 Nov 2026 08:45:38 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d36a1sm10368825eec.12.2026.11.04.08.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:45:37 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Salih Erim <salih.erim@amd.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Wed,  4 Nov 2026 22:15:01 +0530
Message-ID: <20261104164510.105359-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104164510.105359-1-kapoorarnav43@gmail.com>
References: <20261104164510.105359-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
channel specs and lets ams_init_module() fill them for the AMS node and
each of its children, without telling it how much room is left.

For the PL-SYSMON node, ams_init_module() always adds the 10 fixed PL
channels, numbered 20 to 29, and ams_get_ext_chan() then appends one
channel per "channel@N" child as ams_pl_channels[N - 20]. Only channels
30 to 50 are external ones, but any N from 20 to 50 is accepted, so a
child numbered 20 to 29 duplicates a fixed channel. A PL node can then
have up to 41 channels while only 31 are budgeted for it, and together
with the 13 PS and 7 AMS control channels this writes past the end of
the buffer. Since the modules are filled in device tree order, the fixed
channel blocks copied after the PL node can overflow as well.

ams_get_ext_chan() also only checks the upper bound of reg. ext_chan is
unsigned, so a reg below 20 makes it wrap and ams_pl_channels[] is read
far out of bounds.

Only accept the external channels 30 to 50. Also pass the remaining
capacity down to ams_init_module() and ams_get_ext_chan() and fail with
-ENOSPC when a module does not fit, so that a device tree repeating a
reg value can't write past the buffer either.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/adc/xilinx-ams.c | 57 +++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 158e6133abf5..745edcf7c735 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -144,7 +144,14 @@
 #define AMS_PL_CSTS_ACCESS_MASK		BIT(1)
 
 #define AMS_PL_MAX_FIXED_CHANNEL	10
-#define AMS_PL_MAX_EXT_CHANNEL		20
+/*
+ * The PL channels are numbered from 20 in the binding. The first
+ * AMS_PL_MAX_FIXED_CHANNEL of them are always present, the external ones
+ * from AMS_PL_EXT_CHANNEL_MIN to AMS_PL_EXT_CHANNEL_MAX follow them in
+ * ams_pl_channels[].
+ */
+#define AMS_PL_EXT_CHANNEL_MIN		30
+#define AMS_PL_EXT_CHANNEL_MAX		50
 
 #define AMS_INIT_POLL_TIME_US		200
 #define AMS_INIT_TIMEOUT_US		10000
@@ -1131,6 +1138,9 @@ static const struct iio_chan_spec ams_pl_channels[] = {
 	AMS_PL_AUX_CHAN_VOLTAGE(15),
 };
 
+static_assert(ARRAY_SIZE(ams_pl_channels) ==
+	      AMS_PL_MAX_FIXED_CHANNEL + AMS_PL_EXT_CHANNEL_MAX - AMS_PL_EXT_CHANNEL_MIN + 1);
+
 static const struct iio_chan_spec ams_ctrl_channels[] = {
 	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSPLL, AMS_VCC_PSPLL0, "VCC_PSPLL"),
 	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSBATT, AMS_VCC_PSPLL3, "VCC_PSBATT"),
@@ -1142,20 +1152,31 @@ static const struct iio_chan_spec ams_ctrl_channels[] = {
 };
 
 static int ams_get_ext_chan(struct fwnode_handle *chan_node,
-			    struct iio_chan_spec *channels, int num_channels)
+			    struct iio_chan_spec *channels, int num_channels,
+			    unsigned int max_channels)
 {
 	struct iio_chan_spec *chan;
-	struct fwnode_handle *child;
 	unsigned int reg, ext_chan;
 	int ret;
 
-	fwnode_for_each_child_node(chan_node, child) {
+	fwnode_for_each_child_node_scoped(chan_node, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
+		if (ret)
+			continue;
+
+		/*
+		 * The fixed channels have been added already, anything else
+		 * outside of the external range is not a valid channel.
+		 */
+		if (reg < AMS_PL_EXT_CHANNEL_MIN ||
+		    reg > AMS_PL_EXT_CHANNEL_MAX)
 			continue;
 
+		if (num_channels >= max_channels)
+			return -ENOSPC;
+
 		chan = &channels[num_channels];
-		ext_chan = reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
+		ext_chan = reg - AMS_PL_EXT_CHANNEL_MIN + AMS_PL_MAX_FIXED_CHANNEL;
 		memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
 
 		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
@@ -1183,7 +1204,8 @@ static void ams_iounmap_pl(void *data)
 
 static int ams_init_module(struct iio_dev *indio_dev,
 			   struct fwnode_handle *fwnode,
-			   struct iio_chan_spec *channels)
+			   struct iio_chan_spec *channels,
+			   unsigned int max_channels)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct ams *ams = iio_priv(indio_dev);
@@ -1191,6 +1213,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 	int ret;
 
 	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
+		if (max_channels < ARRAY_SIZE(ams_ps_channels))
+			return -ENOSPC;
+
 		ams->ps_base = fwnode_iomap(fwnode, 0);
 		if (!ams->ps_base)
 			return -ENXIO;
@@ -1202,6 +1227,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
 		num_channels = ARRAY_SIZE(ams_ps_channels);
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
+		if (max_channels < AMS_PL_MAX_FIXED_CHANNEL)
+			return -ENOSPC;
+
 		ams->pl_base = fwnode_iomap(fwnode, 0);
 		if (!ams->pl_base)
 			return -ENXIO;
@@ -1213,9 +1241,14 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		/* Copy only first 10 fix channels */
 		memcpy(channels, ams_pl_channels, AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
 		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
-		num_channels = ams_get_ext_chan(fwnode, channels,
-						num_channels);
+		ret = ams_get_ext_chan(fwnode, channels, num_channels, max_channels);
+		if (ret < 0)
+			return ret;
+		num_channels = ret;
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
+		if (max_channels < ARRAY_SIZE(ams_ctrl_channels))
+			return -ENOSPC;
+
 		/* add AMS channels to iio device channels */
 		memcpy(channels, ams_ctrl_channels, sizeof(ams_ctrl_channels));
 		num_channels += ARRAY_SIZE(ams_ctrl_channels);
@@ -1245,7 +1278,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	if (fwnode_device_is_available(fwnode)) {
-		ret = ams_init_module(indio_dev, fwnode, ams_channels);
+		ret = ams_init_module(indio_dev, fwnode, ams_channels, ams_size);
 		if (ret < 0)
 			return ret;
 
@@ -1253,7 +1286,9 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	}
 
 	device_for_each_child_node_scoped(dev, child) {
-		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
+		ret = ams_init_module(indio_dev, child,
+				      ams_channels + num_channels,
+				      ams_size - num_channels);
 		if (ret < 0)
 			return ret;
 
-- 
2.53.0

