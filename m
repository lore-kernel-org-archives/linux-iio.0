Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026FB13635C
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157999; cv=none; b=lM+75RNRaPVIeSVLfftrg99ETvYtBvJKAe2CiR01MVwsJgVGVdLttG+pja1wf+t1q1YQAiCoBEg6D9FGh76mrNoQ1sOpm8E2qCFtnJtY98w7BoWkDyhPht5Tk6sWK4xcvvfKkVuPtCuGNp79J0MhPA9aFkrVYpz8zqnghbn+FWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157999; c=relaxed/simple;
	bh=DceN/1FY5sfDaFKgfd/7xWB7OmyeTAAniEbTxPCaqG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rA2CEApxIzrlUJ1U6SKJfu2lH9Eupgl0huMTO8Po6on8kZ3IiRbV7oMngU+dwv4/CuGYLOWCRdnqBDHnmqpvXD46QR0j3wnyV2XcHZWV/ct+Af6e8RNyIwy31g1w4JMtQ7xO287iNcfNGwe7X7z8LVJUL23M/xrMOMg7+RA//9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8ZZfIe0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8ZZfIe0"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9d9971d059so462412866b.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157996; x=1776762796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmhA9XrEY3SaezkYYH4LWBg56vYjVuHTXXG+8AA87cs=;
        b=Q8ZZfIe0FY/PXsvMFW7IxAIXjiKieI1x8Ok+U5UIYbF+J9us1ZeBnMxLvbP4yTTwPU
         bdgWS7Gy8kx/1xfpPlqVgxzzL4dqYbd43A/LgaQ4zF6l5sMcQDDlHk7bLDVlUuELs3mG
         6zrOcTu30Ox1yZu6tcZCung6swzouAmpruR7W6jJbj8D32SBACsDwgw404c+BtNGYdgs
         pWyeglDnKjS6hh5ommNseDKWB409v0rqIxRmeDReV46Q9guMosCbe33sgWYEsQ+XEscy
         Kg84nTjUwPsxJbwi10jY0C1orDJ8Rlah7OajROpjXMGkDH+Prw4MO0V9hIOWQd3jhpuO
         1PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157996; x=1776762796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmhA9XrEY3SaezkYYH4LWBg56vYjVuHTXXG+8AA87cs=;
        b=CPaLt/+OrydEy/bLjxZ7+51GyLB11GnuxPWcaR3D6Wf8V+3YLiPPGCtI2TsZ6SWvt2
         ns2rIR62korv0n2eu6WzmeqyBSlF2OCi9lcvqSC2JCwJrSgg+TBr9ta62rCBC+ChFPnZ
         rWQMU9g2oG7DEu5Jz7EYC6vRLF7pu3d+29CI58eMoIq0Pg39DMBsmsV/vJViNnaCNiWE
         9XViQ7Vf1Txqv0GmFGlg+/+C+ODOD9bdKAfG4Yr1EOZmSJ8PI4T+UA896CnLkSS3REOd
         7LSMUXyVzWc4QIQ1IGwPbERVFJklShDVreG8hn94fx4z/OoMv8OYZEiHOKAfk7I1gF71
         p3+g==
X-Forwarded-Encrypted: i=1; AFNElJ+bNkddG0T9Ori4945tD1+JvNDKNDvN6o9CQx6+kCisdw9gUMkHKPGm0ikeyixTQi+euctlEZ00aMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7v6Il0s/aQ3XNLGAPgyVv/7MhYc/cJrmkcibQTNdCKObzuFI
	+qj4POQOCSflzOpveNiIL7dRzM82dWe203U0lcNE2Qf367QzuCXOXH6G
X-Gm-Gg: AeBDieuahobOtMVW38gPHrswVpp/JPbJS14F9jMPLS24aSoFvm+iI3mTJ0gqEUc/mcS
	3vpONY5rlR2eRZ1VOY4BrBMG/Rdhhpo033KUCoLRokfUkbYIECJ6gurJvyXJbK74k6/bqINtx76
	hQqUJIqJ9Epnas4wUSfLvJZRIax0lBlZqUNrJPerVvWM8mQzTN34ZMLW2qNQyYglbvjmwo5F0qI
	kX3Z8cUehaRDW/Bw2nq/ci8tVVDzPHcRv9IIrrwo1qSYLGxhAnZWtkQJ+ucapUKTGqH3+jnRySP
	qFyHBDb/WMQbCtfmSpMHbfchXBoR0wIuNXD0F8gm5S5kbmYNSjiJ7DntXEPxgytHRrhGm2iZS4z
	AkpwTzgbqbd/ehqd05FBkqkroXLNZwnorF/9FuLTiqzev2xFi8MiiezvaQajse5H5MobTwlNlC0
	/fJgY2aiJa6jdyL2VkN+R/INroYoHLdQJlBC5McyFfFAGdm0UeIVNib+qFO1SpFAKsVPaA1W1bs
	xc7OTxN76mQ+jVU8vTG/5vq4pYgvkYj0kKelyDTd5AkQ1Btm/b6uKxZJOYhl1kjqT3jCD73PIeA
	L27HwX3KYLpQISVV4V5LbtpKxhqRARNB88DkWaREATD6cvagmewoaEWBpMd0M4GmFNbf2WjTaMD
	LrgZt9GwvIIAyW+NGOfPHU5Zv/SNLKV3MtF7Xk361ADgcayMVIsacR+eUHcHnVj5feX3wPIRfz7
	KEYYcNGgA=
X-Received: by 2002:a17:907:a28d:b0:b9d:424f:1d9e with SMTP id a640c23a62f3a-b9d7298fffamr993970666b.34.1776157995985;
        Tue, 14 Apr 2026 02:13:15 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (63.152.141.34.bc.googleusercontent.com. [34.141.152.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8a44sm384466866b.52.2026.04.14.02.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:13:15 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 3/3] iio: frequency: ad9834: add mutex_lock() when reading st->control
Date: Tue, 14 Apr 2026 09:12:50 +0000
Message-ID: <20260414091250.1295-4-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414091250.1295-1-joshua.crofts1@gmail.com>
References: <20260414091250.1295-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mutex_lock() and mutex_unlock() when reading st->control to
prevent data races as st->control is actively modified by
sysfs _write and _store functions.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 9499e05a73..33570474c4 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -283,12 +283,14 @@ ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 	struct ad9834_state *st = iio_priv(indio_dev);
 	char *str;
 
+	mutex_lock(&st->lock);
 	if (st->devid == ID_AD9833 || st->devid == ID_AD9837)
 		str = "sine triangle square";
 	else if (st->control & AD9834_OPBITEN)
 		str = "sine";
 	else
 		str = "sine triangle";
+	mutex_unlock(&st->lock);
 
 	return sysfs_emit(buf, "%s\n", str);
 }
@@ -305,10 +307,12 @@ ssize_t ad9834_show_out1_wavetype_available(struct device *dev,
 	struct ad9834_state *st = iio_priv(indio_dev);
 	char *str;
 
+	mutex_lock(&st->lock);
 	if (st->control & AD9834_MODE)
 		str = "";
 	else
 		str = "square";
+	mutex_unlock(&st->lock);
 
 	return sysfs_emit(buf, "%s\n", str);
 }
-- 
2.47.3

