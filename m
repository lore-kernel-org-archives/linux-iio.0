Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6F37A496
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703802; cv=none; b=B/6IKWIkWqeLdiuY7leU+zmB3ggJy3fBtJ+AFMvm+8qYU6HIBnp0nYdRn+FskgjBcr+t6uSnLP0cVRaE7Zx/XEKw1fVEsL9dkMqvA4ewD5Dy6hSZpyf7YPxRwwmMfzKErTwALggSoeGcO9Ul/FY68QVEAVr80cP5IARQ1EHxVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703802; c=relaxed/simple;
	bh=/XG7yJ8WW4T07br25rZkcU0UNJbVXx/u2NFLZybPy8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpCpl2G4e9D2lPxAI3aqWXEiB7/cPV5BoyZrQ6OlHAORh+oD1x7hOC5rPVpLR0y6IYNazYiaD4jQYDYBrxXa5KvcyOMvLo+uWsCnf3p7KxX6yzSkUAtb0LCutSJ4V+VMksLxyX6JltJZyMjbnHlMv9R5UR/MZ0FYks6jPyXUfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWbLC8OT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWbLC8OT"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35b9ed7a329so921112a91.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773703800; x=1774308600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OujDTKctKirf6Qr6O7wmP+aSYnvHOSR2UUmvgUln9k=;
        b=hWbLC8OTB2pVLehyM4XOLUQP7hS82SXS9XHb0tE0pj11TrXcAQxYaNdVGjMv+BYylC
         ydwGwTYX7wrRcwlBhv5EQ+iKN0G6KE1I/LHrPVoW6Ql5G4Kyuf5MkT/ggZdPGQKop0fP
         YZJNiiB8/o1NSXFPuVwYNe1sRZioxAIaiis2+MuITW2tEXX4gQMs//OOx+aWNBitykNS
         bElLoVCfR33B3u8Oq5kOLnPVYqIpxsIdeKccHPu/Q3/0HKnsuYcauXWquKnXnDoU6qy1
         w7qR9MqTyt2GOgL1Pez2OJlPwvKnsF/H8YD29/gaMc3MHN/ITll9ENJgxHtdXoguWlKs
         cLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703800; x=1774308600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OujDTKctKirf6Qr6O7wmP+aSYnvHOSR2UUmvgUln9k=;
        b=hzib3indD5c+XZmlPTRrykbkzYJr3AxXTTZwkNXC5ylQCBYo3L9wCW3avwbjzdLN9z
         y4SvolkF5+HU9QAkD8VmuGCiuT9jYz8w75P0LcXEsZ7qUtibBueiP+2nTRdDnc8Uno9h
         AX7v3GJzRtqPFONi7OrId+Co5DY1V5h/kyRZMDEq0Zkv7ked37keHSTfPlALZ1e69OVy
         8Cx+helxw29uL/4BEdNeVQHR+TgZlHfiUWXZZHs2TGC6T34LOskITeot1KouRl9pF3Tu
         TjLXaP7bJa0DM8e36Q+X6bgMmYtVEQDYpkl9ag4IecD2Czpyf78oFzzThxYhd0dPC/Pc
         XuXA==
X-Gm-Message-State: AOJu0Yw+6xqJaTnftpvtGReuv1/nR/87jE8ogTLyyA80IxEPpoNNFRJm
	1sxQ0s4bPR+jSGRfGEwrlr1HxgeC5Gf2lli9cti5FKOKJ/nJ/9eV33qvW8/JQgD0
X-Gm-Gg: ATEYQzyU9puB5Sw4fh9ilW8nOUkeSGFk/EqmJJMTJagHc43uXUVfb+2XfEGErF0ifGj
	n8BSMIkrY3d7enAutfTw9Xqys3LI6UJu4cQAQsZYEf8nofg6pkfbah0mDaaBHx3fkS5iVEpaRGv
	1/K6YGRp7804jVREb3htLV9UMxncAETwbc0J1526/X00xS3xYu0BtLhc/7jeOSrDJFfh3rQi+/u
	/mA84VhBClRNzYLNKO7MvrWlMuWhA8JPSeBMx2h9WzinKxzt8P/K+7um68dVycgCyTqp9aUlrFV
	Dx1EGdz3DfUxcrVzNxuKtXjWNECMPSIfvoO7Z06pazZQ4LPNN8SytYIWPBcw18XUepcDIygk0N0
	xRNt7HaP/q6hKRh5WuRy0tJ03syUcLUf63uFaV9r7Gcm/SmNCiWoDtmFvOEFU4uvUmkjfeD0rOg
	H14uHWzptUklX/Th51zYewDmOZTCM54b1+wpbKWPzxyheDux9bJeawuHA=
X-Received: by 2002:a17:90b:1cc4:b0:35b:9958:4edd with SMTP id 98e67ed59e1d1-35b99585066mr5424597a91.30.1773703799728;
        Mon, 16 Mar 2026 16:29:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35badbcdad9sm868164a91.16.2026.03.16.16.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:29:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] iio: iio-mux: use flexible array member
Date: Mon, 16 Mar 2026 16:29:42 -0700
Message-ID: <20260316232942.46641-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it clear that there's trailing data

Removes a pointer from the struct.

Use array_size for the sizeof calculations. Slightly cleaner.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use array_size
 drivers/iio/multiplexer/iio-mux.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index b742ca9a99d1..f2bc8f3aad95 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -33,8 +33,8 @@ struct mux {
 	struct iio_channel *parent;
 	struct iio_chan_spec *chan;
 	struct iio_chan_spec_ext_info *ext_info;
-	struct mux_child *child;
 	u32 delay_us;
+	struct mux_child child[];
 };

 static int iio_mux_select(struct mux *mux, int idx)
@@ -381,8 +381,8 @@ static int mux_probe(struct platform_device *pdev)
 	}

 	sizeof_priv = sizeof(*mux);
-	sizeof_priv += sizeof(*mux->child) * children;
-	sizeof_priv += sizeof(*mux->chan) * children;
+	sizeof_priv += array_size(children, sizeof(*mux->child));
+	sizeof_priv += array_size(children, sizeof(*mux->chan));
 	sizeof_priv += sizeof_ext_info;

 	indio_dev = devm_iio_device_alloc(dev, sizeof_priv);
@@ -390,7 +390,6 @@ static int mux_probe(struct platform_device *pdev)
 		return -ENOMEM;

 	mux = iio_priv(indio_dev);
-	mux->child = (struct mux_child *)(mux + 1);
 	mux->chan = (struct iio_chan_spec *)(mux->child + children);

 	platform_set_drvdata(pdev, indio_dev);
--
2.53.0

