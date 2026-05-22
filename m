Received: from sender-pp-o92.zoho.in (sender-pp-o92.zoho.in [103.117.158.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23003AC0FE
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442302; cv=pass; b=s0Z8ud2A240enwdVjAW44rtzSp/kHlJEqPl+B7H4ZV2ZbTdzqqp7vnnBo19/CkJSGZSvfOqfxtN+bfP8gI9lE6MlODNYxrA9jBzs0lQnR2aFHZQ02Oxvu7v1NucbrwOrjwsZkn7gq8dyKVa7mnyg/ImASVaQJgxqE3YTd3GE9RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442302; c=relaxed/simple;
	bh=yeCnTHABEBFEdbL3/TtvF20l0zdCUVgJ7bzITzmTHAA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=r5BSMuvw7M4z0vta9d+Z8AzuZNi6Hh49C/O6ea1jxjXqcKzjUZ3whMjgqA668Q/hCibZvBENchooc8czCA7QiFj0efmpYX9CpuFij9GII8Ua2M2f+y3V453BUYVU//Ahb1M1ekUFAHVNVg+qZnxWe4zVSrNUnQ5H6UXzsE7QkEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=ZCj0JM/4; arc=pass smtp.client-ip=103.117.158.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="ZCj0JM/4"
ARC-Seal: i=1; a=rsa-sha256; t=1779442287; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=eTRPNSRHFIXMlXYfZKojaC3huZN3YYkQUwMvzuHoGFO/V0KBYGlZX5rd/P3V6t/u6UfMtzjtvdRTBWingYQGq8CpkmrxYPbvgtHD0RqTQoxx9XbwJuUQS5c6QSX3wWzEuWMHco3X4eH8cLeEkG7vACh0blaNJhgRTOkg4UHudAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1779442287; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YfgeuzNGEEJiy01bwgr9Ks2WekbqE05VMitv4neQyHs=; 
	b=IdGgaodMUG7taGx//VQehc2nFLuit0b+jne1onGAWE8M8MCWZzJb0NHV3dwVyoxk3jfsO17CMGQ9aUY8beDVck1sa1PgmUCZDFEsr4aUNSIzNzUuUkxgpOOGNLhEBvxXD87BnrH7KjM0l/NBEaHXyHBgO5Fmsau5ho7R4U7uKXw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779442287;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YfgeuzNGEEJiy01bwgr9Ks2WekbqE05VMitv4neQyHs=;
	b=ZCj0JM/4wO6sTGm6YSetlopNwy5MML1haY6kixFroE5nprDlAk8UZT0Po5perxU6
	hzkDwAZMteEOQeRm4w/bgvMgEjj8jkmAZnZxyxU+o0mExeqJDOjXp8pxseg1VdI1UbN
	nMO4+PaUJ2fHDbLM+SEvL6kZH0Tb0VlvmTrU9iDA=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1779442281816671.7543808837889; Fri, 22 May 2026 15:01:21 +0530 (IST)
Received: from  [106.219.5.223] by mail.zoho.in
	with HTTP;Fri, 22 May 2026 15:01:21 +0530 (IST)
Date: Fri, 22 May 2026 15:01:21 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "linux-iio" <linux-iio@vger.kernel.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19e4f066d51.4e6bc94b96251.5845269359367162045@zohomail.in>
In-Reply-To: 
Subject: [PATCH] iio: trigger: fix memory leak in viio_trigger_alloc()
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
Date: Fri, 22 May 2026 14:34:46 +0530
Subject: [PATCH] iio: trigger: fix memory leak in viio_trigger_alloc()

Replace direct kfree() with put_device() in the error path after
device_initialize() has been called.

The direct kfree() bypasses the reference counting mechanism,
causing memory leak and potential use-after-free.

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 17781c12bc85..9c72e7ae996c 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -598,7 +598,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 free_descs:
 	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 free_trig:
-	kfree(trig);
+	put_device(&trig->dev);
 	return NULL;
 }

--
2.43.0
