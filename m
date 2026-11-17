Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=91.99.108.219
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794904899;
	b=QJzkYm2JWtbcrduw76Q6CrssXCNpDd4sI+Xxlv46z19OCZVBD0jPslTEfmzpm6mkRmYs
	 u13+qfebiBRTngWjyV1cPktvzOPlPeEvxadbTY7kjuKmJ0VDNzIn9Ts5DvbZdl+mtQJcW
	 SLdGRiCcwQlyHke/flp6HCGQv9PAxVOYEV7mcUVB9+2INT4sZ27eiOg+U1YSFoixDD6v0
	 +qbEFueAPVEj2Pe/SCW8tiA8rL1FpWOw/C7M8J9Uzg/2Shf7Y0KkCKvYX8pXS7AaM3bNX
	 Bn5t2hu+Yt8OsOVV+K8NXZvPG3AgL0+Xa01pZieoDdGtGCwM3/g17PvL5C3RwufbBvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904899;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=to/JihE7zw3nyrKXMtNIgp1O+ckOaT4wODnjMS7edeg=;
	b=1xa/y8f3PaCbuYaUMQDN2E9/Q7Qqsn5yGNLdJjBi39016ObrE9IqqTuVfC8XYlY/wez7
	 qPvkja5i0uCOfITIlIF/HsDkuLipfNPppqHtCu3a2XjL2JHy5LwdxTf10DMrrpHAw+Euj
	 siLOSAK8Hgw7Ph7cbRhpw40RD6hA8j7Qh3r8xT9rVjdYKxmJPTvTM7AYxjO6wLsMKmvg8
	 zOoYG9J3ZqjuKEEqVbTmSFNDDDv6B4lSXM7x7zPCfDzD2GOmiqV3XqeF4m9ad2EBtFJiO
	 7lS2Ie5OOl9R9OGlKW+6Rg/qAq2J+Cj6lLopWo4k8f/kJKtG0WfEybsOIuCH+W8lZnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=catcrafts.net;
	spf=pass smtp.mailfrom=catcrafts.net;
	dkim=pass header.d=catcrafts.net header.i=@catcrafts.net header.a=rsa-sha256 header.s=mail2026 header.b="EqbFl/8F";
	arc=pass header.oldest-pass=0 smtp.remote-ip=91.99.108.219
Received: from mail.catcrafts.net (mail.catcrafts.net [91.99.108.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF940606A88E;
	Tue, 17 Nov 2026 08:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF940606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=catcrafts.net header.i=@catcrafts.net header.a=rsa-sha256 header.s=mail2026 header.b=EqbFl/8F
Received: from jorijnpc (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.catcrafts.net (Postfix) with ESMTPSA id A5A14FA9F2;
	Tue, 17 Nov 2026 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catcrafts.net;
	s=mail2026; t=1794904890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=to/JihE7zw3nyrKXMtNIgp1O+ckOaT4wODnjMS7edeg=;
	b=EqbFl/8F3QS4yWpd1NgAXb/e2k3ayNNzFOzivxIuGiD5nFUZS/pVkJZ9FgwpPaHxQ6iaW/
	ShE4rEazn47A0KWemtvuKu1S1Z+29i+kK/WHC4lO7jC7E0A7uIa27hwIXLIM5t0YGKGxZb
	ddoc2t2ueO4GSEFFP07kzLDqFrwOrmmtSq3aK/Eeg7b9rBPy7o67t62yqiTxp6hkD1B85W
	XfJRbEvpDckucFRfiFfB/OgmQBTpLL+IsouO+AigNzGXmBvORjukbqopifanEdW508N1k8
	umvnxokYfv1QvmaPxE1AlPn94rP8F3efSnBK2KZrugUoB4kcFx00lKq8W1Bheg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=jorijnvdgraaf@catcrafts.net smtp.mailfrom=jorijnvdgraaf@catcrafts.net
ARC-Seal: i=1; s=mail2026; d=catcrafts.net; t=1794904890; a=rsa-sha256;
	cv=none;
	b=Dk26shzc94yEABlHaIAMFWHQrsWUmXnCSNn2lt7GRsX6T5LzCOIdykgViKPSUbI8bHglXE
	/OdmVUhI+WFf6yByB8D/YT45LnTPHgR21vNhgjeE0WXuTE4n9323EOU5D0Te6X3oskDvpK
	+icFUlOPvEdqQnGFFVfunssfSpIjTy8ARNN0Z+iLxGv0nDSAecCZ1HWKg0x3kpB/LyTHdY
	kg06Em2azi/Vm6noTaOZdn6+afGu8CpsvF07OMTbVQ4TmLKc+08D354TSFFXgDIU0FYXpK
	dz+LJNwFaTgMaYL1VKNA/aTaEG1TSL591UDgXlymBv4XytUzlC2zrJrGdCyvsw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jorijnvdgraaf@catcrafts.net smtp.mailfrom=jorijnvdgraaf@catcrafts.net
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=catcrafts.net;
	s=mail2026; t=1794904890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=to/JihE7zw3nyrKXMtNIgp1O+ckOaT4wODnjMS7edeg=;
	b=DLlgA/6tBBd/UF5Bkz4MFPjRGRbqi5uFhC6dLIdj1g8ayGVwLillWYN2/Wa8KUIHRAPA59
	IFwC/mBf8gzsGChtzI4NQkbHASXJo6/6vkJhWgcVs3tSg16NYrMkpJnNYqF9cxo0TTaTgA
	YxHf94YGAOzBc9/Vb1jsFJkVVWeAJejY9IDeboIWAHdVwI8NNlDn4yvOVrElPIswJo6mQW
	MRB30A62ohBuQek2WjaTIwTBhNfRKwLjq2oNisfrmrySJ9Mn82yAaGT+R+g8ZmKzkn+d1U
	w6B5jNGy4DvAkFwr4QzfZ/V/jbVUlWuR+AB42lAkwldzI/jPxyDaFmbsppv7hw==
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Joshua Crofts <crofts@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH 2/3] dt-bindings: iio: pressure: infineon,dps310: Add Goermicro SPL07-003
Date: Tue, 17 Nov 2026 09:39:53 +0100
Message-ID: <20261117083954.335814-3-jorijnvdgraaf@catcrafts.net>
In-Reply-To: <20261117083954.335814-1-jorijnvdgraaf@catcrafts.net>
References: <20261117083954.335814-1-jorijnvdgraaf@catcrafts.net>
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

The Goermicro SPL07-003 is register compatible with the DPS310, but has
two more pressure calibration coefficients, and bit 7 of TMP_CFG is a
rate bit where the DPS310 selects its temperature sensor.

So the DPS310 compatible cannot be a fallback. The ZTS8032 compatible
cannot be one either: the ZTS8032 has the two coefficients as 16 bit
values in four bytes, the SPL07-003 as 12 bit values in three.

Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 .../devicetree/bindings/iio/pressure/infineon,dps310.yaml    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
index 416117dfd927..46f0892a75fb 100644
--- a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -11,12 +11,13 @@ maintainers:
 
 description:
   The DPS310 is a barometric pressure and temperature sensor with an I2C
-  interface. The Zilltek ZTS8032 is register compatible with it, but has
-  additional calibration coefficients.
+  interface. The Goermicro SPL07-003 and the Zilltek ZTS8032 are register
+  compatible with it, but have additional calibration coefficients.
 
 properties:
   compatible:
     enum:
+      - goermicro,spl07-003
       - infineon,dps310
       - zilltek,zts8032
 
-- 
2.56.0

