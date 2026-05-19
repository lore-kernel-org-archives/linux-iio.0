Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A92F5328
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173377; cv=none; b=T17v71r5k5J9QOkD5pU3UxrYC/8SDF0mkbVlQturU5fPGgrkk2DRRJHxG/04/cPTzmtlmm7S7l+woAkbjVA52apBzmkw5kDIgOqWwtZeB0ydHzRX83prCQOO5HZf7WCGAqr5XcGOWkSnhSmkWok408oZPdAgqtsuuw8oE588zRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173377; c=relaxed/simple;
	bh=iKU++M0vilTbASJ/HVX2th9oXg1Tia8+ntZQGzG36lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFbf8T0/0RUHd44O0DNeZqvkkjfbkR6kccogbh/s1BrxaJcD5uX3Ik+/AEfnSm1UDjpgdlJ+pCQ/7/8omKDl2dAX40nVrKzRYcP1qf3WoeJ8+B59nw00AUWR6eymYtCtXV2ngF+Satt5bMbPtIuJgX9vCztUCxzihXOkbg3MUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPdh5Kn0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPdh5Kn0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48896199cbaso24605205e9.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 23:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779173374; x=1779778174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNvtLaRKreB62CpBERJWnLj4Hlcc9HO1L0Jaettyk/k=;
        b=DPdh5Kn0hh6YQp/DpTv194W6HFCrfjZqhrBPljpJUVEpi7Y0Q9inBkZkIGS3Py7I79
         p+nOFDZrePSv4EeT6vUjVPoiRpM2dob6JASUGXc7A1dfcGRPjRs1ZtQvMbPpTB6zGf00
         YwMLcyNblqsGyVYRRN9QMgnMTYwdETo8iDf/Ld4Yi6TOXPYeY2w9dHkNq+Hk1ofh0kaO
         +YZd0atf8ebMhw/1UEaxw/AJKE4bOeS6YcXLop7FHiFYiSHp55V4syDkJIhrAuNJ7rk8
         XVGrTNGtUkIML7DEum0n7ChgHArivXNf18q+yXQgKnwVSUntT9nupYIt9cpbsc+OSWP0
         J9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779173374; x=1779778174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNvtLaRKreB62CpBERJWnLj4Hlcc9HO1L0Jaettyk/k=;
        b=NkRV+xIKkXK/Kua5bab+OOn5mUbP/5K5Lib5FxAzJhKwA2phVLcVuPrbTqE11oybFR
         DPR656CuyD8bAFl/tWh2lt253Z1sTjFLVWF5Ig4TKhvLEh/HVrbZ0LoQyRTlKVSyb2yW
         obWNE4PJfY4mCLRBa65eN+bb8QwUoVVziPMpaDzpeLESExL4OpQRWOG/EodjLrpBxbU5
         QT0wporkfmRSbjApUDKACS4R+mSvVs4dNG/V/j0fXia667y0yO2EpEV3xP4zlU5lRShX
         XAeg1KmD7VJCMcr4Aw4iXi55WFIOebLA+D2Ifu/XUp9JHjHEnyxg9mrkltYmR7gXyah4
         l9Vw==
X-Forwarded-Encrypted: i=1; AFNElJ9o7sEgHnSwyQcdgt18pn1DYti1PR3OlRQZiaq54hf1eURfGR/7v+lWJna0Kql0ODo/9MAv6KrXDDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4FgXL6IeJoGkKL3KIwSeG1VaV+vSTvklgRGM5/DvgswqZpUp2
	1EruRLrtZKxJC5m/Hb68vq7NidXIkZFacYCJBFlN8ijQrPIC3nqFw/Ak
X-Gm-Gg: Acq92OG+vtbeJ5RNBsd+QxdO0wZ+76icHR2SZpJpcPfSqg1wH+m0JbJsW/ecd7CQYyF
	qPPtY5WxXFLsezFMcOVaMJ7dYcN4B31O45QF9OEw0OqqLL80yjDVijbcpx5P/n0oR2GK4Iw1NfF
	BhagDnk32nxAXSWivFSspnFQvf8nnIsGAzLzAt62U4ntaqiub6eE3ttBrwRIC+AqYc3j/E/Q1BM
	LsEPyirC7sQIYOc1BfakL6NGPin1+7DNSA/oD0fvM6lL4iDoKWLQ8PpKcMc5Z1+ZMtSqXJXTEGB
	AAh3cxAhIVR/SdI1QT4xLftut1OkuSC86Wx4vwWjsEGW8HwBCjRKI2cqQsQ22lLz9NNt2CVddvx
	gps6CtgmGoHfF4L+f2A+k7sPX2p716ZIwjyjdzZSt2XyagrizpNR+e71NBXLlYQCErhl1ftlL6R
	DDIEtUlu/BtZKLBxmVl+J5vyoIgYjuM1/VS7dg4YmeEK4vHV+6pvpKIQrcicDVxEAo6xsiLDRZD
	l5ETKc=
X-Received: by 2002:a05:600d:b:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-48fe60ee64amr213685155e9.12.1779173374183;
        Mon, 18 May 2026 23:49:34 -0700 (PDT)
Received: from ?IPV6:2a02:3033:6c2:b9c5:ec15:f5ad:b85f:a3b8? ([2a02:3033:6c2:b9c5:ec15:f5ad:b85f:a3b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm338876785e9.11.2026.05.18.23.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 23:49:33 -0700 (PDT)
Message-ID: <03881262-0906-4ab4-abae-92085402a297@gmail.com>
Date: Tue, 19 May 2026 08:49:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Documentation: iio: Add AD5529R Documentation
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
 <20260508-ad5529r-driver-v2-3-e315441685d7@analog.com>
 <20260508140029.35ff63b0@jic23-huawei>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20260508140029.35ff63b0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/8/26 15:00, Jonathan Cameron wrote:
> On Fri, 8 May 2026 13:55:49 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
>
>> Add documentation for AD5529R high voltage, 16-channel 12/16 bit DAC
> Whilst it is good to have documentation for devices - I've made some
> comments below on not providing documentation of standard things (too much
> duplication) and being careful to work out who the document is for.
> These tend to be for users and board integrators etc so we don't tend
> to have much about the internals of the driver.  For that see driver!
>
> Jonathan

After reviewing your feedback about removing standard IIO content and
driver internals, the remaining user-relevant content becomes too minimal
to justify a separate documentation file. I'll drop this patch from the next version.

Best Regards,
Janani Sunil

