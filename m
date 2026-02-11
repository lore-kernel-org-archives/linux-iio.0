Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F7313E20
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807972; cv=none; b=aS3cLNAKS+jWHMtUEwl2ejIeBQGyUTnkeDcxJdu9DWvZaPVjci9awXDZi4mYXAX0Zsbe1clL9aVdx+zExHuMWeZ2nhBYWbHxS+AdI2uMcbYGHFIAYJ3Fzxv83//5CeXxmKekHWKvOvlW3hbcU2CnNRPFzZOo9V18gFbmHv+c6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807972; c=relaxed/simple;
	bh=HvMwN5NONdCSCa0ZMWtKwPRDsjEEIFgBlh6+5R6BvUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgCBd/LEiR9moWCyYYdMKgIe3XJ5FbkYASiZjMoQ211G6RD3Vo0T8wnCaQptUhSSZDmi/oozxaIaZV6qrfoHMmrxgZAJ6sHmOhLoZBZZuVGdkcBULqb7pPmXiYmTwsgPnrCSz4cacJlLXRdoeth9GC+YOEZzbEIedHfp+D+BBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvQOoOzi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvQOoOzi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4833115090dso17028475e9.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770807970; x=1771412770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvMwN5NONdCSCa0ZMWtKwPRDsjEEIFgBlh6+5R6BvUI=;
        b=DvQOoOziOAqqFzIahB96UncdPg4glMVZATxgMrofuHWrJ77vrDU9Lz6Y2ac4zS0kBP
         AYqitwbDDj+0LFJVL1Ah0jF1Ud5ronyQ4tKmkhztlcLagCcBnv+BdWRHdHQ8e+8kQ+du
         rM6HllktD1A5p8oWCHdJJ8AVrbaDs30peFGgcGnU+LTqIPUpr6XkTjbZUdHG1f3/mSfh
         XmARFMIY5g27ZpUB5jkCc5rHwKR4vSAgn9UkBdWs3VZgw00ySG/GCcjvOu5YLFs44mbo
         sF4RlSadMMSLxi9FBxKSIzGY0T7i8KXuz2Z/NMNtp/Dj0ADciBadIqTN/QYUHqG+W1FS
         XMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770807970; x=1771412770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HvMwN5NONdCSCa0ZMWtKwPRDsjEEIFgBlh6+5R6BvUI=;
        b=ShyvTnaulByEkT+DpWoRBhfZnv1x9vTWTcGYGgCkNRJ1wEbYoWnJX5b0rDrC6XXc/R
         5IIusU49N6goXH93bxG+qXAGf2LZwGjWDlP8i8P/kTRoIB2+vGzAhgCgEaTm+EngFeWo
         33ui40XoqWO2GJlzOxlk7y7bem5phXJytsG8SoAREl61zO7bFrXabZ1uVeNaZkfjf6xJ
         Y+kpTHRT64GN8iYz+loJZmuuQWvC2hDBhMcWYT+tGoDZ70C4ZNzaI1QYYoxn/+i/gspc
         GkXeMvMCQ25C3NLYdfvhXzGixqKhaYDoNmTlEpBfZ5boBPsvpO/5hleUnT0OOm1MynYB
         JG9g==
X-Forwarded-Encrypted: i=1; AJvYcCVc3wK405LzX81ItG2ms6vtVDXIDOMRrM1puefiOW1tQaXhaQxziclp0E8+xtVbERBk4z58DO5eR7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIV/cNLkWtB/AjLcynodjClBTwVNk+vKGDeOLzkNMme1pkuPge
	/25wiTcErBhdQ1I4wGcnaOMLEqR6YVyho2sFogwmf7b2qkIgtscDcnnZAdz+Hw==
X-Gm-Gg: AZuq6aIWPTEz7cSLjcir6exeHOLRlz7R2s6ZV4oWUTTbODwrnZMCgcpjWAU9A+iJX+d
	+I/78RE9j5KyN98fNe+K4cdLe0sTYQuPG1aSX0a/zeUwmGiKFW/qENmi15Hq2bBc5Z7ibX69hqo
	NFvOscwo34dneHYge0g26KTZEAl5okxa8lAZMJPX0jACrWhDtkII/cw4tctqi1J/iK6zJl8r9kI
	8oVfFHuWfZuG+2SZvH8WFBGnzZkh5QRNL5Io4XGjhBJk1BrYr7LWZfYpyIHBtzJlk2ZT/+98TLQ
	axEAC1dDnfmtf3Nxyc/4cB7RqTgHoZ3VOTHizn7vNS/tNM8k0BBx1xYSm1/HOs35aYkgdULaq5l
	zJtVW+7B8wISBO0l9qZc67InMLazZ+rZ71Ccut0my0IzNFvvSMBh8hDWj/mP47Wib4N5PD3KY0n
	Um8v6rPBqjyNcPp9FVKUMCWRZnoC9RQRCvs6VUCr06qIzRnbB5bmoiObPYQnd2
X-Received: by 2002:a05:600c:4f0e:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-483201dce33mr293325425e9.8.1770807969449;
        Wed, 11 Feb 2026 03:06:09 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d989165sm41940855e9.2.2026.02.11.03.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 03:06:08 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: dlechner@baylibre.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [RFC] iio: dac: ad5504: Inquiry regarding voltage scale calculation
Date: Wed, 11 Feb 2026 12:06:06 +0100
Message-ID: <20260211110606.3468-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <81fa8ae9-3c72-482f-a998-911acaa89a8f@baylibre.com>
References: <81fa8ae9-3c72-482f-a998-911acaa89a8f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Thank you for confirming the issue and for the detailed guidance
on the bindings.

I will prepare a patch series following your suggestions and send it as
soon as it is ready for review.

Best regards,
Taha
