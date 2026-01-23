Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F435C1A2;
	Fri, 23 Jan 2026 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168247; cv=none; b=FUABQ4Qm/cSFEJkPt3pNn3oAkUMljgJJRseBa8MDtHPC5IMt7Wds0crhkh9hLfx9iz0bvT6qlFcDcJBngy0jRVj0droNBaFE+WoVyYNea2DT5fohWwJWkSo2Xe5HZ3/qhs3aDi74cYyDTJFCTUMND/9zqHrQByqNCcMw0A0Sg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168247; c=relaxed/simple;
	bh=vIczClc3L+ZkHkVsSpNfq/q11uqYd3Qnw0GzCL2KdpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vh1zJlHs+E784/ZrZZ+FYqCCOx2Esqvxw2OHHBNmGOM0cvnUAQJNkJ05HK49vVFbqYmZoPXNRtgKHfhoHaTKKlIrvJfxsCBXf6LNIdKbwb0TOjOi6VQNle46kvmmoo+C+ytCEfCPoPSjRG+TjjixM2H56RiNDADTQXaYxR5Q11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d7gTBJwq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SjDsxl1b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d7gTBJwq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SjDsxl1b"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sl9nxX2SYIE0FPFj1PICaucmWXvC8UFH0lqaW4a3QRk=;
	b=d7gTBJwqWu1/i93HjGI4i8O3WWlntyfw2Y+GUawJpVNqI4BewHYFOiYO2hEuMRnmrTE7GK
	TLleyiAyiYGpthbO3JesNquobYKS8+Vki/yTQv3DqlFFET0YXbyW8rzTthCDPF6etanq6K
	Q3ypQmR4ltQ6mzeHYDAzAkkMWOYZsOnksPHN1mWACsO5vFZozQZkeiWyFBKfygNmPkLpMY
	gdPr25HBx+rjLRk3cANI2gg3nnPvtaFM9xyZFPk0nFhAR5DpHGwAllEumKvLKhOi4115kW
	vgtjSVlOxm6y2isNHyMXXZag+pZU31iwR3q5TdIDHIZgnwHFeSaRsxfAdvyQCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sl9nxX2SYIE0FPFj1PICaucmWXvC8UFH0lqaW4a3QRk=;
	b=SjDsxl1b7xpJkADeaZGljWS5VK0SRl3ffFVRm/HFBzkVPplbGuxfnSjMnb4WXchTkJ4PyF
	lj3CAMBl82idT5AA==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH 20/21] iio: magnetometer: Remove IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:37:06 +0100
Message-ID: <20260123113708.416727-21-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
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

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

