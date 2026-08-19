Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561833C37B3
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170447; cv=none; b=rYmRBTW/57gGUy9SXLkeLVLjgYKkS+jU6f8IKm/MzItNj8Hu84Mno1QLI0t3hPD6HDsFdap5U1uASzYjo5HTr7tmmUo73pwqL6kk66S8EuBe09afXruxpKOcvlZxHrkVQbl+kaqvZJ0yLyBNecHuJ6r/PXIw1SUdsee5Cz+4qWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170447; c=relaxed/simple;
	bh=ekLJaAFQq89WG4IF/a6svefiMwp9oXl7meItJaYNTig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EisRPHC5iMxd4CBtJM0gKiPZN9J/VOwT/XFyp2lHDHdoEMa2hs5ne9y0nVesDriE9l6uxDwGbJC6EbZg1TbZV+F9D7R2vEOm4XBLuofv2nKxJvk31+16EdzVwyyo0a443aQdXEfrax0+T4JaqL/9xAz4Tb43Il4LAeTiR9B9fIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5d8fbgG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5d8fbgG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47362928f65so1347037f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787170443; x=1787775243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekLJaAFQq89WG4IF/a6svefiMwp9oXl7meItJaYNTig=;
        b=o5d8fbgGU0guZe+PO4DDCtUg+39SEYXH4k/XT/VBVkJdlm+1JL6s+jWLzliQJZC6u3
         lk9fcIhvnkQcUtXbVKkWJH+TWxFD85sbQE712JEFsuDElyFFs8MQq4IpIrQ8eRa3Zq5L
         z3QQSoCB/WB2ZDdpVgMP2yvtC8DK5TLmbgh4ZL0d1/7sfDfeDOPvQMXJqMuU8TyPXKz4
         yWN37MVxJAHIO6OZUPjsrvDxSqN3P4y7ycU5Rdipb6mAFlajJ6fgVS2yG+N+vTEhqQq9
         3KzJ9tiNSlXmIpNpHA3AXsyOls2h1GfvN5sZ8mBHNk5lTwyKSR8Gfkz3J+vJ6bqRav++
         tveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787170443; x=1787775243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ekLJaAFQq89WG4IF/a6svefiMwp9oXl7meItJaYNTig=;
        b=jMiFf5TWm5eDQ+z9fVl2sLrUvjnit/sT9uUPDn2T4ZwkX7Cc9JWpLjNNmwDmR2VLP1
         5alnUKiXnjkSHbue7zzQcW8sd25RjYGpH/S1vWfwoR306COFIi//N50qFYc8BAQzNFQC
         RI+UWQWxoAjy1MOANwpUCpNpQ0lsP7pVDs/nzf/mwCqCTBO1sc8vq1S7hy48TVSpD3B9
         Xs5Ubp4f8xe7TBqHOj0z4Ittf1krajEU+JKdOjiskJa1PyVUyabm5WqW2wDCohEQFsqU
         Q7t3YuHKtoR58FXPwfUs728hbyUUAoqUJfdf6BdnNqoL9jwmC0Nfyy1czRs6Ms0gDf3N
         jR9A==
X-Forwarded-Encrypted: i=1; AHgh+Ro0ez5pfmq+D/m7FdlIy9BWQ4M0Ibr3qEN05IcUo8M1aSgHjoKlQSvGD0asESVjtRBKql4kA3zIVKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKVU4EEvAP9XdJ7w5qRrMee96fYsNDZDm+ZCvqjIXnZOFJHkK
	qjfyE+QdFcLRjG2WKK2OCDHJbVbSOeenPBB7IW7ki0pIhyEE9K6FWrjR
X-Gm-Gg: AR+sD10ClqwpTDyJRqOJnJIGckJScHOiqesfdm2Ahi0zN3/mDYcsf52Kmi+0N8Q5eSv
	344mDZxfAjmwlc4QVB08W8BFX5emo9Fdi0Ex0VOJkngvNl82URqegokV785DJDEb6NxIPkn6OMQ
	c+pNWCr13Ffu11nu7tsMFTMgYkgaBszEay6TdgohrcFBSlrPk2zWJjIFZkpvc1XiAj4zz8mPYAG
	GCbeLDbkqCpZUGtZshiHL17ZsmIc/hlK0fRT82GdGZK2A6DMHIxFh7F4VeTkWdz9mAjgIZXey1/
	AE1vygXuUwD94dRdVud57yikokERsGc82v3D9kEb1k3bTHSZ6cAL1ViPBjY7/cKPXp+o2UAkWiB
	8b2ECCUqFHNFd3vKhDV4aemPDJ+CocuUiBRVfUPJyTHC8qzlWqm73vd985Jez7SkEBMrbqHp51V
	G9c/ZgzNzMPCaa0ZyI0Qm7Ffd/bXim3O6jRiv+GAo0Jfstm6F1QL/CRaeM5Bw43rdsKFfxBVgRV
	O0xe4muHqfa
X-Received: by 2002:a05:600c:3485:b0:499:a685:c10 with SMTP id 5b1f17b1804b1-499aa19a3b8mr150233035e9.4.1787170443145;
        Wed, 19 Aug 2026 13:14:03 -0700 (PDT)
Received: from fedora ([105.74.74.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0d6721sm110815365e9.11.2026.08.19.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:14:02 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: andriy.shevchenko@intel.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v4 3/6] iio: dac: ad5504: remove legacy platform data support
Date: Wed, 19 Aug 2026 16:13:52 -0400
Message-ID: <20260819201352.72054-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoWt52LMj5nviqAVe3O@ashevche-desk.local>
References: <aoWt52LMj5nviqAVe3O@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> But this is still a runtime bisectability issue.
> Not critical most likely, but still...

I see your point. My plan for v5 is to reorder: introduce the ACPI/DT
fork first, then remove pdata on top of it. That way the -ENODEV case
is already handled by the ACPI fork when pdata is removed. What do you
think of this approach?

Best Regards,
Taha Ed-dafili
