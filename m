Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C693B52EF;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941366; cv=none; b=oaw4Rhk3pUIoXZYvI8scmYOkLsKo0jPom2sw4qK+EOWyRPpXcy2EdERNCc1Dt5iUde4z57F45WDhxju/K0Zj1bL919jKWOMDAc8g+Y3dduJqZ/V+nrtgxbMU/Q1K6REisghx7ag8G+lGIdyF53rcDxBE6M09EZwjOjM2WokIIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941366; c=relaxed/simple;
	bh=Uxql/rqWAgjr7g9LNR1+R/8omv+xrkH9wRXMusg9PWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j1PgHcg4rju/V4fzZfXroUxZ8vXtQwY5w7KMHlOyIlVwifp9z940c0f6AKkjxapAJoKzlnOFEWhOoZJIFdDgBJLT7/qCuLxVAvz/y+IXJG28KxBiG0/rz3QWDyMPCo/mSmrSk+LLKVqwXtSvVZ/Em8hTFBoSLk9/Avp1r37+KL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU4h46dX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU4h46dX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4FB3C2BC9E;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941365;
	bh=Uxql/rqWAgjr7g9LNR1+R/8omv+xrkH9wRXMusg9PWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZU4h46dX6V0NpmibR/NPqVy2eNdTnRh6uUvzNtAQaOdH4lBcRS9sMrqOMK7lzmYxb
	 6xRT4A6mn/ARvWe9zOrsAo2o9KgGJNFgLeIknrIjB+5R0jk+ox9ltAccpAe0NfKm8C
	 x1b1/PeNLbp/RySEkbIjHOdMHHWokdQce1rvGB5UQTz1r1wQw/6rvTXw7xSIZWfmL0
	 sJm4gJsAIa1dlV33apK1z3QdwnME9d65H1HILW8iDILEj7XxJjMrfCwS1gfH3F3NJl
	 xQBYwTO1n1qvFYGaAu64k7X5lg00xorg5E2y7ZVDWV1AR4QsHgR9te0Wo4Y+UF0USS
	 oYLbfardxCFOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC7AD262A3;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Wed, 21 Jan 2026 02:05:44 +0530
Subject: [PATCH v6 4/5] iio: proximity: rfd77402: Document device private
 data structure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-rfd77402_v5-v6-4-5b944d0605dd@gmail.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
In-Reply-To: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768941363; l=846;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=ZNRXTbMiZ66e9jZOOxYOba5M4vr3u4LqUYpX35UAbzs=;
 b=910QesgCgsLpYFqkQ106kEJ2rfknYxgus4+rk6blMJS3uq/dP0wFmz4FyBF/udrtpJWZg8nlL
 lN0yfK6cy6LCI3RljXnyaXZpA0Ouv5PoRNXjdEw6Q5ob5BFBQ/4hrkU
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Add kernel-doc style comments for struct rfd77402_data to describe
the purpose of each member.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index fce85f783ab4..dd57156a7859 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -77,9 +77,13 @@ static const struct {
 	{RFD77402_HFCFG_3,	0x45d4},
 };
 
+/**
+ * struct rfd77402_data - device-specific data for the RFD77402 sensor
+ * @client: I2C client handle
+ * @lock: mutex to serialize sensor reads
+ */
 struct rfd77402_data {
 	struct i2c_client *client;
-	/* Serialize reads from the sensor */
 	struct mutex lock;
 };
 

-- 
2.43.0


