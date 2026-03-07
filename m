Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00F313556
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772907902; cv=none; b=OTzVSabJit5zRgmhB1nz+HZPJ8OOoSqyVABcKyneMukoEicl2GNYfYpgjpBYPgs96CqrXjAxCTOsgYB0s2aAiuBqngZzl4UVLy7ktA1RDV076JKA34LfSRax62vczGlhCVjYd2Tn/fSAQyeZhzQqe0kC4Unc3B+u4i1MoTmgjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772907902; c=relaxed/simple;
	bh=h9uJf9PUNi2XPc6EbfAn6h7sJZIyikdlxOc3vZV3YB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPOue2g2wjlH9eQrbOGNfx6rcfVnuHXaRrgUsSbaSTRH58+yoOR1xtPudj2LSh4DI7it+SDprksFYDyU/QAqhMJlX5L4QwqHM0PBUc+XcPSmwQ6wSk+j5TbpaSiWcpcvcwsj8L2RuLeL3yNqgjDY4e3zQgetPKiOBULBo/iySWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sHecCrOx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sHecCrOx"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d1872504cbso7280980a34.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772907900; x=1773512700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdDS4EOWbwiasyyUq3N0HNoSimz3zaLn9xgLsbM1jRU=;
        b=sHecCrOxBHslnqpTSEE3Toek1AkhUDTjgSyCDio6Y62MrrZaDzoU9eRyZIFMPNli+k
         0yMp0NG21zHK3vTFPbhkCOuY1PKZVmWddlOhr5/sW+wAhY31IYFWqN9q2s74YEtZi5Ci
         ljV9K1sOO3MzFw7/UMIt+1wyKU2BnqxDA763exU2tCgSQVVvQzxW7KTGYwh/mxd8PNf1
         AEhW5RVJs68aDuZn5EJs2wgsGCVddzDVfDf4RgIoT1pBk8uvGRoULNA15FI1ogw4thFh
         PPHlncHrzvu1hnI/oGSL2TU1hFA991/ADfB299ib5l79z1U+5viPPfyrKHkgBl2ij19h
         pPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772907900; x=1773512700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdDS4EOWbwiasyyUq3N0HNoSimz3zaLn9xgLsbM1jRU=;
        b=DynwrjyUPqv7+LbMKxqVlge6m7v7UfpDTU9waL5DEdvReXF3sSd8M8SRCSJkt7KSJM
         QhXlKAOqGb0/60ApFUoAUWHhPIJIDuGTquBIQm78bl5C4lAy3fUOPZQUhbvV+f9NYCdn
         BNLhhoIoibZEJXn97ZTXPR+zjfN3A/zNQFgaeqtvJMUkSrc0p3NNFJZIpc/lYqRrqGX+
         co6VpdKPaTKbIM4r4WnaMFiyba7eNnpwZk5zRy+l8cYfy1ACi8iuPI8kxuPnFizrH7NA
         gY2uGjaYyeBibq/43nO/VBOU15JfgpuyTyrn7mMDaRL0J+azgDy22zPnKOOHS8sRQeW1
         rzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+FGq9n99HkvJMrhNmfAaYKyFju3bmBRjJ6qsm44vIQq+LfM+/d8lVSaNfJys2YTOxsi+LphsVcOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6v5dG7JQcMvucAkjRdinAE6WKq0a2lQO+GXdCkZlcwSBKPHX
	5vLC3mVipWHxN21XfRckQPba88Ltjy4JnI+7GLiIwDWhGMLEGaqvJqCHbr23VFAAgZc=
X-Gm-Gg: ATEYQzyqyQxEsuJf+Zrjr3IZajyzk1bE8BYt9jt9tv8ttcrxFDMysVCRJ1nkFCjreTF
	9PWMNNr4+/zYqjMKPpxz56tRDnh4pzAdUOlTCpSLa/7GwpY+1BW1tHCYsTTKSZiO5iJZ3/8N3LY
	Z+4qzdTgFUp14CUO90Ut7Mdzj20xN9nP/Kdb97MvQwuLTktxJyojjz0RTyBVD4dOcSNkwlxN87Y
	OeTBTUu6eBzaeh8TsQPHHADYBc/9bR/6ioZW5xjtAWfM6KrM4uVQJnIP6EZppIFEijV7fIBsO7J
	THBhQ4M7Knj+z0/W/PUepoVqiOLce3jwTRPInjxAQCp2axaif2hGR+4hpS+CdKukzz2ENag5wnG
	bRZ32XPxK05PqOqEmcbss+HxKRVy+Otplbai2DKQflaFqVtE4eQ5PiBb73OkocCfDV5rxmdd1WR
	mUoc8H2h5IZ4Y517bn5YvBGPT+75FIsxURiOpMdEXnqlYXlZbgQw+A4kW95fu9GHDHRJsL0hh8Z
	g==
X-Received: by 2002:a05:6830:4d84:20b0:7d4:8c9d:dd2b with SMTP id 46e09a7af769-7d71cfff8ecmr3738680a34.0.1772907900193;
        Sat, 07 Mar 2026 10:25:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d74062da77sm509741a34.18.2026.03.07.10.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 10:24:59 -0800 (PST)
Message-ID: <97043046-0cf7-4762-9a3e-67f1f47a2694@baylibre.com>
Date: Sat, 7 Mar 2026 12:24:59 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] staging: iio: ad9832: modernize ABI and remove dds.h
 dependency
To: Bhargav Joshi <rougueprince47@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20260305210347.120446-1-rougueprince47@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260305210347.120446-1-rougueprince47@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 3:03 PM, Bhargav Joshi wrote:
> The AD9832 driver currently relies on legacy custom IIO macros defined
> in dds.h. This triggers checkpatch.pl warnings (NON_OCTAL_PERMISSIONS)
> and, more importantly, exposes a non-standard sysfs ABI (e.g.,
> frequency0, frequency1, phase0-3) directly to user space.
> 
> This patch removes the custom macros and migrates the driver to standard
> IIO API mechanisms:
> - Standard attributes (frequency, phase) now use info_mask_separate.
> - Non standard specific toggles (frequencysymbol, phasesymbol,
>   pincontrol) have been migrated to an ext_info array.
> - Remove dds.h header dependency.
> - Pointless frequency_scale and phase_scale attributes are dropped as
>   suggested by Jonathan in
>   https://lore.kernel.org/linux-iio/20251231180939.422e9e62@jic23-huawei/
> 
> NOTE: This patch introduces an intentional ABI changes. The non-standard
> attributes (out_altvoltage0_frequency0, etc.) have been removed. They
> are replaced by standard attributes (out_altvoltage0_frequency and
> out_altvoltage0_phase). Routing to correct register while writing is
> handled by checking currently active frequencysymbol or phasesymbol.
> 
> Testing: This patch has been strictly compile-tested. I do not have
> access to physical AD9832 hardware. I am submitting this as an RFC to
> see if these changes are acceptable, and to ask if someone with physical
> hardware could test thisg and provide a Tested-by tag.
> 
Since this is changing ABI, I think it would best if someone who actually
has the hardware and plans to use it should be making the changes to
make sure they actually work as intended.

