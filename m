Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DE34A3C4
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772905813; cv=none; b=dargUpD2ismvbY5n221QTYDok9uVDi+40UPDE5Btys30+c0Hn27WNRlQ/ORmkIOkehUqiY6EGqSLTr7A/XHwyJd0ZJql/8OCBknbhnRYQ4JJfl4xfY4UOjSLUFAnA2ji9Ejl+V/gP2EM5mSubgWRNpFlOTYOZNamQWvZqzOTeL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772905813; c=relaxed/simple;
	bh=OM35lNL8y4dTOttjAl+zrKtVY+w0bPN8rPegJ3JLMd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGQS5cwfzxyda+Ww6QN8Kut8IAzeNzVsigepuonAx4M2/+zdgUsLxxva6V/k1PZdwbuDSg3YHnNwggKdgD4+XgCWkJfktvqugL6iI8qsMfIZ2KCHPLvH9GFSAtXLZq+E7kSfmEOOyIgrarabxgiSHvHoqxR8al0714sf23+vjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ma6B7tsh; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ma6B7tsh"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d55b97f358so7745818a34.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772905811; x=1773510611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wN2wDKo538EzzNi+QhSobeJKRBkoN6TcqCNOv+Ri41Q=;
        b=Ma6B7tshuF54EZbJ25CGfJFu5uQIBi9DvpukBU7sE4gwUGTzUNGp8zvH6mowoT6tdd
         kug8pbQqbHoNTkCeg0RSUZOo9umlJoAmLMfD+WKPjrnF209i2vu9rcCzS2/IwN5N8/BH
         gPOffvF/5m/bJdZvEslk4DGhx33IW43DYx63eMW3jFp7Xueh0I1M2G4MEtZxmMPzMXwa
         BewzejVMY0eWS0fy86BUmZQP1c4JUwHswi1sUjYJ541dh1fBgPdJBfiJaLD+TQXXZhbd
         +GgvqFrnT1jm7ZHXZqtT7KGD2izWJXdSQI0I6JhfJVntvzwcE6BOzct7xJ416pYgARjZ
         T5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772905811; x=1773510611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wN2wDKo538EzzNi+QhSobeJKRBkoN6TcqCNOv+Ri41Q=;
        b=E9A82E0NTNAiL4eg6nRzgfYds2rm5JjREhDNrmWdRjBo5+/otap9wVlTgNkbmGfgm2
         e7ILssq74xmQQMehCGks7Qy/6z9iIcp3jvCdZSwSdHwBbEWkqokTU8bMaIHOX3W3qaor
         bySBg8vwLmCr/kQNO8LieSNyIhAaGcyMewbMyG8QG7oZ1Y1hJhN5xxiWMOQveAVppGlO
         fOLsmTbH44P4JkQC1C5xXmdHDCJiTRMeIbDynfcu+Yr7yRnwm6+/Y7LAug0+t401Xqmt
         b8Y0KTqe1eDM0HMYGQYd7fEUTo5lhUFh1n4/LU+PBO2xH3izmxYXolEVrEpwp5uA8wIO
         tH0w==
X-Forwarded-Encrypted: i=1; AJvYcCWzrK6mHnqhIg+tHiXTncdv6IkkwplWeJhOmF1PDKJDoUT6kYfmvasu5Ux0ZBvpTKolB6IHhJRCfDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPbZ1aMOateFCV2dvqjmXKWd0CkcvYitEgSEzSNjXuw3TLegq
	+g7Ra3My/QwbYmLZn15gfsqQdbeL7ubAVkpjxXCh5pPaCZlCxLIJ2FUAIzYPpREaBaw=
X-Gm-Gg: ATEYQzxKViN2IeGO6kvHo79T9vDyHGRKkQDQ8mZxyegbVku8i9VUJtCvLZn+uI8Lsgu
	CHQF/SeFsNE034odWsaFxaZ7FY39XNod2hIh5RcO3e3ArcRbvoGnoPbcCXR3+RcA2p3KszXLCX8
	TidnXRaD0rcZvSt7gTJ8DumDU7E3/EeSE2h50niJFuQfSXQdROZFReqXJjrZfFQ+ZUu1jeDS4N7
	+rqn6UOSoCo6tbdaud1S8yfIBWIvqN/bK3zQvQ/mbNX2GN0ta4cGaEn8rb7mRoVs61wKBlDBMYX
	1/I1tr3Jv5GThE4CGK327oAGe5a2QnEJRIqD4FMgoH1XaGicDm0IjE752sqVxJ25UkThV33jwjy
	+rIqwcF5TZEQuF/5nQTlnAs+4hT9Ur3QPSjKPrhDoyNNoAvEOxJwbSfHyDc5bKToMX9EeWO+1lx
	Me18OjEaiOuln/VR96od9ICLQXzAMDXtKkf1Lzxz8h4ukjeCZU3zIt5lO3e17QdiItb2X9CP+ll
	5iRCpiqnCLT
X-Received: by 2002:a05:6830:6887:b0:7c7:6043:dd8f with SMTP id 46e09a7af769-7d726f631bdmr4097301a34.15.1772905810883;
        Sat, 07 Mar 2026 09:50:10 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7423ff0c0sm171636a34.27.2026.03.07.09.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 09:50:10 -0800 (PST)
Message-ID: <ebee83e2-888a-4338-ab5c-5c75caf57318@baylibre.com>
Date: Sat, 7 Mar 2026 11:50:09 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] iio: adc: ti-ads7950: complete conversion to using
 managed resources
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-6-a23fdd1a079e@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-6-a23fdd1a079e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 1:21 PM, Dmitry Torokhov wrote:
> All resources that the driver needs have managed API now. Switch to
> using them to make code clearer and drop ti_ads7950_remove().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

...

> @@ -577,26 +575,22 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	else
>  		st->vref_mv = ret / 1000;
>  
> -	mutex_init(&st->slock);

With this accidental removal fixed:

Reviewed-by: David Lechner <dlechner@baylibre.com>

