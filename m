Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567721;
	b=rai+vBKJzdvG2p1SleeUGMfwlYS4wHfuhPDLqrA6W5EzARRHf2rdAmGs68ghCEmuOOGt
	 4iWqWNgsWSwgyjgFz+oRjY2utq4EGfHdmscvcxj9x2sYRzaIugUZwrE8YyH0Oc3iJzUMU
	 NWdXmbmlVzRPFt/9mjovkApb8i/dU7+/1BQGzmTv9caFDfVXPHrQSA2+TFVa94Dbz74zX
	 3ooIk/wg7wArLkQP6/kF55wO+Khww/qzTKd1jCz7X2Mq+Eb5eJ8zymHeST0eeyrW9/KOx
	 9oeOXYHxPEgGoMuYyFBFFzqUL7iaRtcv69OInms32na7/hn0JQJG8BjhKKEosk9qOPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XrQXIIJcWWHsCurNHxzIBKzj+WWkbswf8BCsQIq75cU=;
	b=oo1vjMztGYenr4bOHmM4n5PJJ+PzMFfH5H/MHPjIOh+pErAKIloW8iN0XclwSxvtPPOt
	 0BlAlAZPDGjhArTHTQhCws0VIrEdRvPj2HcCRfSjcuyvUPqFXxBo9IEm5XJafzKIBidmU
	 sBD7WODexBGj0S9v2DqgaDNbl4A9kWyr4KpcYYRHLajzdW4oHfalXarklWIYj6Zn+67Uv
	 e9ijvOyDopjWkJhPdbJAqPhlkI2pm1Osh9sEhXxtmg/Fmz1PeLQ2lgGWdy1K+1r1pDj4u
	 LiDHnDgk8pdmkMzIcthHX0HN2AnLoECrlCXH5eSAQfL2n9xVMslQxGjiTUXYTTx8OJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QoScEWo5;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E25606A8A6
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 11:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E25606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QoScEWo5
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so1036857eec.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567720; x=1795172520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XrQXIIJcWWHsCurNHxzIBKzj+WWkbswf8BCsQIq75cU=;
        b=QoScEWo5v5xuUnykj2i71ZG+ixB3qmy6gmDh7j7qPyzKZvXBsWfvMPfrLtSxyebLTT
         ghm6WSr7XDsuwPgIK7yq45JM4MHJ2vIE+/8wAaeeBtsZ9l0jEgqqIlq/rP2GWnm+fRPi
         JObAx1icFUlLtPFfEwLZloJ+W9ju50CTzX/l7uck2J4xciCb6OQqqEKgSxnDt02I9UUl
         CIEx+fsRa6YcOn8RgWCnHYDvaqFMjbOrZpfGYY1kQ84KU0XAHN7lbbLIvBm3xcuZArlD
         y3/wUPhhAP+D/Ar+qdspq5R7dEffAak32FxHfC8Z+RSODqd3vJdb1un6Z7R85iGfqCz/
         yA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567720; x=1795172520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrQXIIJcWWHsCurNHxzIBKzj+WWkbswf8BCsQIq75cU=;
        b=vkZlY9mh6s2njH53bKmaF/OAD9gyMM0xzpfXUMGRRm2mhItcFhXYUHq08lN3KPZ4o9
         DWZqUZczCD4/LP9aLZhe/1tytE5ULUsihSh8j9jGuERf6XzxJ18T7AxOzAuadUojcCzc
         76DL2LD2ZsVc7zRw5IT2/aWVwC2nyIxLsosHCHeOUrqOV/RkBqELHG+EBx6cqTZvk1j+
         /eJj9SsDkYm1QCuFWN3Xz95Vq6Iq4FA4ckq/rVpZDkKsEoSctaNFdTYk/ohEtjTc/MyP
         oUaEuwcAbhfo9csB4Ju8/hkOvakcOWsyUJyE0nKMv6RUFM83gNDiEH0a04cOrB7s3CrD
         idQQ==
X-Forwarded-Encrypted: i=1; AL+hErHuP1skXOEePYYleU8UvX0fO/oK+Fr0HyCdCtp9RAmw+uobLK5uMpYzvh6E2NLCUUWjt0+WwoRDpj8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WPrJHMByvMBSiaGVc+Dw1wtGtfBedT1wwxxUOUVZCR0Mk2Gl3
	ahe+VIa1/1wcitXh5jZYXAvlW+V7pYhLkmhuy39SC49AWoG6dbrhyZOoSe7TMi5v+rto1g==
X-Gm-Gg: AYBFou10ek/lASutR2VRglyiVuRCkDeOAgr8HcxPRGYPsdomg2zWJs9cLIeFFUkSaA5
	kwNYlA1qz9d30MQH4/gNwLfZhLiG2Hmru1NG+vmpx1/s9jgF0p2CdTokvGsqnsGm/7u3qCrGPXm
	9KEATvWLOQXYr2rz6rNXyOaZT6ctnj3bxSZntjYtDTNHBVrXeQv/ivRIa9nN34yt6Mo66AJlDm4
	3j0wTbfdU1gSv7cM7W9UaqQH44nLa/YHZWzBs2PFRzP4mxT+hjTzkuYt0VNfcxSM7m7k+/VctuO
	fYj437FGKC+wFgb3Loxp3lE+W4i8ZiEHIrVRTOZn2/xJT5nUyNrPVbbbEMgwTU/29M6K0ghE5Oe
	hdVi4eNX/7XjIMqeN0nUoBGvENtdNryOU7QKGedHge9JKg67y5+hCE+ZJc7y8tlvjdRsKc/Ifci
	5ckWLFyU+gcAp54lfWH8Tit5wVsXc9QdpewvsaAsQ6DiHxmQBU8LNXwCFUqh3NUHsWNcmy/ghJZ
	GZWdQmVOR0FzrQofVERlBU/XFN0QSK3mtM0uUEuYABz+sCtFeWq0tQtgtTcHxTLI32Ci+FhkElS
	NwYbIE1DxLYVXs4VzEorbtiP0VIr9cNot8JowxbyjLXW1MP3beAVY0muBaljPbtXwx0xFVOoFwy
	vFG0LVK92oYAGO7jauMS3NdQaJ5fTPgkk2780uw==
X-Received: by 2002:a05:7300:f794:b0:351:207d:bff4 with SMTP id 5a478bee46e88-37963376965mr1902056eec.4.1794567718572;
        Fri, 13 Nov 2026 03:01:58 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm6461589eec.10.2026.11.13.03.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:01:58 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Parthiban Nallathambi <pn@denx.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: light: vcnl4035: Fix swapped raw channel readings
Date: Fri, 13 Nov 2026 11:01:23 +0000
Message-ID: <20261113110123.96084-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The IIO_LIGHT channel has channel number 0 and the IIO_INTENSITY
channel has channel number 1. vcnl4035_read_info_raw() selects the ALS
register for a nonzero channel number, so in_illuminance_raw returns
the white-channel sample and in_intensity_both_raw returns the ALS
sample. This also causes the illuminance scale to be applied to a
white-channel sample.

Select the ALS data register for IIO_LIGHT and the white data register
for the intensity channel.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Link: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/iio/light/vcnl4035.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index f1cc75245001..4bbb3b458eb5 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -156,7 +156,7 @@ static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	if (chan->channel)
+	if (chan->type == IIO_LIGHT)
 		reg = VCNL4035_ALS_DATA;
 	else
 		reg = VCNL4035_WHITE_DATA;

base-commit: 9752760146e642f3e4a2ec860f8767fa72030d2c
