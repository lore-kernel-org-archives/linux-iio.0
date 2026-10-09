Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E8412BFB;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535416; cv=none; b=YvwFHKuA8CFhcNFKQhkvPNjq1B+cuH8uWB4lQASGafjKEKdha26mYTTt7mRL2JQI6fmivvbs+J2vfRB5Wm3WPJ3ba0C7s6/ZKLvdsP/u81xpkDy0JHOUi//xvHzp2+yhkUW7qIk/tFsgFoe1b1eyvYuVKS61NviNzfM6ELMsX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535416; c=relaxed/simple;
	bh=qPw/W4uGpNR8YtgkZjRtlirnT4ziZSl3ZtAV1Ca3h1Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IfupWUjft+F2ZEVOZo/frRgjqFXuwHXBdYWcNUMGY1Bl5BwndU97MqJnckqvfae2FOs1Q6gsaD99SS0+WdEMPHB06n8YuUL5qMH2QNyrwuow0M4uONeoa38EfMpWovUkvD1mmh5Zvwe5ELJ19/LHl42riLBVcGlPrXdlit6iHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7liUbOP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7liUbOP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53634C2BCF4;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791535415;
	bh=qPw/W4uGpNR8YtgkZjRtlirnT4ziZSl3ZtAV1Ca3h1Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=W7liUbOP6mEloo9aqvA3zjBFX5r8afyg+ugV521p59kcKirF3hQHthSPNa335iwC5
	 kgg7WcDgykjvI7aVR1fNWYMvhqnyahZpAzdisa3DkZ6XOppsOjd9TfdQ5r/vKcQe8m
	 oB1xlfgu8arqUtfoKuymx50SZ6PgHim9AcfncSV3D/rttwO8nxalTATH4c78Trsv21
	 RC5Npo0N+LnPnAgLt9eQEa70FucuSNFcxhpJY9XcMJOPkanCnDqPUTrGkxw8XXtc3J
	 nWOAzu7Bk85cGJSgahEOlSZVpw7J0RB4WjmAY9uLI5WpHPM2lDSWWyX2ia4bGkf4Bx
	 cYJSQHhy/Ru2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C612CA6019;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Subject: [PATCH 0/6] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
Date: Fri, 09 Oct 2026 11:43:33 +0300
Message-Id: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWpyGoC/yXMywrCMBCF4Vcps3YgN4rxVcRFTUYd0TZk0iKUv
 rtTXf6Hw7eCUGUSOHUrVFpYeBo17KGD9BjGOyFnbXDG9daYiDJf3yz7DV8tuRC9TqVMteFi8di
 HEClT8C6DGqXSjT8//3z5twJPSm1HYdu+K87nIYEAAAA=
X-Change-ID: 20261009-submission-ltc2493-support-v1-86449ede432d
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrei Stancovici <andrei.stancovici@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791535413; l=2561;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=qPw/W4uGpNR8YtgkZjRtlirnT4ziZSl3ZtAV1Ca3h1Y=;
 b=d4Cpeh3cVJHo3gedk3mF1UmNKUS4/0bt9xBrR89d1/04EauA5cuIUyKmZQYnXfXchl6LnoofF
 YGwc3s04sYFCT+Eqd3JMmojGSUQdnaAlezA/QbrNzm9OkKAj3Hv5RhG
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com

This series adds LTC2493 support to the ltc2497 driver, and adds FA/FB
line-frequency rejection for the LTC2499 and the LTC2493.

It includes:
- the LTC2493 device-tree binding,
- LTC2493 support in the driver: 4 single-ended inputs or 2 differential
  pairs, 24-bit result, same command format as the LTC2499,
- the LTC2493 internal PTAT temperature channel,
- the LTC2493 2x conversion speed mode, exposed via sampling_frequency,
- FA/FB line-frequency rejection (50Hz, 60Hz, or both) exposed via
  filter_mode, implemented in the core and enabled for the LTC2499,
- the same rejection selection enabled for the LTC2493.

The FA/FB patch also widens the conversion-time budget, because 50Hz-only
rejection takes 163.5 ms at 1x and the previous budget was 150 ms; see
that patch for the details.

Validated on a Raspberry Pi 4 running 7.3.0-rc4, over an IIO network
backend, with a DC1010A-A board (LTC2493) and a DC1012A-A board
(LTC2499):
- LTC2493 voltage channels, single-ended and differential,
- LTC2493 temperature raw/scale/offset, with voltage and temperature
  reads interleaved to confirm no sticky PTAT,
- sampling_frequency 1x/2x switching on the LTC2493,
- filter_mode 50Hz/60Hz/both on both parts, with the conversion time
  honoured in each mode,
- pyadi-iio hardware test suites: 41/41 on the LTC2493, 36/36 on the
  LTC2499.

The series was rebased onto the base commit below after those runs. The
rebase left all four touched files byte-identical, so the code posted
here is the code that was tested.

Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
Andrei Stancovici (6):
      dt-bindings: iio: adc: lltc,ltc2497: add LTC2493 support
      iio: adc: ltc2497: add LTC2493 support
      iio: adc: ltc2497: add LTC2493 internal temperature channel
      iio: adc: ltc2497: add 2x speed mode support for the LTC2493
      iio: adc: ltc2497: add FA/FB line-frequency rejection selection
      iio: adc: ltc2497: enable line-frequency rejection on LTC2493

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   7 +
 drivers/iio/adc/ltc2497-core.c                     | 199 +++++++++++++++++----
 drivers/iio/adc/ltc2497.c                          |  61 +++++--
 drivers/iio/adc/ltc2497.h                          |  45 ++++-
 4 files changed, 251 insertions(+), 61 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261009-submission-ltc2493-support-v1-86449ede432d

Best regards,
--  
Andrei Stancovici <andrei.stancovici@analog.com>


