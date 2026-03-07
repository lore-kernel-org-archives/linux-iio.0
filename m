Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F43A4F39
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772900866; cv=none; b=M87Trs7xd9hroAG82GQPCoS7WrpZR+p3N5DG4oxAPOlzWQRabV9buCDKyO0trCbwNTWlyHlv98oRRSCUGQaeldyOaYh7kWsEVQZp01oTg4ogxKMxMTOJcA4QZ9BY0NjPBJiioO3/L58na+Xy1EXnWrB00XZrV3Vub/dkFQFCmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772900866; c=relaxed/simple;
	bh=2i0EJ63RpRjxcMnjm6qCcEuhBgw382Wkin5Bb311vr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAoOvSYXv7kgFr0VRayJ/130SoMxXH9LFrO2pGZ5U87aFI5EOq8WcIsj7abvkR/HOvEIFYpgOgcxYdFel2SfWypStDgR12Den9nO0sjwQYwbf2uPO8xVuMpvge4a866KJFoLthBo39cqPKSENUHxw9m+PAFSFyyWQiZz58qqZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RTlQtQXS; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RTlQtQXS"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7412cfb9eso92457a34.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 08:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772900863; x=1773505663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBl+rXMC2e9uD/KiX6ObM2tHYn9ZVyslTh4HddNRzfU=;
        b=RTlQtQXSkOWFk3rZ4WXKlw4RVL9tA/Bhur5EFWo4lHokUdcDNdOE4UWRVyTyAMFZup
         ArhfnB2Vq2djXUcbp5GodOEeWxRGGgt7Jjtnkvf2Vk21VGxJnAUV52aPXNXBJ45jOzO2
         +4XJV9cD3n8yV2hhcwuA/pTd08DTDf6NET9TKaFXq+5fngQemXKSy2TSLttQVBBdecP+
         VWOpYofUhoIjDGJJzkmstoFcSq6DuzRXWsNFVrt4dTfC3x8wK15RvdNc/YIwyjabVCpz
         VYXG6QDnAZ/IK/+XWeiGcJoZwf2hFgahWTNZOndEIJIISHxv3UCNgutBl+D9EQJWmvIt
         4Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772900863; x=1773505663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBl+rXMC2e9uD/KiX6ObM2tHYn9ZVyslTh4HddNRzfU=;
        b=cspVbPrhqSxNiezzAT3hUPeMqaylMOJmt1JBJAWdIkuuby0taGGd++4FvF/9GdHvD1
         u+UR4VW88Di2Q1shIW26IS0a+8bWU8QQO89JQoNnManlhSFKmSfzxJIjVKEp01VP29KW
         7yQwkY1gvPkgxFg7T5U58HXH7dCaGZAZyW/QYXDIS5X/ehwcVc70lWG4OmfTrQ9LHgCK
         B7iNVfAwo3biX1pLgRL7G+2+0QTN15DkH8wS11wJPVh2r+YWmPs+o4Mpnwzu5FQ2su9Q
         HlRpQ6xA+7Fd3s5I67urp0ttfF6LDQMOUZLWwPTNtxOJGvDczCopwIeqhb6oYJtSAeHf
         XreQ==
X-Gm-Message-State: AOJu0Yy9t3uJPPunFmc/XrmjwNHxZ9sCmIzdiiwViZv4n+B+HuFuGLpM
	ALeOLWa2Ob6f3U/J1vbxYo8pgPj/t322FKSu54fK6kO0Dv7eCkNK0qfmMWMZEQyViEI=
X-Gm-Gg: ATEYQzw5lGW3MDOU8n6X7eX9vt42lQkz67wSI7DbvzVyMLYsaq2XV1l4G6AAVAbE9dY
	JGgb9vIs6BpOWiuDGhNUfqDyFJS/LOgKn/Fd7PmZ0KPgPGclpsVwf2c52/VVura2hIhpROelzJ0
	CwPnFsHVNFQkVPDqZf42JeEExmPnOnkW3zyHskU04nsQssj0joiU2Phpwo/fj8fpwLfir0zDVp+
	1Cl4kNsveFVPmJ+TtySJ+pUydZYMB/BWfqQhTwY0YY6QdaXH1hUupDJ2RKtj2YVs+KLqrE0orgV
	+Mb8ozu5YyPexCqYDSuMHenSRHiqEgxh2vg3/ejICox5Kjdp5r+OR6QKLh/5BOzQHLHiHQzCSUF
	E/obEzWBJaO/5jl1u89sS/cOiQOBOPxm/N4zSylkz43UsSB8i335lBnQyMenaYQrxVWqQ5DbKKp
	14FYJ6VMBY/9cYjOuuz4ol+Sm69okgaou8bVCdxnKeADGwul0bkPePvCjV/jjvjx1Y8ryTlj0UC
	g==
X-Received: by 2002:a05:6830:620f:b0:7cf:ced8:b5cf with SMTP id 46e09a7af769-7d72702f122mr4013656a34.26.1772900863067;
        Sat, 07 Mar 2026 08:27:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d728c5b75csm3319349a34.2.2026.03.07.08.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 08:27:42 -0800 (PST)
Message-ID: <18438082-8efc-475f-acde-be3cb313f2ab@baylibre.com>
Date: Sat, 7 Mar 2026 10:27:41 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: ad4130: add new supported parts
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, cosmin.tanislav@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
References: <cover.1772078999.git.Jonathan.Santos@analog.com>
 <1d5baeec27724a1c8ebf909c29c3599d583948a1.1772078999.git.Jonathan.Santos@analog.com>
 <aaWH1wL8odeCmE6w@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aaWH1wL8odeCmE6w@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 6:51 AM, Andy Shevchenko wrote:
> On Sat, Feb 28, 2026 at 09:39:04AM -0300, Jonathan Santos wrote:
>> Add support for AD4129-4/8, AD4130-4, and AD4131-4/8 variants.
>>

...

> 
>> +	/* Triggered buffer data structure */
>> +	struct {
>> +		u32 channels[AD4130_MAX_CHANNELS];
>> +		s64 timestamp;
> 
> Use aligned_s64 type...
> 
>> +	} scan __aligned(8);
> 
> ...instead of this.
> 

This is used with SPI, so it actually needs to be:

	IIO_DECLARE_DMA_BUFFER_WITH_TS(u32, channels, AD4130_MAX_CHANNELS);
