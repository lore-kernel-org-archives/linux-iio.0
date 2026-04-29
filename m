Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59436E467;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475150; cv=none; b=kzMBfV1xgJGhbfzU0D+tR9dX2weeU95dNJLDRrhcMd4eQp6SyD+ty25iu2CoWymTa8jS8tWtTO3L7yM3XiHDsS6o8AjgAGHRjoMg9Wa5N2bP++lktZL2BNJD6oww26LoAi0f5eBXzaYygpyalgwZuCY67yK5lxyXPBYi9dy5K1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475150; c=relaxed/simple;
	bh=3i5szcPoHjj8uGVodLvIQA137dR7oTUd3FYQWzKjtv4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HHB1yOdIVkf1H3VmhRZYURGusEGcI4Wo/nOrXKKDHjTKqMqiRJ1PanEgIpFhqUtyjb58peIeJrUJcT7MsdKXR8ZPqSbJ7rtjThqrVmw/3N2KbnfyPE7k2tixXuT+NDpinHOMX3RjqCLPbxq2FVYyFMFcm0olyWReaiSVzMFR0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9nze35V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9nze35V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C87CAC19425;
	Wed, 29 Apr 2026 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475149;
	bh=3i5szcPoHjj8uGVodLvIQA137dR7oTUd3FYQWzKjtv4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=U9nze35Vn+F0pnhtup49i9LbpF3Q5IcjEjgl3GLp5jGOcBa3iKewUFI2X+soMhwcK
	 /3kUTw7cCvXW959GzY+LYpTocoBQ9lS2sNNddOarfA9mlpWfL/e6OnYBurVzO4RR39
	 vNfLyw+BHBtNO7pmgqP+ZMvmN/jGOjO9y4Z+233vUaua+wx4IR3ntsohZcxMYVodPj
	 5231RUUS6yjjaWYQlpN+xlvQwfCT1Dqo7UJwiYrAMrsjdIkeDR3i5nShm1JxEHyEYB
	 JV0kXp7JBQuHmt5hxsnwVYJkR3IKUV3usIKzOwccMGn4Kz6RIpHehPCxPrP6mA0hID
	 Kr7deJrk5pOoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83E8FF8875;
	Wed, 29 Apr 2026 15:05:49 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v3 0/8] iio: light: si1133: driver cleanup
Date: Wed, 29 Apr 2026 17:04:48 +0200
Message-Id: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABAe8mkC/3WOywrCMBBFf6Vk7Uhm0heu/A9xkaaTNmhtSTQop
 f9u2lVBXJ4L53BnEdg7DuKUzcJzdMGNjwTqkAnT60fH4NrEgiSVMqcKgkNUCkzP5vaaQDfGFFR
 L3VolkjR5tu69BS/XxL0Lz9F/tn7Edf2biggIJG1hEbnRpTl3g3b3oxkHsaYi7fX6RyeQUKUjm
 DeWLdNeX5blC3S11MXrAAAA
X-Change-ID: 20260427-si1133-checkup-abcc5280adf3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777475147; l=1807;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=3i5szcPoHjj8uGVodLvIQA137dR7oTUd3FYQWzKjtv4=;
 b=hAwCMJl/2Gy9Xo0cb21LEs85I0s8nXyMid4lHADjvlolpkFlHMoTROSuUY/YaHBvBxvTur1Xe
 2MUr8vzS75NB42lbtb9lTayJS9ByvXZv1nrAuQL8NDM8nvpZTAD2WcN
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

This series deals with the cleanup and modernization of the Silicon
Labs SI1133 UV/Ambient light sensor.

What seemed like a simple checkpatch cleanup turned out to be more
complex, therefore I've ended up doing a patch series instead.

Changes include:
 - adding missing headers
 - removing unused macros
 - adding guard(mutex)() support
 - code style fixes
 - race condition fixes reported by Sashiko

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v3:
- PATCH 6: add local variable for timeout
- PATCH 7 & 8: fix potential race conditions as pointed out by Sashiko
- Link to v2: https://lore.kernel.org/r/20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com

Changes in v2:
- Change v2 to patch series
- PATCH 2: remove unused macros
- PATCH 3: add missing include headers
- PATCH 4: group generic <linux/*> headers
- PATCH 5: add guard(mutex)() support
- Link to v1: https://lore.kernel.org/r/20260427-si1133-checkup-v1-1-20f5f11eba6c@gmail.com

---
Joshua Crofts (8):
      iio: light: si1133: remove unused macros
      iio: light: si1133: prefer complex macros enclosed in parenthesis
      iio: light: si1133: add missing include headers
      iio: light: si1133: group generic <linux/*> headers
      iio: light: si1133: use guard(mutex)() macro
      iio: light: si1133: add local variable for timeout
      iio: light: si1133: reset counter to prevent race condition
      iio: light: si1133: prevent race condition on timeout

 drivers/iio/light/si1133.c | 73 ++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 28 deletions(-)
---
base-commit: d86db1905add39f905cf9f04252804b359914ed6
change-id: 20260427-si1133-checkup-abcc5280adf3

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


