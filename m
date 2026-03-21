Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB5258EC2
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774112021; cv=none; b=T+SI4dgJTQQ/ELTdeglIpuiirXlYDVlEW5ab732+V33DLyDc8j+NjAIaCYEr4SPVDOpVYK8nEQt4PiyMkSA/uI1nDWvwv3jNX/qfBbiF27OY6twNse8FHgjRFQ7o0mjD380c6IBa3eMN1eOELpJd+g5XQYU2tQdQOOLYiniOG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774112021; c=relaxed/simple;
	bh=dAT4XoTqM4srLRTVT7YpxKj02oAsnu7R0+7Qkkkd2cM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition; b=ATmR4R4K3OJ02b360s1GAoRfnTCw/diWAIMfHRMzarnYnboj1mQftkb3hN2/vm+nCGdfw1aEUER791GfRmsTq+qCukjyq1PFxDcTZMiZCCOF4T85ATdDynPatOaDvhN+AWiocgmVC1N4bUu0y5xwGD7f6aFmrbWmEpeCB3v5s3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6eUQctv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6eUQctv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1901194f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774112019; x=1774716819; darn=vger.kernel.org;
        h=content-disposition:mime-version:in-reply-to:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAT4XoTqM4srLRTVT7YpxKj02oAsnu7R0+7Qkkkd2cM=;
        b=O6eUQctvThGkJQto0jMFcGdx+qu9CvU3JXrubgcIEHlBczDkKHYs2/2UoSJzVa3xEY
         J0PrSlmmrVgH5hlkdAzAA0ToW5wh/vaM+43C+sPnbDAvP8Nk4cYK5ffoUEDt6lP5Y0YL
         LErJYz8vnkC1OGp6n9RbJABescCkYdej9kBhalPyGimEDbxOJo0wZ8EcnPDdfuHs8aZ7
         w3I9Z/T8UlHndIHnsprIUXHr6bk7OAaI3H4PyWJJdk5jL4uDBLK6o8avGZwL1GTomiyC
         jYqGbImthEkzKTCJTy5ePLujsFHQjyTW0uZCGOHDVVNZ1J+v7iHv4gnLyg3EeCiudQPu
         VOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774112019; x=1774716819;
        h=content-disposition:mime-version:in-reply-to:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAT4XoTqM4srLRTVT7YpxKj02oAsnu7R0+7Qkkkd2cM=;
        b=HQKWv0NzlCRE6UMMDSBHJmaRYXxwbKVhWu/Esi+eSOgGmYxBh76hfuEyscdZDDeWoe
         v/sPESveZvwcRzHu1k9zt9KWhyIhahJtIqR6K5Twix6Iow3WQbDI7hOgV/2LBq/CesLO
         71oUn5IXcc+uv30AoOpQymV36Uvq45Tok+tWcvfMdAYR6Hu/sjuWYORTJD4a+2TLNKpw
         QK8eQSrVXsdq/0m2Z4UPASVmQP9x/7VnDNdgHYPQLwQSunVWPoW85Hmd/yK7Ip3Ii0Q+
         X8ew4IMcT1RjCFAgS3n7p0F3N/N5jHHlKXG7aur2kozN2bCdPB320V1pTeRKFMsNvI50
         FqEQ==
X-Gm-Message-State: AOJu0YxsEK9TcaLPRIJqbo498upFV4H0Vc4MAGrv+TlNhVjQA2O+7FAd
	zQigdfs3uf+aG62faI1C8XNSgQs7r8cRqdrUA9qKuabX6IyoXLSSMjCF
X-Gm-Gg: ATEYQzzHvob7yiQJKNCoCyeAiNVJCT92BMrMOE/laYlPZ8GTK1DPnTjBPcPtKujLtFH
	vaStzbeOJIqLLhk66lkLvfPM6SxtA8VjhB/FS5O1EGb12Io9xnXbMop+dhUW6zuKjiBWcj5XeEt
	7DE0G1c2T9dnAQhxMRaLAcFGnagpFmSSQjpvefKOQyN3UfLZfxEJB2Pm/w+H/qsAil9yMoc/DWn
	ifUJI7ryFSVjbkGYhe2fAsdZh4ReVWB+9MRuTe1VwuXP22ypBzP0agtbdve1yioiJpdQWm2XT6i
	90ztPiHA5jsMp9ryzTHOYhuik0HSBs3Eb44YtYxQVzc0cckuhS/Z13KfmlGHdJaEJ17i3M0pSbR
	QcAAyroOeOTX87erqs9Rk4S58bGHbeE5h7WManeVGOTJiJ8YXTlzvCoYa86jD0jM4r7XpUabpr4
	NVsHDrbgThAqb4nfr82VThrOhwqsHRcVTplEi0Kg==
X-Received: by 2002:a05:6000:290b:b0:43b:576b:5dca with SMTP id ffacd0b85a97d-43b642442f9mr11136246f8f.16.1774112018381;
        Sat, 21 Mar 2026 09:53:38 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c9b:a000:bc11:6b0a:79ed:3d9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bf1c5sm16128103f8f.14.2026.03.21.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 09:53:37 -0700 (PDT)
Date: Sat, 21 Mar 2026 16:53:36 +0000
From: Gabriel Rondon <grondon@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, 
	linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/3] staging: iio: ad5933: use sysfs_emit() in show
 functions
Message-ID: <ab7NEIlXcg3BMmE8@MacBookPro>
In-Reply-To: <ab0BHU8zNOUIAcJf@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Andy,

Thanks for the review.

I didn't tackle the switch resplit or the modern _avail patterns since
those would be a larger effort toward graduating the driver to
read_raw/write_raw/read_avail.

Thanks,
Gabriel
