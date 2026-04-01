Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818463C9ECB
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045972; cv=none; b=bflacTQvwa1pHQlPMzfuVvUJxHaCHU/xDYvMzuyab+aPg6q9H97+nAYRdAE5EZwb8sWoZrGfr3q7pUJZVfv5MO+aMGamqD5nwF8akLNZmtWKH+Uz5XsEHYC3BGMGUOXOVtMy+NIvRTpqpWg5PUXXKIUxK5O+DFVb2z/KgNaU4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045972; c=relaxed/simple;
	bh=/WOCyJEW+od5ft3M4X2oIZveeAvWKQJyqutxIGTLdT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b30Z3S5nOYyhXE6adl24NFvGbqz63zNY9NJuEjJvR/kSdvC5+aRGSK2k/hYwYduRK4/mWtzgiKjcsVEiCDS5uZI+so7+LzCc2HIxFieosfj1bfGlwS0OodxJziZeG3oT6WACXzW8R6d85qUw/m4lRfaW4cJBN7+JvAqLi7PBGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKHTQki5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKHTQki5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591D7C116C6;
	Wed,  1 Apr 2026 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775045972;
	bh=/WOCyJEW+od5ft3M4X2oIZveeAvWKQJyqutxIGTLdT4=;
	h=From:To:Cc:Subject:Date:From;
	b=dKHTQki5Fy+ja8A9znXkx/ki6KodtaQIlkOgxT0iXuwTRHHaMy4nOetm0yzoZ/8io
	 d4zu2uPm/rAt7crlZGNIZQgcoFGBcNjKt2yDb5TK3lFZ1KB9R03O9JngCa0WAHyXra
	 5e7z/wMI9ECs0vIxxEpXtlZtVHzPQnIwmlvasCsDinH9hspwYKA+4QNEWR0/y8Wppo
	 TbM59kXCloJbqYYvgOkx6qehp4KmqqlONOJ3CGB2V3GQuqOVwJIersGGY7gJoXTw4W
	 R1d62q0fth2MgqibIIKcJPx4G24PylqbQ61nworiRJ5WKXmYYPTivTDiGaOAQ8JppW
	 BovqQ7PigHvDw==
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter fixes for 7.0
Date: Wed,  1 Apr 2026 21:19:21 +0900
Message-ID: <20260401121926.2017351-1-wbg@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=wbg@kernel.org; h=from:subject; bh=/WOCyJEW+od5ft3M4X2oIZveeAvWKQJyqutxIGTLdT4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJlned2s9pp2hhfG8+/KjdSef/AZe/7DSZusM0xV5wuV6 Bq9bL3WUcrCIMbFICumyNJrfvbug0uqGj9ezN8GM4eVCWQIAxenAExkDSMjwzKm55dk222ce4Mj 3ojfUvS9NXnRnmV7HeYmLOGZwavP2MTwP05X5mf8S+dVRxpWfmhLfXFAvMtuxtpdNbvMLzad5E1 XYwEA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-7.0

for you to fetch changes up to 2932095c114b98cbb40ccf34fc00d613cb17cead:

  counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member (2026-03-22 15:59:22 +0900)

----------------------------------------------------------------
Counter fixes for 7.0

Two fixes for rz-mut3-cnt: synchronize runtime PM usage count to toggle
state of the counter, and set counter->parent during probe to ensure the
current dev pointer is accessed during driver operation.

----------------------------------------------------------------
Cosmin Tanislav (2):
      counter: rz-mtu3-cnt: prevent counter from being toggled multiple times
      counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member

 drivers/counter/rz-mtu3-cnt.c | 67 ++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 32 deletions(-)
