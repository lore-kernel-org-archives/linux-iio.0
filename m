Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666758;
	b=1BGCvvHjGPPftlp3sFQZr9ZLj8MN5SyIEgR+Pi2xP+V+KI0ENbQFe9PfR27/wO1R7od6
	 pNblpPVKtjZiHCv8mX0x5KUkG5pya7Xcmd7FV2XOtSu0qQr0Iz6SbMUoNEhfk1IgrnJgw
	 NpYrR9rpsEyhbgqTUiAayU4otigxqXi1qA6/XLHWjno7rEv0GccMVjQ8d1eN6yqmsz2Dj
	 yHkq+O8TBdp6k2pwzXMvdsiHTlmzXB8sQYQnmWw0C7eBvg8UeTjJ/hsavOW01oWOG7Y5l
	 hs5M261RukcYhROBq9T6W9oHxwlfVj1LRJV2jt7pT+806ie7ehKtDhFknVXZ9+baydw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wu5lDuRgkYhHSywuSlGY6BNnn9XlDv9stYOOgzfHduo=;
	b=z4iyl1xJv+6Gq1llmFjJHQPFFhKTONsTDRFVwgZyI28csw7oJe3j80V1JhARKNUUXdCA
	 i8GxBPwKCkyhalfGNK4oNlBqR+lI7mXNMGqY7DckZOtw37fJk7/dNbl+KU8jqTxxRUmeZ
	 l8ljDVGSb0sJFIgS//YZSogR09WiwIgbwA9lHNtRJLTKsg0A0TOrp7d9XOzKV1q+pxvzp
	 IBSEISRQXmi9bWaAdv90rmCjXM37pfmYvGQWoH4u1NbAa5hMEra4WpO+jogFMRSaSr2S3
	 LwzgkyT4z5V49ub1zajzWkoyT8hK+bWGN4a8hfzq7D4v6NvTARPmw89YmOHIcdlMyPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZQcCpc/b";
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B3606A31E
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 105B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZQcCpc/b
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b49a6e8212so2498983a91.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 20:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795666757; x=1796271557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wu5lDuRgkYhHSywuSlGY6BNnn9XlDv9stYOOgzfHduo=;
        b=ZQcCpc/b4moUBO3hNXHKIR5pTa6j4s2brFgmZQXaau8TAb/hc9ZkExV38h2Dv9L+zo
         uBtYJoek0v6a8fiziQ5ywr6BceiHQ1xtBvJOut7FBzVm/jVkybI58Fmy+MQu8DN5OPlg
         2GuOJhPrfW+fzldGmOkEsbqrr3Yw+FUDi0Obec1P1/ctlZlGFS3RsRuSDmyRsqNkWv0r
         GqbHKaQtsL9NWI8NApKbne3TKfTw3j9klqRZynfwPmAqveQ01y6dBDkfR/wG2CiF1JPS
         tUbLAO0p4FqmN8jmXPrMPYeJc+nA5VuMpPFYvf+yeL9WrrRyH2bamALxBZ3I4+8wCVmh
         i6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795666757; x=1796271557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wu5lDuRgkYhHSywuSlGY6BNnn9XlDv9stYOOgzfHduo=;
        b=ZiB6FpznbEuGTPeJ87Xc5oZZBd0AOCMr89A7EyiE1Wi2iFWYGcbj7PDskjRgIjO27z
         MWrPn9L+WY899JAwQWxxZcGlpqAn13XVXDH0ulgc+6DJ0E8FGgo9P8mrahMT3dsikCdh
         BBOfqXq7p6d7U5wd4j0uUu5oNX4SJMz1UwtT6/iRC/WiPUppUO7snfsQOHuuQ27Xv+bI
         bwyYfwLD3QENTq6y0bBDlCjmuYxExhAKlcbmUY2HYkQcc/F2SHX/PtB8Y3pm5JUGZxZ+
         GmoeYa7VIPVcqnM/4gi7zOovZCQBOwDBNBAQyUu37npIuLi85Yv4cNUpFaetf2keeI9Y
         u3Yw==
X-Forwarded-Encrypted: i=1; AL+hErGzzKNCmsYClLCc+TAOCFC4xbTI5kjo0ABa6JDmWVGIFbRVdr2vMeKy/BAu6ajVg7s7vqjfMERvrBY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SyNwVc9En34pXG3Ocr5ntW9TKYc1v2dPzW0qOBXUO+7sqI0lQ
	Nq3CVaR8FgQyjQNHXr8NmwItwv3gb6ypLn+oP6E7xA9asuwHZHmHF+JB
X-Gm-Gg: AZFdTZcnGeoxHAnOjyaLwgcKvG9Wj9oxPJQzoRxQ8xrkNfvVsN6jbgbjiLDxUavq3gW
	0zBkNq+7RLy23ka6hZG7IXCVnX5Ky7nsdjO0ShyoVyoxPuKXH/KuuUJ/ihAbdlFvuhGD1xXFbl+
	TKRjSBjVTo58zgapRP9tA214WgwPCtKWHNLDnwbcQ5IDK4gC42j5R5u2GLp2h2ZkkBO2JVh5oX9
	YE7F+2jk2fc2o+WZ9+C2LTXSkABAgdUM1hOeEp2VywzneTVHE57DU+v6Rnt8OMIzAfY2fuVnLS1
	qydUl5DABInRMtgFi/XSPFrK/W6jbJJiSbyn9jk7gQqpkGBSes/0V/ly+ozzHekpXJoOSqunJsn
	FEamvnLk0CluMgWRu56LaZApMPaHzoqFlcyJq2VHGvrA9XxMMGDBZMvpzkgglnPFwgo4mmZFXdv
	3Zo/OuenxBQZEmcTnujalWnMJDap8nGhBotknGPYwqh6syOiB2ESUfOpo2T59FDlkFNxZgqJG+K
	BbxJrebd9YHvLRI5bCzGoeO7/18QRwk5LR562F/Y9/tr2CbJ02U+VxH/YTGOhbWqsdjX1ygpnEB
	Fc2NaH1FDFNzDjDFaamuvWeee3ARpZAeVN07XwWbX3FxSKN+b+G8g5TTibV/wUJI+JsJvbHzAcw
	3nwTbXvtOm808HAAIT8m9
X-Received: by 2002:a17:90b:5543:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3b41caeca54mr18611047a91.36.1795666757269;
        Wed, 25 Nov 2026 20:19:17 -0800 (PST)
Received: from LDYT9Q2G2M.pvgl.sap.corp ([2a09:bac5:cad0:1caa::2db:4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm30527530a91.9.2026.11.25.20.19.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 20:19:16 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	stable@vger.kernel.org,
	Zhiqi Zhang <zhiqizhangg@gmail.com>
Subject: [PATCH] iio: chemical: pms7003: Reject frames with invalid length
Date: Thu, 26 Nov 2026 12:19:11 +0800
Message-ID: <20261126041911.55827-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The PMS7003 driver accepts any frame data length up to the size of its
frame buffer. This lets a device send a frame with a length shorter than
the two checksum bytes. When that frame is completed,
pms7003_frame_is_okay() subtracts PMS7003_CHECKSUM_LENGTH and reads the
checksum from before frame->data.

Lengths that are at least two bytes but shorter than the fixed PMS7003
data payload can also pass checksum validation and leave the later PM
reads using bytes that were never received for the current frame.

Accept only the fixed 28-byte PMS7003 data payload and make the checksum
helper reject any other length before deriving the checksum offset.

Tooling disclosure: I found this bug. OpenAI Codex helped prepare the
fix, and I reviewed the changes.

Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
 drivers/iio/chemical/pms7003.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index c50edb24a..4f62b5092 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -206,7 +206,12 @@ static u16 pms7003_calc_checksum(struct pms7003_frame *frame)
 static bool pms7003_frame_is_okay(struct pms7003_frame *frame)
 {
 	int offset = frame->length - PMS7003_CHECKSUM_LENGTH;
-	u16 checksum = get_unaligned_be16(frame->data + offset);
+	u16 checksum;
+
+	if (frame->length != PMS7003_MAX_DATA_LENGTH)
+		return false;
+
+	checksum = get_unaligned_be16(frame->data + offset);
 
 	return checksum == pms7003_calc_checksum(frame);
 }
@@ -231,7 +236,7 @@ static size_t pms7003_receive_buf(struct serdev_device *serdev, const u8 *buf,
 			return 2;
 
 		num = get_unaligned_be16(buf + 2);
-		if (num <= PMS7003_MAX_DATA_LENGTH) {
+		if (num == PMS7003_MAX_DATA_LENGTH) {
 			frame->expected_length = num;
 			frame->length = 0;
 		}
-- 
2.54.0 (Apple Git-157)

