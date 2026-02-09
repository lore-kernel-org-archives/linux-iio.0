Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164E37B40A
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649374; cv=none; b=N3+oXy9qQPlS2qWtstmHBWA+3S2CMA06G5ENPh64vgq8IsZT8EUb/KaHQS0QRCMGYEl+K2wtJzG5r2qY1o4LVycWWipSxdedS0B6LV2Woxbg4LWpDZv9nrL3xVCmurG6u1VJqX3p9S+NSyVr+kSKifEV57VP0ZfWq0ekXfRalSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649374; c=relaxed/simple;
	bh=pvzEly1h6RX+5nVyvYuepMJ628AC7g5OzHsBQ/W1VAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7ODx2rvCg2peY0gHoA1opcdZjd3L6g/x99YTOk2C3Jsd7KmtT9pK1R4YuX2K3jgGOJw+ruAw3lj9W1XwCVUEJ4tmetp8xtL683myHfWTnMvzn7NrTZAe+kDrWNR92dIHy0EoxaYX6euk7sLqOi2NKMMvvLrsWXeXP72m55nV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAnSSzJP; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAnSSzJP"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64ad79df972so1845395d50.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770649373; x=1771254173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnnQJD+R93yDtjYhHjFYKLpvoPEvYMiSVqgAW4EPMRI=;
        b=PAnSSzJP8ujJVxqTMnZRfCrGq9BowYuIdYfD97HBGs8nuwlaaNTUGdkxL9ZSgiGN/H
         4Kww/lnhaehBHxy6C6dsSmFMPXdjOp9c8oguptPCIZi3ChArLGH0LI73rqWuAPYQBtpV
         apHg7Fq86zIfEWeJuMIRuR1u6zgJvJ2aztjJJy+v9Cw0qyFkk+sjGgFuIURJl+VxtLjB
         XqG5YRMdSlf3F/4bpkvPWSLCr6KFYRWHWUUbKoUYiARgp1FZlZkPCXOLOCHK0WQN5Jb0
         KG4/oheYSQOOzAm1NUo7Bfz0DUhCXW26W/qaxSuHK3AjBLvEL1wWAK+uHHN4am5nwf/d
         LB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770649373; x=1771254173;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnnQJD+R93yDtjYhHjFYKLpvoPEvYMiSVqgAW4EPMRI=;
        b=hu3eabljPU8z7ZDrMlfwq40pOWpOTMYfb1FkeR7pCMU2KsE6Sy7q0IevApIVFgcwtl
         czzQmfWwbdetZofYHp+v/0WGdC4UWt21cyeDL8sRqLpo5ux4rq6LwIzwIRMnrLt/gFJv
         D/UyGq8TUq36ecp3qK+r/+dXpyUwa/1T10XKe9jnZWnCI4gyGC+FvI3dQbLwSA7emdi/
         H0W+rSysb5zHPaaxeBfI+VLzPIbNhZuA1W2jMf3llnWvmSzAoC6hv928YschJHiL9jCL
         8Ud9i20ZM5mEjO7tYpt5UJ91OubZJobwtzv+zw6wZHSo+9nekkj4GuGIdsIc7pEppkwz
         3NGA==
X-Gm-Message-State: AOJu0YyCapGJZ89Joe+UZTebewxRomTF03LYzUg8Qob1deTeOjYPjslY
	4/aZUtjRNLFoKfyqoQjVla0ju6lUUcz9VQgK5IIjIqq3TksyDEuozmCL
X-Gm-Gg: AZuq6aLF/3SQ1gP0qO8PYY668Rc26E09h7ZYxb6jZMdZTma2ebZV1wQgsT8yKYQv69r
	yqq5zZ/ZREr084J/at9K5jX/YiPewv2+mrB15mbFaYpn6bNZ1Aq0LrcaSexx90mOMOqTQKbzdka
	l5KdV2yrsDXKSRItlvyxcdpkOTvTqm8FxPgcchQDEEYPQ+J7OGQpjh1w2PfPusclBNCjXcCyUf6
	CtVIXNef6L+rf1SkV343eVbxZo+iSrvHcNsasAxG1n8eaJMo4MT7KUuNNJKP5pokJ9C+gHMvhiT
	wow+cTuSvTu7PWI61LygmRUu3luUGuVxULWEglySnMlXHZP0/R+gCvzajCP0+4fh78CJBomLnWa
	djPY7TEABD5QUv556N4SgH1yiyAcYLkv4vU3e7gOb5p3bZcf5NZxmRaoqoRiz+39/zjUq1BAL0w
	3tlYV/cxxEQYvrVg==
X-Received: by 2002:a05:690e:13c6:b0:64a:e3a6:c393 with SMTP id 956f58d0204a3-64ae3a6c5bdmr2693312d50.77.1770649372033;
        Mon, 09 Feb 2026 07:02:52 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649f248c511sm10301423d50.8.2026.02.09.07.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 07:02:51 -0800 (PST)
Message-ID: <dcff3895-53c6-496c-8574-96943d1eddc5@gmail.com>
Date: Mon, 9 Feb 2026 17:02:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: Add binding document for cm36686
To: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
 <20260209-cm36686-v2-1-a48126d2b124@gmail.com>
 <5614db64-3ee4-4a41-bd8b-5b89cc3264aa@kernel.org>
From: Erikas Bitovtas <xerikasxx@gmail.com>
Content-Language: en-US
In-Reply-To: <5614db64-3ee4-4a41-bd8b-5b89cc3264aa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Compatible says cm36672p... Confusing. 
> Why higher number is the fallback? Explain this in the commit msg.

This driver was initially written for cm36686, which is an ambient light and
proximity sensor. But cm36672p shares the same register and regfield layout, it
is just missing an ambient light channel, because it is a proximity-only sensor
and has no ambient light registers.
In v1 the compatible looked like this:
  compatible:
    enum:
      - capella,cm36686
      - capella,cm36672p

