Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1547522EE0
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068630; cv=none; b=uCxrSFCgX4g3E7n08peZsZYrxhVIamN3GH7lvL8M8bdxZcSjYsEsfF8HHfQayjkf8b4rXZbLm085NbkjcR4aJLRB16Rx3soyHc/R7OMcx7FwuX9ZvTp9+W1YIUFy3iqDiyFbehp/j6b3X/LNRRjZh2mm7s9IgwweXGF0DwLvktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068630; c=relaxed/simple;
	bh=nl4ec9AwXQACqVpdMsqZp6/fGYsuYifYLsECN9bSL7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6wd51btGTY5AO3RU/JOqoXowBOHcrm63WGfcW4r6SAG1blNE5UBEqEKRpt8BSNgs+dfYlUMOM5X59fbqFWy+ORXcuQS5mLjbkpHCGNtN/WFNx+Yp7J7QUcdLM0jp8BTNnDnPFJZT366I1bR+s3FdJLaHvI8FBFwj9lHkPY/kDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd0uPbH/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd0uPbH/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d05d51553so13670225e9.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792068627; x=1792673427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=llwCI7aJY+9XjIfXW2VPE44y/chmdd1TNQ4D5TPH5Cg=;
        b=nd0uPbH/lqyU2N62W7XEH7ma9zPE1tKadNQwJQ1QH/V8b9vG3TuVjA+b7i799mJFTJ
         tPUGML7Shb4x0MCmxLgBWfWerw3HVXt/oKxLYxVVEqbdoGv2dwsXUtob4HUh6q7vji3l
         x8mkVoFdL2EhTUSJb4iyVA9E1uslSYd5HN6kchp3xSKxkNqELKd4uZephOTL1DVU79MW
         FzuInGHVbUa0NAMDSAQm3fzbQr4ObuFhLutndAYvtRnzZ7otVP1IoKgOKPcnW18Z7tIP
         B2N/kYWxzEluxEg5hF13ya0L0MEt9V6W9Fcn87MH5hN6giHFpegUz64MLwY2bXpCUY1D
         6QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068627; x=1792673427;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=llwCI7aJY+9XjIfXW2VPE44y/chmdd1TNQ4D5TPH5Cg=;
        b=xVQknLubSpFEK+23ec0uHoztclVidcoF2L+g64hVk7UfawzdvDCUG/BqF85EC5gYlj
         zcYUgbZLdB9Bjkqah4rUmgCa7eQjwIvJIFOixEN0SmN8v/YFjGjfK5tdbZ+SYugEm8v3
         6ae25PL6aWIM21h6+T68hD6j1OabjXh2xlp6NSN+vHJadpGnWSehngSnpDd0QPc/EHCK
         gODKl1L4A6gS09etEJbvZSlB6+zlBNGrawN4nzoz9tWBB72hFzU70v3viXOLhZmI4/ct
         ALZOuCJFWKGQPlYV1TurFZdMmxPAG22SYmEIXLCRMsm0SEDRssycPWSb2Rwo/x/Ys27w
         UeOg==
X-Gm-Message-State: AFq9FYIcHVovftARH7ftWbxjk7r0PfXWasAt4Oz61pOWY88rTgV40fAl
	l6GaEWbnvpduMtfC++C0qmVAHwjv2nxURE5nor8JDK/WVSws6nmluDi8
X-Gm-Gg: AYBFou2bAH/P0CoqRK5khfT0Q/G7lDhXO4Ju22PDGIKF9vnZ3f2HSw71X0v3OmaSjvJ
	cR20KOxk/Z2Gyc36FBii3y68IwgY6XITRZh47K1VjqGZ9jK2uQ9QfHlbbsyijR7SrmVTDUqUHj3
	KASMAx4oCYIuq6yOeqpnzM7KqQQouvDnAfLA5eb05hknn4/vWyI1JpN19SIf3Wx0w7JaQAiQBid
	zEi+/SqJTF44nUaife/zCsNItHe+gESHcsRf6v8RxhIUDWzlShWThuMohYmVA0fGkLG/TzVHhgM
	y1BQO/5Ksv+YzAMQ8ujfhRh04td8sdL658xFpD50panDfCRUFArK+jEO07xQ82AZj8JP+LRV1mV
	3ib3umXRPnSkgMWtiywCD2sW/mModVi2rR5ud2RI0fauVmZoHJF4oN9xnR35dJp0Rp8wxllXiha
	Jx5ZYinv4/uppQbq60NDatXyvCGMDB5H2BJs/RDdJCjR2pUAPvS8Lh3ziSSVocpByCmapTOqRCk
	w/XU+HHgTkjtSSL8TVhfjzeoGyKTHL+AGZ2jY2FofybCxBZxQRbFNNMNR5XCs9ppUhsWYiY+GH5
	7k/qz9rGgGfBRabGKytLhW111hukvaloRVBuoz4eu6PNgr2kJewkVCEKVE5rwM457yGBBDVk1F3
	AdWqGa0gDqJX82mWdYvMJ9HFM1LhsmBpcquVogwycghYkJsI6knTTaI0EAJn0zFRugKh9V+IzS7
	VNneT1
X-Received: by 2002:a05:600c:4504:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-4a18e4a7839mr405810205e9.25.1792068626716;
        Thu, 15 Oct 2026 05:50:26 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5b03sm19802173f8f.30.2026.10.15.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:50:26 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:50:23 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH v2] iio: ccs811: Deassert WAKE GPIO on error paths
Message-ID: <20261015145023.00007922@gmail.com>
In-Reply-To: <20261015123023.3417-1-nikhilgtr@gmail.com>
References: <20261015123023.3417-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 18:00:23 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Ensure the WAKE GPIO is deasserted when status polling fails or
> the data-ready timeout expires. Early returns could leave WAKE asserted,
> preventing the sensor from returning to its low-power state and
> potentially disrupting subsequent I2C transactions.
> 
> Route error paths through a common cleanup label to ensure WAKE is
> deasserted before returning.
> 
> Fixes: c6644f7201f3 ("iio: chemical: Add support for external Reset and Wakeup in CCS811")
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>

Ideally your signed-off-by should be last in the tag block.
No need to resend though.

> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

You were too fast! Wait at least 24 hours before submitting a new
patch, you might get more reviews.

-- 
Kind regards,
Joshua Crofts
