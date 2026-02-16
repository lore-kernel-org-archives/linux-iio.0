Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7792D836D;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261853; cv=none; b=d/Te8aF+2sDKpRoaufgbo8Ix+WzDSNG93c4hMN0prNDb5Rsbj0LqB1nDHOeTPJF6rF5a4HsrdJt0W7ojhFsX5FaFSiHTXUqAdKRu81IS3fCM/1LK+TCHQvWr/I8k/Qb7K9/ekaNUyPc0OuOppFfArIXbKB3GIWXR55GFhe2w3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261853; c=relaxed/simple;
	bh=WB3uNtPxOXBeyvnMEjIGCj3b9y7bQt14nCNr/5URaso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVM83+jP2niFO1f63vT3rho/4vtOEXMSVMSeLzIpfYITYbi8SGjOZ7qiqM8nGSeIRDZNEr/qBCvRLLth7+J6auR3WjK6ex4CMCzQ3naDBZc47p6ymHty5hyYS+dmCvpSaKiWpBVSMz4AzVbcIKFXc+G1P6S5yP/ML+lVF+71Zs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm006ShV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm006ShV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A93EBC2BCB7;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771261853;
	bh=WB3uNtPxOXBeyvnMEjIGCj3b9y7bQt14nCNr/5URaso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mm006ShVeAELIW+YhIssX1l54nR4TQHxWwCNBin7OAUm81mCGKPc707flgZmNB9jE
	 p2GAqTHkerBq6E7ckVzP1j7sXAo91lJwz7eYrfCNdc6V03m3jhgl+DI8ce/PLQoQdl
	 dR4yayIYHyWbNhYEbVGMrqxULAFIsqWqAxrdi+ZirerJtTSTAtN6U9anJFeoLhwZ3F
	 QbXecdZt1WP1LrtnKBc4gGZNUcUXte07ibXFsCyd5OlzqHbf7BTKCxgXM3owOvDIVh
	 x0Al11z/Nszk9etSuKGOVTgO7gwPLZOf/DJ0L/TNKJm7l24rzP+DkTAxZ3d0FLJ9Qv
	 lCDJw6leANCzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F1BE81A5B;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Feb 2026 17:10:49 +0000
Subject: [PATCH v5 05/11] iio: amplifiers: ad8366: use devm_mutex_init()
 and drop mutex_init()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-iio-ad8366-update-v5-5-7e6091357d02@analog.com>
References: <20260216-iio-ad8366-update-v5-0-7e6091357d02@analog.com>
In-Reply-To: <20260216-iio-ad8366-update-v5-0-7e6091357d02@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771261851; l=1096;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Hc2oDziDqm76kntTxzCYZxXGJ8oFjf16eqD+h6jkb6Y=;
 b=NbSdFlOD0YSqM+1UOH7XzHN/+6UynpQX/NRfeDM/C/2NDF/6kP0lO0zdVqMCVSO67Hew97HPW
 2EuuE90K/ALDcCIi4eADmbPLjwTwlP2WJFh4LXuhpRUG5FNWwxFJ0W1
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Adopt proper mutex lifecycle with devm_mutex_init(), replacing
mutex_init(). Mutex init is moved up (before regulator init),
so that goto statement in the error path is avoided (which will
be cleaned up later).

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 677d02f4f075..6466f3eb6bbc 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -259,6 +259,10 @@ static int ad8366_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
@@ -267,7 +271,6 @@ static int ad8366_probe(struct spi_device *spi)
 	}
 
 	spi_set_drvdata(spi, indio_dev);
-	mutex_init(&st->lock);
 	st->spi = spi;
 	st->type = spi_get_device_id(spi)->driver_data;
 

-- 
2.43.0


