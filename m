Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397741E6CC;
	Thu, 16 Jul 2026 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204076; cv=none; b=RCvjliij0I5gpy89m1MjgT6qq3EhmC7W921UyHtD3KhvodBNadaSWEo2UT7DXIZl0NYewi19CC59G7q6y1SZhIZ98MgyAmJXoCDv/ujKW8FKWueyB4XDkBJEHfYg+ionqlfYf979iiQwoi+5dfHXKHCoeYdPF36mkR+XL48I4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204076; c=relaxed/simple;
	bh=w+/cCwkgEvUnchJEyqY03RAh1D9G/2Oa44KlCEJsrYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3iAmdu01XSOuqd1Fpb9/ML3M2hDevUX2Ay2v0O7SVLeTuuITfL+X6CyPGvKM5W0eTVu95UvxAAIWEBbpCGnGAA4OKE8u80d26Zv7CogN/o9QbmuRZt/YcWThldbP+9g9nwlcm6UoxTy8OxiPsJ0nMzGHDdbEn52x1FIMsP4Ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF/ABuY6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF/ABuY6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 470FEC2BCFA;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784204075;
	bh=w+/cCwkgEvUnchJEyqY03RAh1D9G/2Oa44KlCEJsrYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LF/ABuY6lXjsNd19mBlBtIFwtS5NcDU3v8n7Y2ldTsCLqI+M2OwKcZOpwyemkRvV3
	 QQIG3y5YXPzcBJ3UOrvNqLax0VwJsfmTGGWt13xS4oSmtTDhwYmP+wjnn9gLqr2x9W
	 pxHzvRGDYzjt8nYep2Fo+64HKYOMPZWobb88N+KntdXGg0/C+Dk3GxpAuLP3pdLILZ
	 ueDrPvvfakghoSpWW02BNlgNHkRw3CppGlYsjFTeeEeW2tOKrsNS5GW+n9gEewwJVy
	 +6F8KYr9/AdcSD0c0wpluqc/yzHIjwNv1yyxaPIWh93w+AHdrAk7Vg8Cs5N1hhvQgW
	 Rou/ws1BLKNNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321D3C44515;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 16 Jul 2026 13:14:20 +0100
Subject: [PATCH v8 4/8] iio: dac: ad5686: introduce sync operation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-ad5686-new-features-v8-4-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
In-Reply-To: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784204073; l=1488;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=r/qY1H+vZyhzoYkk4EjodZz7IAM2Ur2Y6sQJGGqKUy4=;
 b=/SXlnYJ+Wj1KzVrlmx2fi2Qle2YLYnovakj0Gi5/COyKdBG5PK9gHEui/qEUw43eIQ9RmGy2e
 6trwUv6R6GCB4RqQb3nod30lmxrfSFKuM7OKULhI3fB4TTWbP756IJ0
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
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


