Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795367808;
	b=U7Zq30n5sgN41Fp0/HDNMii3AXaqaC+7Y4uvqRURn4Zhv6q12cLuyivZw0SKAGNoqIMx
	 Xx0OMDriXWaavIAM1MrQFR5rbrzYsk7lazys9gqTBBrtxo+z9SNWCpsNeWTVsjvGVkU3a
	 16zTKb+UDIUj6dK4R2rtQiFwqL9ZQu+dSzadF1eMeU1f8aarCykef37jV74Od/YkVKIBD
	 PojjFVuDcxx9vfyhvxBzHGO2tjA2brJcyHt4eO6qK65ztwckwtl1ZZGtEl5RfH5MSM3RV
	 AQRf+W7A8zOUUbujiHtYfA63ICVLDgkZiHPz/L16HXWeuhB6dOxEvPhHi98leFSTzRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367808;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3IuIvZzszPY1QghsYU6mdPLwWkKdVocIucetIpdi4wE=;
	b=L31Y3gZ4E5XDkTnxyS907mwqPDVPqdskj96QCxSJA6og8aQEvbfPUaXexHh8DkvpT7KS
	 DJCqZU9OHeo4YLhaRtKDkcUjDo1O//NClWgsCoI/1IwJkvdXE9Bl2jj610LQuMmeY1xyT
	 uuxjXg3WldHNJej0S0VI+a+FcWHaVMUnrqLbiLjGjjH0tHftpSFlglGjRm1is7M1+nMqA
	 HTJn+mvAx4KhuQ95j7GvTWQlp1oQIeGYJo+lY8b8h5MvTeCLTgCxMpa4npPYabaGY6WUi
	 m7vX88XdTwKsCocdRZAIwl5A9HzMP1pxNA5y3Y2ZgGvJZCzPA9FBjSNlvAZ/4V7JUsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjWRU9PE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DF606A33B;
	Sun, 22 Nov 2026 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjWRU9PE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795367808;
	b=ebe2o56qRUKrsGhYQj1zE3eOcJqAAMmLpmHjPxwZiyOXsUEyX4m14wUZfPl1MNEB841M
	 Pzt8yk91BxJwP+oJiX9vXWrpDFKsvRC9ilPKoWqv0VRx650E+C6ufAjcgCcxodM+IIhSU
	 NcUMkVuA7q/tJh4dhyujN0TnevA+hugQiE20z+ORs3pQhO60tyj9dTfslOHED2EvDFuj4
	 lcFlOpusnZcVK+I3jR4RRQHDYczv0FGVPP24f6IUL/MJK2f7Jk2htm3oBvI0rQH0Pcsgh
	 T/WGkySb28CSIO3Ya+IeZB/UfG58scAAM6kGKGQbcd9qIVWyHzAkhpO21t4EMmlHWvg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795367808;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3IuIvZzszPY1QghsYU6mdPLwWkKdVocIucetIpdi4wE=;
	b=nHK3WiPHjf+HbeDqoAMM2+dRzOWKB96eaxOVGbyAyO/iaqQ9NTi6EFCA3m459yFmCGts
	 sDQvFxLBsD5HwgdJSut0F7wXdLspLmw935TVUkefZKoBVPSidHvRAShVRWxyzxrrLgQIM
	 2fYcCaEbXp2rBwrrsG+iFRPDDyBNtWpSdPJe++KGFZXTvW+dmm8hJVSSIOrswsdk6gPym
	 d7kUiNjWcvI0Renca8KkvxSEwT3d7UMx5bwyuENyxAoIaDdreu1akeYveK9WH4TP2BMOr
	 WarIXpJLiTdueYpujwLUsQ1tOQVI0UtrvO75762nswWc7R7RZXuV1BeEnmi+rqbodsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0DE2A1F000D2;
	Sun, 22 Nov 2026 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367808;
	bh=3IuIvZzszPY1QghsYU6mdPLwWkKdVocIucetIpdi4wE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DjWRU9PEGpFmfurmoRARnhlgpSVSDRoEKHmiUAAbDaRz2FnvG96BDXDebLT04HWOx
	 9SPL6UTxIH5xjlBqMIpb2tEUctUUOQ9wyxvkMOEEYmqfu84SsPleGsoTZxITtRxQYc
	 rxD6QBw/ZvaDT5IggiJd5jBcDPfVRqaEKwyME79YKSxyDfrJv0+0YfFhicQbBLRhCX
	 AVl3YFSFzPD0hn+79S9+2uWsfXvnuzFDZlh1kLOoO8XsrvAGw1ip88RYJGOZjWjxQh
	 qsIWDs5R7jsG8/RJvx74pQDpiKYUA8otD9J1OLdJaCLqyL4+Gbxq+iS2n7bFrfLcQW
	 GG2arxZl1GjXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 89FB64C149;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 22 Nov 2026 19:15:44 +0200
Subject: [PATCH v3 3/7] iio: light: stk3310: add vdd regulator support
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
Message-Id: <20261122-6768-stk3337-v3-3-b0d0a924e843@protonmail.com>
References: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
In-Reply-To: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795367795; l=1033;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=P2zA60tDPyLHQndDHj+u94a4HO2dDtQIC2bKKHaTIpQ=;
 b=HZt8ub02NUAGUWBYyUOpHp1WDPqBqQXlQQt92xAhDa1+VGNNIS1Jchm3RtHXO60F9lhbU+xoJ
 LeAw67oYJJHAnIm/uZ0IVxum05xemR5iuLlm57hmFJJzNwEIejHda15
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
index 708ac0503be0..828c3404215e 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
@@ -759,6 +760,10 @@ static int stk3310_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get vdd supply\n");
+
 	ret = stk3310_regmap_init(data);
 	if (ret < 0)
 		return ret;

-- 
2.56.1


