Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610899;
	b=ISSn3qHeno6F1DykJrwEaucqWaw4PbX8DFZM+If1vnu+9y2dBDbreA22TXI60U8dZcTE
	 IYJRGjqCShYxjNjsQIYavIiR5sSp5F12rifbOSKKnn39dFJrwcSAmrWPUWnpcvs55m1DO
	 xwNV8nKBBWQIftaAOHPvQL70STYsYknXKZory+FrUlp5LKu6pMwEChc2QXWmeBlFn53TH
	 3Cvzq8dnWz2puzuxOYoXoILRYylhbrZGCESq3/HlHmH+YWcwtQa6Ip35xfdT4RApOYtYR
	 HhZuVowahY8GbGO35AFx9zehCyBAAQDQfQQgurGI96UCYcoWoRLOHxCmRYlKIaXB+qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610899;
	h=DMARC-Filter:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=A+lqbrQAIEwlk5+DaXG+EUNJeqeR4Fn6WDjAlxN4jz4=;
	b=ggzFrSPSeID+0EQjXGtk+PtkkfNTs9+U04AD2sPSID/czS2Fvs8bM+SeXGtQ94eR3wh4
	 Jp2wN8B8E7t82Ki7Qkgyag57+7jTGlesjXZje7Mwo84bzTFRylIel6s8asqw00aeV3VPC
	 WCExPAx+1VuP37XOOeZ76kbcioIn7CWM2KwRXDlD0AXwoGFCtvgIDqU49FKvXT5a79pU5
	 iesdpSGh9WDnZzbgylp3bGt5LMNpSNKHU4ItN8lPxZpHeHRm+LmxGd87lFgSkZOriiumu
	 q3fMqhCJFj4K1y/Jq69fJ//ljMbL/oF2IQS502hM7JC6JHRrDi5nohSwZ4VEqUHTk5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Ay2mFda0;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735F606A327;
	Mon,  2 Nov 2026 09:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0735F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Ay2mFda0
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A29Eagp024461-6A29Eagr024461
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Nov 2026 11:14:37 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xNo7g-00Gk5d-SJ;
	Mon, 02 Nov 2026 11:14:36 +0200
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 11:14:36 +0200
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH v2 1/5] iio: chemical: sgp40: Do not convert I2C errors to EIO
Date: Mon, 2 Nov 2026 11:12:54 +0200
Message-ID: <20261102091258.247402-2-jmatko@utu.fi>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102091258.247402-1-jmatko@utu.fi>
References: <20261102091258.247402-1-jmatko@utu.fi>
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
Content-Type: text/plain
X-ClientProxiedBy: ex19-10.utu.fi (130.232.247.50) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgJAygB
 HEUDBAEGDw0aRgwNSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=A+lqbrQAIEwlk5+DaXG+EUNJeqeR4Fn6WDjAlxN4jz4=;
 b=Ay2mFda0pWu62KL0USdMtHsR/EAWYvimX3c1M9kWJJVKot7eY3GEEg038E0dsRruP/v5XhWA/7Gy
	Rdc70U5M6mc10Sze1/FYx3aYnuESapRK1fHOKcnILpXcI67+mQl0Ipvwx4cw+QmzNF1qu37tND7J
	kw7nrYMXxi3HIfNGeEqcXJ2MAj8f+/fQ1vdgir/IqwBwHIxJROo3CoALyWnCqfonR7tGtYbKf2XE
	ZyB8QVXwoOCmr5+VAbeXhNCA5P8OEu0TuzC0XSBaGOZSo+EoeVozUkUIMzfmjBY1iXarG5fLJn4m
	OpwG7vTK3tXA01JPCjLoKSJG9WYmG9p2/rxMVg==

Any negative error returned by i2c_master_send() in
sgp40_measure_resistance_raw() was caught by the
branch guarding against short sends, and the error
was subsequently replaced with -EIO.

Check for any negative errors first and propagate
the error without conversion.

Fixes: 1081b9d97152 ("iio: chemical: Add driver support for sgp40")

Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
---
Tested by forcing i2c clock to ground. The resulting ETIMEDOUT and
EREMOTEIO are now correctly communicated to userspace instead of
converting to EIO.

 drivers/iio/chemical/sgp40.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index b2b5e32a9eb2..3a239fb6847f 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -187,6 +187,8 @@ static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance
 	mutex_unlock(&data->lock);
 
 	ret = i2c_master_send(client, (const char *)&tg, sizeof(tg));
+	if (ret < 0)
+		return ret;
 	if (ret != sizeof(tg)) {
 		dev_warn(data->dev, "i2c_master_send ret: %d sizeof: %zu\n", ret, sizeof(tg));
 		return -EIO;
-- 
2.56.0

