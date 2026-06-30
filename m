Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE34028E6
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824882; cv=none; b=iEepSrFRtPZpwRD/LpnoKBLkxDBkcOTHHMpUYSHgUCHRAJ/7XbyqyiXjxJ3qHR9FSoSV7cZWv/phLj1qh4szULK55CcvaFBvUJgxFwb5xUZ9OfPOQNcJXrLDNOL1RFeR7OWxbacuPJy2ODFEtf6LF0xSZ2jw+ncbATSqp3XXfuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824882; c=relaxed/simple;
	bh=4wOd2k152jTIOetiUg0ErEuJIr/fWu9qeCXQaQH6IxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crLzgpRD6qqAfNRCMP8QduYW6P32kKWpvM9pO1e3YW5U7kVaskvFOpAc2CWOgEW2MsdUPSt9H3n88HhkJ0jUlQK2NQEMYJhsq/Yf6uRcq7q/XGyNtv6hBwU1IQBWcEW3s/13OVasGveCam3jJEVfUmt4XQw6esHz9GLju/2QVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+Ysmndn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+Ysmndn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493a54b80a5so36631145e9.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 06:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782824879; x=1783429679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O7k0RIXCnKG2vJKuj87RS0STkl6Fhwg5MbkP32JPXo=;
        b=Y+Ysmndn60r44FoUTTOIfyPhD2N//kUfdRtm891lB654mxY+kRf0rgLWHqEdMh9Gt3
         QJp0RaCKhwEIK0NdCVUHJ/qmMFUzZyy2894OmV5sD76mznT2xXGedrlgE1pBJkt+kDKc
         hUz6HYw/B7gL+PMhaHDVT/P6a23jpqL88tYeZR4WBXuaaCVDazM0K7E1nkzTbWfOTcoT
         e+ODgaXLRE+XCN/S27siegBfNYHti8osKcW4surWWzA4scceS3irH+NsGmabpVFghmTV
         D9Ne1fecetBohi1LEqXoMxeT4LD1gfWjWZf3PsyJiy8KqqSL+hdL22L7b+/dvEpszrNJ
         bYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824879; x=1783429679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+O7k0RIXCnKG2vJKuj87RS0STkl6Fhwg5MbkP32JPXo=;
        b=O33HTtYqe1Uguh6pUUuqLzvLur6Bdol4KVYE9JmKDnwK6AcuJvXl6w4722od8J2u/a
         rm+CaTt8mSXPdYrRTzjGwKSz9t5kXSK47IAqrav0l3NUrbJBr2UO6fT/xsK31PJhnOY4
         ODVQyJYQ4aK/q6w68tTbABQ1A97Z1XDoYQfg/RZpTkbvNq7HPqUI2hSVCcZF4neVPRY1
         +SDHhwJPQ1GSIhunhB+X9FSr53UAZ2SBBbtiDup/4GEv5Pbj1zc+HLSfoTCAg+rpbCcY
         p39ZOZxgGL+ULOTzL41f47aILeP5945bKyjCD29jfyxZGu3uVnKFd4rYO76mwEzbCLo7
         mNPA==
X-Forwarded-Encrypted: i=1; AFNElJ+1GwyJ3ZSiNM0K4lddnjVj9FTzyW10H10Hblgp5BmqgHcioM935rCO8J4HWARDTBlOUENnYoPDI6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vCx5PVuk07DulSDayAt4C6AUNJerfsn1izUA8B2/WeYAhUN0
	EhPSQUBVcxS+A/+jPmRg6MZfCGqh+qHhMQnw5XX9dloIa9pnKXJv33E3
X-Gm-Gg: AfdE7cmRLZmjVi2gnVcE6LelLXIwXdBZuALSJvLPSlssbiNp7Z/ybF93EHX9u7Z8oJu
	mgSDYx+u95Kc8qk21nzExOoXi5LPref3byTGCGbIhdpSh6OngTN5xZ3xjrdycqtWSt++UxeytgY
	rEhvjxyVQHs7DwtmZYjAIa6ikYSh63JUkYaH3RNtmDh9utN7i+5dAgUmYOnreI4JCwFyZyiPKkI
	HHREshJyfCGj3G59i1QPK+Yrp7Ok0Ngg9OCvVuO0g8c8Tv+qvRRDwl65vKFYLDQzwBHcBYz6iDT
	xnPg7kcVPfSjedPPO0w8Oc5+GjpCZNEJdME/qvmjmmw++xL6XUbVFfyG+9s27s7vUA/kSVV1eYP
	yS4hWgR98Od46FTNpDEq9lG8w5xbpDPHLMXbNIOvfBYetGY4xi+Nb5so/dO3LD8kfOlEMTF4gk6
	K8p04jSRXdAlpEIO7qV3IqImHiEH0obUYso6Px8qJvsxBW4kdcRs0KOw3LbyOkH/y9gPIjA6gji
	Ma0r5HeCasb7VHfxftHHw+UlYy2bXr24BXtDN1ocRhXY/DvC32w+iG1md1e92pult0QK26PZwCc
	Yls2MbepKIPd6nxEhtIHlEUJXA0ke5nZO6K8Cifs2wK9KBz1qfkh4/M=
X-Received: by 2002:a05:600c:4e46:b0:493:aaa2:f034 with SMTP id 5b1f17b1804b1-493b82b9302mr50790605e9.26.1782824879199;
        Tue, 30 Jun 2026 06:07:59 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf65sm8381241f8f.21.2026.06.30.06.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:07:58 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:07:55 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, gregkh@linuxfoundation.org,
 skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832/ad9834: use div64_ul
 instead of do_div
Message-ID: <20260630150755.0000266f@gmail.com>
In-Reply-To: <akOwOpTIBFmSvquX@ashevche-desk.local>
References: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
	<20260630093931.00006eca@gmail.com>
	<akOwOpTIBFmSvquX@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 15:02:02 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> Since we are getting more "fixes" in the area, perhaps it's a time to add
> a comment in the code summarizing the mentioned discussion?
> 

Good idea. I'd also mention Coccinelle and its false positive in the comment
since patches trying to fix this always mention it (my attempt included).

-- 
Kind regards

CJD
