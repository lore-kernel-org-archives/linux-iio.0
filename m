Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA812F25F5
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045896; cv=none; b=I3tvBm35XwM8840LmYPUXtRIPMau5ib/ukJxKRVQIEoIlTOtm9jFa2896TmW4eIMLHN3IWa2aWclfJXnc/GDBb9w4KsPBCas9cZxoMu+un+fygtcoKAKQowf9saCOSNNyqUwxjE+2PDhOTaEyJrpqnXTPFZZ1BU/AG+8Q/aTAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045896; c=relaxed/simple;
	bh=/WOCyJEW+od5ft3M4X2oIZveeAvWKQJyqutxIGTLdT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsSrg6LZ6DTuJQCF1mB5KkIqO64VazevHQ+QO3lNW3PQfLII+lDMKGE0LEClAKt4ZH21UtvtrKkpVOYiKlcwSOBKx3QbXjdFXOG4bp9jG2eGWjNIdLbgiInv4YALD0i4Y9F5xSeU0GQWpadXAICUiaUSNAM9a8gpCHdsrqljN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcIiZ/yS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcIiZ/yS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316F9C4CEF7;
	Wed,  1 Apr 2026 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775045895;
	bh=/WOCyJEW+od5ft3M4X2oIZveeAvWKQJyqutxIGTLdT4=;
	h=From:To:Cc:Subject:Date:From;
	b=DcIiZ/ySYQn+jfd1Wx1gav4ZPhVEG32Hb9zJNU0DYhczzOOTIIyWMX5+ABZdUypRd
	 4qqxq49bsHJXPvUeb2jro1u0PKXKuKTWBJCXuldHhqlxK96j4s+Mo+dQhKbfnUTRLp
	 aBwXymGj/8nOq5PlyK/6csEHug7UIGFLqVrVqqYvNMg05rjacqBRBKwC/yS1GcPOru
	 J+hOtERiebjHYnHdh+c502wdeZuOl81qwDLbRXEkaDd+DQ2hv8qHwC1gPYdbBWCWNC
	 ZLk/wa+Tf15uwh894dvsv7+PxkOJmB76aDcF/4i3DBt/yyaVSoraOqLl4JSsQq9mWG
	 rdR4FViIqGebA==
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org
Subject: Counter fixes for 7.0
Date: Wed,  1 Apr 2026 21:18:00 +0900
Message-ID: <20260401121804.2017278-1-wbg@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=wbg@kernel.org; h=from:subject; bh=/WOCyJEW+od5ft3M4X2oIZveeAvWKQJyqutxIGTLdT4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJlneR5Z7TXtDC+M59+VG6k9/+Az9vyHkzZZZ5iqzhcq0 TV62Xqto5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZiI8ByGX8yyay/88dn4t+Bz 0e6Dz2d8azrrsTy+dfG8fcsUOeyP7Zdh+B/7beLeP4tOxmltkIy/uPFitFNPXLT8hdl2bQJqGQq efMwA
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
