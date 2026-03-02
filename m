Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA69411605
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466127; cv=none; b=UCU788S6JZj87baQDWGWFj7k9LixAh4Hae7lvUBPsz/eiuEW4BAbApHazPCcPusk+6kNV3fbJoC8OJpwBqoOSMEuQOXRZFcM/qcN8sGH1XSi3ixm3kjmyzNu23skoY78cqJPWO1nm+ZBhq2GWl7W38gHwW4DISXWCyH8c2lmv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466127; c=relaxed/simple;
	bh=Jn9c+KGqkB5IEEgQ8xFuEVkc0BUaJBYfMDD5OERKj0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2mLNH7ITE7ds2kmCDxuCn3LrizQNfz0j0TbFoZ3DkIejO1ENp5HU9lg7KhMjzrGw6UrdOxOLvoBjdst+grKD2/J8Y2i9V7wqLF9ppmM11Tw0RxdBoC4/Xfbb5rcwxjI2eNUK0AOuVw93KNl5JOrpNuCIMjvtRYKv/PlmtQ3aac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0w06So9t; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0w06So9t"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-662f2fa7e67so1973007eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 07:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772466124; x=1773070924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQaLSLcNcp6ruIogCBUfZyPg9rcxUfqwC/rj6FLhb/8=;
        b=0w06So9tGopQQYjC1XiBoLqlkMGyWOqlZrXraRJKInPCess/Q9McjDbvVp4LoqGlja
         DxiCj7PGe/Pys4Z7BnF0mg3vfyEpeNKH22my7Ek+z1UEaHofwU/Up6vqslnBbnEuNgPu
         SU1+k4vLalictbnn3tSAVPYYhAh0rvSd5hocrxKrup/YKCGsMADcAYeDyuws77T46tB+
         0c4qLU0kNShPbzdbnN78OM4Ba1+fpDcxdoERsVCbUZXVFqbBzUxnGwEh946eVlM/t4Um
         FLfmb7IB6J3uJrNNBcF2Nc2S17VNScPdB/FhEXQq3/ZLCDpjaEJ5KMEDLhpzMTwqc+Ha
         LV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466124; x=1773070924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQaLSLcNcp6ruIogCBUfZyPg9rcxUfqwC/rj6FLhb/8=;
        b=xUBhvb//ZTy4j+uqLVdqEEBrYH8QJAmTaV15V7acAHTEceBYf7nvksr1oAzeIohwBZ
         l3mih/mlGd7ritsRP35PRCAM57mb9XXyGlVlCzuV+Dw/+BwSWlgIVpyT+6kuK8ri4I6J
         L700FwtpyqIn0uyFEVkPWdk5leApuRFQZFE1sB/ogD+S5Vg5RMebTlMo442AKLgiKgAN
         8nf6zf5GF+bKjWIOuv6JPPSx5sBaSUJqpTP8uzoqOVUpxXyMd6+L/p/v+czwXxx93erA
         H8U6zKKEgMv60YWq2NbfmLzO60hUZ3GccdAQhBGJWhek+ZitU0JEH4Bz1dkobEmOHTTu
         bodg==
X-Forwarded-Encrypted: i=1; AJvYcCVsTBYvkoAoYQ3GcEBTn1H1ja+t4Yl8VtGX0Y0krD6Cf6iJ3t3F626BfrDaeZuIcgVGWDvJlvU/KbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPKHYfd6GphGiuOY2PX5R9tCTeFWyufA0uo2MLdePSgB2IJxD
	vdqlQRg+fRG52qodivgi/HeHcqHXbDJzSinFrsWREvp9yUbKd2gm6ViIu19vTlmSkm4=
X-Gm-Gg: ATEYQzzeaukrnZs9A6Hqxct+RaKJwY3gtBzzUMmXL9sDoh4RB4k5datTu6hjKu7N3Uw
	ZdXauj0FK23xjJNa8OqJJ35gTfMx9ZcfkyXp/f02umtcL7ITGerwAxuaRP2BnMdX0yEnEyPu7ND
	eIkMcAJ0FpjI9lOp242o4+C3+nWr3k8dvlkmKlnQvbx82lKJiinIQcDkXF2M2bRietFbBGWI3i5
	5rCOkJbKYaSzK/ytpfgIDQTE7FGvhlHk4ekAN2+Ez5d5BYyEQLN6gPzVxIOMYgc27itShM//fpp
	ZrVn/zH/RZRVkqNSVBaIzr8GJjBrdH4J5jWuM6fqWN918ZzTuQBp2pF7e2eM2Ae2ETKYvGG5Ucg
	HX/lYhUGNtz9GW+mtHFrW1JShZ9MqyrIDuc42mm/xHSn90lf+AOQKrX+t19bFldfdl2FlS0koBe
	WNMM3XhAZcyE8TshMjrMaE2T1M4x56MEP0DvRZPyTjktb1gyNiSFI0WQ4Isihfk6DKdEcfr48Yb
	50woXQlN1xC
X-Received: by 2002:a05:6820:f024:b0:663:b63:5aad with SMTP id 006d021491bc7-679faf54744mr6710378eaf.53.1772466124365;
        Mon, 02 Mar 2026 07:42:04 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2be9ab7sm9163410eaf.4.2026.03.02.07.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:42:03 -0800 (PST)
Message-ID: <a7078fba-af96-4d77-8b10-35a31cb364ac@baylibre.com>
Date: Mon, 2 Mar 2026 09:42:03 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: buffer: fix timestamp alignment when quaternion
 in scan
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
 <20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
 <f481f4ae4d9545bbb186e51a1204ca2d65b74a26.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f481f4ae4d9545bbb186e51a1204ca2d65b74a26.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/2/26 6:04 AM, Nuno Sá wrote:
> On Sun, 2026-03-01 at 14:24 -0600, David Lechner wrote:
>> Fix timestamp alignment when a scan buffer contains an element larger
>> than sizeof(int64_t). Currently s32 quaternions are the only such
>> element, and the one driver that has this (hid-sensor-rotation) has a
>> workaround in place already so this change does not affect it.
>>
>> Previously, we assumed that the timestamp would always be 8-byte aligned
>> relative to the end of the scan buffer, but in the case of a scan buffer
>> a 16-byte quaternion vector, scan_bytes == 32, but the timestamp needs
>> to be placed at offset 16, not 24.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> To test this, I used hid-sensor-rotation minus the first patch in the
>> series so that we can see that the timestamp actually moved to the
>> correct location.
>>
>> Before this patch, the timestamp (8 bytes ending with "98 18") is in the
>> wrong location.
>>
>> 00000000  6a 18 00 00 ac f3 ff ff  83 2d 00 00 02 d3 ff ff  |j........-......|
>> 00000010  00 00 00 00 00 00 00 00  5a 17 a0 2a 73 cb 98 18  |........Z..*s...|
>>
>> 00000020  ad 17 00 00 6a f4 ff ff  35 2b 00 00 ca d0 ff ff  |....j...5+......|
>> 00000030  00 00 00 00 00 00 00 00  2a a6 bb 30 73 cb 98 18  |........*..0s...|
>>
>> 00000040  92 1e 00 00 50 ec ff ff  ea c1 ff ff 78 f0 ff ff  |....P.......x...|
>> 00000050  00 00 00 00 00 00 00 00  8f 3b a7 39 77 cb 98 18  |.........;.9w...|
>>
>> After this patch, timestamp is now in the correct location.
>>
>> 00000000  55 0f 00 00 dd 1f 00 00  af 0b 00 00 ec 3e 00 00  |U............>..|
>> 00000010  c7 17 68 42 6d d0 98 18  00 00 00 00 00 00 00 00  |..hBm...........|
>>
>> 00000020  57 0e 00 00 c8 1f 00 00  d1 0e 00 00 42 3e 00 00  |W...........B>..|
>> 00000030  56 a2 87 48 6d d0 98 18  00 00 00 00 00 00 00 00  |V..Hm...........|
>>
>> 00000040  a3 e2 ff ff d3 1b 00 00  0b c9 ff ff cc 20 00 00  |............. ..|
>> 00000050  27 59 4d b3 72 d0 98 18  00 00 00 00 00 00 00 00  |'YM.r...........|
>>
>> I also tested this with a different driver not affected by this bug to
>> make sure that the timestamp is still in the correct location for all
>> other drivers.
>> ---
>>  include/linux/iio/buffer.h | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
>> index d37f82678f71..ac19b39bdbe4 100644
>> --- a/include/linux/iio/buffer.h
>> +++ b/include/linux/iio/buffer.h
>> @@ -34,8 +34,16 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
>>  	void *data, int64_t timestamp)
>>  {
>>  	if (ACCESS_PRIVATE(indio_dev, scan_timestamp)) {
>> -		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
>> -		((int64_t *)data)[ts_offset] = timestamp;
>> +		size_t ts_offset = indio_dev->scan_bytes -
>> +			ACCESS_PRIVATE(indio_dev, largest_scan_element_size);
> 
> Given that we're adding a new private member, maybe we could just directly cache the ts_offset
> in iio_compute_scan_bytes()? Would make the code a bit easier to follow IMHO
> 
> - Nuno Sá
>>

Clever. :-)
