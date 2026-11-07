Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066027;
	b=YN3X/PE8H98J/UU5FMPNVMyxhycrXI4GNuS3/a335rs7kdqtgJJ0erJsoZrZb87HATYL
	 s1Oczv9C6hCwsQDr4uuJZNSpSSC7LlKjv9ho9yv41SvrS6O64y1qIuWPju+VXhP7UwbCn
	 cyY3q68r0URUBZEwJwwlCkR38lH/hpbAXbED1HBIvcTNge1yG5MOaFFGTHy5/DjUNr+Cu
	 kUfUZiIbsmTbp81R1nUJPT+sOxbvXt+Adpq2DZ+EFm1zHAredah8yaCM3qPxiiOIkONGU
	 EKyhjOkG5sxd0NDiDGPWbdL7o5w43bqUhHCKG0zoOqNyqY0xEVYSzlEodfn/9N/IMgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066027;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xodo0tywrQtyKRXosiF2exS76mecM79ssvXhP0BMLRg=;
	b=UailOozzi6JosWcSxMXoU5N/etqp3da3TXfESVxaE4uJc4JR4E+2IVV3xQ9twvZA/kfq
	 SrH/ujF2B2nUlDq6nz2FV0lW+2nC4QGhuI54ALFMLgTGpJqOLXaBFjTHIxDH2Y3WTQoUG
	 2Lurwv8oMLmd1QjnW8UFcS+XXuMyV/UnA8Jz+202mu02yH+L/3FBbK2/2k74dDUMcQvc7
	 FunCxsRvmeBvfimQOCaiylLf/GlM+0qHUoeqMABel4JVLAqhX2N5+ZxNs5KRqUzGccLZ9
	 yNgBwUtnvYou5hzkiS8YOw7aPu5ha/JQtaZEjLn7bcvMeMDcYorXHno6xfLLd0rqKLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUfZ5AHs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3569606A32C;
	Sat,  7 Nov 2026 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUfZ5AHs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D441F008A6;
	Sat,  7 Nov 2026 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794066027;
	bh=xodo0tywrQtyKRXosiF2exS76mecM79ssvXhP0BMLRg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=iUfZ5AHsLvdBUnG8bdhOVl81eCpH+5jE1V/usy/cC5biEtAXFYqDxegYf8djCo9S+
	 xmpnwpG7TRJUg4Dej4rnLDBwwNPmV0nCRARb4alzqmfKKRzHm962tw69/Rx9yNtuNE
	 ut9fpbBnb+/4fnMpHxX7Nq9rymktLh2cEs+JkS3CmH0W9ICMdnvPoJS6hCpQEnX8I6
	 OXHJ28i8qArtu6fwx5c5ma7zj83g4Fdzh6yerx28AZp8KF4YogHfFLPMk2kddBm9W7
	 rRBStLI29qDCrQEBqrvfZfw1EZJu2qL2O6ua7Wy6Mgt68GaduPBhIXg1VTcAWvj9Se
	 55re/VOtn0xgw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 8493E2AB366D;
	Sat, 07 Nov 2026 15:40:24 +0000 (GMT)
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 8/9] spi: spi-engine-ex: Add support for multi-CS
 devices
From: Mark Brown <broonie@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux@analog.com, 
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com, 
 jic23@kernel.org, dlechner@baylibre.com, andriy.shevchenko@intel.com
In-Reply-To: <183539c950c013d472c6b46e3f1365b022e7c716.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
 <183539c950c013d472c6b46e3f1365b022e7c716.1792435248.git.Jonathan.Santos@analog.com>
Date: Sat, 07 Nov 2026 15:40:17 +0000
Message-Id: <179406601717.3424803.6101745794958168794.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=292; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QCp+I+vDYOjwPAhHVOlYaANLQj2Pf0vpWDyG3phbLK4=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeu2XEJtzekrShqTnz5tx9ZZ+8S9tMtNdOswz0+7bu9
 YsvxcplHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZhIsjojw6N9C198mbU76op6
 /Yxnr1JitZxWLs9MThKTm9Cg+aJySjnD/zzeD9G2y77mTHBb9C749dQL+SWzGhZqeDxx//t+7dn
 dvhwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The SPI Engine controller only handled the first chip select when
> asserting CS lines and configuring CS polarity inversion, ignoring
> additional CS indices present in cs_index_mask.

Are we missing some per message configuration of SDx_MASK?

-- 
Mark Brown <broonie@kernel.org>
