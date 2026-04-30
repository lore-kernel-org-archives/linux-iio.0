Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AEF2D5C83;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561517; cv=none; b=XsB/XN5bLZLW8pJ2uI+sDDwssr0U/XAjGhcyEoGmW1UoVNDpvtAn1kKi8gZkHozcLBY/Co2bkR3NCjGf7e9qVhp85nBEv0rjG8IZNjNV4xAJwVsgsd/3E/Y4ZSFMdrzI/HhaFttS1HYI/iYArT5Fk0ruckUawI2WArZ6pqwA0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561517; c=relaxed/simple;
	bh=w+gBC9LzLfUEZ39E2NnGtPODhMvwLIgz7oHW/1UC2ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HvF3KeLmUE2J08yOxBQESpX5nIhhXUWH1RQ74vOMffg2x1W/WWyvIgyidmomAK+SxxcOlHMLvO96VpoIATmSDqpykaMXgi0KHaRLbcK0hKXCbhEgH/cCifVGnlXWIY+Nhh2K7oZ1e0oL3iUCfIdrJjcluJr0pC/xM3V+5Ls+hVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZC4NGEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZC4NGEO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D7FEC2BCB9;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561516;
	bh=w+gBC9LzLfUEZ39E2NnGtPODhMvwLIgz7oHW/1UC2ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uZC4NGEO9mqvOetpW8FBkVKASpDRoWOcT5RqXsrIZ2uvHrheuAxUqpXkOhOCWcyvH
	 9fDM0UfFT2oEKYGT5A36KWhXPPnIWLfYqpF/titAX5TB8W5IgZ+VEw2yBr+d9PeZ2O
	 VfLHPvFLaN17hA4/f0jdg6ib8oUpeYLdk7ZzDqZltGNHDlNHLzTUYBLP9/AQFo/EDF
	 J3rSRMPnBrXd8d2cWNQ+1v/XKxrKsmUdnPGnlUeZWAPzlUfv2g8q95kzqKK8+Lw1//
	 weFeJXssgWUJNWhiflXgM1b0+I4Blz6791RW171RTaQwm8SdOO/Fm9Yq61vX9cCFCG
	 lGhw7tou3qexQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6023EFF8875;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 30 Apr 2026 17:04:21 +0200
Subject: [PATCH v4 1/8] iio: light: si1133: reset counter to prevent race
 condition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-si1133-checkup-v4-1-fb3e9dce41bf@gmail.com>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
In-Reply-To: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 sashiko-bot <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777561514; l=1385;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=rNb20PuoCqb49JFiqKumgMP6bKNErm8C2bsZ39xzPjA=;
 b=Su2w9Mjz7BWOnS0XQymPOWGGGoFG3J36nfcxqOFmVXZVlsEgdOC2S0ts+E+HkJpGsbXOnkRfr
 1EfnPsSgehrBJdpRQc8i12fOBEJsJ4NMWcGSFS9kDUJIyqzNr5hidOJ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Sashiko reported a potential race condition happening when the driver
returns an errno after a timeout in the si1133_command() function. The
premature exit causes the hardware and software counters to become out
of sync by not updating data->rsp_seq, therefore the internal hardware
counter keeps incrementing.

Fix this by adding a call to si1133_cmd_reset_counter() before returning
from timeout.

Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/message/20260428-si1133-checkup-v2-5-70ad14bfefe2%40gmail.com
Assisted-by: gemini:gemini-3.1-pro-preview
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 44fa152dbd24c26c97cc778cbe641d92ecd56afa..c88c79202be2e21abb72067426e31b6bf97c61cf 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -427,6 +427,11 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 			dev_warn(dev,
 				 "Failed to read command 0x%02x, ret=%d\n",
 				 cmd, err);
+			/*
+			 * Reset counter on err to prevent software and hardware
+			 * counters being out of sync.
+			 */
+			si1133_cmd_reset_counter(data);
 			goto out;
 		}
 	}

-- 
2.47.3


