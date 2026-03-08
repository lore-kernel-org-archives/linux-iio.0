Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A84C81
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772991204; cv=none; b=dVPKj6yp51EIJyV9eNwKni27T+HohqfEfysNq2/FBrtKHSGdEzNpLNK5QJvIgDDBu6NgUKkKp3JCtJyBJWkwCkUy4jgisnpueLlrwILVV6KGI3HuxVbkWzgw9qgVuBBoASmi0wilDWs8YswszXdOMEosg3MXNoUnbRBugG4BhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772991204; c=relaxed/simple;
	bh=mUMp90urU2smYO/9qSB4myeg8wLSBmUovYNVfjwBMU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBLyfELEdV+utKb6Hhy77VGnHmx7dNAqT0appyu3mtzwCqW++QjxBLFiMm47x6EZq+7tt6Gr/IXQPh/6srfczQmdVOER+hLJuT+ykTANxFyErBrKFtafPWGk2m4yySjJA7QV8rrc/9WpMCCLG85aFOZF9hAxmfcwmEytp6F1v+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yqkAQXht; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yqkAQXht"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d55b97f358so8079023a34.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772991201; x=1773596001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUMp90urU2smYO/9qSB4myeg8wLSBmUovYNVfjwBMU4=;
        b=yqkAQXhtcFcjW/bg9YEPSMWcPHYjN9L2pW0lxgUa6rG5zXqVd6R+IcHblzWSHgKqRe
         qojNfM+ff8grWQovOAfvKy2P7qGq6QMHm83qjulDy6Pjgc4JsdiEgLNejmMqmg11bTF9
         nMVIUd0qshHBCy6tn9qI0SbhBs+wVM1Yh+bOtSUsygwOhNLIkttVTmGpAjJvn1j8G0zP
         uVwXZwBxoYvzgpjYyg83kavJgF5pQEY0sJwwYOxkBGSU9JechZwafCHymGroMqByn+5B
         fcEsaBo1gJiFQErRskpfq+oNuRUODFYRZgE7oWXdmlsSeY25MWunxEwwem3JrJG7vz4S
         8cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772991201; x=1773596001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUMp90urU2smYO/9qSB4myeg8wLSBmUovYNVfjwBMU4=;
        b=p4BKQxhNfPFwFcax5wxuHBcIGESN/mVCaMi6ayiHg3W/tslTa821vR8jcKPnSBTA5a
         mpoW8mdy6SH1kCmQgQOD6s9gftqecaEJNvp4q+gqSoYVv+OLQzszgv6TMtSrtaeTNq5x
         5xsvzxacL2DbWZe5rqjrzL1FGOcw151TTv9fGOyQaMr3G05N/pIfQJWuwDvV2s2yta9V
         N5T9luckVsIXIMTdadj9SswqmUB/MEWbCKTzbx1JwhqEqtmFbr8d9jeLY+zLOZFzz+z/
         d8JJMOvSRkqsizTLAMax7bXGprALY8dl4mPxLytCx/XmdrVJ82UqqsfXT5qTrqbrir6e
         CcYg==
X-Gm-Message-State: AOJu0YxyB7zHusErPrHk8LKBkucPpSfANG7V6efjKtcWgXoFjiNGnyww
	uStvyiHQWifmEgJAUOWdL36e6+gGW9DrjCbTnEDJ7e5laO2Bl9X3aFx/WJGAnoo+dM8=
X-Gm-Gg: ATEYQzzyES1QVrnK8OjNgd6ZVWSycAieLDQTcNA9U6rXLUYMfXHSKrFd3RkVWemE+Rk
	SYVH33OHvGPLm6DFaCxcfMMBKvPBAJTUc95BRW0KVtuP2eeGHg//CpThGb74UqPGJUWMhibBARY
	9wyFmYLJg/Si7qrOx1BjXzVgFoPb4RqGomjEl/pSMJNBb3G5bTS7rILeKpetUC5ERqiu3KZf8yH
	MnMRr/Cu7GKqMZoxvqc6qWjCekXgIylm956DX2iFEXyd3Nz4Ky/F5GNXz10ecSErsZ3x3SNqt73
	UaaFbQTYu+y7p4NW72EYwGWFHczkQcCAcuIHX0vyi9nTwtmhSFe/6WsulcR2Z4xl3KUiPxs4tag
	YQoltBYKLR2QSjirdkit3qMuwnUbSzAuWLtBuZV0sBaqqXKA24yf+sCz3SSE2izTo5iS8owmD32
	2Yv+R50iBw1eS4j4WU61emfWfn3wcWuE3Z2dbKS236Gph+NVnVxJMPc0FuDc64J43QSHpd/hkXW
	g==
X-Received: by 2002:a05:6830:d04:b0:7cf:d168:2107 with SMTP id 46e09a7af769-7d727081459mr5346472a34.36.1772991201453;
        Sun, 08 Mar 2026 10:33:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a7b4:e550:6d81:e067? ([2600:8803:e7e4:500:a7b4:e550:6d81:e067])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d74062da77sm2129323a34.18.2026.03.08.10.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 10:33:20 -0700 (PDT)
Message-ID: <f789045c-4c6f-4201-bd26-5bda587b5384@baylibre.com>
Date: Sun, 8 Mar 2026 12:33:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Sirat <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260303090253.42076-1-email@sirat.me>
 <20260303090253.42076-3-email@sirat.me>
 <3181de17-d3f6-479e-9500-f5d552bb4151@baylibre.com>
 <CANn+LW+uLQuoRbN4UMq1-pVcsJqzc0sMQNGwfwuSrTR-pNdLog@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CANn+LW+uLQuoRbN4UMq1-pVcsJqzc0sMQNGwfwuSrTR-pNdLog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/8/26 6:04 AM, Sirat wrote:
> On Sat, Mar 7, 2026 at 11:17 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 3/3/26 3:02 AM, Siratul Islam wrote:
>>> Add support for the STMicroelectronics VL53L1X Time-of-Flight
>>> ranging sensor with I2C interface.
>>>
>>
>> ...
>>
> Hi, Thank you for reviewing the patch! Please find my responses below.
>>
To save everyone's time, you should not bother to respond to comments that
you agree with. We will be able to see in the changelog what you did.

It's not meant to be rude, we just get way too many emails every day.

