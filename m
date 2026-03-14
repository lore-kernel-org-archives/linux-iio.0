Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415F2ED15D
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524388; cv=none; b=R8z0m30AusAaHRCjnNv07y8ac7WdpXHClnMmGlgW8c6NUdqAO4VxFUIroEi46PxLAOqX0XduvQPTWmc3fbHZetwykoVfU6qBBYdiYnC39O/Q0edqApNkaFluTthxRTDjYVHzieKXRNI2y0paFewQ03DzjibJCAJ19eAb7IEIKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524388; c=relaxed/simple;
	bh=Cjid4llN8U4wFU73pi8DExNdpsjC2Bk83AyqgwVq+SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWkkIrXXWLWFnjid0isDjNXMuxS6pG6ECaMKbToNQu7TSU1cp+KInPN9YHwkj+sCpZAmYfNwp9NUik22y5HDC8kf25HxYWbi2ukmhL5xsMwFoonGr0aTOZkiiN5axxqt70UStibLkJimdDMIHKl8oTQLtfwV8lCGols1MW77DeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sQwfllty; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sQwfllty"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d743ba241aso1786659a34.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773524385; x=1774129185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ro811a96fh+jbA/xvorkVanktgU1K3n1kQCoKnRbkIQ=;
        b=sQwflltyNCYJJkuBPYk+JV9u6BnK+n+f3nxw6EVVnGM56NxifuNXWD+5D56RsL8ePK
         enk4mHFSRkNb2Qo0vizpYUB7stNxu5lanHDpOCdJxrQ8ioWH9hNiOyfFGnp+q+weePh7
         gmWND/PLRLxBIs2360eCBmCAhKOewnZQmWRo29BGNBSbICS+WS5BNTSlkA1Ndpg7pORQ
         tZ6sjYf9rwsebDvkPKzaNJB/o/xaaerV+17MIXCZYKVm/6x6uCS78cPEJZVw88T4WX5Y
         Mh+9tPr0LVH8jgyjd1Iz7dAHpApmye7moO+mmNKQLK2HFwnCks+fGtBkA2jVC+LBigf7
         hvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773524385; x=1774129185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ro811a96fh+jbA/xvorkVanktgU1K3n1kQCoKnRbkIQ=;
        b=ihxWU1bosfUNIuWfeUzCOAYQS90dLpNn9IIsK6yfCbA1Q9dO3fdmNuBKK6WBeMW/PF
         ZrEXN/v/LW++iJPxf7/orLIrN/U28u6t8AuMqtQ8eI74zQ9wg3nxGTZTPkKc8mECGENS
         ZPL6AhT2A0t/lwJPUA4zfVMCR0aWVuA1GoYbJHwbgIWn2G6L2ZASUa2x7GD/XA8ZMlgY
         f0L0D7IT99nGidNyrnh47mXhR1UFpWNGNqjwiY3XkxbfHU+EDxHJdx8+fH9SW/NUZZfQ
         VhfFk860ykppummDGEqg/orIS4A3JULsy83NX62BIooz7AIAMl8qW+WXqMy2ysjU3RCa
         eFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFrJIbSRrwESPJNFRyQg6uIPFLF3AuaKhhVnAlqryweGjMWyC41lWMq4lmofoFpEmAix1rYqG8KNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ylr7UXbfgzBUKD1wZMTin9mh6gLMvs4KgWjs84nKvvgtnURY
	6lb5xP3J5HOnFSq7Vxx0TUcmmYuoLDfz5Ca4uFLeaujABRc499utBn6d2UxOtZfoduI=
X-Gm-Gg: ATEYQzxaHjr3FcadOt7b4CJT7/Abanv0ctwuitI0YNasYrrPehpNXmKNSB8oDiaE997
	1LLQDujEGnFxy+f1XTsBubPunJ6agGHOtvL59TngehOCAS4mmTAfG8943KGS9Uya0jPZxN7jDAc
	Q8jykoUR45SMOlISTQv1rSVnekKUZ3DldnjeQzBBBxoAXccJjYxLZ6cNNcY0oHM0OrNs9c1mKQW
	XabrK8mp3ooCDtqCCkKrBJbv4SJLS5g22Nw0iiKVcVM6uV33nrIj8xHkjOopljqa97MzS5Dpr++
	r/QAtvNKO0LYWaGR+XSPiTblmVzy3VlI8GAyh8NEhOQL9kIsMQzrvkOcEdNmse7TMiXlrxZOl29
	sCD/QgEQ2kL6qa9oOE46NSu5zmd7y4wwRxzFdeULF0NmKs+VwEkHtCxe4vE5AQKXH7HYQJmR0GU
	gnZnCCTmVgdKF+xB3zQbQP7aq8HOTC1RHjUJdqhCzspB1WXKOPWMGsFe5GN/Xnhq9lDXn4utB3M
	MI4QdRRT/fT
X-Received: by 2002:a05:6830:3e07:b0:7cf:e57f:df1b with SMTP id 46e09a7af769-7d7825476edmr4747941a34.26.1773524385674;
        Sat, 14 Mar 2026 14:39:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae398fcsm8784176a34.16.2026.03.14.14.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 14:39:44 -0700 (PDT)
Message-ID: <84473bc2-727e-4440-bade-d9cc3ee62698@baylibre.com>
Date: Sat, 14 Mar 2026 16:39:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: imu: bno055: add explicit scan buf layout
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260228-iio-imu-bno055-repeated-element-v2-1-888676158804@baylibre.com>
 <aaVRjr3ntMHYq-k9@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aaVRjr3ntMHYq-k9@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 2:59 AM, Andy Shevchenko wrote:
> On Sat, Feb 28, 2026 at 02:15:51PM -0600, David Lechner wrote:
>> Move the scan buf.chans array into a union along with a struct that
>> gives the layout of the buffer with all channels enabled.
>>
>> Although not technically required in this case, if there had been a
>> different number of items before the quaternion, there could have been
>> a subtle bug with the special alignment needed for the quaternion
>> channel data and the array would have been too small.
> 
> Cool thing!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Forgot to mention in v3 that I didn't pick up the tag because I
changed it significantly, so worth another look.
