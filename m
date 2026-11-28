Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795842657;
	b=vD09/e511HKFgA86Fyct9vrJo0+Dva0E2lRFEvJOAzPtJ3hNcZQK5bXiczESpCdetSh6
	 8YcPq4aBsDck86atHbFmyB5wS1ivGr9KKF5BFvgKrrTgxEmXo5zr4Kqq06MADZxsjorrO
	 mEzC9WuF28c7ud6nGSTmsDuB8Rd06BQWp7xReKwR3CATkL3xOfprA+WAkyyif/3FFAQMt
	 LAt4JHw0pi4DBjLDMFmkHcJWCIghMy0Lho4fpYjvGy7PPWsbcuomSe1z/zirLdEhP5bWZ
	 Nc6oiXQq/n3bICQXL/LKbPafPo9Y7EWS/RYuuXJ6AWHdWAYvzIeSpvonLXYjqlZFDtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795842657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x9xZWip8luZXnDxS+OjpkT9Z9CLW6Z85ZqiBS99dE20=;
	b=QLU/gNHPNrv0Mj0FnVQLOFZZlHN8jys/5GsIh+q2P3OCcmkAk6X4eW6wQ7xQVJosPRH/
	 DTT93kw+UjXhhOPMterV+/vp6Oj4fEIaivv9WUjfBdHz2V20PTBmEXg2mobXaQx4bRern
	 Z6L8UHJq9Gegpzp4rOiJrxM4UyVKml28AvZg4oVK5he267REtCEILPUhgOvjQt8QS0n2h
	 ZirzI9N7GTTmr4GdfG5dpqY+UEMykNna59rXH6YL6/6LyDpMzlsZkn5P+gAr6O/E4JPmp
	 vlDmbHQebI45wcMjSgnjydrBjjeF8U1Ybg+mQrRs1FkhPw8uOo6atP/yFglt3NeQbUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPYs7fRu;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70250606A31C
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 05:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70250606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPYs7fRu
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f0426a65e0so52476905ad.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 21:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795842657; x=1796447457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9xZWip8luZXnDxS+OjpkT9Z9CLW6Z85ZqiBS99dE20=;
        b=HPYs7fRu4veF0mBxFtjhQqwYiVraIYzZTIoppROgCyRT86hxDkw9JkRaTI9IpSZux7
         j4PUqsNxwL/hB90terOvF8Ct6jDOdyeWQsCkJFSmowg7XAZ0HYDhrE63ZbF1Bl8buBSp
         8x+s0V2qp8J2fMIxjnO8O1GaGluF58Wx7DkTB9f0Bo0PVDGyDF6E0psnVfhsWXAuswFk
         TZDAWeiUe1IjDq5PLaZAUCpqMGeaDZIcanzKto+vzM6FjrM8HJ1I0IJbxUkLwR8FkN2X
         7XYPHnij3zyyhc7JELWkJzKYwzmdBwaGrCAywgPWWRM1ImuRCcd2rSyxIQGp0P9wHtrN
         60Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795842657; x=1796447457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9xZWip8luZXnDxS+OjpkT9Z9CLW6Z85ZqiBS99dE20=;
        b=1lxTTXFeFPf2ZBcDGMVUOmsii97qPT2bwbXRte26Y7cTR7vbF2D8Z+8GDNWKqMN5/7
         NwUbX2tBvdgwycuNfd9SilIP+5i0beZ9cOwMDqGt4o6qpfqFSsYUu1HAtHyIvEAqJPvh
         YWmYH7oO8rIWnhxNUkU42KikevaN6huYyEGk+VW/9fNZOwHWXhgnEJY7tY3OPhz6Kvx0
         oPT1AIkF20q0vrEvoMdLY3Tzrw9rzyNL8pP7d1+UxnwJBRfSjZPNju8P3VCngPHYgViF
         HEfkmoqUtqPgpVBOvZlkZPJ5524c9cK2ME0rGfmeHUghefQZnOtPAPCVvb7GKwkLvINN
         oLfw==
X-Forwarded-Encrypted: i=1; AL+hErHrSOxC7O4fKauE6upo/oq/XkNhurIWqi3Ypp4gf0iKEuTgks1q0Qo0/WCV66cmFcn/gqYXcXpBVG4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eGBnJ3qOL8KAhDgTVqmW4CI0OZimh+kOBTVBeAB+EHjf8xwhx
	WoiNA8i6mQqRzi5xSQXVhwB7kWKZSO+VxMGDn+BmGUljOf+uO3q6h2awFs0K4Alg
X-Gm-Gg: AZFdTZcsg82aJdI9/HbdKbWlJccv3AL0g09F9KnyaG1697QojesMkFWC3gXsvVrm6XG
	XK/DgcyXSvujsx48E3Zn296V8rODbfMLhWiZoPMzlg3Mll2y0VYDSTkWSAA7zqTSi7+PI/hXoHb
	CTFy3EUfJqREEr+fPcu2dw97ikYWa4wtyhBFkjF7cXSF2cYRPJstdnFSGCnyEZVKab1PdQATSHk
	YUmfXBSQ/YGNudhm4Q6ELKSShLoJPxuPnzNKyvGB5LpTy1BATfvmb5osUBdhgIvrfhWpIGJsATb
	pu0Jg7W5gOQjyy8gG5Z8BboxXH05q6J6C92F6MjSEZA9heYCAt0airCBgFw7R4AGEtzAmojm+o9
	4lC3MwU0BgEdmX7t85+FgZ+N+GHsjsjpbDUu8bsuLjdmEJQyxJm+zYVo1u2ndsD7GhQu5yonAOL
	YDlJCyZ3mz5VFnZKFYwEw4ztnL9TVMzSZx4+IwbK/XhCZWuFNJ+FvzNfc9Ld1JS0ROwmHshMsVG
	38I0hpbf9JoqaKEIUI8jN7dKZeijo7hW0paYZKPmqq0YjF4sz57DCqqO8ZlU5o5Lb4wxTQq/oX9
	ZL0bNci6IzubHqcSVKH8r3ydyvk4nnh5BHqiRil2X1vzBtOwJoN6N3IypEJXTjEtZh2MBIacl74
	DmA==
X-Received: by 2002:a17:902:f70f:b0:2ed:218:6043 with SMTP id d9443c01a7336-2f03f256f8emr220742965ad.59.1795842656745;
        Fri, 27 Nov 2026 21:10:56 -0800 (PST)
Received: from LDYT9Q2G2M ([2a09:bac5:cad0:1caa::2db:4c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42b1sm129676645ad.17.2026.11.27.21.10.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 21:10:56 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	linux-iio@vger.kernel.org,
	Zhiqi Zhang <zhiqizhangg@gmail.com>
Subject: [PATCH v3] iio: chemical: pms7003: Reject frames with invalid length
Date: Sat, 28 Nov 2026 13:10:50 +0800
Message-ID: <20261128051050.20829-1-zhiqizhangg@gmail.com>
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

Reject data lengths shorter than the checksum before storing the expected
frame length. Keep other lengths up to the frame buffer size accepted so
short command replies and compatible Plantower measurement frames can
still complete.

Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Tooling disclosure: I found this bug. OpenAI Codex helped prepare the
fix, and I reviewed the changes.

Changes in v3:
- Move the tooling disclosure below the '---' line as requested by Andy
  Shevchenko.
- Drop the Fixes and stable Cc tags as requested by Jonathan Cameron.
- Pick up Arnav Kapoor's Reviewed-by tag.

Changes in v2:
- Accept frame data lengths from PMS7003_CHECKSUM_LENGTH through
  PMS7003_MAX_DATA_LENGTH instead of only PMS7003_MAX_DATA_LENGTH.
- Drop the extra length check in pms7003_frame_is_okay().

 drivers/iio/chemical/pms7003.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index c50edb24a..70e7575c0 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -231,7 +231,8 @@ static size_t pms7003_receive_buf(struct serdev_device *serdev, const u8 *buf,
 			return 2;
 
 		num = get_unaligned_be16(buf + 2);
-		if (num <= PMS7003_MAX_DATA_LENGTH) {
+		if (num >= PMS7003_CHECKSUM_LENGTH &&
+		    num <= PMS7003_MAX_DATA_LENGTH) {
 			frame->expected_length = num;
 			frame->length = 0;
 		}
-- 
2.54.0 (Apple Git-157)

