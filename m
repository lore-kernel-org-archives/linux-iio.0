Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F33A3E81;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=E0w44ibr5/t8rmPS5BACtk6qUch0QRjsAww6fxbx/+tEv3hKXS52RZHjdbyYwhvZwEqKc+Q8FAaONpJcwkPp+LNbMBQEoK/o2KbzAZY0XmoqvDOJ8ZvMMS+FIEFNbmyGfwHgjgZPR15AokMoEqfZXRQcrtrqrUMFDgoeJ7y/rnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=h/d77N1gpx+E2O8RHYU+Ry71bdmStInC98q+cc/PY5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+junFXhFxGYoURFDHZeIQouEGuWevNq0Pz3xHzYBz9QN1PS+liBjFl4TMCpkTopR9RQVFcGNsdR2uFMHo4NlltqvjIT/9KxsnG0RpgfCQIl8GyWhQ7iDwW2J+jaQ5F4NMULW4AH1a2BykkDUHhzcPVxoXx2D/22OaK5OtaWr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw3acUxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw3acUxo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51294C2BCB9;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981562;
	bh=h/d77N1gpx+E2O8RHYU+Ry71bdmStInC98q+cc/PY5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Lw3acUxo861Wa0PAm1dxJ3fM2plFa33KJygeKgVm/hlrU8Xq3OOCUNQFssiIG8873
	 zhi3BzguTiNfMdKDIfyqRBlfKGqXrxhktFpKXiIUbfpawDOpc29UALcdDEyDTP2Tu+
	 akLnLbLjqCpU5JDbzjcoqP7qrV1WUdXmaFcI1oXrGOUgnbvaT9gXkFKlEd3f5RG5Un
	 ozcX4Ef/ds/8mQrZx5nMLGyFIQWCcbx5VSZmaPo+Rd2UKAhj1YtnC4KkItL5tyeAK9
	 PMckvvpHcPk9Z/oFC8vl6uMUGZsjLa+qJgd0ZoPqMlJOvvllgvVVnQgOFCi41ntDpE
	 m4EQQeQNWoZeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A618CD342F;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:07 +0200
Subject: [PATCH v5 11/18] iio: magnetometer: ak8975: remove duplicate error
 message
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-11-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=1086;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=TunL/JHu5yEjyxC5fcTuS8qbC8VTvXFU4WWogOsSh38=;
 b=UWFAVkyfhVY7WQOqC9mXRginoYEKuqTo2p0VDaaIBSJ5Zm/jvrPxKsD44HgDgKFOoFO71NwAi
 5HAuO9g3dqrAFNrs5Y9fvzSI9Pwk81hVzflsSbx9D2SK63v1dJYIE3t
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The devm_request_irq() already prints an error message.
Remove the duplicate.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 7a971de2eebf127fc8ab68300fb82f38d9476c0c..f58cbafb491a5e039b22fc928a6c58dd6ec0f297 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -584,17 +584,14 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
 			      IRQF_TRIGGER_RISING,
 			      dev_name(&client->dev), data);
-	if (rc < 0) {
-		dev_err(&client->dev, "irq %d request failed: %d\n", irq, rc);
+	if (rc < 0)
 		return rc;
-	}
 
 	data->eoc_irq = irq;
 
 	return rc;
 }
 
-
 /*
  * Perform some start-of-day setup, including reading the asa calibration
  * values and caching them.

-- 
2.47.3


