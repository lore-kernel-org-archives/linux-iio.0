Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D816FBF
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947143; cv=none; b=i3KR2epIW4FuWLp1wVcpPxi9msPYHnVGuv2y+7BhMWkIrv8zWRpNpJ+k3sQ/BcvXujpwQSfNuAUYggs+NT9DxiRyqO4dqByDCCuN5KOxD9W2m8nx0CEV6j9CAKJEE2c7sF9Q7M9dOaWY0gZ1LwUsL+RUCGfjLSpw0SQeum/gcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947143; c=relaxed/simple;
	bh=55UEgKrGXseNz2tQ8SnJJ8wc7RSrqN01+HRxn8hN9ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kT6Mnx4hLDS/Pezb5emxtO75jd1KZZFfyFnMfGIYqEPQVzhJhcShREuEWXS26UIByk5CBx+kSlVHwsvftijN5FzTLt+CJsst8S4ioHamMq9l5d/cRihHTAsA7+GEWmhqmSY1W0sgSd2QAlJaWeVkR0Y62NCfzOxqg/18akKD0ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QREoQ728; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QREoQ728"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad21f437eeso43055375ad.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776947142; x=1777551942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55UEgKrGXseNz2tQ8SnJJ8wc7RSrqN01+HRxn8hN9ug=;
        b=QREoQ728qkANO6gaTiMrhgB7t8udsSxPrxi00P5hK4KmehJRrFlQWPG87GvnlfXiij
         lBaA7LQFJZ9LeGT5jOIPna3ODNBVw10yFXBMSsVlHdTpyWw0ILWxFg+q/zdTDGLwvNR4
         M6xedqFNbFyDUHqJ/BP5cihGSkMiY3irccRJoq541k7QSZjvP7DxG8VdgteMxt6darpS
         z9CM89YXZeH7ary/DT7philyN5QAhGH/b7Zv5P29H8aoAM1Wv3No+Z7nDJrH8uDQWQ17
         5JPNi456pdoeHSPMmgqFW1gseOK8b5GaZLrPRiWg1ZnQ8PBpw1wLb9tzO3oJHDUMbfkV
         cccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947142; x=1777551942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55UEgKrGXseNz2tQ8SnJJ8wc7RSrqN01+HRxn8hN9ug=;
        b=Xg1ivePEwII0SodWMqF20VSFN7T7ZGfHotu8zqVlzIxuMbhOiIgrLfABiaaUxjOBJ5
         kFqWXjjAD11jo3x9W5Gucf+KcJ+q2Gz/+UR54xHRfs1+6/tOLtNVfVopSVYd38wrdhLi
         Opq6fyJifTuuqPShtI7fh6CurUvMGocs2EqapwEljxuHvPfFMZQ0azvCuPFCsesFtZZJ
         V/BVhw/Q08E2B7Pbr7b0ACFxcSp2zkZH2OyK8fzYj2Z2Iue3nYyM1F+7+Zx/NusqGdhp
         70/u3edguL6fzwO08zc+xt1BXs5E8JSLkqxAf3fhtgkFVOa/dgKiMUaDXVHhzistqACa
         4RSQ==
X-Gm-Message-State: AOJu0YxEDKGiD0rwF20vOocW5g7xvpGJsTpNVasL06zkmSC0SU5ZJGey
	TC5P4fFyZc4D65Aewsxf/x3ENtFUURECjouU5uaxn6bD1VB21OykvPsO4sWc063eFg==
X-Gm-Gg: AeBDiesC/ZGddOZ2Q4ZRetzpbyQ0Zfq/EOH07kQnVFUxMfSWADHOIomoSTiRyAAiUew
	UADd8jrEtgw4pChab4tS2n5PegCPrhd+L+Har9rIQsZVUF++r9SbvHA2lAkIUoCo1XKuvRQNwmh
	OC5JjukoN1XF8rXun+NhHH+E9JqwR6Q610j+5eml/YhLCwSdSGx/maUccOLqc1XvvNXeuixMVBe
	Kv58meQpVvGihhfpSjT77C/90L5sZss6vPoBRx1CSwXWUDutBUvOYwsAr4NE1vpSHuHK2fLvuO9
	Y4togdhaJR5+JTQDIistdsh0PHbJprlbUMygwtRyLcuhSQJVkKNIYJTgS4E337UV7YVIUw0kk2f
	01LX6ibm/fiLGVY0nlPWQOMqeGt6NCGxC+WtmBkBDvYb1FuzyHIMHuVIybrGzV/clOBWNMCMDv8
	EQzmRl5SE8f6nzLuwaf6aMQT2pgkd0YVUIBzFMUiHsyX4vaysDEkQ=
X-Received: by 2002:a17:902:c94d:b0:2b4:6597:44d9 with SMTP id d9443c01a7336-2b5f9df28fcmr243257055ad.8.1776947141595;
        Thu, 23 Apr 2026 05:25:41 -0700 (PDT)
Received: from nik.. ([101.0.62.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab30f29sm192424935ad.68.2026.04.23.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 05:25:40 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: Re: [RFC] iio: magnetometer: mlx90393 - regmap vs command-based access
Date: Thu, 23 Apr 2026 17:55:35 +0530
Message-Id: <20260423122535.4334-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423121834.4244-1-nikhilgtr@gmail.com>
References: <20260423121834.4244-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Apologies for missing a few details in the previous mail.

The MLX90393 supports both I2C and SPI interfaces.

Commands include, for example:
- SM (Start Measurement)
- RM (Read Measurement)
- RR (Read Register)

Given this command-oriented interface over both I2C and SPI,
I wanted to confirm whether a custom command abstraction layer
would still be the preferred approach instead of regmap.

Thanks,
Nikhil Gautam
