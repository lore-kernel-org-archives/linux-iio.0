Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568F4183AE;
	Tue, 16 Jun 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598072; cv=none; b=NI6JaJfd3laK3tJcuNu2xg2CNKsYZyTFctMOzJZUVK/MHxdIRAg9RbxLDBtEnBjeHxnwFPH06XO+uNlK3dm99esXEGg+iHITBGjJeSO6USPX/QsRLfryjtzrRcoqkEZaMnHfjzmJ1KJcKfr+uXDog14mBKwla5N+ZtKwyM6vhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598072; c=relaxed/simple;
	bh=/swyioDg+TxAgHM57Vi2HChrRyJZFYYXkbig2NsgQSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRT97H7rMZCvLbLG9gG58qn4jaFcFK6bbeaXCFNEqnSpcFkZHRTsaxjTFk26HxtfbiBFSiUz2hiojrVjXeqJITl7bHHQ1M9tEfuKWM35j02iA71L7NF4ONxjKlp2CBwYw9KLq0joYOawKhfPajzeXxFRF/oB9RROUVvWHm3g6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us9+D8J8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us9+D8J8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A693BC2BCB7;
	Tue, 16 Jun 2026 08:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781598072;
	bh=/swyioDg+TxAgHM57Vi2HChrRyJZFYYXkbig2NsgQSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=us9+D8J8IW1iwgFY2TDrezyDBUPIAJk9V9TRyfTuPYxLMYEC8TCdUSUWG1KTkbsiU
	 PZX2jEp/VdOEa5m1ODafGL0x3vTypL4u9ZnVWcd5v9ibyAd5LQeqPEwlQFzizZQjOJ
	 R6k0Qn9CbinS8G3PE9QmN2NUmD9looWB/45owseyXaJkWmF8mcCz88yyP6ChYG1WW4
	 hTq8OjW6oc+0rFBHP0Sg94fkcY/ijIPm0SMKOP0Pn8EC3TkTwNinGYnndlFqyU53JE
	 62wePpYmATxBcumRfGFL0tvV0eG1EnOKVeacINVbIN7X+gLNKQLj49ISxg40HqOc0y
	 r3kdGwP9uXv4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D25ECD98E0;
	Tue, 16 Jun 2026 08:21:12 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 16 Jun 2026 09:21:14 +0100
Subject: [PATCH v3 08/12] iio: dac: ad5686: introduce sync operation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-ad5686-new-features-v3-8-f829fb7e9262@analog.com>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
In-Reply-To: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781598070; l=1436;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=857MKEkbtP+CzDEmhI5ZYzKG1rm429EH3KJ6KRFQH60=;
 b=pjZ7TCU6qUGGYOQZGucxxO08hHeDQzftl32VhS/OmjGqMW36Wj4woL8RwyRzR5ERs2bNmeGeE
 SJ5QHSIblYnD+PIUMaQ0EKewRfeWd+6T8zCOTBwOd3rKqmktZhKnud/
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
index f3110410d89b..1da5f1b4d52a 100644
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


