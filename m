Received: from sender-pp-o92.zoho.in (sender-pp-o92.zoho.in [103.117.158.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2BF3E9C18;
	Fri, 22 May 2026 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450368; cv=pass; b=E6/80tMKbnThADMpapnBk5YoazokEFK7zTqhigl2K9Bswo1rQZFHnPqblTT1uUYTAVmw7ql8FAfTZMqJdaiAaKhqQ/bRtAkwCiUpUFTbCT6tgAcbnUfjHEvdMGCifLWf50XcXr1NzNIgcFjkUcW93yetkC6dInfYRoDVWfRkdg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450368; c=relaxed/simple;
	bh=/55F72ANKetUpObqAmrYGs8Bq0YitJFVF2vrkf5KfKc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=ms5EO9JOgEdmDDyUtSPh3bBH/P1zKt8lCtQXdCc6skkjHgs4unUel2K2XbTy+0+lBIl/34Gm4dnCuWnvGcg1cb2QO3XXDfaiywYGeO2cPUmELEL7ClqcffWaYolU3UUciKfc+JHvNoaABjUgEbQ1/2u4G7sI5F+f2aKvUYXoqMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=NR+PdhKk; arc=pass smtp.client-ip=103.117.158.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="NR+PdhKk"
ARC-Seal: i=1; a=rsa-sha256; t=1779450360; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=SvjWzvJGOIsIwwEcVeSwYUyfRUYSOYkwQveM4tdui+bWryi9CD3uQFEBeGSNScpG6mjKJoZhQiIalX5hMDbnpz9Gcl6ULD0oBuZWc8CBpyJcIxantysYgAc3yhV3DWcv/hVeuSo3mOHlN0Y6IUib+wYQaCRyURsYBzDZNuc0uiA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1779450360; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C8xCtW6Ww7fh3DCy2f5N5crFG0XXFz7tXBy9CDQahQw=; 
	b=Bl9F5gORiQAYHg2ZFYrEUTdP5XpyMW9iTh6Qb8Qds5hmMeEDyvR+00T7fguVZL6itFqr6pIUcaFidNTx4P+UzdqpHsfrRs1TFKtTFzkvSIgxRzd+PlA92ODY6276chnkFvJfkQDA3kp0ExBnyo1kl0rDfCQg+NCzb1Qr0nJgbuY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779450360;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=C8xCtW6Ww7fh3DCy2f5N5crFG0XXFz7tXBy9CDQahQw=;
	b=NR+PdhKkUSIvDSAH7P/ZIks4z1TOfTZqD+W7zQ8Z10BWxKOpn2q2+CevIWphaRNe
	ufNkBNW3EArSWtZzG32rMJSnvelDvjHnNyKYANnM2wEOBO+q6/qQJwoZR33L4oKJ9GZ
	4QHhzGvan5RRyrmcl0h1mKFR6ZW+wwO0aUCMwx6w=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1779450355425551.7817282345422; Fri, 22 May 2026 17:15:55 +0530 (IST)
Received: from  [106.219.3.73] by mail.zoho.in
	with HTTP;Fri, 22 May 2026 17:15:55 +0530 (IST)
Date: Fri, 22 May 2026 17:15:55 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "linux-iio" <linux-iio@vger.kernel.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19e4f819ed9.2157dac799522.5155742748768717789@zohomail.in>
In-Reply-To: 
Subject: [PATCH v2] iio: trigger: fix memory leak in viio_trigger_alloc()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail


From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Fri, 22 May 2026 17:11:00 +0530
Subject: [PATCH] iio: trigger: fix memory leak in viio_trigger_alloc()

Separate error paths for before/after device_initialize().

The free_trig label was used for both early errors (before
device_initialize) and late errors (after device_initialize).

Replace the unified kfree() with:
- kfree() for early errors (free_trig)
- put_device() for late errors (free_descs)

This prevents put_device() on an uninitialized device and
ensures proper reference counting cleanup.

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/iio/industrialio-trigger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 9c72e7ae996c..39208c65e6c1 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -597,9 +597,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 free_descs:
 	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
-free_trig:
 	put_device(&trig->dev);
 	return NULL;
+free_trig:
+	kfree(trig);
+	return NULL;
 }
 
 /**
--
2.43.0


