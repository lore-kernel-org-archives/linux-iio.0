Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D03E8693
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173153; cv=none; b=MMcgja1bRyuLs3Qb+wX2ffdxBNCyDkgdYRHc1g9PrHe2wljfFQ0y5mcXEQO71wAtUx+bdoSCp8QSx3P1kZWgFBCxQD/ya7TeZik5UPcjFASjGZ9z4Z/fH73g4Itfbw/Bv2peBs2dA9OEfEqZLtKHilXdiNhA8Fm9MyTCBGtsnpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173153; c=relaxed/simple;
	bh=guApLfrSRuNxR3Y8l2tK1to2nzdDTARtdhHWSQ+XOAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSyiXXaAo6sdtVUok3Q1ifE/SBwVgDa2jw0LC4IcdUb0qgXxhVQD5FzjQk+jmP3F4Q/VNdLDVVpEsCAjZZq2hwrTjG/sNU4Sf7C2Rt+rpoHt03klZpBJVofWL1uvl5UaN3wKBI3pGqc3hyIEuMctZgkvGi2EMPkGMAjNE3kxnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6CiRfU7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6CiRfU7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82976220e97so3660340b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173151; x=1773777951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrH4PALLy5kRg8WwPkdWNLB7To1Zs5EdGhx79dnqSRo=;
        b=V6CiRfU7sZI10Zzxz5eRG3i6fSR5ZGQkJGgFJU7T7AHL0mOhDY73fsR9yjFXq5L3dH
         Xq74LAbXhAlsSwqGU+C2gytamTI0jXsavpeVIF3MnDQa7UChff8zRv/pX7NhvfzFnlhU
         HlyHxSUnN3px0sbix2jrve1xR6WT8f22AEmq8pvTIjl0jPqg2uKOrJyDMAYHglH3FaEX
         PUr702IzE6fiQuONpFAFmXYVi0jCWldrZMJ657J4qLtzkybB8mp6ACGtKnkF4gS+ehto
         ELReGzbIBSb1l2RAvTgShr4GUx6FlFKH6HtOInPFsLPDohZ7hxSFrJl3GzyNCd6QSjVk
         w9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173151; x=1773777951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrH4PALLy5kRg8WwPkdWNLB7To1Zs5EdGhx79dnqSRo=;
        b=bxT1KeeKBreCJr2yyhd/Iy/2hg1VITRmrn+hn5zGqjnVcANvuLd+568ZrIWG/l9qu0
         agC/d6RgMSaAGH4LmwXIIZ+gmQLbZg05laln17a57Q+Ez1dy4c5ik7fHqTnBTr96LGnP
         F5lpGM6mEMnKpX1gH6twssm1moyumCqhHByJ4fBfveM12Zvqp3hTIKtLUQcOUCkKoq1Y
         UCaIGbGmwqXdj1uJe2xl61D8hhdYcxUqGdWMhHbgOWeTNCdwePrGQbMgkQBxFMynnEFY
         NW5GD+T7G+dGLOaaamd+AnDgz6Pkhb8kbFsVT3RPvpQTtGqRv02Kl4Gtucg2MVDte6tk
         QBww==
X-Forwarded-Encrypted: i=1; AJvYcCXvF+Q3TkoO6NLislTrUq3svULJSK6uAVjhUINF0Os+8YSlIBfXgMicgji9HXK7v+8tiln9AT6Dcf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6DMzCGG+WZIwlmoyPs7UomNvfRtAJXy1l8kQEky8ao0urVvZx
	Spyp0KtBAZ14WnQQJErqNVt6NvGw4sosbQvURAHnVdN3YjOoS4VQ1nKM
X-Gm-Gg: ATEYQzyYJ5LxVMeQWLK6Gf9nSeR3jV4bPR2gfxl/ivSiWBjfYrBfrEruN1p0IyfATzS
	A59WYKeRK2V4T0ymfxe7pQcOcPXvEAfs2Fk078gS7DFDhpvH26mw6PgIT60EaXiDQ6Qr3WYApnM
	G9PTmJapX6k41mevt8l2r7Uh0O9VBTJuFuIRfB3H0D/Aiq4LLWQOmEakXyZxIxnpKNM9r+o3N28
	bYK3f8OFxHby79txjKbPPMMVvhLoPRvs11GHFL5J17vWHyQDZ51sKWthAM0LJXxAsUV9sjQf7bo
	p1CJLFsukjpmZOZd8tnI8c88pJKmWA1B9LBzHgvQQsPCN+Iek8CiN2yPtLlwvEXBweWOc/BzBTN
	COL8KlEtLk1SObg3bAixjN3K4lOW/8xaPwjyCYpK2p25UN20jzyeIFsstPXW0Vq3x6bl1jE7S7H
	AreAT7PgSucHDaEskCFeZR71/WO6gZtphwcN8TW/ugA2ttJs5XRr9N+tAGXSo=
X-Received: by 2002:a05:6a00:1c9e:b0:829:88e7:c89e with SMTP id d2e1a72fcca58-829f6ee65abmr156570b3a.9.1773173151308;
        Tue, 10 Mar 2026 13:05:51 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm101660b3a.13.2026.03.10.13.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:05:50 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	m.tretter@pengutronix.de,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	pure.logic@nexus-software.ie
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	kernel@pengutronix.de,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	marcelo.schmitt1@gmail.com,
	maudspierings@gocontroll.com,
	hverkuil+cisco@kernel.org,
	ribalda@chromium.org,
	straube.linux@gmail.com,
	dan.carpenter@linaro.org,
	lukagejak5@gmail.com,
	ethantidmore06@gmail.com,
	samasth.norway.ananda@oracle.com,
	karanja99erick@gmail.com,
	s9430939@naver.com,
	tglx@kernel.org,
	mingo@kernel.org,
	sun.jian.kdev@gmail.com,
	weibu@redadmin.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	sanjayembeddedse@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH 2/7] iio: ssp_sensors: simplify cleanup using __free
Date: Wed, 11 Mar 2026 01:35:08 +0530
Message-Id: <20260310200513.2162018-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310200513.2162018-1-sanjayembedded@gmail.com>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace manual cleanup logic with __free attribute from cleanup.h. This
removes explicit kfree() calls and simplifies the error handling paths.

No functional change intended for kmalloc().

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 6c81c0385fb5..e76ef39c6b7c 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -331,7 +331,6 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 /* threaded irq */
 int ssp_irq_msg(struct ssp_data *data)
 {
-	char *buffer;
 	u8 msg_type;
 	int ret;
 	u16 length, msg_options;
@@ -375,7 +374,7 @@ int ssp_irq_msg(struct ssp_data *data)
 			 * but the slave should not send such ones - it is to
 			 * check but let's handle this
 			 */
-			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
+			char *buffer __free(kfree) = kmalloc(length, GFP_KERNEL | GFP_DMA);
 			if (!buffer) {
 				ret = -ENOMEM;
 				goto _unlock;
@@ -386,8 +385,6 @@ int ssp_irq_msg(struct ssp_data *data)
 			if (ret >= 0)
 				ret = -EPROTO;
 
-			kfree(buffer);
-
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
@@ -420,20 +417,18 @@ int ssp_irq_msg(struct ssp_data *data)
 		mutex_unlock(&data->pending_lock);
 		break;
 	case SSP_HUB2AP_WRITE:
-		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
+		char *buffer __free(kfree) = kzalloc(length, GFP_KERNEL | GFP_DMA);
 		if (!buffer)
 			return -ENOMEM;
 
 		ret = spi_read(data->spi, buffer, length);
 		if (ret < 0) {
 			dev_err(SSP_DEV, "spi read fail\n");
-			kfree(buffer);
 			break;
 		}
 
 		ret = ssp_parse_dataframe(data, buffer, length);
 
-		kfree(buffer);
 		break;
 
 	default:
-- 
2.34.1

