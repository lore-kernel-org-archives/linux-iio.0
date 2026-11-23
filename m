Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465583;
	b=solnfT0goTlJdnqGUX3faiST3Z8fJe20Iv1IrZr+Slc7xs7f7paIl4z6Pr+VATE8iEwB
	 MdPs56R49pMemBZJk7rRbvDE5BCBhiu2uy48IkmrFsNaV6wiUsSJE+Wo2yAAMDbMVdz6V
	 srYd778OyoiwIsyPg5JUkh1DnkeUlv8PDcaU45WlFabyFrX82k2Q9DFIo8VffxFaiGEfc
	 ux3LLJX0Z5wyI9JvT84x2CVHWuMgLDPX3/JpmoqpNe1O4EOvQHknHc5VDUIIUDrE4ques
	 OJfsmKZVyV02VfPNNADXi2kqHNjmHjJvilBrHdiWrCn9+COmJAaKZnJX8VJWtpqXKLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Upecx+X/9IYkl/xM9lhnS9+bzajsmI969q78+kC9B7A=;
	b=UH6UmDw0kyt7WkV9gFtUy2ObVLIijBiAfbSEgZz1DsxM/dx+ZAPyhhxUBkD34nk/8Qyn
	 C0o76m7brtdIRDG0dlXiM7Y8ehb+fMs4rwsXIkZE3LXMKxQGA9v1/1/foCs20flrh0VuI
	 x21VFwC2RsxXXTlkTi91AAaNqwMK202AZceQ8ychzZc+SfHv3ofSIKzIBm8hjQC12/9+o
	 5daOJIOLkJniptd19RKwOPfKhedeSv2WlMycrTUt0rIy1w6mbeeu7tWtmCVelip+v3Zlp
	 K7th4IU3QuomsqJwEUN1cRdzHmikfRZFRSCwAhjItxbu4zfoJ5P6glQmPH8om11KI9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=b6V7vY+6;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8170606A321
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 20:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8170606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=b6V7vY+6
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4b52fcb410dso573644f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 12:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795465581; x=1796070381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Upecx+X/9IYkl/xM9lhnS9+bzajsmI969q78+kC9B7A=;
        b=b6V7vY+6rwZ+oeHCGn712eE0DPm7e9WdpitttblvNBO+zocl0I7NsaNXqMP7lRxAtC
         oyi2aHqXACp0d4X+FSwZhi/nQutuP63pZYuA5DMkytQjGRxJnj8eQKV+253Mgnpr4JXD
         GVJQ0gWwLpbp0qkHWAVGHvM9eLwx/1PQr49XyvFZeoI+iHMTvO39HdFnDj/E2ighaqf3
         QXd7Q94BKD969uHAxueDHk7T9ItmGHlx8cZ1KAE9YrSsxZa50Ue6ZZQsb+Bh2+8dzM4v
         EL8KyGJsh8kGKK8HbaoB4jWQVvyxliOtKvcR0GoeCLiKV+cy1iU+4Ml3BOkIFgz8+AI7
         KynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465581; x=1796070381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Upecx+X/9IYkl/xM9lhnS9+bzajsmI969q78+kC9B7A=;
        b=MqvlOmJmDsEc4Ot8rjbi88Vh6CAWGe9bxIOVrr7bAWEoZL99ZzWGF9dKX+TcPoDlPt
         Oj7hwvL1VQzYn/sVVMjRQ0ICGDwlTe+4FcAoaoToEXF2On7Ccyy9oSX5i49rE4t4Q654
         bAYIdOMVqjwXDQ4NVlDFaXKHdmvzHcFJMtAOKeWy3V9HLyZR7/8/9GpHsShCv2pzvckm
         VbNqlQBnp7SUwgswFQQ8IL1rE1Jwyb0Objf6v/Wd1W5sq/+ZRWwJe5F55DucCr0tDP7N
         gH6IZXCZZ0Uom9WpWxhfDfNVh4k6JfeScJSFEES3yTUGW5YT3c4T2nLcYftCjHF/+MwB
         n5fA==
X-Forwarded-Encrypted: i=1; AL+hErGXWtcUvouaTHeI6urFnlXgywYUWuns19hNH4iXJSIgMQInDiN+uLUfajF3gJm8zBWvPgkyuuetvIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nigi4k2/ij1xoocrCe/x1XvIhNK4cQdulIhP7YbrssxEWCuRZ
	9rq3bADBRl3oVnV2YuewWVGi0hPN8eOSUDW+LwXxzji/uHls585rMqUwCb9rBuLgo64=
X-Gm-Gg: AZFdTZeCDRqPTho4o/VuyvZKNxSlEFcjATsY9AfvgIQNulIXd5ogercIY+8RQLiMZ6E
	B/FIjLKFvCE9H39GuqdFQlnXRnmwP55sdlO+0w98oLQZGwzxPGXj8cU/7ydx+dgiYb22LH3AHqR
	d4lMj3+BUE7OQLOaLWvPK3pTwT4bvx+y5uj8EbWUVbf+2IrDOcrOcYq3xSUhYjWILOk1nQpwlaB
	YA8REB/QROgxxSF13aWltEfLIAhbMXCUqPVSzWiQH+3Id6YtyypJvLizQv594dL6J3WMLMa651e
	Raoiv/2w/1shHWWncIrjHHwZr/JA448PC8wfUHA7mjnEv0rFXP8sIfzLUPXaAs+Dj/W5+pcv9G4
	Qqe6EV9ltH5u9ga0M3JO5qXh6Ye6fkYhZRJTFv4LJhiamQzWxecOy65ln7LmgHjL/dG3z+GdMhW
	vurdW2VYj5i76aH0UL9egVNIkJJsatiqG6pOmaN7xmehjtUNDZZpTzCKI2a42ODpEMpqVEPjtHo
	pjTLJ9zfP4F8QL6JCcpevbLj24gXQ2fpA+VCvvA0QMoeFUHnJAgqv5YlMnC6HAMF+CWT2SdT7MI
	oa5Dtx1TBy69O81+Ab4/rFAPTWDXsuvaVx1oKscrxEA6tD837CYJsIgASgQlJDn5HEgOwQb0arx
	4wYoqlOm5pvc=
X-Received: by 2002:a5d:5d87:0:b0:4a3:2ac:26a4 with SMTP id ffacd0b85a97d-4aa58527c76mr34549229f8f.23.1795465581118;
        Mon, 23 Nov 2026 12:26:21 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm20108713f8f.46.2026.11.23.12.26.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 12:26:20 -0800 (PST)
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
Subject: [PATCH v4 2/4] iio: magnetometer: mmc5633: Reference the datasheet for the SET/RESET wait
Date: Mon, 23 Nov 2026 21:26:13 +0100
Message-ID: <20261123202616.17334-3-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261123202616.17334-1-gerard@teslabs.com>
References: <20261123202616.17334-1-gerard@teslabs.com>
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

The 1 ms wait after a SET or RESET is tSR in the Operating Timing Diagram
section of both datasheets. Describe it where it is defined, with the
revision and page of each datasheet, in place of the comment at its use
that pointed at the datasheet without either.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 drivers/iio/magnetometer/mmc5633.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index b651f01e1b5d..92a09316ccdc 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -63,6 +63,11 @@
 
 #define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
 
+/*
+ * tSR, minimum time between SET or RESET and other operations, per MMC5603NJ
+ * datasheet (Rev. B, page 15) and MMC5633NJL datasheet (Rev. A, page 23),
+ * Operating Timing Diagram section.
+ */
 #define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
 
 #define MMC5633_HDR_CTRL0_MEAS_M	0x01
@@ -144,10 +149,6 @@ static int mmc5633_init(struct mmc5633_data *data)
 	if (ret)
 		return ret;
 
-	/*
-	 * Minimum time interval between SET or RESET to other operations is
-	 * 1ms according to Operating Timing Diagram in datasheet.
-	 */
 	fsleep(MMC5633_WAIT_SET_RESET_US);
 
 	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
-- 
2.45.2

