Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6537B014
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018769; cv=pass; b=AknifyxUJySRpi/U2h8N3NveV3df3+DrlCt11GUmCrV7hz+nKxHkzz6fyNYMbqqFXOhEYVtL/DxauHrtIgXSwRXKjMYF/BXfdegUKouZE3u8PcrF7l1Y4qmfoT/vRSHrs9NRlt0WVdBybPa4y+/DxrNRT9Bv00+KRAiido4op8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018769; c=relaxed/simple;
	bh=uDVjOgpE0Gq0QuFbn2GSnfi10stWjSWVpXCNEFFYpsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe+VriYb176qOSBdozTsmB/6OjvbuA2TQzwnJP45y2LlPdd9LINU0s8yaG461W5/2eFCYTPXaV6aMJWSGMd8ORBEdyVNyVGxV3Q8bmBY7I1qIHe5EC0e8IW+PUIZ8iuyTSSRpO/K6eXkDdOS/NWFbvm7emu0WdKwldV/pYNdlUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxLd+q/d; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxLd+q/d"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48909558b3aso62440505e9.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 15:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778018766; cv=none;
        d=google.com; s=arc-20240605;
        b=KQ5jXPe3BNdvGQdNIJayH+m4WRzdGHQ2n+YNmPpbbE9KVoEn19zg0z+a2dn9XYMBLd
         oIe1HjWYbf85OGEAkxpFndXxC7dFaHuyuAIbM3wiDpbqSxSUua9rAwtMpiCVjR+Yfu2I
         BHrXZyIxtX3SjFnbjPh2MJ3D4ThK4zxdoKgXwssrouNADMI0ZPvr1SnTkdeDNb8ueYJZ
         mGiLJn0qD93iK8XHif2Mp/zWQmYVTHnULBviT8iQEbHbplUtH0P+QqWYCzNFPTczdshU
         5Xty3aJf0JWbPva3fzTh8qwAdtzC4mIl076/KaDludeqGorj8m7mk3ZtRTouuFOXupx0
         D2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TZa3MvvD3SObwW51g9rONigbDVCfTPRDL38sQNYarZM=;
        fh=2LXbBi+NTW3e367I8rVEq74KC0ex+ZUCLyjxuHs2DwI=;
        b=Qfd9hjU8Ox6vHRWujVLgi3U5fg5+lS43ZYUR7Z5iSlv2crihj1zkDctewPI/Ljw5QE
         H9PZiYSkhX6x5C/GcSft0CO89WhOCtnLiSxBXkNcmH+ShJIA9kueN57bJiQJ2KAh01Ke
         hIcI4VC3F4aFjUPTwx4oKKjDH+OPlLtXL1qCySWW5NIYKsgti/SWeWyDmLwePQR3Yxip
         VU9ViTPXnjh08lajcZFoXkwm8gvcX/RVFIb4oVis8OVsiBJhUDEvJnS0PCXUlL1sN090
         QD5iWChLmARlIUiNsrp6g01NSlyBfMJVsMtMV+CgIXT+mW8AkUDfKixAfTSJM9gRCHQN
         3Q+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778018766; x=1778623566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TZa3MvvD3SObwW51g9rONigbDVCfTPRDL38sQNYarZM=;
        b=TxLd+q/dd7YBjdtKx1Sg6mSpfF9PdYUJ423F4Bmwegs/za4vVzwt+PmLzEfO6oLCTb
         KcHGdnHSfUUvwnlir2xRt7KV7P9gYBVAYay/svZ1+dF/PnndXY00sl8wtXpqP00+lwAj
         0r3RKnUwXR/IM4QNjH2V6jUzdD3Um3tFs69iDThdTlEv2yVir+T7dYrdGlxwdmyUVGk5
         oWOV4Br8X+tNkK1MoicHNoO2Gz8XeXjFg1Dzw/lSSmwmrGRKTwkHptGMqC3TW6X2Qh6v
         q13jrb4Vx2LCWAS846/IJKXkSLvv9dYkNhHv9SLF6/F9nYEa3tdHkxUycBPc7ybAsyOZ
         TV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018766; x=1778623566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZa3MvvD3SObwW51g9rONigbDVCfTPRDL38sQNYarZM=;
        b=eDbdd8w3/U7kbBgFPpIGiD+y5BKffByJNF5dMbOlUkx1ouPOOSUl6kPBrqIxGtG1Ye
         dJBRYOnsBH8JLPUh39zjlKxBdbqDhn2r2q/zLVl45oglaTtnJqOfW0SVXYJD5w+aEkV/
         2C2zTBxF+04sJDdnzQam/hAOdOPDy/B/Rpv+JfJvFUFSgmbss/EMVFTltVYDQ+Px0LnP
         mqhXzCZwUa9nl0Zf7cd2psNuatb0Mx3l6FXcWigX5Mu+4O7H19lfbnas/jKtPMGJeiGK
         3kdmC3AFD5jLMyLkJceuHoWaQON4xlw0pG4TOzE4gFFSJ8nz6IjLqTwqmguLJy3VSx6X
         DzYA==
X-Forwarded-Encrypted: i=1; AFNElJ+6yTalyT1kzidNr1agQU+nBo+PFb2MPlUM/ouQWRJhdZ3lBD+/ayAmy6i2vJQYQq01DgZ1lwm/DJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jNjWFG0Spqx1blq1J0mndtOWWlh8enG9kBmQmW8wul1hbJJy
	mjDgOgcmGJIMkRfPPo+Kp7O9GwamFtIq3uW2CBmcaSwrrH0J/iBMwA5Iq+zyUVXHidmMkvG7Hcn
	uWociLyT3HvDcruFwpFamY9X4vx2jfds=
X-Gm-Gg: AeBDiet7joWg4hlXLNW64QrBwAvfWbxoGF23pqvAu6vNd5xAsyKf44qDLDhpl7VIt3P
	4wVBUV85N7JwqLp4xWkIdsXl22ILMLFvZQLb+kw9PJuhA7I06zWVgCazEIXbnM0WSdp5MUQ+FCj
	Yugwy1Dd563+xw/ERXXfpOd5t7BxnFX5CFcsnQ74ZSYUuedC8Thjl7YMYhKenGiShHUJFTRTAvu
	ihGBVfM2v9203zgrGvJ5y+JAu8PBWg1NWnGfBrrYWhoQpqWKHCraTYEatFB35HuL+XWNu6vJ0It
	9CSj5mfyBPmCdiJYOmMNmOY1mobhl+qUIBdPhIY5iLcnTbFywvx2HZav0hdYYfs2LSjZkjCYh/W
	hTJ22EY+/GFGjgfrEVYDKI4XlraU5OHAFAR8Uqf9oueWkYtzmEHOLNY8E6bKNnpVpCpwrFZYmIi
	nTxvz6v7KJ2YbT6FUV3rrAzycUUnRu8Dqmx2diJMymWZodIBtd
X-Received: by 2002:a05:600c:a111:b0:48a:7b7b:c2b9 with SMTP id
 5b1f17b1804b1-48e51e0bb44mr13218165e9.4.1778018766076; Tue, 05 May 2026
 15:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505211751.102563-1-salah.triki@gmail.com>
In-Reply-To: <20260505211751.102563-1-salah.triki@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 00:05:53 +0200
X-Gm-Features: AVHnY4L60wNvfVySa10hoFBUwtLLZ6wEQgBxl9tXFSgzpXwDX_9o6qblPWmaapc
Message-ID: <CALoEA-xNNxDRCYxL0hWB3rEsNVPA=8U8Vk73B1vA70FzZqW=yA@mail.gmail.com>
Subject: Re: [PATCH] iio: viperboard: Fix error handling in vprbrd_iio_read_raw
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 23:18, Salah Triki <salah.triki@gmail.com> wrote:
>
> The driver proceeds to the reception phase even if the preceding
> transmission fails.
>
> This uses a goto error label for an early bail out and ensures the mutex is
> properly unlocked in case of failure.
>
> Fixes: ffd8a6e7a778 ("iio: adc: Add viperboard adc driver")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

Nitpick, but I would add adc into the patch title ("iio: adc: viperboard: ...").

>
> diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
> index 9bb0b83c8f67..14d018b5aa33 100644
> --- a/drivers/iio/adc/viperboard_adc.c
> +++ b/drivers/iio/adc/viperboard_adc.c
> @@ -72,6 +72,8 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev,
>                 if (ret != sizeof(struct vprbrd_adc_msg)) {
>                         dev_err(&iio_dev->dev, "usb send error on adc read\n");
>                         error = -EREMOTEIO;
> +                       mutex_unlock(&vb->lock);
> +                       goto error;
>                 }
>
>                 ret = usb_control_msg(vb->usb_dev,
> --
> 2.43.0

Code-wise LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
