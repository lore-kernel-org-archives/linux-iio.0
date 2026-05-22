Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6531E5207
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413144; cv=none; b=qgGMKDhGxN0o2DvwWIo3xURvWwoDB/W9l6nl5qu4X6BsOZS7x8WemD2H40U6pzsmngPS89MGPxRpxPwNirXVdviBVXcAWxw8NNv/ZVdS9jmzCUb0hSRc+qXIA0/l4JYLJqUJ4h0CMgUR8w9t5y0on1mE35EtqTHW8ful6rYD8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413144; c=relaxed/simple;
	bh=meNlnmmcCErRmtN5Q8uakEi614HtX8GhsUthztF+AeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I+peb40RX/dgUDYd5g8oT32Fq69bHIugnAE/8r0olNfDHo7q+38WzziS+m285rW8vrX/B3cryKVFSB3Tz58GfISJlmgUuJxVEu03GM13DUpGN0LlEZZ7a9RwIe7Tyc/SBHapMYyYgqRIPHYXj2fh+HE0Z2K7LF2zH60s/GO/oGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=aFvd+aP1; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="aFvd+aP1"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dca00c1591so1954697a34.3
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 18:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779413140; x=1780017940; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hA2gvcZ3PxG/BnJk7WhvBYIZEP6nJl42pt/2zxF+RLk=;
        b=aFvd+aP1yUL2FbfI4mS4s29i4B5we+AifWgPlRBre4qqrFvgqf44lMl0fsVB6wSmjk
         XDfUBhRztwPKF08zs+TLrLzShUeI/eSwVRT34b/d0WCkGUTwk6+npeyGLT37lXBiPN7u
         2jsb8bTa38bjkSiThr079H11PSo+CoFlZNMRphrHTBeqEfrFIWXpYlFbe1xDjakSkc07
         LT0X/4vyHSxRT7bF5rMJRGI+oP9gw4UFcj1Sd4bABgYqi7ac8D0ndW7ODhhsCFQgcB3v
         YWwoBcWPm6s2rDGLx3RmPAvYwQJggVkMOHinKyZ+ECH7sy904Yi+jmkplxOTQdEq6uaX
         M1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779413140; x=1780017940;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA2gvcZ3PxG/BnJk7WhvBYIZEP6nJl42pt/2zxF+RLk=;
        b=fA9DYcK3TGxAjluufdw5ypDbxTrkqgTlni6yslj/XOzBsOwb66RUXD6yeWNW6ITRlg
         Pz5tSAa+Lqmu1O5Cv1grgYistsFJPz3LhBqOpeD8SYuDHsbCub9iNHSXaKo+R1GKWKiN
         TP430MDaefhzkMUx0PFWMvGPaQOjyl6GF4pYVNTo3NA8m4sraFmLn+8lxrrDQrmxasAV
         x+rXRb6SrUwhvlTbUerrn9Yn5ekDeepjb/fKY7D4Wwla0p4KYG1mKQuh/RLcVozwrX17
         y/CNaGnIsRU1DYnxFhkVrT0xY7uArOxQWxk+XuAEQv41KatFUVSe5mYT5agGcJiE0Ht5
         0m3A==
X-Gm-Message-State: AOJu0YwjmC3stBP3oNgffQSUvUtO0NttikkrHLKp9qph41tMaNLrmx60
	+DydFrpVVXi5mWbiAPmWOnbEEQGC8V3tsyNWgqEiHD1AJ/+ibOvjPdGuZ3UaT9YxSqvfrZQV5Tn
	FydFWaIc=
X-Gm-Gg: Acq92OFnmguNFzR93S2/5FgNlNmIcS3XuiyUkTOnhC5VOqn0EaeqiQW+cUOCM3QHxhI
	sCdVvCymGAwdNXbil5aJ2accuY9fZMZJZUoA/gKMB0+Qmx+87wM5IN7B/mru6f5PlAOqPVlEWRK
	P7ZG/bRFqvYULgY6IbVNKmUKcOOPLxnujTGJXIPIg+8IEsihDolPx0KWOLl3CG59F+3f1FqhR+E
	O4B4CtNmTnV3U7mHtCbkYL0SHdJZHfU3zxERk8/yiLsYmGqPbcEEW1oZ6yVw2BoBxC6merieHvu
	BqJoCYw2Q0Cb4Ax8LSnp6Ij9+K5HFybHGj0yQYJFZXZzaOaEKVfuVu0kNqbImlhvvyqmgdQ10/o
	dqpW3PVRWVPxH/NE2uPxWHjkrQEa60XooxVG/4jmQXDcZOEn01wr5gnLrg83Qn1skPhXZPmvRki
	9XYKrHQIuj0n1jHR0tgSsfJeIY0cFw
X-Received: by 2002:a05:6820:498b:b0:694:a2c9:2d50 with SMTP id 006d021491bc7-69d7ece3888mr708153eaf.59.1779413139688;
        Thu, 21 May 2026 18:25:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:569b:86c6:c367:5139])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83a4eee4sm121768eaf.10.2026.05.21.18.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 18:25:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 21 May 2026 20:25:29 -0500
Subject: [PATCH] iio: humidity: ens210: remove compiler warning workaround
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-iio-humidity-ens210-remove-hack-v1-1-9528ac1b384b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBA0auQWTtJ29ASvYpxUcpIB0NrOkA0h
 Ltbdfk2/+8gVJgELs0OhTYWzqlCnxoI0aeRkIdqMMo4ZY1G5oxxnXng5Y2UxGiFhea8EUYfHtg
 F6117drbtAtTKs9CdX7/D9fa3rP1EYflm4Tg+7UE1U4MAAAA=
X-Change-ID: 20260521-iio-humidity-ens210-remove-hack-7c5a6496547c
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=meNlnmmcCErRmtN5Q8uakEi614HtX8GhsUthztF+AeI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqD7CLamtm2lN/Csp2zizg2L4IAAZQLddI4kk1c
 IiufwMQ3A6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCag+wiwAKCRDCzCAB/wGP
 wF+XB/4sDrBd7LGuFHAYXYRco83eA0WmtcQbAM8GP6AVJf4LtchXth2sDtCCcz9Im0q6UIL0mQT
 BJQ6ExlWIRjJC/dnqAaMUeaKYNwRUf5k9bbaKm6wb58C8PEUhcgFQkdqL388VEYzMI1cMyzd5jW
 hObn7UzcKmFcSFU+2yMI5dX4RaVNMaTniLcow2c8g4ZcoRe0KYe+tamdkbVolk1e5lFU8XrQKkm
 IDuPFV1LNC6zFeAt2VxuafF7CKRLM43TSlb3bc18NDR0BBVs5wi4l53wxkYNLUoexZ7pxfUq26f
 Bzf+D7bm6vM8DK0Qg6iKn7F1t4/jpFj5NthGkTfUevjBBioF
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rewrite IIO_CHAN_INFO_RAW case to avoid needing to add unreachable code
to work around a compiler warning.

When scoped_guard() was first introduced, compilers could not see when
it returned unconditionally from inside the hidden for loop. This has
since been fixed in the macro definition. So removing the `return
-EINVAL` should be enough. Still, we can improve readability, decrease
indentation and avoid the hidden for loop by rewriting the case without
scoped_guard().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/humidity/ens210.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 22ad208e6aa6..49543fc389bf 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -149,15 +149,16 @@ static int ens210_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		scoped_guard(mutex, &data->lock) {
-			ret = ens210_get_measurement(
-				indio_dev, channel->type == IIO_TEMP, val);
-			if (ret)
-				return ret;
-			return IIO_VAL_INT;
-		}
-		return -EINVAL; /* compiler warning workaround */
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&data->lock);
+
+		ret = ens210_get_measurement(indio_dev, channel->type == IIO_TEMP,
+					     val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		if (channel->type == IIO_TEMP) {
 			*val = 15;

---
base-commit: e1a29334a9c043defe7a9363fa76d399d3fdfbec
change-id: 20260521-iio-humidity-ens210-remove-hack-7c5a6496547c

Best regards,
--  
David Lechner <dlechner@baylibre.com>

