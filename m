Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F84014A9
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464741; cv=none; b=BxIPz7vgA4V9nGd2khzngZ0igDzDWG4ifDphrcfdFZVARKAycaKytb4PgsodxDCrwI1+BboOc9m3PHNWCXAgkaL+zftIZ6PSAkmhNe2kC+Fzbg2hiWm5/xZJDl2yz44MirY0mlb4tXgVE5hJgnWSN+APpfXbGiJDB4LRgks7A+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464741; c=relaxed/simple;
	bh=4DnvNXGvvtNNdmmyM4AMeHaM1InJU6nPwqe5ojDIsTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM6gYxOiWuRNWk3wlJ3DNlkwN3cPw99yKVaJIU2JCY+7Tz96EKMrWtlY6+8gwgdKVLLopfbuQqQmRlpNV7cdfpN8BuWSp+umljYprs8cAAgU1BB2jPyiLSPQGu/8i7ww7jSuDKz/BZ2N2WJNkWs5kPV33cwCY0B7aVoBntpTJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t4Gq4CN+; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t4Gq4CN+"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4c9537f90so3547332a34.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 07:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772464738; x=1773069538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZJnsgIALSYKEYqBOZPypi+I02KS1mMRPI+ojqPd+Cg=;
        b=t4Gq4CN+sFzwknZkYFPwQ1svPHbl9g40N50ey43bBBTGcf7DGm6qO9JaY3Hx+AmFm5
         d1xlR6/UUngpYReYMaRdyXTf0zBful1UlQ0lVRuM9KRmZ2mepxezadNKPGpg7Elxczhz
         4cY1vE/7DGw84j/6f9Ap6/llPWQ3U14XL0x53Pmq9UKeFw4iziMGrXDIusoQJXoa+AWN
         c3bq59OVXcqwWQL1pGuI7XbLH50dU5K9qIsl5iaPlk+9pvyVdqOszeaf9LICHEPutg00
         LbpXZ35iFdYS7JD5KNhwDLTjmBJGqubv2MPOYYySaiv0Q91uAq8XrtBJMeba3pgLjOue
         CYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464738; x=1773069538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZJnsgIALSYKEYqBOZPypi+I02KS1mMRPI+ojqPd+Cg=;
        b=jNyOMOS31VnZFrGxX61R3rqF0gXx8KXYg87FWqr8Z6ZnnheQewRJliMhzW1iMO5/Fy
         53CZUdyOzWKqjF3433ZCEYAqvyUh5Rih6Og1YHye0Ptg3edMsxO6IXqV4+o84g3G0Tk+
         8k3VeI22Vo4Jr/5Sd5oc2bqVckIkYIL+2bJ5oNjZ8nKvIwwjxUGvwEwZbpGv4+PF+QWJ
         MCEfnaj1yITEMuc690GQ/wNT9DxmS/jRcGsqJnZUVNgavUNavClEvTtgTRy7kx8CL8e5
         CWkm+0gKpTFqiA6Brf1gl9lxtG3RMh63Gx5gsrj+pWPC7s2NJgYrSafR/XN0cH2Q1/Gs
         YDJg==
X-Forwarded-Encrypted: i=1; AJvYcCUNQpuH3iQbqluwmw8LkDKz1wlQXJ/jun8/pYWFYoXGCmmHgoO5iub7tQG4waWIEHR0LDgsSqdWNBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbDDrL8f6mY8s5aYfxNBFRC0hFKklX7fyyVnr+wGaa7ab5Y3nI
	oiqf8PbkANMgpHL6smDpucAxQZE1zlovNpOGrYmh8TwlyJL70EAdwUr1YV4aiA0/xnM=
X-Gm-Gg: ATEYQzz2KS7KgdlreR7QRD1ssvQnRwARVajQnfenoJiIGSlr9G0jRQBB+YWDxq3D0N3
	xsYpTUa8itxvU5ODsRoaWEJN/fzkLplDkEYASCbjGXn9jXSqEX2TrorN+2oqzCOyQVyJBI2U539
	LyfZXIlzSMRS7ht4i+m8DU1OsCRGvbm78QdHo9K/5m1AaClFH1sKg53yRhzDrFlctg5X3d0jHA8
	20x3KimjbHe4IPEFRgLHdH2stDMNJqmF3+mcZsVdor2DFq5JRQiAV0APYWgVPUiUuzqgh1+T/0X
	N9NRmHBgm08qdpstpUOseKz3BLPbD7E+nSxrNYRTb8rT2ofxRwnKb8qiJNUIosH3//1Xge85cpf
	KQredUpwoVD0yuddqff9pz6jKFgK3mDlT3zneZQFP8zQLRl7lJfyXQ4RMtBvqAm3RZT2Lh/d1vB
	VvqkmuyzmTjmMHLQlbDe8tZPZfMPjo0IAtC9gEjtFkNaK4IwNZThWfDs5ao6TzEIhNpmjKRmt0W
	Q==
X-Received: by 2002:a05:6870:6592:b0:3e8:970e:d4f7 with SMTP id 586e51a60fabf-41626d64dd3mr6976780fac.11.1772464738185;
        Mon, 02 Mar 2026 07:18:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d26d20asm11334813fac.15.2026.03.02.07.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:18:57 -0800 (PST)
Message-ID: <8f9dc90d-9dba-4ed4-8cca-41012027aa10@baylibre.com>
Date: Mon, 2 Mar 2026 09:18:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iio: orientation: hid-sensor-rotation: add timestamp
 hack to not break userspace
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
 <20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com>
 <aaVPQsvz02S8GtsX@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aaVPQsvz02S8GtsX@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 2:50 AM, Andy Shevchenko wrote:
> On Sun, Mar 01, 2026 at 02:24:50PM -0600, David Lechner wrote:
>> Add a hack to push two timestamps in the hid-sensor-rotation scan data
>> to avoid breaking userspace applications that depend on the timestamp
>> being at the incorrect location in the scan data due to unintentional
>> misalignment in older kernels.
>>
>> When this driver was written, the timestamp was in the correct location
>> because of the way iio_compute_scan_bytes() was implemented at the time.
>> (Samples were 24 bytes each.) Then commit 883f61653069 ("iio: buffer:
>> align the size of scan bytes to size of the largest element") changed
>> the computed scan_bytes to be a different size (32 bytes), which caused
>> iio_push_to_buffers_with_timestamp() to place the timestamp at an
>> incorrect offset.
>>
>> There have been long periods of time (6 years each) where the timestamp
>> was in either location, so to not break either case, we open-code the
>> timestamps to be pushed to both locations in the scan data.
> 
> ...
> 
>> +		/*
>> +		 * HACK: There are two copies of the same timestamp in case of
> 
> Usually we use FIXME in such cases. HACK is something which goes with
> "do not apply".
> 
> Does it mean it will stay forever?

Yes, it will have to stay forever because we can't break userspace.

My intention here was for HACK to mean "do not copy to another driver".


If we think that no one is depending on timestamps being in the wrong
offset, we could omit this change and apply only the rest of the series.
And then only apply this patch if anyone complains. I am just trying to
play it safe here and not risk breaking things.
