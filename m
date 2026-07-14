Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C225367F48
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028958; cv=none; b=bHkowqZUz1Q2v5phBFE1YGqFgxwq1Qwp6BKJkC1/KO2JjjjasIKhV4fyqQXtMWlwRD99hVPla9dHmyy65+N6q6xBXGtPkUmspovs+/EuSEnf6bQgPd8thctXRky8UNzUOpL/DNU3VyRLyP4tRb76qadYrgbEg2EueJiB3FlLAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028958; c=relaxed/simple;
	bh=EKNSfL6K7twYkb1f/nM59iEaEppV2KkoUdglhRK+kIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkWSHqXFxnmpljdMbv7yZKVDuPmwqJ9r5GnRpNDnxtjE9SftrGRB2ncnQXwa49zWlyv0wR5lbI+s0px3860J3kTH4do+yiC03xb505F9gTFBabvAVQdX1ixBon7q7koKs4rikC15/6o+jyn5Bt0cKoFgvMx+y5fpti6cZnDkHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6ZE55iz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6ZE55iz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc97653887so47533795ad.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028957; x=1784633757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKNSfL6K7twYkb1f/nM59iEaEppV2KkoUdglhRK+kIY=;
        b=Q6ZE55izrPy2MQT3MQRw2P0PvQCyDMDExBZyj+RR0pT8eTQ/TazsfWPh93/YtjGFup
         bX0ECywG/GVwhD0eOX0GH6wNWQetTgsGR4QEcA+s63u0NKFclhJY3OoJYxXxgbGwK29Y
         1o/GwqSjJTYCLNrAc09vfoEz103EQCTdmOc+LwwSpeg7OEMgEY33Y/JbRmXHcXXaEGOC
         suKVVcRP1eFxniqAxLGHPp8V30a8FA7XjlhmIXvB0CiratT7FpTtiLsjqHzNl+yNlO2J
         +lae9aXXpNZGfGuxppDPq4uw2FiK7fRIXdNAAbokCgDapA6E2x75Jcsuru2ohd/GVUGE
         nU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028957; x=1784633757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EKNSfL6K7twYkb1f/nM59iEaEppV2KkoUdglhRK+kIY=;
        b=FZzn1EjdL3fBTAtEUSf0jWh8jHzmgKoJGWJwACRECqNFxmhU1D29pBBrW1RcWNjnk5
         MY4qP6XwPJ01OL8M9bcgcR5+GpUNIBAAvCowuy78TfFBtu8pEvDNLHn7V5fpLCZcjOBv
         5wfbE8bO1awdye+kJPb38c++wAMpxHzc4HyqF4vOeeWh+C/jCD8PcfR0VIYDU0rqfXcY
         V/GcUh7i3XLWIEIAx3xLZsmTtZ56UsglTx5KXFgs/AhzfA/8MPXVr1ftt/Y4tnvKHaBa
         p57wpWdz2OB+viycPNFJepqFLpgUc8heuYwBYJ0J+bZMVKx2S1d4mdcIkwpR/P1lWXxt
         a9Rg==
X-Forwarded-Encrypted: i=1; AHgh+RpiCM8o12byuCDFBLqbEUxACPLK41RBlF9u/TJ3WF2uNcE1Xdg/nTq4BRD6enhRbcelr1hmxRDb6nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vnYIbZmurIk797P4g43hNHrFmzX1s+4GqMPE/vxesGjbyPDw
	qDkUwiWKLyCCFHpoZf5R5kYkJAZGMJSgze2sVwmcGqlFQPEQo63qRbg=
X-Gm-Gg: AfdE7cmfmWEjF3boMRKzTAiY56j87cRvhLdfhNldU1hggcQbKv+oujYezB6cFKq57Lt
	SsC85XvpSXUQWa3BYnINC3mCdfShWoAzPz97SlLjNSJl0h4UGzWVxY3w/ObNHGx+ab1rUulxPKY
	6oSJaIer1N30qIoD1gnoEkLcuLxv1q4NbwqiGp0aRE66BuQ6tpq94CbVCdkHzA4IspMDHlv6/sy
	EwfswaXIF7RHKt8Jxyz82YGDx1PF8LNj/eiZZ7eNPKtCw09NP0jyzLVD6dWySAs8rlKsP5+3XsM
	9ExE+ppghmUI1+EidTf1uSoaJXT92ORyIazpPn/IzeAc17tg3tgxXtFDmBV14PDVmJHhCVmaaGP
	z2IXg9/0VkKnSzg6zaof/8N3g2UeJ4/+fSlXIOJy3Fcg87fmbUGQ2PZjkuI3LGTfGZzS+LES554
	YS0i1pVLMriTBPCqYrNdOY/3zOJXYpIMnKUcYHPyVhVpEHiLuL+maG/bG60A==
X-Received: by 2002:a17:903:19ec:b0:2be:3850:297e with SMTP id d9443c01a7336-2ce9f052d20mr125833275ad.31.1784028956863;
        Tue, 14 Jul 2026 04:35:56 -0700 (PDT)
Received: from [192.168.1.45] ([101.0.63.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bde9sm115071665ad.79.2026.07.14.04.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 04:35:54 -0700 (PDT)
Message-ID: <dbf0ea30-0fec-4c0a-a9d8-bb782b642121@gmail.com>
Date: Tue, 14 Jul 2026 17:05:51 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] iio: light: opt4001: Fix reversed GENMASK()
 arguments in fault count mask
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260713035736.11346-1-nikhilgtr@gmail.com>
 <20260713035736.11346-2-nikhilgtr@gmail.com>
 <alUNIpZWdSV1Q3tk@ashevche-desk.local>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <alUNIpZWdSV1Q3tk@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13-07-2026 09:36 pm, Andy Shevchenko wrote:
> On Mon, Jul 13, 2026 at 09:27:33AM +0530, Nikhil Gautam wrote:
>> GENMASK(h, l) requires h >= l, but OPT4001_CTRL_FAULT_COUNT is defined
>> as GENMASK(0, 1). The define is currently unused so there is no
>> functional impact, but fix it before anyone builds on it, and add the
>> _MASK suffix for consistency with the neighbouring definitions.
> Cam you check my comments on previous version? This one seems has the same
> issues.
Yes, updated v3 by replacing tabs by spaces

Thanks,
Nikhil
