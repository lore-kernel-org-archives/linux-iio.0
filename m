Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8744949ED;
	Sun, 18 Oct 2026 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359741; cv=none; b=ixQs8WBlCAGcXamTXvEm4yy1Uk9Qe3jhpCr/Wzyed4mDvSQm5dtXT5zuA5NBQUUocRHMjqIJL+4vn23RJ9y+1Atvj2SaXQK+bse7MlfqP8MJLhEHnIx3WEGC8LaNU2Lv2CGAEkOFNeZ4B0fT53TuyfwIahl0ewqBEDbtdoKWvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359741; c=relaxed/simple;
	bh=KxlqlM08pSqbLCX75drsh8bl4LndMnKISQsj+OgCYyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+9DcL+FD27xPo9WXzz8xiyx/b1Qgl4aHxORV7Pe9a4mpFwqh8oD8xUWyD+PJCOE92lEBzCmlMjb/uUki9IdmP599eT4waPePdhqKjLdFA7uGxV3IqP8lvuuTKwdiWHpAyv5KLvfCP/suzOmKVkB2BZQGeOqP5e73RTlD4BgTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp4SQVSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp4SQVSw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5132BC2BCF7;
	Sun, 18 Oct 2026 21:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792359741;
	bh=KxlqlM08pSqbLCX75drsh8bl4LndMnKISQsj+OgCYyc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Xp4SQVSwoz11D6rPu40TPRVF4dEMVpzAPYM+XdtZDZCPNs3qlIoXTQ74maxexToZQ
	 JzCBf7i/3burCtmi97SJKBTLB/8dAfXcD4LM1m3S5j3UZPD7jgL90QNBRtr0exEfrN
	 /oZJUpV2onChZ64MwUV7CFvvThuuRH+izfLzlfsV2PhYUWrYGNvGgNaDnaLAWkzocN
	 mYe6i5HVPaoosgmPxCZPqqZ7EgqIJmEuCxfl9eRMNFjhU9TDAz9KmVPsN3fkIrmUP5
	 wizB+Y/1IXnoUGAcE95eKSu+EM9ync+SUizDlqtZw0tW7mNurF61jN89/8k19Vy63w
	 9oLYQCdBJhGDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32268CCF2C9;
	Sun, 18 Oct 2026 21:42:21 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Sun, 18 Oct 2026 22:41:51 +0100
Subject: [PATCH 2/2] staging: iio: addac: adt7316: drop informational
 message in probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-adt7316-error-codes-v1-2-1970b7e242ac@gmail.com>
References: <20261018-adt7316-error-codes-v1-0-1970b7e242ac@gmail.com>
In-Reply-To: <20261018-adt7316-error-codes-v1-0-1970b7e242ac@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792359739; l=1014;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=yKADDDdmBBCSlIewg1RBic2YWBgdqUnAFXf9g80Iw9I=;
 b=4bGHkl86lqoxO05oSI3aEhN7pTSr3znRkYLdnGHa5tl+v8u/1hhgxkY53SqCTXNQvRjAG97/T
 SIIxK1ggLhkBYiRG3n2F56kbRHssFz7YzWDmUg3etjbvsaPKvgf8a0J
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

A successful probe does not need to be announced in the kernel log;
the device can be found in sysfs. Remove the dev_info() and return the
result of devm_iio_device_register() directly.

Assisted-by: LLM
Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index d495032786db..9fcbb640b7a5 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2178,14 +2178,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	if (ret)
 		return ret;
 
-	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret)
-		return ret;
-
-	dev_info(dev, "%s temperature sensor, ADC and DAC registered.\n",
-		 indio_dev->name);
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL(adt7316_probe);
 

-- 
2.56.0


