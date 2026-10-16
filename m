Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AD3E5A2F;
	Fri, 16 Oct 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161799; cv=none; b=bTq4O+xSDv3PKdPih+KX80BrlaoDMFsyR4TuwXgvpL/jl4Uv5PCTrhxd3qsWfrr3gSfYkLFclbqCvnZto2wpf3gRKIFBi3YeznqeLMiX5nPqdPEPBTmuRuu1n/xgdY6hZAVIDG1DmY6NldYbB67thu2AOPq+XhoLFAd9b4KBmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161799; c=relaxed/simple;
	bh=1C6B2LAxwaDGHH48Cp/KJeQFaSPCuZIy6PCyCxXkAHY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lnn1MkIUrJAGUPFmBBUDrb7IA4GxCNl5msjprGoL0aU2RhvNUS1iiMqp6uDW+6zdgxZkSMRElliqvMUYkKJGDjTF9HzsaWsPKtbL2HP+dKpNhxn0jIUbI5e6JULshhdinPKox8WMqWf3O/1ykauAmWsEPzsXtGsn7uxrHRBxAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 4110F40049;
	Fri, 16 Oct 2026 16:43:15 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Subject: [PATCH 0/3] from my MSM8916-mainline:
Date: Fri, 16 Oct 2026 16:43:05 +0200
Message-Id: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPk30moC/yXMQQ6DIBBA0auQWXcSQGXhVUwXgFOcplECaEyMd
 xft8i3+PyBTYsrQiwMSbZx5mSvUS4Cf7BwIeawGLbVRUhlkXvDHYSoYorZRSo3GjV3XWPKudVD
 DmOjD+zMd3n/n1X3Jl/sE53kBfGzCtXYAAAA=
X-Change-ID: 20261016-iio-light-gp2ap002-6bd553aecb4b
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Christoph Rudorff <chris@rudorff.com>
X-Mailer: b4 0.16.0

Samsung J5 is equipped with GP2AP002 proximity sensor.
Unfortunally the driver wasn't working, no irq received.

We missed to power up the LED.

Now it works.

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
Christoph Rudorff (3):
      iio: light: gp2ap002: add led power supply
      iio: light: Update DT bindings for GP2AP002
      arm64: dts: qcom: msm8916-samsung-j5: Add proximity sensor

 .../bindings/iio/light/sharp,gp2ap002.yaml         |  3 ++
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 19 ++++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    | 40 ++++++++++++++++++++++
 drivers/iio/light/gp2ap002.c                       | 28 +++++++++++++--
 4 files changed, 87 insertions(+), 3 deletions(-)
---
base-commit: a2de78ee6ed8bf8cd99d177c74865a6e8c3cb6ea
change-id: 20261016-iio-light-gp2ap002-6bd553aecb4b

Best regards,
--  
Christoph Rudorff <chris@rudorff.com>

