Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013838;
	b=WMMnvyGRzsU5UcV/LuzoeZjYCsR5g6K5aQNMquOEy0CdBQ8/4sPyvoz4Nz2e8m+o5ovc
	 20WU0nj3jJOCg2rb+DL6eQ65vu3N0R2x9PFWL4LiFkzVEfaTOpK14B6hTvE/qo1gTHf+k
	 GYWTpEUjF7BMs4rjZmg2YQQQOm4IaPqGSxshJgI9kKeGBj5HrRUcW0bDioqrofudnI2sH
	 U+KyceFBX7S0Yf79ftitn330o4RX9p4fKSRuab9fvtV7heu0Lyb9RGL6PwW5kVD3AqVeG
	 ZAEnpH/Qx/MQCPeKeM9F4TEMg8mJoJ+NZ9/ws8gSUc8huvfFA1eC6SMvZrqW42n3OpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WdkOB6VcqgEBpO4s2s6iFSqHY8CcGzvsCx2rzyCP3Ao=;
	b=ygyGxvAJ5hpBXh9iFsJvnX4z+C9ZVLMVZ7O4CXeTseiwc1sNZ8Hi4fc90dqFN6BEofI5
	 /UPdOn2pxWxb1XkoRPZtgUGtn2NsH/ZekqBZekmbDRrxGfzn0Oom/CmQ4dCSF4ie6wT6b
	 uv6mJPsL1Lm9N6CK9RibOEpL0xCWkkTHZ7YcPh+p7HHkw0SiKm38AnOhdfe7bQduneUjX
	 hsYsL2udzFNMjnZLmhjyOcnqbOyv7J+fDBT18r/A8QGG8Cuwxaf08OyjqFU1ibU/fZmoE
	 H2NT9p2NHHcLvx9sRxj5/dlCdoTPnzL40om9b79MM4MmwVQf2YOm9zZJMSnycJ/Eh7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GY0kZjy7;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7F60A260B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 11:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD7F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GY0kZjy7
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35f1f76ea84so4807956eec.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013838; x=1793618638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WdkOB6VcqgEBpO4s2s6iFSqHY8CcGzvsCx2rzyCP3Ao=;
        b=GY0kZjy7GNL6frg9u7inlu1Qb7hDKFMuTFeosW/Zi6NR/2VutCyp6774hKOZLIQ4Uw
         hZ9aejfoH4Q6A0cWbsooQGLOzV+Y/DGxkDLhQz+tNqHNjNTRgkbY3zTpr0piYPpUDqbk
         Qbci4KibkDYh77Oxp+9zhMdxX79KPOaIVWdVOuXWTcijp9fjvNtKiUHC57lTFPNUxJvO
         3Xu0dXA+1LCQXqGFIQsPwkHZ0ORnHEgjVW0hF56fHT2lH73DytDLyWrDoNjxwqC8pSHx
         3Eql/I5qwXGP/J/uDYuJI+tgmgN5k9+K1tvVvDcB318pajZ/9YTIvTW/1OBebeFey5Yr
         FdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013838; x=1793618638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WdkOB6VcqgEBpO4s2s6iFSqHY8CcGzvsCx2rzyCP3Ao=;
        b=0IHta7FpeFXankXJaxPMdUwRncwbrUEwHnGXa5d3mvlQourNjiDHsbSkzEo8DgXFz6
         tjlz7AQ4NXQnRYw+FUx5QzIMi3/1Aj1CKjnJbd8BQ1bQh7gtdr+vjJVfND9elP/6iC74
         2OO3JI5SZtj9EhCuPMecCeT3EJCpoHNwc1CpOqlYJ49OmniegstAwUmW0jloRJYc7qSn
         0jfP+qlYzXkxcu9mgKmwXJwefm02BG61O+eH6K99Lhf8H8IGDSgMcZK9mKV+QhV0L+6M
         e8S34nQu29aE8jn5qGTfW1syTl10GnWtAgUMGyhuZmRF0rhuqqFmTd5E3VgrUEKIQTgs
         NjSA==
X-Forwarded-Encrypted: i=1; AKwUvBwN6nzmAbDNZm435O+Oe+cBU8XCRqDBTcPIAaQmULvonEimQwnejXSeFZ4xuMils2m1HTgRVQYG9oE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd1yj3KpFaxESa8X1czbOctpigpjPOCxQKa2fjwxllvBDi2jXs
	31CD47VeY3EUNSDX04MCKHSYIn8+p1NZ2iBHwWKO7gLYmG9DZh9skR7Y
X-Gm-Gg: AYBFou0LgvPU9p7+EX/dSPpu195kvhlkqPoybrp2f/ZgsbUk0chwizdW9BrGtKix5jl
	e1QjMSVHjyGD6nYepdUr6SafnAz2eVbRwD03l8veo91+naw52vse3WmmcAJ+WKiAEyGWkxegpKa
	UKinflYsyQBRtu1I8fAf2C4UoWvTObsBXYIhWJ24S52i1nKeqHzxKXFNM5sroox+3uoaotXKLh6
	v8Jw6AzpCsyrA60KnxN2Cokk8U2XbchwbFQzMUxVZd8kLbTrNj2MXh/pwzZWpoDRcWpF1Hox4EM
	qzV1Db3efqTVn3TH31nhnXSIfIWd7Pl434cwJECDkxW83bR2/kLCAaew829L3upocF5L0QK0Fg+
	acixrn2h50W850FfNeVKZGp1+tMrbDnEuLJ7xuewENY283iYlCPF5zXKuaMvstjeN2waH9ZL9yn
	L2GQoS9c7C+2AgXrSEh3xnRRkkZjDvYey8vC/bOFCKkBccytp9aIJ+A29bMnp0u/o4ZfnUvFWvF
	o3k/Q4uc1VolOSEuIVakWrJPMCn1rE7WdGin6UZP6bMWK2WK/+itIGNVrqMifa2XHwAXykvhtqe
	Mpwhlrb+kX51tUNWhtD1GKNgdOXwUIlnTum7por2y2qHpX6xGtOIW5Pn+SHmhP3QC7Rn1bhcfKQ
	G7wzTXU9h3dU=
X-Received: by 2002:a05:7300:c8c4:b0:367:6d85:29ef with SMTP id 5a478bee46e88-369e861b789mr10833374eec.27.1793013837476;
        Mon, 26 Oct 2026 04:23:57 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a064510b0sm6599989eec.2.2026.10.26.04.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:23:56 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 1/3] iio: proximity: sx9310: keep the IRQ balanced across suspend and resume
Date: Mon, 26 Oct 2026 16:53:04 +0530
Message-ID: <20261026112342.65917-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026112342.65917-1-kapoorarnav43@gmail.com>
References: <20261026112342.65917-1-kapoorarnav43@gmail.com>
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

sx9310_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9310_resume() also
returns without enabling it on error. Without an interrupt line,
client->irq is 0 and both callbacks act on IRQ 0, which the driver
doesn't own.

Disable the interrupt only once the device is asleep, always enable it
in resume, and skip both when there is no interrupt.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9310.c | 41 ++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 79ba46d8a0aa..fad1dcffbe26 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -943,8 +943,6 @@ static int sx9310_suspend(struct device *dev)
 	u8 ctrl0;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
 			  &data->suspend_ctrl);
@@ -956,7 +954,28 @@ static int sx9310_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	return regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+	ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+	if (ret)
+		return ret;
+
+	/* Only once nothing can fail, as resume isn't called on failure. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
+}
+
+static int sx9310_wake_up(struct sx_common_data *data)
+{
+	int ret;
+
+	guard(mutex)(&data->mutex);
+	ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
+			    data->suspend_ctrl);
 }
 
 static int sx9310_resume(struct device *dev)
@@ -964,19 +983,13 @@ static int sx9310_resume(struct device *dev)
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
 
-	scoped_guard(mutex, &data->mutex) {
-		ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
-		if (ret)
-			return ret;
+	ret = sx9310_wake_up(data);
 
-		ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
-				   data->suspend_ctrl);
-		if (ret)
-			return ret;
-	}
+	/* Balance the suspend even if the device couldn't be woken up. */
+	if (data->client->irq)
+		enable_irq(data->client->irq);
 
-	enable_irq(data->client->irq);
-	return 0;
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
-- 
2.53.0

