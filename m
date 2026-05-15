Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0D3016F7
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825727; cv=none; b=XZWDr3JldqQLoTpYDJL4/aqLEiWb1VweqlqWELlXw2DrF2Tx+PJy5DcrlQGBM1j7ZuW3mvVAAFXCv+aGbcHyVfFEdefW1yxvCn3f9Ydn1EXs87QDQe3yL8O5ING292o56HYkXOH6K/Ay1+a+56EiP8hIZGoG6Myufh1K5RovHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825727; c=relaxed/simple;
	bh=4Rk6pbputitLgjygjhZYWBF4yYuAKbTQIWa+MCCTLCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LsGSbUmxYPU3Zkwe/rsUq8rUU7RzcADJxTJwJMG7UfdvZeB8TxKDHZFtsfYq6Q5mhIF87lVXKA7H/E/wnnYvyajrmnHKLX4mk8crLEtcovHk/KRkpiwkFNNBdX6MCEzbJRkf5itXKDIY6BWuCR9R+AdEDPe2L4Gz9y3AT2iYjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I17Thr2S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I17Thr2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44465C2BCB0;
	Fri, 15 May 2026 06:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778825727;
	bh=4Rk6pbputitLgjygjhZYWBF4yYuAKbTQIWa+MCCTLCc=;
	h=From:To:Cc:Subject:Date:From;
	b=I17Thr2SeHUz/6zFCf8/bt6Z7OCJd4x8GMY1mf8ON0QnMrcD59tKb9XJsbPTELK4Z
	 2ePX1iTsYqymHcBWkq42XHiTJIbcajOFIRH7k/i9qq5vay+WISqcx1RAUwLgXIdDe/
	 ktcgNzghIJzzBMY/J4BY0Of6SctKvPYijsTnqrmkWKYk+h8vJhJ/W6Y7STqMTS1EhV
	 p9B12Rnocc77WWaePPvI88fViaILWOLjacVLYwox8VD8eyTx504fWqRtTB1uiwq8GC
	 qFV9Cu1aQxyWEt8IWQo9h0sts07RfApR31Yg4q4vwVH3Cj+4PcRSq2GaiH9RwDKZX1
	 GkQKal16anxmQ==
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter fixes for 7.1
Date: Fri, 15 May 2026 15:15:17 +0900
Message-ID: <20260515061519.339714-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=wbg@kernel.org; h=from:subject; bh=4Rk6pbputitLgjygjhZYWBF4yYuAKbTQIWa+MCCTLCc=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlsO9dNU302Q+SkFOeVSQn+OgpMK9u4qqq5CqeE7qjU3 Hg+zHNRRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjARMRFGhqdeP03sq6TnLYlR Pb+ALXSN+vTgkD3aoR2iQoefe5kYpDAyTPmeMavyg9qZOaXr7BbZVt4NWZci9MCyUY/nmMj/GwL S/AA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-7.1

for you to fetch changes up to d9eeb0ea0d2de658663bfaa9c26eccdd8fd64440:

  counter: Fix refcount leak in counter_alloc() error path (2026-05-03 13:48:39 +0900)

----------------------------------------------------------------
Counter fixes for 7.1

A fix to plug a refcount leak in counter_alloc() if dev_set_name() fails
and the error path is taken.

----------------------------------------------------------------
Guangshuo Li (1):
      counter: Fix refcount leak in counter_alloc() error path

 drivers/counter/counter-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
