Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C153C661D;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043096; cv=none; b=KanRZ0a/uDJ2fRWetaBXKvf00ZOa8eHPMOom9Pjcsp+Px12G1+Me0nQcDjC6xGJZMuLnqyzGFFxrirDxtC0r3dfu9wm0+hiabt9FrsXghWC8HzWGTh9SsoVS8vPHWighkuKlmp05xpk2meZv2luLfIJPuUXZ98m5LckFqwfnDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043096; c=relaxed/simple;
	bh=gSzjzZpWyN5p9u4MH/AHyWy9legDqAcplirEJBm6wWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LO6b0cbhJkQ4L9+zk6ZA23fS7jM4iGpPcs8l7duaPnxkWjbOb8u7XLNCZwcTijgNbMzCf1MqGiOw4nPVuiuU8+c8PZWZJbvG6flUja6WPxMdKxpN/ephA3Jmc1M6eaOsz9BP+8a3QMi3eNPhfGLsNfHrkyw1a84pX2Ohs+0Dz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIX5ophN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIX5ophN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28953C2BCC6;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779043096;
	bh=gSzjzZpWyN5p9u4MH/AHyWy9legDqAcplirEJBm6wWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZIX5ophNJ99CR/R5vHEhHATCg1xKniWykwyM2ukiIlbfszniHv33/7Fimdv49OqVW
	 ewoeYB+DSJ+SACkfeC4T13QIHgdC9STwSaz6iIGweA+55cYdWTNRff+Aca+f7CQErO
	 nq5/N1V2cab0JmY7Q6BpGgKB2kdJmll9HsOlUCnSvaDGIurNAGg+R+rVtm4ZYHc9SR
	 yI0WnlexlwapbrJ02ccxKpV7zXQuCLRHz58Q4US8JgFV/AnCZxIr7KEVsqujNQW/K1
	 HCSG8uBsjmW9a7JmaicCgMQv5VhbpejIkC9YMTsWzEyKvBlzaynv8L2UdQcDGZPDtC
	 Tv8ZGw/Rguqbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E17CD4F4A;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 17 May 2026 19:37:45 +0100
Subject: [PATCH v5 01/13] iio: core: validate file offset in
 iio_debugfs_write_reg()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-ad9910-iio-driver-v5-1-31599c88314a@analog.com>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
In-Reply-To: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779043094; l=1108;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=rpvrvxHbTOo5EkMCZusLPjn94XbWzpS5zKDDEjpU2jk=;
 b=BUCN7UhT4hmZxpaaGhdA7LrjXns0A75goPn3s2+S4yaVEr9TuKBEURlCtB52ip/HlPOJOi0fE
 8wEFa6dVUUkC7jGaRj3a1WBv5qF8rZn0kQiQvz24qf6tTaU2pmLMmT8
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Check that a file offset is zero so that simple_write_to_buffer() can be
used safely, i.e., buf array is not left with uninitialized memory at its
start. It is not a big concern as it is a debug interface, but it is still
a hardening measure. The issue was introduced when direct call to
copy_from_user() was replaced by simple_write_to_buffer().

Fixes: 6d5dd486c715 ("iio: core: make use of simple_write_to_buffer()")
Reported-by: sashiko-bot@kernel.org
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bd6f4f9f4533..e587aca79b8e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -419,7 +419,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	if (count >= sizeof(buf))
+	if (count >= sizeof(buf) || *ppos != 0)
 		return -EINVAL;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,

-- 
2.43.0


