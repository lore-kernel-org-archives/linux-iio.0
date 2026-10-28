Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225105;
	b=ySrfhJmvl2nPWfY3wsMODf+pGQi+d6WeCr0q+K3IcAmm/jL2LpZsVSX+EvOSWBL1jqqH
	 cN553kpj3Mf7Ap9CpjMzfFPWgmavC1tuoW6d2HCXcTqEqtCbrjKGV5vjSfeBajR/elJNY
	 ylehfGjeOU3GjavDRo4F+J+lbTr4FbSLQIcMGhakGzE2/wY15KBNTE7DvmRAaxQWia9Fx
	 WNbZ9TD0A2Y4OnQQ0hyTo647QwwTnUM//BUpqrr1jAj756WI3V/gtwB8TYqVYwKNvEQXA
	 ibujPFRkYiiTvD+WV0sXotHsu+ZvlzOIRnw73SsRo5rT0b8Z9W+5RMnitg2LXGtQl9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SETH6ZaX18QbS+L23rL1WndgOD4QR2QtN3TQLoUJteo=;
	b=fugfSCyiN+nXihMHqh8/PNY7AgMI7bUgzxWZDCuerQTQ5/UWlMHcdipbhch5lAEcJ6H8
	 OAMZlsVu3OCY00gTiVX0OW7JmVDTY+MOjRTFLCkFiRMfvqBzVmszLAl0IUzerKcmID9t1
	 OvVa/zqY53PGBIU8rvhVZODvfHuuWjnEYVdfMeqZ8IkHVtUHAgLYOtN5QFb9OGbNDvWpN
	 eJSUmcVcTfCE05zAshSVWjrtKfu/y4E499C6iEiGL5nKJ+Z172LprJ+ZaM0mYBxrKux/5
	 xGFGFea2jxbiPUrq6RQYzI6klzdiRELhlnPspXhzosYJHD/LNYcEDXEjsHKt6V6d1Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kEKz77Z+;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE6606A31F
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 22:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FFE6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kEKz77Z+
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3514b90bb89so2808252eec.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793225105; x=1793829905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SETH6ZaX18QbS+L23rL1WndgOD4QR2QtN3TQLoUJteo=;
        b=kEKz77Z+JR7IEHeEdK/WZUmHpr3k8KO9URnO5RbaLdPcONALvy9SRVajC9Z0iJGgdU
         i8RXIh0+aLNbqF3p9kF/NegByyWyK63HaFYvoiOXZI//YdOs4LbziVDPjH8ZuibiGM/M
         ntCt/rfKbxbWTLa8oTwwgGcSGK6rssXwjOUtT13vQT9tV6k6VWd8tsw4m3hWvNaHXzXD
         /6sOv+D7PpMMyvnI3AsL32ax8HKvpq0HR4uqSWDq/8X7Wj9dQ+Sasipe/Ep2d7EUwXoH
         xJYeSL0eLRKlQjjmp3+yTDxNQNofy52uU686Av3QqQJkdxtlYaHJzlphLeRzb1EgCcI+
         40JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225105; x=1793829905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SETH6ZaX18QbS+L23rL1WndgOD4QR2QtN3TQLoUJteo=;
        b=cCZUK/0xSXNcB3HIPFPHHrRvoZ0mq3SrsUQZPuxcq8+HASTg/MzCm93ziweozQS04U
         dxNXJGYbyqeb/8iEQhusCtAcWkF8wzWFr1AZi4uW9afD6rSo0sBSXkzrbkZJQq/acgRD
         eRQwnC7TsZGLrxyjYDxsGn2Pq6cE/6yYLPkCQt4Z5feJzqKpVk6xU3YvuIEDABW6TE7m
         o0emhbffrsLmkFatZGUvv4e5/FH9LI/iEVW1N1vE1smMqZoo5n+dm+UKN9KgTCEYg5Xj
         mj3uTz+jtvYyhdSwkWYyQFd6TWvm7RSgEXQdcmjnO5XbetF1kn079v4khTyy2Y8Le0V2
         hXMw==
X-Forwarded-Encrypted: i=1; AKwUvBye0Lj+bOXNYZdoSnr6qKm3hb8m2n74qGv5stu8epTuldaiaLbY1cB+qIw+D4XWs4044VNQiav9Oi0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcueCBeWeUoZHSj82WrVV+CkxYlxnSg1wjtt/LXKklECO3Ut0O
	lxX9hSYnSV3TNyAZJThZSC1g/BoEvj2zk7doi9pcvcBRJKzE8PirJ1SF
X-Gm-Gg: AYBFou0td7hI6RsvCiukcsQHQjv/cHlOVI4OMKeAy3ihhb9RMqRNB/RPqWQEq3GOL0L
	SCKfryBnAEXq+rFQVewfn5J1y/0uxw35vawZdvfQ6gREEnKo9iU9NoJzoPfAY60q1z6UGBawJvb
	JSIgW8s+kzg+ZlAPs9ZZVlw7oox7+xvigbn8GEAzf0kqZ+BmvsygEKxjWmkBgCilL65mZlL3iFy
	AcdMHBqr5dGv4oXkv1IyHp8gx9X9fvn+RYLgOlmOmGR5qjiSZaiEIIMachC+Oa6mTTQpY7pE6a2
	h4bQjktc6Coqjyi/47Pq85eDU1MgoBcLjUSDHtElNKr/TBXk0FXjTL+y4qiTkbGNsSx/lVFmRrn
	kk1bovizcLUhIVW7iQjetMk0mK/hGviVFr7yncA235p91E5UgzSahddy/BF3WT8JDm4qjX1gCCp
	7CCCSfdWII6fhgSdyi2lgD+tQnEQtiWNZGcaSMAwNO478Tq24O4WUxso/VdRU7VPQYjU/X0Muva
	fN0zPds3RJNre9QsPBig0rIsLrhnyzxQsSwBRJi3UPqvHyrahiaNmwI/X3/E4eY+y8d+pVRDCO3
	0KDrIWv9QAJFQbupfNMhYfTjBRHoMqEiDj1wEAo0/tYfTVdRtb3JCv5BEklwZet96C4MmgtBLjM
	eYdOeStdF2VfO9oKIpt3aGcKPh6HuwnPWRg0Bkwmpelh5pRgMvz12L7vXUcyM1sHs1XgEi3SjqY
	HokHuhzcrbW/0WYoSVgZgIHjxwNzwLni62t9Zyqxs39MH5pwU+oFRripaTr2LMR3E=
X-Received: by 2002:a05:693c:87d1:20b0:367:23b6:94e1 with SMTP id 5a478bee46e88-36a20140439mr4800889eec.41.1793225104481;
        Wed, 28 Oct 2026 15:05:04 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390a812sm9924429eec.14.2026.10.28.15.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:05:04 -0700 (PDT)
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
Subject: [PATCH v3 2/3] iio: proximity: sx9324: keep the IRQ balanced across suspend and resume
Date: Thu, 29 Oct 2026 03:34:38 +0530
Message-ID: <20261028220444.70121-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028220444.70121-1-kapoorarnav43@gmail.com>
References: <20261028220444.70121-1-kapoorarnav43@gmail.com>
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

sx9324_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9324_resume() also
returns without enabling it on error. Without an interrupt line,
client->irq is 0 and both callbacks act on IRQ 0, which the driver
doesn't own.

Disable the interrupt only once the device is asleep, always enable it
in resume, and skip both when there is no interrupt.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 255a36976ac4..ced415747a98 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -1088,8 +1088,6 @@ static int sx9324_suspend(struct device *dev)
 	unsigned int regval;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
 	if (ret < 0)
@@ -1100,23 +1098,32 @@ static int sx9324_suspend(struct device *dev)
 
 
 	/* Disable all phases, send the device to sleep. */
-	return regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
+	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
+	if (ret)
+		return ret;
+
+	/* Only once nothing can fail, as resume isn't called on failure. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
 }
 
 static int sx9324_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
 
-	scoped_guard(mutex, &data->mutex) {
-		int ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
-				       data->suspend_ctrl |
-				       SX9324_REG_GNRL_CTRL1_PAUSECTRL);
-		if (ret)
-			return ret;
-	}
+	scoped_guard(mutex, &data->mutex)
+		ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
+				   data->suspend_ctrl |
+				   SX9324_REG_GNRL_CTRL1_PAUSECTRL);
 
-	enable_irq(data->client->irq);
-	return 0;
+	/* Balance the suspend even if the device couldn't be woken up. */
+	if (data->client->irq)
+		enable_irq(data->client->irq);
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);
-- 
2.53.0

