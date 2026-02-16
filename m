Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1A3191BF;
	Mon, 16 Feb 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254152; cv=none; b=JyPJuEUGN3fk8VPw3i5j8DzT8pZk/LmiU0iscDqIhojvgVirqQc9oGIccIkgsoGEfM7S5CsqqIO+763tP/6zUot0EO3OY04VzEMzt4D7hnfvQwl1PNzIAtAtZgJWLJIyvWTJQ1i5gFA9Jz6VlByxc2/leWArlj4+I7gn8tn43UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254152; c=relaxed/simple;
	bh=U1lEfjI+z1Avgj2/tKUt7srl6TH1jOcXtS/244eTisA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PPPnLM41L6dqmMMjIZFpLfmJ6Bfgmojixa8xgmVxH8kSI94JJ/tLDqhNrYtyjzFNvqbOYmeDi3uCVca0ojMub6/r1uHNc9uxo2P/2BTlmU51R4W8Y/ZpdtoNRrqxZSufWxjp5a+3VKBnxffxhexKCE33iCIDV8Gvh2TwqELFLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOfMMph/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOfMMph/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2605BC116C6;
	Mon, 16 Feb 2026 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771254152;
	bh=U1lEfjI+z1Avgj2/tKUt7srl6TH1jOcXtS/244eTisA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FOfMMph/MpEYak99/f18Rs78wjDoSqu0J1IspD9aKpfnt4jtgjyG0O4skn1zpwMIU
	 RSW9Bjg3wMviiexajpgLOVXLq+c5Ypx95piPw23AhjO2ipm4q/26U9ph7nfrVU8mxc
	 z2uOKNLlxjk2j6fIXFgoJO/bg6aMYo360YcerpMrntsDJTTCgRizp0ySAuuOUHoQ1k
	 s/oPETV89LgZRLe1EaTvVWw9q8lbvj7MdZuo8zfIoZQdzdBlGzjCxj9Bm0X3xoCy50
	 p2KrNMoJBRbGMMIVZ03kP8jhEWC6SyWGCfh9Dm1U0s9TTXSMj2FedD7q+mYGomEuic
	 O2IlcAzNPbVzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1564E81A2F;
	Mon, 16 Feb 2026 15:02:31 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v7 0/8] ADF41513/ADF41510 PLL frequency synthesizers
Date: Mon, 16 Feb 2026 15:02:15 +0000
Message-Id: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHcxk2kC/33Q0UrFMAwG4Fc59NpKk25t55XvIV5kTXpOQc+kk
 6Ec9u52A3Gy6eUfki8hNzVKyTKqh9NNFZnymIdrDf7upOKFrmfRmWtWaLAFAKOJUwMtWJ3zoLn
 kSYomihTIp2CCqDr5ViTlj1V9eq75ksf3oXyuSyZYqv97E2ijkVPoxSSOTh7pSi/D+T4Or2oBJ
 /xBELpjBCvSC3YULLe+szvEfiPOgAnHiF0usQzWA0lqwg5pNgi4Y6SpCPe9Z+cDIvgd0m4QtMd
 Iu/4kSgAkZKYd4jaI/eOxriIxNQ5tV/v6+AuZ5/kL3s7b9RACAAA=
X-Change-ID: 20251110-adf41513-iio-driver-aaca8a7f808e
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771254149; l=4379;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=U1lEfjI+z1Avgj2/tKUt7srl6TH1jOcXtS/244eTisA=;
 b=t+H06vNT/wXjrrPVwzezii81kDmoZMdlDfHD6g/VMLUh1wtkCJ4FjmsXMcM/M1trwDzBI0Lha
 6PhsnEMwfTCD31/nE/8293B/Uy5kRnH40QeejT1RMU63/fS7oZF7gjL
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series adds support for the Analog Devices ADF41513 and ADF41510
ultralow noise PLL frequency synthesizers. These devices are designed for
implementing local oscillators (LOs) in high-frequency applications.
The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
operates from 1 GHz to 10 GHz.

Key features supported by this driver:
- Integer-N and fractional-N operation modes
- High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
- 25-bit fixed modulus or 49-bit variable modulus fractional modes
- Digital lock detect functionality
- Phase resync capability for consistent output phase
- Load Enable vs Reference signal syncronization

The series includes:
1. PLL driver implementation
2. Device tree bindings documentation
3. IIO ABI documentation

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v7:
- Addressed minor suggestions.
- frequency_resolution ABI for AD4350 removed in favor of generic one.
- Link to v6: https://lore.kernel.org/r/20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com

Changes in v6:
- Drop usage of simple_strtoull().
- Implement better overflow checks with iio_safe_strntou64().
- Link to v5: https://lore.kernel.org/r/20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com

Changes in v5:
- Drop local parsing of 64-bit plus fractional parts
- Add iio_str_to_fixpoint64() to iio core with parsing tests
- Add DT property dependency for adi,charge-pump-resistor-ohms
- Add local definition for ADF41513_HZ_PER_GHZ and drop units.h patch
- Link to v4: https://lore.kernel.org/r/20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com

Changes in v4:
- Proper usage of units.h macros
- Simplifications to DT property parsing
- Adjustments to return value handling
- Drop of simple DT property node example
- Link to v3: https://lore.kernel.org/r/20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com

Changes in v3:
- Use FIELD_MODIFY macro in driver implementation
- Drop refin_frequency iio attribute
- Drop muxout-select property from dt-bindings (and rename logic-level property)
- Use -mhz suffix in power-up frequency property
- Address documentation issues
- Link to v2: https://lore.kernel.org/r/20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com

Changes in v2:
- separate driver implementation from extra features and improve commit messages
- use macros from units.h
- explanation of custom parse function: adf41513_parse_uhz
- reorganize driver data structures
- drop clock framework support for now
- reorganize documentation
- Link to v1: https://lore.kernel.org/r/20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com

---
Rodrigo Alencar (8):
      dt-bindings: iio: frequency: add adf41513
      iio: core: add fixed point parsing with 64-bit parts
      iio: test: add kunit test for fixed-point parsing
      iio: frequency: adf41513: driver implementation
      iio: frequency: adf41513: handle LE synchronization feature
      iio: frequency: adf41513: features on frequency change
      docs: iio: add documentation for adf41513 driver
      Documentation: ABI: testing: add common ABI file for iio/frequency

 Documentation/ABI/testing/sysfs-bus-iio-frequency  |   11 +
 .../ABI/testing/sysfs-bus-iio-frequency-adf4350    |   10 -
 .../bindings/iio/frequency/adi,adf41513.yaml       |  215 ++++
 Documentation/iio/adf41513.rst                     |  199 ++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf41513.c                   | 1240 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |  211 +++-
 drivers/iio/test/Kconfig                           |   12 +
 drivers/iio/test/Makefile                          |    1 +
 drivers/iio/test/iio-test-fixpoint-parse.c         |  470 ++++++++
 include/linux/iio/iio.h                            |    2 +
 14 files changed, 2333 insertions(+), 60 deletions(-)
---
base-commit: cce8de7f9744a210a4441ca8a667a9950515eea7
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


