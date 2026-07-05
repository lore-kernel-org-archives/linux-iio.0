Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDA37A48D;
	Sun,  5 Jul 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783251562; cv=none; b=WDVwXdetCZeGITNfkpdJh8ZmWhLWzAZWKArjba5Ie9kCB643CR3qqXSFIOgus1jISYe+ohefZFJxdtG9aOpXkJTO4I1ntPHLe3gr+zBrApdGY5kuUC74U3r5bKgeAXxv4EDU5+hHR4TM8LG0XyoO0ecBqe25xetuAEkKpE2i66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783251562; c=relaxed/simple;
	bh=cjQ9pDdRzexmdnEFVPcOS2uzmihE5Dkf9G7PROHYhfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rx5vjSvsDvKReDI1bjq8e+KpwJNA8blCKjygrXrZ4f/XyYsWCHK9vL433u76m3lTk3ITdwz2VZ50BjBn6G64oal2stZfIIvbICBLOT7aRUpe/T+WBdlhzhw3Aonvbm3nC05zMY/waQW355qyULaekuzk6FdvSHogWDoXbgW6Ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq5GWOBg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq5GWOBg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21E6AC2BCF6;
	Sun,  5 Jul 2026 11:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783251562;
	bh=cjQ9pDdRzexmdnEFVPcOS2uzmihE5Dkf9G7PROHYhfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Iq5GWOBg3gtt23z7I87LffkatO/VxBHgjN2WWDSteiMnx1EQAXzgeZSRgWKCFRnUe
	 EP7KLN7P7RvSKVTnSGFy7QBqX4L/C8KF0Wu/gYrzOdVbLS/vlOJEjoOsrRN8X57BmK
	 fm31WqE9ZA/39tT2SDNQYx+/rLGs106wLanHd7UyJPQOKylhI5k5cyQSH2KWEVq13F
	 SoYbM+/bD7P2l82dorxFQtbAZvvg86MydDbd0G0MHxpva6brwnWb4EDoFUEFkP68d9
	 oWvTxabPVkGMdmYJunrKo5UY+sJxWgo3iWZMHvtH2YZrTrSMkuL58PTztEz3MDBwc6
	 ItzG5+sfO00BQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C2C44500;
	Sun,  5 Jul 2026 11:39:22 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 05 Jul 2026 12:38:57 +0100
Subject: [PATCH v6 2/6] iio: dac: ad5686: introduce sync operation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-ad5686-new-features-v6-2-269594c7aae5@analog.com>
References: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
In-Reply-To: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783251560; l=1436;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=/vsDuIkCy+O82t+vzKstlQP2RRX82emoYOHg5MWTkC0=;
 b=ElDeMK74i0FPe9/OCbAc+1eDwnstal9uxS4QRnnH2AsN9ph4VSwvyvl8BxHYfxG6rx97Kbfpk
 3PoPfxS2xLACSb9GfHfJobpaqQqdYueGIzS6TdOJ5ISgDYZ8wZ1gd2P
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
index 0d1bbf110926..56d37191ab37 100644
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


