Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244DC3E8C59
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173176; cv=none; b=ceOGamDqmzzS1Wx8mq0v2/5EHPvJOX/qCBtcrVHuZ92UglzWxb9bvswBVlMdoiY58/lmSG20qjRF3Ma4DL/RoDOpLp0Wvqf3iAipEhSLe0THCNWtf2fElTiPeXSinSP279I0oRyr40F7C/uh1iZa7q446axfisqipqfNSd9Rlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173176; c=relaxed/simple;
	bh=kDaS0oBBZ1N5fMHKwDDGFI1Ivj7HNRUlOpYXqktu9XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTNkLqMBXtbCoxQ+mLyhbhSQrwMGwjgBJnk/WYlb2hMBW/X0CRW4q25HFmWkf3BsHhTqUYTCzasC1kKAB6wZiSef6fsfYeKb5u8zBmA+9XZAg4cAmt5JtT7z8LorDQSyxHcgVSo8n/ANH7yNWIjq4VVaSmto7fLsK5sCAVMGDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br1H0f0x; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br1H0f0x"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so3915471b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173174; x=1773777974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FCnsZqgY0C/inqnWcqsCfogd4Ir01+XklcEE3giunQ=;
        b=Br1H0f0xNEmnRVdit6eCWnhKiAIxF57+hL5cuWoSgzcsmhcl0H4fTadmpRnrucYbyi
         k6B69BVDRwLURza7uEPkSGzv4X2akx195sgsSBju0X5030fSJ/oon16Xc4UWKFvr9s0K
         0F+DUYUcbxpepbVuV+5Tx4vHQAYj1JUqnXALQyQPjbfeVWfQ+wQ/IvhRgvB1B/Z3vhQH
         HjtZ8WiT0KaAfZ8qFzDOm4UMAGUGdSgn7xFNLlqMVldd1gsitzd4Ovk4tLvYQpmhAWdO
         L9G0Y7utYpQHJOURnY4NOsYCa28IsPbzZKHP0Z/d77vL+XEjOjZrQRtErU68R05y9hNG
         GMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173174; x=1773777974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+FCnsZqgY0C/inqnWcqsCfogd4Ir01+XklcEE3giunQ=;
        b=EzSw7Wpr91Yjr6E6eyBz1i7RNFTl/igb0oiFsfwoYupRcwJSsjazoQSEfijOH1xdTi
         Ie4deig95rNfGzzMFGQtXkyVC2XHLgqU3yIRRtkIVYOKEUXuihk2qAtJLWiWftwQdEHq
         GZGdc7j9+GUeqlxCKJcxxbp+A4WMwWzdSb4uU5VCmvxPYaH+QGjvcx93hVMOlQ4yogHg
         RoWlRcptr5TYmBarEmbcd2iKibd3vLpoK2dsI7DCIX/d+6IM5fGtf7jaUD8Vyq+uo0Wo
         FkTgwT3RKxVMwvBEgVqbIi1IlkqjpsrBa2GZwuR8JlWQ2yVQymFi4W3jPrZ4uzPHUjC0
         uxPA==
X-Forwarded-Encrypted: i=1; AJvYcCXhZ8C/y6H6z7fqRI0XYuHNHK9/ddFCvMPNwkN7u3rGErEbsDEbwJnc/yUmnZUySkoa4RrB9XofXoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwonPR3LyA6HeY0Se0AnPiwMDXiVOw69cuI8Zu8+EpPOj9HpFLz
	s2+X8ROAKxMBOiQeJi85Dkl2L/qr4vAPQ8I042U4HAY0GBAfOnr2G/oA
X-Gm-Gg: ATEYQzyZ35GEtZekeQpNh3ThyHDDyz1+HlXokFJDwZuIYMTZaCE2Oqa8IvZh//q9pLP
	QEdjvzO7+WbfEdjetFhI+CxH/wTGTsaWhov9nCu7NYI+n7cZ6Iqg8vCJvAHnLZ26bIbSwBy8QxN
	KM4XEobEXUuKc9yEtzjSYDvTTuGE8+XF47IIXhsjLpqOsbx95jR/dsCYZyoidVXteIn9LCPaRMv
	fF6fogWaWL1wrdOeoDKqB/U9CCnrmJPhz+VbmqDSTH6nRiyWLWUHOUggaPDEuy8vQMFez5Z55ho
	zZQ5fqWffL733/5cFVxVyJ5RdEzSy69FIeVEiZaF+UQXYEzxexpvYaLIhxDmU/NQvMxm/OcU8bS
	cJZafm+25pB/1yxwYjEgi2YW6/5U/989/0pesq3BsjBguqfcrxaEzn6Y4PTte/Y4slBf9EtukwR
	Dcc9bC/GefFL82Q31suf8MJ427SdJB8nWuUIlCd4JDaESNL5lk
X-Received: by 2002:a05:6a00:3d4e:b0:81c:6ca8:7ff8 with SMTP id d2e1a72fcca58-829f71c43f1mr119633b3a.61.1773173174414;
        Tue, 10 Mar 2026 13:06:14 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm101660b3a.13.2026.03.10.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:06:14 -0700 (PDT)
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
Subject: [PATCH 4/7] media: mediatek: vcodec: simplify cleanup using __free
Date: Wed, 11 Mar 2026 01:35:10 +0530
Message-Id: <20260310200513.2162018-5-sanjayembedded@gmail.com>
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
 .../media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c   | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
index 2da11521fc7b..3184939f793a 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
@@ -96,7 +96,7 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 	int total_len = 200 * (dbgfs->inst_count == 0 ? 1 : dbgfs->inst_count);
 	int used_len = 0, curr_len, ret;
 	bool dbgfs_index[MTK_VDEC_DBGFS_MAX] = {0};
-	char *buf = kmalloc(total_len, GFP_KERNEL);
+	char *buf __free(kfree) = kmalloc(total_len, GFP_KERNEL);
 
 	if (!buf)
 		return -ENOMEM;
@@ -134,7 +134,6 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 	mutex_unlock(&dbgfs->dbgfs_lock);
 read_buffer:
 	ret = simple_read_from_buffer(ubuf, count, ppos, buf, used_len);
-	kfree(buf);
 	return ret;
 }
 
-- 
2.34.1

