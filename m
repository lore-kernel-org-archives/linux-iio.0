Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC844103C;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382316; cv=none; b=t5jt3QuHFDYwiTx+lh1U531xOHCcxr1v5xJMxrxlMYXmFdNcur1IlwxFX3TXwUzUTLWzNKUZXyK+dsuuv3qRcK/050x2UmtCWLkhUH39ljF3SxZdZm5gbAE/B7SlUiGPRHukpKHMsTNOnklFb9cdzsSYTRh47Vn238cASWjT/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382316; c=relaxed/simple;
	bh=hlX2tTmUoxSKiSECEojELI2SP5G0fAlh4xQ9I68Ym9A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=icAp48jGAlvKNuLwbNjCMNRwQvXobcX8GW64UcmaigFHZc3Q2Cz4nAWh6JuzuQmlUmrV1fFWb7f4IFtuNXQhWJnSYMUgALJ+FLpBbARSdf/6rye+JUdzBdFwGGPz37uBPyYIdoatzY5LI8q0hPF8ygUgLhAgcEuUkfDqiaus5I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLLacvDS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLLacvDS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D7D0C2BCAF;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382316;
	bh=hlX2tTmUoxSKiSECEojELI2SP5G0fAlh4xQ9I68Ym9A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZLLacvDSQIU5reehbHb+XH9r07BlOizL8mSaA5Vj9rxl+2X60chpvHyUrPpvbJ8Mi
	 xFgJm48nGUeTsgW9XsnNwIS8wgVPJuMOiEHp2ZF9esTl2WRN/gFUYCXj2fkg25z5X6
	 I+CJDuD5FhrYWhUqu/H1Jk7/XczMIRosF/QOCd0dB4d4+S73HivkxkPIyCuVRd2vvP
	 cjrSKUgx7AxtJ1XYMUNz7FdTwuW2yd+2BFnbHFY3FP2SpDptu7eXXI9m0+SqJZh/MK
	 /LlhlFNkfwhs3S0NuXWjrdgzXlqh7SeBKj+SzzlFsYKxGlzuDpvIGZQgUSZc9X3AaA
	 a9HzrOGLmHJ+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D33FF885A;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v2 0/5] iio: light: si1133: driver cleanup
Date: Tue, 28 Apr 2026 15:18:32 +0200
Message-Id: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmz8GkC/3XMyw6CMBCF4Vchs7am0woaV7yHYVGGKUyUS1olG
 tJ3t7J3+Z/kfBtEDsIRrsUGgVeJMk85zKEAGtzUs5IuNxhtKn0yZxUF0VpFA9P9tSjXEpXmol3
 nLeTTEtjLewdvTe5B4nMOn91f8bf+pVZUqIz2pUfk1lVU96OTx5HmEZqU0hcfalHvrAAAAA==
X-Change-ID: 20260427-si1133-checkup-abcc5280adf3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777382314; l=1350;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=hlX2tTmUoxSKiSECEojELI2SP5G0fAlh4xQ9I68Ym9A=;
 b=KaHDT9/e92q7cjwRuLbSo9aWybWWLiq2Y4yMDZGTZ7rX1pUiNHCYXhLFOOJGjEWbF/flWvgBY
 dnncEjLbaGcA85hAQbmzsoAbkKirVhl+X2n6xJHBoqd5uvp7dPTganf
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

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
- Change v2 to patch series
- PATCH 2: remove unused macros
- PATCH 3: add missing include headers
- PATCH 4: group generic <linux/*> headers
- PATCH 5: add guard(mutex)() support
- Link to v1: https://lore.kernel.org/r/20260427-si1133-checkup-v1-1-20f5f11eba6c@gmail.com

---
Joshua Crofts (5):
      iio: light: si1133: prefer complex macros enclosed in parenthesis
      iio: light: si1133: remove unused macros
      iio: light: si1133: add missing include headers
      iio: light: si1133: group generic <linux/*> headers
      iio: light: si1133: use guard(mutex)() macro

 drivers/iio/light/si1133.c | 57 ++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)
---
base-commit: d86db1905add39f905cf9f04252804b359914ed6
change-id: 20260427-si1133-checkup-abcc5280adf3

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


