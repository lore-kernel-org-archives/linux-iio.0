Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EF3876BB;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=Uk5bPaoJbWRGpuecMVEvfs6jj4Vvizb+DihDoFz3647hpwoAMZBZ+kMIJUcJuuaCy9kf9BO34ceoMWVeuRLDcB2DjJefLui3FzLjtW5imbPEAFDT3tEQwsivhWSJXAXji5gAzizmWwX5PQo30HHGbYiFEBhD2B8rDuPegMdZAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=LzFzwM1vVt7yzGjBEJMTkXfLayEfGMNdWc3OJe6lpjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C42L1bt9BsJBmLBF7MQK/2DgTe5L31UNFuvW7aOYcUHRuPEthlVNVUJCjswj3dIH9tMx8sbW8uWURsOe+9GBVCJvG+trlUyMC2R63kkZyoDCiTJNN2d1K/w5hByJBEPFqblYh3ovxceB3gXJ2yhglMH+f2jTC4KqqQtxNBZ72ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBYiNrqB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBYiNrqB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C93D4C2BCF7;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888114;
	bh=LzFzwM1vVt7yzGjBEJMTkXfLayEfGMNdWc3OJe6lpjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aBYiNrqBF8I1l17ChSV9xehyHFdwreBA3V/NmWOGdYSvh3gD43UyV9bhD2RwFW5ma
	 UFWshKCOcsC8vnQ95R7VwwtFkTDAluKAWe+3/ncQn+GEw3XFUMsbGoSFq/g7ZtA+se
	 qWQ4yFDevcR/TLvat/ejfexR4qDAebKwLVvOFjsFcb5Y6wJnxNHkP6mlJIjq1sQhdQ
	 0V7YkG2FEqGjQvzDA19XWxxRwADRoblDwrxn6OWaSzwuFaTG3IVTQ1J3a6g9XzmPhJ
	 mEUW223ZZUDYGbLjaojPYuhJNMPn4zYfMoOEtmNhdDUAKcu41q9UQ6oKA1cfRWdUgQ
	 o3Wr2R7ECMOug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21C2CD342C;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:16 +0200
Subject: [PATCH v4 04/17] iio: magnetometer: ak8975: change 'u8*' to 'u8 *'
 in cast
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-4-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888111; l=1056;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=Wdt8KANnDoSFXBcgrJIrMksQrP9sjlwOf4hExOFf40Y=;
 b=EPobh4fhjT8hpclgEUMCzw2uJj/0oL2VSQEc3oJ+TKckLd5kWE3Lp6PyPUz+p+fcSEqqaknwF
 Gw6DhgQBfCcBUlVTyOlB0QIZvnZmh02ZQ0G+bzW4cR4BMQWxsRjES6C
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.
Also fix the indentation of parameters in
i2c_smbus_read_i2c_block_data_or_emulated() function.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index a84a05a1b64280e26c428e9752a39380e386c234..6ca8c24b9fba452b6fed8155957a8e5fcbc6511c 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -759,9 +759,10 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret)
 		goto exit;
 
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, def->data_regs[index],
-			sizeof(rval), (u8*)&rval);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							def->data_regs[index],
+							sizeof(rval),
+							(u8 *)&rval);
 	if (ret < 0)
 		goto exit;
 

-- 
2.47.3


