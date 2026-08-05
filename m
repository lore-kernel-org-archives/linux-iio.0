Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E73E3DAB;
	Wed,  5 Aug 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914520; cv=none; b=Tr7vXwjKQUpV5zgUO5u1ZIjigtmGuXiSbxkSIdUWJMhTT/WS6XG7+DssGOe9KukUMqltYS4jZ16QkClup4jnzrE+G4J4/dJ6EgEuYgrbZ44phK4YNSWpFMCP1tmbliXQYkJ0hlhGFwgY4c13WVJTxyV2gtkwbMmCREpSAjHgI3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914520; c=relaxed/simple;
	bh=Asys/l5kf2kl/oT8Duj+DEFHKiFbbacSeXHFVUJ7pOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzEA3ai5duJY6YWN9K3T2vuNcPRW+grkLs6YLAHpPBuBAODo5dQcFfbpkj21B/nGnIK7LSY5n7BL7lzDt5bhCXhgISuahHfF+rmsHhA1Tq2PibptvLHrHYXZF3l84e9WE2NI0kVwsl/sknlNghiXIYn2iWGe8xelbmB5pXH+NR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=uBrFROoK; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="uBrFROoK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785914514; x=1786173714;
	bh=5Q+k7JiM1qH6orV/XcRPs5qMQAeInl+Ds1EHW53hz4w=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uBrFROoKIh44UDftQXW/Pw1yzme1qRzvTNnWeT67aNoNv9gVJb8ieHFJOgZkBVY7k
	 69Sc+PLI9w5nKrpmd+xEljAD4zLaDCxH0fBzNd9i6MG0DbvfKG9VB1abSCxnhd2gUx
	 wLNTcmUAcTxoZRc2pYxhPXwZFK1O7yHoiu7b84YVppwYZOdvb6CKcmRGCbipY57h3P
	 gGaMAn4NaSAI+oKevwUVpkReYKyDlDIYlke0F5fc2E+abDOM6l7s8CNmSVzQmq+eIr
	 km5y6IDaj7UlV1WwHBR+1ecRY3zZv2FzTdvUYLxhsDsmeezOfDsYOQ1mNTfFseH7El
	 eoGOth/doCh7Q==
X-Pm-Submission-Id: 4hFMKp2LsNz2ScQJ
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 05 Aug 2026 09:21:37 +0200
Subject: [PATCH v3 3/4] iio: accel: mma8452: Only apply trigger type when
 not set by firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-mma8452-open-drain-v3-3-6149f406a409@geanix.com>
References: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
In-Reply-To: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785914502; l=1248;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Asys/l5kf2kl/oT8Duj+DEFHKiFbbacSeXHFVUJ7pOU=;
 b=GbB5Yg4/bZpQt+FVA4wu9FPpLFXk4pq5Uwpa33GJ0jro5+2T63obCOfkMA0pARP8a2ufAAcpx
 ZNqCo9VFXotBcAcsZqascIPFHv0YZPdqOS96ZfMDbDdaAwsQZ3mOPQV
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Instead of unconditionally overriding the trigger type, it is better to
only apply a default when no trigger type is set by firmware. This should
be reasonably backward compatible, and should only potentially cause
problems if systems exist where firmware specifies an incorrect trigger
type. With a bit of luck, there are no such systems.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index f645a5c6fd1c..723ca3d9cb96 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1683,9 +1683,14 @@ static int mma8452_probe(struct i2c_client *client)
 		goto trigger_cleanup;
 
 	if (client->irq) {
+		unsigned long irq_flags;
+
+		irq_flags = irq_get_trigger_type(client->irq);
+		if (irq_flags == IRQ_TYPE_NONE)
+			irq_flags = IRQF_TRIGGER_LOW;
+		irq_flags |= IRQF_ONESHOT;
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   client->name, indio_dev);
+					   irq_flags, client->name, indio_dev);
 		if (ret)
 			goto buffer_cleanup;
 	}

-- 
2.55.0

