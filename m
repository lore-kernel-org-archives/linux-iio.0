Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0E3C277F;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966308; cv=none; b=SbzD6K0MO8YIPXFOiNHhMLzeUk3VZAQrfYGq18fxJ1089Yevjz2+t/K61Z9mXN9ed7nwks9WDntK+BsJanoN1gUPNm0D6Q9AsNvTvohnytzHCnTzTy3pkEh1wGPuLf0oW525uoASoZVVV9jEwcZs0fmBRAjg+z0mG8AvOd0Bl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966308; c=relaxed/simple;
	bh=w+gBC9LzLfUEZ39E2NnGtPODhMvwLIgz7oHW/1UC2ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqYEJUMVJVh7KpkClw1rJkslzBfSXcxhwcl63ixfFN6fOGrL3Ghg05tyV5SI56+22VFwmBVsvTv1EvfvTOzMnQDYxYza2o47vMtPoJmyjDKmQsULfHe1xgfi550/Atj00yDOAjhjbps78lY9TbdejaUjioY5Zb4n/2jeWDOTa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5Sp5j0F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5Sp5j0F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E0B5C2BCC7;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966308;
	bh=w+gBC9LzLfUEZ39E2NnGtPODhMvwLIgz7oHW/1UC2ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C5Sp5j0F11PZU0U9ufLorYuBOUuyxOG0KpiG72pihJj65zbuN/6WEH5Li1TjaC4e0
	 0LcN18P6LX3H8ZSXbgH2vMUzXthjDZEGYySfRagnYnYQT7ftRZdt45hyI9izMBuz2D
	 KG9W9ie1ub6WB0wdET47qsMmi7gB2yMeLUzqa6MsWN7Fk+PuEyu0/JluBNlvS+ehtX
	 XYTQGTwSt9nfEjl/hn26i4YAF20SQlEhtrNaOe/4OSfsi2NKF+eHYjunwnFCEtR2nk
	 E04jNEjam4iD1DfySWdHeKxmUohpTNnp+8iU1UhxrJyPtVr+Oc786TgdjX8XTmtOXg
	 gcMdTlnZt3gTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5123CCD13DA;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 09:31:26 +0200
Subject: [PATCH v5 1/8] iio: light: si1133: reset counter to prevent race
 condition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-si1133-checkup-v5-1-5df86a9024ed@gmail.com>
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
In-Reply-To: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
 =?utf-8?q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, sashiko-bot <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777966306; l=1385;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=rNb20PuoCqb49JFiqKumgMP6bKNErm8C2bsZ39xzPjA=;
 b=fPBuOnIc113xkJSOTRBQsMc/4rSYmEbRXoPXrycmyJnPwejfbc0izKvkkwvLOA+o3TDqx/QOe
 NOu8sbaXdhRC/48XfCgBRofxZ0fdFnqzgGP9RyMFGz9c/4zj3U0g63T
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


