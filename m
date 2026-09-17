Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E44A8FD0
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636583; cv=none; b=L1L2QTlysA4z0cfwp0eu/gUGz9guEyPOZDgxRGkSjlBwIPRucfSO8lcVKLiivzjrBzWH7UDRLk+AHSBRNiDW6rNTjVvNi5pNPLPnxrQmm9SlQodTu5ps3u2mIvGRXRzNV6p+d9d4rf4UThVPbyImrctRT4a/Hu2vnScUG10NaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636583; c=relaxed/simple;
	bh=R+nm9Wa+FeFv7xcNwmA/+Lk3Rork6TWTL3tbsr1nRXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCdeoqwx74s+k0r3mYDmmF8ZTwsvvzQeVfZhKyNNzQkmnEZKdy1IuivLyazmzNpeI9BDK4++NsA7/Ygi/Bw/LoRGL1oSRhaB/MFCtAlTW7g00K1rPW4pzfgCwb83ZN7pFsEsk0bWjjRfXGzTMFLu33CMLuqzvdf1mwK4uyTYPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDjMeTiW; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDjMeTiW"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so4314645e9.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789636579; x=1790241379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=09UW21Y8Ldpo1k4QvWzXYRCxILCDr/EkzcXOvORWXRM=;
        b=rDjMeTiW9DTIcihM2qdFZBUADOYosvEKnBeUeRX8BMamJ1Fqyrc8Zo1zCd4N70BhGM
         +yVpXVjzwFa83HqZP0JTNOEBl1EyQZlATkTUt5sMKAzanhTsctFdmUvTwa82akJg+ZuN
         LhsFzCHkrEwt+OZd957rW+sxfOAogcE7sT2z0YAB65sumOaeMFAf3dzDUqG4JHlIORDS
         yRuoq6CqaGn3D1asFqaWB/Qwt+0ROJb6/Koscr1m5f3Q7hiPLT66jbGAG7SR5zB8Xn1b
         t4d70c3P/pDUd1x7C8fxdS+3xodx2Qa4Hs1VtVxsGsPm8c5Dsw5DbmkEM+qidPVv5pOF
         Kg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789636579; x=1790241379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=09UW21Y8Ldpo1k4QvWzXYRCxILCDr/EkzcXOvORWXRM=;
        b=SvexOk67pdjDKG3WknsDiPU/TW39qXQ8IbzwEfy2pQtOHDS/2HDGcnnHz1ICOYJb1K
         jB0xtZuOKBI/VrO+vA0Ak5rPwGAgzAnRNJBmTowZfC3huiDTryj3Tydtv1UkgE370j1Q
         zv46W1Izit7IbkIUE+mMdP4IPc30WF1/Wf3AG8Hb+B82ow2LOZjlFUPfIVYyoxzKXaOJ
         cFGkuXaUaYzUGSHiTknUGvT3ujyF117f1owyAuVYzX9zniJI2nYjioRNw+IgqCuLpdzJ
         OdFOQy3jyiphi2c6F6RqmT1fnuOEyxK84Xixi8iqzN9jKTEUj7riYl01WXBJaxXr3KJ7
         iRcA==
X-Gm-Message-State: AFuF++kVO/nnH7jSASU8UdHuv+ryn9OE7j3cgM66s24YOljWYTadMdU8
	Cv4iMRz+EJSXsSgfqv6RIgav5QOv8nghOe9iS50CTymp0GF2cHu4jDmk
X-Gm-Gg: AYBFou2fWJWA48C/c5nvW+HQA4WO77/ECzgtXa8j+sZ5nLvLjT9tVCrHVoD4VirZB2D
	YvD5HauVWxi5UETBXo/doVYB1pq6C+7OWs3KTHCP8J/KiNl3LG2LYMJmTv7vtVgohqwE+0Xall7
	Wu9xU+QtyWVonatZqL2IrhjYkH45IO9XQAKWG66IKw2QeLhqo1sLXhPVQMFwSBPSuOwr6glqXlg
	8OeHXPyfRgXzrlE1xmqx7UVXKBHw08cTBT+ANtAPSfXfRbb8TdCAeLvqYMz9q/+iXRdxWsWT1DU
	RzhuauwGabkfHNTb4IztDeUE82AUkPDNBCaASwG9F6GxiQur/8alSjzJTpSCLZkqVX3BAGPaT5O
	8TXRNV/W6iDjxjEXL7Z7zXIA5yyA5bEqPxG6W4W0XjSaLbLgqB6unrOqFxmKqtZhKVbYqiSOf3i
	7lJbQYZbrzPK+wve14iEsbA0uj12syndKYiu4G+38QqvdhG++y+BcxRbe9vJsoYBk5QreZ+LnHX
	l2hlh5BSots6FQIBQuCazE=
X-Received: by 2002:a05:600c:548f:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49ec0543ce6mr70867275e9.31.1789636578480;
        Thu, 17 Sep 2026 02:16:18 -0700 (PDT)
Received: from localhost.localdomain ([196.235.229.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24774esm96082595e9.10.2026.09.17.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:16:17 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: temperature: tsys02d: Fix state desynchronization on resolution write error
Date: Thu, 17 Sep 2026 10:16:08 +0100
Message-ID: <20260917091609.626043-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tsys02d_write_raw(), dev_data->res_index is updated before checking
the return value of ms_sensors_write_resolution(). If the hardware I2C
write operation fails, dev_data->res_index remains updated with the
new index despite the physical sensor remaining in its previous state.

This leads to a state desynchronization where subsequent reads via
tsys02d_read_raw() return an incorrect sampling frequency.

Fix this by handling the error path first, updating dev_data->res_index
only on success, and using guard(mutex) to clean up locking.

This was found through manual code review.

Fixes: 53bf4d067d51 ("Add tsys02d meas-spec driver support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
v1 -> v2:
 - Use error-first pattern (if (ret) return ret) instead of if (!ret).
 - Use guard(mutex) for clean locking and simplified return path.
 - Add note stating the issue was found through manual code review.
 - Add proper blank lines.

 drivers/iio/temperature/tsys02d.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 3ef72347456e..20f67134affd 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -72,12 +72,14 @@ static int tsys02d_write_raw(struct iio_dev *indio_dev,
 				break;
 		if (i < 0)
 			return -EINVAL;
-		mutex_lock(&dev_data->lock);
-		dev_data->res_index = i;
+
+		guard(mutex)(&dev_data->lock);
+
 		ret = ms_sensors_write_resolution(dev_data, i);
-		mutex_unlock(&dev_data->lock);
+		if (ret)
+			return ret;
 
-		return ret;
+		dev_data->res_index = i;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0

