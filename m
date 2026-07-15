Received: from h8.fbrelay.privateemail.com (h8.fbrelay.privateemail.com [162.0.218.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470E39936E;
	Wed, 15 Jul 2026 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148453; cv=none; b=Wxju283ZbZEwEzod9N1w29yugq0LH0tMp2CUoWglCaDNhiYTPnJF7QzZovfOSq4Nk6LX6XWRKhrmJHCE5Ly6JeZTTkN6zhjImuFKTARJfr8etfitRq0o1tPLh598/P2rh3ZhNhwXHIqChwsoteZGVGGdrh94G9z40+FN/EhhntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148453; c=relaxed/simple;
	bh=VqaUW/eET8gnOBgZ+HS089ADD+WTF4InR/ZSqfyhcKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyrDHqQJNRcUHOC7N+0YRmJZOe7GuP5OCvpAXMlW0UkGbpY5geq5B8AS0QraSSb3oc3Kd6H6CsKlDq/6EJrqCFsnD6tDLm1qwfE/7dwVpE2SrwETAbEBN7MS9Dye+OmNlLvaM8i96gfdSy7P+vbAr+WKPkjpwYIg/OZGmgZHozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=162.0.218.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from MTA-15-3.privateemail.com (mta-15.privateemail.com [198.54.118.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4h0pBz1DNWz2xGB;
	Wed, 15 Jul 2026 16:47:23 -0400 (EDT)
Received: from mail.privateemail.com (K8S-PROD-WORKER-15 [87.215.145.39])
	by mta-15.privateemail.com (Postfix) with ESMTPA id 4h0pBW6JZpz3hhTG;
	Wed, 15 Jul 2026 16:46:59 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Siratul Islam <siratul.islam@linux.dev>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
Date: Wed, 15 Jul 2026 22:46:57 +0200
Message-ID: <20260715204657.46657-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <alansZsKEH3nX_UN@monoceros>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net> <20260714202842.340293-3-jorijnvdgraaf@catcrafts.net> <alansZsKEH3nX_UN@monoceros>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 23:21:18 +0200, Uwe Kleine-König wrote:
> On Tue, Jul 14, 2026 at 10:28:42PM +0200, Jorijn van der Graaf wrote:
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
>
> Please drop the include of <linux/mod_devicetable.h>. You need
> i2c_device_id and of_device_id, both are provided by <linux/i2c.h>.

Will do in v2, thanks,
Jorijn
