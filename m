Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540753E008A;
	Mon, 18 May 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090641; cv=none; b=inhWCqRTG6oUTUr96tozjO5pzuRExT/WT6FfravrqsQ1+h8USrtlwt/JA5RkH9LAYpa5dc3mAEIBU5fQi9ho9qDdCu8jFfkUWlBUOZeZ9X7cNJsbMv3q5/HvLgtlDJHG8qIZkze8AX3+jyhGHqRc2ShdummF0y/uObQEmbKxNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090641; c=relaxed/simple;
	bh=9r6bhk4YQR00tc+vjSEInvVhw9xaep8l04WJlB0u9pI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AeEdkb7QCWIcl2gyebhI3Tz6rAAJyBaoF8lYLmy4qZTmcOB4TqUwpQr/zrqR1hIoPGii0E7oIf8yvW1Le1uojJYg9WPOSgBr29vjgcKLVzB0EGzANjbmiEVfLDIaWIreBviDyOtwiOgMC/myM6y0EFa3GYg4IEegYmZSxzObpec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxqGIKAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxqGIKAD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F27D6C2BCC9;
	Mon, 18 May 2026 07:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779090640;
	bh=9r6bhk4YQR00tc+vjSEInvVhw9xaep8l04WJlB0u9pI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hxqGIKADNE66xj2ffhM8tIR3knH62Atqno9GEXoji44C2j2xJnm7hGhsc9e8zv/oo
	 YIIT7UaBCgB0nCnEVzlQ/LtHHqqPBT225YPUyZkqmBfJkEhsLeK2NqWoPQKx4V37bz
	 0CmjgdhTj52/HcwmXgEG2k7ZQ/QgU5kKBJTuq8PTG/DDQJNrAImuUefEniZJfyhFoe
	 evH5grHwTfTkNN/4zWbcnxtjc/pZwJk444Dz4Ea1lRcxjQm87fbWwtJL+JVXKyuqTi
	 LPb53fGpMQon2nzGzJ6/qztlQNOZkTH05RUYlUkehMuXrPWrciIWmqenPS/WLvgN6N
	 NhKOTzT1KugtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F08CD4F49;
	Mon, 18 May 2026 07:50:39 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v8 0/5] iio: magnetometer: ak8975: driver cleanup
Date: Mon, 18 May 2026 09:50:24 +0200
Message-Id: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMDECmoC/43NQQ7CIBCF4as0rMVAawFdeQ/jgsLQEqUQqETT9
 O7SrrrT5f8y+WZGCaKFhC7VjCJkm6wfS4hDhdQgxx6w1aVRTWpGWsKxk/0Ik3cwQcTGviHh4NO
 Eg1WPV8CKadlpzZhpT6ggIcJ2VIzbvfRg0+TjZ/uX6br+TWeKCW64qLmSTJiuufZO2udReYdWO
 vMdR+lPjhfurM+UGClr0bE9tyzLF0T5kVwbAQAA
X-Change-ID: 20260507-magnetometer-fixes-post-pickup-c6dabdd66f54
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779090640; l=1625;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=9r6bhk4YQR00tc+vjSEInvVhw9xaep8l04WJlB0u9pI=;
 b=+KPRGUYzkQ3EgazGq7dx5RK0I+sYVATzNH7+nOWfpCHa9SQpLAOfOR6NDzO5950SmJ7m3Mn3P
 8m61GyDZD+DCKrqnFNJ+qmqELPE+fH/vw1AiUuRy5PaV/jarPlXLx36
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

This series is a continuation of the previous ak8975 driver cleanup
effort, as most of the patches were picked.

Changes include:
- using BIT() and GENMASK() macros
- moving to devm_* resource management
- adding a scan index enum
- moving from using wait loops to iopoll functions
- various code style changes

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v8:
- Code style changes
- Resent after existing issues with the driver were fixed in separate
  patches
- Link to v7: https://lore.kernel.org/r/20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com

Changes in v7:
- Changed revision to v7 as series is a continuation of previous series
- Added Nuno's Reviewed-by tag
- PATCH 3: change order of pm_runtime initialization
- Link to v6: https://lore.kernel.org/r/20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com

---
Andy Shevchenko (4):
      iio: magnetometer: ak8975: switch to using managed resources
      iio: magnetometer: ak8975: unify messages with help of dev_err_probe()
      iio: magnetometer: ak8975: use temporary variable for struct device
      iio: magnetometer: ak8975: make use of the macros from bits.h

Joshua Crofts (1):
      iio: magnetometer: ak8975: add scan mask index enum

 drivers/iio/magnetometer/ak8975.c | 208 +++++++++++++++++++-------------------
 1 file changed, 105 insertions(+), 103 deletions(-)
---
base-commit: 8678fb54958893818ddeccd05fea560a4e1fc759
change-id: 20260507-magnetometer-fixes-post-pickup-c6dabdd66f54

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


