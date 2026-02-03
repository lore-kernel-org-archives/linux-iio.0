Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AD3B8BDA
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132397; cv=none; b=OC1yQzbZC3c3OwFyF5RwukVz0Tg65IiyKWffrIsf8AgocNPhqdrZ+njW3bLh+VN7hdbq/JUi7hYpIi4I8H8C6/BwBb2YweWpYqtxLzihSpGf2cAoLcdERwstCt+8ENWm7DuZ/yP26Zq0UHONtffvt25uF4e06SdJLFOry1DKDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132397; c=relaxed/simple;
	bh=5n40Muz08IMbEtfEZx3V2Ip6RkL3gN39O5tvpGBLV4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUU6vwwXi81yII7hzupjL8ALdtdVQE7bHbVVyolwttYrdCQcm/o0UHHdNH5jMozw4P2fpoMmfbJteS7NOchnh1omaD8ib9aBqaA+ZJ7I9AeZvd+1ro/zbJr36pyGaxLVb4UEkFzDi8rQtSFAcb4RCDvAXFrq/WuoPMm07IqAJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=swR8oH2X; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="swR8oH2X"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45f194e9a98so1801553b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 07:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770132394; x=1770737194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+npamYXM8+F17+5UqZREX8PEj8M1DA/ro6ZdeNndwqw=;
        b=swR8oH2X4JGoJ8w27BIu49rMDcty4zCPIguYxebfcz/qOgEmDlCyd/VHGFRpbAMWXQ
         uC7Ld49aEqCv8fwUDQt0vFAdTrMRX9L6Fn+T4uP1G3wtUZl5KfhSozrjil/af4GOCI/m
         yYZ1BdgsGWSr3SL1REQE6q/0sZdcbaT8oUuQ67jyggzZdR2/p4nHV1u5XMCn3uEim7k1
         /Dsxn2EmFxgoOSriOpjBmg41oN7NNJClRRij/vrbbLa6Ral/n97VBxde4tGh6IfaVa3v
         zhA/WpMkRpjdoDMPWGdIWp/B3Y/MLp/mPC8ePCchxy48pG6xZqe56Gq2yfEKcLaYLljV
         CckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770132394; x=1770737194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+npamYXM8+F17+5UqZREX8PEj8M1DA/ro6ZdeNndwqw=;
        b=sICsqJVBoKGaL0Wn7TsCArscNSuYpMl8LEu0ha16cCT1GvUPBHKVtOP6qo++FfUjwf
         wlKuoi0t/CqBw//wX0E5Y95jhV6M9eUNoOr1mcuftt4zzs97BvZh1iub116jxE7O+ZW9
         FiAp3YlLFu8lMDEfIzpW9DCGApqGtKFE9TQFq/H0EHqB8apftArBbMUyDqmaU0w7f0ds
         rXBGb7L6PzqmsbsRNtQK6XcsboemzYseQi9QQ0pPrx3lZWR7Jx6T2vUfWZP+2Yt+YNje
         zRhv8By2PecBHKM0FGgR/bsY5TyZYSSPOdwiYuAA+TBc5zoVhyk2+Wx7/Rd3JpKtZ717
         qgLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX1f8yBEeweVg/s3K1ccFXWn0qDtUhfwfSarOlvK8oeYqBEAPb8mEQdQxgwMSc9HUHCnWxmCW/1Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnNRFTbsqMZb0rby1Lz+tl8fcvdjjA+6rdv/O5P60temgeV+Z
	VTdx5jXYXpdNcvcsam5041tXBVA8VTzEXjgcPN3SGbONkCGdvAaVSBkkfpkgZb/AfQo=
X-Gm-Gg: AZuq6aIV2YkIRRCH3cqstWkvgWTO8GuPkurKP5Rkl4TVDwziJdJsWcaiJPstFjm8R8R
	nvXGa1d9bBadL342yCv4YXa+rAYN1XR+ZIPQauq0n90zoHB8A/JUlZsUiodAOu8rqBdb8kz49b2
	XtrDkmk5z9FO1cq16lqPFJ3pll5kfJq/9P/Jy/5hOgqLrZqG6R4h7Bclv9fdaOSaOL4818VJFEi
	nlNBDyb9/o2YzjfPszgXgpKx533g2TALOouysRTWlXTw6QaVv0U3z3AoIGdlnjgdhY2XNfohCen
	7EyrXfK+HcmyHTAVQCvnvKKvZVsdD60/fyAMju6IWvxYyH2lthWKEblYmr9pcwq+9R5DqWdIIqw
	V8W4PlRxVC+/uVAKWTIKkQIKS0G7j0TAY5xAhE8F3keSIzlMRVWTPhP45fs0gUqUrpHPQB0fo+5
	koOD/yM+3khaX388TcQhAw/inCiTK/TJnUH96/YGyONIe+Th9HGzfqFXY=
X-Received: by 2002:a05:6808:c1fc:b0:45e:801c:a0ea with SMTP id 5614622812f47-45f34cd6102mr5829079b6e.32.1770132394358;
        Tue, 03 Feb 2026 07:26:34 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e13:880:992:e796? ([2600:8803:e7e4:500:8e13:880:992:e796])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409571ae8f5sm13282707fac.9.2026.02.03.07.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 07:26:33 -0800 (PST)
Message-ID: <eeab5c00-381b-4ee5-bc4a-efc8bd59bb49@baylibre.com>
Date: Tue, 3 Feb 2026 09:26:32 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 1/5] iio: sca3000: cache SPI device ID in probe
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
 andriy.shevchenko@intel.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <20260202194033.627967-2-harshit.m.mogalapalli@oracle.com>
 <38793c4d-e79a-4896-8b25-e20bc8ecbb74@baylibre.com>
 <91ba7406-b05f-4aaa-a800-b4c8cde0eeb7@oracle.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <91ba7406-b05f-4aaa-a800-b4c8cde0eeb7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/26 4:24 AM, Harshit Mogalapalli wrote:
> Hi David,
> 
> On 03/02/26 04:31, David Lechner wrote:
>> On 2/2/26 1:40 PM, Harshit Mogalapalli wrote:
>>> Store the spi_device_id at probe entry and reuse it for the name and
>>> chip info instead of calling spi_get_device_id() repeatedly.
>>
>> Even better would be to replace spi_get_device_id() with
>> pi_get_device_match_data() and turn sca3000_spi_chip_info_tbl[]
>> into individual structs that are used directly as the match
>> data pointers.
>>
> 
> Thanks for the review.
> 
> Jonathan also suggested this on v1, but thought of doing this item separate to this patch series(as its a functional change) , would you mind if I do it in a separate patch after this series ?

I'm not sure why it would be considered a functional change. If you want to
save it for a separate series, that is fine. If we do that though, there
is probably not much point in cleaning up spi_get_device_id() first since
it will all be replaced anyway.


