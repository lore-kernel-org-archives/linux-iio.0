Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E9483811;
	Tue,  4 Aug 2026 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862975; cv=none; b=gYNNEuGZkx5EKbR6PzlYBHYycKDocCyTvHO6tVe2cfWPWsc+sP42Kqgr9uFrv1czYSyLyiBLEQV+fffeRYaAmr+nX84pPbNWCzNa3GAO9qxEkwm09Xz3wjt/udwDBxxOyLQTCIVWjVcjVdLeP1wWAjCnSVl+zJFAoJYL2UaeYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862975; c=relaxed/simple;
	bh=VXyhQMMg8CN0cFJ9z4GKE2E+8am/m1lwXpQe7fanMH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dFcCKsD/y0eUKhasdFldfnF+u6Tz41xxSpTr8Gyvlxm2zgXr/p+c6avEfxVxmkeYDuSPiXlPrecKqTyYk0wdkr8l1E97DEqTLLmRnzRuzrRycxHMJsYh6v3NUBBXGif12wIW4uBlGS/G8Mhkxk/WyYhO/fYB00LwQK1G3NfXKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=EMoCDnmz; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EMoCDnmz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785862960; x=1786122160;
	bh=yK0E56Rq3jAFi303hsKEKdRRobQvbPJyMbQ/anb9Y+g=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EMoCDnmzTMQWEiYQb8FXYvJPpNVl+NZREc5/SuH9n1Kwje9wwXe59SxhEzHWzrr67
	 pB2KPnuSTr8668+ECtMg5zvlxAa7B/qDkc/ZAfmQKizqwpEGioCRnQPRAzO9mcnq7h
	 77MBGPWgL49eWUVWpG2Z9f508FlxkVtWxp4xAmtYi+Vjo7+yKi2j657DfneZKXB52/
	 132Icmib8gVIH8lzk6Mcnhpmjc6057bF4GNBiSI6Rz3BfLijpjXYkKajh7sbLm9jMJ
	 Lm9/cgZT+KGSMIMvKGZ1NBeULDIJA2lxLFW9QHeMWLMbpOh5RUp4GPRAOyXXJUkWNL
	 v9paFXlcjUT1Q==
X-Pm-Submission-Id: 4hF0GR2WCdz2Sd49
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 04 Aug 2026 19:02:15 +0200
Subject: [PATCH v3 4/6] iio: light: ltr501: Power down chip if request irq
 fails
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-liteon-ltr329-v3-4-c6b768c7c745@geanix.com>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
In-Reply-To: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785862947; l=1111;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=VXyhQMMg8CN0cFJ9z4GKE2E+8am/m1lwXpQe7fanMH0=;
 b=oniRpbGTVaUmGA/y9GvaoXFbMDzOmE7E4Le9PG8AE+an1iAcldEjL5LIdUJyU70/kCRMl/EOh
 LXDZZlG9OxuCW1mWUi58kdUftTWoU5lf/zRGAw2FEcKuHth9+NIOfWr
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

The dev_err() message was causing duplicated error messages, as
devm_request_threaded_irq() calls dev_err_probe() on failure.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7d045be78c6d..b36bd10a0262 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1537,11 +1537,8 @@ static int ltr501_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"ltr501_thresh_event",
 						indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "request irq (%d) failed\n",
-				client->irq);
-			return ret;
-		}
+		if (ret)
+			goto powerdown_on_error;
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
 	}

-- 
2.55.0

