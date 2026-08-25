Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E03E1200
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646505; cv=none; b=Vxi9zNZHeTIXypYAcnhS6+Mw1vYjzfu/A5XOsIzjoX76K5r6l8127DjKd+Ag+O6hXkh/Ubpp8oxsIdZyvDjJDZznU8Cc/+CUT3WjgaL+cQBegIbD1evGeCjctXeFv0Z0po40ftKZNsA3JLWu9MmCq6s+xbpKfXGOint+keKl9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646505; c=relaxed/simple;
	bh=CQt4VpK/gUFi5hSBjRzPqWtP7oV7ZZDzAs8aCFm4k/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GiblI3p3jfFaVOfP2xmkoBHbh4QD4t9iW2fHo9WqzUJh4ev8u1GqAR68KuppUku9cNTCAItckEubW6F5/yImzA+kChYSpMTq82sDZjxP2Xagbi5kWwE1txARGv/geCRnxvSzwSi7LPlXZLkRO5u4SMmtutk5QQgQeBW+WiO0RQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ZJDDTq/b; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZJDDTq/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787646489; x=1787905689;
	bh=d5ddm8RHR5lDiVqtBd299JMtTIifk4yTFA/MF5oUCJc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZJDDTq/bORQlpb61aVxIqc905jK6ACLFORP69RjuaiRj1f3SbtzHXX+fqj/FGz//v
	 aLOG51d7EOYpnqJrikkYN5ArvM/w5s0rbrYt/ZGHqzZpQqvHrHfn9N0HpP+CFDANqk
	 dV2uTYjY+byuLW3f2y1XhAbjHnpOZIacBwbLvhO9nj24+H5vDeJNtEyiZunbhz8mNb
	 WVcPL0cZnvmYDBL4jPvmfiVEqUYLdAsreF3UPltuc/OPGqAamrKV0J88uwcJJ8q+DQ
	 tjdOnhDgfX9o7Pc1lZ2pgOSRrnk3r3DZ9SO5c8OsjHM7/UPOUrM3WeEv2rm3tJeKg+
	 88npcZ1NODoqw==
X-Pm-Submission-Id: 4hTgs50jlpz1DF71
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 25 Aug 2026 10:27:45 +0200
Subject: [PATCH v6 7/9] iio: accel: mma8452: Drop unneeded lock acquire on
 read
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mma8452-open-drain-v6-7-9b252804ee80@geanix.com>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
In-Reply-To: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787646470; l=798;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=CQt4VpK/gUFi5hSBjRzPqWtP7oV7ZZDzAs8aCFm4k/Y=;
 b=dkMez87xduDXmHM4peUonBDf/y8dUJ39W59T1qDDI+esuebzXFADHYw7vEKjewKCkZWyxMki7
 9V6Ziyu+mXSD+WvrieI81pjbjLYmNAQvS/R3UGaxQ1kxbO7Q6G85KOY
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

There is no need to acquire data->lock when calling mma8452_read(), and
dropping that makes it less likely to end up in an AB-BA deadlock
situation.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7ef1a9a91c31..9ae2c3e60576 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -504,9 +504,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
-		mutex_lock(&data->lock);
 		ret = mma8452_read(data, buffer);
-		mutex_unlock(&data->lock);
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;

-- 
2.55.0

