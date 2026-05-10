Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAF91DC985;
	Sun, 10 May 2026 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436592; cv=none; b=gTmFSeeir4+0nqS1bVAIlpNjzfDsqo3jBqMiP0ozLl/q/tYhlOW7NyEz/Yi6iyN51XQIfLOZbZYzAIbhi40K8ml4ZTexG0r7Izf873LlPQUQDdJvxRUbj7KWjM3qF0JR0OfJ37BSH2SdU3ZDSjc+YODHY8elWkEkpRX8kNKhBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436592; c=relaxed/simple;
	bh=sO5H5/4GTewuYdeypxz3gvRPdcqIT9yN7wjzCLN20jw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WCSwfCwydP0Jukk+Ufcs2GA2G03BKrLSVN+ekZ30by0OFkT2nKaD53YIIEXqrV85dNLe18pTenS9/s/wOuF/t/9bydlUlaLru1vU37wnuOviJEXqKGx2LfflVCns89VLPLBlNfoL8wNMbYyIsmNUtGDZ4GwrH/y8X/GgeI1GesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlEkniUB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlEkniUB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A34F9C2BCB8;
	Sun, 10 May 2026 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778436591;
	bh=sO5H5/4GTewuYdeypxz3gvRPdcqIT9yN7wjzCLN20jw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IlEkniUBsa0FlCu+2f/oYOUhA4QqE/k+vV1D05OEhfeYhCJiH8XD358AJPfbLsJHK
	 i6Jk6mfrsHYi2KfH78Rdi3y8E8QfzCWv+pKGsRe3kwqUEs8FGaW2d712r6+jltcb6k
	 dlOwSZM4ecP9/yQhN4GaEEB63vwS5ZY1Jd+ZlFrtHDCjpssY2OgQ5AgXK9gwDzxmbn
	 e+73svNc3SqDzwygTJvRPg8XcYSzC6IFjeCWgmEdUXuSHHmRKUYRCJwepOu0zX0B+m
	 E4ZPyYyaRBBL5PFMN5ip6vd23TesUDg1k3EqSWPtm2lOcAiivaQeJ5Av7F4kjKOoLI
	 wt9duOSmxghwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9EBCD37B9;
	Sun, 10 May 2026 18:09:51 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org>
Subject: [PATCH 0/2] iio: light: Add ROHM BH1730FVC ambient light sensor
 driver
Date: Mon, 11 May 2026 01:09:48 +0700
Message-Id: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0ND3aQMQ3NjA13DVGMDo8TklESTNAsloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0ATs9lY2oAAAA=
X-Change-ID: 20260511-bh1730-1e302acda4f8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandre Hamamdjian <azkali.limited@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778436589; l=893;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=sO5H5/4GTewuYdeypxz3gvRPdcqIT9yN7wjzCLN20jw=;
 b=BJWxJxe+zIelIrHIX4g6mTxIbq/y8NB14mgZF1iBJYaXrIEgMBrZbKHS78BePuOsfVB3D/zEa
 IY6p1kT98CTAGHMoY313GgHlh1PP3gpkjCsUvWrqq6IyeVB5NacNdYm
X-Developer-Key: i=azkali.limited@gmail.com; a=ed25519;
 pk=I0Z0IdCdQJqNGX+FQUnXhrHg950u3cM6Xzz3YT6JOyQ=
X-Endpoint-Received: by B4 Relay for azkali.limited@gmail.com/20260510 with
 auth_id=774
X-Original-From: Alexandre Hamamdjian <azkali.limited@gmail.com>
Reply-To: azkali.limited@gmail.com

Add a driver and devicetree binding for the ROHM BH1730FVC ambient
light sensor. This sensor is found on the Nintendo Switch console,
where it is used by the system for automatic display brightness
adjustment.

Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
---
CTCaer (2):
      dt-bindings: iio: light: Add ROHM BH1730FVC binding
      iio: light: bh1730: Add bh1730 light sensor driver

 .../bindings/iio/light/rohm,bh1730fvc.yaml         |  95 +++
 drivers/iio/light/Kconfig                          |   9 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/bh1730.c                         | 686 +++++++++++++++++++++
 4 files changed, 791 insertions(+)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260511-bh1730-1e302acda4f8

Best regards,
--  
Alexandre Hamamdjian <azkali.limited@gmail.com>


