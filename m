Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91F3890F3
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516980; cv=none; b=Ojht/V4LNyYt+dQFirsHpRpBEkvBcDWO6OkI/5J7ggoZMZcXW6nKPLVbfiIx8Y/xjBHPHUvlbMt3NQMbqr6ituNtWUzUEy3OsT3FC8A1GhrWnEyDTG/WEeQvijNX8jeVXf6GKX10kIAPf1AVgVr68qU8FxAqlWrxD/bSgeIxsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516980; c=relaxed/simple;
	bh=D95HInvC/7wNSJPaJQt6SRLmjUKUsLq+wBbHfpIjARc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYjx3IztqYRD6H6RoSMPJxjTkmDkz2c03dLRujX2T/3E7FO/I9pqmN0SLRhii8+7OGsRcmgNdXcIbVA2FuILl3yr7BDHZc0mEujHy7S9c6AD5QqxevDwEyJnT+cJNSOKofkk4W8tyLAiUodqxIRhpJ1t6ulyOKu6XRC6yLcedgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdUv6tJ7; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdUv6tJ7"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9aea40d799so2916869a12.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 20:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784516979; x=1785121779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uELaWXedQ9qQGNcAq7Cw7Bv4z3LDW14NAE5K6u6YwA=;
        b=kdUv6tJ7Zp7mxZEpUlH3s/7Unelkyf5lAOkW0aIZm06SXVh8NUccheUUm2OzwozvoE
         2quPVXPJv0R3MHttOAEVvQ74fScKz7GuxIeJbqdbAO8N/dTsE4l1ITPpu3CWE30B+hCg
         IXYQyyf+huI821STCDyz9a2U1RSgq3BT/nGvjqQeuXEtKym5BlK6nrTgsLuuKF7cmAC0
         EVGPad836kJ5i90y/mCx3asQbkGmV+w4xrKZe5V2bamx2QRna4n1PTkQvK+ZcuMvTdL8
         gHAxC25wA9ZJjx88wN84dKRNveHrEKxjd3AwF2HYuawopb8xr1oaz2BpVYh+VhpGbV0v
         wFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784516979; x=1785121779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1uELaWXedQ9qQGNcAq7Cw7Bv4z3LDW14NAE5K6u6YwA=;
        b=VlzrNxKKe6u0NbCmvOpeMWTNqkKqLgjIUl8ryEZpYub2fsU4S7mN9/pqRatwdU4cnO
         uT7QIHy647wLUWAxY+tRiyHxILDtea3CWYnxMQ6XGY4V9v8mwdPXcDxOzzF8kJkW+eaL
         AKWxc2pTsXLQgv0ArtgHRjWetIbI/Bnhun44MqQdPNpUr9QZmOfncZt9yHHBNmJMBgtq
         yFO2UdVg5cONigN80CCBJibuRoxhfqZrU9E9IqtNmsQQ+R+3EFY1WB4/RGdAPK+c9yxn
         YOaZmgE38BUEFoPAgplurdBA753a8Y8llmz2o47//fPK8ZbWWi12+BD8ShfmtSvQCLMo
         9Z/A==
X-Forwarded-Encrypted: i=1; AHgh+RqyS8hJtWPw7tgx52UYS5pe/WhmtOf9+rNOYz0lIG3l5U2mEIQTo56NUNHpL2vOZ42PpZghYjKKpmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIop4G738RIoZlhJNNuij6Ap2MRNFW8dCzg8D1mh9nqOIVp3I
	UVvxy1MEa4azTv7ittoFX3btRuK6FEf7/9BhWgBj4oacejXZsX5aJF9/
X-Gm-Gg: AfdE7cmmbFDj1WFPQKiAriI29L3CIwI3/jJsacc6vZZ1FuK4YGFcHUSai2vnC4sA+jZ
	X7Okcpj+6tWa2JWq7qIqLzLpU5jOGXXTCHeqDl9EovfqfwYQErT8XzYZ16/xuHX5NTckql90lx3
	od6FKFv79iqVGAF+RL3npP3tI48JsW6eeGtjv1SXOBxTYnGVuRDfguWlGFC20bAV5+IZ8XajXdT
	xv93Hcye56xDou6HMm5NdJv8rEFHkHnOoBL1w3K3HuiTYyYXZ0OPK/miqZRDqHxBmXUACkugp3I
	3EaEQWKpEciSYxl2IHIVJsOuGiZArSFwrf+ujZuSVHyrFn2/vDEaKvQ4P9635eMfAnbZ0ybHWLF
	cr7i2WOtSDB3umrNMAOUlQuFp6LAgT9EP5n2nPHKtZxgC89b1oL92FiyaeoeDW+nkykaQf1tetY
	hebjhTd9lYHKGZa7ySKNO1yvKGypvtRpSmtKhjz3sgQBO7+lsEMBTtpg==
X-Received: by 2002:a05:6a00:391f:b0:845:a435:a2eb with SMTP id d2e1a72fcca58-84c2927fc39mr13129007b3a.31.1784516978856;
        Sun, 19 Jul 2026 20:09:38 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc7adasm4962151b3a.19.2026.07.19.20.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2026 20:09:38 -0700 (PDT)
Message-ID: <5eaff736-9271-487a-a9d2-225580ff449d@gmail.com>
Date: Mon, 20 Jul 2026 11:09:35 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, jic23@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260713081127.115197-1-cwweng.linux@gmail.com>
 <20260713081127.115197-2-cwweng.linux@gmail.com>
 <20260716174237.00004b79@oss.qualcomm.com>
 <8d757505-ea93-4dd4-a374-79f143f6f949@gmail.com>
 <CAL_Jsq+5N9AvzQ0cxUVY97Ad+CasR29Fan7sUuprDYjgqzWjMQ@mail.gmail.com>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <CAL_Jsq+5N9AvzQ0cxUVY97Ad+CasR29Fan7sUuprDYjgqzWjMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rob,

Thank you for the clarification.

 > No, document what the h/w has, not what a driver currently uses. The
 > only exception I can think of here would be if only 1 interrupt pin is
 > usable on a given system. Then it would be just 1 interrupt with
 > interrupt-names to define which one is used.

Understood. I incorrectly based the binding on the current driver
implementation rather than the hardware resources.

MA35D1 has one EADC controller, EADC0, and all four interrupt outputs, 
ADINT0
through ADINT3, are connected to separate GIC interrupt lines.

ADINT0, ADINT1 and ADINT2 are generated from the corresponding ADIF0,
ADIF1 and ADIF2 conversion interrupt flags. ADINT3 is a shared interrupt
output and can be generated by ADIF3 or by any of the ADCMPF0 through
ADCMPF3 result-compare flags.

I will therefore keep all four interrupt entries in the v3 binding and
add interrupt-names for "adint0", "adint1", "adint2" and "adint3". The
ADINT3 description will state that it is shared by the conversion and
result-compare interrupt sources.

The initial driver will continue to request and use only "adint0", but
that implementation limitation will not restrict the hardware
description in the binding.

I will also remove the redundant maxItems property because the fixed
items list already specifies the number of interrupt entries.

Thanks,
Chi-Wen
