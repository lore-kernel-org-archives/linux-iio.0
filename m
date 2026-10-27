Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105408;
	b=YHJmWouK3dLo5O6k01rpSrF8lMsmpqA4ldNsKDH3oslqKVytGvW3zEo09dJDIDPLd1gG
	 uLqR1WjMxUXLuHfC8liTnWF+xYRrWVBPLJTFlAP5ZHqtCgsmScgBZ2o1T/syd/yIcD+ps
	 W2UY9W4uw5dDZaK+zSl6Cs9L2Lmmiq14Bihb3NtJb0FOGTLBX7xkZ9OfvMuo4AaKKxX5P
	 yTUGu/ABEGh7FwgGfN5LCiGhPzdQoQVBb/fdpcA2MzS9CILAzSngDDVzphmVXBGrRsYvq
	 GuMRfePgB7MefaW7JS5pY6nH78pQpG5dmb3BUtxPbfDdpoZRmxvbtvQe54gPoURmXKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5maieUrV3gg0OvUYuumtngfF5Rbt74fkE8XBQYCal3Q=;
	b=lmg+byX+36115o9zKSK1M/G9vVPSgZaw3l7XN8aAlVObZedqGlL7scrlQxNbeTAHqfBY
	 0Z4QnTLk97ycXf0kH7RU/gP0H2eDAECuml1nGSTYwEPt3unYC5T0XLcwJmms/RLE8CcAR
	 lDm6I300qnACjWO255pU+lH9TG27DcWwaZt+L2IrzhiHTLLdxLunbnj8xDnN2rZS+rCwi
	 tWHypxqak/shdr6EqXCp91TYa24uwdkloR574q5o+pyHybW1P+vAFQRq7NmMQKaqWv586
	 KP7WjID40vlZgD+R6bUVIQyepOO8x7/2SK1CLfwiWeeMwGmeaGXGy4iGxNkF5P4KFfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hRl9iP1r;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3D560A2605
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC3D560A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hRl9iP1r
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be4c78e8caso1614011e87.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105406; x=1793710206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5maieUrV3gg0OvUYuumtngfF5Rbt74fkE8XBQYCal3Q=;
        b=hRl9iP1rX7Yescz/IkmbkH6cXyf/ED1aKA7Xz0y5VNBAW8maE8GgmBLi1Wh1HJz5Xq
         zK07nv2LlnsuYPggwoPLVCpg9cILU7yxCYhUI8kfh//X0q4h84Uxy4WnAqOym2Z8oQ94
         870cWd01UkCi1PlsYPmlcE4siKtHAmuIkZEvSG/jnBk6fQ5mVK2vhe27IgRTfeNsKKDl
         YMuUVPSGHaTgX13h5g1TJatd7M9jShSpYRsgvpTcBOVfsiSGUtW2jk4UkN8GZ1buI9G5
         uY4QIKF9bGFC6ba9VYdtJIgBxMjedCj7bDXcmJ1v/U2lGc93fGlda0Wo+SvL83E1oZsb
         G2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105406; x=1793710206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5maieUrV3gg0OvUYuumtngfF5Rbt74fkE8XBQYCal3Q=;
        b=fSs81MXVyh/0wZIPi2HEZxDt2eOXud+AU62mglm+2eqYvdZFeCLfnYFMpF8fXU3XQu
         GryYFY8Y7AndulfDBM99AUhEaTOxf5/AXt497qIZApnyESaM4LMpaiD6QUscA2rilwZ3
         6X0RYK+RXGE/vHMEaUd/BXVAYBeK4sfusVPlKKefTXSvAjCFbhKTK5TcccMw0tv4jYxX
         HY2riuQ9wFcBPMYSUdg/Rn+P8z1iZ5H2YPLA5TdW5oaF7l1h0tsq2m9yapmj7EHxJd1p
         two2IoFgAPX/GK701/hEKKs2PUCak1jxcunl4tK+kb+H5QrePARpplFutmtJAspkKrrR
         tpjw==
X-Forwarded-Encrypted: i=1; AKwUvByo92NhO7SBFxICVuTLEilxxiTBrD8Ls654+lnTmktiH2PYESV253C0W+YMuDlNjMwLxim+1TNT0dw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNI0NNqxLDCMzwPHOf4ubBHBc1MA5XhP03FoHNUJQKijKGBcrO
	oOGl0GeawrqYEs41Fe6wexkTp7bJR8VOLO+SGiaM2qymw++ohp+JrpNC5/a0hwtz
X-Gm-Gg: AYBFou1yRGZYgwLrcVWeUB3GgT3aSamA/26ZA3IKse6dv7rBpcaOKBRjyfRC5inDdfy
	M10/M8muxT0JcjiIt2N36ghS/rxG25ikxINDMd2RBnQImEb9mXi1BtApPwSC6EKsPJQxZQsNrvV
	zFD03u30skIt8CebBZF/lGdpLuclSUZ0qcCUmFRTxTnABmAmZvrJjPsSRzDTLPspZP/kzDZkYU+
	jvGEkpvbRKzowiMetOOeSywAYa5f49belBvwzSA7XKXjb1Rdqxm03r1BhSttay0JA/Frk+CO4rA
	Uy6h4VxLf/01eDs4gXMt2eN/vUPxLJgCb+P8HvYZctISmBrO/Ben0KGOFHkCDRPmhsInOsGE9Ai
	a27X+c2fyjH+W1B/K5YF2nw4lt4Kg9WLpPIjDHEToDHQBogP1w36Dx8gOUMLclXkABVwQWuH0JQ
	NBR8drUegc/UjapJgTntp91+KOQH7WFzjzGn8yUxfAeS2vch0hXQFrk5bhEICwbTpjiVa1RU0Wn
	oj99srYPg62EUI91Kv+D1KS1aJCvTk4JbuGX8etF5FDHDXPQON41gTcYxRMVLxQjy6vbo839YdK
	CHScpyNgNBRbydWn532/rQE29tx4FRN0N8E1A0u0Hj9If7chr0azhXNL8K2v8To8
X-Received: by 2002:ac2:4c47:0:b0:5bc:b15d:beb9 with SMTP id 2adb3069b0e04-5bfb71c6b52mr3628166e87.29.1793105405831;
        Tue, 27 Oct 2026 05:50:05 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:50:05 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>
Cc: chrome-platform@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 3/9] iio: core: mark the mode lock helpers __context_unsafe
Date: Tue, 27 Oct 2026 14:49:48 +0200
Message-ID: <20261027124954.110697-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027124954.110697-1-zoone.rupert@gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
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

__iio_dev_mode_lock() and __iio_dev_mode_unlock() are declared to take
and release indio_dev, a token for the mode lock, because the mutex
itself is private to the core. Their bodies take and release the mutex
instead, which context analysis reports once it is on for the core.
Mark both definitions __context_unsafe().

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>

 drivers/iio/industrialio-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d73f2541375f..e9a5d1d905c1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2252,6 +2252,7 @@ EXPORT_SYMBOL_GPL(__devm_iio_device_register);
  * iio_device_try_claim_buffer_mode() pairs or related helpers instead.
  */
 void __iio_dev_mode_lock(struct iio_dev *indio_dev)
+	__context_unsafe(/* returns with mlock held */)
 {
 	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
 }
@@ -2262,6 +2263,7 @@ EXPORT_SYMBOL_GPL(__iio_dev_mode_lock);
  * @indio_dev: the iio_dev associated with the device
  */
 void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
+	__context_unsafe(/* releases mlock */)
 {
 	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
 }
-- 
2.43.0

