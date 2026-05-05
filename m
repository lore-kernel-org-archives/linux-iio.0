Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B633E1219;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966308; cv=none; b=oGs84ehbxoM4PrEoow2/l6CS/CBRPKp5q5lrggbwZPGVbhN1yUOCpzqKabVeLs1Y+4vtDM43+W8XgZ//WAxGOj93zG2ZGdyKwD5YkjiqWAmGdCTeYlg1yfy5XOtOjQSVL8ZOB29yVYx42KTlrN2OwOw8/16Nz0047RRE4hlv7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966308; c=relaxed/simple;
	bh=pmpyJeIflePapL/RApE/hkgCQoa1DmdL+rEhiYpEbeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jb+DYll1UKr1JQgE3HOPxOEMC+D4glJMVUXJlBE9PNn4NIMKx7/7j2IY7/LNzZgp7riH7lrO4DDkhrEticChiUjdAK9Mg6ChqB3UgME5k0VR7mJujFH+u9RDYpGECe3lPjv35rViF7s81T/1dTq6iXxv2mb0cJI0fyIb/spN+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2mETwdV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2mETwdV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B177FC2BCFD;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966308;
	bh=pmpyJeIflePapL/RApE/hkgCQoa1DmdL+rEhiYpEbeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g2mETwdV2DXvMTi8pGpPrj8y4gkd53hNC/hEgTm5KPns2L54ELYa32n9KifBDHZPY
	 q+b9DIYEjfQ/CM9Zxz9Es/SZbgupd6VCk9+33ETL4ao6MKpMV7ZuXDVZ+qtMC453fG
	 zjD4F/M6Ofhf0HaI68Yib3vsyx5q/bU4c4QgRC7QTdSXR57fSa//Z1kFuEkjMbHrTb
	 472+P86jixqLVkdZa1Ed6rLhL5IC9sDnhWTt0D7eFIJZZUh0tQi6L0uVRAHvgYbPRN
	 dyuDPeMEphU5AgTh3SfPtJ/oZJd6csIWvNDYitP1op+gguq7G3LNdO9TUlWZpUGP5e
	 dkUYiQ5AOFdog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB652CD3439;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 09:31:32 +0200
Subject: [PATCH v5 7/8] iio: light: si1133: add local variable for timeout
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-si1133-checkup-v5-7-5df86a9024ed@gmail.com>
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
In-Reply-To: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
 =?utf-8?q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777966306; l=1250;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=/XJFGcdvil+2we7+TC+ip157GN0rAXA5yY6shTe6uEY=;
 b=0C7lCRmCfOweFgiVXLhrhvNfCyI0u26mSlQ8O++RVhUHIz35bIcTcpJk/ZJVaqhBIQ9boHZxs
 AiaKs2OKqsaB61zoA1MJoxxCLHakBnYUycxbbdU49jZYlxMNBo2d8OQ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add local variable for timeout to improve readability.

No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index fdffdee16e493277d95c369ec2f6c0678cf9f61c..a3e4ab25acdc105d3800994f4391a7e4291e1c74 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -390,6 +390,7 @@ static int si1133_cmd_reset_counter(struct si1133_data *data)
 
 static int si1133_command(struct si1133_data *data, u8 cmd)
 {
+	unsigned long timeout = msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS);
 	struct device *dev = &data->client->dev;
 	u32 resp;
 	int err;
@@ -417,8 +418,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 
 	if (cmd == SI1133_CMD_FORCE) {
 		/* wait for irq */
-		if (!wait_for_completion_timeout(&data->completion,
-			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS))) {
+		if (!wait_for_completion_timeout(&data->completion, timeout)) {
 			regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 0);
 			err = -ETIMEDOUT;
 			goto out;

-- 
2.47.3


