Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5E34F483;
	Wed, 28 Jan 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594170; cv=none; b=S1NTgMtZF6O8AXE+WZ2jZW4FJZgpWDlvQXNrXpuV0TgY7mMBR+h5lAlW40pURP+YswlnpwwbP/jZUIL73WMR8pDfPRtr7KTNP3rDZPK3j1x8csvLc8HxcGK2TM/fSSpcMIlYVKq7enMbKPQYC04+rGhMSWK6PH34J9f7o/BTboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594170; c=relaxed/simple;
	bh=qVa0VoHLsuewyeObssCoPaoYm5WLwXw+JK5rcjkrCVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ofj9g/m/+FWLGFZgUGCRvBbjdytxcUdaB13g9wOhYvUzSDuo42x605lEAWhfYeUNpxHwjparNExwicNZrDh/F05Yahb8TQtXPxRz3GFgc+EZRmQ0Ot1LsR1d3kJMdzTqqnD3dIK+C4djQjQ817Nhyvpwppig0grwaOdamgESfv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Edh1bVPt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5ulMJqDd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Edh1bVPt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ulMJqDd"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qq3AN5OW9updjcbObsRppzVautQaGYNsBWlroen7/jQ=;
	b=Edh1bVPtoc3BX1CaQvqfPBGfw1SBJcqDe/s155YiR0c+sqfWGLE4X69JD+UdbuWfNcQyVm
	SmGXY5JEFHUOgO6bc8MoVrOWls5j/sZ9k4gcyQsAxTj9n57SyPCJbrrs8tpRLsNmTGVPEF
	CfSPZctwZOn2iIM9GmuRJNSdP+puzln51DWC5FhKW5/NKUxqvEM8vTD2RtRRwxvduvOU2Z
	o84xFgNH1jowrilwL2bbbHIrVs2tW3Cx6yLgjiFE8EKPbAEfUbIYVZyPCt4HZl0ssasgqg
	hoWUrg9NR5vfh3KyR4IPiX/LEZNerNYDyC3ufoMKM0ZqdLIzgujkb/+Z9GpiWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qq3AN5OW9updjcbObsRppzVautQaGYNsBWlroen7/jQ=;
	b=5ulMJqDdWITiHRtMpV2TGwPqEdIg5i7XB/4Znbw7IyYZFUadmPcP3QZU+g1KctEAYZBnv5
	gDPHeZ7HG/qGKGCQ==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 18/20] iio: magnetometer: Remove IRQF_ONESHOT
Date: Wed, 28 Jan 2026 10:55:38 +0100
Message-ID: <20260128095540.863589-19-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.
The force-threading functionality is required on PREEMPT_RT because the
handler is using locks with can sleep on PREEMPT_RT.

Remove IRQF_ONESHOT from irqflags.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/magnetometer/ak8975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/a=
k8975.c
index 3fd0171e5d69b..d30315ad85ded 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -581,7 +581,7 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 		irq =3D gpiod_to_irq(data->eoc_gpiod);
=20
 	rc =3D devm_request_irq(&client->dev, irq, ak8975_irq_handler,
-			      IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			      IRQF_TRIGGER_RISING,
 			      dev_name(&client->dev), data);
 	if (rc < 0) {
 		dev_err(&client->dev, "irq %d request failed: %d\n", irq, rc);
--=20
2.51.0

