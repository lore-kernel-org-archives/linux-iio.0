Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B730566D
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781478661; cv=pass; b=S7TgVWXHWj0LybEsyfmbSMreFlAIh0HDtd4AVNaDNAHAeIsBBE4czRtWovEbcXLU4Vf3kbHxiQE7912MeUoMG8BId1sNztz+F1oc+SUnGj+mSVvJItmTFlLcsC01WPI9SD5kUyY9XoyV9xe+VaNws1oHFro/oh9hZVP93OntiKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781478661; c=relaxed/simple;
	bh=rjVDYWZQNGoDR3AfOz9WNdT9V1VkyrqPMS3E9BtwqeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDk1QQEMEmTOms/qPNVC5GiWrynBfZ40qY8DzrwXPfyxeIF9cIc12WZI3pH7CwMNhkYo2jpUWYWimE4RDUg5tfdlZ6c0ZCtzv1Ei2IIWDCIhULNT0YmjF+0EIOvZjjTFqjuiE349OSoDmGjhHj/HXNFAjxJnA1vW0UBCA5f5S+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/rQ9WUn; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/rQ9WUn"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7efd49373c0so23136437b3.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 16:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781478659; cv=none;
        d=google.com; s=arc-20240605;
        b=HH2DXLo/XqvvB0dVwokNaRJt7HTxuyWsEDvMSOI5i6Gtmjn0GELbnrcIXxf55NMmLx
         Y+yTwkHyQzdxb6WSuvMWX4AaMqltmOqZpqVHS90sezO76FagpxLWZ+5XdBamn5TLDl9p
         ubjqSz8FGk0lWOGvhrlho/qMKR7JwquULYWWNz0xin+61hzrjSPyOraEO5407bjnjnQh
         ud43/B2Lhj7mDISgry3DoOLOtIBinyypfuHvLfOlrXlsF3ucF8kK+skZ9pGQWPlMNbtc
         wSXGjkd5LLE8pl6VhyRKMOJTGkCht5/rPRkHN4UJZkM4BxV4V2Kdu7GOuvQo0FWOJRUp
         0dQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rjVDYWZQNGoDR3AfOz9WNdT9V1VkyrqPMS3E9BtwqeI=;
        fh=8sIX/Vl0vzEcdQx3jlFYwgPhjzOlX2aanozHvZCXtqU=;
        b=XMUPqAf27ae0bJ0cIJbxImsw2YS2zGpUY4cIBee5wX06Hsw+znR5wrEGO7vvi1slOA
         +zr4Oprw1ZCcdWjcfPu+dqDUm/nh3QKUj/UIVvQJvMJqdc8vGdRC3Kg82RlgRFjhphH3
         rsTj8frT3Uf/z0brk+KsQaEfu2ATRNs3iBmmg39KDW0W4mmP/kw5oRqU+6LGIsQK48m+
         +LQw9S6Sh5tdFjRc4EuFccMJ+7n6eGZQe1OdZITNf8Y0gQ6xZ7fYU74E7B6u07OqsTFN
         BG5sN6HgV2JIZbo++O0BKW5EhgCiGC63EXPzSCbylPgb/roWoOYn5OgATBVbFSl8mdsO
         fong==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781478659; x=1782083459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjVDYWZQNGoDR3AfOz9WNdT9V1VkyrqPMS3E9BtwqeI=;
        b=Y/rQ9WUnSnRTgnKvIho+BP6VlLmMvQjPMm2L1zRnnSt61zarLhZgCCrippOwoPaJZL
         BGXRYiKduA9nKpb60aYCFcUTC8+UEwrmmHe9mwoEMqpxv/gm1lKiRet29nOGs2cUB63c
         4baP8oFhn5YjQaeGT4x4lOskt/mvh3xgf92q/mrXhUX/IbPqM4MqfuzCu6MaASwC10uz
         PAAwa9VZ3swFVW9R4GN/NsSc8Ba6gvrZR4cmE88JWLADMBIao/e6P9TiUdYriSMLfXuT
         vtrS9NxAXsOxvPjVX1YclDa+kflPiY4BMT40I7E7XkrFe2zLGFo789dqJsXiB2jZYs7o
         7Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781478659; x=1782083459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjVDYWZQNGoDR3AfOz9WNdT9V1VkyrqPMS3E9BtwqeI=;
        b=fb7Bsku0Hs2lT7qvGTMQ8xFwALup/rLy6A0qw3QnPKmuJVYw8ukoixbvntFXv20bJA
         8bZ97ZIF7agBDogtxXt8NfZ8ydH9M6HXyCOzOVk9o/kWdI36xrD7rozFBvECK4lUnmB7
         qpk68+DJIcytcfCkkzaHKmNKk2IoB0S4deFpFh6fE3nP176L7sIIVwqrphlqwL2+MpT+
         /oTnTMfar/nwRePalv8SPOkGDnTlfaw01hQm8/jYIFYs+7UyuDXtlzAPT3+weI5y5JB4
         jYhlOXKO5Bumm3ipkaKlK0WYjUnpD+wwgcJ80s1HRIIkHlcTXXdSDbU1I+k7mZvfxLzx
         0vCQ==
X-Gm-Message-State: AOJu0YzXv8DPal2fHvq0+BGFMs+r2b0TW27k1JmaXQtl1p5JnfJqJX8G
	/xMqUUJhmSx7gQdzL/aTGWUBIbFexv+gOQjCN67SaXP/SgV9hNgjJU7YEHJBX7uT29lpNCeSYcr
	hjaRH5WdLqZAItMOfOYRjF6idn6RfgVDJ36xGMo723A==
X-Gm-Gg: Acq92OFZcJECv5fDxmJJIhtNx376qHD71iAF7tjHjRikO8df4wk3j248scQpA/i+yvw
	bx59a+KSyHQBEVRhUtIKqrU9qgJD6hE1H4ErYYQayYGWOkVeFHYnYEVX93tP328qoVDJ4W0Dg1H
	IpiuqTJ9drxz0Ey4Oq2/mXTPI3SvIv8BC4mC6Myq2ctn2MPnwHvTLnj4Pf9aGEsjb6g19Suqh1E
	ZwFMp40HSA8XKu78+nHWGbedPBAhLE7BbgWOz/FdABtl0ZHWLvKttk36FXS4Mefw1uBxXM3KFvU
	7nA7QR9Kn8LNJh5AR69uJ0KBo1t5xQqTkqtuXD8n1VPErytEbyY+h3mkMArEQC598jPFf9n8yDS
	u5qPU5Q==
X-Received: by 2002:a05:690c:b01:b0:7bd:9566:ef0c with SMTP id
 00721157ae682-7f7b862e78fmr119687847b3.26.1781478659551; Sun, 14 Jun 2026
 16:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
 <20260607234343.22109-3-kimjinseob88@gmail.com> <20260614185914.6c14d376@jic23-huawei>
In-Reply-To: <20260614185914.6c14d376@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Mon, 15 Jun 2026 08:10:47 +0900
X-Gm-Features: AVVi8Cdqkxn_jwr_B4sti63s0G3x0_uMazWV8Jxn18jsY8E46VaGjxB-zdDsBH4
Message-ID: <CALMSewJgdzLbX0KYX5QjwOKce_+o8B6jhz0jh7x7PKTRTd0JUQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/6] Documentation: iio: add Open Sensor Fusion
 driver overview
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Same issue on needing this series to be against a suitable
> tree, not on top of your previous version.

Understood, thanks.

I will regenerate the next revision as a full standalone series against a
clean upstream base, not on top of the previous version.

I will also check the final diffstat before sending so files from earlier
versions are not removed, and fold the MAINTAINERS cleanup into the correct
patch.

Thanks,

Jinseob
