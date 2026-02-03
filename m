Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BE37E310
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133272; cv=none; b=bwqLqFymoqehCZ6Xq9il8lmcyWX52oo+8290xQfRMHMsqbroagRHGOcmGrnS5ZqosgA4KIG9aEN+Yo0CeNLpQizYD7jy7LnCLCSiAJZK7zpqgQpZQR0Wyw+iiMZfHrrqOX9s4xg0SOaCpGu4jO6U2OBjaz/y9mcRHLR4fALaOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133272; c=relaxed/simple;
	bh=1LJxSgDfu2qHVQ0BcLX0FLZBAv55EAAcPTpRZxMhd0k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kVTStRDpSEfaU9637slroRIUCy37NZEULGrwgZGB54qx2WoYGZ/FwipTNentURT74bhLA0r1FEb9f+TubWHX+d9R7ol4ToxZH7Wto7blzfZyYXxgswN139YHGgIiT2ZmBZFMQ1inmOeQ0XRVwHGiBTDOoIj05uAKoGjqFT7aJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWYzJmqr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWYzJmqr"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794f281eb04so7776397b3.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770133270; x=1770738070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y+dHBcJ0EB1oMWtqDa79JLU2lSQMRC9g+f/II9Wq8ic=;
        b=JWYzJmqrJZlDuWM1M5XSmQVkgjbQcC7n26n23tCf3PGLlAdKUMHG3fwNQyMmVm3ZkA
         K1V+/fe3vNvj9m2gpSXu7EXOOMCMLYTpAIMUoNTCUJW0ni7iz/z7Fm7rPcR6KDQq7xK4
         ItBSQRcNiyDYGU9SwuC1FC/yFjrozk1SC56D913jf+Ua85WQ1j/kmZVsmYiHoygrctCU
         TeXJVuXmZBXolSbyCba4DGpse3lDmguwg/wiBjGHL2o17ltHCvkFuHQ+diVXfAL+GGqM
         4HMLpjX2VLE66GvCE68ai7nPtr72lbMMIBjr/h+BZGUR/Dp9v7EFbqwryxuAvUhAlaiw
         eG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133270; x=1770738070;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+dHBcJ0EB1oMWtqDa79JLU2lSQMRC9g+f/II9Wq8ic=;
        b=aN4axuUUfsocWlezbCOLom9Va4696akYY3M/Lz0YB5TWbp7wo3zTQjvKnVeuC7xigY
         f8KeMJHLmQ9ArwxaVjtet+9ch27LwxcQXppyyyyTHv+psa3kIEde38E7cz1HVMLbJS63
         Y0Cwkp1EqZOUdd5rWEJ3syt6WpRhoOnpGlMBRmj3qpipfq9b+lQKkYhArZ97V5rd8SVF
         VYnwhI1jqE5JJ9fK5Ea+/G2WowfielUz1vLi4GE7CF18s3mtTeUv6csw29xSj2q293sj
         u92fe7SpYV3reVt6xjfD6pM6gQRvj3+sfrilVIkpEuuUZEgHuolaJYGuYJABiMxgEaAi
         nkqw==
X-Gm-Message-State: AOJu0YxVh//CTGD+T1ktPaa5Cl5ZZ8pwTTfl95hLk9hkRPGcuHPSdA9E
	VXIBhWwzs11oaHv+uTFoO3YzBiNKYSalFQBy0AqTqQIYoFSm3fDoJQDd
X-Gm-Gg: AZuq6aIuncWerhA631TAlGpSQjJ3SddrbItkONzKLOwkL3Zrth1uxVLQZdbPT0OnDfq
	J2OoPKctLBYVji177FDILK+bbY005sE3lX0qucZB4RlouNBhrYAVyqCO8ILXMF3aEhRHdysDKn8
	wm1cOocjF218W1DXiJ66RYVJ5joGentblZ00pFc+7WUZA+Kt+fAJEn+AIMZy2VRklLzW9PcZYkJ
	lpSArMwsod0glUsGrgS/PkLiR7rVFqLntBUXjGFwts8AbqHfZ2NTk+1qQUb2XiBl8NQvo9a/xLY
	g5lEpm2wA248/MGGHMJzlaoZFboQ7womqfI9hXcnWR10dnvtGS9SrtLUM03OB+MsYgTiCBkX7st
	iPBBQnfrePC7MHAtQ5FnBs7aDn+WZgK92VEpU6+IthPzkJfOYstxMZBjSx8RoUtXIa/E1Imm6cw
	qcJIuhEZslhsAGrg==
X-Received: by 2002:a05:690c:260b:b0:794:f3df:80f3 with SMTP id 00721157ae682-794f3dfa1a8mr32368167b3.69.1770133269769;
        Tue, 03 Feb 2026 07:41:09 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649b30b5825sm8121645d50.24.2026.02.03.07.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 07:41:09 -0800 (PST)
Message-ID: <372c9172-ea01-4a3a-b737-3f7f14519791@gmail.com>
Date: Tue, 3 Feb 2026 17:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260201-cm36686-v1-0-4949a2a9ba63@gmail.com>
 <20260201-cm36686-v1-2-4949a2a9ba63@gmail.com>
 <eb922433-3951-409a-a397-b48efef57b7b@baylibre.com>
 <b133521f-434d-4972-82a3-6e7978e557bd@gmail.com>
 <086d6b35-8c19-4e92-9cd1-557b98991d35@baylibre.com>
Content-Language: en-US
In-Reply-To: <086d6b35-8c19-4e92-9cd1-557b98991d35@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Pro tip: when you reply, trim out the not relevant parts like this.

Noted.
> We could start with hard-coding the als_trans_ratio in this driver for the
> scale (and write comments explaining where it came from and what we know
> and don't know). Then at least we would have a scale. And if anyone needs
> something more accurate and reverse-engineers it we could fix it up later
> with a DT property or something like that.
> 

In arch/arm/boot/dts/qcom/libra/common-proximity.dtsi Xiaomi sets this property
to 16, and they set integration time in their driver to 160ms. Maybe
als_trans_ratio has something to do with integration time? In that case, we can
calculate the scale from a formula, like this:
scale = cm36686_als_it_times[index][1] / 10000 * 40000
val = scale / 1000000
val2 = scale % 1000000
This would allow us to preserve lux value when changing integration time.
