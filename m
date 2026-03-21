Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C82236E8
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774110769; cv=none; b=q0G3CnbYskM+8jZSZwfBdzeLwn9Ap/dJTYkki0mELZ8vAY1WsmLcMc8qbUv2BLPM1zBIOLjY19/OdlVRXR52nzbeouU/oIm8rtX4NhfaHhmrsO9pQ+WNUBgtxplC3NozCSVIvmPZ9kDhUyIEjVxL9Tn7U3vPxhW5XUEDZqKo+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774110769; c=relaxed/simple;
	bh=51vCU2JKcnieIWsD8YQCefsAJtC6XXkN7CUpD28t8cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmU806eKwaUa5c2SKPGQYKVcJOv9mFecDC6Ofuq6omtROPopaVKjEhB26xccp3OWcfCOkp0psu0gHBSfdm0ooTRc34szT/Rzidg/jKmEdlFtcte0CsDTgPoOJxqcc1LnOgN3D6YKxCv9A5B6+IRnAJ9A+3cvTof9NDZ8AeTGt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uulFcl5P; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uulFcl5P"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d55b97f358so1906465a34.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774110766; x=1774715566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtwhrQ2gjpZhQ+N5aLTaxEqh+xigBy2WpOl/KG2IX60=;
        b=uulFcl5Pv2mgJ34NHLw5llA6hsg8OnVyMP7QSIqvyQJLBYTkXH0BgYN0oO/ra2XbIE
         si+S4ojPblpOjDIaC7DqcsWoFe/bAAAIt4fHporfh/G4Vu3tVjxPwosZ8gt097uUodnz
         LxRV7yAnt+/JAutKXyqwt9Yu1NoMr65YcIVZD4cxi/c4TaJhaKMhMrZpANfyyJdIuEF9
         kBdJNl/6KxwzLKWkFHCZu7+nmsCIWIWJpXuDmTy2G17tRI3qIiPkTgYM1OCNylpFVC1c
         GjewfTiknzJ4y9GDlP3z+YRqUMALS7FiZxsvAL49plih5qfVIleaoF442u+5949WEx5z
         xkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774110766; x=1774715566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtwhrQ2gjpZhQ+N5aLTaxEqh+xigBy2WpOl/KG2IX60=;
        b=sS18RKH0GXG7XVOfwHquSHTqIgHOJoyYL//OhiCw4UVzuE0sHwby9ShqQG8eqNqCwv
         WstUHWniDD4r0BhXXiLoTNwKo19CzQChsrMz4NQeTq4zJyFFqnGNQG4GxlLrId9Urayq
         Ywm542IAwgxgFVXB6Kd3RYymf2W/joCAZx4PHCUZyrJIxbo0EFFPI4OFOIW89jErEXtB
         X8kjxJR+u/A1sBJGspqxwhaeGWHgfn1nahSIsRxTO1G18Lp/9OYlGssGzFt5rxHNkvaO
         2PFahOKcTJU/pnkGksKI3B7sXbyXb/rtRAyRJKh8rQMsB5/kFdNr9ncxZ7fLAIy+3Uv0
         nRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzjdJoAfR1/90u0DlzSSQn60AvSpTnI+Sj1xh0rn3fDLKC6P+gjxsDm8erSZD3nWINHNP4qNLEzS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lrgc5BGevqRgFR+7JKerfblnPrNARd5H8kFk2OzvUYnzTv/Q
	mJUyakgGHzYIg2522sc+hRBwGlsXh3zLbKY6hyCphG1zKBx7hu78vmYU2dOXi/n/gFQ=
X-Gm-Gg: ATEYQzw1gFt5ke3F0XasiVZVQ2kZhKpnDWVxLU9r/T2dY+XyeQilTDQ2C25LIgVmgER
	5mIhul/rkW0iR1qjAI5xkjYX6dNsKXDFon5VSP6MbwRr+K3mbvj0/A4K2HdG0cpo2fFUy2DTqRo
	JE7dLZlK6hG9GQj7XTNDO+DaaLNeSmgEVYgcrDeLKvAOhu9JByuPUXuekX4E8WMdPehW2U+2hrX
	ZJnxkRlHhrv4mJx7BH/VKP0XFY1w3YYkJiueZcbn750LLK5ZpRTZmIeE972ipMb3ZmWVuiT2wbn
	C9z9KEJw+7suO1DfCfPlVsmSrRGIAHPM+T3+XGbwOBm4vXyD2Fzmn/hdTIsh4bighLRqGxFOUv3
	mayOrJQjZ23WjzZREN6Ji7YiCcZgmTXUDLa43SYOVLPoTFb0VNQcaNig2fW5yiWJpQRsOgND9t9
	RbnmG8WyKYXfGXrywsLMSZTIFRp2yiTL70vdLyK5aMGVJNZibF0qjHYyra7KpIhsEOQUY2J75rJ
	w==
X-Received: by 2002:a05:6830:81c9:b0:7d7:de7f:1216 with SMTP id 46e09a7af769-7d7eb05988cmr4010495a34.34.1774110766143;
        Sat, 21 Mar 2026 09:32:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8e89:f58e:e4e6:5567? ([2600:8803:e7e4:500:8e89:f58e:e4e6:5567])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eaa025dcsm5323038a34.0.2026.03.21.09.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 09:32:45 -0700 (PDT)
Message-ID: <fcab4c63-4055-4aab-8cb7-16cdbb917c23@baylibre.com>
Date: Sat, 21 Mar 2026 11:32:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] iio: resolver: fix typo from degredation to
 degradation
To: ShiHao <i.shihao.999@gmail.com>, jic23@kernel.org
Cc: andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
 <20260316090023.14691-9-i.shihao.999@gmail.com>
 <abgt1yoYTnQEiAlk@ashevche-desk.local> <abguXZJjIXMdqcU5@ashevche-desk.local>
 <abqsaI6-hznIv7dO@fedora> <abq7g-9GnQaFc_1K@ashevche-desk.local>
 <ab6HPnoJZLocFIMW@fedora>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ab6HPnoJZLocFIMW@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/26 6:55 AM, ShiHao wrote:
> Hey everyone,
> 
>     Just checking again, is this patch series  rejected?
>     Do i need to send it again? 
> 
> Best regards
> Shihao

Please give maintainers a week or two to respond. They don't have time to
answer emails every day. And sometimes they even go on vacation. :-)

