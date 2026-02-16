Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB52D7392;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261853; cv=none; b=Ws1oO3llPyMtP40bawqIVjYulrDUQSOlBfU7gXN63C/Q8OjfPdN0P9BkwhR9HF8uRkjIz7K5XI44VOGKJgoZK/ObxVBfkjHPqfOW5QxGhTtS7QpqFjv8XA5u19Y+IDo1ukJfUSm9aYQhXzKWa48IX1rcGH7VzO18NR5gI1wK0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261853; c=relaxed/simple;
	bh=o3bvt5IVoPOuC7CuBgSGeBwzgK4Z/m9v9mxJ/tknRCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMFhx/ScKfRO3oFRXv98StNV9sJobOZKCt3xAXcNGXA8rPeQS1V5VwJD2s/8ytR0wGnctOcXcn4668UQvg043/RwGetP06QM1knK7UUHr2JvKzlzJsB70wC2IbxvFNG3X5AhRBQyHONmeMpCnZYk7ZxPHbJFVQKB5+q1ScpD5Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9o17rhl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9o17rhl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CAD3C2BC86;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771261853;
	bh=o3bvt5IVoPOuC7CuBgSGeBwzgK4Z/m9v9mxJ/tknRCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h9o17rhl0RKJUJc6euDErpeTgfCLFAcgWpp0fqAwWAYkViHitfOfrM5jwfm5D7ZvN
	 BSKRSl5cwhQNTw7y4v4KwwHqUCgTFoRUKhI7GbbhiPc5kEDP7Jo47+YJikGVzNFzoh
	 EwuT+Zsat4fhj8+YDwXiPSHNcbYuebaDqZgJaSo6EHTT9bh2xBzccYvP+0/yTznrNj
	 RVxicJVnLxpnwhXuYVkUI5JOMWP/5/u58ff5emr2fQC/fKWWTLe0CrzpWnDSoveD93
	 cJ4XntQ7NWl+ecpA/p1kC0N1i1porRNZKWhO6j+gDnqCtUZQrYob4IPvCBp33iePPM
	 Lb2Cx6tnnq5PA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47595E81A56;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Feb 2026 17:10:45 +0000
Subject: [PATCH v5 01/11] MAINTAINERS: Add missing maintainer entry for
 AD8366 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-iio-ad8366-update-v5-1-7e6091357d02@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771261851; l=890;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=IB6nsbVkeaHwQfGZNvFxArIH7f6StXcyc8CEVB24Hfs=;
 b=HhLpF3E0gb1YoVZqodpB9UBVx4v45+g+AF5t2qukrFyQwwTCdPZ9YyN8hPmUkqYZUF4Up4kdH
 o44MCpfuLhRBBmXv7sa3QnzdvJeB8U7fXsfubKF04UnoOj8zDbeB3O+
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add maintainers entry for drivers/iio/amplifiers/ad8366.c

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1251965d70bd..ec9a6beb7619 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1583,6 +1583,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD8366 DRIVER
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	drivers/iio/amplifiers/ad8366.c
+
 ANALOG DEVICES INC AD9467 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Nuno Sa <nuno.sa@analog.com>

-- 
2.43.0


