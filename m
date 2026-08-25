Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A83DE430
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650936; cv=none; b=O/rstwopBsvm4xcXdof7N25FQgK5/vGb3NhgTZfWD0HGxQs1NquGmkmXvTbLbNuWJn5+efcFzfZHMTywuf91+vu62n1050aNSpi6bKsxcicT/8tBBHaHQuJX2DHWSWT7x5aZyIY4qziL1p//GuWTA7hHeiev4bx+RwpaFAqLUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650936; c=relaxed/simple;
	bh=sgkUUUofKk4XRaG+J0UMLKLbX06fVhxE4SnsPsEWBwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak9kc+Sh5cuSqTm46FH8yYitKzlm8Au+AsIlqoXYs8lMeifI0GTCBG3Hw3FTLJWLAXpyQgMieHrPSrcEpA7oKrjKtGC7r61e3IhHv7F5lJng+4bVsbkpxE/JF2HlUu8a7NrRTNf64YnQde8dCwNDyH7CVLR/xpdL5Rh7rxMytm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmQGZPhS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmQGZPhS"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so8683520a12.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 02:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787650933; x=1788255733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JK28XhYIm59KeOaoUdt1w0lQmpTjtM9MMAoGURUqk6s=;
        b=FmQGZPhS5g/mhWXLq4Yyp4k992G/aCCeLUypev7dMdCNXS7813F0oKJjTD3w/fXOSC
         Fi/Vxrbun8aSaJePSeHAScAcNJro1eHBhCSf3g61Ww9xcGhgN/rwh7OLOe2Y38KtYYu2
         WFmxhW6x502vAhY2xzJg7L9mhgFRjeIDC8MC4sLdM52EnnziRZ0rmPI4HelFctq3DRWK
         iVZ2qn5xf85K1YOh7Z0sK3lsH25bPfUMG7j9yShEC2kdyQFWllzY2+fhwf1cYa9IkGHc
         oCdxPIUhvqM6C+gt9QBbCR3HqyDAQkZ1fJ79Tlznn7nwYDp5uJ+MBSLxKaIgO/SXZVVs
         uHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650933; x=1788255733;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JK28XhYIm59KeOaoUdt1w0lQmpTjtM9MMAoGURUqk6s=;
        b=PVPMXz5PBmgVr6onaM5UgBQl75/g6pXWLQH8vkZSy1lNMSYw1s5psge7qKveur/CJz
         hp3fZP3ygOsZE4oouwER5IU3WiW3y68/Pq0G72uDwyJbLL95n6DQpzX3qZsvM6RncUyf
         dxCkMFUr0BMlYgMSzaoZqM/u1lI3dlYDBHjOp8oqnn/MUCZqTdfEzOp4xb+0+fUgHhSm
         exHpMVNK9CqzFM5FXrcZQ7t9kyWrvVvKIPKkYhk18GheC12ugd05wwPD+ZDHOnZ1pDTJ
         MGj3ifrPs0gV4uQYNH0quPkqxwmwNc3sa4PUfxlXwh1rFSaypnpABTKIcaqAOVa/+N56
         aIIw==
X-Forwarded-Encrypted: i=1; AHgh+Rrf1aIufjf+OKbh3QydDUVINVdlmYI+xCo/E78ByWu7MbXNVKmyME2VWpWQVhsWUZ29reuaHAjYAlw=@vger.kernel.org
X-Gm-Message-State: AFuF++koGeMEbobFGrtFgEMTuzOsJd2Jw/1W1svXl5YObh8ThYKOV33k
	WFS+2KXyxrzu5kkGY58hIgbud82HVgsDOoH5Lly9jCfaTnFzcwYipTsX
X-Gm-Gg: AR+sD13kziX2C6uKhewgw5VIZDvTgCvevmXRCPMWdYLQsGaxpuxqrc8MtDfXQ2rcz0u
	YFAXbS1Flg66CoWCfzLlw4Ng3Ep1pJTBKHfq0+CJ9uZAetq7edSz945wF2hjE2K+6NA3sNGVEZT
	F42AwHeqeQv8/8ULU+sVp9T8j1TLNRiTs8dcUmptGvqJ1yo6gLhKJ6FalNClEgMmIlfm1cfA+8t
	sa1LLOAvg7bZlYnxyPlrj/IXKOSpVtCr1MjYsc9la8FyhqoQ3EhIBga8I1kJYONjucr4JEySBQ6
	Zeqstk4CSO4nQEgwsqGAC/bkOSC70Prs+lIN8WIRKuZj7U2BsuaYyFeqUAoa3KBO9Bb3EIKShZt
	9VcYW72EJ9aKXZSu6oQVHPi+Jqschfn64D0+/CNRU0DKVazCOzfq17BIf0vbcRuj9h0KAAXri4b
	GN279i3TOAe5Ae37MSlaB0KIprCkuT0LuqUFZ+AWO+DYRw1YDCGybwwmzl6FiAz2l/TWVfRY4vT
	cxHKik9dCr66yohrcqdgBdtAwYWLstyRkWYYGy5i9TogTj7/gOENAMs/nWCVfQdsdeR6WfIM+bz
	O+XBHanBPpP6FXJLkqqpxd7N56q6DrYt1MVAqsGhjmufDPcU6huIDJB88sEQ1+UNk39pRvZWcfB
	yepKNWhs0gEmJOordY2CnTAb8iJc+MKQ/ZX2+CENEgq4QtwdgCjIsWeBoAsAe6G6mEfR4lg==
X-Received: by 2002:a05:6402:2788:b0:6a4:32c0:3e93 with SMTP id 4fb4d7f45d1cf-6a582b78320mr27645092a12.13.1787650932802;
        Tue, 25 Aug 2026 02:42:12 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2d8ae9sm13858381a12.28.2026.08.25.02.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:42:12 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:42:11 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: andy@kernel.org, bleung@chromium.org, chrome-platform@lists.linux.dev,
 dlechner@baylibre.com, groeck@chromium.org, jic23@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, Tzung-Bi Shih <tzungbi@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20260825114211.00007c1e@gmail.com>
In-Reply-To: <20260825093524.285443-1-triet.hoang.dev@gmail.com>
References: <20260821014454.15960-1-triet.hoang.dev@gmail.com>
	<20260825093524.285443-1-triet.hoang.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 16:35:24 +0700
Triet Hoang <triet.hoang.dev@gmail.com> wrote:

> Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
> and pm_sleep_ptr().
> 
> This lets us drop the __maybe_unused annotations from the resume callback.
> This is a straightforward cleanup with no functional change intended.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> Changes in v2:
> - Use EXPORT_GPL_SIMPLE_DEV_PM_OPS for cros_ec_sensors_pm_ops
> - Wrap to 75 ish chars for commit messages.
> Changes in v3:
> - Update commit message based on feedback from v2, and added Reviewed-by tags.
> ---

Please don't send a new version as a reply to the previous version, it can
break tooling like b4. Additionally, please wait at least 24 hours before
sending a new version.

-- 
Kind regards,
Joshua Crofts
