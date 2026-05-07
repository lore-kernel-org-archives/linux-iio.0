Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E240DFD3
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176920; cv=none; b=uWdDxLD3vi/wMobs1dfb//CHKIwfaYiD1EActn3g51txIyxiE3Xo1dERo8KV+RUOXuJLFJhp5l/OtScrPmqlOT8xdiTR7Bgzf7j5sLjfVQcvAp10Shs6ccRkv41XN1UlFLzab+JpuXa8QVnxsAHcgvz7JJmH9Z16dmnqSIhf6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176920; c=relaxed/simple;
	bh=HhqiIaTEwKrfwCLwb7zwiQ6WJZrLqK82iljAKN+d4PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rphu58OJ+dcjMYoFQV2dgqsh7mE69K//XmpDkdm+lB49iyqZEKigWDUeLWAFg08IQL9TBBqYS7I4Mqo1y5hnfH4pLMlciBH/tQ9pBLG3I/lMIZHbCiw8BNWVhemdnwUJlfiifZAbsUD4kd1Ep0nTuMXZd2xNvDsZJOz8UBSSjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2sbkKML; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2sbkKML"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so1159525e9.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778176917; x=1778781717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhqiIaTEwKrfwCLwb7zwiQ6WJZrLqK82iljAKN+d4PE=;
        b=R2sbkKMLsPlDZjV8C0j+XKX+QED94ECIoZzF28LhHPqtqgKwrw9vekoA+VCuQW4itf
         9EEaXRa1Q9YcL9u6unHgKwHghlvQqfpuYrVkaAK7BxTQxmuxI8RnILSBRbCTMGib+/wk
         B5V5r9E2ClneD2jmx9scCCeibZZhky4NrEzoXKdJuWQR6wn9YZcl6LXveqa4q0/CK6Zd
         /Umcy9YMASLRb47dHfbpQwr7MU5vuO1a1AqRSmobFX32uZJNU3cyb8nBU//kK9PEyjCB
         5cgWhCcjvG1RgSuhoadvJJIjfXlWf2doUSRYv8DqhtJZkzOzG2aGvInDpG0ix/vsGGym
         4eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176917; x=1778781717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HhqiIaTEwKrfwCLwb7zwiQ6WJZrLqK82iljAKN+d4PE=;
        b=UfQqNEW+LESv/FBNwqZ3Mo41sYrf92BrPSoaJn/sq84xVlioQ+GdZzj8lkZj4dO9GD
         74aW6HwioXcORqs17VnT7Qa/0MOc19R4yFsHOSdWlo55BH675mcO9pLvIiuw9UjwF23y
         NMau3/IGctC/ukQZEedu9cAbLKpkwOnAdbCRwWYdWwgi7RJtuTSgURFh0KMlqaYScIqk
         xv1MG7ruTXmVI/hG85GSEBeAI7nIVqaKU5wOHdF+148Jik34u6Kh4OczN3osyfgITbiW
         nzhh4VNqvgHAgXUS5/3gSG52AHd6koeLCSrW8xIHhc8n4FBGSQTN+Ius4cWyfsyRoLM4
         jZpA==
X-Forwarded-Encrypted: i=1; AFNElJ8ck0190/5C3uX83YTmn8QN135w1V/OzarzP9gjW3Uo/AoLEWsmQL7aJEHI2DLw5eC6O6qwUSiIGQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSMETbizB7SDmfYBXa1FCW99KU8Ujh41SZLXP4zkSm3B8zEXD
	VBdjf4rG/8+twS41/lDN57A6+xgOjLRAAedgHrzX8fUK2fWKqL4LHyp7al6UIIn1IPGyTA==
X-Gm-Gg: AeBDietGXz5eTIxWkcS9b9SWPebF15ULvRFY45DIpTjyvBuhkc4lADPWcrtOrS1MQsV
	9uaLvoU9tZQS0wjPO+fhgSvrZmtbFAW33p0/IzpVL8A8Liji+Kx9C6uQki8vhmaWvnYxnYTyiQz
	xWRsdAi6qZgEdRBLpRvy+UH0jK+3BTQPGOYutnKHYRvg7iw+IiMuBTcayiDJ+rfPUNgU70UlAFi
	1Fawbi4pWNgTUkNGK5rVQ6GhVYr6BfjRRa8ibATfsweb4Zz7ahxoxdUDaHcdHHEgEsR6/Gr6BWi
	MVzVZ5VWnWdEud8x+mKpiKv3gt0FZ3z97f5I7uPk82ft/OhknuYQ2wMXEDzB9wW3EQjM4EvNOCI
	eF865eOdSFHAVf5k2XQ0awdvJytSqFdb2KdeEqWd5SkdQ3f4k0oPOsNYB2lhSLGtuR9xtge+EyO
	psjV1j257uJq/zBrx4Ubur2+CZJYGxejmeiGbngyAPSAuX
X-Received: by 2002:a05:600c:4510:b0:48a:79da:c87 with SMTP id 5b1f17b1804b1-48e5310852amr62582045e9.8.1778176917087;
        Thu, 07 May 2026 11:01:57 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4541712368esm594656f8f.26.2026.05.07.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:01:56 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: m32285159@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as SCD30 maintainer
Date: Thu,  7 May 2026 22:00:54 +0500
Message-Id: <20260507170054.9349-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260507172404.80435-1-m32285159@gmail.com>
References: <20260507172404.80435-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 07 May 2026, Maxwell Doose wrote:
> The current maintainer's email is no longer valid and the driver is
> being orphaned. Replace his entry with mine, as I am volunteering to
> take over, and Jonathan Cameron has approved such.

I confirmed the bounce from tomasz.duszynski@octakon.com when sending
a smatch-driven cleanup against scd30 yesterday, which is what
triggered the orphan patch [1]. Glad you stepped up. Please feel free
to drop my orphan patch in favour of this one.

[1] https://lore.kernel.org/linux-iio/20260506182931.494-1-sozdayvek@gmail.com/

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>

Thanks,
Stepan
