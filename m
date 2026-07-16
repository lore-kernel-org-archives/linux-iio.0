Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD141DEE2;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204076; cv=none; b=ZL4vjgxg9kdr7ZmaqgwIEZQkrCoJUJ8t5KWgTnqtd3hvbtZQiHLo/Ij2gkqdphuSd/lYIs+sUQrgLJbcU6mD4Fj9igVUtBW3GKEej5/vt6s8QbhLpgABkdtdAOUVDRdzAoZ6y+EPdw8O7ofi9W4Lv0PrNUHEExSwV/ekXycP87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204076; c=relaxed/simple;
	bh=9Gm0I8M5tfPuRSA1nO6OxxUxNPM87vuB8sQFznGAYpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LW47FahRD9yS2aBf76oSHpcZrAjGj22YJj35fqbRumS4KjuAbAf44QqcgEf+Q7FU3vsGaBaFq8lYLMzLK2OlTUfQ67q3fWl4vrLNfwgpLMNDKDITZMRJUBuR1zvLwTIPdTl1ucTJgIN5kjaoiXhTwe6d0QS4YVo7NGPyKKL2YNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8t27mz0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8t27mz0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 332BEC2BCC9;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784204075;
	bh=9Gm0I8M5tfPuRSA1nO6OxxUxNPM87vuB8sQFznGAYpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G8t27mz0rlWTQ7ubutpG25mZe4kyYYoi4Rdg+CshNKIO6gvGIHA85+mt2zW0l9W64
	 9EbQ+LHpQBfzoAscO5cwgThKN5yzqGRO/GSgXgIxODczMgBY60QuDgmBnXkfgut5cN
	 zY9noehWXmMegpdysI+a86o+twDIvtQRZ5ZrIeOyAPsFnl9znQlWLEPVQMxexJzpTv
	 xzMSHv0b6X8NKV8Nkbc7q/FUVhCMWrmk+ImppmHr89z1PMRvOy1CUMjlvnUJdIEbpj
	 IfoEcAWeQs2pWzVEqSPJLft3UvPXPGG5oIBZ7C5d52uGrVPwUAPupKqAMgxNVvAHoE
	 kpN7nO0FqMKvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14157C4450A;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 16 Jul 2026 13:14:18 +0100
Subject: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
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
 Rodrigo Alencar <rodrigo.alencar@analog.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784204073; l=947;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=B6fpsbUowwq2wwnC44rBjvb0k/SqZw7YPYPD6UUOXs0=;
 b=5ahXKuzPoIFDO9l54rv9iIqAN0epUdRXTrmvtahiMVJ/CWOWJGdeK6lTWQJLFrIjGrx8lBITM
 ZYZkTXl+tXQDNfaQOHm6YjFaJMXZhr+aFpjrBvyoGxGH1919grMWu+x
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Verify that chip_info pointer is not NULL. If a user binds the driver
using driver_override via sysfs with a device name not present in the
id_table or of_match_table, match data will be NULL.

Fixes: 0eb1728461a1 ("iio: dac: ad5686: drop enum id")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260710113149.53EC51F000E9@smtp.kernel.org/
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 713fe71ad1e7..d34250647aa4 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -479,6 +479,9 @@ int ad5686_probe(struct device *dev,
 	struct iio_dev *indio_dev;
 	int ret, i;
 
+	if (!chip_info)
+		return -ENODEV;
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return  -ENOMEM;

-- 
2.43.0


