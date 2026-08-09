Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD82F3C37
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786254909; cv=none; b=ZWV/E72/J2PFTd95euml1rV79txQo1O3hLz1PTFj51TqGgw7+XDYcWc9kaE5SSPkSR3PtIvQIVsH+j2b9LJ+X0KlWHrxC9q2Lyt+Kkw/woVjHFj241qyj0Rt2cYPE+0yMnjjSzDJe+eqOnWH9MshBc5EJ0212Xb3K5hQNDNE0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786254909; c=relaxed/simple;
	bh=B+c2pKvqi++PEZyBteJQHtBcjL2yh0u5LqizqDOzpMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiI+d78xkXOrXBNtsNhxsphhmvMM7bC0nPnsW3NC6dqid5eLGOYrpjPN9E7r/37fDw+Uldn0sqY3tSxRt6SQ6ers35uT+GzHgyi8AGU4n3BXdLM9+xjwrP5z22czroZaRBWCEfJIzrIdrt3ztxj7NISvCz27glBv53l/dTp/0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXEb2c3i; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXEb2c3i"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so736190a12.3
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 22:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786254908; x=1786859708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CehgxbX+uIsr9VLyi5jm78aSD7vYR8WIjTWSVAm23q0=;
        b=kXEb2c3iVZXVbsRRb/O1Oi5YbDmmY/cfARSrJy5Eor+kgjJOf0NynCvT2/3DOUsBUv
         J71AOgErb1gbGejmRDHjc5T+fMCekUpp+UJ3jC/K2Xr8B4ueEPHneztZVkMOg8Fmo/Uv
         uFYzl2znYRMmTZGv6b/9K/00rUYSQ7jTYybsPiqgS4CaAsivKweT6fDGgGehIJo/TpTt
         BLhRW11qTQAbv7R2jyHxb9J2fQwupdD/glLfXEYQfcII/zBJb1GkjcP9GhI8PF1sWb+H
         n6uPa1zDTAS2OpQzQESXiGe+nq395uWZZnVVkG0HUbqarg3MU07tE20xMH7n4oaNBG2k
         OHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786254908; x=1786859708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CehgxbX+uIsr9VLyi5jm78aSD7vYR8WIjTWSVAm23q0=;
        b=S7qRKFzM0yETA3kzIPxh3OdEEbfuRVuBCMdFUOaQY7952AKWkM5Wp2Ym4E38yVg9Cq
         LknZdMN2mqk1lMxvx13956HDCgE5guVtRhqcURSEOJYxjauNUMby10xfi5r9xL7GTnoX
         yWanOHBRFUs31Hl/+b3uZcdv8K9vFBuWpDEYKE5OwzJ6lO13shim58XIU8ViS0gTyAY9
         0u4SUExwisH33DOaxZryCXgtkOeRfXvq5BcpHi3vEDrmN23gEoRQWCCfq7JhbByU4tYH
         xFGquCHuDyLFlCJC1MhqkJiltVIgemQGVqdy8v6ztSH7+fnAJdOX0AnfzDSLU9C781uz
         n2bA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9/VgZyEvCjleP341lMrTC/nsHjOWLcfr97WtgdoWh91wvxg0BImTwLvWEemUOG5V+UVLojtIZeWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3Vv/4bubeeYH00AVknQtiKQiQ8S4PN4f+1DO8XhIPeJtKbrP
	Eh2GpXAnzg9/g9uXBtWtiCBtLIHa7wi1y0sp3MJdSmqQ+UmFY869/7lP
X-Gm-Gg: AR+sD10BK+gXHw1jWZ9f9oHoq/8uq26SDLRPbcToiS7Umvvq4Z7IyahAYjfE8jSHtxz
	5D7ZoKpNe0Tt6uM55BxCprLNtrEgiM6ilmhSJnFLfkDfZPFdKVCK/gdMWq7No2gSm9qLKgl+vVJ
	QRumCHz4ho59iAy7xPGhOyUlxBki37lulRKGgR05sLGQ9HWkqwhsC3vMeM0uLljTJUTJkufI38v
	rdEEsNWEm2Be+1SZDrUc+g6VVNLY5KvBS167J1OlI3PPkkatmZfXoq5rUcI1w0vCvGfdrwO5jy8
	7P/FD9IHvuG7UbzKasvgaJjvC8xIKbgZhN24YMKCQ0/ZcZ6t8wUaRAEZVDhTP/eUAj+aieLLd+U
	vIHi39QBLVadK7TuUIi43dNrwm5JHosNMiU0QjxTJ/j2Jb+P+zL3kIJTkTWwMSKyd8vP6QD9hJq
	OPbwF+NKOQYaq/JEb7Eu5/e1o24U8zmhLFBLjc4gv9XzZRHyxhnaRDGTUhQOv5zQavsGuE9w4Ll
	U/BQpRW
X-Received: by 2002:a05:6a20:4322:b0:3c3:b57b:6285 with SMTP id adf61e73a8af0-3cbc01b4a9bmr13416174637.13.1786254907703;
        Sat, 08 Aug 2026 22:55:07 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:1066:5a44:383d:b342:28d9:ba64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199bfd8sm22311869c88.2.2026.08.08.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 22:55:07 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH v2] iio: accel: bmc150: use IIO_DECLARE_BUFFER_WITH_TS
Date: Sun,  9 Aug 2026 11:24:42 +0530
Message-ID: <20260809055442.434972-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808220236.421832-1-yashsuthar983@gmail.com>
References: <20260808220236.421832-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace bmc150_accel_data plain buffer with IIO_DECLARE_BUFFER_WITH_TS()
that also keep timestamp aligned.

Fixes: bd7fe5b71918 ("iio: accel: BMC150 accel support")
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
v2:
- Rewrap commit message.
- Add Fixes tag.

 drivers/iio/accel/bmc150-accel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index e8f26198359f..e0773533efeb 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -64,7 +64,7 @@ struct bmc150_accel_data {
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;
 	u8 fifo_mode, watermark;
-	s16 buffer[8];
+	IIO_DECLARE_BUFFER_WITH_TS(s16, buffer, 3);
 	/*
 	 * Ensure there is sufficient space and correct alignment for
 	 * the timestamp if enabled
-- 
2.43.0

