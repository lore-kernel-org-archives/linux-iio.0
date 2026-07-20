Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FF3D7A15;
	Mon, 20 Jul 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543938; cv=none; b=jDOmVgnmpC24T7PTEBeINsO77j/lgaYFjccknTTd9qBaMHbjNkuoyR+3hLTnOpswZWJmMbvn6hvok1C9+4AsBrUyqJowMOKBvRHkZ9HM8f4k2gxsdrgK0nyyo+dtNSGWyJsoIMAgsbXUleV+7QchdtvxXueSDXrgRaUhQyQKLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543938; c=relaxed/simple;
	bh=tkxgU4aAbLqEyR/VxCM3e2NBV1wEpOg7XgcWPywgfQM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JVEpY9zGhNjQURaQzTbo1gf6eYF7C3UxAVA+ZeomP5uJejAk4eso6QIOrdaBkUxwKSGhd7JbR48NYOhentPlyQIJNkxOKGftytcNOT6Oqwq6mU09CsUDDDmeV11zHCuDIuweE2bNtUS8EoGcql+GG9Tp8uuV1o9vYHY3oMH7wus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBbAhc7U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBbAhc7U"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30494C2BCB8;
	Mon, 20 Jul 2026 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784543938;
	bh=tkxgU4aAbLqEyR/VxCM3e2NBV1wEpOg7XgcWPywgfQM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LBbAhc7Ulv+/RocFkeuC3Dq/B4mDbYtFForaP7yVfmj7VRTWBWD6hKTdbPxIr1o/O
	 7qcumic3xncn0qyEXS6wnyEqeL96LhaPODqXf3xooRE2KudwSYy72n9d28Susz6/Zt
	 c4aKpL5/cMhaCWW/qE92vlWKJRHeJVnTprvJgm4tboOzBomhgER13VTqRLFShtgaAW
	 eSXR/JWtPkfRivtQrOjJHz5t6P3rNDWZ5nRAuBwNHdphep8KUhdn/DwgiHCkCfXZ7u
	 KGLdHNH4vKwPkP6pe8GhY2uHI2S1k6IgTnPQwo/fjABv+yWN9MJMAVoCcv0wSR+f0m
	 BuiSqZndGRo3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C81CC44529;
	Mon, 20 Jul 2026 10:38:58 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v2 0/3] iio: common: improve InvenSense sample timestamping
Date: Mon, 20 Jul 2026 12:38:31 +0200
Message-Id: <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKf6XWoC/42OwQ7CIBBEf6Xh7BporBpP/ofpAWGxawM0LFZN0
 3+X1nj3+JKZeTMJxkTI4lRNIuFITDEUqDeVMJ0ONwSyhUUt6708qAaIIpjofQxAYQTGwDExZPL
 IWfsBEj5j6kEbp7TUWkq3E2VtSOjotZou7Zf5cb2jycv8kuiIc0zv9cqoltzPevjbOiqQYJV2i
 PVRNsaes+23pSnaeZ4/2OIZa+4AAAA=
X-Change-ID: 20260715-iio-common-inv-sensors-timestamp-rework-acf1a0aa00f4
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784543936; l=1928;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=tkxgU4aAbLqEyR/VxCM3e2NBV1wEpOg7XgcWPywgfQM=;
 b=GNHbJW3B9c7N862rAx0+sWsS4qrg2L614qtItRg8irO4tZtktI2kDK6Ipe/3o1lUvqMZ2+ozi
 PhM6rcNbIDRBhdCQLgETP6GaRePlH3CJ6cm1vx3UxcjNtrV7ACN2H2M
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

This series improves the InvenSense timestamping mechanism for 2 cases:
when using watermark and for high frequency sampling.

Data arriving by batch because of FIFO watermark will now be all aligned
correctly with the interrupt timestamp and the chip period measurement
will use a minimal period of 20ms to ensure that system latency is
not preventing measurement when using high frequency sampling.

This was tested using inv_icm42600 driver when using maximum FIFO
watermark and when using 1kHz sampling frequency.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v2:
- Add a 1st patch to convert to kernel types.
- Rework following review suggestions.
- Following Sashiko fix delta_counter usage and handle case of
  timestamp overflowing last interrupt by using s64 type for new_period.
- Reword commit message for better timestamp alignement using Jonathan
  proposition.
- Link to v1: https://patch.msgid.link/20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Jean-Baptiste Maneyrol (3):
      iio: inv_sensors: convert to kernel types
      iio: inv_sensors: better timestamp alignment when using watermark
      iio: inv_sensors: improve period measurement by using a longer delay

 .../iio/common/inv_sensors/inv_sensors_timestamp.c | 109 +++++++++++----------
 include/linux/iio/common/inv_sensors_timestamp.h   |  40 ++++----
 2 files changed, 81 insertions(+), 68 deletions(-)
---
base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
change-id: 20260715-iio-common-inv-sensors-timestamp-rework-acf1a0aa00f4

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


