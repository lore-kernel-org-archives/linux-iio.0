Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793620103;
	b=4lMuAiN2SrQmVP4N3KeNYHwO02+gTmjkJH8EgnVkUWDa17d3hgqgjI8L9kbH55bWcX4g
	 oSk7hlL94xA9tZqc1Ed09hfRssSAosX4Tr0RZyuTobY2x72lmRvQBysCkuWeikeC7HbMs
	 UOn7gZ0OBpquVj/DUMC0Bi34DgVBOsRlJINcAOxWIBLNTQwmFJuDWTSFnbvm1IHTCoV6h
	 o+AOGxBeiTJsabELxMaleJSKrc9YcMD1iRE4orjaNSJShMlCBSt5OW9jxLCc+oHhDq6OM
	 enZC8VjSlT0Np2V81PCIXMARfGvOpQ9HMTYGQeejuG7lCjiJTKbFNkG4lMQGsI73iPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rauZGBFXVvz8AaUGJr8FmAMzmIJEbnyJfkU8F/WFMhc=;
	b=lz+peKrC1IAM374+oC+qk1DBcRfMDdjwZ+B1UEmQfVg3g0/l9QvS0Jfi4uGD1ndVvJzE
	 Bqok/VIzUZgZeianQaIut/7hYmCskOsBOzVD62or0tEn1KDgYR8pYywi+W7SLOtd9juvS
	 YN9ByePiNnGnmoAVdKAVskTMZtHnrJ58PtGl4InrlFZK76xHv1Ko07okg68PzMf8nVgGU
	 lIiWCzLD9rHg9fLbyOL/3vRNyW5j+/Icuj5Ev3luEIuz3qQIJHNZDYYaqNyWE8s4OBYic
	 3875EXpzfpmMcMGeum+XfXElwjEXUoA8xeWq+rwssBH2fp8IuI09WYJnupEqUrvI8uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deHCt1kX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F5606A326
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 11:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5F5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deHCt1kX
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6f5a0893610so2414196eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 03:48:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793620102; cv=none;
        d=google.com; s=arc-20260327;
        b=T+DsWbji7+CYIyGhr9BF/yykWdivohHFrStXXL1v7j0GhssHFOBcG7Zhcz7x4j8Ye0
         sSh2+hYrydTYUw5Rjscrf3btxgtGpeUuNMaoiNOsw4ph3grvu3E3CPOWhyU/ZrJAtO5j
         xq9navYCdFIU2jorSglhfLf6rmudajhEKBnYxsM7Xc62PGnypqd1GJXSI6Niui05sxLV
         bxGQs38BCXGaB20z1ubwWAf+O2O3OkwJTSiDgac0tKbuBIkViDcp4JOX5NpcDLmEfy03
         c9STgMjfTnt1xwhr7dx3T1bnYyzG9uHf/hLOyChWUWnu0FbO3ZraxfOU17HbjD0H3YDg
         fI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rauZGBFXVvz8AaUGJr8FmAMzmIJEbnyJfkU8F/WFMhc=;
        fh=bS6V6NWWZ/UrCVKvB7ZvKRLR0mSOfUuDjazEX2b2a48=;
        b=holWuxqR3WzR3AOpKJx5k7ixD2CXGbHbtj+JWMqgk3Yzpz7scmFfkl4hdeLbZFEUof
         geXtJiCMUfQvdoqIZzc/0jTi6lMOrn53n9G5gB7tmU3yc7fZykpyd+bBflxG6TomNAMw
         V1kkmc2yP93TiJhDXBwUJjRIe/T6dnVM/azzilATqDnO07+wZqNl6SWzKOnWLpFy8wMu
         AJqkCoLEEuFYhkLWEffuFvyUfHGFSfqTpGLwDaHPh8qyHEKIus9vCoDHnvtYjxsA1tpl
         yvqY8ezyBHaFfNJRuj9VFX6HzKhFRcsxzcZ6LjdOmsnU1vORzt3OpDfWwCfMJIFu48u4
         ONog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793620102; x=1794224902; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rauZGBFXVvz8AaUGJr8FmAMzmIJEbnyJfkU8F/WFMhc=;
        b=deHCt1kXObf/4PvERbEkS0a1GZPsmvpFF3uCs3GZzUmr5pGcw9Z1Ls/yJHcNgI4vda
         +DnXQtdzKGwWt8BjT6daHFQFhPWr6itZGXPkxKZg6HMZBJAuahL4tuusHk4BT6LtAeRG
         RzZnF9uQCOWrAjqZnUaxzvQwfQ1w67SVe+giBaEoExJpeQ6gcLkm4aGDLV0Z0QPVwNH3
         RSh19dBZp1fGxTPrA10YzZkEIqNXhkwava3+eNoFuE6FeZ85r70LQTLmAAWFroOsXnvf
         Bt2dkGahlmFI83l9YX/vTuGXTuB+AZ6LWMZjrDEjdUyjd5AIo1TkjBSJgVLjrWvTiFWK
         UOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793620102; x=1794224902;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rauZGBFXVvz8AaUGJr8FmAMzmIJEbnyJfkU8F/WFMhc=;
        b=V/QErww9X/p16UJZkqU/P8SftQGW0huXSKr0+43RlTr2ABlVKSlcRY4QVu2pMQ9ktQ
         a8XUStN0ztBTiZMpv9v7hLAyK3Gg5sgy+VkiEURGKpkb5ASAIhW2a/uFur29zcWY5R38
         6yOOR24lY1ScB+fzyLTYgbn7aIjXfJQ7XNB0AdK+YiL3ZE439kZQmWnLNxs/2QaD64jy
         va+fNWPKdsy/T3ISmiwlMkKJXK7IZ71/xY8YAV+CCR7iGsq556S642jB98wq1IJvY9B/
         hoTNh2wyo6fyRIr5qbkhnEvBeUJrLVEYvy5DQ0ZxUhink4jEq6ChBt6G03WSOfloqh5b
         gMUw==
X-Forwarded-Encrypted: i=1; AKwUvBxviGGZzYCowYm6rQD56xbiCGg+kjXvVjhszugWNdBpsqujP/9v9umZNVeGHzHGCTv9yZolFlTcRO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzRFaPYF1EBQ4LgQEk8AezW0mCuLqQxSHXLNodRPqlefWhY71M
	+7NwpnpOhlhiG2X08nboJISCjzzIFQUg6Ddi45xTcluZHUc2Y0O7Md5JSqtyPBA9KxcJHB8uBQM
	ATH7XBZnH/dJ69/m40Sd2ey8ybH23kfo=
X-Gm-Gg: AYBFou0oEy96aMIvnIyA3FtkIR1L/7os+hRt1D2jPQWmQQfctlXlW8G4KXTBDeMADZN
	hpvFGrW8JckRf+CsnRlfkiizujNDHG8d7zScgo8ADyjH9rmO6EYz401ByC7n2hv7dgK8JiOFkWc
	YtpyxogTm5xT0CNUkLtPSoO1HHlONCgXMnDlKXancWp41ZcfVyExRjQRx95sOYn7+RyqSy/uNxs
	Q+i+DnIkexc17iwn4rSfzYOaK9bx6k1dz7XwE5dgSbGvgJs0qQ/KGWodx+ovMjoiHnyj512ZVC8
	g+/yjYrIXYwILmQoS6FrB+OAOGj031NQCvARlDOzhogphnOYqj33vgEm2ecKnQtJ9c8TBrtbv3B
	dVJfMo2NAWtzOuxE8bmEtarNie4VsFbj32GTPNI4mYOswur2MxIFQJRC/heZsv4qe7lhe7ZL956
	/W9O9SAbXDOK2zXfz6q2u6DOJ1vj5fFoyU+UeR3umhK206WgifEQ==
X-Received: by 2002:a05:6820:1501:b0:6e0:1599:a4b with SMTP id
 006d021491bc7-714f29883fdmr5485309eaf.18.1793620102037; Mon, 02 Nov 2026
 03:48:22 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com> <20261102-massive-busy-woodlouse-8d0bbb@quoll>
In-Reply-To: <20261102-massive-busy-woodlouse-8d0bbb@quoll>
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Mon, 2 Nov 2026 17:18:10 +0530
X-Gm-Features: AclHuK-Rix2X8fn5EwhAQXoIbuQmroe9ZGiZTVGN5aB_rSm7KEtS6EsFTTUOsQw
Message-ID: <CAFqz8LJZQ+tw6wmLS-1FXvt6OxBESPEyz2-uK4D7B8X8epoKhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 02, 2026 at 11:47:56AM +0100, Krzysztof Kozlowski wrote:
> What changed exactly? b4 diff fails, the patchset cannot be applied on
> any known upstream revision I tried.

I am really sorry for that, I didn't realise it was based on Jonathan's
iio.git (testing branch) instead of linux-next. Patch 3 conflicts in the
Makefile on next.

In the binding, reg is now optional, there's a serial example, and the
pin 5/6 descriptions cover UART too.

Happy to rebase on next and resend if that's easier.

Thanks,
Vidhu
