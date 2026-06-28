Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188A3ACA58;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655794; cv=none; b=WrYkRg6Or/Y1zu9zw9sZN8vix0PRz4FLloiWMBOqlmdaAUzIGTUI5ZXH7RUUwK8HaiMBEEbZAd93mlTyPit7rYBAQn1lIPTmVnLFFpS8kyU7N3IwMhCeDD8rTddAMnNs9Cl8bGwrfUK49MdahdfRJgMP+ffAnLe0UQnDOkM/KRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655794; c=relaxed/simple;
	bh=VjiUDIBmGY8ehJYKh3xdsRBq7blQiEQbpG6Chja0TYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNY/QZzratE3FEYK7+01xzFMHZQ5lLsdFb+JzDB76u8IAsB0C/ZMCAbUbgz1TagRwYP3CFlpSPV1ESm1F81/6fE8Tsb8PoUeCzZMqLAmnTxld/WscVJb4CcjxB3WROXlePmlybuqPssVpep76O/mmyHd0bC34/B6hDIAyq/YSQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtnLLXqo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtnLLXqo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FE59C2BCF7;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782655794;
	bh=VjiUDIBmGY8ehJYKh3xdsRBq7blQiEQbpG6Chja0TYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WtnLLXqo3inZMOVlT7QNkh6AlodLc0LF2yiR5LJ9MUfTB5GQQ/ayraj7Uq4kElRlC
	 prPHGMFsBHIDbhZrpjYlhGGOu2xKyBHawKWCALKIUPutSpa4G2tN4em+eXFYxVK3JG
	 pUV1k+PvfkPTiCUOH4h1E4Rr5ODB364eBurLZs3Y5aoI9gdozXkMYEpdUTkz2AfSVC
	 I8o9ry1XIMPmtiM5BMUnGQHsker8ZsYqv7Tu+c0Fwh1mBIP4K5bGrNhW8iFFK8JNXw
	 /kM+CCU9sLKeR7f/1e3QYV0nsu1fd6jPguo85KuLmKzJ+K2txJlOhoJRlQCsAtOeCH
	 ms/7SgXoEqBeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462ECC43458;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 28 Jun 2026 15:08:15 +0100
Subject: [PATCH v5 08/12] iio: dac: ad5686: introduce sync operation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-ad5686-new-features-v5-8-577caadbf7c0@analog.com>
References: <20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com>
In-Reply-To: <20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655792; l=1436;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=aHIe2CXcz6kHJnvwwE3YrD49dPtg+rsFxmw4m2wDGs4=;
 b=FFNHB3tB55jEjpiTZkrb8tgdvUG0rc+2WnIjdZIjntjuGxgPu6bwDqcULG1J6FpKgqXUVMklR
 IEzLVWfqnLlATQUjqSpnTKitsZs2MYKiSpFG74ZjtLFCN2tEqwblhuU
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
index c424720f8f72..9a192b0a2d7a 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -68,10 +68,12 @@ struct ad5686_state;
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
@@ -160,7 +162,13 @@ int ad5686_probe(struct device *dev,
 
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


