Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513601;
	b=ug3ghA+IS6FS/u+ieO+oaEXTVcse5TOXaA+SlX5K9DsF1cEJ1L18TbszXez+sgx+48g2
	 j6FYDpAkq6j6NUtIXFkzTVYb/IUL/n/OZl/uV6rPsAmsg5UPU3J0FRpUPqA038arL3vI+
	 JlfsPZFe1/zh2hugd6PJMMsr9yvQVgjHYAetCi8W2f9rtIRlvffXAh6chKoMwikGoVG8o
	 Dm/QkFbhBjLjuln9CiOcdGMd2+Mg2/aZd2sk5opiCCC8ciwo6eztAu/4hnSUj5tfNIY4h
	 l7rJm8bOK+/lB/HPRR/qQAjRGCUZ3EikCLpXnTDlCkoSiqAmS4SZlPL2x7+ED/CMQeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bC/+9T2U8Kzer0tWSeR+xsoPj4sAgxGYU2Of5ey/6oA=;
	b=K+GNHJWhD4Kn4T/z8sTFcSlFbBV8So79edCvVwVstlCf1GIF3xBA90oDqMYxZlWLFlO2
	 KedfnfYhNoOs4Unk61W09FhEEfomQMOxzi+hLynvhrvAiXycPuz8VsTlryfFElv2n8Gyl
	 /e/RrUeazwGpPtA9n5SiehN5C4D2pV9XMaSW/4pGZKZdI0ExS9/ZvxXoZl5HJhLfjFfjk
	 GX7ggBk9T5mJtOiwTiFCN/k1l2FCGfUZogP0z8X2q6zoOnRty8I7OWvinTJyTJPQHmCJO
	 jVQC96KDATKgTYXy51JjN0EI13ze996YjCUUiE880zK8GEIbdE3qb9Z8FDBIYqpRC8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qHVlQaGJ;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2160777DF
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 09:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5B2160777DF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qHVlQaGJ
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so32905355e9.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795513598; x=1796118398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bC/+9T2U8Kzer0tWSeR+xsoPj4sAgxGYU2Of5ey/6oA=;
        b=qHVlQaGJfwcvc0wtiqE3FnLP7VpreHf8WPdB5ZLJoIs9T8hcIqcJdrpjXKrixXC8jd
         cUxw5UenDWPVhF3N4eMGqucQQWaqjZy2Pr6wyFpAmnV9PMIDqgDQ6hQjb/0r4g8qZe+O
         0Vq1q8DE8dWWB6LSLu6IRrjB6QuZgzQ2ZYIiMqgIDhN+JPsgRd7V1MebF8UeY4caQcx2
         X5uy8EC18TEfSe4jbJj35sR0uoPK6hzLdx6GBQyFdIlWQ2afLwpcO7hJdVML+IgCl/c1
         YtfOvcA8CK9XIMmHHdTCoUYjjKkaFedhOGL//+zGuDGFu8fwXad9tQ9XBU5/uX4LdSAZ
         ndOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513598; x=1796118398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bC/+9T2U8Kzer0tWSeR+xsoPj4sAgxGYU2Of5ey/6oA=;
        b=h+ZeknNEyZeiVfdhFIBTwoDNou5pNlM2sc5g5+oE9qRCxAG/QFwxnOw6NC3GHbGwCq
         LGP0NiR7lGHLkWKC5UNdYVE02CpGhm4fn+NOZUQrSm5oomeORrvp/c+p8KxqX/jq4FDU
         VuhwXYnSIOH5d4zh9n/u8DDr8JRW4n0GxEBiU+ENL4vuVDl05w3TJwDDHsblTeSsI03p
         ftsU1t0yIHkGWleWPwNucdvI4yJ5WaxJQXvzodFUo0QsWH+GNun0b/HN4MuKMmHboNET
         3TZgqtkH3rsVuqRLfkmZZKRb247kbXqodxMWe5N4omHl+fNKNZb0DSvXYMGIA6Q+Lrh0
         js6g==
X-Forwarded-Encrypted: i=1; AL+hErFThxwCoaN0aqPsxgyr1Mii7Ep4yo0IKyohG9fn3tDZK2IVP0gFQijWUBRv9BenfKEcIpGguHaCyCg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vA3pEMzerhy8lS0sty39chU5uvOjwFFVomolY8ba+twyo3JbC
	ItuA1PjSRQNJaAY7dp65A58uKbTDqzjX6qyvAdpEQX/3gXLs74tDHiCEolHkYecItAw=
X-Gm-Gg: AZFdTZeOgUh4Qq4UqVw9cDHyYcdkisSXeS55NMNs05QU4e3LalBSQeMjaBdTX2mu1g5
	ZNdqlGznKYq+1Gqpig2QPmzjC80CBkFyvPQfc35jOQsOrzPuSMSZvIRjPr+W38t0lbibfeVjaTr
	TJKz+SWnAVwJENp1SbgvgH56cn/lBZq6SOODD6fVp1vs/+qfo3oFziW98Q5pI4p9nQTBOxrW8rd
	i00V1K6m7DfYMOBrRZtoh0yiOr42YwVcV6kl/CbhGX6gd65IJ6ue50gnx9RRK2Q2EC1mdonMbfd
	sBzOvdtCY1eoPxfw9yrRaY9cu2DuP95v9gcQlsSiAmkYwC88VJLoIS5C8c67+E6Tj8eFxtB4HQI
	5nfSOfHZ3MXqXY5jBi20bBeAFkMO1EZByhD3YqZ63ef0PfRuglZPvAjOhS+noDpS1Yngcl6hcA4
	F6e8CnuGOYMeBkUW99lo2Aa8rbTNGom72z0sdlwhd0mKXLZBdmuHoMJwOGZeX5enQ4e6bHUPBFv
	0O1Vrskl9ojcrJ1Y6gZogMXeObU4PodjtW2J2mACO3UfKQsV9oDaiuggkx0oAZniejwFSn8EUAg
	FAG3QJ4pSwIbGf9wYhELuOVjLNb0E3qvdFd5O5hdJxkA25vDP3ZvnFUEMSYwEw2GjpUPscZmf1+
	/yHflVx20JJo=
X-Received: by 2002:a05:600c:19d0:b0:4bb:65ed:b55c with SMTP id 5b1f17b1804b1-4bb88824b18mr290530295e9.33.1795513598176;
        Tue, 24 Nov 2026 01:46:38 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm431782555e9.15.2026.11.24.01.46.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 01:46:37 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 4/4] iio: magnetometer: mmc5633: Add mount matrix support
Date: Tue, 24 Nov 2026 10:46:32 +0100
Message-ID: <20261124094632.8879-5-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261124094632.8879-1-gerard@teslabs.com>
References: <20261124094632.8879-1-gerard@teslabs.com>
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

Read the mount matrix from the firmware and expose it, so that user
space can account for how the sensor is oriented on the board.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 drivers/iio/magnetometer/mmc5633.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index 08bebc8eb5f6..a25d989afb2b 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -95,6 +95,7 @@ struct mmc5633_data {
 	struct regmap *regmap;
 	struct i3c_device *i3cdev;
 	struct mutex mutex; /* protect to finish one whole measurement */
+	struct iio_mount_matrix orientation;
 };
 
 static int mmc5633_samp_freq[][2] = {
@@ -104,6 +105,20 @@ static int mmc5633_samp_freq[][2] = {
 	{ 6, 600000 },
 };
 
+static const struct iio_mount_matrix *
+mmc5633_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info mmc5633_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, mmc5633_get_mount_matrix),
+	{ }
+};
+
 #define MMC5633_CHANNEL(_axis) { \
 	.type = IIO_MAGN, \
 	.modified = 1, \
@@ -112,6 +127,7 @@ static int mmc5633_samp_freq[][2] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
 				    BIT(IIO_CHAN_INFO_SCALE), \
+	.ext_info = mmc5633_ext_info, \
 }
 
 static const struct iio_chan_spec mmc5633_channels[] = {
@@ -488,6 +504,10 @@ static int mmc5633_common_probe(struct regmap *regmap, char *name,
 
 	fsleep(MMC5633_POWER_ON_US);
 
+	ret = iio_read_mount_matrix(dev, &data->orientation);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read mount matrix\n");
+
 	indio_dev->info = &mmc5633_info;
 	indio_dev->name = name;
 	indio_dev->channels = mmc5633_channels;
-- 
2.45.2

