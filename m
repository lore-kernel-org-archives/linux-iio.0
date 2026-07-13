Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9392D97B9
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951950; cv=none; b=S6jpwWIH5njCi/pj4HyCYEpH4ajcdzItxya8Z6Rj04gDp95glchpS+nLKBn6w5+Kdn/F17qj9ThyP0aHjpUTPv1qOviOvj7YSwMQtK90FOMGgup+/tYYYDt9tqP0b9e4KGnQuRhZs1uPoItyyhM4ddqtcA8KzmoMZL5v2eZ+WVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951950; c=relaxed/simple;
	bh=2b7fv8aufK/PjWj6/63cjc8IXdamL9WFwe43EH+MRe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTwz7MoiC8tfgGXDpk62tWAX3ETyFjk0tsaWruGMdl/9VQAh3sBeepCLIgmqFzFP3TP4NBuYOrjufBN+u3zuzC+Sp2FRbxfgwCCdigKwV0Df9xCbyu6yCgL0ffg4It9M2kqzxsOXZOoiRre8mzpGBqsfVzO4PcQDjopc4JmqeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WGjWov8M; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WGjWov8M"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44ae264a785so1845646fac.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783951948; x=1784556748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3ffx1ARFvGTVEwrbNuoxCUBdpz3Gg80806XEMXu1NQ=;
        b=WGjWov8MxergdieubyhsFgp+T9AKHKSanbLOPKjmcil7Q3lkOdumUyHenjHuM54hRJ
         iBwmi+YGwq9QJwhRBA3YOWZjN7uq7Kn0i5GCjLGg8bM7rbJEZARmVcFFu7RVB3ZC+fVq
         RtwLpnlxy28JIurwGsmC921uTucKo+ZqmcyBmoxJAZ9tPUyIMsst0tAEtrufEYmv4CWo
         y9t+ouRGd/1pSEph+kFRqOziK+efcjYWBIwOsROyEkfwIc1UzBbqhjRkLs2+BfQJVMCW
         uod9mn5KE76qbnX1pYJ9jWjTmtvwsm8lnY6x5F3eLYXjBhbdIOtqLxnDc3qcPfi9IDpe
         xAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951948; x=1784556748;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3ffx1ARFvGTVEwrbNuoxCUBdpz3Gg80806XEMXu1NQ=;
        b=H/NPAXJVg35QmY9tTUzOtyzW+QeH7wNf0rDR12c/f5mvgw+CZux1XYtr048IECXtNS
         4hGQxSY7+DtotEuYhJEFNyXaMxWGn1x9AMTdh1My+wRtBKcoLoRl0LiDOs1Mi/sxXFDo
         TE5wVEvvazd/FrWL4TTIAuwQNNfBw+v3XrBkaIP/mqEXCKySFW+KIMP2847OEZfnGvBq
         MM3H8em/0MXx/MDjUoXtG2fdN3lT1fXuFgTtgg84qNPAkMDXNHAFQ2ldIW4HKbUd7FUe
         Eo8guxp9bTmjw5jKQ+NlyczZQ9OCglXTJp3CAEaS8SxDpvL5kMuxc6PHfFng3MBCV8ep
         WJWw==
X-Gm-Message-State: AOJu0YwlKk5Ye7s5i6Q/GI6PFY1XhwsaXg5S4uq/LfNwTs0eN6YArLsV
	URrAz1dVJ2WAo4LpjkPwoSuCZpoMesfdLMRkWAZEbx8TlJ4IMgDezbrgznU7LsRbI3Q=
X-Gm-Gg: AfdE7ckN/hwTlc1u7FNlEEyuY3Rmf4Y1eG0IIThpsmNMb3tJxsVVAaxHMKzdgllW5Dm
	M6piH4Y5Z/NWAESbhOjidGILAy4ke0hokuxl7XxlrjGnYB9v3FsVL7Ejf1jPSzJZS7Wmt1BjzsQ
	GQ2UJ3h6GTGLrBrxdj358eX/21oIOXKXYAs8TR3Fo9rj/dDY3hAQFKX1pk+IG726KzwFw4i5Iif
	Elu73RbR1O7RjJsxSTm4aF6cP5IPldV0d58bcKGa1rC8JkQkrK1kcIZNZxELrb6eMdiv3tU3+uH
	4WufMNYJYODHhgGxaMVDGSiJUhbbFW3ipstW4JIqTo4U7yb5Tm/pQbilyVEydwdBjkswQta8eiS
	nXHO/wkO67dI7EoM+6WKIvB1m6D4bjrJ33zXj18EvjLjRpbSxIkh0EbWbx3PTBwvvwHeeNb8+3T
	UUwoDUEefcGrBEwpdfJkZEFyJDS/t1TyCy55ueYa+3YwXG6A0EcmjSkI8gd1kOWas=
X-Received: by 2002:a05:6808:23c9:b0:495:f104:d898 with SMTP id 5614622812f47-4a42af2764fmr6846857b6e.32.1783951947703;
        Mon, 13 Jul 2026 07:12:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:610b:e45c:5e0c:e14b? ([2600:8803:e7e4:500:610b:e45c:5e0c:e14b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm12046117b6e.2.2026.07.13.07.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 07:12:27 -0700 (PDT)
Message-ID: <587c6cb2-0f43-471d-9711-5be91600b603@baylibre.com>
Date: Mon, 13 Jul 2026 09:12:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
To: Jonathan Cameron <jic23@kernel.org>,
 Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, duje@dujemihanovic.xyz,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
 sakari.ailus@linux.intel.com, wens@kernel.org
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
 <20260711184414.1013686-2-jakubszczudlo40@gmail.com>
 <20260713022040.146555b6@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260713022040.146555b6@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/26 8:20 PM, Jonathan Cameron wrote:
> On Sat, 11 Jul 2026 20:44:12 +0200
> Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:
> 
>> When device is suspended and it is in single mode then changing
>> datarate doesn't make it actual wait for new measurement, so to
>> be sure that read after change is correct functions that changes
>> datarate and gain will wait for new data.
>>
>> Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
>> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
>> ---
Just noticed that the subject line is missing ti-ads1100:.

iio: adc: ti-ads1100: Fix incorrect reading when datarate changed in single mode
