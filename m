Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD035DA40
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780825485; cv=none; b=T5Yd5T6GHQRijjme2eBntJY40t6jp1rxAHt1Qfut1gadTryN79LQrxKfGO8Po94SHN5lEeCyFevHkC5S+FfKIlWX9gYkrjPB1rTx/nub2EmLPYsxPTbo/5B1pTrHT9UnQ0WPczwUArTK02x1doszdTpORdGggfTQveFCul+qLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780825485; c=relaxed/simple;
	bh=ThYMWQAfsexWY1TWhGbF6PFLMWNiIlXKMllw2X788mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9H67Vys/HOLiVd6VKHKkw0xEzxq8DR2eT8TTFkJS7tLs7NONktgG5knmg9HN+C0YubjkO/kp4/LxgGL0Z417Cd3s4marsEk/BY7voXkRCBA/U8c4mTb8dR8GhhW7P8aweYovA2bzWHeac3R9YfK1j/ShWsx5a96wn7nUw1djTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+/3/Com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+/3/Com"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef4223be7so1688575f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780825483; x=1781430283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HR/lmdk2plRsJSnfN9lqr24Fr4cHJ+9UQGnQ2BUyH4o=;
        b=A+/3/CombLRRzvbCbT32QSj02gHn5fOFGXMWJNEbwgr/pGnj0orygU2OuRjKWGPa+x
         lxaINJ3LFjkCgyQVt0CRhkSSWzHdbMH9UY853vqBzTTvWm9/BdC3Jxj4s5F1iIIknZkq
         Z8dPDHSHnq8jQK9YiPeJwHLCa+eoOuZQJIIqD0SgbHJjnsX4ibJxhbvEFi3hXBtdTVFq
         XmaC4rMwgJdEL1S2N+axViyXUWn8eeyupwKP9lt9K1Fm0U26ijLU8jAc9NubEBd/up/K
         TqaJqzA+Wk5ommjqCNvZ5j/MmHa3INdU5lsJkE/J0jviAtOYTaSwT7+sdi7EtxZUeXig
         4nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780825483; x=1781430283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HR/lmdk2plRsJSnfN9lqr24Fr4cHJ+9UQGnQ2BUyH4o=;
        b=CqdGmQMUqsZKLwgQEXJLmlE5FOlPIg5SMeHziLxFeMs28t/Ze2vNaKexuv8mEc935p
         LoPqyjiXWswPdJwSxfQE69tH2LLQaxB+vKFIyIoiskEIPJ1jP12G1TJrr62xHhshbUO6
         zYbyg/r0oAmPx7JtnVi4M/2rI870R8f9j1sWNmQ5Hz6b1EeJrZ59v1Ymdo2ZVTrVkf8b
         L89BjwSiL0S98VZYL9yz9tLkrPN6jZdd9+sAjoA8ZNi5PMeV47/tqNfSA2Lj6j2i1cDE
         5phaE1TTwkB74SrADZ1jr241nETBeODMdrXwZwRLFGt9s7ysak49YUys7sH2LTL/LmGS
         B+MA==
X-Forwarded-Encrypted: i=1; AFNElJ8SvtHLoMQiLtHtPNKIijrb4ANJ2+Jxvv6rYpbPJn3OHS4ayKct2NUAgGu1bnW6EINT0HFm9I2uIGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrA0ZTnJgbJp4VR+g/kXAfqmubX17g5Poed6mVSMkqCl9sf7I
	UNu2cYWmBWotut35MAlaTA5aZr8oY3vd9J2SSirvNUrDIXVq8mBvaWl1
X-Gm-Gg: Acq92OF+zBtcIPwJwEBXibED/MP1pnjFmlBJHfsoagxvHbsG3PLCL6T2xdYeQITZ5qm
	3cYLEhp3qHfhXU/NuIWlxRi69HJuZ/uzsZCyol1TnrMfQa4ACzxm8h43UqJyjz2rciLl1EDBHXy
	6bdE4GmUKhceFiHN8JZZTaN+w67lAz99EWEjboeO5A0+YK6InSJLypqaMgKsjPUjYe04BRq7DPn
	tJXon4tk3UugeN0oK5aVWZKR7qwv7QKv4OX5kwam3tS+tsaF1lZvA1ddWdI4YYSKGehCtUcOVDA
	O9YhwmwD1SioD7TeVX9jBv3QDgSBFIfaICeHDtN0ZvL7RL7aFxYs1FdLpTct1z9ACCuq5kLVlX5
	gdX7YrwPpl+ZT0pjhfGDOtoIJxUqyMe37i/cVqzUm/Gz8XM2C41mNUo6aWB3WQl4rs3NlAc9ybu
	S65tk4X/4PG2PBe6FeOfaUGontFcWzNk398OzAWD3taLSbYvAlrS/s0CKbUDlMeJlMJMVXUDoYU
	+viZiea7g==
X-Received: by 2002:a05:6000:181a:b0:45d:817c:b8b2 with SMTP id ffacd0b85a97d-4603065b5f2mr11689633f8f.30.1780825482665;
        Sun, 07 Jun 2026 02:44:42 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5402:d840:f1ee:c5d:74e4:6e19? ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm44922742f8f.36.2026.06.07.02.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 02:44:42 -0700 (PDT)
Message-ID: <d1c24756-3025-4ce8-9437-be3b2a4b89a4@gmail.com>
Date: Sun, 7 Jun 2026 11:44:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] iio: tcs3472: implement wait time and sampling
 frequency
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20260522123420.45495-1-aldocontelk@gmail.com>
 <20260522123420.45495-9-aldocontelk@gmail.com>
 <9c0bec93-e102-4655-8074-fd544b16d912@gmail.com>
 <8392f8a6-719e-43d9-813a-0a163f450ed8@gmail.com>
 <20260606150939.72974703@jic23-huawei>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <20260606150939.72974703@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/26 16:09, Jonathan Cameron wrote:
> On Sat, 6 Jun 2026 11:27:16 +0200
> Aldo Conte <aldocontelk@gmail.com> wrote:
> 
>> On 04/06/26 11:23, Aldo Conte wrote:
>>> On 22/05/26 14:34, Aldo Conte wrote:
>>>    
>>>>    static int tcs3472_req_data(struct tcs3472_data *data)
>>>>    {
>>>>        int tries = 50;
>>>> @@ -166,16 +214,131 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
>>>>            *val = 0;
>>>>            *val2 = (256 - data->atime) * 2400;
>>>>            return IIO_VAL_INT_PLUS_MICRO;
>>>> +    case IIO_CHAN_INFO_SAMP_FREQ: {
>>>> +        unsigned int cycle_us = tcs3472_cycle_time_us(data);
>>>> +
>>>> +        tcs3472_cycle_to_freq(cycle_us, val, val2);
>>>> +        return IIO_VAL_INT_PLUS_MICRO;
>>>> +    }
>>>>        default:
>>>>            return -EINVAL;
>>>>        }
>>>>    }
> 
> If this races with an update can we end up with too short a dynamic timeout?
> I.e. what happens if that time changes - is the current read cycle completed
> with old timing and it only affect the next one, or is it super simple and
> the affect is immediate - maybe changing some threshold on a counter that
> is used to trigger / stop the acquisition?
> 
> I would not expect us to either be able to rely on particular behaviour or
> find it documented anywhere.  So two options.
> 1) Lock around the retry loop
> 2) Set the retry max to the worse possible case if that's not insanely long.
>     Give the polling should exist early anyway it shouldn't make a practical
>     difference and is always long enough.   I think the max is about 7 seconds? That's
>     rather long to hold a lock for, but should never apply if real timing is a
>     microseconds.  This would be my preference as it's simple.
> 
> Only remaining thing to check is there is nothing in the datasheet to imply it
> is unsafe to change the timings during a capture - as if that were the case
> stronger locking would be needed.

Hi Jonathan,

Thanks for the analysis. I checked the TCS3472 datasheet
does not document what happens when ATIME, WTIME
or WLONG change mid-capture.

The worst case is ATIME=0x00, WTIME=0x00, WLONG=1, giving
614 ms (Max Integration Time) + 2.4 ms (RGBC Init) +
7.37 s (Max Wait Time) ~ 8 s.


For v4 I went with your option (2):

static int tcs3472_req_data(struct tcs3472_data *data)
{
	/*
	 * The worst-case cycle time is reached with ATIME=0x00, WTIME=0x00
	 * and WLONG=1. So: 614 ms (Max Integration Time) + 2.4 ms (RGBC Init) +
	 * 7.37 s (Max Wait Time) = ~ 8 s (Total Max cycle time).
	 * Use that as a polling upper bound; in normal operation the loop
	 * exits as soon as AVALID is set. So the total number of tries in 8
	 * seconds considering a polling period of 20 ms is 400.
	 */
	int tries = 400;
	int ret;

	while (tries--) {
...


400 iterations × 20 ms = 8 s upper bound.

Thanks,
Aldo
