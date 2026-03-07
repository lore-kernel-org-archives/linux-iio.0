Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB353382F4
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904955; cv=none; b=Yrexefk1GewAs48BZKLYQOiiwizlwc8Hf+QD0wvrzpQNMvycQDL6arkA+DnjJKbPicBlib8pWeydOQRTcCJfFVnr++TBfn7ECdpCvN954vp25SMAm5hS82dKNcYhjf4cVnmAihWboC3FbvztMZJtFkJA7mdO8Gw2npM0XzIvaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904955; c=relaxed/simple;
	bh=IdlikrSxlKRlIV8yOYL9V7FN17UFwg+5SA/3zwMVLzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1qYSbODq3R1ui49Zo77/LfKnpKh+pSkxzrxCMaKYWOKg/Cvk6hdCtrUJzu3YM6ndLLUEB8Gss3dCU72V6pHSoj3PfEZSa+OGFUobBojNsGU+zoF7SCnw5hajacNoDTR3963UDkOWB6/QKRQsGlclKt7+R8q0CmrFCGR9qFGkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oiOBFlvA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oiOBFlvA"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-463a94f8475so7341021b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772904953; x=1773509753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDkcsKgSUge1OGeONN3ftwbPvkeD9dQGZlZ9gDV45A4=;
        b=oiOBFlvAk07mc7goyM3NCc2X5FRsf+HVHv7Gja7MtdWDcK6PpLJ+ggQ1cLp9VT90oM
         +ydNNKZ6cHq9ftEWYsqqDfCEEkYgUHANdz+I04eQjKqs/iBaEM7xQx7mqwHwOH+BNQHQ
         Huy79iJpmgQEU5fbIFit8KD9Fk6nGmBhpZVgtmQmUU2RJT5cly3N/1IfzjCSzcXo5+7l
         U4t6h8/PLOY6Ctg/Sk6DxGUOaBvtElbO4I0LWF9uRs6s0y7Yxm75Ta8n3uPqkdU6kCEO
         853msKwf3vJs66J1LiRQlaC1vurSeyZ6Uxu/IinpZ85RPryYTRimzrr9mU6tRdBGpW2o
         YAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772904953; x=1773509753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDkcsKgSUge1OGeONN3ftwbPvkeD9dQGZlZ9gDV45A4=;
        b=f6tc6i7HQt7b04WnpsBOItPixFtPnJaIw2P1URWBlhk9P2bMCDv43cijScjtOzTii2
         Yva+rxZk8no87lY9SklgF9G82M5B/fi9A6G6VfphKBwfE8bN4OLa7YHXdzLpnwCNHsp0
         2E7cftAVlbt7yWlPTtsjyckXaAfO8s2qDwExVNXHnnjH/0FBRQxodG6yX0QoSFxnX+mm
         PnCQTKuCaIk+MbYmQzYppkQ9IFp2N2E+LQupxHwX0qJqVRh0MPfeMLJ6vR6oWEtJAY5F
         F6+2tUrpXqTmQcwdCQ5ampaQKLgOqRyaiZcRne7mPPl9iHSu9s9P1JAcayilmy7wI6ZY
         WH5w==
X-Forwarded-Encrypted: i=1; AJvYcCU7mRn65En/yvHe+fQXKStMrgceCwsv9qIThW8bsrrAG6C0GCpgUCSHASq757mi5rCezjdrG0OxD5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YymKx9t2X8iA6I9Ql/rV+vGgHegZpqz4wi+zBDD1jm5v6JNBCr5
	pCErJFIIoRCi+II0lvadMTehRi1DQ5vLpF6d/pn891kvnYJgsZVoOBHDwgXE72eOxRICHmowCQK
	oG38W
X-Gm-Gg: ATEYQzztAOySkLnZuZxsHF58apATe027hGGIES5fo+l6KRsTeG1eN9CC2UExI7Fnt78
	DXaoyKaS7aWEo2IBSsKnL2En02tfrbBI8N5uaOfcnQIDeU6qHBOK3RP8Ed5hXTwbyYUe/qldeZV
	YaJ5JWuNj3GQWiTPKMLo/mSZb9rteU5XAn+X9ltt9i9YYdUrcuo9rkcI4l0jhhaaPLxuItcZK8T
	/l0VBfYZZKzLj6OYMUqbEOi/RtCMwEEqgh1UP6WCZlHKjbgRUW72bWnewpd6EO0EJ1bhQF+qUP0
	jtozTwtTdRBto0z/NREkf/CWAkGtarfGgvwwVUplCSGWhN+0Q+ujFKn29A/irOrColc5yzV8SGa
	WZhf8s/czEfAJW2BSSMVqbrVWt/KsmN0uQ1XKpe54/ZaLWUe7ChHTMM8kZgLTWrD50C2FWrPA3L
	hI+R28nhw3nnzZtfIgbDMf91ofOmUbST8N1Fpm2v6YIsh31B8GyyPZXQc4kqaRgfZyxqDeduy6c
	g==
X-Received: by 2002:a05:6808:4f48:b0:450:826e:5df1 with SMTP id 5614622812f47-466dd0f718bmr3563525b6e.19.1772904953014;
        Sat, 07 Mar 2026 09:35:53 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466ebbd7243sm1402325b6e.3.2026.03.07.09.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 09:35:51 -0800 (PST)
Message-ID: <1b78fbdc-e695-4d7d-8531-b02e98a903c8@baylibre.com>
Date: Sat, 7 Mar 2026 11:35:49 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] iio: adc: ti-ads7950: simplify check for
 spi_setup() failures
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-4-a23fdd1a079e@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-4-a23fdd1a079e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 1:21 PM, Dmitry Torokhov wrote:
> spi_setup() specifies that it returns 0 on success or negative error on
> failure. Therefore we can simply check for the return code being 0 or
> not.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

