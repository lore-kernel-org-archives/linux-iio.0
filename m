Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059684195C8;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574697; cv=none; b=TlCA0wZIMVyplqFsIbV/Z/AWDLaxOh7NN/ye4iwpAln6JZrbuDarnPzN5/l8aghLxh3N572oN71i44pHsePwdeXlQSNzUP9BMOZl2lpIT9xDDpB3XAl2PCwwQ+lgOPvEs5JbijXybc59fOp6F5R6B7g4+gy4qRLt9EyhJsb+pHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574697; c=relaxed/simple;
	bh=KT6Pf5qqHIW+9eGHA62X1LADJ5xfPm/G15BUFan5T/0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WBFiGSTnqlMOSrnWtNVcXLcnAcF1oDiI5QfEP/uRa68MLp1xciZrlsKIfSU/PxkZGtI3UGYLbdobzVmNKBPIvmjAfEbhKvhBtP+nVAPRw8SD/NEkRb7G/o2ACD/zgPmJT+7UAczzLIEgBcFj12F0xlwBXcSYzP2sTh68cm9C81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8Zp6gTj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8Zp6gTj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98B83C2BCF6;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787574696;
	bh=KT6Pf5qqHIW+9eGHA62X1LADJ5xfPm/G15BUFan5T/0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=N8Zp6gTjaHNBy5eQATJdkuSXjxp6WE0k58nNc4nnHih4wX5uPPUcjmGWrI5xhR7A4
	 s/3D8MNh19uT49FTFSlP7TlCOQbG18/9F+SCdqFDCiX3drAxe5C7WF3igXhbOeG/QV
	 L5/HnZLMBiMsJ4Db26vA6Iwakx3oKmG55+Du/7egrmFFUO5vVmZXm5MrHEAvG3B6ca
	 iS0ZYDSXWfcQgg01zpHhOKF/ZCkMcqhF9CgVj7hm4yZ6yaTIEVQaL9+ONgWI3sq6SG
	 RLOGn90QUmCzazBVjgqaH0+D/3Tv5E+msQ+/o2vw5gxPqU5iwcGK50gatFRkv6ENCg
	 3PgDiOwSd/bCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8424BC5DF81;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v2 0/4] inv_icm42600 driver enhancements
Date: Mon, 24 Aug 2026 14:30:06 +0200
Message-Id: <20260824-inv-icm42600-enhacements-v2-0-0040837fde12@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE45jGoC/3WNQQ6CMBBFr0K6dsy0EaiuvIdhAWWQ0dCatjYaw
 t0tsHb5kv/fm0UgzxTEpZiFp8SBnc2gDoUwY2vvBNxnFgpVhTWegW0CNtMpIwLZsTU0kY0BJCF
 JTdWgKy3y/eVp4M+mvjU7h3f3IBNX37oYOUTnv1s7yXW3Z7TC/5kkAQHrstVa9l1Z1tfYP4/GT
 aJZluUH/uzZYNAAAAA=
X-Change-ID: 20260709-inv-icm42600-enhacements-1e0e18e6f868
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787574695; l=1889;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=KT6Pf5qqHIW+9eGHA62X1LADJ5xfPm/G15BUFan5T/0=;
 b=Q7B7t1VJDwwaO7S7p5M4XGfgE4R4YzLhgDwS3kuQ4g1IuEc7BMCaRaiMsFAI7gHO2/Y4MwLRR
 IDNs7b/5n14DhdjvjYjiWW5l8Js2OJ8YRdFDo6pI6vueYwdL4DHuyA6
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

This series add enhancements patches to inv_icm42600 driver.

It includes:
1. Move of MEMS stabilization sleep before FIFO configuration to avoid
   pushing incorrect data.
2. Use a fixed FIFO frame of 16 bits to avoid a bug of dynamic FIFO
   configuration changed triggered by the sleep move.
3. Simplify watermark computation using gcd.
4. Enhance support of high frequency streaming by avoiding read of FIFO
   count for watermark interrupt.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v2:
- Add commentaries for easing understanding of changes.
- Reword commit messages with better explanations.
- Link to v1: https://patch.msgid.link/20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com

To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Jean-Baptiste Maneyrol (4):
      iio: imu: inv_icm42600: sleep before enabling FIFO data
      iio: imu: inv_icm42600: use 2 sensors fixed packet size of 16 bytes
      iio: imu: inv_icm42600: simplify watermark computation by using GCD
      iio: imu: inv_icm42600: do not read FIFO count for watermark it

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   4 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  16 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 112 +++++++++------------
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  16 ++-
 4 files changed, 73 insertions(+), 75 deletions(-)
---
base-commit: 53c022f51fbe540fffee2121ce9ed3e15266c9a4
change-id: 20260709-inv-icm42600-enhacements-1e0e18e6f868

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


