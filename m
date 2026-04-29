Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E14376BF7;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475150; cv=none; b=jDTZoVFsmuLzWarsBggfciZfwbzqKnxyMmtsJzjT8cLM2pqqMKgevYCNJGWsqv00FIEgw0qnt7kPSIAczQpWmg/7LVJtqAtlq4kCafILozBJO7FPwufd2X4E6UfprsOauqX0JyoXf4T5ZrvnUCWK0cmCuQ5uDBA/7O17AqEx5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475150; c=relaxed/simple;
	bh=yvZqNvHhQMwxj7xF0MXrcn2P9izjkp6fBgoEoqbizpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8h8496eo0AJAHpfgqEIiJKiz/MRDIwGCPWPe/vEU/QrwRSkM+5lTJL1qPiS+UPbTmrBsv9j7wsa0m8jr9pxe2eth+ZMekKQH0K5+cXbSotJ1YicF6H+FmrGFmaMRJtAC+A9fRNY3T8qX2ZY6VRlzxiz9gY5J6WyNpQkkpFovA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeISPOSy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeISPOSy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4477CC2BCFD;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475150;
	bh=yvZqNvHhQMwxj7xF0MXrcn2P9izjkp6fBgoEoqbizpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OeISPOSyONm4d7iPgRHsQCbRt3hfxIxcIggtTY0kU//I/GPRqqNhrCwmYaDYd+IMZ
	 tc0jhUBORjsKXNH10WTfx5WaeGxWf19ATdFby0HRGgUXW49dwpYN9WewIm8HBzgVc1
	 RfS+hNADEodL0JIyB4Vn84xXsnr34iCSjrjgLK0+LB2dE3XrcxUuMsjyZuwAqzNB/l
	 /gYKWDii0HUfEJPqWwur8ewfBNNML3E+WEofTYUhh7B2q9gI/K8JEIoD3pI5M5flnS
	 tfnFzzdE8+V7cwU4Fu68l+GwEYlvprglTes9HyF14ROPVN4/Bogwl/4MJkM7HIReeW
	 W2AH6H/dvJHnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB91CD13D3;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Wed, 29 Apr 2026 17:04:55 +0200
Subject: [PATCH v3 7/8] iio: light: si1133: reset counter to prevent race
 condition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-si1133-checkup-v3-7-469f21d960eb@gmail.com>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
In-Reply-To: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777475147; l=1283;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=w5+8yh3xuGpn+X2XqfBM/QUEQDOv+CuyHlSCRq32RGk=;
 b=N+thik5dCDitv8Y5v6yQadfTjYzWgatWrVGaWSgs2/ysj5GlhS4q7jKx+4dTZnTnDWjM4sZMJ
 S2W/3fMGeNfBJMBqmLPcdlfUE8yno3ogfTBbX1yg4mYkWqr7M+tc8oK
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

Fix this by adding a call to si1133_cmd_reset_counter() before returing
from timeout.

Closes: https://sashiko.dev/#/message/20260428-si1133-checkup-v2-5-70ad14bfefe2%40gmail.com
Assisted-by: gemini:gemini-3.1-pro-preview
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 471692057b0f16c82946507bf7d23a0004f80bf0..842a59bc68c20b3206e0c826f86c913f6c66bd7c 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -430,6 +430,12 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 			dev_warn(dev,
 				 "Failed to read command 0x%02x, ret=%d\n",
 				 cmd, err);
+			/*
+			 * reset counter on err to prevent sofware and hardware
+			 * counters being out of sync
+			 */
+			si1133_cmd_reset_counter(data);
+
 			return err;
 		}
 	}

-- 
2.47.3


