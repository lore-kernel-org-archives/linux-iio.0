Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA490348C76
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898977; cv=none; b=HneUwUxRHXxdRiCVyQtiwajWUc/fYW+PWBPmU8w2cXpkqtnK5Xdqj2u6TVGQqoELaSgUdDUlNXuiHq6TxW2C1lBFORNGjdNQxqmsRJ0wO3oMwJRxHYUkDWtDLjgSE0sRw60ZBvI1VgzDaHMjjapDH33YItpAyWhUIRJy2+ysbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898977; c=relaxed/simple;
	bh=jap97A4svyHGjLLJ91pWZ4pJuBTZ6OW/+1/v1XMQF1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTCSZ5hDO2PLy9MI3OE6yzqL/oe5ayCKpg29eIGDW/rK9E3nHseVZ4Ld1bK4MRQDZjNbBACwzVQRX8ADQzqG/RGOfwm9YpRnO+mNF5MoBqWeKyVJEp1pra1Qmkf3jVFSQYT+SODzypiYf/wjkL7zB7hyPC7IGYHreXCQiMnxjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5sBPwjF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5sBPwjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975511F00A3D;
	Wed,  5 Aug 2026 03:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785898976;
	bh=I6irIAsciEVpY85696Lhao/wxVP6jdf+4qpyxXMhz0M=;
	h=From:To:Cc:Subject:Date;
	b=Y5sBPwjFkzV2zE6F792wpuuy7NNdksLxvLyIYQG0e1fQsdtfwj0Thguya7rlObENC
	 eVpHc2lyKCA53w3uzCk45jaQlXWwHsWVmo6hGshFM7qgQOd3Sf5oLOfsJezNrUV9jC
	 MISQnXEmFWq4PK7YIHvUe+Xt1VhliMe5xQRKsnhBNlfOVzENu/qp13fFMokcXreZLK
	 b1zG2drG1M0za1yrrE1nHJGk2cJ7p2FZCSxLN4oHJHKHbxkhbB+KchElTierU2PHYB
	 lW9Xy8eHMqgJdot9YXnM1+LZrmDS3CZfOmqy98pvfWETkKjqidQAeRSiCpC08yWL8A
	 kOrDAJSd+YphA==
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter fixes for 7.2
Date: Wed,  5 Aug 2026 12:02:49 +0900
Message-ID: <20260805030250.1502786-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=wbg@kernel.org; h=from:subject; bh=jap97A4svyHGjLLJ91pWZ4pJuBTZ6OW/+1/v1XMQF1A=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlFy8+/dXNuOsHX42/Mk2i+bGFPffC8hMye6V3ta5Y+k PHf/UOso5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZiI6A+G/ymlTe8WuIqUzvXk la/VtD+XIXAhUyKWlX/2b43Jvz++jGP4p12mlRfTecJKfMuURgv/Y5PfxzguXzL74Ibok0IfCye 4MAIA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-7.2

for you to fetch changes up to f1a3a9946aab611dd2200c01ff122f64b033dad2:

  counter: microchip-tcb-capture: Fix DT channel validation (2026-08-02 21:41:51 +0900)

----------------------------------------------------------------
Counter fixes for 7.2

A fix for microchip-tcb-capture to read the devicetree "reg" cell into a
u32 variable to match the expected data type.

----------------------------------------------------------------
Babanpreet Singh (1):
      counter: microchip-tcb-capture: Fix DT channel validation

 drivers/counter/microchip-tcb-capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
