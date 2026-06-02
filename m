Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92637473A;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418033; cv=none; b=QA51D00zIZzmusDOWPGXDm9c6o2x+/Ksubqpvd+su+7yCeRyEzLfSKUapJ4Dl65ygmHsquAAVqXePX112DaShCZtOZ3LzfDVB2VJOkkSPh+PqGLNEMylCXTZbMjwJ1dF+eiSqU7/lmYTBz+gkXPZP8dDgmw0FcfRBnXWMnKRq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418033; c=relaxed/simple;
	bh=4Olsc02gqukpHfg1z1h766Y4hOa+FcPXE68xTPMwQqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6boPIZQUzpplWU0VML0aQMplU4wuigxSANM54VYyHxVzOYcRMC6363KiCWFhz5fRvkjgLX7AXGYG/C5n0c//4iKXXEuzfIpESJVQ/GNNn6XokKlHBPh7MfjSZkoh3Wh4reZXgWHX/tmPpseqHlL1qqPcyxFt7pJqJGHzSVFJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ7c/U+b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ7c/U+b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36F4DC2BCFB;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780418033;
	bh=4Olsc02gqukpHfg1z1h766Y4hOa+FcPXE68xTPMwQqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YQ7c/U+bXdT5thgZ6/dBwOdSHHoB6NUzRsXdwXEjDNjvujJ9EN/pdYWQKd9sbls8d
	 2ndU1eFvXEJe5egVt3JMsugIsCQ8sBMkj6o6++wjxNniKiTUKRJmDucDmjSZB0bZSf
	 FHDnruI2iSgi7EhkKuwwx3mZ2VLyTJY9KHxMA8MAbPS5L5kLOxq+ILHxxmYvozrK4D
	 K+XkZtkcQ+pg+nsG7qM44f1yZlNQ09iW5W9S8/YXGPtWeVrShEZ6Y3Y5m+2qEQ+0mq
	 Ip2yRhMOI+st9U89ypdVFsm4N7Bh/LM6bZbkiR3tAT6zRgrrkfQQ70IVQ7Dn/vjsb7
	 wn83Ytq5kG8sA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20117CD6E68;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 02 Jun 2026 17:33:55 +0100
Subject: [PATCH 08/12] iio: dac: ad5686: introduce sync operation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-ad5686-new-features-v1-8-691e01883d27@analog.com>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
In-Reply-To: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780418030; l=1436;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=5dYkJ2OZkHyAKxl2jNuORfMox/fLJ07hRjAKClskDvk=;
 b=fE08Oihthsp9HKS+Qe5GTjSDrJ+BfaalpgM/JL8G189wPX747TK8mdStR0bvoNh2qUxc/jbW+
 TyP5o4N16D5Akal256r4ppDrRhFiK0IAxKpGZCOfOwk3yOHxkfRXuOz
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
index 498d05ab12ee..414d39863004 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -67,10 +67,12 @@ struct ad5686_state;
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
@@ -159,7 +161,13 @@ int ad5686_probe(struct device *dev,
 
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


