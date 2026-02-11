Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566092DC781
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817484; cv=none; b=inYAlNb2V1Be7PUds9gwJurcuUz5p5c15mWQzJTSj/iEE7TK3XNWhKjh2UBBMrLWm7I/CVJYCXqIzCwlFBGN204vGHpg6HwlOhX8aSJrVj5y1j0vqjRXQPUlv+1XhZYHJZIT4SaP98fMmvuchkSzpebK+vMIFJAbzrViLNdjm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817484; c=relaxed/simple;
	bh=/11VEqhwGxvQVfEDWs9HDEyvesu4S7SCHh6a817GTv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKg0fF5Q3FoB6DEv208LaRWHVHN2f5X48bPmn3AswmhCSW83WZEnwLab8PyX7hwusdf/xp3j6f0OqD0Eu9tBSTTTl6/UYYdl4OSwQGqnXlhcB5sR8NkG78NNoRg6SRIq7f8xYnVIyzgayz5XdAcx0dzV7Gd8DKq6n1rBHlqJwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ammpMnLC; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ammpMnLC"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64aea64bf15so2071802d50.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770817482; x=1771422282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=esoqYJ+UQfCawlbPhicOHbgq8QCm1eQe//LmcmVz62g=;
        b=ammpMnLCDSU8/925KEqywCJQsTU16jSgPFdnt9mJ+k0L7rENtPUwofJwfXkTYTXuBk
         ZyBIjIgQUvchWUetpkvugpujW27MetLsO6Gu5NqODvFCgnLEUshW1CK+YrQK2BO6v6kB
         zhlpNbr0Txdtg8XZr6MAQ8UQLECHH3bBQ+nqVZqZ5sKO4RQ7b/EiTAgSJtV3TQ4zIJL6
         suflbg/YZcdbs7l1SfutiXetl8YNeyd/2I+1OBUWdx447R/iq5CaK1YAogAUhMZjKhQJ
         lc7Pl3dvvROCpIyK6LDt32eFqIycoMnx6pnJPLxQrHkmeuIoGAzJ3NN6BWcI0xBC/H20
         qFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770817482; x=1771422282;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esoqYJ+UQfCawlbPhicOHbgq8QCm1eQe//LmcmVz62g=;
        b=ccpa5wM9v0j81Z8TBB6sKBIwxR99kYLwcnVcME7iERyBAAt9zv8gtyvreyxVd7cCtx
         qPF/4TbA7llWOt+Gzoa1owKGOzPyx34i40EQtBkWa8ACLSqi2kLl70+2ecGVtigiTO9Q
         lu8j+YauIn5EOVNSqvsvZukCGJPdjiA/ZwJlDL4HyjphR6vSctIF7kO6LTfyRcI5tJ1B
         ftplwNBYy6Y0d3gydVFMYYQUqzGm0iy5UET7egwFmku0yt3qs5WpXM7XL2MgtKIi0HzC
         SVdgQkxL1PYZFyWdyhIBfYks6GOWCLTtd3Q9m4KoRtqb/SoKuYu6tC8AwaCTCm5FIEOz
         O+nw==
X-Forwarded-Encrypted: i=1; AJvYcCVNzIQxPFwUluNWTJ4D/qWlY/kYxefHF7RchINQdcz3ognzPz3N1fIwZhxY+ZNJBWP3BArB0a7tNrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlO2cxIuNIKEu+GcLHGSkU/7Vw8m4/HHOtgwb8z4I4IzPOCdfS
	Jx0vcz8V7u+8g6eh0YAkPgC/7DeuozPw6yr9hh/RwlHdZAhU5gy7PWDP
X-Gm-Gg: AZuq6aKReXSbUSAfl7zYkraxMrFr5C2DC5RF/gon72WXANURoZqQhohZuQ0pOUAapx/
	BWEDW/oO9IxiyVRrIOasrzuiJWmeLndx+Z/HUzsIn7za72nNJhUuGYL2FKKS+MZ1bsIHH9utRNa
	LnHtDgHcsISO4EF3g8BfI+uhE5c7DLTzUWMHVx5p1kIvT90yCEYH39Y84LXwVEkcz3Z1tDlgDOZ
	Z9oRF1aHvWGVzWM2d5wNgmQiFtdPkG0U5h0CzcnjIMJIABDel31YhPvim379ADQ6YbXA4gCPjiY
	+wM0tOQcVO312FBi0kW9y5GE8DXOczhhf2XRzOTG4v+ciZzJlywIY8fdvEDQ8ot1kBaMYnaPLxt
	ydOcsOu3sW9qsx2QDwTEDj+3RvCPYPGvqA6sCZxTP8PFHAaTLdEAGTH/XDtf6e4yS2WwU0ooMYR
	vkD1M+687JJOLrYqo5dncvlQ7xqw==
X-Received: by 2002:a05:690c:9b01:b0:794:71b7:2adb with SMTP id 00721157ae682-7952ab24f48mr346147957b3.38.1770817482271;
        Wed, 11 Feb 2026 05:44:42 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18bd49sm16215487b3.16.2026.02.11.05.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 05:44:41 -0800 (PST)
Message-ID: <59d12283-28c0-446e-b591-a7c3d022f50e@gmail.com>
Date: Wed, 11 Feb 2026 15:44:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
 <20260210-cm36686-v1-1-aef68dd46ad4@gmail.com>
 <20260211-sceptical-frog-of-revolution-fc3cf4@quoll>
 <b95d7a49-6191-4d85-b725-4a941505b40d@gmail.com>
 <6f97c68d-0236-4d04-8199-768ecee7c4dd@kernel.org>
 <242d5502-bf58-4e25-8258-8a6c75ff3623@gmail.com>
 <aYyGIPNeHWpluaoF@smile.fi.intel.com>
From: Erikas Bitovtas <xerikasxx@gmail.com>
Content-Language: en-US
In-Reply-To: <aYyGIPNeHWpluaoF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/26 3:37 PM, Andy Shevchenko wrote:
> On Wed, Feb 11, 2026 at 03:32:41PM +0200, Erikas Bitovtas wrote:
> 
>>>>> Please implement previous feedback.
>>>>
>>>> Since I am making changes to the existing driver instead of creating a new one,
>>>> I introduced a new patch series. As I mentioned in the cover letter, cm36686 is
>>>> fully compatible with vcnl4040, so instead of creating a new binding, I create a
>>>> fallback compatible for the device. I probably should have named this patch
>>>> series something else.
>>>
>>> That's fine, but that's v3 of previous patches. Your work was to add
>>> CM36686 support. How you do it, evolves, but patchset/work is one
>>> continuous work. When you rework approach next time, you also start from
>>> v1? And then you go back to previous solution of new driver it will jump
>>> from v1 to v3?
>>>
>>
>> There has been a misunderstanding. I assumed that since I will no longer
>> be developing that driver, this warrants a new patch series. I apologize
>> for this.
>> Here is the changelog since v2:
>> - Remove the previous unnecessary proposed driver and bindings.
>> - Add a fallback compatible for cm36686 of vcnl4040.
>> - Add a new compatible for cm36672p.
>> - Add channel info for cm36672p.
>> - Remove redundant information in the dt-bindings commit message.
>> Here is the link to v2:
>> https://lore.kernel.org/linux-iio/20260209182432.00006c3c@huawei.com/
>>
>> I have received some feedback regarding the changes I made to the
>> existing vcnl4000 driver. Shall I submit the implementation of it as a
>> v3 to that series of patches?
> 
> I guess v4 would be better as this is assumed misversioned v3, if I got
> the situation correctly.
> 

Yes, I started a new patch series when I should have continued previous
one. I will submit an implementation of your feedback as a v4 to the
patch series I started initially. Thank you!
