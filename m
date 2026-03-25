Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BEE3A7F61;
	Wed, 25 Mar 2026 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437145; cv=none; b=MtiRjoUwfEiYNDLTZFKdMG6YAAlGLOwv3EJId9EuGzal+FOAY/Omhh0PA+8QSV70IF+7oIFTiv9FN2kkYFeavMOT13vT7WHJASjRSG5Cb6O8kKsmha5XvWNFD158SoYsr5WW4tjCGsdi+eFVPLW8aEvX9qlx/cbQQzQ8hdGgrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437145; c=relaxed/simple;
	bh=6s60KjYjwOw1gKouJIv1rbJ9T2v6rnXR5nRknIdF0GA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GCEKKqiRquScCQpHwv8Uox8ZzRCEt5fwTFbX/bKGYlJaDZ+VN3gMTQah1BoXNCbnDQZaGlAOCim3HMwiaJkY9LHv4A4f07zXGM78T6FEoHuqVhqpnk9BpuRmIfpTx3iTqE7pjYXK2R1vC2bQ/9nNx+IrnkIRn8OX1olgy2faGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK8vWb1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK8vWb1p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D245EC4CEF7;
	Wed, 25 Mar 2026 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774437144;
	bh=6s60KjYjwOw1gKouJIv1rbJ9T2v6rnXR5nRknIdF0GA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kK8vWb1p69BI7KeERRSBDvAYW5L0xziU0go+jmtNUufwvms8AMl8tAq4f70DyQ1HO
	 sS50RQjOXFtSwz2QpFlE8NR2c4sXSd7bMOvYHBgEmfcC8MD410PsrnbH/7P5VqncUZ
	 Cvp8SF8844DKISU78/rEWIPZQhtRZ0WstszbGb6jZNm80RQCVQtOIrAQzjPvvezfs4
	 iAiuHpidY3qypAnJkw8pbs9gmjtVECpJGc8bH1DuGUKcn9yCyVpf/WnnI/c3s4o+qo
	 rZ8ZYk4F6XjfMkDBCxEyqy6snCdnGfOqTJPIR++mBJ478/XFwIijflRFWa5c0sPyJb
	 0qlviIen0u5pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0310FEA83E;
	Wed, 25 Mar 2026 11:12:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH 0/2] ADRF5702/ADRF5703 Digital Attenuator support
Date: Wed, 25 Mar 2026 11:12:01 +0000
Message-Id: <20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHDw2kC/x3MPQqAMAxA4atIZgNt/fcq4lA11Sy2pCqCeHeL4
 ze890AkYYrQZw8IXRzZ7wk6z2De7L4S8pIMRplaFaZCu4irGnUjs8d4huDlQNJdV+rWTbZUkNI
 g5Pj+t8P4vh8P9djDZgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774437143; l=808;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=6s60KjYjwOw1gKouJIv1rbJ9T2v6rnXR5nRknIdF0GA=;
 b=WeuRfH4St3KVL/xuGRUuA2Qs5GkPq1aVPv3shOLplBnzEEx6J6SVYouOOVp1O0u5S6+l6S9NY
 IqP8VuewfihAvZJQkvjMCLINNZAs8klQg8/T/tohFachBrVXVtifHHt
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


