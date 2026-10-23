Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787179;
	b=cvvghXBnIakSPiT1EEngzejL1DuPEBwoYu9QR2PIbthutbfGp9VCINYeME/ZEIa6rEdS
	 cFgdIVkGJrV0451KZLgxYXv6dA5wV6TrkrTP0TTQp/VFYcPXOlZEGWLw9GR4len4UKHqv
	 Zbz6W0X0Dvo+OFnzvrq5I9K9FNuKi20AHGEiRUT3XfsEZqGF8C8EthvvzK/zJbZmiPK48
	 xz6XCcyXl0ficpjvyimMAK/9p1cs9jPfdpb5jV8AUlzv8zA5X2OPUKHOU4WJXiOKdmT1y
	 4uqXhRew7EKd5ALokhbenLF9G2e+RwhElTJyjUtWAYodWRIOzhlwP5SOGVderLuylSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jMT/0jRYIKZhw47Q26itdzqUKsUFWhPK7paGQJTSrNA=;
	b=oxqlCEvQjyXw6hRrAOa8IMgHwq6IvpUGnsVsi2jv3XNO5llLx/WXMDUb0u0GLOCvXSxk
	 rzXsjudEKnXugeSzgeqi3G5087vHYV5JpejDlkI8b2ya5JEbS69AC27HNlZh9eJJoutJK
	 RZZpNWEvhUBj1Hr5jCroL3JZo3yPD97zUrdeZ5R5Css/MTHWA4ui/cbgBYkPRkUZrYEe3
	 8FWF1dSTejVRAv43Y0jL8qZTu8dyQPOvzrzHkfAKyOh+YoACwhOK2gmIEA15Hntfee+Qy
	 nqw8QzHKS6UGajJ1sDvp7TFgYIkCyKDqPovbO8Zm8L72k+no2GIO3nzVlt+9fg7YGVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="brUqs/ru";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D6606A31A
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 20:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 635D6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=brUqs/ru
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so14430435e9.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792787178; x=1793391978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMT/0jRYIKZhw47Q26itdzqUKsUFWhPK7paGQJTSrNA=;
        b=brUqs/ruabJLhMCyTI1qCB113WGLMZBS6lZo0oDLGSLFgSrKweSNWSJT1wc+D3vUim
         H7ZVosX9ORfTMbN/yU8ouV6dClsHYYcd5l/rQcn7N9fJJEkc2Z1qQI7Ix1J6FDEscgsq
         /qedPqVuf4bnWODa2v8XvHZHSvzD3xxle37jagXf/59xLp/XqVXifdSXvX6L1RJ6kjeg
         rFGxBzv4eo1TxskqrUD23KmEXy8p7En4iSl5XvgAlXHrviDXeDPSsFoadeGqsgzSJDKP
         TDQ0zUgjBWOkln+z7EgAMsep+Oc4VIzsTg5lS9nLAMb7Vxc5ywjm7vafIiDdkz+uz7Dr
         I6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787178; x=1793391978;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jMT/0jRYIKZhw47Q26itdzqUKsUFWhPK7paGQJTSrNA=;
        b=W6Ya5omW9uf0RWxUhLy8TMdy/MqFZKFt9Okp/A2ZTBLyhqVipNqfIEQtzva9r7HmyR
         tO8nm/THFJpS9g5wf7u/ZRmfsMU+FHA+95Gw/YUO2kHh1tdlXl8B7dFU1U8ixa0Sz/ZV
         dIIt334GaZ8z/c7n0m/PoStdc0Xhi4TVYFoI9rtGLtjodZ5LKSlLHe437nEt893wEk94
         jcs33D2tqdX0JOpprwzAiMsXObXCUdSAOCgl+Kkmf/UorlPrAuBS/Z2iSAWTB4N7KbqC
         7CdrKxfkavNq1G6jV7GgkeEFqRdYzm7UPXJfIURGudkpo8rRhGiHLO1yVLfiCR2G+WzK
         aFQw==
X-Forwarded-Encrypted: i=1; AKwUvBz4enzWjktOUpY3aaBaGK50NLSaAm3ZD/jBv/RC2CLwRs8Nkv/TwZzhKxEe9+DHl53ZLp23wmIAzZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8NIcttVOCLTN2lcUx6VucElpuO2u+4CM4Oa6ee0DujPQh+akI
	P/mor5auzDo97Fw2D9tWB+YyAv11U9N/333D1s+ZgLScnkzmmA+vvElf
X-Gm-Gg: AYBFou1cBBBRV5fqZULf5Ut4uaHqo1R80dsKqrtM0Wj7NSsw4i0mDij17Kzpwa2T4kK
	OH5EnqrDVcdSQzkqoWcuaj09EZgcW5YNOat7b+e9ft5TqZkxShDbb0+YZO6rKO9VqjrRHUTr2pD
	s4j+vdt/HwniJwtKu7BjJCHBeudF+9Iy41qye8KV0T5N3CaRxCNhKwbMtAjIjkPnuaecJHdrjXx
	NfCabpy/i6sJnYQFE1+rHuhA2hEnVOVm75EWLoi8QA0MBcUhVXhWZk7Um03ZhNs9dkbwfOXSWfD
	MD6iD9Sz/Kym6/P8sMgZk/LQBbMEwYJN9NNsSNIUTKtielIaJCXqheoUworcZ8H5zSnhvf/TZyD
	3JT++I5RhM26/xgya3/4Eijw2clfW7SFhFUpSece+S8zu6KLRa4jBL0meQtBHBJ99kbYeqaDPCB
	/ob9sH+W+R3XxPYPRP6QVQ70gsqgManXUX+rLuhrnT78VWgBBKhSx5rxVYdWKV0bTU5jkemOkLL
	YKrHUCqY9oh9wMnRk+9X0iYeGb3TeXKt5DxSbxUDDRNGLO7Zzcam+a1p5R6DTmQDd0xTmo7RSq5
	e6BFDQ==
X-Received: by 2002:a05:600c:a45:b0:4a1:e11f:b2e1 with SMTP id 5b1f17b1804b1-4a35aca4bbbmr269895e9.15.1792787177630;
        Fri, 23 Oct 2026 13:26:17 -0700 (PDT)
Received: from legion.. ([5.43.81.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a573f65sm5674945e9.10.2026.10.23.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:26:17 -0700 (PDT)
From: =?UTF-8?q?Adi=20Kadu=C5=A1i=C4=87?= <kadusicadi1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Adi=20Kadu=C5=A1i=C4=87?= <kadusicadi1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Miao Li <limiao@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	"Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	Pan Chuang <panchuang@vivo.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: stk3310: replace sprintf() with safer sysfs_emit()
Date: Fri, 23 Oct 2026 22:25:40 +0200
Message-ID: <20261023202543.144563-1-kadusicadi1@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch replaces sprintf() with sysfs_emit() safer alternative
with no functional changes.

Signed-off-by: Adi Kadušić <kadusicadi1@gmail.com>
---
 drivers/iio/light/stk3310.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 0a16e326e939..e751e7c97bc1 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -18,7 +18,6 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/sprintf.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
@@ -180,7 +179,7 @@ static ssize_t stk3310_read_near_level(struct iio_dev *indio_dev,
 {
 	struct stk3310_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%u\n", data->ps_near_level);
+	return sysfs_emit(buf, "%u\n", data->ps_near_level);
 }
 
 static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
-- 
2.43.0

