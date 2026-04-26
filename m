Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F126D4CA
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777235148; cv=none; b=gTdbk7Z++EzuSl/gTAiKtb7GF6b5KehNTTDl+VaPniZhdMkvDU0PA38f0DmFbVqS/KvyhpHJHv5essUgTAewM+b1xoJ4iflc8LkYEiCBiOjiooqI2RGhYUJ96hm9Kd8wdULWAcGzHgKRn2xF21gjE9IBQpLXv0txtW9usBcKTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777235148; c=relaxed/simple;
	bh=yr2DHkpYu2/Xu8RHkP9LXjK2VZnznGUp5EnqqaF+/jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHRfPVPmgxi2uAMbyw5noiGCJnVm+6tfiOBVRQ8zkhxt9nTCP8zf8vRN55ubFuzpGpDO0IB98TPlhlWBV7rwZQAVMFH+XJK6q2h7a2gj7IUUfrUSOmfZ9lQJhd5822QHvQsgJ/wLbB8ynehZX/HqshY4i7qDFFKtekE87/qUwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDbxKH8B; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDbxKH8B"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9358dd7f79so527860666b.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777235144; x=1777839944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oQhRQaCh7wTVDtW5X/ov7P7WhvzMH+Ofkf86HNNbro=;
        b=VDbxKH8BVMRRK+PJB3RuS1/UeRUArmCgZPRnPL1Wrdv+ZvCNpLMW3B9JT06iSFxv/B
         X0LXaLc847Y5CCUBHQbRRkFpndpvNavuVHbAhw8uaijuVC6AYSp0NgIlzCuJK0lSa2X4
         oO0zp6ctMB60E2rpbAihxavSFAvfAAY/99DtIjgQ3qSvrQ5PgHHW7lTJvnYM6x5we96F
         RXran58VznsQqlvyjogilJYICZ34LgmNTFDrSPWbkkk9oDrmwFFtYFlYulLBjdqSqoDl
         +blHJPtOn3Y2xIJMbbwyLET2jokNZE21Lsm785tJaKB0VNJEQxA263OSpm452cgV7GTd
         CVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777235144; x=1777839944;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oQhRQaCh7wTVDtW5X/ov7P7WhvzMH+Ofkf86HNNbro=;
        b=lHJ+Bu9WMwAIlFShV7IQeLzXnK+orNNjDJ+jWk9DNTSGoGR54Y6I7UvDfsEACGRuJZ
         dEDWOuMSoBs2ypn5KvhKDgtzfguwCR5qnkxKIZk/cOhyWACFvqMjOZjh1Sn9mas5rIjK
         dObZwCQbDnR6Un0B4SEETmxRA2zsI5gc7SRL3+vfYvF7tJuMwZZiHPVSnAZxw1wMblZ+
         MqafZiiwxg3jbp4rCLZD3YKmUfYDb8VvyUnzNYE58jQM+94ZwKqvXmFxp21Gh3vJqJ1e
         WCfYcPA5O2H6fPSY87gJVnAUJtgj/n/83UDE897hPe0ABwtG4cAlMImtPpgGguQd4clR
         Y3Jg==
X-Forwarded-Encrypted: i=1; AFNElJ/N20DqBMfrW09gvsLN176DckpQnSApnoiDmLWlNPeEZFx3ZjvpQcMO0zC/ZitT4Z8bEGwZ9PxKqyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37/xlVwceV7TjqvcRHYmQwcT+8GO1u6aiXhzWCbcYnNtdt+2C
	+VqMSi+st6rdz0ih/oRoi0VByhQftPVyuXvo+tcIvpk3ucP6y9ogmbcjGNuiy24Uclg=
X-Gm-Gg: AeBDiespcSqxSBlBCVh44C6q4IeHyYISPmnyd7qgNz4gqzIeXOcynoLZXIVA8p83Tgj
	rJ80tI9UYgjud7XTvnjAQt5UQYcaa9WGUUkSOG7OYLJTKHeRcZdxu+/JNEX/YBhjX+GcbxDAXew
	JOvKw89i1JZ7+In2pQ7RaHdfQIhYwVQNl18f5CmsFG07reJOB5AW67YGDkTH5QV7SbtBz7ZN4x9
	k+7tLZ6NDO8bvf/k4hI//fOb3zZmV/qtdZnDacVoB52PNREMkpp8XlfnWMnIjgkSpSzbXFt4kTB
	venlu4NnwPyzqa/6zJi6n0i5PPhPQ41CmV7kBsy6ytm8jkgFpbbTTBw/EqofxgaWA0e+2jKLv9h
	MILvAS/I2FisDcXJDGrZGGAWHKQe80mt32OSh38v+6d+0DCIaDMdRgms04Nr/477fBXbPUcFM8w
	ZpAVDybDnw4u5aJEX7EoDIqLZQ9pxu35blirBP0+KclVtlNC6k/w==
X-Received: by 2002:a17:907:c302:b0:b96:e593:fd24 with SMTP id a640c23a62f3a-ba419658d6fmr2389436466b.15.1777235144005;
        Sun, 26 Apr 2026 13:25:44 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455043cdbsm1029590366b.46.2026.04.26.13.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 13:25:43 -0700 (PDT)
Date: Sun, 26 Apr 2026 23:25:42 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] iio: imu: inv_mpu6050: fix unbalanced
 regulator_disable calls, when probe fails
Message-ID: <ae50xlJfXiVax6c_@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
References: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
 <20260426112334.3938774-2-andrej.skvortzov@gmail.com>
 <20260426154330.0a29236e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260426154330.0a29236e@jic23-huawei>

On 26-04-26 15:43, Jonathan Cameron wrote:
> On Sun, 26 Apr 2026 14:23:32 +0300
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> 
> > During a probe functions after all regulators are enabled, runtime pm
> > is enabled. Before probe function finishes, runtime pm triggers and
> > disables vddio regulator. When probe function fails after that,
> > inv_mpu_core_disable_regulator_action tries to disable already
> > disabled by runtime pm vddio regulator causing following backtrace:
> > 
> >   inv-mpu6050-i2c 1-0068: trigger probe fail -19
> >   WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x2ac/0x600
> >   Call trace:
> >    _regulator_disable+0x2ac/0x600 (P)
> >    regulator_disable+0xac/0x148
> >    inv_mpu_core_disable_regulator_vddio_action+0x3c/0xb0 [inv_mpu6050]
> >    devm_action_release+0x4c/0x88
> >    release_nodes+0xd8/0x178
> >    devres_release_group+0x214/0x3c8
> >    i2c_device_probe+0x6fc/0x9b0
> >   ...
> >   inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5
> > 
> > vddio state is handled in two places: pm_runtime and
> > inv_mpu_core_disable_regulator_vddio_action devm action.
> > inv_mpu_core_disable_regulator_vddio_action has to check, whether
> > regulator is disabled by pm_runtime already. But this information is
> > available only after pm_runtime state is initialized by
> > pm_runtime_set_active during a probe. So
> > inv_mpu_core_disable_regulator_vddio_action has to be called only
> > after pm_runtime is properly initialized. To handle cases, when probe
> > fails before pm_runtime is enabled, explicitly disable regulators
> > in error paths.
> Why not drag pm_runtime_set_active() earlier?

Do you mean something like proposed in v2? [1]

1. https://lore.kernel.org/linux-iio/20260401082737.781018-4-andrej.skvortzov@gmail.com/#t

> Whilst we currently
> check for an error on that call I'm not sure there is any reason
> to do so.  It's a narrow set of conditions than can cause such an
> error. 
> 
> If you have that between the regulator enable and registering the
> devm action I think that would mean you don't need to manually clean
> up the regulators.
> 
> Maybe I'm missing something.
> 
> J
> 
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > Fixes: 07c12b1c007c ("iio: imu: mpu6050: add support for regulator framework")
> > ---
> > 
> > Changes in v3:
> >  - make patch to be the first patch of the patchset for easier backporting
> >  - update commit message to fix Andy's comment
> >  - don't move pm_runtime_set_active from pm_runtime initialization,
> >    move activation of inv_mpu_core_disable_regulator_action instead
> > 
> > Changes in v2:
> >  - minimize call trace in commit message
> >  - include specific driver name in patch subject
> > 

-- 
Best regards,
Andrey Skvortsov
