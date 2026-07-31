Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A16470128
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522264; cv=none; b=XISbUMSSNTZPXO4wSZH2Cj8E0auzgsl/XJM8zKDOlO0HUL2/dGAL49Evk5SmTM9/2MS+RmRL3VJKTUIDDRtXUMHn3uE+rcP21K3c0vaL/EAxSCI9UNs8VDvYBcHSz0hoTr6Yqag8VPOC8hReycq6xFVJxjS0OXPBsQSMePBFmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522264; c=relaxed/simple;
	bh=EPY5u/ZBN4AuBkuSxbn9+BI/xZDkdQvnzEg57jzxv4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqhJXo/NkRssQrk3HWjLPL2K0DLVOvyPDsZyuGHPq8OJArMgg5DrAJNJL7xHubclr3d+rsVICvfCH0+P/l5uu8UnvISLtuh8oS+oxkTRpKPh8YQee9Rxm5yr7tIOKKcTooEs35ovsmA2v0DpFY6a/QOkbWkn0LYILJ+XR6V2AfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuOZe2UA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuOZe2UA"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1428842a91.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785522262; x=1786127062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDzVbcLKcPv6oSc5KVtpGnThTEkbSjdGeapuLqqH1HI=;
        b=NuOZe2UA13S9Q+6Ajsz+JrUAGC3fkWl4fhU6/8o4T16b6klag0dXBb7kYQgvE96lxR
         +mWXR76z2iCu9lKpBK4Q1RviCfto8R/ho7BU8D0rmaHOwxiExNcnSC6E6YiAV1vckAO5
         t1EpekzmiUBRkDVCyYF9hjY3YFW3iXdJhM2rk7dfITkzJBhv+WxBsLvbgjqjFaWe5Qvy
         9oWNd+AwL6AJp+63G+N3erM9enynFKIzUfQzntoSFkLOXks9syb1fCJHMr2Q/F2wHmZE
         oqTEQoo8tkmFgeiuW5pjoPspN6qbHLRjzD91Mj1blfU2FgD+ofzdeBM94QxgidZJsjMD
         FxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522262; x=1786127062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDzVbcLKcPv6oSc5KVtpGnThTEkbSjdGeapuLqqH1HI=;
        b=YTT3ajO47bEjuI/XYp/lnx75usr5o9dpDTib0OHYsU74ZS5nnxsO+q4HjloKThzTip
         FjBY1Gdke9b945b0gUSaEJwiBz/eQo7m0GsEB9x4NjWrB01q6OdAP9ScMpRyx5Ck6PZe
         O0ZZCD/7N7snxwxiMRQFY9Grvi4lzcvp0Vx/L0M84Czw8pXwh8ozkh+mdiM4WcGDfUf4
         pReJXquGWwMNLHWVHX/cIDbpDFtAP82QL8brqHmKATCu4oMGLOkPHtzyMVJrMySfmycF
         8YAhEe6jvq45j9F4dtZwOoEkStprcRpc0H3CgXRlFt3qKBUw8DLXZLMk0Ex1T51ySeju
         bw0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVb27rz8S38U19dZjaygpKjGcgWkhw9KK3ffcDKp+ZFqXMukGF3m3G+23MEPmTnpke22gFH3iV4so=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2pDUkRXcVB02CllUcN+wvVorD1UYoOEL8ZiDTLFJkcwoQ8uh
	5OQ88jd2GPhfCRsc8YJFBp0+Qu1xJwyq0RoNltFAvd+DoZN0JlH/hPta
X-Gm-Gg: AR+sD13TNFNcYGL9DSncxE1qWaZCCsgoVhOeo6gJvAE2DXG4CdkZNj4J5IFvrjyOOMA
	nL2mEg8VwsfRosJdgQsF7Q7zkBe+6ipGSgLT6pNy8BEuIoT8g7d249CTVvv9nN0Z/PzVzgt7v8k
	WAdE0711ppEARRpAc1I2r8wJnbnWtA+uPXL0/kS05UWSXOXzYtabRvxCE9gN61Yytk8l2UYg/Jd
	iXcFxKGh4tB5jNMIaxaGE6VoHNRyukc1P2pQdh+anFbe5lOrjMiJmFRNQMKK3qAiAa+O0obmavd
	wfky1dUINHs58fmphVcfimTgujoydHYB3c3B0cv7ERy90jNEEnug7RBo17mQWymLMhj2lh7u742
	GrxeTWBNT1GgtOZpoFdOioCgCu5Zz0j1GjXM5y0k36nn2EJlc+0GpTxZRFiXI/Bi/yu6uFmLyk0
	1x2UXPPKDvF527DoSQSSXFcioeQJX/ezWRIb4dfSavHdiigBNZqSKFlGlN4IQ=
X-Received: by 2002:a05:6300:6684:b0:3c3:c080:71ca with SMTP id adf61e73a8af0-3c92a26b14bmr795433637.0.1785522261990;
        Fri, 31 Jul 2026 11:24:21 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:d69c:7f00:28b4:311c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8400785eec.10.2026.07.31.11.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:24:21 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts@broadcom.com>,
	Broadcom internal kernel list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v3 1/3] iio: adc: bcm_iproc_adc: Remove redundant error message after devm_request_threaded_irq()
Date: Fri, 31 Jul 2026 23:53:45 +0530
Message-ID: <20260731182347.42888-2-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731182347.42888-1-mdshahid03@gmail.com>
References: <20260731182347.42888-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

devm_request_threaded_irq() already logs an error when the request
fails, making the explicit dev_err() redundant.

Remove the duplicate message and simply return the error.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index cf4738b16e62..1b0dd654402f 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -551,10 +551,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 				iproc_adc_interrupt_handler,
 				iproc_adc_interrupt_thread,
 				IRQF_SHARED, "iproc-adc", indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "request_irq error %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = clk_prepare_enable(adc_priv->adc_clk);
 	if (ret) {
-- 
2.43.0

