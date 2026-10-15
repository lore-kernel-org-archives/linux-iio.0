Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D883E5577;
	Thu, 15 Oct 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082995; cv=none; b=aAlaBIqiZtR0SknRrIJguMdINrnPO/eXLUZjsytWu4U0Qo0FnXYBWR8wLLXpIBHRR/1QCQx7kd2UE8j7Gp4Wo4qIiJXrwfvUcfT6DhDP/EUw608819VktZ2CcNi0A1a4h+q3FkoNY7MFlcaBtePvQegbEm6WaEII2ofvtpyjvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082995; c=relaxed/simple;
	bh=0+HWhSkCpghkOfm79SliF6p8qXrll7DuCOm1mvzp4Gs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=otG5XLbnRnyEHjptWOI5qbzs2F66QiOlkM7qjUVbcVsWG1ayW7wIRTeYTdY5s5IYlILprM9h6WwKAxPPG/ylX8L8gaFy4rhA9eF0ngw4roSxtbmYYM5hNh1i7/dIEnMEFVjPd/NQ+rQNIct7TUmTydzv0vmCYTa2YiS0y24/xVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONJIZ6OF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONJIZ6OF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2F02C2BCC7;
	Thu, 15 Oct 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792082994;
	bh=0+HWhSkCpghkOfm79SliF6p8qXrll7DuCOm1mvzp4Gs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ONJIZ6OFHVHLdS44JZbhblC41vVSux7wQRY57ig9bxlLSz6IIW2LySqePDbe+aps4
	 SLpwwEKJDkMrdTisaYkRO4aF1oZO/rYauV44v9Sr7n96zJgGUOdB6xPLEWTbuhydpx
	 KYjIKOyg08LNAAERGTCBqD9QkEFd2Dx3pqsYKBSDIYyiHNZgmmSF4cy9KFWhweoyTp
	 mRqp8UzYQQXLi96ENjx4tSi5anzAV/5x0Jk4e/mFyPTKf9k2DKuRe2eo3Nq3ED7hzQ
	 sUMmPSmlLhwUzk4hDGhYfWLVjSFJnpPnWADc390PUmvIVZgfSFY5uUi9n86wfr2Ga+
	 SlMGLjiikUKVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A6CC6B33;
	Thu, 15 Oct 2026 16:49:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH 00/10] iio: frequency: ad9910: add IIO backend support
Date: Thu, 15 Oct 2026 13:49:40 -0300
Message-Id: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQE0WoC/yXMQQrCMBBA0auUWTswaYMhXkVcpMmoo5CGTCtC6
 d0b6/It/l9BuQorXLoVKn9EZcoN5tRBfIb8YJTUDD31Z/IDYUjeG8IxxDfnhLqUMtUZjQvWJeO
 sHQhaXCrf5XuMr7e/dRlfHOffDbZtByM6BTB6AAAA
X-Change-ID: 20260930-ad9910-backend-support-17a47d174430
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792082993; l=2640;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=0+HWhSkCpghkOfm79SliF6p8qXrll7DuCOm1mvzp4Gs=;
 b=ymNJ8Ey19sr74mQ8L7kQqU2ubD3ozWIDgnC/+dBWV+57liYowKul7/gFlZbvMUrMXQ2QsRMGg
 h7G4N+upt/VAZ9nV8P1TafnbbkyVfKnoFfVkNAaM+UDSyDtwO4l3pAx
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This series extends the AD9910 DDS driver with support for an IIO backend,
enabling data streaming through the parallel data port, and with control of
the DRCTL pin, which defines the slope direction of the digital ramp
generator (DRG).

The parallel data port allows modulation of the DDS core parameters
(amplitude, phase, frequency or polar) at up to the PDCLK rate, which is
SYSCLK / 4. Such data rates require an FPGA IP core as the data source, so
an AXI backend driver is added for the AD9910 HDL reference design. Besides
streaming data from memory via DMA, the IP core also drives the PROFILE[2:0]
and DRCTL pins. The latter is exposed as a PWM output, so that the frontend
driver can consume it through the PWM framework without depending on the
backend being present.

The backend is optional: the AD9910 remains functional through the SPI
control interface alone, hence the new devm_iio_backend_get_optional()
helper.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Rodrigo Alencar (10):
      iio: frequency: ad9910: powerdown fix
      iio: backend: add devm_iio_backend_get_optional()
      dt-bindings: iio: frequency: add adi,ad9910-axi-backend
      dt-bindings: iio: frequency: ad9910: add io-backends property
      iio: frequency: ad9910: move channel indexes into a shared header
      iio: frequency: ad9910: add axi backend driver
      iio: frequency: ad9910: support drctl control
      iio: frequency: ad9910: support iio backend
      iio: ABI: add integration_time for output channels
      docs: iio: ad9910: document DRCTL pin control

 Documentation/ABI/testing/sysfs-bus-iio            |  17 +
 .../iio/frequency/adi,ad9910-axi-backend.yaml      |  74 ++++
 .../bindings/iio/frequency/adi,ad9910.yaml         |  38 ++
 Documentation/iio/ad9910.rst                       |  90 ++++-
 MAINTAINERS                                        |   3 +
 drivers/iio/frequency/Kconfig                      |  18 +
 drivers/iio/frequency/Makefile                     |   1 +
 drivers/iio/frequency/ad9910-axi-backend.c         | 396 ++++++++++++++++++++
 drivers/iio/frequency/ad9910.c                     | 402 ++++++++++++++++++---
 drivers/iio/frequency/ad9910.h                     |  44 +++
 drivers/iio/industrialio-backend.c                 |  34 +-
 include/linux/iio/backend.h                        |   2 +
 12 files changed, 1052 insertions(+), 67 deletions(-)
---
base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
change-id: 20260930-ad9910-backend-support-17a47d174430

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


