Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA493ACA5F
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682534; cv=none; b=mzGDU1kYdD0YYgH0ydOu0ZcyH54it4XS8wjQSfCOY3rjLVh0VKrqIOL4fPjTsk8I/MlFlL54xrZMEYcHf3EQyOUKknbhOU2iWIVnPsF9Mh49Zhlfr5orM/AoWmjXXdFB8dGLyL4wCzGvbIxNq9lz7vt+2pFM56xWXdlgiVZDs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682534; c=relaxed/simple;
	bh=avlC41Z7qfD37KMgpKWW28XxAk8XP9gab5Z6xd8VY8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeaBHu8UMOOjMR0vV2qP0YOhy9YKNroc14rzP+YbCJKMeTAf6xFZh7tSHwmZoAo2rm7xHCLr2HvFhOpLIbTxJJmO5wfEswmJAe13lpKxzuay1sJrQIvX7lmvnhZ5UkKF/xjW7yVb5fQdF7v5VKtvfgt2VBWI5seLnOfV/OhWsvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PFAH0fQi; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PFAH0fQi"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so1644186b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785682531; x=1786287331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QvXk+CwtNe/yx4A/ob7hj3C0u3Bge2dzbH4nX5DP+v0=;
        b=PFAH0fQiIv0KsMcc1wpf4x4E9tbphbcS4rjh2Oka3XCGOwedlLnvJVwwB9xEzUNrIn
         DEpOouXAi3DWE4fVD6Go/YPwNix56cHwoZs2IBOJUaOr23i1M9BHJht4yVjkXeE/Py2N
         RpCgKufiu0SrAE8mBo8lfpSZzzHFOKpnvlJS34zHt8AhdKFwJVFWo6TDW8VdvfxSecew
         pNDYXSfcC2HyplSnxMaBSwTaGoafv0WYubBq/Qz79pM0GvReLKUBfvzeICZSmFbGUUXW
         4VEqI2zcS/KmqrZh0NfNCzrK2MHXJYMoRr/b0RDie6CNz7HSAez9BEsY9WKS6iTiKWPv
         zjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785682531; x=1786287331;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QvXk+CwtNe/yx4A/ob7hj3C0u3Bge2dzbH4nX5DP+v0=;
        b=olDvaTAOyiR/fe4wBE76tMIKqh52Gf3v7IVtnzu030J9XYbb9lMfTsaKacHbP8s8c2
         7JnhY8QEgFPC2NGT2hLNUuHKvY+LpfNSqoxJWxWb3onLXR9+QyWEu6Y9qD1xrVjmo5fr
         z1Cuq0e1+p5tGbD8Gf53YEV6RopOAIlWP5dxzPv/Zi56GcV+7ekEWlrzUAeatFZQr4z8
         3ZF5vOP9p5vOEoApNTKHzG8bjTPFSPGEcnKqPPMmD2XVYK7tJQM9+eNadTKOdUu3vQ8E
         pWzPPnvraUeXFBU4uBNapZMDSpCHTDfRAbDgUvWJq83nNvcy/25YGfkGqP19cFrMYt5h
         zSSw==
X-Forwarded-Encrypted: i=1; AHgh+Rqg4g98H+u1J1p9TBvyX8DvDzLC3Ljamgg+Jfi7GiFSOIKmEL/e5IzyNHSqQwrRQjJKxkvbQlVlUkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Wl3ruNd2LYZDrKnjRPhOnm3BEcSP3KQZYLtXBTbhK/rsDe7B
	y1qsoHjRu4mFW2gyUeJKBPHJLxw7yNIBmfWG7PBdq+sVwkqInoBIb5ip8JoSIysYxbo=
X-Gm-Gg: AR+sD104dGELob7cMbWCelfuxT0ecxRdnCuOHY0mpBaUy9+Wfcv3Yl+9rrSOm0cUN/I
	+SJobNCxgy5EJulBgREs+sjHlZoe56Z3poT+Zj9Vd08Hy0D0Us5pItuh09LJ2RWpiStq6imuvbC
	uiDAUoLBDIRre3IJ68jenc9+MMNzCj6YpFKwhaVTxW4//N3dsHqz9d76bP6oSJ7DhykxJcX5k46
	5OVazlJ/HJWWfISBDdYe+DcErEPMXi3fnYL9DOzEJoyFmgOe3YwSDuwIAobC7jptee/kl+zezyT
	jj2nUSo54Z6RrHUIWSoy0q+abO5UXrzjtIT0xkhe1aaLDF3QlSB8ZqC7aCSgWE4aBY1Z/MswD3a
	nfKrF9eqZhROBgrKkhx3vP3HiD0Dpq2C8x/GGICHAnuthSt87i/1loQi7n/ixAu8z9nYwZv0buJ
	EIN7ES8LUL6OvK7ihBc2yevQBsE1PXYXnp1lER/j2DUaexre+rzD43karMJOrT7ItMtX1TUseH3
	lMLXrLrYnEC8VqSXpCzpL4V0UxBRt0Uu9h3Ne8=
X-Received: by 2002:a05:6808:1a27:b0:486:560d:aa91 with SMTP id 5614622812f47-4af5e2c78b6mr10111131b6e.19.1785682531523;
        Sun, 02 Aug 2026 07:55:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58e9568asm4776407b6e.9.2026.08.02.07.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 07:55:29 -0700 (PDT)
Message-ID: <82983661-0231-4fc7-99b5-2ea1bed91296@baylibre.com>
Date: Sun, 2 Aug 2026 09:55:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] iio: ssp_sensors: cleanup codestyle warning
To: Jonathan Cameron <jic23@kernel.org>,
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
 christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
 kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
 <20260426091710.3722035-2-sanjayembedded@gmail.com>
 <20260426145312.06bcd30e@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260426145312.06bcd30e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/26 8:53 AM, Jonathan Cameron wrote:
> On Sun, 26 Apr 2026 14:47:02 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> 
>> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>>
>> Reported by checkpatch:
>> FILE: drivers/iio/common/ssp_sensors/ssp_dev.c
>>
>> WARNING: Prefer __packed over __attribute__((__packed__))
>> +} __attribute__((__packed__));
>>
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> Applied to the testing branch of iio.git.
> 
> I'm trying to pick up some of the patches on list just
> to reduce how many are getting sent in new revisions and
> the time it takes people to look at them each time.
> 
> Not sure how far I'll get in your series so look out for
> when I stop saying I've applied them.
> 
> thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/common/ssp_sensors/ssp_dev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
>> index da09c9f3ceb6..7d07fae295fd 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
>> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
>> @@ -28,7 +28,7 @@ struct ssp_instruction {
>>  	__le32 a;
>>  	__le32 b;
>>  	u8 c;
>> -} __attribute__((__packed__));
>> +} __packed__;

Too late now, but this isn't the recommended `__packed` as it was
in the first 6 revisions of this patch and there is no changelog
to explain why it was changed.

>>  
>>  static const u8 ssp_magnitude_table[] = {110, 85, 171, 71, 203, 195, 0, 67,
>>  	208, 56, 175, 244, 206, 213, 0, 92, 250, 0, 55, 48, 189, 252, 171,
> 

