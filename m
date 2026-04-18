Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451824503B
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776495737; cv=none; b=WVjVQso63opLnSWjhEJ0XclfwW6hGmWQmfnkgOhNf7lJxwNmMvbx2MluQlwKoxsr5w4YDkaLMNhcJnlHoXAZalnuku7f1Ipm4wN+TlSGsVuiZXUwjRiZmbW33/GoAnRpvXfoyoJsrolrIRzGIKtR0LaCw5jL1IOZlwLU7aHJkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776495737; c=relaxed/simple;
	bh=0LxCSMAlTprhHVcaZ/Kig/+/PE9YK5dfaQRpW7ZnDMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhicEGgqEWHizFnXhznNOXZKvEe3v2/kZ2pFEThgVAwBNoYOGFDfE3kDTrpTmh+nWUKjLV7SJ8MFMGTOTN4H+5f8AkVYLnaNtFEjxStM6hTcPV7memMLJLmGCxF96556u4RS+xxVvFjI3X1JQ0B4eFDF2LzCG1n34xzMO+DynYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+uKNfRl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+uKNfRl"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so21267645e9.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776495734; x=1777100534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2PGp6adUklCNoEuFcx3+PMQlffGed9h7DVSnekk4hk=;
        b=E+uKNfRlvbPff+U7RcEnkGm+zr7mOWITASnAg9RjhmhtbyXGwIlRqq5umhiMpCWdLM
         pfhMT526ZhsiuQOPjXg1mJxkdeZrV2igMYKujmq+gBUBEh/dwkaMJrvITc2qDrv1tKp9
         pWPquC74bJZxSxcmDQuPEoNUcXseX2ukkxVAJO/aD6MjrK+Cg9mG0mjqNBdYUV/9C9dV
         3Mju/Gqc0YCIpAzj+9tXzOpOc0fkeF9XboSUHrBcS5XLxDAWRVq0EFPLJzqsiHT2iqnU
         bizZTUoulQse8Mw13UHch2MyxB8w4UHc3QUPgjQ/Ll09Ot+R91Tm4m9HIr+OkNd+4uT4
         c2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776495734; x=1777100534;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2PGp6adUklCNoEuFcx3+PMQlffGed9h7DVSnekk4hk=;
        b=tWctmejc2x82G+kmd1cUWtD9BZS++k+WKJHnjcAkQusiObi4oDsXDKG0PSgWUdBzyk
         laMhuXfiDn6knSYVGq1LYLgbLnZNCD1LtZGeGHgzXE8pmVsVgVrJ4WeWaEEPImOl6vNe
         OSgFgjWaWPqfQZygDlxKqmOwEwcZFVJKqfG3pBkk1wAp9y0LVns0plkICiwREG5hu1wX
         Q4osXtA2cwUsiZ1r8V5QNgo7yBZx1wRBpkhC/1sxyB8uXdp3F+nIjsBzR+gMQYGr1s6G
         IEQIExEq3y2wF42FgHPNHMtC87smzDQu1v7yD/1BsbyUmApS9UmhDX6kHjvSr2qFkGaI
         llCg==
X-Gm-Message-State: AOJu0YxZsYgQxuxApT4RG1MMd0PVwofeq03zfCFlel7pmdYoq3R9+8w5
	kjJ17UjAjHbEQII7dNs7d+VOJ0MLDHzDqAPi3oZTGtjf2r+p9gWm4Gii
X-Gm-Gg: AeBDiesObqFqUEpQMNo7df0MY8qBw+5lhkAcoLQllUIKx50IUxgQ6iGbWxhuk+rpYTr
	ITBquj6YTR6FerW5xT5XMhIL7j8G7Rl8txVItqCC9ae1Mq1qYQmVBws8KUgLq98mE/i4ywPLwFU
	brbcflhatmD57MXkxbiHJbZofq8pN543VQU5gSIvy2iJozhC8tUz5xFbfqmSOf/fPUnpBbnkXYQ
	tYexJKw4PBrSWxntJOxeTH9Kp6ircsH6jcOqDyCfygLba/DBS3Lx+AvIzeP7vgxgIjVcCh3cNKV
	MYw/wf/mt802AjSWzvJaOQYx+dIGF2pz+Bw+5iNUSILzRvZH/Hn0nsQ+zliBu4QB7IXUresQHEd
	lOQdhtoa2lUvVS9W7659i5bWUHR4PL7NN93IAYNKET18MULWLhMynZq+gNks0Wvpb/2/GRnvbMG
	O/GSeAj3OHTrpkQN7QrH9msJVeZk8F4kVst6wrkM1kTJsoeBGGjM4Q
X-Received: by 2002:a05:600c:6089:b0:488:e192:6fb5 with SMTP id 5b1f17b1804b1-488fb7887camr80734755e9.24.1776495733845;
        Sat, 18 Apr 2026 00:02:13 -0700 (PDT)
Received: from [192.168.0.100] ([188.27.129.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7aa593sm35208265e9.24.2026.04.18.00.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 00:02:12 -0700 (PDT)
Message-ID: <d6d8660e-c5d2-4f02-a5fc-2f8b49d2e0d7@gmail.com>
Date: Sat, 18 Apr 2026 10:01:27 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] iio: accel: adxl372: Use dev_err_probe
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
 <20260417124924.353189-9-sanjayembedded@gmail.com>
 <11AEFA5E-58EF-47BA-A533-E996D395CB15@gmail.com>
From: Cosmin Tanislav <demonsingur@gmail.com>
Content-Language: en-US
In-Reply-To: <11AEFA5E-58EF-47BA-A533-E996D395CB15@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/17/26 10:20 PM, Sanjay Chitroda wrote:
> 
> 
> On 17 April 2026 6:19:24 pm IST, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>>
>> dev_err_probe() makes error code handling simpler and handles
>> deferred probe nicely (avoid spamming logs).
>>
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>> ---
>> drivers/iio/accel/adxl372.c | 6 ++----
>> 1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
>> index 1a6ba94f54f4..e375d068a3f5 100644
>> --- a/drivers/iio/accel/adxl372.c
>> +++ b/drivers/iio/accel/adxl372.c
>> @@ -1316,10 +1316,8 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
>> 	}
>>
>> 	ret = adxl372_setup(st);
>> -	if (ret < 0) {
>> -		dev_err(dev, "ADXL372 setup failed\n");
>> -		return ret;
>> -	}
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "ADXL372 setup failed\n");
>>
>> 	if (chip_info->fifo_supported) {
>> 		ret = adxl372_buffer_setup(indio_dev);
> 
> Hi Cosmin,
> 
> Your email address listed in MAINTAINERS (cosmin.tanislav@analog.com) appears to be bouncing.
> 
> I noticed recent commits from you using cosmin-gabriel.tanislav.xa@renesas.com and demonsingur@gmail.com, so I plan to update the entry accordingly.
> 
> Could you please confirm whether you are still maintaining this subsystem with renesas/gmail account ?
> 

Hi.

Someone at Analog should be taking over as maintainer, I don't work for
Analog anymore.

CC: Nuno

> Thanks, 
> Sanjay Chitroda

