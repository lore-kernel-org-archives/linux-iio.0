Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6033BBD2
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664181; cv=none; b=jRdOEwF4sKEDBjDiJLZ7KsAI7zxSFp7TE3Heoj+95Fkcqnzujz1USsYbYqTBsB2EzFQ4rz6+oKOod1YtaX1Ktm057SYn9UPRw/jtVs4jmAQgy50ps4Pw3TsxSmzdUafKF49v60A1nFGvxgCyoSca60ZWedf19YNbYYSgxFt+7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664181; c=relaxed/simple;
	bh=rBCozInSjW011y2KpSL8Y3DDrbPK8IaIa6GK0bYlops=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4xL2pwm2og3UmaxHnQaVa8oa4rH1iXuhKoS/cTeB1pty+qSklW3MiXi7pYYbqSPBF929vpk5ifQCJcVNoZKS8XiYYD3/zxio2mzCw22TrLakf1oVOsi/OVjxvvf+AjxXNUi45EbIJUQqvWH3+BMCbB3XTrdHCp2idn42mBPkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qETN7MAP; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qETN7MAP"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4be7c4ebeso3689161a34.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772664178; x=1773268978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYkJqj9b67Te3StQAwfzR33xU71lrHTNEjs7SXgCrtg=;
        b=qETN7MAPsyTFvp+AX49GF9AYHdC5tvSJ9b/efn7ctr4zKMiQ+zvPL3Z68qafK+Ul9Q
         gTR/qgRnRUYY7nls+A2lBFgb0YPmRs7/z1YckVFnU6eV28R0D3tVRoX6zIs+J6KkWQVP
         FdLFKKZN9Ffx8FidVZye49ww78g8MN6fiAx4yTuXRpfzBs2FFHDUYsPeWz8yY+XbyUzy
         MQ33hcEzFrf/9OQYhtp5Wt/O8sxgnA5iJTuQbW+NC5lKBJsJezujARFk0KKRkJVw+W81
         5Urx0GQdyt9aiIHQOIxGP/DV7EqvHjQ3Rs+KXv8DUbMPcW+a8kr2iXeOH3mjHrVLwImW
         oeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772664178; x=1773268978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYkJqj9b67Te3StQAwfzR33xU71lrHTNEjs7SXgCrtg=;
        b=KPjkOMny/+KiYMQnLGa9npMjnlUZeQv6AxEt6DVa7PDGiYsy6KUYSdyzMJWg1h0hWD
         0AgU4PjqbmbCNjtY36dM/UYUQkcPdjpqqXbS+lNcDDC0hZQ7zYqEhPxAV/UMKegAW2n4
         yxskiuuvuQZEpvVp+kV4VK862CJ9yx0pQhJ7N2oVWpOP0rFy20vUSKkFVprHYDxLByq4
         LA1nT8Wy5Sgm+cQONjIodFdYjxKeKefHPuLVc2eSMfX6YvT3v3vk8t/j3ZXSNyauOoSB
         oWHz82tlgCLVECMqTKwGpSqT+14zWBU8Qofi4xFqJjm68IADXpdKEXwyuvrfDSLSUBrx
         Pf1g==
X-Forwarded-Encrypted: i=1; AJvYcCUKrL3HBn/wV/JcY0xPZ8YeFqkJ9Wgh9E4vAGmyqGnLEwB0abqpvCD2UDO1/b5ODafvBekFAeZlY/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9au9Ap7uRcCXm+SpAkxZ1GghPA5IUYdhhSAhhsZT2SBRUB5Ex
	DhgXLh3FOn6gAobqHPW6Ta/BY/nKqPJoTxirS3PGZNF5/RVhL+tGQWMRulraSqyoyw0=
X-Gm-Gg: ATEYQzxS/YF3WaRNgDqTQ8AArvJ2j+bLbJzzJgxCZyjYH/n0zbiN8RNKJzdGfWTrIqn
	oPKecUXtv/RBTBY3i492gS67leXP2sN+2pLvTic9JDR+AdFmZDViUfB949j+ekZ0I+6FmHPiaQO
	179uTedlczkbgA+1xa13Dbtbmy+U4MKGkvMdmljZjx7IO6VFufnr/VoKiaM5cTyjwlxJbFBEIs8
	H48SyUZKBU5T6e9rnYbQ3eewv9WgOrvCmKrWJLLrA86pB+M72Q7EU3k8r6mRoXa1qwZ0Y1L4O+4
	eW1XVj7kjdBogR84IfmZ8bmvU3IQa9uht7LRaPOQUBp7WuancHyDaJbkRPmOehr3VfYCSD0HMGm
	X+WeUbpTf/Q0YruFIYfUqhPi+9pU4S33BafyVkr1PE1blryD3H+LtzZ1qYj6c7O0c2l6dDcTe20
	XavqtIhGP7UnoHgN4XnJHv2lJvAZVyIB0ysf80VdciSinNNUP0s/fAZZNwtXxXsVcC+8JFboPMa
	A==
X-Received: by 2002:a05:6830:3148:b0:7cf:db0f:c824 with SMTP id 46e09a7af769-7d6da1fd4d8mr2760368a34.32.1772664178654;
        Wed, 04 Mar 2026 14:42:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d719:8353:352f:b2e0? ([2600:8803:e7e4:500:d719:8353:352f:b2e0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58647b17esm16578628a34.8.2026.03.04.14.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 14:42:58 -0800 (PST)
Message-ID: <ae79da24-1129-461f-a8ff-9dadfc863fee@baylibre.com>
Date: Wed, 4 Mar 2026 16:42:57 -0600
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a265489380e7abc9343c536185bc203688c5bd29.camel@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/4/26 8:21 AM, Francesco Lavra wrote:
> On Wed, 2026-03-04 at 13:51 +0200, Andy Shevchenko wrote:
>> On Wed, Mar 04, 2026 at 09:07:05AM +0100, Francesco Lavra wrote:
>>> This modifier applies to the IIO_ROT channel type, and indicates a data
>>> representation that specifies the {x, y, z} components of the
>>> normalized
>>> quaternion vector.
>>
>> ...
>>
>>> +What:          /sys/bus/iio/devices/iio:deviceX/in_rot_partial_quatern
>>> ion_raw
>>
>>> +               Raw value of {x, y, z} components of the quaternion
>>> vector. These
>>> +               components represent the axis about which a rotation
>>> occurs, and are
>>> +               subject to the following costraints:
>>> +               - the quaternion vector is normalized, i.e. x^2 + y^2 +
>>> z^2 + w^2 = 1
>>> +               - the rotation angle is within the [-180, 180] range,
>>> i.e. the w
>>> +                 component (which represents the amount of rotation)
>>> is non-negative
>>> +               These constraints allow the w value to be calculated
>>> from the other
>>> +               components: w = sqrt(1 - (x^2 + y^2 + z^2)).
>>
>> Just to double check if we really do not have a special mathematical term
>> for
>> that already. If we do, I prefer to have that over odd "partial
>> quaternion".
> 
> A quaternion is often represented as w + xi + yj + zk, i.e. it's composed
> of a real coefficient (w) and 3 imaginary coefficients (x, y, z). With this
> notation, the (x, y, z) components are referred to as the imaginary part of
> the quaternion.
> Alternatively, a quaternion is represented as the combination of a scalar
> value w and a 3D vector value (x, y, z). With this notation, the (x, y, z)
> components are referred to as the vector part of the quaternion; this can
> be confusing, since the quaternion as a whole is often considered as a 4D
> vector.

I'm surprised there isn't a common name for this. When I went looking, the
thing that came up most often is that Doom 3 used this in their MD5 file
format. So maybe IIO_MOD_DOOM3_QUATERNION? (joking)

I do think we could come up with something better than "partial" though.

My first thought is IIO_MOD_3D_QUATERNION since it is a 3-dimentional number,
but I could see that being confusing to some since quaternions are generally
used for rotations in 3-D space.

Maybe something like IIO_MOD_3VALUE_QUATERNION or IIO_MOD_COMPRESSED_QUATERNION
or just IIO_MOD_3QUATERNION?
