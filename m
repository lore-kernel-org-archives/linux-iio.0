Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D522223702
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721472; cv=none; b=cKp+yXiyRo2qCkWXRNhSqissuz5izs09mOzZ4DUFcBFboqx+Ievgex21vOkiePk03EavNdO/jUmhToigPu/cg8X0mY06lDxfJH7iApFjv0OeMIdDbImRpCOgMzxalYboHJYMNNGg59qYZo+kAxPbiIJCcWPCRYeFaX37Fc97vTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721472; c=relaxed/simple;
	bh=yFxM+FwWkqZuOBQsTPCSWW9DEUgOF6tUu4tyoHvlr3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKEKdKGw+915syw7jhsldwWW0Y09/itKF4clLATnTWeYd43pVoBQPvUg9j2ju+ATUfkZ90jV4YyaIxJi03VKuxSMtmos/Lc7rLF+TAQWhEdieHYPrQYNPdSlreMBYG5Wys3L2pNALEmsqBEAwTsoZu91xuVFG3fvMJkK9ctneqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O5KSm1r3; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O5KSm1r3"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6786b13984fso5841962eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 06:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772721469; x=1773326269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDq5n4yMw9e6z9A1BIBitGCBLWVemJFZFjtS+nGx1SM=;
        b=O5KSm1r3Fe01lOMr6PfDZvDBqt9i3aDg/ryLDrEVQyUvFJD3n8VgIYYWyrSzQWCoUF
         9rOkK6/C+KKeK++3Ud0b0t0SqbqgwgVETo9nMPCGIOyTk7EWmFQCal+KrLyxKGPOvO3d
         uYYS3AlAegopzVOqLv7K8RvITAIHQugAQxiHVctsAh39in1woPbDTISOYR2vn6dthY8p
         7Zp6J4x8+hlrw0NxRskTwDSWsRVtQ/clbubieC0g+iWAY7h4mZVttEqlg3IWVMel/aOx
         ECnJKPK2TiDrAF8gUB+pJjn0Ss4a1MnVHJwkQPhjEPdS08v6n0j0rI60uIQN8Z7XWPEk
         +1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721469; x=1773326269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDq5n4yMw9e6z9A1BIBitGCBLWVemJFZFjtS+nGx1SM=;
        b=umsHos2mboKgWW+F+EEaubQeG1nITXr6Mq47q9nEo9UiAgu5J796VcmivyUXmXRW4U
         /Ioj1XVCrIELiwEwUGyrBlyPZNd1hVHhxaX+6UXNtCiHBGewFslJW8aLws9h2FcO7SV0
         5+Sks+uQkQYQ9DlHhNYwdcorR0yK2YSeDXX8xABulkodI75JYzHrF2xkoT5G5RKe9CNf
         o+K1vpABov5+nfbhs94ysJO4En4ADK7o0l+Tw+WbS/SVUVBwBefiZ6up07pJ8sJCQswx
         Htad/F0jh/LezbwBJp2LuRh+Tu1NUxIy3Q3nUHNuVGWazFhPY4+qo3jX0iwGTzHD4nbL
         hS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkp3FOoTyRenNOeByX8j0ecnQiWV3Xu1FThfDmgKt0wiTMVb+LYjgOWSD41K/92T22a7LuJdP9scI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWUx89rtUGAC/4a4vgsifz4uZd5N1oZ6NgwSKHRKpJzRfn24wq
	3+zhUe7U3/dWUHamepGkFqp7mTSp1LsvTwnZtWOVHfuWaIou/59p+DiDIOnwbh9qNUY=
X-Gm-Gg: ATEYQzwEOGRnKZ0D7NH/rhztwPDFmHu1wifjE//3Yg1pYuEdwXIEpjdt0uAUTuHiaXt
	noyjkKVUNksYFtmiCkpfUWKvWf2r965hrWSsjdbcd537NhyjCN98T6dBrSYT5Bij17k1blDCpqY
	UOK9Qk84+wZs4JTwkLqVlFvIt8N8mWqOuGTKC9SQGrZ5Zv5vxAPWuilWv/sWlrIkbD/VDq+0rqV
	W0XQOTuY1irWQ1ZTz+d90XLvftZ6ZYVjEKExWtCz9Zo4E+hN/y9njFS3pDJgcwOj4gzKGacn5um
	TFDb4L3RoxCOE97C6wSE0XNWLUIuS8OuWL1yZzFhQir9jQLdVDREyq3V8As+XskhksSHECnTh72
	VHssP1g59Jh9Lu5OxVjHWkxFWVFFF6hasbkgr1B7lVM1GPKHTiKrby0FvcYoGUtS8TAOUB6evRX
	dyeH6RFwsbBURk5xdJmx8lnSAubH2j3I4cFGkSvO/+dLczNrvwFWbZ+yLI4hcvupatlJzK4SMYZ
	w==
X-Received: by 2002:a05:6820:4cc1:b0:679:9844:698a with SMTP id 006d021491bc7-67b1776ab7cmr3503859eaf.55.1772721469509;
        Thu, 05 Mar 2026 06:37:49 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:874e:e775:4f67:b3a5? ([2600:8803:e7e4:500:874e:e775:4f67:b3a5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm5413217eaf.5.2026.03.05.06.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 06:37:49 -0800 (PST)
Message-ID: <dd6d1436-d509-4233-ba1f-5a3f870f35fb@baylibre.com>
Date: Thu, 5 Mar 2026 08:37:48 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] iio: ABI: Add support for floating-point numbers
 in buffer scan elements
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080658.2844434-1-flavra@baylibre.com>
 <70f25902-5c79-46f9-8c67-99633b22b5ac@baylibre.com>
 <098886563f5fdcde837989d0556ed9a2d8d3203b.camel@baylibre.com>
 <CAHp75Vdni=OgHiDi8G5s6CgBFZZuypOyJSo5DFjaKYFkLGPqkQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75Vdni=OgHiDi8G5s6CgBFZZuypOyJSo5DFjaKYFkLGPqkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/5/26 3:23 AM, Andy Shevchenko wrote:
> On Thu, Mar 5, 2026 at 11:09 AM Francesco Lavra <flavra@baylibre.com> wrote:
>> On Wed, 2026-03-04 at 16:45 -0600, David Lechner wrote:
>>> On 3/4/26 2:06 AM, Francesco Lavra wrote:
>>>> In the data storage description of a scan element, the first character
>>>> after the colon can have the values 's' and 'u' to specify signed and
>>>> unsigned integers, respectively.
>>>> Add 'f' as an allowed value to specify floating-point numbers formatted
>>>> according to the IEEE 754 standard.
> 
> ...
> 
>>>> -  Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift] .
>>>> +  Format is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift] .
>>>>
>>>>    * *be* or *le*, specifies big or little endian.
>>>> +  * *f*, specifies if floating-point.
>>>>    * *s* or *u*, specifies if signed (2's complement) or unsigned.
>>>
>>> I would keep all of the format options on one bullet point.
>>
>> That's what I did initially, but Andy suggested doing differently [1].
> 
> And still I think it's better to not mix them. The floating in the
> same sentence is confusing (along with 2's complement mention and
> sign).

Then I would split up all 3. It is strange to mix some and not
all.

> 
> ...
> 
>>>> -is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
>>>> +is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift], where:
>>>>
>>>>  - **be** or **le** specifies big or little-endian.
>>>> +- **f** specifies if floating-point.
>>>>  - **s** or **u** specifies if signed (2's complement) or unsigned.
>>>
>>> same here
>>
>> [1] https://lore.kernel.org/linux-iio/aZ7dCdLs5xcJ4UGW@smile.fi.intel.com/
> 
> Same here.
> 

