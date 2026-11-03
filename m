Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717585;
	b=PBvnqyrov41cy9QTKK+Ud4A4/DZwnPhNgDbn1Tb67fc0k+zUAG3k5lzS03ZbqmSeJXDM
	 3tPvsviyuP1WgT3Vu50uyAjcpu4VTgmBqQTBm137I0WG667YCo12D6EoZQgnMWQS7pfr3
	 xjwAsMhrNL6Zer+V1AIJEx2voVqZDLTPcoeGSMrlkvFXkC0UAK+PNg4lt8fTfk31EQb4o
	 jF8bEv+ub3P2RXbsbeLHkEbdYOtPw1g32hIXS1bGkK49ackPn9vVjFL12Hn/BrpUZzKfU
	 QDO9G0uwyPPSj07lNXE+fr07AaQ3aSW5eyIzg0HqhfYiDbsGwVwDUevhNG9dxfopCvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717585;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZgsSRgLhdRJXX0D7l/a2ulYRdMo+CZDmbqVMPRhhICM=;
	b=ScoIOKI24spaHNS2Nx3ypjiiG497XPTL08vEWEUAi9heJ+fTixCfVkjb97jJq9t6RGEw
	 1QmqOJRyAANJHAyRmrcyXlqK6zKNaB5yrZwaJHuseTrj67xCxu1ICjZ6d5x3ANUCAHjUT
	 ecYneUDqK9F7ljn9ab8cogn1k2Fo73ejPvUyJhR74k+OUQK+OQTdZuSLiRe7ngcd+XIwF
	 uLqs/psOFUCsyQ3mea12EqVg1KOdleNcQBkaeKzTcoqmbJlX2ZsT4RpgZmyFLo518ztmi
	 jotAIxNOvnjvDvkCAA5znwgzbsTbE5pvfbDUS2NeRn8qDss5IKnH3caI2+QjuMZT/PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcQQD26j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF760A5BDC;
	Tue,  3 Nov 2026 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcQQD26j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793717583;
	b=1V31pSPAn/+/FqScK9noDd28CdPaNy+33vsKiyCAsassRvPZL0t4yCMvWbSbBDriHi1F
	 ma6MRXDPAL798Mar27IhauMEIiH4e+Cz+CZiTkKgtx30Zmg+d6MT693PoF5FRfDCZ3rgJ
	 OVlri4UUfFI8tv864vxKtEiT2sD5vra2/Cl1aCO9Ke2qdAnA94L4cE2O76oy6pOgKHi/7
	 JbJBh6VVZvVCHzroI/SCwIiCFbT1/KN1T4P/fu3nfN4qtnz7m2OyZPdSUnUaI0voy4Iai
	 irwnh6cEPSQyAaDTGXq4SPv0xxj8zzI4AYYKJ/Z/iNwG2xR/v4uhkvqVeHhzlTbe7Rg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717583;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZgsSRgLhdRJXX0D7l/a2ulYRdMo+CZDmbqVMPRhhICM=;
	b=zGaPfuuCJcNGO+5NuJsXNg3QbdHGMT+QFBo9KW7GnbF1xEtwU6+KF1vCiMNEQSh9r7Ik
	 vILDYWInLfSIsdWqoaOV+rouqLl2WIuk+/cpQHY9dzrI1wNj4EYc6HGa4CR1IpWt73/AR
	 1jmnkPF4D0Iy560/JokZ5yREtR1r0zo3JUluoULUahMPCut59dnMTYjvdeGJVwjOAMMrG
	 K8Dq2XJgNBdGhDxBkQOcneZDbiUS7x3n/Tqhl8wOHNkIl2yvoy93lbEfdBIqfPe8teyBn
	 WmGfeL/O0GkWAbnMnwalanoesrx20ayOdD4Xvx827WQrS9KgcLUuijuKCkyPBe86VdQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4C821F0093A;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717583;
	bh=ZgsSRgLhdRJXX0D7l/a2ulYRdMo+CZDmbqVMPRhhICM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gcQQD26j3orAlu23raTtvUQUIEWJBUU8k9DynM8xDxVnYHU68j2m9Phrgke0s5tL2
	 9PC1TveTSoqgkhr/E6bjj14tFSuWjqRc9fQWbtBZvislIZjqdsUYrzNzRLg/0s7kHZ
	 JU0KhF+w89aa/69X5MhmKszQopvw2OUMiNmSDZVWeVdFfejqtPb283PD7QV9S41RD6
	 /f2qyAfJzJJXlXYwr2iFRyVwTE3ZeGHD7Ry75Q3CtisDBBzvzT4WDzg6QdATQXRmzb
	 vJd7eZP/f07JHhqBzGV7a50fRcW+lPG6u5qbXHoeee0KTNAW1vBpHw2HK5x2qWWRe9
	 sNkp2JaVOh6/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 697E3469A2;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Nov 2026 11:52:58 -0300
Subject: [PATCH v3 02/10] iio: backend: add devm_iio_backend_get_optional()
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
Message-Id: <20261103-ad9910-backend-support-v3-2-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
In-Reply-To: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793717581; l=4433;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=DR+JgLsY7qzSw7iJ/0ySFgwEAMpmPHtv/6q9aBcxSno=;
 b=DGkCPtymJw3YK+3vP3zTiq3xT4HrI+5ohXpB3/hKOkFbDCw+BDCBkqAYYnZsiF0mdjnwuXtaL
 PFT3szY4R4UDnFiPAjYHExlLCujsF9UHEsSKdvp8NykBLjslEdXonVA
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


