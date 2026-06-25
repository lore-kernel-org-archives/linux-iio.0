Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61BD2DAFA9;
	Thu, 25 Jun 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390312; cv=none; b=qKwQANrJEL/DGZo8txlV8vF10wvAPzSmXzcs21Phh94QDE3BDFoWxuyeXb3uoRAsJ/GgyRbrdx5bXMk2viu37bW//CVrGAiJu8ZRQ12Z5gidyzykGkXIRwegntj8VGeLtRX43NRfDTfzH+TYSETmjm4MBIDfDthcbB+gduNXThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390312; c=relaxed/simple;
	bh=6rma1kTZbSPPl/oep7CF0HWuRcH1fnVvL/CiMdexe64=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b1bVuCBJC3EntQIb9zG+DIHcHF4LIiaSv20oPlgIuLQRRxUEVJf5pM1GC2kY21EnSh6qSzI+In9JFk2mb5Vp79wy4+A5QrzQoeJ3BdMVbB3m6zYQpjk7n6E1dAltvV/rOLDMMc4hbLBufe0XV27ndxMpgrsYZNBG6Gq1+aVpU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTH5MVMk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTH5MVMk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3806EC2BCB3;
	Thu, 25 Jun 2026 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782390312;
	bh=6rma1kTZbSPPl/oep7CF0HWuRcH1fnVvL/CiMdexe64=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uTH5MVMk/1VlVSqBoarOvQkzGg5Mcr7ysvcw2Oyrk100+hx2DyQRzgQazcZpA7dBB
	 hyEflTITtZyx+ikO/nfL6f50RxE0h/MND9TueYrZu7BXHbzwrRivuzgzTSb8a/1Qg+
	 k94L3ceuEcgofbVThYWx1R+VFg/9KWwerb08kYDtfihN8Lajv9vK4Oj88klckZS863
	 uDRO5Jo9X4WbzME1AEqjX0f3b7IXI5Uzj3bA1eX3DZLEJUZYZZhV2GV4NxRXsScOil
	 Ql+a9/gdUIRffI1jtpTwqv27GuLDmSE7RPR1TNEidqcvRUlLcIAWqMRu52XnHEQ8Lz
	 Rf3ooyNvpAKZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAEECDE001;
	Thu, 25 Jun 2026 12:25:12 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v4 0/2] iio: imu: inv_icm42600: add hwfifo watermark
 attributes
Date: Thu, 25 Jun 2026 14:24:51 +0200
Message-Id: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-0-8b4c8bfa96d7@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABMePWoC/52OwU7EIBRFf2XC2mceFLB15X8YYyg87NNMa4CiZ
 tJ/l44x6nJcnuTmnHsSmRJTFreHk0hUOfMyN9BXB+EnNz8RcGgsFCqLVinguQL7o26I4EKAcY2
 REkxvkePy6EpJPK6FMjhPAbU01Gkpmu81UeT3c+v+4YvzOj6TL3tgX0ycy5I+zmeq3Hff3e6Cb
 pUgIcgBe0SyGOiuhJdrvxzFXq3qt1df4lXNK5W9McoMZPv+r7f7t7cDBBMGp721Khr88W7b9gn
 b6OgnogEAAA==
X-Change-ID: 20260622-inv-icm42600-add-buffer-hwfifo_attributes-aced0415e341
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782390310; l=2106;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=6rma1kTZbSPPl/oep7CF0HWuRcH1fnVvL/CiMdexe64=;
 b=PSZoOvlVZvLa5HUvoc4JN/BJQ4uf8xxzAcFA5yb0drcyRdSGq9TAiF0k28zHPLuzPWrxAbF/c
 XRTyhT4U9w9BTcWnnIwpLu2D3Dg5H0y+oTCWNHkdfmPx65/nilloC12
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

Add hwfifo_watermark_* buffer attributes.

There is a preliminary patch for reordering includes first.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v4:
- Rework headers fix to just reorder includes but for all driver
  sources.
- Link to v3: https://patch.msgid.link/20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-0-5d9a4c662f50@tdk.com

Changes in v3:
- Add a preparatory patch for reordering includes.
- Use IIO_DEVICE_ATTR_RO.
- Link to v2: https://patch.msgid.link/20260624-inv-icm42600-add-buffer-hwfifo_attributes-v2-1-12675259e688@tdk.com

Changes in v2:
- Delete trailing comma after NULL terminator
- Link to v1: https://patch.msgid.link/20260623-inv-icm42600-add-buffer-hwfifo_attributes-v1-1-d190800e60de@tdk.com

To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: reorder all driver headers
      iio: imu: inv_icm42600: add buffer hwfifo watermark attributes

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        | 10 +++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 18 +++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 43 ++++++++++++++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  3 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 12 +++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 16 ++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |  8 ++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |  8 ++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |  3 +-
 9 files changed, 84 insertions(+), 37 deletions(-)
---
base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
change-id: 20260622-inv-icm42600-add-buffer-hwfifo_attributes-aced0415e341

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


