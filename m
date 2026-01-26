Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C02749C1;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455977; cv=none; b=LVHUEqDNFPJ9WbDOBvp7CK6HiO661WcYTbdgJXGVIXwtk+eCPiv8pZVjQWCB+j/NbjBDk/AjOFbt8kvSV7T1IFKPZZZjRbRR2b5Q5q+cDaBjBSbc5BkGnKGvKj8x1Z4g78D+6Bb337T19ttHfFf6oecL6Kb05RO7YB0nkabz+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455977; c=relaxed/simple;
	bh=4PtBuP67jDG6cx0eqtotDQ2qzFrmXgxQTJ8ZGnhryIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGg8yjg+zrj9Ql/tVLuHOIlGAEyMCGTpA2AYp5Zjvl/Uz8CnLdTHlNzwGIhnM0glw4UOTIDZBFLPSTHN+PRx0PTTxQ/QjohG45jYfqIrQiWVdDiyVs+zI8hh0RRdb1tjgxnWTnFbJrT/sRqsASDOHADPJ6VSsefvXk/GKhrF0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By1233Nr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By1233Nr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A318C4AF09;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455977;
	bh=4PtBuP67jDG6cx0eqtotDQ2qzFrmXgxQTJ8ZGnhryIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=By1233NrQxZbF/mfUrRGMVHM4lxNnWnsUmDoba2TDEgvMYyN4U/8SIRwUBS0yf2KP
	 DigzfnufVH39eCmGy2Z352o+JbqfxghHOUgAnxtDvzKyOqG3mbIxSCnXw0gskrtXvJ
	 Pb4I7Wsr0YH06/LDiUJCnv2LeNY5WfSIfyWCFq8COln/US98PgCWmzmQRG5F60oUbv
	 +9IeCcBv8hM+3XKBVUmGSCkpX643Ytnv+TM4X6PyKDGPADgbh7qdut/52ht9VEBjeJ
	 +5qQyqrX0jsKS8OQARWFIyM2dGSBGR8q+1liytL7s40OgUJzblBbMNhjIt6sM6CRZj
	 jx/hPw3bqn/BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F220D19517;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Tue, 27 Jan 2026 01:02:19 +0530
Subject: [PATCH v7 5/6] iio: proximity: rfd77402: Document device private
 data structure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-b4-rfd77402_v5-v7-5-3e7f2d452da2@gmail.com>
References: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
In-Reply-To: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769455974; l=906;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=x84MD8DpzwahLxBpvUlfo99iVRVFury7i1rHYa+sduo=;
 b=Kp+HUTXxhY7dmoqXgMysY8BD9gNXw8gXihQvmoeORL5P1bDjBhhQeYHPPSnt9tSJtC+Dizqud
 ZZfSQyXukXPDSbW5cQrxRc1eWdUCYX4gism7Ergh2re313Dhk6ntF6s
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Add kernel-doc style comments for struct rfd77402_data to describe
the purpose of each member.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index a374a7389c33..c29ae9af4a90 100644
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


