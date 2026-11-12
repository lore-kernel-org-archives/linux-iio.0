Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446765;
	b=SebsS18bQhHFYhQTB9qNB6wXPJweKBNziOyAUFx1gizf5KqOjLL825QnZIeAicocFNbo
	 BaLWFUrYAyaRVDF00BCOJ8Y0UDWeLBb+6N/Fog1zrX60oITFCzUUFj2UFbWQOKipabwr+
	 L/c4pJ2r+b9Xz94p27aIzA2vsHKzgq3K6J8mesYhwb2EkuDBVLy7o3c0hRC7SsKEnmRct
	 Jffh4mUnZJzk3Jr66d7ovOmb09H1ZC67xgDzDUu20Gbp9V5ikFI/ufiFSkro6WNGvzvYy
	 g3X88TVGCX77bSXKlx0QNn6/G3n7xaABeLp8jQvzzyeSTABsP2Lc+JcExP3Q4/7WPsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=m+Hm8h27H+tMrn8DnDQGWdsE10AXH5b7GXOSSBSzWEk=;
	b=TPHM+uwudQW0lrrr+W5b6+pPgQzijIPnVm6ERo5oYhbowbilEdeR9kFY0u3RpV7wIxWh
	 136tJLNl5rlsm2JdBFz1OxjzIPzDBvQDqkqpebduFm2Oxa+4Wu/zrhGX2THxiFDtsBkNK
	 se94pxJwC21HGnUPpOlWOVKuMH8NqgnQvjs6XWu2457tTIygAbKCNA5yC/WqU2/+WHVQm
	 3M0rEC2l9S1OnvNcsl5lCXZj56n8ajc9S2bC5975d/PApdgl1MbmHDAQzNbGVPB+XO5ZJ
	 51nhDwBhhODEqHkrap3AzqETyQRuX+P4I+IkuvuIQCUsx9R+4bgsOkIf5YsSLk6+aXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZsYPY1kc;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D33606A32D
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 01:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39D33606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZsYPY1kc
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a2af4c8d00so3743784c88.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 17:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794446764; x=1795051564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m+Hm8h27H+tMrn8DnDQGWdsE10AXH5b7GXOSSBSzWEk=;
        b=ZsYPY1kcOQ1ZkbpwRFCLeOhKMk+CXgiVRlqpcHA2KRBb/wtWm/38P5ptumhbwtMSMs
         4Gjx5DC55qOIiy9xR8C5F2UUSvW1hdJ46sqxWm476o9UBQbatqeXDYrDStIwCCQf9gTs
         1Y0V+4AepBSMO5tvFvdmYXeomHELECh7nIsRzOM1ukxztuJBZWrh+f0DrI/kX+SzGMoA
         42YkjlF71Om+oH1VlmZHRDR/0y35e3VXs9UL6FvlfOhweg6D0LxU2MTirGODKqbeDuLx
         RajSdUIwg1iExbxEMTMSyPSPErbxU4Hg8IEeenIR/z9Ff3waNPkk/Oxjf8VEG++ZPq9T
         OGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794446764; x=1795051564;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+Hm8h27H+tMrn8DnDQGWdsE10AXH5b7GXOSSBSzWEk=;
        b=fXliMh9HyyysMJSJQHnXajyepUqB9ev5NfMOvlXP+kwD7/2XvffTanJ2mBWd9bvTLB
         zMhZF49cfgFHh5Y6NQfNocA6bOaeo2VL6aFcilZrpRmyDI1r/ZFGrtsgZgHEXt+G/Rco
         7Gttfb1hfkESE8Z2r0Ojigh/dd88rizLOMEw/JzjC2X0rDj6KdzYOaUgicpLl/HuqmRF
         G3NpMWqeGAR/n3w7JpXNrLRVkBJgPyzhMD0XQhIkP5qgoMf14VERUrJ9qWIVaZNxQHba
         aciqM+XA5NohCA4D3f1v8roXCKX0QT5SIr30kNRZDxAwG6Bh0pq6Abdr5Dh/piU6m9bm
         EUTg==
X-Forwarded-Encrypted: i=1; AL+hErF7fA6cnRafsk0NGTarMAHJuJoowI9qMdfBOqJg0tUdlN+ZhPDUSq6VOL5mV2XD6atRUWyDpU1dM5Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9G5viYTK0yne4J8fZgqkQRiyKKNt+5Cjm9AnREZ9g88rwilapO
	pgV6hp5A6R7e+AJl1pEHI3FFsFaBRpBIGc+ujWhwdXkd477wHqev6xm4
X-Gm-Gg: AYBFou2D0ahDPNLvy6JVzezMZjo5+k+o3KlRbMHFlsloZrpLCv68c2w9N9HBQblcl8m
	vT7lrqRIGaCEx0Cv9Zy8LvSyuZTkAwCYHhqV4AbMfll4uucL31yHZTzQrkWoWEoTIh/JMwCu8Oy
	h3DDdrGSUjWRBZH4juQyx11Vk0hHLpoAj2wSj4RFA5dhLlCb9m+wh0j6g8b117OO4TQiog8MSBB
	BKw/BkU56xqq/hbmZuFDXWi8Vi9Qpmeb4bbomqcJZCaTWulo8sly/sn6rDOJBdkF1HoP54p3iur
	NaZy5+e+MfYalxSl8PZEMZXxnuW8uynn2QfKQuZdjsH+pNraGyoMSGdQbLxuvn08BvfY3gMQ2ea
	Ba1cg+ZNY6Dn5E4833yFBpA3PPai66/49mzZanVoxzRds8OpMCgfkAR5jr1HOxS5Oksk7M4bHcu
	px7fN5xgIG+BNsbIzGeqet5zRI4itBj0FIWK3XlGCeP1bEtcZdE1npk7Z4HbILAoszN7rjkgACL
	LnYUWFQl33JweZlpiokBa62d2DXWXo3HP354Mb94W++UMd6ttLdvuvaumf/jxSiYUxSOh06b0KL
	v+i+kmiJ89DLLN2OVD+OaDMjmwk6nPuJO6rkq99USBzwD2QyJ3x8lDigXRrEmVCsOLyUUJjXcvw
	VTbPl
X-Received: by 2002:a05:701b:21c3:b0:1a5:9abb:fdd7 with SMTP id a92af1059eb24-1b3c02fdb4fmr3591375c88.9.1794446764133;
        Wed, 11 Nov 2026 17:26:04 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890e04sm20110159c88.2.2026.11.11.17.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 17:26:03 -0800 (PST)
Message-ID: <c52e7b57-9d40-456c-a2f6-545c0bca9b46@gmail.com>
Date: Thu, 12 Nov 2026 09:26:00 +0800
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, conor+dt@kernel.org, cwweng@nuvoton.com,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 robh@kernel.org
References: <20261104091136.151269-3-cwweng.linux@gmail.com>
 <SN1PR12MB2528F7F6F04801AB698A5A60A5712@SN1PR12MB2528.namprd12.prod.outlook.com>
 <avR2DaxSJJwpnWP9@ashevche-desk.local>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <avR2DaxSJJwpnWP9@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Andy Shevchenko 於 2026/11/11 下午 10:05 寫道:
> On Tue, Nov 10, 2026 at 08:08:03PM -0600, Victor Chernyakin wrote:
> 
> ...
> 
>>> +	if (!num_channels)
>>> +		return dev_err_probe(dev, -ENOENT, "no ADC channels configured\n");
>>> +
>>> +	if (num_channels > MA35D1_EADC_MAX_EXT_CHANNELS)
>>> +		return dev_err_probe(dev, -ENOSPC, "too many ADC channels\n");
>>> +
>>> +	channels = devm_kcalloc(dev, size_add(num_channels, 1),
>>> +				sizeof(*channels), GFP_KERNEL);
>>
>> Couldn't size_add() just be regular +?
>> (Question to Andy who originally suggested it)
>> We've just checked that num_channels is small and won't overflow.
> 
> While that's true, the other aspect(s) of this is in play. Namely we want to
> have the same pattern over the kernel that makes code robust (tomorrow some
> cases can be modified unnoticed with opening such an issue again) along with
> the potential of finding those patterns and update in case of mass-updates
> of low-level API, and I have heard for the matter of fact that devm_*alloc*()
> are in the plans to move to something like k*alloc_obj*() or k*alloc_flex().
> 

Thanks Victor and Andy for the discussion.

I'll keep size_add() for consistency and future-proofing, as Andy suggested.

Thanks,
Chi-Wen

