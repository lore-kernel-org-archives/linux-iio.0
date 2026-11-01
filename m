Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528735;
	b=20hnuozif8Xw2ODg8S6ZHQVU/3oclNmb5OePnF8GwMhbbxRtv97ArHqRaHbX2HFJd+6d
	 IT8duG9AME5ilFew/m9pIOs0/cFkOhkGTq23EigYKI9aMcyXrjf4GyEa01ggs9ieimKWh
	 21mm7hMRR+qLnflQPQAHHrDsb8chHN2O2eHyiQ2VnN9quDrWH/+Rhxk1M6rx5CCjGkff3
	 0TI0r+dntEgrrblSx7esxUxaAOh/y8Yo7v7TK+BC3JS9DPOxcAfjBc6zSaB9QQzhghA1j
	 U7SpAABW2M9S/11/bs5gyEWt4uaDjHYtf/XKP//BgNUPsrGAoLjOaR04/pq6i/yR2Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Yz41EgmzVHT2TrkuGKMcash2HLmMxiz4Mrz1ARsoS3s=;
	b=GvWR2TpEUarsW8xrB0+S5k6jlrgvb2eawbqFHlciPqGqQhTuRyUCJW+8orHt2aVaC0aK
	 jy3h7FWntLJJQyhOFunADY0w4PKYGaTujj6Wb3gmbTf/pziZMa2AkFvdyq8UzkTOhPzgm
	 K8pR9Ag9UcCf3ubCfgvkT2lXAYxZN7QL4IZio6eDpMs1qMaXP5K1ht2fVvylIQ9+vuZPA
	 7wsB2jKmWunPCKHlpOP8Pz3TdHomyvM8GnY4ToTTKgs5PvWN+pVZiEh4xdH8S8hSOTNMh
	 GKZLSp/hc37GISDuIRWAh9+2gf6+XgXtjLz3IBWpJ2EDq6R+PRTngjakhGjLCQ+DsBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AB9JOhXl;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CFB606A32D
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 10:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0CFB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AB9JOhXl
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35c76e9614aso2982568eec.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 02:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793528734; x=1794133534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yz41EgmzVHT2TrkuGKMcash2HLmMxiz4Mrz1ARsoS3s=;
        b=AB9JOhXlSGRcFDVt+Qse3eeEne4tv+2gZSTmaaeOVZoUVjvQ+dd0ieJhkSwZ+bOT6r
         4KFuyQX4M2z3OLCfuaR7UkeOLSl3cHkiDDDK4u/3Wfqcbvn73RMRmCY81TaaKW2RN9WC
         hDK+3cnfsxUYFBhDHOu0FpeMWUSyNgGNhRubpG7L7hQ58a5w8CROVRqVwb02HawN0UGO
         vW7RlNIyYAlw/Y1uI5sDnAhZdOddYcqi1Kr6e87TncMt/8SSZujv598hkUCo3HCMu4rh
         oJaq8xN+xbuZ1k7uj3DQFthP2vJbM14ELW6+yIIVukJLo9P/qfaTeOrXTumjNVRa3CHi
         dNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793528734; x=1794133534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yz41EgmzVHT2TrkuGKMcash2HLmMxiz4Mrz1ARsoS3s=;
        b=xubQvm3Q0XzI3M0X+pHTA494ntBP9rCk9sIKoX9wAHU/jRwrlIzLxb1o/9gQEGVpff
         xfQCxqLoKdmnp3MWHmy/jX0nyf0Al7E8CM/QTIAH50Cgwe5aFbNFzinyl71g9jY918cK
         PQp+E+3UYyGv7hL20aP2KVK/Wt2wVW8ZLeFB1I2n6FLHXGM4r7in0RFOU3Q8z4CClr7n
         d7WAkpADTWte3EpK1O536cCNopSZLY/5iFHC3nAaaW3WglntqSBXORSQuPAKMhJapnTr
         D+yFdr1KndU5MboUaOIp18WiZLkDk/zsJ9XL+Iu5iVBflp0Q+iS96L+5HvQKCp+vWEUd
         jwug==
X-Forwarded-Encrypted: i=1; AKwUvByLUCxROElfBu5fznfk3FLhjjFrzQYcfqazyJDRam5Fr0FXpf5KgkPP7ne3FJ1oi6YFrh+8ULbq/Dg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBUa7KukPKw3pmJFECEVSzpS0xPOz05mbu2D645uFl9EoY244Z
	yr5MRoBpO5SJ19TQd2ABaWFE9pH9zrl4u+oY26K6L42Qd/VKVL6VLJv/
X-Gm-Gg: AYBFou3L0wseZRy7id2739FLZzn2CIFZsfTOKcqrMRoxKerSyzE5qcBo8CPXkh23t+q
	7iyOEoxqsGjK9BkeXZ5cDTBsnUIiUI0b4L4GNYnPtNSx5w1bO1q2OJgqVs5ktJsox7gZsMOtqOj
	UDXdARXKC+j0dwuarR+lfZcjq+u2ic5XGSWKkG9gna9dvbUQMhLDSxg7GyDIkFHP9zPYnnnuaw1
	rNc5O50ZZbrsubcIvjjdPA97T9IadHpRXI6j5MpXQ67up1CwkpYf7Q2U9efrgWrlqF2w8iTrl2c
	rkkjRkgrJUF6XmEhOge/Pz1WKn3GNkkFcL2rIDc9y0jKOFJJK3N2m8X3Xl3eIVjBfut7ROsIUbk
	dbh/qnGBuTBLqW6kgZhBMdPMMm4hSzn0AQp0TMOSdWPs6EfPo3FAtPcadw2aceUPNvvc1cE/3ZS
	swD2VlqsUMGzeSDzc6QPAbRfCiWSHJovxBu9hD0sUpkeCPpSl+iUpnNWAvcwPu+96ifQeKqF+bc
	U58Pk5clHA70vJJSLUKlPxIQRGkE2PpEWQCrKHTg0OpkcGo2czFG7LmMhiXw5q+NLZpfzNZBEot
	0u1tx18GAiIek2oGPprHjdCtzs69jJ4dhFW6PCgUFvFYjz/qM8d8xcBGvRGWjR+aPZys+tMRwsg
	2vLg0eAF/6R1R42+oUl8+p1pbOVWk2SaFTIvxfYqh03FyEi0FHPOZ7GQF4fbWJVLQCpUJ4fTNCS
	KuX/FvBM1VnIIOMB/GU0OG4czwb6WQHlYQ0Kt4VbKbGQ==
X-Received: by 2002:a05:7022:68f:b0:169:3706:d61b with SMTP id a92af1059eb24-1ac5bbba040mr14277811c88.16.1793528733897;
        Sun, 01 Nov 2026 02:25:33 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b106edc7f8sm6767163c88.9.2026.11.01.02.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:25:33 -0800 (PST)
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
Subject: [PATCH v4 1/3] iio: proximity: sx9310: keep the IRQ balanced across suspend and resume
Date: Sun,  1 Nov 2026 15:55:02 +0530
Message-ID: <20261101102518.22757-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101102518.22757-1-kapoorarnav43@gmail.com>
References: <20261101102518.22757-1-kapoorarnav43@gmail.com>
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
returns without enabling it on error.

Make the two mirror images: disable the interrupt as the last step of
suspend and enable it as the first step of resume, before anything can
fail. The driver works without an interrupt line, so skip both calls
when client->irq is 0, as sx_common already does.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9310.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 79ba46d8a0aa..373037ca67d1 100644
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
@@ -956,27 +954,33 @@ static int sx9310_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	return regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+	ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+	if (ret)
+		return ret;
+
+	/* Last, as resume isn't called if suspend fails. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
 }
 
 static int sx9310_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	struct regmap *map = data->regmap;
 	int ret;
 
-	scoped_guard(mutex, &data->mutex) {
-		ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
-		if (ret)
-			return ret;
+	if (data->client->irq)
+		enable_irq(data->client->irq);
 
-		ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
-				   data->suspend_ctrl);
-		if (ret)
-			return ret;
-	}
+	guard(mutex)(&data->mutex);
 
-	enable_irq(data->client->irq);
-	return 0;
+	ret = regmap_write(map, SX9310_REG_PAUSE, 1);
+	if (ret)
+		return ret;
+
+	return regmap_write(map, SX9310_REG_PROX_CTRL0, data->suspend_ctrl);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
-- 
2.53.0

