Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D32E717B
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248236; cv=none; b=ptlY+mD0X1CAnJyy11igbDjZ+cJlSNZVNkSFM7CutOkYCNBabR3BAzMcWRdMXedQwszZBJOtzMFWg+rgWoZLVzMLAg5qiepyKZxUt1YqJWOLqnU8LVEBfT0rqYqkQSJIkFS3HdxP5x5mX0NUkm4BXgnTdoYPr4DQfCEoTJQNqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248236; c=relaxed/simple;
	bh=ZAWwLaLN/cE+jfQlCrY72ZvXTvoJsRxUHj0Dt/vxK0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NynfgPGk4MI5bAJFrztFMawuU+0CaP6s1Args6vF2XDFK578CYjFVJ3Gt8CR8L8+PMc9lwXnarPmQKRoas9IOenaQ7XfTB3UrHtZPoRjWj5MjdbbnAqLCz4wmYDE5Et0o31P063WPfYVgqp+OPxk87Xhh7CaBkGUKntKt/RMtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzbwMgdj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzbwMgdj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53522C116C6;
	Mon, 16 Feb 2026 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248236;
	bh=ZAWwLaLN/cE+jfQlCrY72ZvXTvoJsRxUHj0Dt/vxK0c=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HzbwMgdjTK72DrMDegH/K9SSUDOPVuMNwo7WlGE6YT1EBReLJNRmSJexIUcBv2Uhu
	 goF+YQBN0Sx9hkpD/EL55EFl+Vpj9xhlh+B+VGouCUzTf6w0VCpZJP3Km/ik/7O5Zt
	 lp6beepbpz+nnBSXsoLf5H1wpUr1de+LD2cK4YcoiRonOEPvMlUJD+dXbxF1oK+TBN
	 rKYz4E3hWADLZe8aMFZDdQGsNTVVG4w5C3WmD8CYgSnErun3DeFlI1FYK77xVbdfeg
	 PK/gwGCikKofRsgOQdUmkgucvvkErY2jYyDfiiSdPVGemVrLqAtbQAcyYeZzAdQxe1
	 oLXomXLMmG++Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E4BE7BDB4;
	Mon, 16 Feb 2026 13:23:56 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 16 Feb 2026 13:24:27 +0000
Subject: [PATCH] iio: buffer: Fix wait_queue not being removed
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-iio-buffer-write-fix-v1-1-bc08b239f37a@analog.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23IJaSPQr0UFzrb1UrL1A+vek4
 wzMZEgkTAn6KoPQxYm3tYCuK5gWt86EHAqDUcYqoy0yb+jPGEnwFj4IIz/Y6BBi541rnYKS7kJ
 F/9thfN8PqEMt72YAAAA=
X-Change-ID: 20260216-iio-buffer-write-fix-31ddf8b2a4a0
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771248279; l=1108;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=wgGaI/gfKqTtshRUq5bR1f6wLAM/nnkZhqCz5oA7qag=;
 b=bG9bTAk4c9iO1DsO79uD+3MlBL/AGa6EaxSdcj0pNaGl0ji7vPpH33k65sfLmZSsL8LpubgNi
 /FEcDHJ5MVXCW4KluMqO4/0loz/G5FJ1b/p1CsNF+vmuXpcx3MObGxV
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

In the edge case where the IIO device is unregistered while we're
buffering, we were directly returning an error without removing the wait
queue. Instead, set 'ret' and break out of the loop.

Fixes: 9eeee3b0bf19 ("iio: Add output buffer support")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c6259213e150..a09c0d263d7f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -228,8 +228,10 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
 	written = 0;
 	add_wait_queue(&rb->pollq, &wait);
 	do {
-		if (!indio_dev->info)
-			return -ENODEV;
+		if (!indio_dev->info) {
+			ret = -ENODEV;
+			break;
+		}
 
 		if (!iio_buffer_space_available(rb)) {
 			if (signal_pending(current)) {

---
base-commit: f52690c50893ef1504990199c8a2dfbb869f38c6
change-id: 20260216-iio-buffer-write-fix-31ddf8b2a4a0
--

Thanks!
- Nuno Sá


