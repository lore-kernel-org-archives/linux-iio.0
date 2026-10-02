Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A142902A
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946287; cv=none; b=LmZfSQi03jzk1x/MOawqL0VDki84r4KjdO/0vwBg0EnBBFpWpm/wBlptjiETYwPkwJwBxspR9CX1C9rYfHqMllujAzTGviJc7u0ecBGcvxmZ0MB0Tla8082HfUjpbCT0TDvwboPhz/JSdbzDvyzqkuShfoE06ncBrefCA88kn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946287; c=relaxed/simple;
	bh=LE21Er5LgBMHtoxp+XFH6YUALhySAAW4QWfzMht/7MU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ub2Ft8/O0MEQTWidPJsqCX9cLz69yur2g/AFuvZ9f6/ZdUQYbkdKHhqoBrnkRfDNIZzwnZw7q8TsPlEX07V7FzuqgitwXO88fjFhcj4FF2mB9vNhx9jTzl+RSMtLTlsYudo/m+edh9AG0MNU6NhnlahfSlxkiVDjzvAjoKfC91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eptsl36/; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eptsl36/"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so58067065e9.2
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790946273; x=1791551073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcKwMMClLBKjo8sc4QYgIFN0itGSVJ9653Hu+JKLxpE=;
        b=eptsl36/XMborLUPk8kXrYOfxazY2FU5KmGoILvZ2K5hDCU4IwqczDoDW8mxh4G/aS
         T4iyoQecDemxSRJ+meKTGVcgs7Az51eECuYDqzAaSPjMtlL/5XIrRSutTubuDB3/+M6B
         dihVaSgL4/LtxVJXQFR7qqtH3I7Fo+oskriHleMhcqX3mnsA961q3y2q54S60PpYpSKc
         pxTsIStAferxUMFwqm9buRTs5XI/8wyixDftgKHGaDtoZ52qEv/E7M0rFnjvaydvTM/t
         VtyUNL7rnCx2cwPwwexr7jfAqSXU/bsGj7A5qmfHJt5buKdU/rrY9yztt3MVYue4WIAx
         g8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790946273; x=1791551073;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcKwMMClLBKjo8sc4QYgIFN0itGSVJ9653Hu+JKLxpE=;
        b=gQ1cucpL+OBLvObokA0yiD9G/HI9QpWMrbt3H+foHikDhPdyAXPqzhKv7rDlomdF8p
         xXN1VySYCw7/lqpwby0qr9oBUCWYp+LrJSrZZQotOFwsBHG/Co00EKTs4xhD7rHYDan/
         hwd66a22Vw9o/cgJ3wsQ+a+m7+QQce+ayWSd04JwmyDYzcNLApS5lyJN8/cMR7PLHexU
         JJSxdUdfu3h0YqOZ8v2x6l83SxUbKuR1iPgWK0tF5HTfTAZD4IzLRZPBwn32pxudRO0T
         x3LvKijFY2RkaTCSoAy+O0HezcQc7zRD0wh2STUKBAIIDguOtlRQUQRkbMkGzUuwdqL+
         tIWg==
X-Forwarded-Encrypted: i=1; AKwUvBw9SgFCyDhxqO7PMhxffrNqY19DwS20fJm30+e1441kAA7INdloNFugynaHd+Cw+UQHBAMdtA2T8oU=@vger.kernel.org
X-Gm-Message-State: AFuF++nrTUTyP1AOdgA4VeVg25n8cH1WP8fg2wrCYF2+a7wd7rzo73h5
	nzOPXZbWFRbJSWMVmx4wBWk3qZg/KUt6HgxtAP/NlpzWxmAfctiAia9F
X-Gm-Gg: AYBFou09SLNYff8SowL7HDD0S9BCHI8tbNxdsmTaRE/uE6JIvyQNoM2VTw2Lny4boz0
	2icD6wjN9yNtW4g50Njil50yxaFeYYQmaC/kxlrDdgWT5st91NLQD/tpASnBUthoA2M8B6ztFFk
	8aAVl7IDR/658mevXciQZP1g2VF7q3kDl1D9NYiznLApvpSYkB6ExhbPH8ef6E46Iza5V2kpanO
	Hk0EOcl5nPyzutC5SUaiYjqx61GoIpMSQo5idobLv1DyAiZ6GnW3jW36mxCJwx1sIUIbzt6xIm4
	ZHDDfCNbYeEogRff41oZJUew8CCo2S7w/g8vJWNWBPnwkrmyH4rppvLSXpDJPcP46KJwREMLk2o
	HxlefX92r7b4dgZJ3dQHkuIoRe9nPtHDPqfNliVD/sfv2mhrlXH9/0BxE0BwIhg9xhId9eM8V6O
	IjBeWRO3RtVfDPiUxLGptmqJ9jYYuasEdssQwhjR0nFahFJ+XhMwmp/PMlhHxeeeKafF5QzBb3O
	CJ35YV3pHDF2ey1L+7fXOQKf6e/wGGa7Vcq1z/uDtT91n/glVcoVqibRTpwKbMcxWlb0my/hQUz
	gnkV2Lm13WfHGYwcacvE3uIZ5LfgU1+FQ0wn8T+oN9bMfYnDuQnBLNh3Rh3cT83wSH8w+zI6fgR
	rwhZrBGZi5wnS+KGEMPLNNlDlDTrdQtRpjCNaMb6nklv0B9X/YFZ8SyEek3IL/fDecAKU0uSvKz
	zj9TdI
X-Received: by 2002:a05:600c:5306:b0:4a0:1feb:de6a with SMTP id 5b1f17b1804b1-4a0275863cemr45486965e9.30.1790946267381;
        Fri, 02 Oct 2026 06:04:27 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm61064485e9.4.2026.10.02.06.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:04:27 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:04:25 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Liviu Stan <liviu.stan@analog.com>, Arnd Bergmann
 <arnd@arndb.de>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Shi Hao
 <i.shihao.999@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: ltc2983: avoid -Wstring-compare
 warning
Message-ID: <20261002150425.0000286a@gmail.com>
In-Reply-To: <20261002124902.3703019-1-arnd@kernel.org>
References: <20261002124902.3703019-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Oct 2026 14:48:51 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> When __ltc2983_custom_sensor_new() is inlined into a caller, gcc notices
> that the string compare can never succeed and warns about this being a
> possible mistake:
> 
> In function '__ltc2983_custom_sensor_new',
>     inlined from 'ltc2983_thermistor_new' at drivers/iio/temperature/ltc2983.c:1079:24:
> drivers/iio/temperature/ltc2983.c:559:29: error: 'strcmp' of a string of length 24 and an array of size 22 evaluates to nonzero [-Werror=string-compare]
>   559 |    if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is a false positive warning as the code always works correctly,
> though the strcmp() is a somewhat elaborate way of identifying the caller.
> 
> Rework this by replacing both the strcmp() and the is_steinhart flag with
> the sensor->type that is always available anyway and identifies with
> code path gets taken.
> 
> Fixes: 3dd0c048409e ("iio: temperature: ltc2983: Add support for ADT7604")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Makes sense.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
