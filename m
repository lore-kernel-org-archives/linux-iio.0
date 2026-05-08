Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78B382397
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229022; cv=none; b=ozKVy+L3wNi9dJTct7vD+EAoh6Zw5+zFgwIshD+ic6i912wUo5Ng1YtVMkXqz3h2vHb/H9U2Rxw1xHl8puVUmvpxPzwb7HAC3ixjaPIEU0kdilIZAaEayGjXdk+dKv786FKFRRiPAzlTQe/+ETK0xbM8odP1PrndxqrwBDPQnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229022; c=relaxed/simple;
	bh=STc1pDhTvUY7seyQeBjpeODjgJfUrj7itSRyJDNooiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/ewHwbPKfoF7ehAwpks8QIu9x1aosRSR+nWi4yxEMKRerXS27QkgVAOa9ZaKL5zwSxWcLbz6EJjRHZY2Zak3o8lxtvv78q74cu8fxrWMkzmaT7RwrCSQrTIvv2PQoKdpZwKJrZMxwS5Av1P2zciT+QhBRQE6Z4o4FTbhLrEWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etWJeezS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etWJeezS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-445ae03198eso83945f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778229018; x=1778833818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STc1pDhTvUY7seyQeBjpeODjgJfUrj7itSRyJDNooiU=;
        b=etWJeezSUArkiFguA4Mj0EWyP0G+GbmmPmVBORwGgXvIpDcSGyPOpoopTSjdedpF20
         CnfbIO8z9vr0FK11muCkGgiPLzjIrvlbAx94BYNf6LyXctCHIcD45llPJ7nD9iwmwC08
         ohtqHEWb1tPOm7VHT86irpbNts0X1e3oOTJ52e9w7QT4PPbMpJ+My6XszgejVlksS9Bf
         WiAZ9ONZnDDqRsMwJIGHfgoWXIUNJCSkg3Oa0TP0nLbF7IvU5BP/1QkQOY1iWfSUgI5T
         HWXhHSELHcmJJg+JHrlJjebrqvqMG4ZgDKR6Q+Xs3SWiPrjCUxaJ+6Z9gsZ1RFyMxbPH
         g45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778229018; x=1778833818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=STc1pDhTvUY7seyQeBjpeODjgJfUrj7itSRyJDNooiU=;
        b=LXUGlNOqLUjkBb6MlItyx7YETJFoWgNccjZS8gQxQ3nZ37HI/5uqIu5iWKh/l0Xr+/
         hI/0l2pydmwbH5yYWmQiSmtWVUjlV5KHrPvzCmyBoYnDL1qfWu0F3DlC4/o93tZqZUuv
         vzPpWBheLkwgPDeTGQichNntXr0N4QJv7yTwTdaiqxy0e538L9T4T6EiA2opEhN/IVHQ
         tNG/ddnHF/B+ukg8AbjJ9MJfL7Y2ymoB1uiqJdI1BvwjB8fhmxZ+Tsl6tZjy61vQMMxz
         aR9aSCo3g+uxSVoSJoMFkA5mhPdk9oBlojUHrNC8Plxn2lj5+qSQKejQqiX7kmGe1eXO
         RceQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QZvQV/iVK3S20AdQ5wjzXzrTNIvfFRy4J8BPm/DxPy2vSzlhxMvexobq6XxqrvekNUM4yK7zaHLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBq+In9fxuOT7b7gXQPWh/IKmakP/UeLWeWCi+FppJnd9JDJOK
	yZtoouP7Ad9GdDu6YfLevTY9pprJrm7cEsm5hjsZARBOClkkNNmFr4tOF2pDTJQDxMZN2g==
X-Gm-Gg: AeBDietjVKO3Jr6O5IkzefzxpUBRbEFyidT10RcjJmQfdOVjJGQW0LeIsx6E/doVaMQ
	VWHi0tzVlbM8qztRcNpGPpSIV2GAQg9+lsMAvH3Q5cQi2zehFuNAR6n3xw5Huk5EfHMQBcBJzoG
	8VpOCh52fsG5ih3wWa6DUcjeL4810bzWNJNVHInc1/oQ+VIvkSnYgByrnzR8bWlGH2nUKsJDOly
	U8QteXZCigYp+auLkvWsEPJVWES1PI3Hn747lul8evQH3s016KluZ8Sr26gbZeitClu0Hl9t6V2
	76eNNHr4nEtolM+b8GuRerWuGA0YAG4zQ5d142SfKOcIdGv3s2UjUCbzhJfWIsh8oFrHrn0TB6v
	sEtw/CTV4zJ0tHlYTEe5PpYUnlK/L+DLJkWkq8P0vr5DZFA7KJLtVA/wVMa5QqGXYEvc6MGJOyF
	cn57wDNawV8zmC9E1pzXa826+6nVoP4tkdO5iBO8VLOT9Rm7810eA35r0=
X-Received: by 2002:a05:600c:3b82:b0:489:1fa8:b895 with SMTP id 5b1f17b1804b1-48e52f6f44fmr96891995e9.2.1778229018093;
        Fri, 08 May 2026 01:30:18 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm2613988f8f.14.2026.05.08.01.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:30:17 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andriy.shevchenko@intel.com
Cc: jic23@kernel.org,
	m32285159@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: reject (response=NULL, size>0) in scd30_i2c_command()
Date: Fri,  8 May 2026 12:29:43 +0500
Message-Id: <20260508072943.9777-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <af2SaesfmLw-AG0d@ashevche-desk.local>
References: <20260506181533.409-1-sozdayvek@gmail.com> <20260507152800.9062-1-sozdayvek@gmail.com> <af2SaesfmLw-AG0d@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 08 May 2026, Andy Shevchenko wrote:
> Is this analysis AI assisted?

The bug itself was found by smatch and analysed manually; AI
was used to help draft the commit message wording.

> Do not reply to the same email thread with a new patch version.

Got it -- will send future v-N in separate threads.

Thanks for the review!

Stepan
