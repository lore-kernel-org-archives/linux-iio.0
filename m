Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=91.99.108.219
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794904901;
	b=MdZAl80aGOH/SpL4scCS51MGPRC/Xd2vD2M2W3koJThxUGu9Yxx4nobnwQ2PWN/Kq1RD
	 AxYlbXSYqp4hwKs5XUONHPkELbZCam4njozcV5Zh13OMwefEV9j3Y2aZrtXioJz4E0bKw
	 vZk2UNNct2pc2LNKhjodXEPag2V34tMaa1W7CuXH81RHQZ4y2+lY5aQ8aDduEPO2RppHP
	 Gy1kHOTjO2wWMwwmQnlqDvtljbr5Ut5E0ZFQKTGZ+bZKjDe+KUY1SLVu+M89R7zTd1snp
	 zePspHx80jsgSJhSkpLp+mK2VUtrmQsKWqCy/GX6DyeMbHxsm9iYbj/XcmgNdbxa5Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904901;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eeBZ1iGnr9f6bGDcLO3nBO125C8080rw02ju6vAciq4=;
	b=LnWUuZRxskaRgMcOH8Hy4+FhlyNisGl3xTUyKSKtJtmC+DdHmfKadis1vRGBKwAsTllv
	 pEN1LDj7Q+2qpuTzkEkxoEH6FnQ0jbyS/P6LwBj6gwqPlbBUUirk02QrP32rw8WR3bklp
	 XjDF44oqpTbSF/8X21bpIe0AITZl6DXSVbOnO7X/T/aq/3gPAkaArfUEvqC+PTFHPNYOe
	 p2o/A9S6WJ4KdQSSLFBp336LIidQyQk8qDgzAkrsWpUMq4GDczTpGtS0jukHxgmQtqHY+
	 9/vn/kyKb74gvK11FHa8+p29m+GETBFbJX6d3/CYfLHmihHtVXL/872Pqm99UsagnuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=catcrafts.net;
	spf=pass smtp.mailfrom=catcrafts.net;
	dkim=pass header.d=catcrafts.net header.i=@catcrafts.net header.a=rsa-sha256 header.s=mail2026 header.b=EBzYQTWV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=91.99.108.219
Received: from mail.catcrafts.net (mail.catcrafts.net [91.99.108.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF296606A88B;
	Tue, 17 Nov 2026 08:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF296606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=catcrafts.net header.i=@catcrafts.net header.a=rsa-sha256 header.s=mail2026 header.b=EBzYQTWV
Received: from jorijnpc (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.catcrafts.net (Postfix) with ESMTPSA id 0AD82FA9F4;
	Tue, 17 Nov 2026 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catcrafts.net;
	s=mail2026; t=1794904889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eeBZ1iGnr9f6bGDcLO3nBO125C8080rw02ju6vAciq4=;
	b=EBzYQTWVXudygUwxhFInmeMrtrSvzj7J8S5WspwNngBj3yKsEcqmpmdHKXlZ+9jq5kcW0p
	TplWoNs+zt8Ff7X4D8yvqrStcFTJiW6Eo0ozW2m+Uq0CEo5hkLhgXXWF+INcBJv9UJ8eN+
	w7B2yScFh8Xizc8Xf3unSrNQVF1aJZ4z7a1s2lGgCwq/JdSLNX3XFJaX6DzCEJaUzQXk80
	m/QNmnnUUoZJ4wlqmQO61FcpOgBraGWzLdbGjHy6pP+ZDnNX5tv6coPgnCyQRSUirVsTue
	DSpewy+i1ttG2yeBNmOUd0N1ZSyEa35Aw5Afi7wUqXtpWubQMx/oqYL4IyyrVg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=jorijnvdgraaf@catcrafts.net smtp.mailfrom=jorijnvdgraaf@catcrafts.net
ARC-Seal: i=1; s=mail2026; d=catcrafts.net; t=1794904889; a=rsa-sha256;
	cv=none;
	b=T+aVDIrrx6Txa0HH+KaeKv2SxuliKrfVrYUGMMYHYq/54KWhe0+I9tWqGweXXgTAuKefeZ
	/xPbvUi6q1kn+aKq8C9oSkC/8LZpUuGKhL9lotpkuageGsdFk0Gn3HT5OFpZjN/BrqdqqK
	bo09PTRp4dRMnMwBajux6vg3U28zZNJObj3YhuhiVXcYzVRYmhncP00PQVzHDg50UbaVrQ
	YESDDXaTHTeTJEYkKNNGgdGUUUxL8KlX3l3oNnD0UAkOmSwhAAc8TH2ZqdJDdElyW4KBjT
	ukiMBYi9RR14PX21ojaFL7+a/bHM6SZZcb3xxAewXdmkAwIx2vNLSf56X/yLFw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jorijnvdgraaf@catcrafts.net smtp.mailfrom=jorijnvdgraaf@catcrafts.net
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=catcrafts.net;
	s=mail2026; t=1794904889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eeBZ1iGnr9f6bGDcLO3nBO125C8080rw02ju6vAciq4=;
	b=E9XYjFr5dFGkJB1fjBG74ZuEcqry5byiHdC3/qqW+UDbUEtKhISu9xQgC0h8rjLtpNs0Po
	DtfWJVAdzeQkKjWxZFGvKchMnCGhUbcktT8EOqT2Tli3oELSB4HjzZwIOtovueGioP3q6f
	RPOs+JssKFwCgFAUKrIFKEzit5St5uCnGogBXhie+nOtGbrFLGZai3OCiqmyaFp/3Z2GRg
	cu6KEap9Q3NO1A4sNQaPF2nkrTlD9n7pGklzpT9W8hhqP7PeZCIuVbIMFhDcjr0GW4m0/y
	Hv9J8slKaRutRM6ZyHqndVyhLVlEiqjZ81b0aFHA8K0DtwA0kjCbIUlIPT2n2A==
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
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Goermicro
Date: Tue, 17 Nov 2026 09:39:52 +0100
Message-ID: <20261117083954.335814-2-jorijnvdgraaf@catcrafts.net>
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

Goermicro (Goertek Microelectronics Inc.) makes sensors and sensor
modules such as the SPL07-003 barometric pressure sensor. It is a
subsidiary of Goertek Inc. with its own name and domain.

Link: https://en.goermicro.com/
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0cfafd297978..c740a98522c3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -696,6 +696,8 @@ patternProperties:
     description: Global Mixed-mode Technology, Inc.
   "^gocontroll,.*":
     description: GOcontroll Modular Embedded Electronics B.V.
+  "^goermicro,.*":
+    description: Goertek Microelectronics Inc.
   "^goldelico,.*":
     description: Golden Delicious Computers GmbH & Co. KG
   "^goodix,.*":
-- 
2.56.0

