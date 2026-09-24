Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D94854ED
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262816; cv=none; b=DalVIwKWKFLOowi65cLHnKAFyuJPt3ujyAEoq9Y9tTm3m8UiYrAY9ViY6hfXhMogqTX7cQHsW9uK8kdwurH5f5I95XPBIQmOfhqPnnyvdETNyrllWzb0AUyRVWLpVZ3BxmHJn1fFE9Y1pvuL1DhPyuoIBqqDWM7EuoUuuqI0ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262816; c=relaxed/simple;
	bh=vBZNIMcrFusc7oIU7IAyIFJoDxVBsHLcKvTckgQuMm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsBlExzh8PKLwNuehU4HeiIFQvPP+R90v7x486wLCgJubcPXBhwm+6wqXO3JQ0mnbGWug1MnZiS125JjMCTS7zC+Np+S3oDQ1RFNzIzNW19kDFatZLEkmzCOJMXDWHoSG16kt5ehXQE9KLUACz8pEydNeg+YP6YzxkcxorS6ues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI9alQAy; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI9alQAy"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so7762825e9.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790262813; x=1790867613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DCS5WVHgbfqAUCE9Nm3HZBU7EdbFt5hV09Y99Fzxq1o=;
        b=AI9alQAyK+kqAKyuzWl2XYuEyR48+koGm5fiERRqM3/jIdzNDB2cHrM2WWQAkBpu+J
         BJ8JQQ/ReiBYAk+dnr2mcLG+2iMryyDrYzNXG+ep6EAUwyWsndDHRJHmU9kjsiLDZdOV
         KfoUwK5pAeKl2UtmRIOCDbdivc+WYGJC2e4i4lwW20w4bo82T5qhI62C064Q7hkFc/NW
         lQoxtwmBcejF4G2WUts+AHouAglI9YzC/Ws5KM9AFSepO6qFel9lhgjMVGMSKyPja6hG
         KNmv8ntq8Cfkyi0cpR6cksp9zbJDyjAlF69sn543Zu0dmBsmx78rNALpe1kfoCV48A6o
         x+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262813; x=1790867613;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCS5WVHgbfqAUCE9Nm3HZBU7EdbFt5hV09Y99Fzxq1o=;
        b=ChUBGHlHjKxfCMKog3WoRYYo/J3OzNvreJZfYPf9ei1k7uBU4l5SBnY8R3hq/EoM8p
         9kpYq0MlApQt7glKHQxfAtqwmiVV5yCDewgKkSNFNtl9bICrV/E1ILzJ6M5xHWt49MKY
         HTStSgjQ6ck9VMRC7w7uZaURgiKGZ9bVLHHkKhba/Ws1R4ssoQ6UE9tn1Ma+WrZ8LXp4
         82N0FG5yVR7rFgvYgMsL8BL/0a4Sw1fE7X8F7oShDvaqF0iCdT1Z6fWC9mSd0AYDFTY1
         bbbsjd/mfTDPxDLFTfUNYYFaRwUyhIvECq1H5Yy6C/7zlA6e9mJ0OH63KEpSV+LWfncA
         SkdQ==
X-Forwarded-Encrypted: i=1; AKwUvByNiBne9kCcBIPKaks8CxzM9MNWHARCFBjRNRJd0oriEJowXYKmZdnGmyqaTeOXVDT9hMUpjaeH1BI=@vger.kernel.org
X-Gm-Message-State: AFuF++neouyHS36+VIEE7x762MlpEyLLok6DNfwXGkU1u1Ath1K1bEvF
	Mg11hbsAb+TEGh5CgZ7z+JLAx28HPaKsdJ7jcUPUCjEau+aUIkzsxOfA
X-Gm-Gg: AYBFou1Izu5U+iDGWJvzZsyy3uMfIIDIgXKwfkFN0Y8obGFKaUVMuE8O8+K6rnzb3UB
	pqFrmipD6psvFrxiTyEYg5pQpUgSI8DWelldQBIh6O9JYIOK1NzeOiwUatROtbp8eiTXS9HCt0+
	ww7r5SGx+nB0EcSFJXNIjVOlbRzY+sB/Uc51cptUyDk0rSMGblwpJ6xQ3dgrzpAp1FjX52cHn9Y
	LyrBMyRafRAz+QiX4Qu26lF0/q0B8WyHnZ3t74ilO1S8AmFqtMr92SMxDim9oO9FKpXH2hQNwPV
	GCoXQPlbcy104eDdR17hlz7V9THgPPyN4pNA9wvlt1JoezN1wD5R8igYPue92grvD5TUSF/w+Y2
	zNgLHAVJwxtm4kFUyNqx2SahEbw8XQFjiC9PhPTZF8N2kHNa81v38L9Q2JvZZsOS7XEMMDhVMYA
	bfzeiF/5DqeW83Xwlk1oD5zbbp5rQw70OZ/g0J3UNnE53HMhS/rpLXQnrbZOw/qQuutQfvlm0y4
	LNWnDX2bpO1XdetbeMBPSxzfjophZjeVV3fMAIVknYdpazsWlDghtKVa0CcKr3a2Y8flOHlQ7VA
	Jd6IfvbPRy/pBd5oAttWIvLfmt5cxGeTFOOcNiwVMK96cpjclFS6kI4BwkKdzNU1ZJVcfCuVjdW
	Wrr3qknBuPV4JwO6i3De+qrXtnIZwHhLzMgVgv0ChSJ2Hrxf59RCl1XBbqehJ8g85y0s/1hLag/
	IJSsle
X-Received: by 2002:a05:600c:4e53:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49fe66c8288mr48456315e9.4.1790262812943;
        Thu, 24 Sep 2026 08:13:32 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de187asm72623085e9.7.2026.09.24.08.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:13:32 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:13:32 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20260924171332.00001f82@gmail.com>
In-Reply-To: <20260924-topic-sm8x50-iio-max34417-adc-v2-2-9a0609e72f5c@linaro.org>
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
	<20260924-topic-sm8x50-iio-max34417-adc-v2-2-9a0609e72f5c@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 15:14:16 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage and accumulated average power over an
> I2C/SMBUS serial interface.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Unfortunately you were too fast and there was another reply on v1 :(

-- 
Kind regards,
Joshua Crofts
