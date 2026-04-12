Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6021368946
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775986700; cv=none; b=ctewmTOhfpfxv6fyWIA1DlLOMqUSXhlgy+7vZIFI9Lozz9FmgtKyzxna7bU899yxECL7SchPNzV1EcYOi1Bz0mhVOaqTwK6Gb9VQ+ZViTkKu3Ppyrl17fHOwXSVKg5LQxc1CSXbI7Y5CFIWV16HkxFBM9rpOZ+aig5UtSqZ04Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775986700; c=relaxed/simple;
	bh=jPdCb0q5WEMo6KmG6qwLqObNwDG2gwcqq6+myRFEzSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZuJbZS8U9RhnRoUlo7qEXLJw3fBXvbQDFH/aXIEDt+gW3u2JFd2pXo/LHz0mtup7le4uEROLW64lQHt/Z1DXUF5G4JLn27fs/Hh5cqU4bSRqgC/1T890BXXMbR95QWJbwEs7nQGGsrUoLozQwWFyg4UpMqD4690iIp+y05ypoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IugOTSMt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IugOTSMt"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so1568063b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775986698; x=1776591498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhpgpezcr4Npkqf+9mlvwrcSSNmQUddV4HFFLOvyW/w=;
        b=IugOTSMtHEf4CIg2PQ0W/xddSkE0yZE99lxJB+SfAQHCqF7apZQficGs8DdGX0RzbM
         rJcftqzoU73uHk4XnWIhfctwv8Av+Fiyuj8Px5q/QHT/kyJGtNoUl1O05dMqQxdskWty
         JTQWpmm/bfvwZ/saqFhGNQX+y1ekkCqxdtwoR8R/Ig5RXwhwa9bMnzH+o6Gu5HRixiH9
         Plo95yY6ap+IG2tasHPDABdq3GoHw3MGQ3VzT0rFh7RoQ8KtXf0gYTXb6dUJuVR4OYZ6
         2+aCt1Ug3faFiBzk7gncex0wI1BLWuIO1mxtNlO+TwfUpMBlk8VdYzDl1jtXDOo4MQWI
         mJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775986698; x=1776591498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bhpgpezcr4Npkqf+9mlvwrcSSNmQUddV4HFFLOvyW/w=;
        b=NkflTvcBmvA4eL2OJdgbANukD9zuiMZNVbX/OpbINa5TgJCf/WdTewrTATPHWyvzdn
         Julx7jDViGbmA/awqBDzjzvY8ZZaze/DpgqDZr6kDfc0X3YVISVwl4oUozmZNlM+aVyT
         0p5LAOTmR4uZG9b4zEDYtERFLkKTbxG6pabNXSwD1/Gdc+vbSBtFRdvxJu86mA7L0BeU
         WsStEZUGUk9QF9N75D3XoAKlHJ8AJFz+cdxcBZlEcPNm0WKKy2Ibdwx3apyGiPxTrePN
         tTueczcpDdSUeDiqczEaeBL54jWtFEdziKogG67/v80lx1zYOIcisS1Cy8SZnVTzTJzV
         USGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyrgolCOdycODnK1OzHz3o84Q2pck+b0qracHWIYyekVoHQc9hhNvrBsvMViy6T6cpH1VewvlNgQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYY23VH94JE+czMakidEWHraJsFKlv7t7M6C/JShfrHamHqHja
	WLubqx9RUosALZJYjA/IeWVJIH8Ak1TTwpzxpyaUEDpvke6f6dWofgvh
X-Gm-Gg: AeBDievWQH1p4TdoVts60xkl7hd6WxEzdAPBTQ6xiQMKdfFlfX2wESdboCZueFJtGV/
	EnipDOKT+erzKdh7MibmLp3592lF0OH+MdWd+wNx0jhLWDkWIWTeKuQStUNXb59Tu8nijGft7Fl
	wjBBWBxPGcBM03vIz11BxqOLueO+I7b1vwlXUaDEI6ndntjhQtFCfhw3hqL0TfFpLR49sMTR86A
	6WoqW7q76EAJB1PRZY36whn03pA+hs2rA9L3ld/hF3+LILv6lUlWOtlRZkC80FOnN6MT20PC6pI
	LcyE7xSED58tk3jbq7A2KcrtNcmwPrCRq6EoOztwnXTf9NYAheA71zOzg0RmIuwnT02eHrhLqZ0
	q5guV41v8W6FVXBx+4GHVIDHOtSVJax3n+rU+wfowB6eVfwlWdStpHIowfTCwxWKKgSaONv1r0n
	k1w+bsRoYskLnDgbZPZ+Z6zjIrPOy0e6Pr6nt9/DK+lAaIj0zKmpajO9Ehr5WmrpRZSM8dhzF4
X-Received: by 2002:a05:6a00:4fcf:b0:827:441a:c970 with SMTP id d2e1a72fcca58-82f0c12f194mr9316309b3a.6.1775986698137;
        Sun, 12 Apr 2026 02:38:18 -0700 (PDT)
Received: from debian.ari ([152.56.156.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c36130csm7885038b3a.24.2026.04.12.02.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 02:38:17 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v8 3/5] iio: adc: ad799x: use a static buffer for scan data
Date: Sun, 12 Apr 2026 15:07:37 +0530
Message-Id: <20260412093739.17116-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260412093739.17116-1-architanant5@gmail.com>
References: <20260412093739.17116-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rx_buf is dynamically allocated using kmalloc() every time
ad799x_update_scan_mode() is called. This can lead to memory leaks if
the scan mask is updated multiple times.

Drop the dynamic allocation and replace it with a static buffer at the
end of the state structure using IIO_DECLARE_BUFFER_WITH_TS().
This eliminates the allocation overhead, prevents leaks, and removes
the need for manual kfree() on driver removal.

Suggested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index bf0575585a59..d8389b6e19b5 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -39,6 +39,7 @@
 #include <linux/iio/triggered_buffer.h>
 
 #define AD799X_CHANNEL_SHIFT			4
+#define AD799X_MAX_CHANNELS			8
 
 /*
  * AD7991, AD7995 and AD7999 defines
@@ -133,8 +134,8 @@ struct ad799x_state {
 	unsigned int			id;
 	u16				config;
 
-	u8				*rx_buf;
 	unsigned int			transfer_size;
+	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
 static int ad799x_write_config(struct ad799x_state *st, u16 val)
@@ -217,7 +218,8 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	}
 
 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
-			cmd, st->transfer_size, st->rx_buf);
+						cmd, st->transfer_size,
+						(u8 *)st->rx_buf);
 	if (b_sent < 0)
 		goto out;
 
@@ -234,11 +236,6 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	kfree(st->rx_buf);
-	st->rx_buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!st->rx_buf)
-		return -ENOMEM;
-
 	st->transfer_size = bitmap_weight(scan_mask,
 					  iio_get_masklength(indio_dev)) * 2;
 
@@ -896,7 +893,6 @@ static void ad799x_remove(struct i2c_client *client)
 	if (st->vref)
 		regulator_disable(st->vref);
 	regulator_disable(st->reg);
-	kfree(st->rx_buf);
 }
 
 static int ad799x_suspend(struct device *dev)
-- 
2.39.5

