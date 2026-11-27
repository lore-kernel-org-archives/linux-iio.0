Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772886;
	b=1msnlqGeKzNt9mMa72tEMmn2FaocVlNExu8WednDbMorbpx5FUECBlL4JOgLiTXrMJCu
	 5eu781gCqQS8OQBe+2djpMbNZiYj2v6Np+nPVGwaDss+lUFR+E+tZED1JcE88VFH4s3+3
	 S1PG8kQP9y7Q6vYN5p42ukYuy2Z+Zfi/qKBmuT2KoksSmZ9MgS5wtHIyrvjZVHvuPPOsc
	 /HfMmBkVeG6SZ1UHfDAyV/g6Foflu2ngv9q9VOl2qNBhW5kj7b7yzHpG3oV9cIMJt3C4a
	 WDoRS/l744GVL/CWZ7FCaoB379LtXeU3jZiINTgFozkswDSePyqWms9xUe6hFPMU7Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772886;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VM7QE4Ethu8V3wZnaWbBoSzvQC/QKL4mYayAF97w8so=;
	b=CyH78PVTAVqVkX20s6jgF/ftSVVeOnW5QlBV0KtwJEWfUdIRqcx044IT4qapmDRdg0wL
	 MGH6zsKQ4vJa3p4FUOaupAqSIFZAniVuOIcAujvSODhqmtz3D35NWiTM+m20rDD790CiI
	 ihvYr1zPryzISbiX9A6FKjPnhBYwfxcUqRAgufJ8MFN12kAmERbFfEHdCwT1oNyXg5a5U
	 7OTowUXK2qgCTTcamjhOk2wlgtgDhD5a/LGiHCHJep3IGw8LPm5yGYA/OFEIR1tGfyO8F
	 j5e6F3ojcf3V+JYcFJBVtQsBs4HKJwVlxipBI+jdnu+cOr0XyLKNVbnBW1SbBWsqnCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQFt1o+A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391A606A32F;
	Fri, 27 Nov 2026 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQFt1o+A
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795772886;
	b=aSPyOQQdNADU2N4IWWCB3oLqkfKzNUe8MNDjPm6h/owlgm+TokHghdtuQjowCc0wRbHd
	 4OFZfpPLUt06ksOliNKiY5yb1xuXkIRsq8KyS7nWXPxSbSI6KIrR4sM2G9rAJvKdApoCq
	 Wo1I6zhGqTmbwWxnl5jQV2gQkJ0BD0GwNz0kI7uu1E6/PuqHHAmImD9LPnrLDa4CXcppg
	 sD4aU4NiafBPeddYu4sZx3qzL43jEjrtEcGY4x7IeV05AFmK7fDAZ/qmVZ5R3UcKFpM6P
	 IRBwT4B5yiJuU13HGenVvEDe5uBo7E4wUiynn0HrupfHhkUZeLHkClG8pJ0N+4IIC5w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795772886;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VM7QE4Ethu8V3wZnaWbBoSzvQC/QKL4mYayAF97w8so=;
	b=LwYfIcG5wSNKYr6e3J46oJX5vBLs0sWWur6yRqLJ//747KjzjvOz6z7II0XaddfWB4FQ
	 kNIzSCmJZwgP892jvZdEsBbCONgeVC5q892m7OSsJ5pCSfiKM1uwpC3H81MjSPGYS0d/R
	 1+jAT4AOZ3IpP3w0Z9ykwyoKme6X/2cKJfSD3m6qtMKLeq+GOu1CjD5J7Kwo9zmtPrKYd
	 xzIJGGjRxBelS4t7YFFH6hnxt7UMeCsYvEc4IzqRVMF0/CojKa1ShKREHZeg0gb5SSTv1
	 0io99iGKiQNTT6fshVHqiLV5VT4CtMrC5ruJnLWAeGypAnDA/kcKki/H8ch4PPo5Ssw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC82A1F00898;
	Fri, 27 Nov 2026 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795772886;
	bh=VM7QE4Ethu8V3wZnaWbBoSzvQC/QKL4mYayAF97w8so=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TQFt1o+AZIGmk2Hltdtzi80OzNllhw5DGMQ4W0Yn2Jwqs6Cs3sBsLptDI7LtZEOjQ
	 /hTNf+9g7oIBEuF4dkvt3TRzQyl9E/btW58AkcpUyCgA6tN+riiscWF5GWQrnZvtjM
	 A1N5UxA1pA0zy/7+bqOAkYpfTNebm63KI5AISvEVnyzC26XxKf/n7m2bBUQk95h2VV
	 vkmaMHWoJpZff3OVts8bwFXGNJosF+ETc+fEd9fyXtTBEG+IElD0DfIwKw2T15ZNcZ
	 lI7vs3e97UF3KRsIEJyjur+6o7U0jKtxoGZRXmYvRAwEhyPYCp7nYAP3elBgQ8MzKB
	 krVnU9/cFsogw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 576CF4B6C4;
	Fri, 27 Nov 2026 09:47:56 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 27 Nov 2026 09:47:44 +0000
Subject: [PATCH v2 1/5] iio: core: emit channel prefixes into a struct
 seq_buf
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
Message-Id: <20261127-iio-core-attr-review-v2-1-e0aed1e8a81c@analog.com>
References: <20261127-iio-core-attr-review-v2-0-e0aed1e8a81c@analog.com>
In-Reply-To: <20261127-iio-core-attr-review-v2-0-e0aed1e8a81c@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795772875; l=3352;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=dMRekQ/faBreODE2xVwTa3Gmbpv2kNnDqBlJ6+rvKGA=;
 b=uPgcgI1EKqF3hLPjrSBFZipofI3leTzGnDx6RE9iKl0DN1CeWRhr0UuDC4mOFIFPJa0heSDBi
 gBhRLvdt+KRD9VzpEm0vmEyZp7BQtXDTnBZ954ywOsR/2b3wyu8tlQu
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

__iio_chan_prefix_emit() builds the channel prefix of an attribute name
through a struct seq_buf that is local to the function, so a caller that
wants to append to the prefix has to deal with the buffer offset itself.

Move the prefix logic into iio_chan_prefix_seq_buf(), which takes the
struct seq_buf directly and returns the length of the prefix, and keep
__iio_chan_prefix_emit() as a wrapper for its current users. This lets
the IIO core build a full attribute name in a single struct seq_buf.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 46 ++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index dabd57a0994e..5267a9c5908c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -206,28 +206,24 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_POWERFACTOR] = "powerfactor",
 };
 
-VISIBLE_IF_KUNIT
-ssize_t __iio_chan_prefix_emit(struct device *dev,
-			       const struct iio_chan_spec *chan,
-			       enum iio_shared_by shared_by,
-			       char *buf, size_t len)
+static ssize_t iio_chan_prefix_seq_buf(struct device *dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_shared_by shared_by,
+				       struct seq_buf *s)
 {
 	const char *type = iio_chan_type_name_spec[chan->type];
 	const char *dir = iio_direction[chan->output];
-	struct seq_buf s;
-
-	seq_buf_init(&s, buf, len);
 
 	switch (shared_by) {
 	case IIO_SHARED_BY_ALL:
 		break;
 	case IIO_SHARED_BY_DIR:
-		seq_buf_printf(&s, "%s", dir);
+		seq_buf_printf(s, "%s", dir);
 		break;
 	case IIO_SHARED_BY_TYPE:
-		seq_buf_printf(&s, "%s_%s", dir, type);
+		seq_buf_printf(s, "%s_%s", dir, type);
 		if (chan->differential)
-			seq_buf_printf(&s, "-%s", type);
+			seq_buf_printf(s, "-%s", type);
 		break;
 	case IIO_SEPARATE:
 		/* Validate differential channel settings */
@@ -242,23 +238,39 @@ ssize_t __iio_chan_prefix_emit(struct device *dev,
 			}
 		}
 
-		seq_buf_printf(&s, "%s_%s", dir, type);
+		seq_buf_printf(s, "%s_%s", dir, type);
 
 		if (chan->indexed)
-			seq_buf_printf(&s, "%d", chan->channel);
+			seq_buf_printf(s, "%d", chan->channel);
 
 		if (chan->differential)
-			seq_buf_printf(&s, "-%s%d", type, chan->channel2);
+			seq_buf_printf(s, "-%s%d", type, chan->channel2);
 
 		if (chan->modified)
-			seq_buf_printf(&s, "_%s", iio_modifier_names[chan->channel2]);
+			seq_buf_printf(s, "_%s", iio_modifier_names[chan->channel2]);
 
 		if (chan->extend_name)
-			seq_buf_printf(&s, "_%s", chan->extend_name);
+			seq_buf_printf(s, "_%s", chan->extend_name);
 		break;
 	}
 
-	return seq_buf_has_overflowed(&s) ? -EOVERFLOW : s.len;
+	if (seq_buf_has_overflowed(s))
+		return -EOVERFLOW;
+
+	return seq_buf_used(s);
+}
+
+VISIBLE_IF_KUNIT
+ssize_t __iio_chan_prefix_emit(struct device *dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_shared_by shared_by,
+			       char *buf, size_t len)
+{
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, len);
+
+	return iio_chan_prefix_seq_buf(dev, chan, shared_by, &s);
 }
 EXPORT_SYMBOL_IF_KUNIT(__iio_chan_prefix_emit);
 

-- 
2.43.0


