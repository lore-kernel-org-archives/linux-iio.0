Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794094300;
	b=zuMJ6L7lmbk9FNrshUUaBuMO35tyV3yOlFUhNW97LxRR50A6fy0m7znyuHEv2+3WdW2H
	 4dqNNfkyiRUbBNuBaZjXwslEVNVwqHBG3ayxxtcLdsRmJIJkJeBrgOGgnLC3K1H32gGWL
	 sokwn8ILBsIvlPVL5HNdaF1dYi8OZhxVetueKMTdPYrj/FZYCSn/lajioyjffgnUyY/Az
	 2NGmypZ5efMacooOIy9/dGAS+itLpiDuEZnpT6U1decFkXa4r3EvuIYAI6/fpgTj1jhn/
	 oEf3ll2Ls2HAxzxU0aZ6voUpl9qI5uNKymfAsgz67dJK/a6ZCImGRVsUvIVsU/gwwdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794094300;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=nekne0KQYiJrS7jjDj5hFbjzxCG5kSQxN2Iuz/nADAg=;
	b=Ut5ByEXcoV2drdGTx4DdrwhOCSYzBhBAgWq5mLH15w9ZiSGTZ16zGhNZMHt5lbQoF/lx
	 23MySzA2hFzZkDNukjm4XLyDUKZci5l/Fx6ugzX86N37FCdd5xGl9c2GhClNZ0Bx+Gv4E
	 +KrLskunA1gg/4M9tNZ3pVA+2VfJXTvSzYHmmeqpiDtRb9qt5H8e6vjiBbDbDH7ZhyJwP
	 yCz5120mgdelbB3vgj/MbqiNswAD/gAOWstodWlwtApFGj5ESZy7jHyfoo5cPQC3s4xpm
	 3hUPg/OHOtark/8cFWBSxpSTdjpZf6VHU/Lm2VkhFlxP+2JcbRjBUVln4FjkTWQ/XNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ide5+He3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C332606A330;
	Sat,  7 Nov 2026 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ide5+He3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3191F008A1;
	Sat,  7 Nov 2026 23:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794094299;
	bh=nekne0KQYiJrS7jjDj5hFbjzxCG5kSQxN2Iuz/nADAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ide5+He3zVGBxMyu+Bz3tVsUrfJw/A/3d0C9EcIKdH7cNsQOHEfRJy6uXCHhpApHs
	 Td2+XPoxZVt13l+6MslD7nKF0wABXulFtwhL81Q0BoGL7kgnCngXLSjTHYvVdel4Q4
	 d3n5z5ExWkCkalundY7dx4H0odukLg/AVElAVk5bwy+SIctRUs8wHfsy6xhXn0bPBN
	 WsI4kg4sxZxIp77MiiE1IWr5R5oT30z+TkWZl6pmyyX+4lAL3mWn34Zt6zD9IxP8IW
	 cy72Odbgfywzl8xirHxkknkJ9HcGN5He2PG0Q3CLZbY12ivfEfuupgbuVCS13vXKKh
	 Yd7OtzwoncBXg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 08 Nov 2026 00:31:33 +0100
Subject: [PATCH 1/4] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
 supplies
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-gp2ap030-v1-1-55314eb7055b@kernel.org>
References: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
In-Reply-To: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The GP2AP020A00F needs a core supply as well as power for its infrared
LED. Its I2C and interrupt pull-up resistors may also be supplied from
a separately controlled rail.

Describe the core supply as vdd-supply and the pull-up supply as
vio-supply. Keep both properties optional to preserve compatibility
with existing device trees that only describe vled-supply.

Link: https://global.sharp/corporate/news/110721.html
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
index 3fabf1f576cf..d4bcca0f2d0a 100644
--- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
@@ -22,6 +22,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply:
+    description: Sensor core power supply (VCC).
+
+  vio-supply:
+    description: Supply for the I2C and interrupt pull-up resistors.
+
   vled-supply: true
 
 additionalProperties: false

-- 
2.56.0

