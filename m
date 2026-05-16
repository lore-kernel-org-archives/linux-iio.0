Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7B3E3DBC
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945037; cv=none; b=EjFAoeASEjmzHPMNrT9/SkoUF3Sgvt/AmGWvKFI7H8mA/v+VBkVsPdrvrzqkkURCxB7pLQdtlihttzBP6r0PSlF2dNvQxWUSWIE0gnKGxqLpAb+ZwwK/HrNImhT5OhpA/ClBvT2UMSTuZlLbDalxhOUQaaxKWo/6cCt5sbq50D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945037; c=relaxed/simple;
	bh=q21qE7CxpHCFqxnUE1xY9T/lsDJlzA/XTaD3r/DtQxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJnqUkr2xxs+5rUrlInfd7VjOmteRCc4qQ52w5hYG75eH8ag0TyrEJEcuPfh8ezYUBqQ2MOFdfw/8ZuX87TrM/3WKqNnUZo4Fqy7kp16CRqzYFvWbox7xBS7caj6QzlQD+V+XuiEw0on8ir9QsafhUWKp7K4zk6/MQjLsVk6ak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4c00kzJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4c00kzJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ac04e13dso925885e9.1
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778945034; x=1779549834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q0up9/HrhOHj+j+adfhj2mtVYK497Nsuxv5I8Ikx+o=;
        b=A4c00kzJWn2aRX/xchw2HayvIFzEFEAMMUWwtY/SXeOrnwQaF9/fsvTaN2A+FzA7Pb
         o9DGxFkUn3L6pZQCu5eu6+r0fLHF+9lsQo6jU7XQVIMZ/aqvmOa8X6IC1AyJhRsVT6DR
         F6yvCMYDraH3AWlg0qqQD7iG3F+BXQHBGK4p0tH9TIJaBoJ4Ye659vGWHHZXz8yvzZlX
         0BKYWW5RJ4/odK+E0LmAim10zEZJ3fq+Oo2IE4v5YQ9uQx0Zs81M4CqAG0V2k7iAR/i9
         c7jzE7KiEE5BC53f06C9hqTvoASIhDrxe5Sd/80X3NLEo/+kVOvSGQR81Pu86qenhavw
         Wvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778945034; x=1779549834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Q0up9/HrhOHj+j+adfhj2mtVYK497Nsuxv5I8Ikx+o=;
        b=rekK8b4xojjIeTDyGbX0jAWWzc4Fth752Z4TDGYjc0X/YR9JsrvV3pmTdRUac2d8Cm
         volQoJ+wfN88MWt/VUsfcj5b6/rMdEOKrEuwVyoIH5hhWbJMnGBQT/oXP08yGGWJEhAM
         LpIpzfIAJk+kee2tXqXNkzAn0oQ5dZWBWlnrN6I6yOxzU+MhjSBB5px3pdyg/ouCx7+i
         d+dzwLSGZd+3LY6CcY7IaPaighxFiyZ/8YkHtyL2wnniuBn7gKx4th70VM1s8pM0PViE
         p36P7liccJ7UpUfroFzTeSkKGvi/J3l0Q59H6oKdUa+X5JmTDKJgAtAh9q5wa/VP3xHr
         YoDw==
X-Forwarded-Encrypted: i=1; AFNElJ93sgPaEQM105pzz2xO+dg06dM3ajj7LAYJ1Auzr9Pxps50rlnKdD0jCuoZdgzTRBWml4n4qFwwW9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdGd+Uljo1E+FcqOjhnMLjOoWjywXW2PgkeliDRanvMfPvDOC
	doTl1Jx4a/6JCYaiiphgchDCkcKs7Gf28U2qk/eW+GDzoc2y14gnuEzg
X-Gm-Gg: Acq92OFG+Tl15m0EX5lh8GxaKaibXdjOcbWe8aZDueMgYuEv6jGPg9t4UhrPEn44GBZ
	Z4QjdLFf6Hmrm2HETaGve4A5GWj0zgP/xhCluG28EO3efBmCP2Z+SsCnntaqOpj26lDGHqsTQhd
	6qATdJTtVTfvaUFJtiZSzpkOdJp4mVtzL20BmkDInG0nFbpTUanPGILQbBTHHYAyBsq/L7bI/em
	1Rd8d3ZLsidGx+cY/15SxsYPCpSfsYFjTeeXrAtKPI0ms6yQZSXAKZKmLGFOqDl4DYsxVxVH6R2
	r7NFT2q39tqS7ANNDF5D8j6LALVAEeLhffDfN+TKMs9XUSRynchj3AX7JqY3d2dmkuYCcLNl+Mw
	vfMTULO3o4OGHMiXD629GGqjlXgNQTFm4UMCaIV3P0uRl2Qy5p2LpcZ3MjflJSy/oxeduDIkO8p
	kzF4ajEf7R9IKCgAmYqqWPoLPLmvwL+D8bXNOxfdrx3SVJjQ==
X-Received: by 2002:a05:600c:c177:b0:48a:56d4:7274 with SMTP id 5b1f17b1804b1-48fe66423ecmr57106375e9.3.1778945034321;
        Sat, 16 May 2026 08:23:54 -0700 (PDT)
Received: from localhost.localdomain ([185.139.138.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm127342465e9.12.2026.05.16.08.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:23:53 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] iio: resolver: ad2s1210: split trigger handler body into a helper
Date: Sat, 16 May 2026 20:23:37 +0500
Message-Id: <20260516152337.1743-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260516151721.1982-1-sozdayvek@gmail.com>
References: <20260516151721.1982-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, May 16, 2026 at 20:17:21, Stepan Ionichev wrote:
> [PATCH] iio: resolver: ad2s1210: split trigger handler body into a helper

Please drop this -- I missed that David posted essentially the same
refactor eight minutes earlier:

  https://lore.kernel.org/linux-iio/20260516-iio-resolver-refactor-trigger-handler-v1-1-25b11ba0155e@baylibre.com/

His version is cleaner (void helper, since the irq handler never
looks at the return value).

Reviewing his patch separately.

Stepan
