Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BA352026
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278213; cv=none; b=lP3vhf7yjAHbb08NZQLMMslEiMmT4YKQWbs55HhbeUeFT+ADFzlxTH0MEpsi/MdCgrKGwtIsSTBvza+KBf6nXyAd+QvDBmBkCZeUzlJwrbuTmoGhHm/OL2cQbyKQgZaDqTxN7roWUk40a8YTv6rDKX8dFFcpv/vGV7ek5tKtzn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278213; c=relaxed/simple;
	bh=4xPM3Ye/FxcpyYek/S1irL41yRtOgBab2MQH645uGLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNRnr8XmHRbkDhwMd6/3pLLRtlnoR2X9SGeTIhHvINzUlbg4zO0fWgIlSFpZWa6+rmkvJ14YxHDJPp5cN2vsYyUu4jNiiOw7NndGW2z2lI+eUSmMNU5VTCFp5km+8SrnUdvWiWHO++oRiFTa3uioTLMoA7hQaPKRs7VVm3umjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEh7rJQU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEh7rJQU"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38511175ad3so452983a91.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787278211; x=1787883011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vmJf0qs2DgBsdsOJH4Zv4rn/Lap8Q6UgjlHrije8TRc=;
        b=dEh7rJQUOZBnjlZ97qy5GOZ0LiEPNnp5CgNmljKSNbmZnnu4K7/HpP0dXUZbs+PB/V
         IskTnEgop70vCarANOcQx+Z+7ySPm3jb1gJsYVc4nkL7NUTKfytANe81fRMR4Ra/V5wR
         WOGKpX4DgOYBytni+/RnMP88qFCSWgyIpXwbyiPLqlnhl/XQzmPYLPQ5300zRoGBz6kZ
         GiP+OlVB5GYu/xdL6CLwV6h5uwEWGdgEqoGUcCmPhZL/xd/Egkt3oTL5+UBig4704jbm
         OULljw9d4eo876NZZkGB3I4X84Cr75Wm6xheiSCUfSmL7JO2phftBYRG1uchZGO0IV9l
         O0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787278211; x=1787883011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vmJf0qs2DgBsdsOJH4Zv4rn/Lap8Q6UgjlHrije8TRc=;
        b=MBI54EwFqkDYiZK12/xznQ+XewPs8zMqgrdOLnASS8dYfjAmCGmiMkhoxNWWguWniX
         dAMKgIVerU5JBnXQzJJSdI7lehWWR+H7qmf++5ycBgdL47u85sm/zI1JzuUys6ilyeb8
         NM5NBa6ajt6rT+NibTA70lVRAAcCeChtWikUTGu5Zi4bVNKw2BtzOwtkRwrP7f/EUiCm
         OvLaOCxmLgIGvL27AR0qDRzGglDx7nQ0jOhMbuXM2bMX7vjzoPx4Ly6NoJQKkx0dyb2D
         fxF7InIznikp9Ql8NZJwBjFynCPHeHg8SXIQlMBbpfp5p8y0PM2CZ3i40a0CvntnXdf2
         deoA==
X-Forwarded-Encrypted: i=1; AHgh+Rrez03wn6yIkZF9T6YOZv4pnKc7aUvd7Mt5+uSkxUUUg9Y3/GoNqbIgDitG0mlVc1VRcSWxZjyRI+c=@vger.kernel.org
X-Gm-Message-State: AFuF++l0A8BPlEhPeca2B8t2O2qWIxmFaVzlQ6aWlcUvtlPGMCzzGDQ4
	LRgpt8Ym/j2/rUe+CwfzeRO8NgSX2MbagqZJ87nRLU8FcdN7rlaH3Vk=
X-Gm-Gg: AR+sD11dzVaRQ49yWc0ImEw/EgNAqSRGJBQpFhsrJhPubrT6+nrQ7tiGKSvQAU1zwD3
	GxcgFo10hM6WZkFlp9O1B/PNHhtxFRHzAIBL7yLj6j4POk78j49PzuWINhCfQiBYFDNtJZodH5W
	xecN3qwSqbiG0N/hH28NQ2eYV2Er9dsJ6c2vZQvIJCAdw0luLin3SWeYRmCel9Rin7KrJLBDeyn
	e/S8CuUrHW7jTWjfa4gTeQc/Ut/V7r4C4FOsYoFDj2QZlzgOQJjik69Ma7xYpGDBrySwGknNdhg
	GvSkJWZmb4xtNvwsl9MrkqEuQNkMRBpHPEvc2R3ciSdmNhiFjFqLhbj/oFV5eYNWgiakDf279NB
	xAouATXMnuGRvobLN8RxPxRbM2NHeatHmoHDPolqugAVMCHTEjtpcq/juvwRxp6neLTed8MR177
	U0q8Pb44Gi+0lIZG6Q7W5Qw9DglHOty6A5F8JUZTNebXw4OvWRQjQq4ppN6C6ZdRwlD9R5tauqf
	g==
X-Received: by 2002:a17:90b:3d8a:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-395c33daf0fmr5550724a91.3.1787278211479;
        Thu, 20 Aug 2026 19:10:11 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4baa594sm1008775a91.17.2026.08.20.19.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:10:11 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <triet.hoang@datalogic.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	bleung@chromium.org,
	chrome-platform@lists.linux.dev,
	dlechner@baylibre.com,
	groeck@chromium.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	triet.hoang.dev@gmail.com
Subject: Re: [PATCH] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 21 Aug 2026 09:10:07 +0700
Message-ID: <20260821021007.30946-1-triet.hoang@datalogic.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821025453.5944eb9d@jic23-huawei>
References: <20260821025453.5944eb9d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Aug 2026 02:54:53 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Hi Triet,
> 
> Wrap to 75 ish chars for commit messages.

Thanks for that! I will keep in my mind.

> > Take a look at where this macro and the comment right next to it...
> 
> >  EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
> relating to this circumstance.

I think we should use EXPORT_GPL_SIMPLE_DEV_PM_OPS here.
Should I send the v2 patch to correct it?

Regards,
Triet
