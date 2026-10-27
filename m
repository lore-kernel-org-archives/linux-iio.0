Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117962;
	b=ox2IAl7uuFbMr5ca3gWM0GL+Y2kaFBXAWbWUTXbPiGF280wbMuH2SyK0MiJbwZV5uqFp
	 Igit7Z0CStFjDz8tfOB2VIFh5ybzUTsl822HNjJH8/tlszytJEPEVgEMhqLNghKKbBOsl
	 9GLGClbOupNzyvsM4h/zHJJ54eOzoSa47lXYtUIIgPysCoKdmkLOv39OtbL+DUCNCsET7
	 31tunKccQRcoU9Q3RAMCAOs1112G/76PnHNq9lknz6uc9UjLs7mjVqHBYEglsXLoDro5f
	 1bPHPIVlxJDuDn4b7XVqm1P+xb0QDUGne/1s6WHN5cl2bLkgcb7M9hmQLfr+9D/UMDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117962;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=m8poRwtRD9MmS85JEw/kt/a0mOjztmA/81bAlIIaYcY=;
	b=Fx2Dby9rdpAuim2ncyNsMQYERUVvUe0AeQipWRvmoz2JGz4tuPDdjQ7qfT0gDKPFa96u
	 110Ptqso+5nH899h3LnOCpR5dS45FaucXDrWxGf/Jz3Rnv6tZe7o+M5LtishWKuxqf420
	 StnNWFq/a+COZe/KwS+UKAEEAA3J8r8BBBPOBegK8HJPEveB/+/mND2sEZ0rVq6izzB/G
	 OTl6HogwLxKt+NHtIx5ikPAfHvF2b1K+/NFMXvwGy3b0pJCOfPGLCuw4j/0OsKZa53N7w
	 FDg1VjSBWS1FQ5soNEiF1bvhlnGe1JSgE0TyrR0xi2BnLj/eOMIss/nHnRktVyhn+Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=S0PSUSaV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F2606A32A;
	Tue, 27 Oct 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=S0PSUSaV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914CA1F01825;
	Tue, 27 Oct 2026 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117962;
	bh=m8poRwtRD9MmS85JEw/kt/a0mOjztmA/81bAlIIaYcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S0PSUSaVquziF2Ebfd4DuBoBHPbJlNrFHUeMnzMDFji5lPFgbT786HpmlIA68HqNS
	 D+Szna9qllNhmHMrVvNO63cm6oSkLwmv6bmKTGr+9sEBhxUZ5Psm/31vC1sCS3j4Vg
	 5Yfzz6rutWxx8NZHsNF8wV59Mvw8bWJadRyoFRQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:06 +0100
Subject: [PATCH 02/15] iio: trigger: fail the attach if no sub-IRQ is left
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-2-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Leonard Crestez <cdleonard@gmail.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=iCZh3qp1rjwlzXQzeVwW+kjkM3JYPRk0ie5cHsAjDR4=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjPdffnAb6t3jo7y6Rfli+rtTvttuBv/5PKDh/u0F
 J1vu1r96YhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJZN1lmMXcv7/j6LKNvg/0
 /gpL+/387be+JYphntqaI9ZLmDfcXbzRUOuXuZHNzwozTwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

A trigger can serve CONFIG_IIO_CONSUMERS_PER_TRIGGER devices, two by
default.  When one more device is attached, iio_trigger_get_irq() returns
-ENOMEM.  iio_trigger_attach_poll_func() prints an error, drops the module
reference and jumps to its exit, but ret is still 0 there, so it reports
success.

iio_enable_buffers() goes on as if the poll function were attached.  The
write to buffer/enable succeeds, but no sample ever arrives.  When the
buffer is disabled again, iio_trigger_detach_poll_func() undoes an attach
which has not taken place, with -ENOMEM in pf->irq:

 - iio_trigger_put_irq() calls clear_bit() with the bit number
   -ENOMEM - trig->subirq_base, which clears a bit in whatever lies in
   front of trig->pool;
 - if only one of the real consumers is left, the trigger is switched off
   under it;
 - module_put() drops a reference to the driver module which has been
   dropped already.

All it takes is to set the same trigger as current_trigger of three
devices and to enable their buffers.

Return the error.

Fixes: 995438233579 ("iio: Fix error handling in iio_trigger_attach_poll_func")
Cc: stable <stable@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Leonard Crestez <cdleonard@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/industrialio-trigger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 76926fee0f84..fc4651490d42 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -293,6 +293,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	if (pf->irq < 0) {
 		pr_err("Could not find an available irq for trigger %s, CONFIG_IIO_CONSUMERS_PER_TRIGGER=%d limit might be exceeded\n",
 			trig->name, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+		ret = pf->irq;
 		goto out_put_module;
 	}
 

-- 
2.56.0

