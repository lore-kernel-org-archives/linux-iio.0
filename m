Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A134CFC3
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691018; cv=none; b=lZMlq4qfYEb1lnBlqE73C4p6YOCTIfK7aZdFb/AIkSXiGVYgnjMtOdP5UAGiNa51KE4CKTidfP/znrgvmAgJdKJUbu3UjWgXcFz11tk7xf/owgymO/XUpMEme/YJkPK6AZdkuDl9iR5DQTXHY/bYO+/2pkSz+HwpJJqUGZ9CDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691018; c=relaxed/simple;
	bh=ArJd7HrU909urH7zHvCJ4xaUBXk38BgRRNYSJYgMqF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Llh3goiILiNHvMQVW+kUb446i4I6okkllS+rnMi7KpCy44/m/3YK2MmyYX/bWFMAZPsZrzhHnsqiebxG5nEtuDCKsDI+HhbJ6PFEO19i3SZ0yzFb12SAnlQ7rAdKCUFAKjow1emUZTLjhF6t3RlVvVr+CzciUEQ19SRdxCki9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DtOLkD9f; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DtOLkD9f"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-417c34b0509so2414671fac.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773691014; x=1774295814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5d1yKuk3SLAtnZLG3Qec0w4FmDKAr8Dh755XkWBDe8=;
        b=DtOLkD9fB0kwmzV7zR6RizG5yPdnBE7ngZitLZ1UgR0l7o1WPg0qUBQRoFOEWb2Tps
         mCkObixF25NWYI2tUu0HfYewrGBJ79eGxvwlEPQcFUUf8btaJ1CYWfnKLqERhH0rNT5d
         RpIV6Yc5/BoTrk08aTXYTGq+TYExd6kqBPQLiNCXHiXVIkiNfTEobTDXp/c+edKAzZYv
         MoQqGvASrXmb4U2Ss7bo80BnSv5hfXu7MD0ze0bwUZCV18NeN4KQa0kwjUMuPG+1W05z
         W5rWUfg8VN7IMEdYBTIYBK30OWPNpl2MWhviQ9ag1jit6OGJ4/4h0mzGyZ+h5RwF1t98
         1u9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773691014; x=1774295814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5d1yKuk3SLAtnZLG3Qec0w4FmDKAr8Dh755XkWBDe8=;
        b=dmZ6Cbzc3DX1Blq/Xk+uevuFjbx4nWLnuLdU26YWObNMEOdMVJ9b/frrdNDccaMGUZ
         pr/pZIW0E62AvE6hrbWm+7Vvmrc3kd2XNztF8pErpc65is8ayZmjB3Jcia/SIFi3rduQ
         2DqSWsyuQwzzGADezwmeXvo3IlWsjS9cTL5riUKFEMpzTgtS8XlIaLYtxy0BmNFvSi2A
         SVd6w/fndFtUp2Lt47wunRXkQDJ+KpE5PEe+g9iYyBKP/EVpfSabT+nCrkaN7HlTcY65
         9tEIf/0C6052L0OPdBicquzhM8wGcZkTas27E0CjaqH5AWtEA0UvlPblzBMlS1dLtaT0
         Fa7Q==
X-Gm-Message-State: AOJu0Yx1ZCTL+vWzNC073wsMK2FQ8SKVnC3MUjD9S2W5hepirqBG2i8l
	ZLfaWkNqz8XNrWhZRhRM2emJR3X++nrhz7dt5LrhjZgBnF4/LjjhhDB8C8n7z77M9QY=
X-Gm-Gg: ATEYQzzR2HZ0/KyidgEdQGuEeu4ZfS/qIkRfcNGhNfh35CP6He913C0tNbr/mnxOdFH
	UvE2YhdGE3vSIagnWFgwhpWEjrIu7n/xjrE3fndETgk2xGkLz/wsl9UOSsQjdYZjtPbg6mHFBXf
	OTCXCtSpg/TAl0rBWwhcwQMVJMbXwH08GfF4SlqPNhy0GZ2I8jqUOY6hK5r/WtNeegHINI971U/
	wf6jsmqKasjgq8Krwk/JBQq3AcdqBjIHfVXku77zV9WNeg/dPSKAgqgXSgNK4Ln+O4y32pAsL8H
	dmqCsijXfQIxanuI2GByTKYNdbHOspc/bdqSl4lhhS480VkAIN+/7ueo0nP4yoLgij+llJS8o6W
	jmeyBfdE+jW42o3ByX19Pi+gQYANxXIfyBiv4uI6P1kAl/ky+wps3E8HSsqkzuZb6MqgIZkVZBm
	DctPEoktwSmWaYu1c0/uUcs7W4pRaovXrgpmHZBjX4s79p35oftxs1t/XHLKEqwZ7JEF4XvjVnZ
	II5fsgM3xqd
X-Received: by 2002:a05:6870:63aa:b0:417:1726:9076 with SMTP id 586e51a60fabf-417b93c709cmr8101740fac.29.1773691014173;
        Mon, 16 Mar 2026 12:56:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e268f37sm16508449fac.6.2026.03.16.12.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 12:56:53 -0700 (PDT)
Message-ID: <b050ce49-9880-4d87-8e52-09705e7166bc@baylibre.com>
Date: Mon, 16 Mar 2026 14:56:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: add IIO_DECLARE_QUATERNION() macro
To: Francesco Lavra <flavra@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
 <20260228-iio-fix-repeat-alignment-v2-1-d58bfaa2920d@baylibre.com>
 <7f000ea5-1a41-4da8-aad5-04aa875fa4bc@baylibre.com>
 <0b9ac137f52c2c279e07b2d1d8f7379ca9631cef.camel@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0b9ac137f52c2c279e07b2d1d8f7379ca9631cef.camel@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 2:03 PM, Francesco Lavra wrote:
> On Sat, 2026-03-07 at 18:35 -0600, David Lechner wrote:
>> On 2/28/26 2:02 PM, David Lechner wrote:
>>> Add a new IIO_DECLARE_QUATERNION() macro that is used to declare the
>>> field in an IIO buffer struct that contains a quaternion vector.
>>>
>>> Quaternions are currently the only IIO data type that uses the .repeat
>>> feature of struct iio_scan_type. This has an implicit rule that the
>>> element in the buffer must be aligned to the entire size of the
>>> repeated
>>> element. This macro will make that requirement explicit. Since this is
>>> the only user, we just call the macro IIO_DECLARE_QUATERNION() instead
>>> of something more generic.
> 
> ...
> 
> 
>> Hi Francesco,
>>
>> I should have cc'ed you on this one. We'll want to add another macro
>> like this for IIO_DECLARE_QUATERNION_AXIS(), I imagine. (This has been
>> applied to the fixes-togreg branch since it is a dependency to a fix.)
>>
>> What to do on that for the alignment though is an open question since
>> we've never had a repeat of 3 before. The question is if it is OK to
>> have an alignment that isn't a power of two bytes. For your case, since
>> the data is 3 x 16-bit, it would be 3 * 2 = 6 bytes.
> 
> Hi David. Differently from the hid-sensor driver (where the `scan` field in
> struct dev_rot_state is used exclusively for quaternion data), the lsm6dsx
> driver uses a data structure (see the `iio_buff` variable in
> st_lsm6dsx_buffer.c:st_lsm6dsx_read_tagged_fifo()) that is shared between
> all the different data types that can be read from the hardware FIFO
> (accel, gyro, quaternion, external sensor data), so changing this structure
> to a quaternion-specific type is not ideal. So I think for the time being
> there wouldn't be any users of an IIO_DECLARE_QUATERNION_AXIS() macro.

Makes sense.

> 
> As for the alignment, according to your patch at [1], when the repeat
> number is not a power of two, it is (will be) rounded up to the next power
> of two (and this is consistent with what the lsm6dsx driver expects), so
> the alignment will be 8 bytes.

I think you are referring to the 8-byte alignment for the timestamp?

Patch [1] should make a difference when the timestamp is not enabled
in a buffered read though.

When the timestamp is enabled, the buffer is going to be 16 bytes per
sample no matter what because of the 8-byte alignment of the timestamp.

But if the timestamp is not enabled, then for 16-bit storagebits and
repeat of 3, before the patch, the buffer would only be 6 bytes per
sample, but after the patch would be 8 bytes per sample. This doesn't
make a difference in the driver itself, but does make a difference to
userspace that is reading the buffer.

> 
> [1]
> https://lore.kernel.org/linux-iio/20260307-iio-fix-timestamp-alignment-v2-4-d1d48fbadbbf@baylibre.com/

