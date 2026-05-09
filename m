Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612235C197
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778365274; cv=none; b=ObitgXfWNTKS2FYSiV7bDnwnzPmCJWiq9UL51M1OvZ+DWFZ71ZxpvbHgh0mpG6ZsS4RRP8TuYqCx1e7JprL9H+sZPkdS2A0VYlsAisUz6iTlTCUfViJAtHjkHy0L4DSX+hUtWISIxHRNOYd7AD0IeURZMS5E/MbsskcvwM01CSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778365274; c=relaxed/simple;
	bh=V3PnkRNkI9BUmkfd37NWASsHb2UoFlKqUAxni6iD868=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMQGOlaDgKOqHah5NVBpLb3bTiqu09O1pZUJ7hSK784kC5vlNDqtb2PrBtYpbqWPn4VAL8sjnSAk+8nGMhWqwAKBcvikxRXJxkH9T1JI130KZI4yOo3r7ul1zpDGUzFV7i223hIrgl0/31aa2TGoZQrVBp5AkprbnEgSDMilWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=CbEo5nh9; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="CbEo5nh9"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbe437b072so1687984a34.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778365271; x=1778970071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAJdZFhhyoVEmBVhRoifLB48NRsX03oJG1Z1uzT0ZtU=;
        b=CbEo5nh9rqNOmrG95Y9NAXLf8ByYYlYQfiZaPZmN52Q7e5IeAJlWDJAdWXT9+WLQvI
         tkyzVqNHRW/TM+FvIfqqw2wy8CktDtsvdsIP1p6AqTd+cwUh9VWQNcZCBX/NMKupIFTY
         VeBqvFOMXv1+XcjB2eIZVZ7dhnBp8ZLROwfp2DvVH28PdopCRgtFP9BdgXTT5TaKwr9F
         fveeHL+8qga8yFIYEDtgpkN2rAAPS3rNAKPLg+qoGVCWBGlHhypsZA3Maxrh2BtvDF5S
         unngNQ03iKCpruvYyOPrIObDopQJyjICfcMAwheGMoRVLvf7GS1EwdySHlgAhqy+BeDQ
         j/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778365271; x=1778970071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAJdZFhhyoVEmBVhRoifLB48NRsX03oJG1Z1uzT0ZtU=;
        b=VUp3tA2vkKW3s55mbOYqwCCvF0BYOKMAKwUtYGrLPogQ51V2qfjTz6W+CvqnV+Oyfw
         LHGk4bqu0admeIjatevl7d38VynvKwnQF78dU2LTUPRDoKp+bCtPilnss4hPx1oMVEGC
         A2wsM3vkgcn/5kH4O0N9knAJxDoIS9We7tSSIkh0UrET7bGNaoyyWFU9ja/5jTWL7stJ
         moff4uf46lp5ZzIFp0kkc57xE7MXLEuaPT6IoGp+Hg44OB/2Mhe4Y5sQGX7RfykcBeUF
         JEFo9vdOrA/cuk+sqperxXlMlU3pg9uu9Vh5WiVqm2A7/eLhlB/dG1a7WQrRHMYcbYiD
         +djQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Af1aCCOwy/rJdtZQ0Y3SElTaZW6YIXBmMvXT3CNKXIpzpjSyqwY3swp7ER6/N5AyHf+vGyjS1J7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eVVPb8Lntiupcrp4bmMUxSkxivxAvzXzAvjTu7Vo9NO4AAwm
	Yra5qa+jg54OEW52rcGdXonF/4KkRcbbtxgoF2INXZWpKPvvVkc7QA4Bdq7MOBahwNG/8x2NQSb
	dEJiE
X-Gm-Gg: Acq92OF5tu6OjKH9pigcrbLC/KbmG/qxNu0y5To0G+WToYtL/JmNanBZ1dbK47etNQ5
	UKwVYmrH5JSbOVztRjPX3NFjjWZfAUAzyoFH9pXWYgnmlmqhnIWLf9v7hs5/pU0xQTQGZs5mpa1
	5B9lAPr+OnnhEiNT0AvOwIR4m2Dm7u2pxk1sMW9EEwffy0TrLynE2FdSzcbDq8gDYsYf+7ZurT6
	xn1TBXN1H5jwbqoq1BWOfuZ0L0a93xdbGTNdT+lQq59wKQ/EaMB/3Lu7DY7FnoB9rxxNCpt5bBa
	fPppn1HCMN6e3E4P0Yd2uIRw4BfUXhGw6xbb8VDGVQb2KzsZ+0eELLpZvWeEFiLRB0v+pnsdX+H
	VG1x6UZIcn2eRPsIvCmq0fYk8WG/7hIKPPuaK4e0L38RhBwZPVb+e3ZrdGWUVDxjCyHCeAUmSjZ
	Gv5mvj5FSTOdKx8BMNzWohmAEcGWWFlrSAOwc+2lK4r1WFXN/9SEpVqAfU2IomGJWm2UEQpfzwP
	QwbbLNPTQ==
X-Received: by 2002:a05:6830:3905:b0:7dc:cd0b:58b0 with SMTP id 46e09a7af769-7e1ded2b16fmr11431496a34.3.1778365271231;
        Sat, 09 May 2026 15:21:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:12a0:9178:ab4:39cc? ([2600:8803:e7e4:500:12a0:9178:ab4:39cc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d9d788sm3674656a34.24.2026.05.09.15.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 15:21:10 -0700 (PDT)
Message-ID: <5afc2ee5-7b2d-420d-911e-7019b7f8b2c5@baylibre.com>
Date: Sat, 9 May 2026 17:21:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] dt-bindings: iio: adc: add AD7816/AD7817/AD7818
 binding
To: Hungyu Lin <dennylin0707@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260509022718.82957-1-dennylin0707@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509022718.82957-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 9:27 PM, Hungyu Lin wrote:
> Changes in v3:
> - Fix commit message based on input from Sanjay Chitroda
> 
> Changes in v2:
> - Fix commit message to match binding requirements
> 
> Hungyu Lin (1):
>   dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding
> 
>  .../bindings/iio/adc/adi,ad7816.yaml          | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> 

Don't need a cover letter for a single patch. Just put
this after --- in the commit message of the patch.
