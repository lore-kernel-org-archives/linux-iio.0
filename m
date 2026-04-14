Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE773C3447
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159064; cv=none; b=rqDqEj1sqZ6oK+Rzafu4WUUz+xYZxwFST0JzdmzMpw3+vTAH41n93P+nbjLDON8tIrIZKJYwJauWynAD647ygk54Xz8MlE9AQVcAsbJoI6gVmoODuBcGlXiCFIBRJYvP8+7K09UiAUnuHkAy0SFPjEvIpFjIb3SKDl810b40uHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159064; c=relaxed/simple;
	bh=MtE8HFy8h/E4hGPSqldnQm4F4trB5xVe2YBSkRUcE/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4CJsQOvquG24Qr0mOH6tGRJheh3dL4gMVYJYL5yPZT+3XEXUwIDlZ1BcLYxJpTOnRBofCTEWuuVIOMyhNz11mWZtlZRholAfCyzo42SKkORbceAHwXPVhf+dMZ99q3UvMaNyX7KX52ARmbkf8aydMLJF2GaPQbvXdxzjVllnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSRh34/l; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSRh34/l"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38de18126e7so51554081fa.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776159062; x=1776763862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6KmFQ5DD/wIKsr9qgRDL3vC75y03HZ0DpNlcZqmlE0=;
        b=bSRh34/l0qAHhmvkDeUliqsi3EG+bclbKaRd9D0tl0URitgIIKIEVTypKxS9+b6430
         OaT0HiCJWScKzlqHt0o5c+f2o7eMxZrFfcvxbTgxHEpnJScOvgHetxXMBrqhu5Ov4ovS
         x1p793v+bJJSkt37d55I9CXNdVFM3aSw1+JdPUZwMnY4D6KwKdEM0NMe6r0chzSt4RlG
         A7PeloMVSpqMODYe07CCjjMDgu4F3ovtvcyvIaXrpBi1kwJe3+Y/tmEz2uilg+7xcDM+
         a6aQ1EmQ6BsdYsX3EVQW0diOhf1YKlJrQXtStbUCxQXe9MlTQrezERhqt9T+9TvpfJ+q
         EtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159062; x=1776763862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6KmFQ5DD/wIKsr9qgRDL3vC75y03HZ0DpNlcZqmlE0=;
        b=Ziyf1saD0/uJlWe5e3001qf/XoqiSrv0Qs/6fQMvcasb76J8WMTCvSgHewebHChJOQ
         e2QkECFuyzwGbTvCoGq1pEXRiL9HXoGAuFOEQatZI3fXyYd+YhdTvQ2pVEBwKBlM2Siw
         +/yfLdKZtyeruv8Y8C8EsFK8PO0PXMC2rP4gfvzXAYs9UiJ3zkRX0gfi7FmUI58fFDEM
         i+vto0ikoP3lq6Dj0NytqWN/4NunxYdc1R3KHHvaV+/fTTWWUVp8sp0AXdupOdYNC7FI
         LlrfvzWl9DjeTWNT2zWaG8zgyb5kHkxOLHM7lebxqYztGerzA8plCLs4uepHZKWBiE7u
         9iQw==
X-Forwarded-Encrypted: i=1; AFNElJ8KelPFduo8SqGiPV9TDYpALTOtOb9OFabRM6jyRud1DJKUea74CHf9tyukqe/A3RDltSZO0jJEyZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DSRg4k1BgaBS9AUOgLJ0hoObCphnK1+dxOYFO+/coIhFuzII
	KiGSBQ+/RL3ZkR2FT4HuN5uZYppyN7AAzyK+CqY3p/zW4DF+mLWOtjKzkpFKs+BG
X-Gm-Gg: AeBDieuba74EVb9m+9ud/Aj7EblHD2OoaepUa+b4ekSh/wELh4TBJtFMpFIe1G0mKYM
	co92KLwzqMq5WzEV4aaTvxe1R+tO2d3jJxKKcdMsdbh8K5D0GTg+adRk5WFXr7lgs/Blqi9b9gd
	DkTJxBlAbK3AfqzFV3qHFYFCC/BK2nI7QS+/T0PPD5KvP3YAgG08VxO4+K6IIkPsBKdaEKf6lL0
	SUOD7CWkhMxtc2xbhm8ZncpRvR4W7D2jS0cvz+9/qoI6X35KegBLAdejcvagqQt26LmmHr83XHF
	o4YFMN+QLL5GLZ1laDljOCAr3vtomhV6zyBG/0aiAscQ153JbNkF3dOmjBnQ6XkJLJuIWNFam81
	/5kuheRHiRjufjHR3zAk59+AzTstd8r/CjpFxSaDGkXHWArXivrfDOgoGYAGWwXcuPQK3fefJW9
	quDRwJJuwf3LiePqXssDZStbYG6UdWAqWaI6nQx0heAraIWijzCw8rD0cE3VmzvGP8+fIh4PYz4
	C5RV62X4Keca4/u2eCbR8FOAM5Lj8lCj0NLTr/4A5aCNxAC4d/xfId45qJshs6KgVa9UV9/miFy
X-Received: by 2002:a05:651c:4185:b0:38a:4dd9:23f5 with SMTP id 38308e7fff4ca-38e4bf41e5amr34175321fa.22.1776159061284;
        Tue, 14 Apr 2026 02:31:01 -0700 (PDT)
Received: from ?IPV6:2001:14ba:6e:3100:fa75:bb3f:af4f:b222? (2001-14ba-6e-3100-fa75-bb3f-af4f-b222.rev.dnainternet.fi. [2001:14ba:6e:3100:fa75:bb3f:af4f:b222])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e49a4a6f9sm27242431fa.31.2026.04.14.02.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:31:00 -0700 (PDT)
Message-ID: <461bc8a7-b2e8-469d-8988-2f080e23a624@gmail.com>
Date: Tue, 14 Apr 2026 12:30:59 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: hid-sensors: Use software trigger
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, bigeasy@linutronix.de, spasswolf@web.de,
 linux-kernel@vger.kernel.org
References: <20260220224514.471348-1-srinivas.pandruvada@linux.intel.com>
 <7ef87de7-9731-46fb-9608-34c07fcf03cd@gmail.com>
 <20260412143840.349400ca@jic23-huawei>
Content-Language: en-US
From: =?UTF-8?B?SGFubmUtTG90dGEgTcOkZW5ww6TDpA==?= <hannelotta@gmail.com>
In-Reply-To: <20260412143840.349400ca@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/12/26 4:38 PM, Jonathan Cameron wrote:
> The patch was merged a while ago and in the discussions in the related
> threads we decide it was too invasive to handle as a fix for what is a
> warning print, not a failure.
> 
> The closes tag without a fixes would trigger various bot warnings.
> It could have been there as a Link however.
> 
> Also, the small temporal issue of the fix predating the bugzilla
> entry made it trickier!  I could have added it when merging but
> we didn't have confirmation that the two were definitely the same
> issue at that time and I chose not to connect up the dots.
> 
> Your reply may well help anyone looking to find the issue though
> so thanks for that.
> 
> Jonathan
> 
> 

Thanks for replying. The warning doesn't appear in kernel v7.0.0-rc-7.

Good to know about the Closes / Fixes tags.

Best Regards,

Hanne-Lotta Mäenpää
