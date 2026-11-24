Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555988;
	b=fUQEdJiDJ0TKCPD2r0aC6EFSyz8aPBggpgNHmA6oBVlcBa1QxSnNedsRacRnVgWeiznI
	 lXQ4VRaLhOgp9Kca8bYeXF2Zq4T66urUbjG4WQPceZ1DFbbyfnhGDsXSnQALbB8aiewEv
	 7xu722vewZoEgMMxICRTaL1ss1kDzpRGPyHrTcNFMjq1KTxZodwAyg5mcRd74bMi/uwlW
	 Fk9W+3RHk7VifT3ChRaPQKNDd7S4jGsKu+mvEKJ3FKgH3xotNsfVwkM1kWG8kXkYnc5NG
	 tWHIMz38iVhFw8BC6vTkJxw0ig1pUG3byNdkLjrtT64NNx0j6iPoO+pwjNmo6Y8mnPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3jNvKr6YKssr0KC6PP+aBeDU0LdpHAs30F0i3S3i2H4=;
	b=49uH5f4UP8iZm8MZcmAEB9m6vECfWZ1KGp5enGkNgLxBA6DToL4ua9Bag5ag/AfPDjlV
	 V8neavBTVqzhbhFK0tvdP7ZvEwCOTAUCPyWmtpb8cxdJX6hWFPCIJ+RLoXUjxMmeSijNF
	 9jl74594Mb4gpdkAvCvYt+FlkXmo4CaffTkcbkLFlzzBXZf6OV+xknUvdXIcetQQw3267
	 fpng5fEHyEhUq65ZzJCaOC99vHmxnEH92cAvaYeLwGS2paz22ClDrhSzFETwxRKBv18Nk
	 pi+2sNpn0BiCCjvm8rF7b3gtcxKZYEkt9qHtbA9tlJjrowQbl7iH2DNdf0dUNXI3mIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezt4wIi+;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDA606A321
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 21:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FDDA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezt4wIi+
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4b769975b2bso9119865e9.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795555986; x=1796160786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3jNvKr6YKssr0KC6PP+aBeDU0LdpHAs30F0i3S3i2H4=;
        b=ezt4wIi++lL98PEYPo7Owc743QvyuZWXP64xqyUYB0rI8NKvS8r836Hvk2PZN1XEay
         1V45ldPutTYcf2GtXFZq0LqJ3FHu3k0TpH/LIMulAIJRazwlcOLb8wDUv/9xnck1kQ78
         AkD49mJkZ/Q0WV1nCVy75nIlMW9Lt980L45hcaL14HQMcKCleE6ZyEbrQzOaaF5WSfch
         lE8bY2Q0dLGYrrKFI4osddxXk3ZfdH1v6VmdpRQwCJ5bNcbyH9ipXdQ7Es/uYYfF/Jui
         KF4GNRVllFYdu1QIOCzqEv2q7WPsgn5i7HVUub2NvMf5m/8qqojAowIPFiIlCuKfHciw
         nqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795555986; x=1796160786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jNvKr6YKssr0KC6PP+aBeDU0LdpHAs30F0i3S3i2H4=;
        b=PRZKzMQHPvGhw4yBjvtzoQDgjJnIW/j7Z8oSs503ZB2iBH6YJ3wPWnwfVOEybsqVto
         GcUu+sXKYvz4LQdv2ZeqoBVgNwUTdc0t8FUQ7u+Q8ZDw9ukPt8vfpW/fCoFczSOUkvLV
         fRkR7zMaSrM+SuxoSvW2OcqqjcnwzWSa4JkUxpHzHPoBOzJm5lWvPvwS/pEE+2O/08Cj
         oJPA0fAsCGlsbb4ZWMHXeKeXZTJDTGWzaUruj8fpKmfgYii1K/K/bbrQgjn4ZuLYXfio
         4oDOMGOXAMtKTbBwAggt/dSVnPKyNrrhaKOp16Ttc0pNEq1slZEM7lah/bkO4nn3vCtv
         3clg==
X-Forwarded-Encrypted: i=1; AL+hErH65adNYPPFsNBcGrzqfBSAvEC92vp5WYKCmt0lSfr+R+YTIzcLHIIz1pD8N2yjpSZTS5dvLg3QUVs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vGvJVjdEukpG1DOBNWHQBcbZmHA6E+y4t4z5Z6JoplO+d3ULw
	X2/dn/iFej+NGd+QCJeEuDv6qL94eU18J+KA4ylfj9ENJga1ibJzZA6S
X-Gm-Gg: AZFdTZdyHH/JJX9NqGjEZMdxOlPgOwlGhPS/Hv1JYbNrEoEu9FOwj8y7vwjLNWZeLsb
	KnoHrh614etXJvczLPkiQKU4hlDRoxiIoLWYi5L0T24T/XXptonfBnoMeS9AmOtSJbkPEy2V1aR
	Cz+J0DR9xct4JXRK+UVg200Lr8FjHXQqhpL3FnaLCVABLTYDCyld34xCKzBAWDKipOTeWV9yWnR
	kJR2MvbJgtBqx0ZyytdW/cNwyUCPBs405iVwWmQC9Qemwycbpp/xFPGlb8mbpHRwLigMr/Hub3w
	Kvwds1APeNUcotdU5CCsyyo96pwhrC4/h1E6iuHRzgw5OuHs8DY0MS9ADaT1Es8v8eispYUIrWL
	lfLcN2KCSc1lIhNMcETVrVP0H/Bo4gEcK+5CawBx539s3Rarx3TTzcq7IKldLgyluRzVGZN/Q9U
	h+fLtt42sLJP5Xr/LgC5o3NqZpEEHZ+mlS8Wd3kM7mGKPlkIGBqrwrMp5S4CIgjhPX5ZS+HVZZm
	XtwJCn85/tAduNh3St4vJk4XzoVRD+V5VJGpUv/+7NXQHcN3PS147KnOqpdDP9DH4RzOgFuSbwr
	H8pF8/YuwHAaizQbcroWo7z6kYq1RCPKmA==
X-Received: by 2002:a05:600c:3b88:b0:4a2:191f:7cbd with SMTP id 5b1f17b1804b1-4bb888078a8mr367519085e9.11.1795555986267;
        Tue, 24 Nov 2026 13:33:06 -0800 (PST)
Received: from 192.168.1.35 ([39.47.150.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b205443sm31986200f8f.39.2026.11.24.13.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:33:06 -0800 (PST)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: radu.sabau@analog.com,
	Antoniu.Miclaus@analog.com,
	Dragos.Bogdan@analog.com,
	Michael.Hennerich@analog.com,
	Nuno.Sa@analog.com,
	Robert.Budai@analog.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	shehryar.amd@gmail.com
Subject: [PATCH] iio: imu: adis_buffer: fix buffer ordering for IIO core demultiplexing
Date: Wed, 25 Nov 2026 02:30:54 +0500
Message-ID: <20261124213118.63979-1-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Fix adis_update_scan_mode() to iterate in scan_index order. The adis
library constructs the SPI transaction in channel array order, while the
IIO core demultiplexes the buffer in scan_index order, causing data to
land in the wrong slots.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
RFC discussions at [1]. Tested by Radu Sabau, but not carrying tested by
tag, used iio_for_each_active_channel() while RFC patch used
for_each_set_bit().

Link: https://lore.kernel.org/all/20260925110239.59320-1-shehryar.amd@gmail.com/ #[1]
 
drivers/iio/imu/adis_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 501da4eae..17af61c7d 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -110,10 +110,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 		spi_message_add_tail(&adis->xfer[j], &adis->msg);
 	}
 
-	chan = indio_dev->channels;
-	for (i = 0; i < indio_dev->num_channels; i++, chan++) {
-		if (!test_bit(chan->scan_index, scan_mask))
-			continue;
+	iio_for_each_active_channel(indio_dev, i) {
+		chan = iio_find_channel_from_si(indio_dev, i);
+		if (!chan)
+			return -EINVAL;
 		if (chan->scan_type.storagebits == 32)
 			*tx++ = cpu_to_be16((chan->address + 2) << 8);
 		*tx++ = cpu_to_be16(chan->address << 8);
-- 
2.56.1

