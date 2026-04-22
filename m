Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247823E33D;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869184; cv=none; b=dly8RE9EQh+eGo8wLdDGK3fizcx9VZtNBcqpGmR+6ezN5P4cdq4IW0OOFSQIkDkksXKNR3WIlhGWHJCG2sWcvhnmC1Eilis5kvftqGAW6eZ6/RP4sif+FhM+FLdQtB5p3Ae1gGfKakEYaosJDEsv03D4ckObhCqqxN55VXJlEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869184; c=relaxed/simple;
	bh=KW9LBaKsAszNIdyDF3YPDVS0lfnwke+MlHzKoxh0iUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ng4BGm+Y/75Y/lIv5GaM6GD/XD/pwFP7ARw/IKph/XDtY71qOnHNWu8kKjbj1aY5wtYEoOdGU38fYh311TpvN2S5WKkcxRqI0MT1GhotbZRcl8wp3sCUjUmXd9ZRqXdk7zXI2PzQ3vuNnmbKyoTNjsHtHrMoMZoCA340GCTqtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyj2e+Rb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyj2e+Rb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D178BC2BCB4;
	Wed, 22 Apr 2026 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869183;
	bh=KW9LBaKsAszNIdyDF3YPDVS0lfnwke+MlHzKoxh0iUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cyj2e+RbqwoMiA+2LJiDv5GP6UPSc+ogjutnXbWbI5+Yu8BVAQHFr17rRsGbZ3h91
	 e2IWZdPwXG4Jm/joU9kr1bAn8eb7nKs65kO7SRxVPIBCuKLU7TW98SgkPuezAFE7n9
	 CweYB5X/bsnXCmcloC+W0oRJo2lOLnHhgs6aLcwtUB3FRHLeBSZUnEai1fsqzCO4v+
	 EMJ/yRqGnP/dyb0K4Jt/aIH0WvcYdgL/ohEzHJ3RH6nSr9resDCILLPPgr5FKhlweY
	 DPkFmt5X+CUeYPdpTJ3d2+AD3xDAmPJkfMQSOFkmsOQLNM6fFI+LhFlkN9RKJ54UAu
	 qPEVebzKfYB8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C252AF9EDED;
	Wed, 22 Apr 2026 14:46:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:35 +0100
Subject: [PATCH 01/22] dt-bindings: iio: dac: ad5696: extend device support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-1-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=1192;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=El1N/55Vq+qsAn09ahJqnZZZn0tChOeJyXjS3wCOfPE=;
 b=TqIPGOd3GrgXveavFWj7EsXu+bwU+jXRUWXdLzoMfkv5QNMfFP/RyLpWWDPK69vcKt5oxlaMd
 TJ0F1yb86WPCVgYe+iZgoginWn4D0G+/X7jUkDBMvIjVPbbiV6PPja8
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Support for AD5316R, AD5673R, AD5675, AD5677R and AD5697R missing from the
device-tree bindings documentation. These devices have different bit
resolutions or different number of channels so no fallback compatibles
are used.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index b5a88b03dc2f..ed79323bfc93 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -16,10 +16,14 @@ properties:
   compatible:
     enum:
       - adi,ad5311r
+      - adi,ad5316r
       - adi,ad5337r
       - adi,ad5338r
       - adi,ad5671r
+      - adi,ad5673r
+      - adi,ad5675
       - adi,ad5675r
+      - adi,ad5677r
       - adi,ad5691r
       - adi,ad5692r
       - adi,ad5693
@@ -29,6 +33,7 @@ properties:
       - adi,ad5695r
       - adi,ad5696
       - adi,ad5696r
+      - adi,ad5697r
 
   reg:
     maxItems: 1

-- 
2.43.0


