Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F5362138;
	Thu, 20 Aug 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252564; cv=none; b=dwyYUFRfN0UrDhwDHzTjmIsJ8evrfzHauRs8QjLrJi/xYAb7ErJH0xT9tmza6SSPaqTxpchvRTTlog7rmYraJv07MzwEDUrfpxUSC14yGb9AAd0iK6S0XhhYVyPatGX3hWNPdquoLdrxsPrzu0bD3yn+pc/9nna3XnhNSFoWKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252564; c=relaxed/simple;
	bh=lrkb5DHW4nekBm62Ptn6gdrtseZG3P/khBB49osjqIk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yg9d7WnUHL553wZFVV+ZGEfwi5/HjZK5iFnJwUJCuiksl/tz3i4yff8nMAFYEN4ogcsqsAM6fmxXQ6rOAFeCFslkBEZqWkOX/HYJQKsNFID34p794OhEoLRfW9hOEdDu0Xi8GiHfygIu7q/hipcukyxcUurwGiK/ir19iuMnNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKbvGYBH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKbvGYBH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E77D1C2BCB3;
	Thu, 20 Aug 2026 19:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787252564;
	bh=lrkb5DHW4nekBm62Ptn6gdrtseZG3P/khBB49osjqIk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GKbvGYBHFY+WyD3RxUEYPAxwtOn7iABJqbh7RV1gZHw7ff3sNfmzPU8q0aLXMtyZW
	 Pale+rheFUVhYMTrT5wz1R88D0duJFncaKeU4ws1StYDP5NHbqTsJ7G2LnP4ZcfDH5
	 f32Jbh5Y0fExkTrKoHvyDSwzPUavMfY7+V7TtU80dF9pJ5iZQuu5pPjerN3FlSeL9D
	 pSANOaZ1PslwocQekmDJjGsFpDJUq3TidZOjaHR2BK2WZiS8NCYZ7l/gBNCyxHjiw0
	 tygLTR0hDIeXycNbE5/5873VNjsQFkYactb7hBdl+2LDqvS/6qGqvfuKERLVdZyMGc
	 MrQa3Rysojgow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30AEC5DF86;
	Thu, 20 Aug 2026 19:02:43 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH 0/4] inv_icm42600 driver enhancements
Date: Thu, 20 Aug 2026 21:02:36 +0200
Message-Id: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExPh2oC/yXMQQrCQAxG4auUrA1kioyjVxEXdfxrIzTKpC1C6
 d0ddfkt3lvJURROp2algkVdn1YRdg3lobM7WG/V1Eob5SBHVltY87ivFIYNXcYIm5wDBCEh9ik
 mqvmroNf3b32+/O3z9YE8fX+0bR+r9bR5fAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787252562; l=1371;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=lrkb5DHW4nekBm62Ptn6gdrtseZG3P/khBB49osjqIk=;
 b=z2r01HbY7zKX1LD8h1H8bd6vdUs1Q9v5pDWgsZlihr0aSoKmfN7NY7fMlBq5t2eexTsxiwfn+
 p1mb8TdnTPIApzKDAPfzDAyjME0nJREF58RrUjpr04xhqIUppZPqd85
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
Jean-Baptiste Maneyrol (4):
      iio: imu: inv_icm42600: sleep before enabling FIFO data
      iio: imu: inv_icm42600: use 2 sensors fixed packet size of 16 bytes
      iio: imu: inv_icm42600: simplify watermark computation by using gcd
      iio: imu: inv_icm42600: do not read FIFO count for watermark it

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   4 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  12 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 109 +++++++++------------
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  12 ++-
 4 files changed, 62 insertions(+), 75 deletions(-)
---
base-commit: 53c022f51fbe540fffee2121ce9ed3e15266c9a4
change-id: 20260709-inv-icm42600-enhacements-1e0e18e6f868

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


