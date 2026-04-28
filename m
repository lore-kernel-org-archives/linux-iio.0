Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB52EDD7D
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368103; cv=pass; b=avqdTHdBjJDRwJh+QyfF5NfJdBHzlu54sra5FeBqepuOVpUom8OeR+b0nJVmPT9xnSnjCqX5uzUoX1OldYxiGRCWNf7bMrPw68kW9slhmzOpbe9JB0s6+ne687XHG3BJ2RUKmNMqjrLlHxkCphu15XutI0+bjnw+rF2Iixj7Uus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368103; c=relaxed/simple;
	bh=E4gp86cZxA1edQ1SUU1MrTluAvrMQy004dA9rP+G7+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6JbVc8ncSM8RvBTQM8vLuIdmUa8p1oJQQU8Wvhx6445xUMsUYV2hQqUnOjMFNZIjfQbF/x2SgYDni/0kaElQIi+jLnupcdC1e3IhktWBqL9X53K5kA6EkWCvvmd157+GAxe6E2TDVikmlc130kG9yqJwCME4XfjX5RKMeR3SMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQmd3McG; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQmd3McG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso92901195e9.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 02:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777368101; cv=none;
        d=google.com; s=arc-20240605;
        b=AaqB1JUXfIsf+uA8B7+Y3P7n6UyNA1Ahtvv07mZ96S8qjsI06Ykk33nb5hKLpvP+hc
         /t5zYpjFb6MnL0zCfFwXLnswxW1DwXXqPpDPoI4/f1kXF8HRhQ5PhZaCXoX4fDdE+RcL
         y/BWGECcp6XRxTzGRGq6otfg7FH6qiAoEhpU93HSNJHWYvE5CxNw2+KM1/LqdkgSRrz7
         mLF+rIPCBP8aKJLSDnZ5YUrLYq+ROR/cYZtx4gNKuKHZZ3OT8wyV82xa7q2n7oasVCD9
         e5i39mxBGQDcOxCbOWcQBbAEXJFPt+Gf/uZqlF0KOVV1DLnhYklHh3cw5OMtI3ymROBH
         /IGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P/F6IAYFhCqiZUnokBz7RxmrgXwr85PYZvLOiOy19eU=;
        fh=Dg5zoWqUx76h3UPcxsppTHY72IFDoZZoazTlpye19aI=;
        b=OCnz5OBL2plGeC1H2uxoxgCxiJG/ZDNa9TEapKCwwk6Vdcvg4Yh35+F6oEV2Ck4gnr
         tViLM2J0+Z7fbpPB7276+zs9LX0J3RJBH1RqmHUd7zxL92YxY4q8JHlBOA3AL6Fu7H6W
         8CSVkGwTmyQp6GjLVXbJTfuwB6M18jTmnORbal00mKslPKMIQy0v/IuZL8ZH/6ZO7uZf
         3nyxns954u5u0Q+1BHwo8Luxj8pFJC74huKpF43MNOkYhYOHNNZiO7OCY87xzPtGyvh5
         wCb9OPEEAhiaZpreO1p9cS7FsDXpyJewNrv6ofg446DhVVJG6VUQWovVzLXwYxKKGzOe
         5twA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368101; x=1777972901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/F6IAYFhCqiZUnokBz7RxmrgXwr85PYZvLOiOy19eU=;
        b=GQmd3McGFM3ow7saWDOxppDH9PEr6DDp2T1BnFtbjebxpnrGAOdTw/WG8lz7Pq88ja
         B6q3jX/aW1j2Q8ahyvjP+6ZSZxNoCDO3d6iRcFVVqkVdWoL8IK4+Ms1p/37Y+sYuq4Ev
         SX5+k3CYMl+9s3tJ7ks8MNsaEWUghM6rsM4EL7wlNtsvJhnWbxxyVvI7UkExM4+RAESM
         K9w/vCK8IzABU+GV6SGNgVPoK+BwWxxmY0jM5mLRPFP6SVeY+4jbCzxm/p0dosrM8GY/
         dbNwZ+t/Z3SbQJ4o3Vl6PNg837AynOnaJ1kbAtm/T07PFGS7uOFPy/UIF2lH6jqx42R/
         w40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368101; x=1777972901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/F6IAYFhCqiZUnokBz7RxmrgXwr85PYZvLOiOy19eU=;
        b=J8erO2maYUe8h613T0v9Rvpy64MjDkxu9UZy4T64GYsa6n0TjF5Y5cSUVIIsZphZXh
         4LgVrWhUFYYMJ+SPSwi4OJCe9S5nbezFzliAhcAUnWYyo+tdzmYi9zHYXVxFIE8Y4ObE
         18THVH8MJ8mZTVW1wywIOYxwxcPywpOPAkTEEpZcxbc/emiMyew4RIVHwL3yTisJ3Gce
         RkRDQc7h6QMKDdueHcs+2XufwP2G3dXWjSN001aqWkepzWn/Gas37AJJvB6BpJIlraZs
         xu7asn8YzcFr95IWCmBmqVvjubT7HL+ZHwNuuFqIcAISZUYxOfZbs1VocS5filsp/rcG
         jx3A==
X-Gm-Message-State: AOJu0YxevI9VnlCJ6Vzq9uI/vsvritnV/8qliMYwGMjn2Jh8pCxaE58B
	H5T6W/9QbmPXZkYg8j5fHXft0Ez6MXVq9Qjg045Hh7ySwyoDBnt6ISiSRXeQy36fIyXkyyA4y9e
	CvV3Tt+T399v1RX3ATk33j9XNdF9aVFM=
X-Gm-Gg: AeBDiettJjUAELIQuxoEoWHmNTh8FlfGAwQ+o1VttVV5832tvYGrSb+JyMLNQU5mGCf
	9HzsrQtF2swCbfA+6+8K3GzRVNkkgLXbRqUN5azpfcZsEpBA2DKu1UGjNE9EaHKHHQ8HznMbzI5
	ebLi0RGCBBGySg1FQOiDmtvaxDPKflCTlezIoK2kUURD+cYPw6+QVKJ2z8UQxnRC7g9xzMtb6yP
	WTZJLfhhKMDbz8DjVk/C/mMWSYFpo8Te6dG5bSsIJhW08YpmNnxN5E1uf75LLLgS9g0bkUDr7O2
	lDhJ8ORVgMSgkjpxMsNJrb0QhWjLb8F4r6yCKpIY7MQ7oNZe4Z2rNaPdj40N3+1b4TxoeAFZc/j
	/jJQ9QZd6lNeCp5+qvirBlivPIX98IX7inaLR6VHgp48hqechAALzpSqoclLC5hOOkdKqp0gsKf
	s7YgNKtlLNkpeX4F2G
X-Received: by 2002:a05:600c:8283:b0:489:1f08:91b with SMTP id
 5b1f17b1804b1-48a77b1da8emr34390125e9.16.1777368100704; Tue, 28 Apr 2026
 02:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com> <20260427201412.3067235-13-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260427201412.3067235-13-andriy.shevchenko@linux.intel.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 11:21:29 +0200
X-Gm-Features: AVHnY4IU3ehsjjvuBYIZ9NGnT6gPPfmPyfss-eZGGr8Ylxdb0nzPMQYePibSK0U
Message-ID: <CALoEA-yjpDhTrP1Z-ZgSohjJBE8W+kBvTeeDHtcguvb4ReiV3A@mail.gmail.com>
Subject: Re: [PATCH v0 12/14] iio: magnetometer: ak8975: Unify messages with
 help of dev_err_probe()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 22:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> +       if (ret)
> +               return dev_err_probe(dev, ret, "%s initialization fails\n", name);

Minor typo, better to have "initialization failed", but that was already
in the original codebase.

> +       if (ret)
> +               return dev_err_probe(dev, ret, "device register failed\n");

Same here, "failed to register device" would probably be better imo.

-- 
Kind regards

CJD
