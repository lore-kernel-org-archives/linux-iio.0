Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794224346;
	b=uPX/5iBVZT+ARnLZfcAHkUsGNJN0akwD+uYVz933faTy6wkHrPgfYXyEqOeTQV6QHAA4
	 T0o6sGfJ3hQuI+PwAghy0TqlaOPMmcS6eaH/ExUuhLaS/yVtX5bSiCXNJkQYMFaEFYG56
	 Q977Q4rlx9sljS35wDvRNLVwUuNpIU2exooF9tkqMn7UHwtMx611i/zUKFMMnnuGtwCz0
	 wnJZhrGpUKYiUAsqukrPXqFCIMx9Kd01FMPH4gtfp0r/f6yWX1AdGW6kHVxGFGROT4y4+
	 pwZMUq1UDla3JkTH/WaPeQ+AihgqIITER3ZQrVplbE41XKJ/fnauCJ2o0BeLeX9qL1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224346;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=hkhAO5uRbe9AyOzMtBcySK3hZ8QRqBAHM1v0jz/Y4yE=;
	b=EBk5NSGqRajSDGZFV/IP6kmIW3CYSOoUS6T91wIPRvSPjclDc2oQo63ZCcZUegyrNV9T
	 xr+4KmU8CrN7eZ8nKIJiHO0XPwfKg0krhpr4ISYd5KogPLOrInf0E+8y24ig3nfW5bYCR
	 rfmQLyKx0j/KkQvcLxH9b2TO+wPDC9qXRCAYg1FxdI7oyrkY4zg8YxifKSP33SIF+BHtA
	 6wpCvX6OkHgdfycUJcx69dq3wJjD02sGm0kvj5tCkRvbzj+7BJyIy3MHRqdUYqkHbCDbi
	 AubcQlWVj2+EbHon35RUIdzb46Ax0ua6oxkA8cQFj5YY3KNE+2kfv/Fs0SWDf8dCm4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8f4Y3fw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301F606A326;
	Mon,  9 Nov 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8f4Y3fw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794224346;
	b=MwqUdHm/Pk1ahQaX0jG3LrZlCO8lyLrcDaGCtGPnQ6F5DI62fbBsf1BKvQ4w/f+qTjTY
	 yVdp1wZ+v7HYdjQZecADLvZ6m8ckyZA1Y4G/vro8IwkO4hm9DlyacfT6dRwFCza05bPU+
	 kiYyRrf5kVCNaUrl4/XZ4TmI8pDfL9gin4/jZcnLnJHAkgOCirNPo7WdBc0STFDLg0sbh
	 E3jqWBATqM4PBtpayu8lNNM2riq4jGRyuDNs+EwhOrVTJPcd2ezypxxltcj9QtllBoXs6
	 aSaZ+yaKT8kBDwttH5vw1q3DGCmJ4zNAkj+/BAE6qJeRKl+G3zZICJLSFGGuoTdGuOQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794224346;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=hkhAO5uRbe9AyOzMtBcySK3hZ8QRqBAHM1v0jz/Y4yE=;
	b=PBFRzsj4eOYdru3efCGIyWENZF6MJOF834G82HFXA4Myx99gZIChrzLMyVaSR//0qvgt
	 JiTRSkzoQynOEFYUrB55ap+PmxYBSTbVj7jq/GyBfvdU7EiJNmpKh5ctoM8Us1H5s/tGI
	 UGYMgekrd8EJGXUBNwv6bBpw3VoaFU0+1sekiXUfoB5+GhiiQCRHNOTgOKs5izjmiwFi1
	 pDbBxObrBcJscDx2CtYqGEFwtsDkyAGMh07xQvf9SMBy7nswkLvRcXpRgEllDuoZkuE44
	 FDm9dPfoh6sPEswDOGxSsif42Cfw8oAVJ7glQRyu4n5zpG67y6m/3jG7SJb3z65sHzQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A78C1F008A2;
	Mon,  9 Nov 2026 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224346;
	bh=hkhAO5uRbe9AyOzMtBcySK3hZ8QRqBAHM1v0jz/Y4yE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=l8f4Y3fwJ6GfJvCEii/q8fOj5iqIIfpwelx6iuFsUUaVOGQPk5COprQ/iXlNAvgBo
	 hcyLUsdGTbNtsWrnYXnE1jPvgKcQ99qshNQQJU8DHzM1AnB57VRQ/ugqB8cwjQFkqc
	 gIN/M3aMU6IpBr0yMeG8FEx8uv30u1TR4ia6dbe/9EsldzXm95Q3eR7ViYU2LI1E6u
	 LxxqvRuwyUH+pj2gN7HgU237gO8+L42vEXDhcXWGN/953scrihXEsj0puF7pxKv0G3
	 dTy+GzgCFG+sPLGfM9b3gBeE4X0Yds6eLuG4/FunpeBjscxiYU6B3GzIeyRKiYwt2e
	 MR9YjErSE/3lw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 89969483EA;
	Mon,  9 Nov 2026 11:39:04 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Subject: [PATCH 0/2] iio: light: adux1020: fix proximity measurement issues
Date: Mon, 09 Nov 2026 11:39:01 +0000
Message-Id: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQ6CMBCE4auQfXaTtiKCVzE+tDDVNQFN1xoSw
 t0t8vhl8s9CiiRQulQLJXxF5TUV2ENF/cNPd7AMxeSMa6w1Hfshz9Y4wyO85gSOMkO5i8cQ2rq
 O51NLJX4n/IfSXm+7NYcn+s/2Ruv6Az9WMdN6AAAA
X-Change-ID: 20261109-adux1020-measure-fixes-9f3bb844f758
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794224343; l=1623;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=2Gdy8ztYs31P4MGi0uVjJ2HcIDHZ0VjZXsn3fGJQTSM=;
 b=W2E7lj03k+H/PAnWCUQnAZ+Li1H297foRYcibX1kSh9oLx7Jm0TvSRhfD4OARnkUKv1Byszmo
 LPL2pMjwUeHCwdnVKnHKo8DlZgty8nuw2f8PPJix4Li9ZWMEn8pIeyv
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com

While testing the guard() conversion of this driver with i2c-stub, I
found two issues in adux1020_measure().

Patch 1 fixes a real bug: the interrupt clear value is computed as
~u16, which integer promotion turns into 0xffffff0f. Plain I2C
adapters silently truncate it to 0xff0f, but SMBus-only adapters reject
it with -EINVAL, so every proximity read fails on them.

Patch 2 extracts the FIFO byte count with FIELD_GET(). The current code
compares the unshifted field against the packet size. Per the
datasheet, the FIFO only stores complete packets, so this does not
misbehave on a working device, hence no Fixes tag.

Tested on arm64 QEMU with i2c-stub (an SMBus-only adapter), lockdep and
UBSAN enabled, planting FIFO byte counts in INT_STATUS by hand:
- before: reads fail with -EINVAL
- patch 1: count 2 returns the planted sample; count 1 also returns it
  (issue fixed by patch 2); count 0 times out with -EIO
- patch 1+2: count 2 returns the sample; counts 1 and 0 time out with
  -EIO
No lockdep or UBSAN reports.

I prepared these patches with the help of an AI coding assistant, and
reviewed and tested them myself.

---
Raffaele Tranfaglia (2):
      iio: light: adux1020: fix interrupt clear value on SMBus-only adapters
      iio: light: adux1020: extract the FIFO byte count with FIELD_GET()

 drivers/iio/light/adux1020.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: b70566610b48ba49dec636019da4d696db64b085
change-id: 20261109-adux1020-measure-fixes-9f3bb844f758

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


