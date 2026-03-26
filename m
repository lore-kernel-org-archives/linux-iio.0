Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACE39FCAC;
	Thu, 26 Mar 2026 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549943; cv=none; b=tSoE5l+LpvzylgBcx1uDDI7GzvnakxKvjN4uNLrEvyCz/mT1KUGAUZnb6M4hEGAX1jZkgRnYnigZul8jrfN86IjE1QSDbZ74TCxTjBgGgp3vjnFY6+EM6GoPEM2e6njQkTJl/3V1ZWiRM4drgkyK1NUn4cF4ineuzYrtCqHbjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549943; c=relaxed/simple;
	bh=CzsFZIJiKMsLWlfT0H5N9wCIpe9LumoDaQPCrhbfnfI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A+klh7wY2VsLMv8+HMAR9lEamaWQ64QX1CYznRfj0AtipVwe/CFZcGMk0uL0ACPSzCZ/ZKKUVYGapuxG69voEZQOcgg6QcgAaK9oWRKiOINjcCveJ1Hmz8OUeIen8vzMvTRSAPhoVXZJIJAGSGImRkXNoNPK7zEW6cVmKmNY6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkI7yvsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkI7yvsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23C81C116C6;
	Thu, 26 Mar 2026 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549943;
	bh=CzsFZIJiKMsLWlfT0H5N9wCIpe9LumoDaQPCrhbfnfI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XkI7yvsQQp9pk4i9aTqXbp7iRnWawmQ56KO6+yiJb2nlaEGMc/Rw3C65LyPKRZ6P9
	 ArhR9U7kAXTNMaskuDgtNQRiKbJ0y/lX3aUADJHfoTJkHWsMFxLFy4Gr21NYSxDNBD
	 jBx6cTWfoCxw4vVhWHhO+LTYbpQKRoQwruXZ1J8fx4rHlMetsGqU28mDmjnCE8qJL7
	 b+Xvfqv+OUw2xO456Kvjjfk+06v3qqFZRGWsh1wuZEF4RU3h4cKU2vv4KnY5e7IXD/
	 9ucz7QBpshHEzaEYjWvwLXS2pkqErX1ZAuRRj12Yd74Kj6/OqBFqqKoe9mRV0AlY26
	 EbAEZjOz8hgwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1094810A3D96;
	Thu, 26 Mar 2026 18:32:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v2 0/2] ADRF5702/ADRF5703 Digital Attenuator support
Date: Thu, 26 Mar 2026 18:32:15 +0000
Message-Id: <20260326-adrf570x-iio-support-v2-0-b622a17335d0@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK97xWkC/4WNQQ6CMBBFr0Jm7Zi2UgRX3sOwKDCFSZQ2LRIM6
 d2tXMDle8l/f4dIgSnCrdgh0MqR3ZxBnQroJzOPhDxkBiVUJS5KoxmC1VexIbPD+PbehQVJNk0
 pa9uZUkCe+kCWtyP7aDNPHBcXPsfLKn/2T3CVKLAxqqo1dYq0vpvZPN147t0L2pTSF8ftO6G5A
 AAA
X-Change-ID: 20260325-adrf570x-iio-support-e199418fba40
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774549942; l=986;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=CzsFZIJiKMsLWlfT0H5N9wCIpe9LumoDaQPCrhbfnfI=;
 b=TuNHdp+ljawlKp6O97s1DzuisbOEEDdcextDE34p8Mt70LsrYQpTHXumNirEjUzRJvPrvTbP7
 DERO2VcEXyGD1oxR8My5XngtUgyqr9XJth0tYG8MOZwhwIIsbiNOFdr
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This is a small patch series that adds support for two extra attenuators.
Basically, new chip info and device table entries are added into the
AD8366 IIO driver.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v2:
- Add more context to the dt-bindings commit message.
- Link to v1: https://lore.kernel.org/r/20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com

---
Rodrigo Alencar (2):
      dt-bindings: iio: amplifiers: ad8366: add adrf5702/3 support
      iio: amplifiers: ad8366: add support for adrf5702/3

 .../bindings/iio/amplifiers/adi,ad8366.yaml        |  4 ++++
 drivers/iio/amplifiers/Kconfig                     |  2 ++
 drivers/iio/amplifiers/ad8366.c                    | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+)
---
base-commit: af980a79bfed43c4a0be12cca786be46f1a0c5e8
change-id: 20260325-adrf570x-iio-support-e199418fba40

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


