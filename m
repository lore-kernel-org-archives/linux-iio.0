Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D276C33F586;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164569; cv=none; b=EZmZ3kv6Josv8RFfsgjkDHifquge8aMI72pL2nZHsb4kz7aswFJ3MPiw7tRBbJCkO73D9m1AgMxX9q2ODnroC1tSESkd0jS+S/7aqNL8Sr96/EmvYzty3pICQBVXFXwcIVzj5DkscH9KTsm6oJTlkB2zXHxq5L2sA6/NF7iJpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164569; c=relaxed/simple;
	bh=gbLkSW4l1FISiUVd0zkqtnIJxWy4VPWhr3yQiYSqkNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GzaCLdqk939HVuBtFfgVG0Wi7QRiw5hor9naMl5EA9YVqRxxfFTb3tQwLpI9czKswcm/Ig6tDdseeKTX/zorErhSuAm4db4KDhRDPXJzOj/lua25GXhEIYU8bL7RZFD5vjsGQuHdD7gv1A04RYDsLyyyqatuETqN1hGDRlu87jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxZj0xoX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxZj0xoX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C3EC2BCB2;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164569;
	bh=gbLkSW4l1FISiUVd0zkqtnIJxWy4VPWhr3yQiYSqkNA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WxZj0xoX0B26ts71BHS4a/rDLfxChqOlVywaMuvT5tis/ZwF40yBRtY4EyS7mQrfZ
	 04MaQ5IlZhGKRFiSiz6+Rbo1HtWe7iVRCWQMCtsfGZS+vo2XtMMQELtFVBC42VIQjP
	 E6Xs5OFi5l+rwWFcHNmfJ0AvjnOZG42VHwnJpnkBrfvV2iQrxmgi6Y5OoZnjgB0KgS
	 NXj/B9Ot9txkWqWYcC4wCX+98yICWuJpoe5KiGXawDbdyfQWQG2fFdOkL1vdXTkyo9
	 hIMIGd9xb11kIouEcrzCpTg04s1JPZGbc6nYi7Ko/NEwCeo8ZVpFzEKbhFWnoOaq6s
	 HI1+CNie1WM7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623F8CD3439;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH 0/8] iio: magnetometer: ak8975: driver cleanup
Date: Thu, 07 May 2026 16:35:49 +0200
Message-Id: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWj/GkC/x3MQQrDIBBG4auEWXfAhsZCr1K6sPonHUpUHFMKk
 rtHsvzg8RopikDpMTQq+IlKih3Xy0D+4+ICltBNoxmtmcydV7dE1LSiovAsfyjnpJWz+O+W2dv
 g3iFYO0836pNccEb98Xzt+wFpEQVYcAAAAA==
X-Change-ID: 20260507-magnetometer-fixes-post-pickup-c6dabdd66f54
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778164567; l=1319;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=gbLkSW4l1FISiUVd0zkqtnIJxWy4VPWhr3yQiYSqkNA=;
 b=SPGwRFy1d/APvdUuHk+jVct1YlcqLZzLFmqSeo7g5pBePTAcgeQfkwssqRBgFlR3CgroR9HvS
 rYpGg3uu5d8DNWiT1H7Ez7NtcDI2ClcAug2EQ2jlMxXmEURdrBki9lD
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
Andy Shevchenko (5):
      iio: magnetometer: ak8975: switch to using managed resources
      iio: magnetometer: ak8975: consistently use 'data' parameter
      iio: magnetometer: ak8975: unify messages with help of dev_err_probe()
      iio: magnetometer: ak8975: use temporary variable for struct device
      iio: magnetometer: ak8975: make use of the macros from bits.h

Joshua Crofts (3):
      iio: magnetometer: ak8975: modernize polling loops with iopoll() macros
      iio: magnetometer: ak8975: check if gpiod read was successful
      iio: magnetometer: ak8975: add scan mask index enum

 drivers/iio/magnetometer/ak8975.c | 268 +++++++++++++++++++-------------------
 1 file changed, 134 insertions(+), 134 deletions(-)
---
base-commit: 74d173f29572951629d1e0b7456b424006e51b87
change-id: 20260507-magnetometer-fixes-post-pickup-c6dabdd66f54

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


