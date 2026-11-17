Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938919;
	b=s1xqUD6Q07OeO/v7xNsDuM+boeCsetqru6ukNIYXJ+9/WXJ/LP8ID1bvznN3VaU62OqF
	 IKSKoioSdwrH9+qKhwU6l+jPqrApT/uJ0EYeXNZUSdBzQ1JZb2wxftY6u1pdCEkzIXM5f
	 ebMzEsPsOk+ZG1nOt3C0N4K7snK0HbiUZY17qIghKvBDc70XGdR+XRUM5jsJSiufc87BY
	 y+IlEGjYXiL20T6jRNzZLCb+fo7Po3p9LTn07+oG0TEy6YzQEJ7UxWxZi6dxGoTnKTyf9
	 pozERZ+Pt26FXbh3T7AvMRs9CBuARTiycxxwUzH/ihZzinqwhapgK81SKqmuwNmSp2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938919;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=De7BqjSh3MyG8qLZsPPymWHHEpjTg4BbJeztDhyF0Wg=;
	b=KMapVkxM9/AMWHz8oih+wCKwBnDiT3zCCPAIAHZ4VxS4xQ5BkM6QjYWRgxa8opOdbeqW
	 XtMa1++hsKfaKrSlb/pzAl2glrU6LZKTBzcysX+YqSECopxZntrjTwb5Ps4D/h3C5UrJb
	 UZ8Tktbs30uRAgPtqE7MZ32emg90ChfRibnYqyNDjow5BsJ5YSn2/hMrRRllI8eyAqJ3n
	 Z/jYfBlzx9Qg6DN5cQ+NDAhWnhCAgVoWsbBKDo4drKxeDW/NBRdsoULXpxzNaEUi0PUpI
	 5B2W5/rN5to2Ofub/3XmenddIF8OXSyH0bcOOrIHHlC8VDBQsQNuWE+54antKBI5LcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S9s/GKu/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A6606A33B;
	Tue, 17 Nov 2026 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9s/GKu/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938918;
	b=1HuhBhsEsCalTx6IGB9ZGdjqBORxuiNrAsf8hw6qpRsAaKZ5h4mNuM0whc8xTYoXquCC
	 qLYnIip6ANZmVIXGoBpXW3cvi3diOggVwOdnVVSPdXleQv/vcMdFk32vu9qs66uixL2Cd
	 JojxXulQohKgb1ULhFzQAC9PhhfB7JdZ04LVWZKUAjn/46xSCCzdxtpGhgQkNBEBoFC33
	 npAwSUUy19PLCpqfov76Xb/ecizgVT3WdmtTz7tTdnS2/W4nUfTq7KvfgNXgzhekAYwj5
	 JM4vD5EBwDJcv3CtetID02KZu71ZYh/vqdPnL0PG/qyU5Q7WNw0fy9+S3L3biA5GQpA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938918;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=De7BqjSh3MyG8qLZsPPymWHHEpjTg4BbJeztDhyF0Wg=;
	b=FBq9VQwZQxugxdrei4IkB3EtixfpvOHuNoSm3Q68wUs87BIXyLYyrZL0sPG2YC5KWc9Z
	 PAUb+QZinXL2LLbbEd0vyrr1AYABa0Hn8LyGOAKE/7g1l1LThMHSni4zN/LrXz89jJGEg
	 f2AUHpbpqXvv2CjrrDhtNvu0KkZ4n/b097c/WVe1uoLimHcATsYve28U3wbYtmrPfh5D1
	 fznyUWOLNBCdNeWGrvns2i3umf1HkHbeXhaAlRUtyKd92Y+zh3uMPgs0kmWYlZmFS62wU
	 RHnYWO09dksqDGIt1s7ZUilKts8lYTcX7EFU8+alo/2G+H5MzriIFsdFiq9ZfvA4LOg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B7D1C1F000C7;
	Tue, 17 Nov 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938918;
	bh=De7BqjSh3MyG8qLZsPPymWHHEpjTg4BbJeztDhyF0Wg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=S9s/GKu/WL34d1h1jd8AdFAmDnd/IxeGCN4EHAlY0jqGDfSjGErWMY8mHb7HaNBWO
	 TjfTmFJIoSfZuKgRIovUlEG11VgyICyW9lzg9dMg0o3liv26u5cL3IH0RGp0OUTyKl
	 iTiMDKkjuQKHtQIppCIyMShIguKLbF48lhitdrNZdpkQAPd06t27JW+FEIbgEdytzk
	 71V646lxXd0GvSsaBj5Ehid8yFXvbUOyiw5UDdUySTwb8miBgwUnU73Zw/VlXG1NRX
	 3R/XFJvjejM8IzQVjqy5U+XM8C8jksic+rbdroQhTtTR3+5+fH+adSB0nVV0ALBdx7
	 MrqbpEQkjFMPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 43B5E4AA47;
	Tue, 17 Nov 2026 18:08:37 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 17 Nov 2026 20:08:37 +0200
Subject: [PATCH v2 3/4] iio: light: stk3310: add vdd regulator support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-6768-stk3337-v2-3-92f4c7be3bc6@protonmail.com>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
In-Reply-To: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938915; l=1100;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=P5EyD85VDfSXBEox0JnVub85ggLxUGhVypoOaimLv4g=;
 b=sGQ05nVPy4oABTud4kewoqVpxi+MNMAJcrf7Yr6J0+c+luB23bpoF5N9EDfV4icN1JJyqiLIc
 9tdIblKgER9BdP2JWSqX/4+uPAGV0GodhnOezT5tWevCS15iIiZh1pV
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

On some boards, the sensor is powered by shared power rail. If the rail
is powered down, the chip can't function.

Add vdd regulator support to ensure the power supply is enabled for the
chip.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/iio/light/stk3310.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index e751e7c97bc1..2f4747c06f43 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -18,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
@@ -745,6 +746,10 @@ static int stk3310_probe(struct i2c_client *client)
 	device_property_read_u32(&client->dev, "proximity-near-level",
 				 &data->ps_near_level);
 
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get vdd supply\n");
+
 	mutex_init(&data->lock);
 
 	ret = stk3310_regmap_init(data);

-- 
2.56.1


