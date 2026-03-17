Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63851494C3
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773729145; cv=none; b=QUdvjIRa61kiQ5Zo028vKLRgNR0jCp8ZDG60cmuFfU7N9iKWIGPglVc3ZFXZeLRRqHWvkyNwMMJxMNNnGpP+ViUbs8GUyCQwn3kFIDsGzmjpiPjwFZ8/0j/kDNJmWQDulfDMtIrQrnCaxWTY8oRMmNOhfDqAlhWU+DuaZIc5oAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773729145; c=relaxed/simple;
	bh=htZU4hh7Xx65c4Qs3YCuLjw934CPG7maDSwh1ZXz178=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpaU0JpSepG4mjq3N2O8v7ERO7h0IqatS0btdCE8r+MSZ5/8Ux8hiGfu2q5kHCT662iqfW+lAoAuCC7Ffcqf/uv3mZR+8L1WL1/dzNh5OCD8B1efMQy7VMIdJR0VlLIA//4Ghr0Xm6Ic9W4Svujs3WZfMcZPQcODEo1xBduCg0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+c4PLKU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+c4PLKU"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a13a06fc85so6265970e87.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773729142; x=1774333942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0H+vBci0Tg+qnlHchn8zarI78gCM2kD3mls/1dQlbrg=;
        b=U+c4PLKUA0DcBHnaUroD9HMFmWdqx49Ppoob/W9Rnn2TfRjzBM3POFu1fkn3kShVOn
         9UpowMD7TBS2wJN5khY+WSS7Ky1jZT/rzoX5I+bCP1vLtvylApR0/7oUXU5equX5w1s+
         1iGA2feYFA5Pe7BSyMok4PlhCfXiCmc4Qknql7mQRablff76VsdqAwtWOiOk2PZp55Eq
         kUhU3hY/oGbPNMg0tykuxpYXgG108zoDRh9BfTdCedR7vz6Wshh+afQDLe+GtopjZVa8
         1vxjgVFTxfDot/n6ovcqlOgAjh7IhKbau0w94egEYa7z+4QxIQGVRlnb9UCVkGKAZVGO
         IFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773729142; x=1774333942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0H+vBci0Tg+qnlHchn8zarI78gCM2kD3mls/1dQlbrg=;
        b=tJEGY0fVfgOjfuCWs46iUnMtauC5Bc0jAHamWfNy0gfySSoZ2JI2zUz+TRp9FGJS8A
         VLJZELbkvQXP7/QABJ4cHUsHOBWcTcpi0Mba1CHRu4DxKZ6TVvmgVQkVdSbV79qRM0vg
         wGvcgMsL1Hns5RM9mK29rDGHSs+PljrQYaFA+TxSfGRzVOa7sA3VooTPdNicnGscGSxy
         JA+EYI4RTX09KKqYMn+41ryRHEIX6mqGRP5E+aqB2AHzLYbIWDUV4PwfEO8RS09cPQz2
         5i4zYKSfisbTMnVgG19uzpc0LWTkSSdxSTUJr/yUz6M5w6WkTtatsnJWHHGcp/AL6yGY
         jGow==
X-Forwarded-Encrypted: i=1; AJvYcCXgfKbgf3r22rW2xq/T0MqWB8zaTLa8kkzuuoaO+i4WCDmMZTPZBJlsn06dUBDmUIY7JG0sfyuZ2ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyMQYp1vfuAdI8Ur1fxzNedabCe5sFfaaMxbCZ3qog8m0ZQq0j
	OFOmhhcCf5dRBW5dwD7s06IhRrYirSlpTAsy3Ovto2+tjZwubBXqhEoS
X-Gm-Gg: ATEYQzyevKe9BOwPaz4kq+0a1Q3Qft/EcM518ddmJjMw/fSHGv6IhsyUBY2Q0XoeS0D
	wR1DpM1fhByk3wbjEbVneg3oJCiyUHHGIHPJuDmY88sHdKXhrwrxDW4YBr+LmoL/v+F0N5kw63I
	pCf/Fb0hL7tXDJmaZdALRlqhgmEpOUSqcTvLlZKvrz5Bj8e+muZjxa0TU/61LfPw0raIxau0A/v
	fRLMQX8jxlUbbPrbZIL7ZIQ8ND0Nk5bU25KLzZvuTN6zlZtZwRmoN36cf1lTA5dMsH86fUPfBgU
	PgKLZOXI6U134bH6t0v6PwEuyzo5Z0oc1NCF0MMsLsPiRrYYKITQRfeHunw+vMSY4jAVWuGRBso
	1EECrXMk0XOOZ8L6hIIjVAmWdQ/I3T62dE6EIT/Lg3ucN+MlrdyVla76JDqePKXf7DCCm5kbR5s
	bO6yWveBhYilgCOGTmi2jkLN/5/FX9ERUEpowtzxx0vb1NNRv4WvpNbR35MV8V52XvLpa17pBWz
	RVO5N64
X-Received: by 2002:a05:6512:2553:b0:5a1:3bb3:9ff4 with SMTP id 2adb3069b0e04-5a162b1d8e0mr3992976e87.33.1773729141807;
        Mon, 16 Mar 2026 23:32:21 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33cd4sm3893838e87.8.2026.03.16.23.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 23:32:20 -0700 (PDT)
Message-ID: <9eeedcfc-a39c-4922-bc81-a91ba51e985b@gmail.com>
Date: Tue, 17 Mar 2026 08:32:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] iio: test: fix typo from neeeds to needs in
 comment
To: Shi Hao <i.shihao.999@gmail.com>, jic23@kernel.org
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
 <20260316090023.14691-11-i.shihao.999@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260316090023.14691-11-i.shihao.999@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Thanks.

On 16/03/2026 11:00, Shi Hao wrote:
> Fix incorrect spelling from neeeds to needs.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
