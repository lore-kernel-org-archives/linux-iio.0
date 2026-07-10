Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BDA416CE3;
	Fri, 10 Jul 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682460; cv=none; b=gVVrICA1v+P+LPQIilzq9q92a0pOsTGqcjucMArafAsoCDxAlutw5POMmft7yw5w8uq8OFbXzoGjhj05FYEQbM4P6Wd1LKdowHk1Y4Ddthd+IMF88dC1SIY+wWzuSKZgwgamCtiE8a7Nbz+WKQz0SeDlXWspV6XP3xIV3Zzjkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682460; c=relaxed/simple;
	bh=UC3Fb0K/osa1Y5Q6O+cQe5RPOAEjTKbM+sRmsfxCYRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZaAHIIkIxGOX3ZUW7lsmrpUlhar/ByDgjIqvjfqo4pYflzwM1M/bnY28vdohdcNs1pIWJ4avl0QJkze85Smxzpcgf6UVxiBCxL61NobrL2/87KLbXkwEqOYN3q8kcKlOa5ytoEQ/1T5SamgSfAB5I/MOTR5nHthzxERXvnQEk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWGRNbnK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWGRNbnK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7070CC2BCFA;
	Fri, 10 Jul 2026 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783682458;
	bh=UC3Fb0K/osa1Y5Q6O+cQe5RPOAEjTKbM+sRmsfxCYRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pWGRNbnKK97MTuEGhdtozmzl+UdYhzrCWObETIKleO7+Ut196x0ErpcBctEW41u5W
	 xVhIqTSzo5VYTtZQFVNOJ/8p0dYj4K3jdjLVOh5QIN9Y8cCexTsKyHGxREja1JDIfa
	 4vRFwqUd737uKtM/4sa58NBmT80wVlrjTTav7iPe8twvWM4T4uXybdzi9zMjmAbfxz
	 otUGJCQxLHF3NyPuAcC+P2oVBp91Ei/WbRXHiOI3uYHXL+ckvyW4Y3v6dkmHyXait7
	 UBmDBYdnE+Vjw3b/ibsZsSOtHKLgsW0SBk4etWBnTD2SRu/Pu8GOujNxfHgPmL3Hog
	 NDRGAhNfQ0cbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A77C44509;
	Fri, 10 Jul 2026 11:20:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 10 Jul 2026 12:20:47 +0100
Subject: [PATCH v7 3/7] iio: dac: ad5686: introduce sync operation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-ad5686-new-features-v7-3-1bcc8c280e4d@analog.com>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
In-Reply-To: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783682457; l=1436;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=AMX5SeS0etW8inHhzpcq0acC46wU0BKcTGY/05CNxgA=;
 b=VKOx/7mHfJL+l/bGfAe9yG6bGyScVHBdYFCi5zsyb4cSIKJ+HZ5yGnWIVGwGsX7tV4+KzeEm7
 1CiU7H91ajeDOhdDm2jCyPB7k0JAAMWHPggxHXjNcMt1SO6oBq4t86x
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add sync() to operation to ad5686_bus_ops, which can be used to flush
multiple pending data transfers at once. This is going to be used when
implementing triggered buffer support.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 32cb3931413c..ae9aeda2d201 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -70,10 +70,12 @@ struct ad5686_state;
  * struct ad5686_bus_ops - bus specific read/write operations
  * @read: read a register value at the given address
  * @write: write a command, address and value to the device
+ * @sync: ensure the completion of the write operation (optional)
  */
 struct ad5686_bus_ops {
 	int (*read)(struct ad5686_state *st, u8 addr);
 	int (*write)(struct ad5686_state *st, u8 cmd, u8 addr, u16 val);
+	int (*sync)(struct ad5686_state *st);
 };
 
 /**
@@ -162,7 +164,13 @@ int ad5686_probe(struct device *dev,
 
 static inline int ad5686_write(struct ad5686_state *st, u8 cmd, u8 addr, u16 val)
 {
-	return st->ops->write(st, cmd, addr, val);
+	int ret;
+
+	ret = st->ops->write(st, cmd, addr, val);
+	if (ret)
+		return ret;
+
+	return st->ops->sync ? st->ops->sync(st) : 0;
 }
 
 static inline int ad5686_read(struct ad5686_state *st, u8 addr)

-- 
2.43.0


