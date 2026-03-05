Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A33A873A
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721630; cv=none; b=FmA3u3a/k0Z+g6r733H3opaw0qF1NVJvZFBHPI0AKnsKAb6tBXs/3Ug+jKVD8MfKKfDrD5ChhfHiOgwwfxGzQKpRXoCedi85J9h1WoUPiBURPc0euX47kCKS7VQzea0LO+JPj33jd9gv+ZGiLLqIhCs8jUKsRQ7DPOjw0ctPjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721630; c=relaxed/simple;
	bh=x0IHbI7zkrY4OQz2ww37pu08inkjv+bB2IUg1qOTRMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFUJJwMBlhyUQQNODZYLIYhy3q0qP2XL/Pzm/3XSlUTaw+6ShB71uNiXrZ53/dPAJ3jU1YxAaNUQTiwi95fM+ES99FB686bmaupcaaWzDcqHE8KvFi9qXocvw15qlLj8weGJbVEUor5TeYp+ev4VPABd6zA8dclTyVHilkLvSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z7xM+jA9; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z7xM+jA9"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d1959ba05cso4077756a34.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 06:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772721628; x=1773326428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVU5zT4oQrMXt6jl2ajfFdVScSq3j2jzoZfhWMLtyYk=;
        b=Z7xM+jA9FDDuTtPBc/jFZy+Oq2WjN0E7fSGgcbv+9S4IMk3jm0sD3iicnwZROWPU1V
         VjD7WrowgizCMBsZfQUP4Z72nTFJvlw1frozyQImgV9lkzAXsEMkM++3ZhCpGIQGldPf
         1+qYmyLQUDMFgTXgdodKdbK8LsVkSTYIJumAQt7GwH+o7J8YV+qta4d25PbEWDgs+K58
         u53G9CyGaCs/YeoxpIEkB13wPMJpwQYu8D/a318a7Bmu7byHaEHF9q4Z5q9OxCxcD1Rj
         HFbxYCdjN5G+gPr7hyW8qqKlHaOkZPeKJ8bWF739CazwYsPLW/I1QDcr9cy1cpMxjYVM
         MKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721628; x=1773326428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVU5zT4oQrMXt6jl2ajfFdVScSq3j2jzoZfhWMLtyYk=;
        b=cGBiao3zGqvD3Wvv4urtjYu6MDQGcMpLtu7+71d57FD7o2cceZebiWyDpHFnknD1Rb
         m5EBDWFHmhxklW/RCsYsp04UWK/yvKpUpwJrTGLaR/eDXcFVq1ZhRskrhnKpMQJol0Gq
         7xspyqCGHvFttQgQycVS6SSXNlxI2OtV2Pc5rtQ29I6gPs3bE3utry9bvbIBVn4f3wnw
         TsDCqyNEccFyjx9bGQ6ljEA6L1RoqKbUMTuGZaFcU8iJdfYrcj0wI4NZoNObMWYrS87w
         BQF4D8LK+MIMnWN2/OEogp7h8+fAy4Bjl8Knj/9FdNO5/LIMheap02i8PItphQMsXvTb
         4C7g==
X-Forwarded-Encrypted: i=1; AJvYcCWFhldwfLjzb6P8lcDkH9FLmztzi/zKkpQRnIIYEA3rTga5hqMPdm3ieEs67UbDrb+pzCEOGUNCack=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WpXE6mdO/p6wixVqzA0i7cT6TnWjk9/dKjzN8LbKlUtQ5VEp
	8gpMXNAlhJR3Rns+NxI0uHh6nn4WE53XhYqWQVbGvZUgb3nvXOP44bWLQTtHyYjSNXw=
X-Gm-Gg: ATEYQzy1b1D6w1AQkemzsHtZDH/xytuQZV85zyrEQHPp/xDowYqwOdrWqXHzIlFZjGW
	poydgQ+otrkiMzw/uE6pNDK3hgVuSt4CauSN008izh3xWE9ZhwMPehxF5NDoo28/zz4P+9W0Tll
	+P3Z0pKGr40T6vXMnCQbvcC/P0htnuVDAT1gA9YvGg/63z6TonUTuGHQOTs6l0thb4DHPR+sJFn
	I8EUIUrkcQ0J+GV2mIMJelufBWPYx0RBusLWpXNnGOcB8uKBmFdARlq4hZj1VUHUPbKBN6QuSL+
	N0OkuXPHbElAdXcYEb9+wsA6chq1iJxTG3A2D0jAa6f3g2mtooQnvAZzvDGCFMayYMRjzn+Pf1e
	h38K7CjE/joWiU0EU0ezpQ6BcyGzREdhaRbidMCJcTUVeSRwWf7P/RyLUzIotZXf063pZFr65Q1
	gvd2NmZSrnADB65tw5oSKN5UIyTbrkvHHpmmjCRdGzVADskrvXk3ZNz5T3KXtyN//TR1dqxOlKN
	w==
X-Received: by 2002:a4a:e918:0:b0:679:c358:8ed4 with SMTP id 006d021491bc7-67b177584b3mr3549685eaf.46.1772721627905;
        Thu, 05 Mar 2026 06:40:27 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:874e:e775:4f67:b3a5? ([2600:8803:e7e4:500:874e:e775:4f67:b3a5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf259a7sm20746906fac.3.2026.03.05.06.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 06:40:27 -0800 (PST)
Message-ID: <e145d179-d8c4-44d3-ac7d-1721b676cf01@baylibre.com>
Date: Thu, 5 Mar 2026 08:40:26 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
To: Francesco Lavra <flavra@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080706.2844472-1-flavra@baylibre.com>
 <aagc1_EkH3cqh41O@ashevche-desk.local>
 <a265489380e7abc9343c536185bc203688c5bd29.camel@baylibre.com>
 <ae79da24-1129-461f-a8ff-9dadfc863fee@baylibre.com>
 <0e808a2522e4021187ccf6aca5d8baae4beeed6c.camel@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0e808a2522e4021187ccf6aca5d8baae4beeed6c.camel@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/5/26 2:50 AM, Francesco Lavra wrote:
> On Wed, 2026-03-04 at 16:42 -0600, David Lechner wrote:
>> On 3/4/26 8:21 AM, Francesco Lavra wrote:
>>> On Wed, 2026-03-04 at 13:51 +0200, Andy Shevchenko wrote:
>>>> On Wed, Mar 04, 2026 at 09:07:05AM +0100, Francesco Lavra wrote:
>>>>> This modifier applies to the IIO_ROT channel type, and indicates a
>>>>> data
>>>>> representation that specifies the {x, y, z} components of the
>>>>> normalized
>>>>> quaternion vector.
>>>>
>>>> ...
>>>>
>>>>> +What:          /sys/bus/iio/devices/iio:deviceX/in_rot_partial_qua
>>>>> tern
>>>>> ion_raw
>>>>
>>>>> +               Raw value of {x, y, z} components of the quaternion
>>>>> vector. These
>>>>> +               components represent the axis about which a
>>>>> rotation
>>>>> occurs, and are
>>>>> +               subject to the following costraints:
>>>>> +               - the quaternion vector is normalized, i.e. x^2 +
>>>>> y^2 +
>>>>> z^2 + w^2 = 1
>>>>> +               - the rotation angle is within the [-180, 180]
>>>>> range,
>>>>> i.e. the w
>>>>> +                 component (which represents the amount of
>>>>> rotation)
>>>>> is non-negative
>>>>> +               These constraints allow the w value to be
>>>>> calculated
>>>>> from the other
>>>>> +               components: w = sqrt(1 - (x^2 + y^2 + z^2)).
>>>>
>>>> Just to double check if we really do not have a special mathematical
>>>> term
>>>> for
>>>> that already. If we do, I prefer to have that over odd "partial
>>>> quaternion".
>>>
>>> A quaternion is often represented as w + xi + yj + zk, i.e. it's
>>> composed
>>> of a real coefficient (w) and 3 imaginary coefficients (x, y, z). With
>>> this
>>> notation, the (x, y, z) components are referred to as the imaginary
>>> part of
>>> the quaternion.
>>> Alternatively, a quaternion is represented as the combination of a
>>> scalar
>>> value w and a 3D vector value (x, y, z). With this notation, the (x, y,
>>> z)
>>> components are referred to as the vector part of the quaternion; this
>>> can
>>> be confusing, since the quaternion as a whole is often considered as a
>>> 4D
>>> vector.
>>
>> I'm surprised there isn't a common name for this. When I went looking,
>> the
>> thing that came up most often is that Doom 3 used this in their MD5 file
>> format. So maybe IIO_MOD_DOOM3_QUATERNION? (joking)
>>
>> I do think we could come up with something better than "partial" though.
>>
>> My first thought is IIO_MOD_3D_QUATERNION since it is a 3-dimentional
>> number,
>> but I could see that being confusing to some since quaternions are
>> generally
>> used for rotations in 3-D space.
>>
>> Maybe something like IIO_MOD_3VALUE_QUATERNION or
>> IIO_MOD_COMPRESSED_QUATERNION
>> or just IIO_MOD_3QUATERNION?
> 
> Or, since this represents the axis of rotation, perhaps something like
> IIO_MOD_QUATERNION_AXIS?

Sounds OK to me.
