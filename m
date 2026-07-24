Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A72411F93;
	Fri, 24 Jul 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784894594; cv=none; b=DGyAhPBlySjslJijMueZiGxeu5+A0u/hQfDr4t43FGiyhDBAM7EmZYJ0ih+HfjkYZ6rs9D7yW34VOXJ72xqTU1qepCOZOD1SefYM30wk3+bRcZnLjAh6qHppidwvlo8D5T7O2EofI7A4I/GB+jzfJUJdWqtxrvDDeXnHbh77Ix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784894594; c=relaxed/simple;
	bh=IOKygviKYsdzNDfvMZxPYjdbgMKODl/dsCbAkwiLDuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgclxLbNRFOyhu5aq+4At0uA3ypUvu+Au3pR+AVymh9IUSrUiiU5vvdq1DarylqMV/1r63D4xMrUvjMaezmqFDl3ONrkqS8M8SKHw6mQ7lR+mTjzuamXt+bhD/Nk27TK3P5TmL3vsJhE9w3HpVjNWaClwTBQE5LWxSAXgOAIqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3zlxkg0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3zlxkg0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B12BFC2BCB3;
	Fri, 24 Jul 2026 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784894593;
	bh=IOKygviKYsdzNDfvMZxPYjdbgMKODl/dsCbAkwiLDuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s3zlxkg0YuTHni4IrbTZi9wAJEdMNadeiC6No/pyZVy7WS5eQANRXO6OoG/WNCIbR
	 MuV9i44/EUasjZ+N2fvSoIZCq1YmD8GkcuZmA6kHjz+B/lOYIJHnb1Byf90XiDgDqO
	 8wNBVrnGHHRnxmoJdkoxk5mgN5zDgTK2FYGTXa7L5faSmck3MDDZXDcrAljkuRX1pO
	 IGWvksqkXxQErfl8nmGW2Fjl8ajxZL2/udt3wz5mfWZFVCpGiEA02whQ3+3kKPZN6A
	 L3lHBiVAce+7kgr+f/9Myxo+xfW2caI2dKKsmCq0SwYca9YiIua67guZBOgxkUfqcC
	 6z7WcgRJej25A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F88BC531C9;
	Fri, 24 Jul 2026 12:03:13 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 24 Jul 2026 13:03:11 +0100
Subject: [PATCH v2 1/6] dt-bindings: iio: dac: ad5696: add AD5673R/AD5677R
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ad5686-extend-dev-support-v2-1-cfc2b30ce988@analog.com>
References: <20260724-ad5686-extend-dev-support-v2-0-cfc2b30ce988@analog.com>
In-Reply-To: <20260724-ad5686-extend-dev-support-v2-0-cfc2b30ce988@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784894592; l=860;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=3HN8UocK8YBGgUj8JEQFaztjreh7vf2LXD3mgpedKpA=;
 b=/wcSbeRBuFVEHsoIErXWW987wFtIunrJVQLS9YMsw6nYJaBMUZdzA33LQXAdausLWJ5BFQ+T4
 e788WyUXLFYB28wc8pHGUy93vDhu+k7O9LfkO/XM63g6tjuMEr+HiXB
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add compatible entries for AD5673R and AD5677R. These 16-channel devices
have different bit resolutions so no fallback compatibles are used.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index e10f8596f9d3..5a93edc976f0 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -19,7 +19,9 @@ properties:
       - adi,ad5337r
       - adi,ad5338r
       - adi,ad5671r
+      - adi,ad5673r
       - adi,ad5675r
+      - adi,ad5677r
       - adi,ad5691r
       - adi,ad5692r
       - adi,ad5693

-- 
2.43.0


