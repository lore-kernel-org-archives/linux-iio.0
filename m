Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF6411F9C;
	Fri, 24 Jul 2026 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784894594; cv=none; b=ZMvu26pyfeYOe27HFLmHy9P/9h4L/p7ea8pixh7yJnXUgq1ceetfChvMa+IyyMiDnFjYF2rFnQILbI2qmtEScJKc0KMs7U3PCLBU1zd06bzdNFGvQ0tkK7aaf0gJalNSl3NdJyPyv8ZKvU3+BqZM0ME9IvO7c1OzdC/NqRlBHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784894594; c=relaxed/simple;
	bh=40cvMlvgwmZriZTlerX6U1ckF3bUC4+tpjdJ8BUKE/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BvtY3S7BD79hW4Wx8UCG/6VkAYEPbNHqUBte04KzJ/MFh9nGzKO55vltjTzR4WlO9BtjSgaaYqLQb8c8xF2zxoS/ewAMfl2stczM3FCTPaNNr3U+YubDSBhzNpnaQNggeJDaZ74DORtrvnKSFHhaImL4IbBDApomSSj4vawNDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srOEuYUF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srOEuYUF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF080C4AF0D;
	Fri, 24 Jul 2026 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784894594;
	bh=40cvMlvgwmZriZTlerX6U1ckF3bUC4+tpjdJ8BUKE/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=srOEuYUF5Z/6WYAWFfNFssaqrcYNL7b25DE6EgLNvUGhSm51DiCRxZDftCCXPpPAl
	 qwvgFYspsBTNMOuFhmGIwxC/mPLJsCuxjCmtmyx2rMp/MoZk+fL/M4wNwoi42yPHCN
	 8kEJ/bsXIzKkXpuc1iuC3n4nc9PoWcUeL0bxg55+0eRxuyohLv8UqQal+AqmJUdHt0
	 EYoCWa0MySA7MMyg2JS1dBJdsI9oQN6M7coSJpsmM+ayEIOHct6BEkwSa68g7d28ZY
	 k7LAyCaCiql5BhVeXJ3LOjvXVob+gt1MP/4NOiGLO4VAmKuQQrSTSlLa8jwMkEQiGH
	 hQ11CPv47wuGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E37C53216;
	Fri, 24 Jul 2026 12:03:13 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 24 Jul 2026 13:03:14 +0100
Subject: [PATCH v2 4/6] dt-bindings: iio: dac: ad5696: extend device
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ad5686-extend-dev-support-v2-4-cfc2b30ce988@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784894592; l=1287;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=63m1LwLWVeApaoTgcE/eNkXUbzs9WDM/QX6+A1pEnRM=;
 b=dMwYoTNaaVtwfZfGUbmtrZbjssG+7EMmIBgDhujc456oaGr7NZaVGCAXPaNqosSKndyFzqj8X
 jKNlXQ8bpPlBys41tTQzEwxzSgOVV9j6ECCYyYK66IU4unCpnipaqGP
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add support for AD5316R, AD5675 and AD5697R. These devices have different
bit resolutions or different number of channels so no fallback compatibles
are used.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index 5a93edc976f0..835fa21c474e 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -16,10 +16,12 @@ properties:
   compatible:
     enum:
       - adi,ad5311r
+      - adi,ad5316r
       - adi,ad5337r
       - adi,ad5338r
       - adi,ad5671r
       - adi,ad5673r
+      - adi,ad5675
       - adi,ad5675r
       - adi,ad5677r
       - adi,ad5691r
@@ -31,6 +33,7 @@ properties:
       - adi,ad5695r
       - adi,ad5696
       - adi,ad5696r
+      - adi,ad5697r
 
   reg:
     maxItems: 1
@@ -86,6 +89,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - adi,ad5675
               - adi,ad5693
               - adi,ad5694
               - adi,ad5696

-- 
2.43.0


