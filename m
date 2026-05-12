Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB8838E8D7;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583473; cv=none; b=MHacjIgHhX66zJ/JTPgckrYDvsyKPq61j4PlKiWVaPBsfQoZjoNz97S4xzw3zOFfWGMyhhFeB1wLK4vCsknrGUVafd8/AjNZSR1QM3/oET21XB8/dklmmERnp3cDQMgxyF/SbF1vBQNEfbPr2DtWWDZjbe7DyNIDEjBd95o4cdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583473; c=relaxed/simple;
	bh=hnypABvmlE1Sj2gAeVKyslXoqoLrW5BPh99jpjSy0lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7pjQ4yfCMVIoCApd8zrJcTpLzLwIQ2Nzk5J4tnHIFKpWwZQ3jaPujwmkD/l0dkaHqXYkXZtWr/Fychgab7y/osmqaHa2qvWkjhv1A7cu6T+p035zsharEjaNTNPXbfVIRUhypOeYgUc4IXrMEY1eyjOEuLIskg0MPtDqu5Mct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwWCfrEd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwWCfrEd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 953ADC32782;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583473;
	bh=hnypABvmlE1Sj2gAeVKyslXoqoLrW5BPh99jpjSy0lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kwWCfrEd8A8bKp9dRjQuRGgwPmoyRNs4IBDeeDQlkzhjihOE814vdW5V5hcqMdoI1
	 XD+Wg7yTnvpEedIBLaUJm/JQN8x6/ZKT7OnraYgIv12uUyHPMzCtjzMV3Kd+mPiGUS
	 rW7fQ9/LlWUUmfwhXEeElzedY5KMrCt1YsybyT0O+eGDQKCkYk3B/+NhQVze+VbGKw
	 h7fxF1UTfsBl4kTwujYdun1wYHRIN9AgZFHHaV9+imnKB1cDEdtFTDDrB2phvIPY3f
	 QKu2ZfEeV6njeItnZVA+7zb1VdQT+oUD4zXkNheR7qEYo/CbA7xu4vkzj7KnmXWgka
	 80hC1bILN4fEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B007CD4F21;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 12 May 2026 12:57:30 +0200
Subject: [PATCH v2 10/10] iio: light: opt3001: add comment to mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-opt3001-cleanup-v2-10-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
In-Reply-To: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583471; l=692;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=9LCbzPQ+voynoNiKus4VNoaaKdzkjvLt3vAM6THTWlQ=;
 b=C7b7QpXCOmCiaZBpNtXGQLqJYiad35EF6gLzN59OCN+4R+cAJn0jx9wPt4oIGoqeXSi5FRx7U
 Fl2SHx38W0qAnvYCWY5WxMLAOGWGCSMFOvODqtHYuRh0ggI8QvK8daU
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add comment to mutex per checkpatch.pl report.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 1319e5941b66bd82e4dc2badf5ea27cacbcfd54a..81afee6993d08b1126f07b1c63c3d3496d8b380c 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -104,6 +104,7 @@ struct opt3001 {
 	struct i2c_client	*client;
 	struct device		*dev;
 
+	/* Mutex for ensuring one executed command at a time */
 	struct mutex		lock;
 	bool			ok_to_ignore_lock;
 	bool			result_ready;

-- 
2.47.3


