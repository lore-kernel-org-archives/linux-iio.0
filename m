Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB13403150
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866875; cv=none; b=PpsHZxZ6Nsfse8lPZx9Y9T0+gMEQsqksjOCESommGF9UKj/e/Ezw/k1Jn6B3BvwA3//ium7kUn6LTmEN7YziFSAaWH6819+yROvdfqf4fRC0nRQwnRGx6/wY/QOpl39sZvomW32gi1D06exCWSNm3/2MZq5K5swlaLL4LskCk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866875; c=relaxed/simple;
	bh=jsuGpb2mMPaykr3eFzIY4cRo7k5b02mPEDyE1cLv9jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ber7qWkX4LlA1mdzUImVIWu2snO8WQAmt3oxk79vkoBzJ/8LbB1jHHUtoC+l8n78imn2/SziEx1N8Yf5KWv6BdG0mei3OVfksXrWcWNECqrDcvWbvKyZYOO9UlPAIRzGdf+LBzuMj6qbFT+Gyv2ErymugUGYZrpXbJjF2gbCbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0OPvGgn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0OPvGgn"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83975e992e1so58724b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866874; x=1779471674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rxxcYYFlb5z1A5295QXlxiBsIWJkSP9LihNKkDQr2c=;
        b=L0OPvGgn8MRkvJgjmRAh8DowS7dWVHkBU8QKnMvYI/4qOOoiFKWCVt7QhO5qYRA6a5
         vbgTNh1/QvKvRoobmHMjYNJ2Ap5UBu4jhD2kCosxaTJZGODmNC7EDQhraU7UZNDFtIYj
         Awico4Qp9owB5P1oJp7VlrLAReD+w4y+6Ey17HJ+QaH1gWBbstUkYlnip8aTtnhyEzeK
         Pvy+CXK56ill/nQhzHyp4qYiUG4olSiYT5vQYOsn+kAiyLPoQ+UCAG9kkTwMoTLGOJuc
         E1lrQMVDOO4ggKPF7JG2zFdmjEbwaEjxN0JSpVuFPoI54n44actEuVDGBTeUitfybm3o
         PWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866874; x=1779471674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1rxxcYYFlb5z1A5295QXlxiBsIWJkSP9LihNKkDQr2c=;
        b=BS6exeCAACf6suufozYc36S8mrhiTS8pz+CkD5aqKGckfJLKJpbpwmECNLWkSoBeM0
         zc+qYALNWBTSdfy/HQ6c3nAVojsKx/S0TErCwODkZGAfxZLAMcfpeCQyYhCfFJyJL6uf
         w4CJtUQ/t46VWrowC9sMYYUxfXOq4s2AgtZnF7ZwEVhJZPkRyHFPOwifjuykUSjXnlE/
         CE3XGyo1ClhX7kq0q+4VI1k/GRpJfR2iqbjpuZVj51nfB7Q0+XG5tSPAVUvpJRCiX7Qs
         eBx/o2eBPGShW6KDkvCGNrtu5Z/eyrzt22mNUrYMTcEnq2OnjrX2Vh0HPB/BX7mGaZql
         11Rg==
X-Forwarded-Encrypted: i=1; AFNElJ+1LN+Fb/E3hFKiha49rPMCh0zkMecrs0sdjVGVwrL3OBchpOrRDvz7vFsTwZM/wEp2fBRaqRaFqO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfM0hhJiX9+o2KboAPz3kUDA6nW/AwhkXX3ZhOOOb30P5mZCcp
	mX5Pyz0oDVXXfV8ipP4NXkiwKaH8PpKPqIbgjsns+BxZxin76vSxkMZF
X-Gm-Gg: Acq92OGj0+RwcO48Y4my0xuU14I4dwFNH8Fjs+5/QCJzL2w+JrvH2LqsHPHcP7NQmFy
	3QDl3Px5NRUSS9z2Pn5+/zC9yDRqmT2hW7WfK0XJba9lQVwiLL2Pdi2q1T51ByzyL9katLThonm
	CRtp0koVXe2gD/PsgGWpUI+a57ZbIikCeqSsugmOBxLiGsnIq2K2JqQMmQ0rOFkV5/I/eznJFAW
	pn7Ufjo2gMg99TV5ji+MFOibE46Epi46u4ozOg2vuurzhhH8appEd9I/WxZECIlKFHt7sF4vVu8
	h8jv+pVq+pge56X6EpzOMFFqA/vQ/E/55vYKn48MMDwtxgOgzC4GMqY4Pcs+aUgmFa/ppxoJgkg
	JF4noDjcc/cI4kmoWZsyZF9/jQ4xo7G6it0tOi8T0TgkXnGMk+Igc8dRUTQNhXX8paH97GXftzQ
	RMm6ipPGM8yb+KI/NDDV/UQBg9szC/WPsasu1GN7WNfqVSzdyu
X-Received: by 2002:a05:6a00:808f:b0:81f:3bcb:af2a with SMTP id d2e1a72fcca58-83f33c60a46mr5166343b3a.26.1778866873535;
        Fri, 15 May 2026 10:41:13 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:41:13 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/12] iio: ssp_sensors: return errors directly from ssp_irq_msg()
Date: Fri, 15 May 2026 23:10:16 +0530
Message-Id: <20260515174017.3962168-12-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

In the switch legs previously used break statements and relied on the
common return path at the end of the function.

Return directly on failure instead, allowing errors to be propagated
immediately. The final return value now clearly indicates success.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 29bc3d48c42f..172b4bbd298c 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -386,7 +386,7 @@ int ssp_irq_msg(struct ssp_data *data)
 			if (iter->options == msg_options) {
 				list_del(&iter->list);
 				msg = iter;
-				break;
+				return ret;
 			}
 		}
 
@@ -410,7 +410,7 @@ int ssp_irq_msg(struct ssp_data *data)
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
-			break;
+			return ret;
 		}
 
 		if (msg_type == SSP_AP2HUB_READ)
@@ -428,14 +428,14 @@ int ssp_irq_msg(struct ssp_data *data)
 				msg->length = 1;
 
 				list_add_tail(&msg->list, &data->pending_list);
-				break;
+				return ret;
 			}
 		}
 
 		if (msg->done)
 			if (!completion_done(msg->done))
 				complete(msg->done);
-		break;
+		return ret;
 	}
 	case SSP_HUB2AP_WRITE:
 		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
@@ -446,20 +446,20 @@ int ssp_irq_msg(struct ssp_data *data)
 		if (ret < 0) {
 			dev_err(SSP_DEV, "spi read fail\n");
 			kfree(buffer);
-			break;
+			return ret;
 		}
 
 		ret = ssp_parse_dataframe(data, buffer, length);
 
 		kfree(buffer);
-		break;
+		return ret;
 
 	default:
 		dev_err(SSP_DEV, "unknown msg type\n");
 		return -EPROTO;
 	}
 
-	return ret;
+	return 0;
 }
 
 void ssp_clean_pending_list(struct ssp_data *data)
-- 
2.34.1

