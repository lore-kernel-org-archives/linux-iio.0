Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467388;
	b=s9GxdVJjg4VHER/e7hqr7bRH7tIEEFzf9dUjBqPQFArKqxSqQ1L20sIsCKqVmiieGSp+
	 O2Kbh0CPsHfHFF87n6kGOfeWX/TlnBujWthmTHMZaYVj/chX7wqXD01UYZ6PlzOIrMdwC
	 3cqy3daZwCiVlSha7IAM+RGnrx9XFLX5fTPqMpfXDr1IYwllttIe6mGsijm1NQs6AxCdE
	 H93L+UkZyHt1BD/sqKDP2UdF/Tpy7jNBm71xyY/ObhPqdpI0kYxOQfN1m2dkdB5s6j3zh
	 p9uBqyfi5Cox1lwGBY15iAIh4OowDsS2KlTOnCRURErmnbyqfhSlG8tqtBJGZgwxlYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ga64ejtKP8vihbB5AdVC6YmsQYSLFpLgjmPK9HX3a5U=;
	b=CCPTYtOkU8pw86mAXNBeAb/mXEncL+yNzEkfV1Wd9A9p0evEoTPj/sv6Ba467IEF2bTp
	 +G4KrUGqfYU+MasRbJd5kWaVriSmDxKblQrzHfFO/z26x2U0B8v6Mg41YPd3gS/sFVNJG
	 /R2+FHGR3ZIj3ifRf7qh+naCiyKlxpMhMIDMrTBIuggp2nWh/H9kAU+Ar1BYXCk/Z4YuY
	 GdijcwkaAJwVrA6UAx3PmnClqUMS1g6yHAVQYgHtlHV57B5v+c7f/L2ceaNcfhRwu9dgR
	 9PRyh+H7WZrKSX8eweD4bg+xMvUkwHQACzQzn4at9eWURLXQcPwNHiOGyX/PIbtHsNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m3/m0vYe";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66DA606A321
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 07:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A66DA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m3/m0vYe
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed28bac8d7so2960155ad.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 23:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794467387; x=1795072187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ga64ejtKP8vihbB5AdVC6YmsQYSLFpLgjmPK9HX3a5U=;
        b=m3/m0vYeupFvjQNaPjKDPkFLsUyXx9jEBdrB0K1bpkO3alQdtmo1vE+zim9W8ipoXm
         +9YM8b11z+WNi/nDDC3DMbU5inU+uVXRq7aWUWs9jjGjhBMXGTEfo103skUpDsn7fCnT
         f70uWmd4HO0wtacdDI1d9Xo0oYw8T/ng/ffHRdDJ68onriuRZCcMt+aqS72T8Wop8C6v
         7y6HZPKmg++iVkV+Pe49Z5b+VJOELM1lneEL3VTp+8rIb6PGq1Qwuh2s41IQ6VcWGzxm
         HUzwW78xhHKytox5cImMVH7URg3wjo97rdv5ILq0kdgTrxo3S72CKU6AeYIqa1JxsaJo
         0TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467387; x=1795072187;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ga64ejtKP8vihbB5AdVC6YmsQYSLFpLgjmPK9HX3a5U=;
        b=OmbN6OFx2wXq4V9+MmpDUH8V7X15iCODZeg8tXBMASPdjgKNzuoW7brImqw+6e2w9i
         GFoxB+9fcn+75xQwS40I3xk5RZpEsyQDRGeNY0JX4WrkPaUMenhOjKOqRos+3AdDm+ts
         OVdjGOpW9nDRaTvHITjBrm8q17FsxnV33krGzI4mXLKvUzrVtWZxCoChyuo+IK35i6Af
         4NR+Dha7ugSAlVA0KAXSM1ygBuldkyiIrgv/DLyZ3ie6isSBWkAkso+xIRcm+B+YPWfm
         yw3gkcyR2oTtsbU4sIkKcCAcActvXWqOQ2Kj0I2xzxnxyJcp2RFddpSkoTP2jHZwpo8Y
         jd5A==
X-Forwarded-Encrypted: i=1; AL+hErG9qXPArNqlgTRJj+kMbE2FDVxXwoexj7r/JCkH69w80IT7EA7EEO35wx7nVz2Ru+1SGyDAx7e7cVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nF3yBqWP9UGFGl48RoFGd0NxrZCUIiwu+c9SF76Gi2SLCtDQP
	7OUupiSdtZsrziF7jzv0/zOTC8F6zFCZOBKXUNlqB61M67Vy0Y5Go3Ur
X-Gm-Gg: AYBFou0LL9EpExlXOnNTnREqFDupMQj3DPloo+zsquXxKhdh4RCvcIB3VqaV6VJTzYK
	BnLzc+a+IAZ8y0wJYPd/l/LKlnZ4RlxITdm8W/ThRRAqQbp8pSldBhXyjhiFZuFXVCH+WEOt3jO
	vaLVTKVSVoqejkpmEc7PWBJGp1ohfEyrVDq950GP698PVFwgwSOngqb921HY8zr5Tee3zmc3mwI
	PkFqjpr8dpwPuF7O14HIcDMqZ4rCAn7Q7nqelZrxURfoo8km2qSkZtIuxcxoR0NWK40ZkgNprPc
	GkmmvyhvLjEtlIMttV18b3l9//H9UA1GdvqQKXEjPNtb/72SYjIWnWgn2VhdthSCHQ4gMzbOaiQ
	DV52EmjYBS/+8BMOJqWFNSTxJncoDOk/DaY8KHgBf2ZWyf/t3D2rFjPCi74amAPBByTRIsZwMs2
	+54t673E5ZP0YgbXYsP5coBvMrVhy/EYIgaPJfF5toC8AfGV/3jp4xs50NRPlXc7YKltCJvBPG2
	J4o5v2Ir5jB70tARE8DZ9PrProO2US0YvOX+ARpY/O1U/pzRMq1OXrpclXGaewoRIVB+BND7YFH
	PE/k3wgF1tTClZ5IFr0nvN3pCW3V03f35QpdYhoLQa/lKrRr0A+wZT2kTb8Ks2GPc0GHKFXbZAo
	ljkxtO0ipVyRcbp2KK52Zvi8aJBGYxFYUSAvACuX6yJQ=
X-Received: by 2002:a17:902:d48a:b0:2e8:5857:b5f4 with SMTP id d9443c01a7336-2edf167035amr12354095ad.10.1794467386732;
        Wed, 11 Nov 2026 23:09:46 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:29ac:0:1866])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d9baa5sm28966385ad.45.2026.11.11.23.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:09:46 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	paul@crapouillou.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: buffer: hold a reference while DMA-BUF is attached
Date: Thu, 12 Nov 2026 15:09:40 +0800
Message-Id: <20261112070940.2527455-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iio_buffer_attach_dmabuf() stores an IIO buffer pointer in the DMA-BUF
attachment without taking a buffer reference.  A delayed DMA fence
completion can release the attachment after the IIO device has been
unbound and its buffer freed.  The release callback then dereferences
the stale buffer while detaching the DMA-BUF.

Take a reference when storing the buffer in the attachment, and drop
it after the final detach or when the attach operation fails.  This
keeps the buffer alive for the asynchronous completion path.

A KASAN-enabled test with a DMA-BUF-capable IIO test device reproduced
the use-after-free on the unmodified kernel.  The same delayed
completion sequence produced no report with the change applied.

Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface infrastructure")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>

---
Changes since v1:
- Dropped the nonstandard Assisted-by trailer.
- Added Nuno Sá's Reviewed-by tag.
- The fix and the QEMU/KASAN tests were developed with AI assistance
  (ZCode/GLM-4); the author reviewed the patch and the test results.
v1: https://lore.kernel.org/r/179378580164.73301.2666197876060323279@gmail.com/
---
 drivers/iio/industrialio-buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4294101810fd7..bfa6d19471126 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1597,6 +1597,8 @@ static void iio_buffer_dmabuf_release(struct kref *ref)
 
 	buffer->access->detach_dmabuf(buffer, priv->block);
 
+	iio_buffer_put(buffer);
+
 	dma_buf_detach(attach->dmabuf, attach);
 	dma_buf_put(dmabuf);
 	kfree(priv);
@@ -1741,7 +1743,13 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 	}
 
 	kref_init(&priv->ref);
-	priv->buffer = buffer;
+	/*
+	 * Hold a reference for the asynchronous dmabuf completion path
+	 * (iio_buffer_cleanup() -> iio_buffer_dmabuf_put() may run from a
+	 * work item after the device has been unbound); released in
+	 * iio_buffer_dmabuf_release().
+	 */
+	priv->buffer = iio_buffer_get(buffer);
 	priv->attach = attach;
 	attach->importer_priv = priv;
 
@@ -1789,6 +1797,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 err_dmabuf_put:
 	dma_buf_put(dmabuf);
 err_free_priv:
+	iio_buffer_put(priv->buffer);
 	kfree(priv);
 
 	return err;
-- 
2.34.1

