Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571403E16A5;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697226; cv=none; b=rw8Mm+tEsMMZMULVd0+ACA4af4X2q0umEJ2vtc0Iq3w//zy/VxtYQY8e3s1z5FxWG50Rjne3puafOzJgIXSO4trvkApWgGJAXe9ZzWdVhWTPrVHfI489a3ngEZDO7rWW5OdTzOf578E7kyr/6yxp2ZdHxdn8YGZQNV2cVuf7Rz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697226; c=relaxed/simple;
	bh=PAmiiyvog4vMHDca2wkfy5RtYs+QyYpNTfZrmhnDoPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uROSZmQ+u4ZSrBKYTsxxIFK9Pd2ifPi9sCdifAjP6jwnHNNfB3DT9ts5aWD0qlY2oDbsn2lbJSil1g6ppzykx5vEjVTskR5wmBPXHMdyY+7WDJxmUiPjO9DjTp7YKSliz8kWO3G2lv/uQJ3Z2635tYyyzUtUi4Su6pLv4FWVqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj4PaXPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj4PaXPB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26C50C2BD01;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779697226;
	bh=PAmiiyvog4vMHDca2wkfy5RtYs+QyYpNTfZrmhnDoPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dj4PaXPBFWAqvbdW6r014jbpSxP8d01XpBPY4UeCi2rFU8M/yO+z+u+AXgVWvPDjt
	 4sUCsSw7SlZT/1lKLJCLu6GwaBXmWZGH9N3nBbwNw1b6M4LGRFHmgUNSvV9tQsF22b
	 rcEnoBRroHdMZuv/ulNjV42keKc1wCN++yXUSLbj7z24CgBFwfJffvSqYFyTND9zlC
	 lCULy89mQDR5RY7GCBC7RE0Q6zS7Ju1Kf3g1GGm2aoWISGhLBpsjdCEbt9XJ5mg0b6
	 tDId6KfPFXl2hRibWp81gED816vh/4y1hB63pt8D/9a0aejARvkDvl4wYTKbJC2v5z
	 T43Fj86fkidYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20402CD5BBF;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 25 May 2026 10:20:22 +0200
Subject: [PATCH v4 8/8] iio: light: opt3001: add comment to mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-opt3001-cleanup-v4-8-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779697227; l=901;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=e0FEzpVldsPt7x0C57i9zGOxx0GFmKdZq9MhceXE7aU=;
 b=natZBCGqCGJr+RedNb8eCq03yq6sNn2h1dH7JA5kC/CwhsVslf7ed3xZWASskUTnrGfzNAApw
 Uxj186nVxVPBmc/zXLykJz5+hDOovWSqVxP/FE7vCHTxBf6z/fxbp1l
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add comment to mutex per checkpatch.pl report. While we're at it, add
a comment to bool ok_to_ignore_lock.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index e35b5cf665e2651e8b6a576aa34fed5082f4ed19..8d89d539b19b862ad7a33cfabd922ddf8b826b2c 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -103,7 +103,13 @@ struct opt3001_chip_info {
 struct opt3001 {
 	struct i2c_client	*client;
 
+	/*
+	 * Ensure data capture and read-modify-write sequences are
+	 * not interrupted.
+	 */
 	struct mutex		lock;
+
+	/* Allows for IRQs to bypass locking mechanism */
 	bool			ok_to_ignore_lock;
 	bool			result_ready;
 	wait_queue_head_t	result_ready_queue;

-- 
2.47.3


