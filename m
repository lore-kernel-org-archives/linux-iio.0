Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B271FD4
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778372088; cv=pass; b=WsC0Yrwnk3gqvjzn/QX/VE+kFt1UVq5y5XD7NYdIp28EAmS3WmG8IUXi8fX9GHlZpFUXyQeb5h+/rzzd5qa6XKLgctujPi8vZ4xYj08vpXjXDNlWm3dEEj+E/ectaz6lAYI5AQ25IXGmD5HknUn5PN3Xe1auVQRstJFjf+UDm/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778372088; c=relaxed/simple;
	bh=UxIPxGiwauI9YCQkuCObysls4we1rXy2SOE1g8tRgds=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k3wmfUZCOSMjXGMbbdXj6F5JwVSt2MnQZr5LtCxmG1Eey3zyWNKxM/asHzHLBDrJbLDjh//L4d6PXuYDKfDO7JHhf/zrFqQyCifWivJZpypoxKuZpw2NzozJLDNRm8rkzDw3/801CqdUsm8/1D2zr35YQHiuHdVkKGdykHq5lT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqGEpWIV; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqGEpWIV"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bdaa68cf81so30470957b3.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 17:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778372086; cv=none;
        d=google.com; s=arc-20240605;
        b=Euq7QFdekvby1RhCu/nPNOkdex31b/7v2MjaXYeQRdADNbHl9ZFkS4bwxfaw2acFjQ
         qxDmMm6sRfxgDO/O4uBq6ik312GHuDSMu1G1j/ohwR3Lwf1lks/PRK/5um9KsQJSMeCX
         0vEAPAa/WEuYM/DcyGZN7IrwDlcXcndnlk3nrbyfPz60M9OSzGvCLYFzFAEICXvyeie4
         RmpB7a+OPFcvZSFt4RD6u5M/q8p9OgtxVtxWR8SItrA/Cx0S0wl9kFYYcxI/nD2dNv0W
         xDju13nevVcxEAc8JHd2NwgFd+3zSvdI1SeihxKOo8UiAQZweix0UNzr7JPe8hUKVVaL
         Ye/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UxIPxGiwauI9YCQkuCObysls4we1rXy2SOE1g8tRgds=;
        fh=PYQDpy+i997YfYnoRRs6Z2M/6yDWEdRdoDRcSQwte4o=;
        b=YffLThRViiUNOpdMHPqLitbb2xVg6k3hNbUM5di7L2Z8UScCNtSQN4H5PMrP868v8F
         d6B7QJEF9/G1U2eYZAHKOniPKDA/Ai6tRuQLnA/viNXOdEAUsTS8OljQgoCo3lxF65DS
         payQqvBl6hjPXn93p3x7tAROwbpwRCj/ynIgdn1v2CUScSCsrJR7ZsXqEejJXL3mvn1D
         sDAcTMnvFVb5F1SBk9sTToQ4mqKnvwnojfnKIpYQ+o77zc9jygYL8xGT22v7PIx12xt6
         c8QyIFglhokbjfvU8kf2mrI6ejnDZwfib0qr+UCWEICnGGaWf+dLiPkU86bMEK5Ue5DW
         djyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778372086; x=1778976886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UxIPxGiwauI9YCQkuCObysls4we1rXy2SOE1g8tRgds=;
        b=mqGEpWIV+1wXlf68uPhkNJHHn0FdT9slUllF4yUu/JqHvgQCAm1HJftO7q6Z0/uqzV
         dUlqox5HaAx9SJu/z3usii0OZ7zN7vpxQ58UE0DX/A3iwP66Xi9QJTj/vZu5HpXtW22G
         YkZ98pXmuS/U7bepBtKuT3BkHDtD0FoiIQSz6nWuwfKFcVNEbEcZzoVoeCkE6Npy7Ilr
         FTpqSeGDEDjoalPHxRi6OSbVNDmUdUwZKu0VVKV/FG1vUVbpdYm3yZlgwGQUfPE0HLVo
         LriassLhrExBhTIaIq81dpiMj0vEZYxcKvVzbq5KEHfNJdbB4HVDDH3cVtpCp82b+m+W
         c7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778372086; x=1778976886;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxIPxGiwauI9YCQkuCObysls4we1rXy2SOE1g8tRgds=;
        b=P8BQdeSdpFq/dq7MT3b2i2U8uKlJ90wzObficPTQa4YvThvsp9h+XBT6pEbMSmko8i
         7WPiPNkQEAYkjejggIgK3Pq/se42hffK3mZ3zVgMQCAH6q5eah7U6HaI9qS+Udy2ghb4
         x/tVWJCYhQyeHmU90AFBNLl3/AupyI5W9ysHb399TNTpTpQ2U+Akw134bYm0oTM9sr7L
         jtpTLQjZVsuFbvlji9AJWzwX3r+4KCo/nEgA6YbLuwRDifly1h769stkhJqBC/CUKZPi
         Tpv3n2KFPGnSAUa80ADRTZBlBGIWiVzLKsKy7EnOr9UICunrHudn8EYjnNS6GdalpBEd
         2lgA==
X-Gm-Message-State: AOJu0YwFFU+LQ92QB9CSwW4RyBc9E8klJR0+dudo2/jLrYlEq4ULIQsN
	NKGZXH+AD5/2XGyfpET56ZESeVUn6ShYyuIyDe46x/t2nDZuB/O+IR5M0x6K0tbkw4Y0hVQadAS
	7IUY7OwgHDqw1CA1sXfngi3xZzEtD7jA=
X-Gm-Gg: Acq92OFxhtSghBLx37Ut3Iab5fpXvC8KQTuliZg7Svyg2AVtYzbuyliEXa4ulSV5nX4
	w3g30TYj8aOgu+3kytD0ZlRIbu/LEGHIsG2Uq99Z453Ub17e1v9Ws5q7BVSwT28fTAbroLzWwtD
	W7wSVFGLzWF0NXl57Uoyh5OSs6aSLoIBZKoX2RTr9i2rC6Slk+66tefDNseKPaE2IIWrW9OOFwu
	57QYVSfboki0/m6JYQ196hllAz/AgSgleRmcAS6NDOVsNlQDPG8Gzj1mUqs5jEOJ7Luu+eBwoTY
	9IOQ
X-Received: by 2002:a05:690c:4989:b0:7bf:3b0:27f0 with SMTP id
 00721157ae682-7bf03b03675mr145722477b3.19.1778372086487; Sat, 09 May 2026
 17:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 9 May 2026 19:14:35 -0500
X-Gm-Features: AVHnY4K42iLICF9DxL5aKegZvsI5dOmm-f9TXTq0hfMPslRBHcMezBDG0KfUzjU
Message-ID: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
Subject: [RFC] Maintenance status of SPS30 driver and related Tomasz Duszynski entries
To: Jonathan Cameron <jic23@kernel.org>
Cc: "open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, tduszyns@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

I was preparing some other patches for the sps30 and scd30 and
realized that Tomasz Duszynski (whom we've already considered
inactive) is still listed as maintainer of the sps30 and some other
drivers under a different email. I sent a patch for the sps30 and
while his email didn't bounce, I still have reason to believe he's
inactive as according to git log --author="Tomasz Duszynski", he
hasn't had a commit in a little over 3 years, which means the drivers
he's maintaining are essentially orphans. I'd be willing to maintain
them but I just wanted your input before we consider anything.

best regards,
max
