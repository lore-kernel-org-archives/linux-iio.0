Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D23939DA
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463395; cv=none; b=ZOo3G/ivdrAy4tTsyTlL+giUlwU0e2ItmLa/u1I4/2m3EHk4VoXkN1sUdU325S6cP5HvOdchtw/3Ua79eFoBpaR7vo4rAZrH0bVRuKluBJZZwxBeMuLOB632GV8bz6pb9dRQeMDvUljGSrKApz/cIdZaARHwvQ3fEI9w10Ay/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463395; c=relaxed/simple;
	bh=xLcu+naJATLSrp6oD632lLb1BBJ8uP4Nn1rRK3v6cUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QX7tgoT6CwxjlZi0qqFbdt+6dTpmuPlFz9cZ5JIYe+zgBODw5fW8Xdp0LOa20H6W+0a4zRqfLEyA2jc4FsS+mnd8HdToCnS2WNJc2KbGCzyiFov0dFMBnJUa5nXAPALgqya2s44gKvakCZOu5ZiL0gSn06Y9VcnVuMmVyRhYwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HbS4JmKt; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HbS4JmKt"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ee4399c3abso37043a34.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786463392; x=1787068192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tHd7fMf6OyG9czVkocgnx+h3OKQk2OgvfP9nJAII4k0=;
        b=HbS4JmKt59LFDH2Xi9VX+J7Amc1WWKnDk2Z3aUN6U2dUWEiwF4GYr55i/9dWJaNjol
         cuKIktz6Qby3Xnd5rFLcD+PcFXWowsP6QHiuK06RZX+6OEy8kBI2tsp2sZoBcYY3dJTj
         2NmEin1myadAyJowbkR87Pr+/EDqd/5N7bLmjH/qFIIEaSbiy0Xp5tHWZI58sfnbl1dL
         /LS3fyD1A0Kq10oMjvNYvw/TuJHpe7w/O4854nBFNqMXucOfdBFzhzi9WT98Kmk8vFFp
         PzJ2jMnpHeZNj6vgCSpgX4o4lXntEyhzpqaSla2uUsJJn1YBc7lLHFa0O2OCHvSRJr3e
         J7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786463392; x=1787068192;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHd7fMf6OyG9czVkocgnx+h3OKQk2OgvfP9nJAII4k0=;
        b=ZeFdSzAlvh/6VnJCSvJYz5qeNa9J0tdMdBIzLheYl61DAOe7TlUWDLcrgv+f4+jzF8
         ZBcMDxQ4AjfdSxSpxZybDxqeRRijonlanMqTqDhrOiQtaUHLVN2RrooVKbtftT/ukq79
         VZDu6d0+uSBhauSgVd074Ot8g0FHYXJDoQNFGAOZbRUL2P5wJmEeIRnd8GrwUB4pyevM
         Di6s5MlM6lWmU7koblszQiWzCZlk51IEsC8vHKPeR2m6S8m8H/yxSgjp4/W+zrc2sDK+
         usSqP6xsmfw97J/ogc5SQA66fVCEHRG44sYpZzW3a8vSE7AXC4gp5AKZNJFCfH85at1O
         DXgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqH1KAhTwCUUHAxgTJg6ofzSuHU5SVVdq+mQ/GqQD16H2F4LetI5/yMtJqccZIyxBc6HPzqZf3bwLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxlXa9kmkGMS73lDZ6wNZhWHVrzTWh750N6Nda5c58nx+waZL7
	vjiD1/60xzgybyCYxv7vzGDSddnknhmPUZn4WexHh5qndR7Dai5ae/cEAJn23/llqEk=
X-Gm-Gg: AR+sD12k7mCDSaY81lmkmeUrKlAhMurfxTLPutAYtxo0GaiUSuR1mZ1W8dXPZKj30aw
	mnzB1RyuNk9clf1X2iVzhF74LikUBbFbAaAjoCRvI50NW9m3qP2Xz+Kp2Qcmeb/VSfkjhW7yI9P
	i3JvSRRVAb1vAj0+D1FXQJeJJ4qDQKjdAst9OKn9BjEqnLmxuItCx/27YsFrCCdISR3vHCP8O11
	0tKEYeabmwMy+9gxBj+QD6sYvITXfKv+taQs+l0Lru67wrQosofBof/9YUfO67RLlX9NVbtrggP
	JAA02Ky0jnMpKZbgHWmGAXNo/NmwoqM08cgAi0oe9lm4DgDWRSdJLBhLJpUJ5CLGtf9ov0NIXG1
	niRhHR1zozixMrU1uziAp51rNgf7URQ1AaFmLgL9erW+mCwbZUlx6i8eRgfU8gNNYt1e2l9Pqtg
	PAUALGkh35SBgGrO6kUrLPL3ngehwDS3UN+oASqxwf62xsfLy4yNz6ZT4snZYIs4jGXfa6lCMyk
	PM9rzXnketAc9axmUTkMcfgFsmifcAFgOse
X-Received: by 2002:a05:6830:621c:b0:7dc:db3c:1d82 with SMTP id 46e09a7af769-7f3a829eb35mr2930682a34.10.1786463391711;
        Tue, 11 Aug 2026 08:49:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7060:91df:60e9:76b? ([2600:8803:e7e4:500:7060:91df:60e9:76b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b3209115sm147808a34.8.2026.08.11.08.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 08:49:51 -0700 (PDT)
Message-ID: <2d7dcced-47f9-4fcf-9668-30acb9e8c9b1@baylibre.com>
Date: Tue, 11 Aug 2026 10:49:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
To: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
 <anqKwJOkl_cxzCT6@debian-BULLSEYE-live-builder-AMD64>
 <anrRkty6ugdJUGmE@ashevche-desk.local> <DKM7MV8J10HS.2OIM1TDHB9VHQ@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DKM7MV8J10HS.2OIM1TDHB9VHQ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 10:12 AM, Nicolás Antinori wrote:
> On Mon Aug 10, 2026 at 4:28 PM -03, David Lechner wrote:
>> On 8/10/26 1:32 PM, Nicolás Antinori wrote:
>>> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
>>> communication protocol and measurement conversions.
>>>
>>> Add the "am2320" entry to the i2c_device_id table.
>>
>> Interesting. No devicetree bindings for this one? What kind of
>> system is it on?
>>
> 
> I am testing this on a Raspberry Pi 3b mounted on a protoboard.

How do you tell the RPi to bind the driver?

Since Raspberry Pi is ARM-based, usually we would use devicetree
overlay to do this, which would mean that we should write a
dt-bindings .yaml file for these chips.



