Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395E3D34BB;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212160; cv=none; b=JlIaKgPQajA1Yp5R14TMUyeTX9N/JKFk/rlMx8WbmlknWZUbyb4siO5y+fBRuVkHrI5Uba+ef/qqb0cng+KVlZ6gXrepetY48vD138+hbbvNK/3W16n4SmeTmpSSGae/6cPHJrzGpVsTFW+J7stvNBF7KCK0e0FR/b1tI116WDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212160; c=relaxed/simple;
	bh=VjiUDIBmGY8ehJYKh3xdsRBq7blQiEQbpG6Chja0TYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2PXuQiK8vkJqZbdxSgO6gjUVAQh/xRQsfwQTLgVhJB5fW7v0RZBd5NHvaygKj3ohnezT2TtkAkxCGOec+OkUBuO2odVwz/3VXwb2MulyWJUuj+Wlr1GEMWcPNF6e7CmzNrAjScov8rEA72yqBBcQdHvYOWr1vFM18Sy3XfTZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELLzzOTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELLzzOTV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18D23C2BCF6;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782212160;
	bh=VjiUDIBmGY8ehJYKh3xdsRBq7blQiEQbpG6Chja0TYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ELLzzOTVFij8kV8rf3/M7or/odbOWT+5zM3o8LTtiUkeQyVHSzoC/4jsj8wg47rFr
	 fVmgaOfCmdSNSK4oWGGYg47NP3hN/PiqpZquJsknsuGDJUXOqR0dPY3AWbxipysL5P
	 yfPnxZ33cKAUxr1eAevqf/YKw+h9hkGf1yIUfIW0M4FibKQBEhIHBn7THAqpCjAVm3
	 iSREcX40WbxOtcxrq4QRKOuPJXQsfGu5t6IvBbQ/+h/OrDkCBJHOT+p2sZGEAuuBPw
	 74iYgdu5O01e4lcpHuJJ54sB6NMlRTu1DCL1PruQZXx8el0PxDf9u6T1U155mdR51Q
	 NvL+vmGhh1hAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7B5CD4F26;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 23 Jun 2026 11:55:48 +0100
Subject: [PATCH v4 08/12] iio: dac: ad5686: introduce sync operation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-ad5686-new-features-v4-8-28962a57db0f@analog.com>
References: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
In-Reply-To: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782212158; l=1436;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=aHIe2CXcz6kHJnvwwE3YrD49dPtg+rsFxmw4m2wDGs4=;
 b=RSaoDqJTPueakQMifCFWiL/6TWgUmcP0bvT1PzWqDAuYVZwC8PvOceJ++MgWfb5ozviR8laTt
 XyYicmWx2vKBK2NfJp9ROOaCF57yz6VLPEkqrsVtDzEotiV6NCeb7WX
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


