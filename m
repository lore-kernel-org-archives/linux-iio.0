Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374523;
	b=vMPHoOmKNzrcEaNR1v/vbiCP4CHpC/HL0FBBX/Oa77CvfWJmglNESbVgU2wWRq++6wZq
	 Ilei6B/xq7rtDOEs/O6ZrKpm2PxvkkBwq2G9WIHof+QWr0hvDK0vBoZ/6dTYpwG169yO1
	 zfWnmy0vj1lrkVAnG6xfctOfVvhbMcWSdWQVzWLHeEQF6aSaCk7KY1R56QqKfLCQ1c1ES
	 O5uvpyXoiJGScYukeafkGhk9MgluIM6ocYIorQ2v5AsLwk6+VObvcex6HFO2oZdhplDvM
	 Z60QdBlKiNpBzxdhcqSkPcY9+RZA6qrgWB2SPFN/cFNv680BXhg9mFHSfz02IV91BOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dAs1mqfrVrH1ol/B1nRUX6eBBIxpRuHBybsWCr2GDvU=;
	b=LBMksE6PBANxbCIXJUZOjrEzvR3h2m8JCxkvdIm+/D3Iuf4wbBJI1WnTF1Git1xUHb2N
	 a1cMgjRHkPKk+/ApBzHSBxkmxWsMugNDkGhcdtJXZ26J5zBLQwOSSilgTczE87UreteZw
	 tL8IJUeGIBT7SBl6c0C9bzvU7sngiFsVDizDFcj9/eTk2AzXgjStIdu+f7sw8rw4ruBB/
	 mOMLvYGr6qxVvAfH+bBKPpih8O0l1EBctpulVQjmVIwsssEsQbKwGqCW+YwfM238UUUo9
	 rP88MduRaU7/QRmz70fjua4g2CCWgpHuGnGN4algyvs360q/i1PFmHHn4I2FOAUA0UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CK8UnIGY;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9537606A681
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 19:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9537606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CK8UnIGY
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so18939795e9.2
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795374521; x=1795979321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAs1mqfrVrH1ol/B1nRUX6eBBIxpRuHBybsWCr2GDvU=;
        b=CK8UnIGY3tyNdi3KsdxWUFgIsuevJezdcxkZ0Tvxgvwb2yGWbic7kemqR3xCy9RriR
         XtDRytV0gxbfFtkO0gju/ZJjOwfQSDSzNwbE2g7oBcO6OD5XDKZY3yENX1kRAqYQp3zA
         IwPRo+10jO3xlCxlC9rJEmKQwVuaa92PQ1YcuJhQgbJ3hEbVn674bfv2Oq/ccAmP7ysu
         KVDQURX/udZ5xXi0EJIg9v9FOWsaYl1Di5oFGsQT3JZxPyVkYIAlhsMQvL7mDeeJQ4a7
         hksPvNghpbg7JVmb/g1u2/amPVy2WQnPV2iGFZmKp/ICzFRez1mEB0M0AqSS8H854Kab
         nQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374521; x=1795979321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAs1mqfrVrH1ol/B1nRUX6eBBIxpRuHBybsWCr2GDvU=;
        b=P9dl3oGk9SG8c7jSXI8LVckh3plJw5DW8ksIT3EAn2ZlFBQKAdXj0Cl7R+YPjF5pA6
         gkc3OUCNeOp4lCIsiWdF1n3f8s4Z9RxaIgjLGYDEvCq1mRNNwRLZ6p6EXlcPdwesRRjY
         yodNIm055nzADceLC4aqctkxnbO4OZ3LT2pONvbmJK1+AaY9lJynpx9o0ZH83tAOe8Il
         2j6WJTU5TTqd/IkEK8TlNNFRViFstGD7aq9/THbTumYuheDN3ZczO9lkkHeqs1bUlozq
         xuGO460BOWRvUQFIt05hZjCPIPoGizf6wCEBd2FgPDDxhniXT4uIls51m8aV2RkFFKPb
         emeQ==
X-Forwarded-Encrypted: i=1; AL+hErGRzWijnw3JCJSpc5rA5AuNaYVGKgZuIjvdsl0txo/MXkSvIY79wNg5TU32ybBeatBtI2q+fZtXaUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NdH/45oOmEETCON2NPAmmaTuyIm1Z0F11viGt5bBCmZzj85X6
	NWslZ7OmCBWsRwsUUhDymeSGni1pMVt89H7ne5ZKMDXtCTT09RQ86J6mVspSYFAuZns=
X-Gm-Gg: AZFdTZdKbzMNmOPdQ4VPPitBKZ/pKKC2CJi7HCOAOTMPqXSMkBTG/d40yXWy8E0anrX
	n6+zkCcfk4aIScMTYplkdeODoWX5B+VJCIJJvxP65/Iy2m/8zcL78ia0PGN/G2JFxHky5fKGxgG
	ociD06OIsONhSkTANQwy/nj/fI/hME5HqnHusVdj41XjNEEn8XpDWfmXlp9PwJM922u4e1EQ4/Z
	OyIgxLyDcguHGo+r8mKyTgX8Nr0IgnXI2YeKg0wbgmQz66UHf8Gi3pSL2PJ5ubIo/fNJ3bzpFxH
	qpyAglMBnkD1kPcO+/3sTmsFr70EtmDoGRnAYNIgvqZcI2W5Pi3wfeKY2UhXJf6vvikM6mWoiBV
	wMVFiTdVVt8SB3wDUSmPu5sUlNOgGJjjc+MEx4sc46EeMj+QG8bBbpMuLUK2sikgsvfuDCXQdVS
	Zz3bPaLudg+CVKlcjOU9REo7SPE2KZ1cz136OJqCDGKAOCPWE6jQRzxMfjzW5Vigiou9DGIRw14
	R2GvCjLcv15YFTJgHZ7xwJVrTz3MRw2GSge/5HVo7FP8jT0NfooGi58uAMsKoQcgr1CDIteA6gK
	01gT7XjLkntmXPxlHvTpN9DZrzEtW63TQB0gM0zOtGQVjFixMujbEpfoq+9SyYeJsPv8oDI73My
	HV2yWcvEwKtY=
X-Received: by 2002:a05:600d:600b:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4bb88815f1fmr200246095e9.21.1795374521196;
        Sun, 22 Nov 2026 11:08:41 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895f7bc1sm103080395e9.3.2026.11.22.11.08.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 11:08:40 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: magnetometer: mmc5633: Add mount matrix support
Date: Sun, 22 Nov 2026 20:08:36 +0100
Message-ID: <20261122190836.66111-4-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261122190836.66111-1-gerard@teslabs.com>
References: <20261122190836.66111-1-gerard@teslabs.com>
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

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 drivers/iio/magnetometer/mmc5633.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index 79015c7984de..f9ecb3737cf6 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -83,6 +83,7 @@ struct mmc5633_data {
 	struct regmap *regmap;
 	struct i3c_device *i3cdev;
 	struct mutex mutex; /* protect to finish one whole measurement */
+	struct iio_mount_matrix orientation;
 };
 
 static int mmc5633_samp_freq[][2] = {
@@ -92,6 +93,20 @@ static int mmc5633_samp_freq[][2] = {
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
@@ -100,6 +115,7 @@ static int mmc5633_samp_freq[][2] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
 				    BIT(IIO_CHAN_INFO_SCALE), \
+	.ext_info = mmc5633_ext_info, \
 }
 
 static const struct iio_chan_spec mmc5633_channels[] = {
@@ -480,6 +496,10 @@ static int mmc5633_common_probe(struct regmap *regmap, char *name,
 
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

