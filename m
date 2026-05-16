Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EA346AD5
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778974507; cv=none; b=lPYU+A754jI4MK8hZShM4EIcSQuSMKXgf30m3PzlqAlP5O/+A2TyfcHFmLWT//pscjxLxLE9BeEaokxAHwpjJte7/17TzjpphkF65HNHqfroycjOMCGCYNKtNydOA29b8/QqwbLHE2WV2zDzPgNNSaaAXgrc2xPBePtQ+PlhnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778974507; c=relaxed/simple;
	bh=cZLAY9u9FlZnFtiU5MVbschagyVZHDauu8/rirWUUrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cj/xXXeHekwQYZVAhltVQSXvGNaPhJG4znFNEWiDBu+NVexbsSj3vh91NSZjZdY+cdG9cgj3O+x/WSaawkOhqjb8Y4smsZBUtuojVLjId3uLSf6H3VAaxDtIKpfT7Wy2j2hB/HwdEDYVvd/nuzCSeuCD/G3kreL6OFLYh+U8X1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=pZFHroBO; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="pZFHroBO"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43587e63a8eso697192fac.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778974503; x=1779579303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RR+I8tSn9ph6Vb00Qgk9jV6LJ7ZGJ5ksY4nEt34vP/4=;
        b=pZFHroBOs7oOJD1LbeQprCaQj3ipW1VR8ynVs6OuyYPiAeKE5udHF5qfA3SKKoLQH5
         HvBOMpgeuYoyUz9C8rfPSwvYOcIqBC5JyzZ0htyI4Zbh36KMNJRRmC44TUCYfZ12KoV5
         Jsdk35ANVwG6oYpdNhe2mjlCRSEdmWjdyTAoUp7UYzOGFiUlxzt9s1oSyg3o5FlxpDQF
         DIx59AEvXsA52WqwpkDUKU7Rll8XPuEUelRPRUG4Qa9ctogH94sNR73Ll7Ru4MbOkwjZ
         BT4T24+QAVFWVm9SSDNIrEh+oo7oINRUEZwemyvjY5knJOgNdHK2FrrPppfO6HG6vDJr
         P5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778974503; x=1779579303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RR+I8tSn9ph6Vb00Qgk9jV6LJ7ZGJ5ksY4nEt34vP/4=;
        b=s4chFfAtZ7aN2H6vXn2P3LP02Fd8IEceiRuHRKRrGU01h8EysYPXC2ATTCjUw0jAak
         IgKUE8Q/vYVoMN3tTklDUkRi5+7FV01QWz0FdiLWMSuIH2XumQSgzi771LO9h8KrI2BZ
         CCd4rQNLwq7MhbTtG0Dp4hFnwOXXZ7vmLBAcGu23IC7si4W76qddtGQBoXBSSBU4Swe3
         oh6//4bMNCfaBrcTVu7redBPjm/YTaW5qspWIQ9mfJDWG1h7M6CvZCoa61EEfw3W54Yb
         sZWhh/j0zFYyJzEd9v/YjKkVHgq+wCQObhCBrRiISMUeMpwHHzkAeGvM3JASP+4zoSjN
         F2Yw==
X-Forwarded-Encrypted: i=1; AFNElJ+301tw6k2WFP38ASqX75gtiHSGOQECUEYvc8UNShGRSo0bUq1Aw8KeqcWyT4qyovfb+6bth7fjGqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3Z+zMrDpkuISeK6G9EN2HE/4VG6tfXeI/zSsk3xqbV12tPXI
	gOJSAy2ZSGyI7Uuv1DdrR/ahFU43oP3DWgZdAeQgDTjRrUDNuxfMb0SpJFVqX06RXbU=
X-Gm-Gg: Acq92OGfYBs+IDSpkc3MKler6tw29Sp1gH43y02wBJh1FoEb8IUhZqBZCxSAEjkNcuN
	tDZa/s6AB6+LZX7xWS42QAGf2KW8c6CPerfQNrwTF4cl3wOUL2s7iUT2jj1X9Tzhwd7oVGGJTqw
	anYUEzibUlsvFnJ4mXk1AJp2RkGpIYl8+sAgKCI9qjG/8GH3sex/PmAane5Zr/Goj1ZLB4aTGT9
	B0Wi2tuGZZo0/plWonAKZdPfysvnvH0F5iLDY/6kkZWvTc4axKIV5z1QvA8I2rjLhqKLJEZDUT2
	CrqjMLOvXKlnq/eWKSmJ459y9e3/yDrR4J3vc+HRfe3+PzRK9TU8KjPtNfBzVv44lDPE2/ACieL
	vHHSz2EEoc9CToyqEGgeVwuNLIyWqjy5VbjoVocNEH26ABMe9jGv73+dY4Sr15XIOVDb20R74SF
	GBYB9AoOqfvBz7JLjijFCHepLumDiI4miHZromMjXu7K/QfGwPNCA3XCLQsLPn73U69749ZVe85
	w==
X-Received: by 2002:a05:6870:6492:b0:435:bb5f:5e4c with SMTP id 586e51a60fabf-43a2def7be9mr6229898fac.21.1778974503349;
        Sat, 16 May 2026 16:35:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a957639b2sm198583fac.14.2026.05.16.16.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 16:35:01 -0700 (PDT)
Message-ID: <db325da7-e87d-4dbb-ba14-cd864a52bb5d@baylibre.com>
Date: Sat, 16 May 2026 18:35:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: accel: adxl372: Add timestamp to FIFO data
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
References: <20260516211935.36773-1-shofiqtest@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260516211935.36773-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/26 4:19 PM, Md Shofiqul Islam wrote:
> The driver pushes FIFO samples using iio_push_to_buffers() which does
> not attach a hardware timestamp to the data.  Capture a single timestamp
> per IRQ with iio_get_time_ns() and reuse it for both the event push and
> the FIFO sample loop.
> 
> Use IIO_DECLARE_BUFFER_WITH_TS() for fifo_buf to guarantee the required
> s64 alignment, and switch the FIFO push loop to
> iio_push_to_buffers_with_ts() which accepts an explicit data size and
> timestamp without requiring a separate scan struct or memcpy.
> 
> Add IIO_CHAN_SOFT_TIMESTAMP(3) to the channel spec so the IIO core
> enables scan_timestamp and includes the timestamp slot in the buffer.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
> Changes in v2:
>   - Use IIO_DECLARE_BUFFER_WITH_TS() + iio_push_to_buffers_with_ts() instead
>     of a separate scan struct + memcpy, per review from David Lechner
>   - Add IIO_CHAN_SOFT_TIMESTAMP(3) to channel spec (missing in v1)

There was other discussion on v1 that said adding a timestamp channel
to FIFO data is not practical since we are receiving multiple data points
all at one time. The timestamp will not be accurate other than the last
data point in each burst.

Did you respond to that?

If there is a good reason for it, the commit message should explain that.


