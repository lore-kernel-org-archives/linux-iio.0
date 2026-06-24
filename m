Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A01D130E;
	Wed, 24 Jun 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318088; cv=none; b=rwc8MATelfZcPptBjmVVxls3Tjmi+tJC4XP8VXm9oAUY4vx48DP+HkXVFOSYxkgEmK7KN4lWpekq3W8nIUncadQ34pX4CN1g0kNpJEM3ze/j9SC8d5Sy4QG8x5BNlqFMJC6ERYmcKC5hk4pPsSnpEJSU569mFqPBG2pG2Ujc7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318088; c=relaxed/simple;
	bh=SH+iQf/6jCyuH7OTIUTPgiXthvl1nWhouagizAV6EYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cwynI5nEo/RMd7GGm4ekQ4OxOsfRW6Z2WTBrWCzqa5mPxKvI5o0s4MOnQYoAGg9BlGmebhje7J7nSzYi104yitG35HDkIAkhqIkPWRyDCTJEjgSGM82OAhZeRORxFLQFzaVKulH1sreCPdweX4J5W69gK5OZ4Jfu7RVax9JJHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVG7QBmS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVG7QBmS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DECFFC19425;
	Wed, 24 Jun 2026 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782318088;
	bh=SH+iQf/6jCyuH7OTIUTPgiXthvl1nWhouagizAV6EYk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FVG7QBmSiaJwEQS40ZICY+zQBNr8kcRMrpJZMHMv4+nLwDQft0TWn223Yhk/gkj5R
	 BV1nTI6MoYEZTi5yE9Mog3mk36+YIDYcVnxE+e1fJgwK3YIO8KUxHhAQckcaFZ69iH
	 AhQE4DYyHYf5JCRkwYQmEQVaiHx2XQmwBmbkxOAHvgJh/2YsiwC4UR/bSknmqaynzf
	 gylycGwrV8rKyavqeSXkCTesuFuo+tM/TZ7aEOx19czXHySomAzmkokLa4RYeU4F9y
	 5D4aW5aSTWM9FCGGmIOS79UpmXkGWibN4D88SMDn/5VjEuXJWSI5FHDd+JlHOahzU3
	 v4ksk5kLi27EQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CAACDB47F;
	Wed, 24 Jun 2026 16:21:27 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v3 0/2] iio: imu: inv_icm42600: add hwfifo watermark
 attributes
Date: Wed, 24 Jun 2026 18:21:17 +0200
Message-Id: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-0-5d9a4c662f50@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP0DPGoC/5WOwQ6CMBAFf8X07Jq2QEVP/ocxBtqtrEYwbakaw
 79bMEavHCd5mXkv5tERerZdvJjDSJ66NkG2XDDdVO0JgUxiJrlUXEkJ1EYgfc0TcqiMgbq3Fh0
 0d0u2O1YhOKr7gB4qjYbnosAsFyz5bg4tPabW/vBh39dn1GEMjIuGfOjcczoTxbj7drMZ3ShAg
 BEbXnKOihvcBXNZ6e7KxmqU/958jlcmr5BqXchig6osf95hGN57p+ppSgEAAA==
X-Change-ID: 20260622-inv-icm42600-add-buffer-hwfifo_attributes-aced0415e341
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782318086; l=1633;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=SH+iQf/6jCyuH7OTIUTPgiXthvl1nWhouagizAV6EYk=;
 b=QDn7tFWxHFnQ1ZExnLlw2mJygw79rADQ7g0xUtMSmFLFkB2i7vu4UWrRFRJtuqA/Fsco/OTTb
 al+jgH0CMjLA1c3/3qdAMW55NJIiep3G8fTX8OHHtwoYCBCJCpYu6N3
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
      iio: imu: inv_icm42600: reorder includes for buffer module
      iio: imu: inv_icm42600: add buffer hwfifo watermark attributes

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  5 +--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 42 ++++++++++++++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  5 +--
 5 files changed, 48 insertions(+), 7 deletions(-)
---
base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
change-id: 20260622-inv-icm42600-add-buffer-hwfifo_attributes-aced0415e341

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


