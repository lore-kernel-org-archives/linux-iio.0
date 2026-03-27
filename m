Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481083EDAC8
	for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619658; cv=none; b=rxuvnqTxec1toQerokjuBMM3LqMMElicOFW0PxEMFQBglP6wR0vROtqVtmfTrS7MnMdNhbuHRvrGML8K8SRGoMMllMs4zx7hznARbaiyLk+XlzoVKk7JNuXF2z0QKYLIGF+a1mNggb8D2CtnPitGExd0Fx9S3sPRX+MFjM4/ISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619658; c=relaxed/simple;
	bh=F8nqQtP6HknANaBoPAe6dwl5ApJC8kya6guOXtyTiPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6P0tzmPcrqMGwAkhkrThUSDnlvxhnAhBdiLSuSrID7augSo0c4a1k3sS2JjQKYDgaikVFigwrgVhoy7wLR0Joyr6tdHOvOH1F//ltthwCt6PI0eYj1Iolz0zUKmdX3dAOieUURm0N/MYy+vbsYasGswNmiskuAtz8MAgVRpr9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qdqYil7l; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qdqYil7l"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d8b2703f37so1898599a34.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774619654; x=1775224454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsiRzlu0kDThiDmUQXOxPDfKN3XDauB2BbTLDlcDoZY=;
        b=qdqYil7lFWwQkNZJ3e8HhdhONsP3EXh37kz47wka1qwIxUZonaujjsWcMVyldUbFnx
         tvUoDOL46FbApR4XvgyzxIejZ0TJES7zxzdkJeaI099F2YbRwJ7NEX7i3GsC3vwEJtE8
         v0fLXgXPKbGhUpHuT+1TiOWN1XuSa4/byLp4gPKyBRdCMYj7vx27kJB2kxg/+7StpDUa
         ymG326PFl9vBXvXxoyUF+8c4cSlFkkJZTcf9cfl1DpwNscw+YJf0NaFhqc4B7zqeDYn5
         QrK71+7gKCB/vsPbhg1QIaoAAFd4WkmPCYxpfSQo0GZXFaTe8ntRFpxUEr1VjhdwrEwz
         tscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774619654; x=1775224454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsiRzlu0kDThiDmUQXOxPDfKN3XDauB2BbTLDlcDoZY=;
        b=MCpFURO2tCMM6eUfNsUWmyq/pg/fVzw+WjkRwtuWU4r9nsuUuiK2O/Kf7lHqJGw3cp
         0Jo5bsRtksqsTBgx7Hth7gLzud/+2zkr0Zu8bpcRE5Q95dZEvDHlKAXDRemuFyoO1fVm
         XuLGyn+GU7I8acKaALtARC0UpsMQmJoUZuPpnA5aGubV+dcj6LEYnXk2WH3BdCdPTCcx
         dId5sq+rWdwGp8otrO3jp7fBrBaRFObmbTa5v/qmS+fNj2Q2IMj3qW4oLSVK2myVIGck
         EiHLKQss6mmVfiT+Y2nSqEFxDFejrWuj0x/ANlvWWr6TP4h7BGFqM6TfOm3qVerX0Ehs
         UQNA==
X-Forwarded-Encrypted: i=1; AJvYcCWk9gFcHYrfS9u3xIq5yWlr7C1/UH3pps4wKtT3ma5bw5SK18wI2GxUU1XhhN6mxGDSoFQLHDNSC+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49KXZu40blPB1YWFfviSelvzFi0S5daUngiV8ZCM5KirDB+on
	xHZha8RFJkIHzc2CDomJ85PBYW7bs6nS3DnAgFiVWTQkXxmtKdemeTi+vsAGKnDoodY=
X-Gm-Gg: ATEYQzyu7p6mT4SVNk2wN2MSQEp7lNax50mvjyVJE2HF8NOzNTV3x05DCjLsUUH8xJB
	sXR0aDSq2066p8FPJBBC8cYfwvncFl6aLfnzy2Io0AXKXO23zMUaV338tnufyxVvIEuhIgMlcu+
	4sajmGdW3fBftgCZJ/Qe4j/WG4VObR6Qy8knPcbJ9sGLnEOQXzeltSylG4W/dj+kkAkUnUz6Zfo
	pIsSvXciStqKq5Ji95tYqbK5kZn2X86QyoMBNohtl56P2oVd+eIGRiaMDmuABz17BWDJe/HWuAG
	BFFW9B8eK6VHFhk/Smu2wBZPbeOWxHpoLJstDUa5Ct2g4Ja/uOJbNBU1YMPb6R5QuF0geskR/5O
	SpNpXmLJ5VaOJhcKhLVlGDRBJRHaPKUe+d/EQcQ16gVrZZFqp7OOF6pmXalALdDUrQhAeKqQx5I
	bbk7QIBpPwOlj2yf7vrkyUmILrrRpxujJgqrypt1EhFOBcbMMASTGHtLG2KsSDLQ4pSv69DThBl
	A==
X-Received: by 2002:a05:6830:4392:b0:7d7:f617:3573 with SMTP id 46e09a7af769-7d9fadfd5a3mr1377794a34.10.1774619654222;
        Fri, 27 Mar 2026 06:54:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99? ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e724e977sm4787166a34.22.2026.03.27.06.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 06:54:13 -0700 (PDT)
Message-ID: <3558dc31-e998-4a50-9732-0ae751b4fd7a@baylibre.com>
Date: Fri, 27 Mar 2026 08:54:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 kernel test robot <lkp@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matt Ranostay <mranostay@gmail.com>, oe-kbuild-all@lists.linux.dev,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
 <202603271734.pnWuSmNr-lkp@intel.com> <acZRgSH2Vvmm1Usg@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <acZRgSH2Vvmm1Usg@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 4:44 AM, Andy Shevchenko wrote:
> On Fri, Mar 27, 2026 at 05:13:16PM +0800, kernel test robot wrote:
>> Hi David,
>>
>> kernel test robot noticed the following build errors:
> 
> 
>> All errors (new ones prefixed by >>):
>>
>>    drivers/iio/adc/ti-adc161s626.c: In function 'ti_adc_read_measurement':
>>>> drivers/iio/adc/ti-adc161s626.c:87:24: error: implicit declaration of function 'get_unaligned_be16' [-Wimplicit-function-declaration]
>>       87 |                 *val = get_unaligned_be16(data->buf);
>>          |                        ^~~~~~~~~~~~~~~~~~
>>>> drivers/iio/adc/ti-adc161s626.c:94:24: error: implicit declaration of function 'get_unaligned_be24' [-Wimplicit-function-declaration]
>>       94 |                 *val = get_unaligned_be24(data->buf);
>>          |                        ^~~~~~~~~~~~~~~~~~
> 
> + linux/unaligned.h should fix this.
> 

Jonathan caught this already [1], so should be fixed already [2].

[1]: https://lore.kernel.org/linux-iio/20260321204506.4b5df02a@jic23-huawei/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=768461517a28d80fe81ea4d5d03a90cd184ea6ad
