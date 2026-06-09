Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAB3F8237;
	Tue,  9 Jun 2026 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999992; cv=none; b=F3bj7EuPHYp/Fz6E78y9djUsWVk8e9BE3LvQEZUGMEs5suTS3CC3cVt0coYZpabR3k4oBKU/gZaeOy/HoMCNI4ByTWbs7mgvUpOTjTx/48ISuG/vUY0Dg1Xqm2F5UhAlnQ3O32TFP9y4uRlbnMBMG4FfmxFlORiJ59thdMEzqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999992; c=relaxed/simple;
	bh=/swyioDg+TxAgHM57Vi2HChrRyJZFYYXkbig2NsgQSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGtVZgHGNZs0yiZXdakBnNH4k3LOEJrPHQW4rbKZdjzv90VLB6Kwblwj3DZBgbkeM35FeZjdYJFI+Dn+0n5O/ymn5DTsaHGk/xOjdUJxBh0qHNV/qPKEnpIJ/IZLeJXGv3BF8U7twd2Yy6dJoMsW50icRFDi+eppEwEEYdztbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI2gzstm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI2gzstm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 837C6C2BCB4;
	Tue,  9 Jun 2026 10:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780999992;
	bh=/swyioDg+TxAgHM57Vi2HChrRyJZFYYXkbig2NsgQSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BI2gzstmMETHhgljprdRkHvLg038SCWTDniZ2cTWWzg6Z/QZjSDh5d2UiQIzOICKu
	 +OGB2XfiQ0jfY4Pk46wtzzTztuAB1L3zw1bMMfVPmQ4EOYUCRPrQjIOSOcUpSFVCnR
	 M/Ns720eCMPu0hGggmVEXfmWWPLFJn52jB2QiRwsbo8ln+XXL3Ya2tREJAh4z9TywC
	 0QBYEXFAeOM9vQxPftM/3US6uWfWk/0Gnt92pDrmb9PhzEK3cHAWV4/LeFZEalc0a2
	 JYoTwbHO65kDoiAHo4uzxt3FfWga/dWqh2mIpWG+5w5L4ZKuhzryBlMxtgS7dQ/gT8
	 tVP+zz/CY71+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBAFCD8CA8;
	Tue,  9 Jun 2026 10:13:12 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 11:13:03 +0100
Subject: [PATCH v2 08/12] iio: dac: ad5686: introduce sync operation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ad5686-new-features-v2-8-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
In-Reply-To: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999989; l=1436;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=857MKEkbtP+CzDEmhI5ZYzKG1rm429EH3KJ6KRFQH60=;
 b=Tl/AUUzSQJF1XupbK+BNZrB1dMl/Dx3W+jkZnLCYy4ygrZqCA1akCls+et9bc8iM5kkLHWhWz
 lrxxf7LdFgHADllOzHAz/5/yw6q/p+66rE8qlpMQ3Q3eVVGGThl84F6
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


