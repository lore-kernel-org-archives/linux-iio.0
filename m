Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847201;
	b=3Lu+kpmVNO1JSB+nXQAiCHezKNQdmYuodejOR2vsJJ8porUX9YnMeSgogk12E40PSUZT
	 jeDaRzIfdYjexgh/NUggixSbgxhoyL9sJFdHueD7L8SPezy4EQJivjlEIRmx17Znos+lG
	 vxgpj7GcS40G1yELA2QPgAZK/DW9X9OHAJfchcOOGkmwcz0q1GuZEOgb9WfEtDUAssTbk
	 YZ5knVa4/Q1TvOL/RJCsaVC1nMwyj1mvJtEcbE2dbTYLrVmgYQKLAWT52jk/V9oHspT2P
	 /ryuDUX4RBDDtYbbRHyCRbkFDnpxowO/kSt9auOG2h+cFieZ8dFV5IPgeXlOg6O3p8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847201;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lk2SN1MOyS9BuowyoHNf1WTArRMVQdX4/eeuskoAfHU=;
	b=CEFHXty1TfN1PpXQyJTz6u5K87MRNp3nZI3gWhZiSCP7D8sJANhaNuszScJPuDKP3DRH
	 u+VzZOs/7X0aMkLitv1PlYv6YWKdFLnFqSy8LQ74ELsDnRFiR5oihzZaa0SvEQQD68D0R
	 OYc+bp68C23j26z2RQKCNszcznSyjIKmWA/no9S6Llo9fQ/dt56ohTZBOHfn2joNcZ9JV
	 WTxVtQY7y7cLks4ejuYrnw40MN+bJSMxQueUkOGJdq9MH3zejvH1GnoP8LNR8aO+lEjXb
	 yvu+2X279WNMVla6EiCqBP7efaDS01sOXxDocCHmdYt7Fkk6Uz/Q2gDVGh0YHCh/zHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNx6e3VD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65F606A896;
	Mon, 16 Nov 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNx6e3VD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794847201;
	b=FA/mB7upbb2UAXEDUnxBDmpwBjNKhg724S5mri31ObiPAp3Dr8s8HmxfS7d00zQRrWIM
	 B01/oGIXwEWSbLhZI9MtYAQ/H7giutEOOn5imMUigaTOCNw9SfjyPrZa2prkzqZ/VE5Ci
	 nf5qM2udxAdaqld3l86nkQImvzVpBPisOC95ah6HiFJaVadcuu24zC9hra2V1KEilwI3o
	 djZ4ziaPxuBjChJLAGv39Pt1rxmuedzPf1D9y+Ij54OMhvxG+SsKQIS0Cod6sEaoLPe+V
	 Upg/aBKtRxKYSuPwvsPsSEthOvEweVTDAuw4L5TOgfs3Jf6JolWwEq+HsyaLg5CmvNg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847201;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lk2SN1MOyS9BuowyoHNf1WTArRMVQdX4/eeuskoAfHU=;
	b=IskYsL8RXTbGVL79lwmP24ZBvrmK02sz8L5zgrmAhSp6O1Gk4ags78c3Y+vnOw3tX6kE
	 s3u3ZWjzCB2MAAKNG0iHi7dSDKTnG7XFQ048UpVYpXDmq+Jdjk67SoEkkL4dzlvXyCzgt
	 Jw9BOXxQqk2NpxmaMdlOdwSx/mEYHJbAZLSh7C1v801S0xKx2uMRdUWG66Wxpla+RAMy5
	 GAt+Iyos64WYUVNe4AIeb7PfOMMjXMZQc7TVrK7tvyGYNqNgunmZjWbup8p3jAxhhAsrC
	 EX5Qi5rVqBTINgbTd2sWuN/GWpgqBSR8bxfx03stkoGiHzpfB5MUQUxkfMn36pg18vA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 83E531F000CC;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847201;
	bh=Lk2SN1MOyS9BuowyoHNf1WTArRMVQdX4/eeuskoAfHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oNx6e3VD7PfJIvakux/7IfKew9NAFMzf1wVEWRF/AC05cS8Fw017hC4MFe/kPgluD
	 fYGo4Bd8jXRlukrGpAlf6hG9ZciZrznwByGMKPwET2ayNQnRUFzli4hvaO07NOorpF
	 2AuD5xoxUSx1dJKDluly58X52Tm/FUMEntppxieGbIlIYWv26DGk9Q516gpe7yUpVg
	 8oZM2cwTzeb+7nR6Ry12uU+Y+xx5QRyr+hRZCfp/NkfPSZMBBeLfUd/u5BXONBQFax
	 icMfPWbmRWG08Hff70PqTCEEJL2ww5Ju/w1VNfjorI3r198ZbLZsoKtu3IrxSIzO0O
	 sygBXfEjyF5Og==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 116514A526;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Nov 2026 16:39:56 +0000
Subject: [PATCH v4 04/12] iio: backend: add devm_iio_backend_get_optional()
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-ad9910-backend-support-v4-4-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847197; l=4395;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=1RmO+bYGkY9qG/xEVJTt7o0ywOtzaEkx7xtxxPpxxXY=;
 b=6T/BbiBTjiE0kdJUDIl5wNN13mP3TkGCwQPTlZHfAzX2TgmF2gsXJBCTDB9/N//Mc1b7CCi05
 Q7jCJL2SRqcAJ7lTwLli2guo9F7TmulmGns2fvDIPdBGWEFmyuVr+K1
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Frontend devices might not need a backend driver to rely on. An IIO device
that supports backends can behave differently when they are not available
and that should be acceptable. Such parts may provide basic functionality
solely using the control interface (SPI for instance), being able to have
extended features when a backend is present.

Add devm_iio_backend_get_optional(), which returns NULL when the backend
is not described in firmware, i.e., when the io-backends property is not
present or, for a named lookup, when the name is not listed in the
io-backend-names property. Other errors, such as probe deferral, are
still returned.

To make that possible, a named lookup that does not match any entry of
io-backend-names now fails with -ENOENT, the same error returned when the
io-backends reference is missing. Also, the missing reference is no longer
logged as an error, leaving that to the caller.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-backend.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 9a1072b39815..1458d5a3eec6 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -1006,6 +1006,9 @@ static struct iio_backend *__devm_iio_backend_fwnode_get_by_index(struct device
 
 	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
 		fwnode_find_reference(fwnode, "io-backends", index);
+	/* not described in firmware, let the caller decide what to do */
+	if (PTR_ERR(fwnode_back) == -ENOENT)
+		return ERR_CAST(fwnode_back);
 	if (IS_ERR(fwnode_back))
 		return dev_err_cast_probe(dev, fwnode_back,
 					  "Cannot get Firmware reference\n");
@@ -1034,7 +1037,17 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 	int ret;
 
 	if (name) {
+		if (!fwnode_property_present(fwnode, "io-backend-names"))
+			return ERR_PTR(-ENOENT);
+
 		ret = fwnode_property_match_string(fwnode, "io-backend-names", name);
+		/*
+		 * fwnode_property_match_string() also returns -ENODATA when
+		 * @name is not listed in the property, which means that this
+		 * backend is not described in firmware.
+		 */
+		if (ret == -ENODATA)
+			return ERR_PTR(-ENOENT);
 		if (ret < 0)
 			return ERR_PTR(ret);
 		index = ret;
@@ -1061,6 +1074,31 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
 
+/**
+ * devm_iio_backend_get_optional - Optional device managed backend device get
+ * @dev: Consumer device for the backend
+ * @name: Backend name
+ *
+ * Gets the backend associated with @dev. A backend not described in firmware,
+ * i.e., the io-backends property is not present or @name is not listed in
+ * the io-backend-names property, is not treated as an error.
+ *
+ * RETURNS:
+ * A backend pointer, NULL if the backend is not described in firmware,
+ * negative error pointer otherwise.
+ */
+struct iio_backend *devm_iio_backend_get_optional(struct device *dev,
+						  const char *name)
+{
+	struct iio_backend *back = devm_iio_backend_get(dev, name);
+
+	if (IS_ERR(back) && PTR_ERR(back) == -ENOENT)
+		return NULL;
+
+	return back;
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_optional, "IIO_BACKEND");
+
 /**
  * devm_iio_backend_get_by_index - Device managed backend device get by index
  * @dev: Consumer device for the backend
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 9c16b695a602..93d5f2073cc3 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -267,6 +267,8 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
 bool iio_backend_has_caps(struct iio_backend *back, u32 caps);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+struct iio_backend *devm_iio_backend_get_optional(struct device *dev,
+						  const char *name);
 struct iio_backend *devm_iio_backend_get_by_index(struct device *dev, unsigned int index);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
 						const char *name,

-- 
2.43.0


