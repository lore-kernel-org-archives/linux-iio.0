Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5536F427;
	Wed, 28 Jan 2026 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622745; cv=none; b=b5+WTOB+yg14RtuyujXtOw5ie9zeTnfy12zeiS4IqRmy8X2dVHX26oxvHwQ6O3yISCAzVg2hef1oaRbrLU6p1x8jSXabEHH1WvlnQ0pBKh8nl2+KqkFwxJorAfwf311XCp+CRkbdid3dCbScLtgz1TXtKatL0zXiWHYMxv3ZUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622745; c=relaxed/simple;
	bh=4PtBuP67jDG6cx0eqtotDQ2qzFrmXgxQTJ8ZGnhryIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtVv+nGxOwDDzDd0e1sSXek7gDSV/KQHkXwYNo5KwAifaFvFrKKQP3TsSgAqz5AoACSDF05pagAwEIlmfvlHdIdQlTnWjQR4q5niELuXpZNyKl0RdJ8Nj2yJg8q5g7/h7azuVKsHonvdyOV7yWHT9Lapnqu4X3SgXBi/oaVeoFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfLbfdcc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfLbfdcc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5589C2BC9E;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622744;
	bh=4PtBuP67jDG6cx0eqtotDQ2qzFrmXgxQTJ8ZGnhryIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kfLbfdccqAKXqkEirKyJb9RvZEo2QkrOuftEX5DU0PuBOkhugGK+7g9dvuRTctB2I
	 aTuYoksZLKpz5sMOtIFqTIX3/1sHbfypz8Rz67Xw89uw476OwUnA1Cj72rX5GqJsOg
	 0YAhy9VHv1Jx9r3RkEDWcr1iWBK61MPkujpqTjEwaIWRhUdJEQxMAgblmyCXwetwTP
	 g0F55rJQLEVq1IAtZMsV+nn0y3aR6xAJGBsLYjUP9R1mx9zMUCEMftpwD6BU3RvdO8
	 /C80jQCcMmUb1wnhK6vhufpEgZ7Nt1s5RgIdabadgX5TNKcvfu/d9vez4pOFcZKOcD
	 vlvvSAJ6gugyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE0FD46BEC;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Wed, 28 Jan 2026 23:21:52 +0530
Subject: [PATCH v8 5/6] iio: proximity: rfd77402: Document device private
 data structure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-b4-rfd77402_v5-v8-5-36388fe7b95e@gmail.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
In-Reply-To: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769622737; l=906;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=x84MD8DpzwahLxBpvUlfo99iVRVFury7i1rHYa+sduo=;
 b=P/tqTbXhP+XXS2nSgtTJISHiwU1xgrW9Kn9FpKcfuEKETylRr6xgxYAl5T1slvCR+yhAwfknn
 JbhhuS0SQjcCixop4SDsz6XXHdydfrSefC+K5oslLGz+2D055NCCTGp
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


