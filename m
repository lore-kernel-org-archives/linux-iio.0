Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682350;
	b=RJODuBTW/OOPoIoaOdCd/qfSQ2RexaDbCiu6uf5+Ygmg0DQSxWgS3ZTThQkPo2hN8C6R
	 qdfnVWMKWc7shqNHYD0t1YkY0Lil0daUNk7vDz0yuQm6UIw4R4F+ywFHuYYV9rwlh+QEo
	 hOVFytdMiKpFtBcnPDn/EQPpqP4E37ISpGaBnQbuSDuf9PiUWCgSDPLjM/hPPFTl4UgD8
	 fg55sz3m1phrtzbXU8anVMmjS2fbWzM4YoOCpcgZMMzBGlyidcrbiEpHtTCnYTzTtEcN6
	 cKdnEinOOMKAaTmeqQpRrT0AuPNlaXS77B99ZCdpKNOTwCJSg15Iqy4BzLwYgfhcHdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682350;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZgsSRgLhdRJXX0D7l/a2ulYRdMo+CZDmbqVMPRhhICM=;
	b=caJKiVVnj68qwDJVlFBvxxlKetxyd4xE7Suj9ObtRU3Z3/QVWXcaItl5bVS9gVogqDoM
	 p6qMQ/TVcOKVnvojKjNa07Y9sWrxxbV9jO9XAvqIalvJncqysNMTPOuRJhIfG4F5IlyRG
	 H5oPKMSjsYFYXGZmDJARw3NEBEzAL14Ggh/s8cyQsVS+ZH0wAEPXeb2W/q2CE7ctWwWWq
	 25oYs/RBMpYBjSYXtvRmBVxcIs67kaVAKBgxFGS20K3ytYrqewP7b+jphNvjwVmQ+xLI0
	 ZKLeL4pWpgqrXNhLulJG82TE4ViTTohNmTgtO1op8P3Knh/MGF0iK/TsPp5MzcGEgCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SPbTJyJ/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4A606BE53;
	Thu, 22 Oct 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPbTJyJ/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792682350;
	b=oPC/mkmqL8k6dIkjwPihWQV9mpKOt7kbD/PGPfkbsmWPcGs92ojZDTl9KgZofKw+Snsb
	 g+c27fbKqFss1NX3eO5UiOggmqFj5TNjE5o33MSOJPNrLo5PPCNQ6/qChGa6Y8BRPxDE0
	 1iV9JkkYP698giNZJIDa8PJsinnYbLicCx5pWj/lVBdn5HajnXsND4ZZzHxIi3+UToBLD
	 fu6hEEX2Gvb3bbwj9QqMBVQ7JnHZr8i5LwSyBFA5iJRBr+wQabYq3FqGV7eZyJqyn+IDR
	 sMXi7BevvScyOxn1jCzAf4879IrKH0DarU5mGIzjhFlPbki4BooceENoaLl0dJ24EvQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792682350;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZgsSRgLhdRJXX0D7l/a2ulYRdMo+CZDmbqVMPRhhICM=;
	b=0RGDpY6S8NmYp5VJkwXRGfJPdYLP2DKQFCsmITiQAfs1cR9oypn51IxYUHDJe9GZSPdB
	 rHSXKiEzBkxpu59y3lPc83z8z/oHwOloR8tmJ7iTjkT5V7WT7i/T9T9M9BoxVXLSrr76I
	 vZ3u4LpNXpBpVIG51kUXy4uN4+y6/YPd6hUeXbYVEMvHzlTzpUaFdoE/lk2LdLpLckGtZ
	 ZO8UHPoNzJFxyddegqcsX+/Po5DZtuVFUAZBhxA/vreEGHHBPY9X1Cmc8AHeb+kcEjSJc
	 ChC/Iwt2IulmYwHYelZ+EtTzHq3pY7hG9LNkQg+lqO2g4zwLDPO7a3OAMsWA3k/M8XQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EDAAF1F01829;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682350;
	bh=ZgsSRgLhdRJXX0D7l/a2ulYRdMo+CZDmbqVMPRhhICM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SPbTJyJ/DSyInQsNKfFWtSuBgD41b2GlQb9P1KOcVynpHjyMVjwa3WzR34zmwgjO2
	 xJGLw6cg5HxcVzUFqHkBKH9QAfsXGCoXd2xkd3PGxRzMCXC8rjkgW2CN0diQ0ivMQu
	 gnuRnj/ondEM3SSw2CmKTzXVhUzNKnhW18pA/DTnYI/uKmDX7kTXWIuliP+bR7CKki
	 boSShZpNL3xbYyn0bIkPCYTN2cb08VlTqVhWggUlGDu+3fLXE2haRhdc+h3f/2Izjo
	 3jbCLKe+4QkLshII6r6/hLr5WjNq70jeJEyRO/O2UPIXb3V3QJNZRhnzpLCJlundvM
	 b8pk9pIse/Kfg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 770D441E4D;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 22 Oct 2026 12:19:00 -0300
Subject: [PATCH v2 02/10] iio: backend: add devm_iio_backend_get_optional()
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
Message-Id: <20261022-ad9910-backend-support-v2-2-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
In-Reply-To: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792682347; l=4433;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=DR+JgLsY7qzSw7iJ/0ySFgwEAMpmPHtv/6q9aBcxSno=;
 b=3crxF6HvT5YXyw7lQncL7kG6Ddm2Syj8/O1U35ssgsGrGerNwuxlVurVylA8hO61dD0jB5dih
 vVin55RAwaJCDMT2C+5/HMGDQ7QNjwZAXflztbrTsKBiQ0ei9DvZwhj
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 8bit

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

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-backend.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index fbf5c39d7655..d12d163f45ca 100644
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
+		if (!device_property_present(dev, "io-backend-names"))
+			return ERR_PTR(-ENOENT);
+
 		ret = device_property_match_string(dev, "io-backend-names", name);
+		/*
+		 * device_property_match_string() also returns -ENODATA when
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


