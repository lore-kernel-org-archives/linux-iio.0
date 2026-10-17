Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0947F3C7
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230418; cv=none; b=ixhfzT4Us6MLv/oyBeiWawOfDSGA1E0Qi4bjBBwrCuFcAyi5OW/bpBgXr+OhqCIjvF2gYJysV98WxLBCn2ejMtnmqsWiwU0EIBREsYrmzfK6tRfidd4D1/DpLVUbfMJXC0eF1b+1pFhg67k6QiBGXGJKMOR6AQfyyR08xyBqVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230418; c=relaxed/simple;
	bh=+VI8/d3lnZDa+xcOD2YfuTIpLOKrWMyzcnSDAv9p91s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LZsQDeXeASbuNlrxiWnnoCQszongk3cWWMwkCqEk+PnSmCbf+y1qLXpy8JZuM1RK2y1A2Bz/eWMI11PjYjI0tgY3ykJRb87rtlu7z48czFfEewycC6ZSENOFOkIVJ5Xsmjt7XbgzC8GeMUi1wE1miRdDUmpA8Ve+HWTt5+kc8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6618hkp; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6618hkp"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so898983eec.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792230415; x=1792835215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=38+wpYROyyabUyi5vQ70P++iJLb+AS+U91iM8zmq47c=;
        b=H6618hkptIPTgqXllU/WGnT3/Gesj0+IOUoJVHPKJtqldmtnhQ+cng9oY/1JLxcOLi
         yGR22r9rQuZDWSxK0XMLM5/3oYTVnvLqp81IKPBo2q5J5OvJ2x4jOP2cdA9Bh7Ef59Fw
         IMYHYQJq/Oi7YQv7TSLHKOuoX38BZOsXrwLjG+woKF3Q+RttKdLD3KXpv1WQVazB6+U+
         P+DmIwjBd0NNzF6tc2bGK13M8n7SpntC+nWGc3w1awH90V2nuQ0Usz6YLCCZnZtgz0w+
         PUpVNigHzxSZW7idyXQmBDW1GvpN1GGZPr5sUnh1WBMlvWDaJ1MqiZRn62imSPyNZGC4
         oy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792230415; x=1792835215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38+wpYROyyabUyi5vQ70P++iJLb+AS+U91iM8zmq47c=;
        b=dUq6Qw6vYvdeNeNYnodYzxC+BlLVqAKjR0CJkLjO5MF1/D0OxMe9FWlIIZrMe1yQDA
         QpF7bNdTuWg04cwxYrqjfDVeLK340e9FavFF8Q8LycUunLsXC6yKk7wyADzs57+kFHyE
         eHxDFxWAZcCTU6Hm7FbZrTo+HjLAWppK8Hq5Q4BYB6iUSTLsxb+q1/qCNlWaitXZil3N
         vj6DKrny8Lo6p3ErFRC7BVFn04qTXvFl3razPTJdlG9xY7J+HgrCnW11EdrU0MahpHoY
         hH79V9QLXV2iYgDl8u99dMVaTqJC5E27ch8TPLmkf3OcsIsKZpzPTn6elxjW6juwvCRL
         i0Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwSLRg0QIv2k+ZjcJWcK5qQEWdvvKnbExWkKYC0V+ZdW8dashU/r2bJi3uPR7yvlQqR36f8zwEWZMg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIu5L4NRNgAbmPPdofTdrmFzfWNJOGttF3F7UFfwxl537aHXMT8
	VTnQupyinFZ1cW/+AcwRwcjXgYkMFGU88/5eLnZSrHOkDmhaWSeVZVc=
X-Gm-Gg: AYBFou24PMxmEusWWe/6Y+ISWQcPUQyZQq7Bjy1cObOoRm0P5yLOpt7nX+AUob1rjQ7
	zsxGFCyoCkHTSwSiLtWVajgQ+ghiqo+A6WBuHN5n4GxlYmj2maDVMm1JzkxmngTw5Wigcnw1c2p
	3RVrMYHFnJ3xOyac4ZgXjn71HvH0TnYKcAUVxet19KkyLvWb5ihNVnLTvmDtfLipqP5H39RcKT/
	PnZzlUMTwLduBDdAw/5csf5mSSU2/vpQQSujHoD7bqEkdhpc5Ur/+hqKJGV6JlI5sUFsKhPmHNj
	QcJ0sj6NNvIw+Nh48B8hW84b6ZM8s2pAeSJKcUTrOZc4bRjjkEsO+wZx1HJ62NbubEwcmUBfM6L
	in4r4nr3Ewbkv0KtUbi32MdjCMuFbpW/PBm8KsUSyyJQCi1lci/O5tgynIW+4WBAJRB9xyTrzE0
	5SnDdvrKl91eAAkUcQ6kiUrcpFf6VF+cH5VIk2JRhxHLmCGeKpuepJbbsZCsCQVVhdl8sKkTPw4
	Aahy4Hxd3niqTuUnm15cx80Msl1PsheSoRD4w==
X-Received: by 2002:a05:7301:271f:b0:359:bdc8:c9d5 with SMTP id 5a478bee46e88-361a195b1c7mr3854306eec.21.1792230415068;
        Sat, 17 Oct 2026 02:46:55 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm13475852eec.14.2026.10.17.02.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 02:46:53 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: anshulusr@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2] iio: chemical: ags02ma: Check for short I2C reads
Date: Sat, 17 Oct 2026 15:16:39 +0530
Message-Id: <20261017094639.3002-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that the I2C receive operation transfers the expected number
of bytes before accessing the received data.

Return -EIO if the transfer is incomplete.

Fixes: d58013f39b30 ("iio: chemical: add support for Aosong AGS02MA")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/chemical/ags02ma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/chemical/ags02ma.c b/drivers/iio/chemical/ags02ma.c
index 151178d4e8f4..2219965d044f 100644
--- a/drivers/iio/chemical/ags02ma.c
+++ b/drivers/iio/chemical/ags02ma.c
@@ -61,6 +61,12 @@ static int ags02ma_register_read(struct i2c_client *client, u8 reg, u16 delay,
 		return ret;
 	}
 
+	if (ret != sizeof(read_buffer)) {
+		dev_err(&client->dev,
+			"Short read from register 0x%x\n", reg);
+		return -EIO;
+	}
+
 	crc = crc8(ags02ma_crc8_table, (u8 *)&read_buffer.data,
 		   sizeof(read_buffer.data), AGS02MA_CRC8_INIT);
 	if (crc != read_buffer.crc) {
-- 
2.39.5

