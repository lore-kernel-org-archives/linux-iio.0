Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193198;
	b=nzNsh0sWwcsyjGfG1rScTAVmzZ8k3vQBCXegugOpkbYBYWEJF/noInwL8BqNShTbM4Re
	 00Cbpmw9a/CjyGEVHMeVuQQVKphWPrGjLMraArXsoCwXyetwh0XR+ZHyWFrANGPebbRvB
	 htEVfenQZpJY53NbANojAhkrT69V3Gy6pGDhAzQSSwMqFZP9dgAuth6wO81y2vqeYQBV9
	 iK8rB0+j9IsblT2L0ynck7y7WjE53N4/Oih2r+SBbiHcRf/rcZEEsSa2WKOSLZLBbjVGm
	 dFPZisQvsZ4abXRbacysRZTisZ55eXkcKe29PAd5TPCEnfb9dxAOvaKdrgd2V8yKegA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dOD5XrVmD6y96EgRoiJnai2L/0L+uuMS0Loaa0UEtIU=;
	b=37LIUJHX/DVF7zdgKh+IN3bHQ8DtkWDXFvCwSPXtrsrAD5s8yDyP5aohpZquX/yGMTUD
	 U+z/2b2L8XpbEOCHiXIueIiU9ScD6C1fqKJpTx4jlvrSm1OyT7Edtq2AZyxI8uyQPbfLX
	 ZwAgLiPHgL3Wo8ez+Bvu09OYnNxPzMrYHReg4yl7MJgzq4oNpVVhKTIM+zGm1xajRbUB9
	 DAgYnLM+vhKD4O1GJWAPjhr/AdnTvL1TO2W1SKoZbA8Xk6pUlW5EmS69fPNWXiq9Yhsdt
	 lSt33TpZWZhnRt9UGyOzt4Ke1FiuRuFNzO5+ZYMPLIl6bTGfTBkDP4wa8z9lSC9GKSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TLTSWpg0;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CDF606A31A
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 13:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9CDF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TLTSWpg0
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4395d31228so137955166b.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793193196; x=1793797996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dOD5XrVmD6y96EgRoiJnai2L/0L+uuMS0Loaa0UEtIU=;
        b=TLTSWpg0QcRD6pnmJMdorrNNTPYQWxfuLalj6YWlBuppGwMYXh5fjlY86FNeDGDPhb
         m56OgCQ/yhTZBSXXAiJSpuquO5oQMWdsxhmDpxUAv6liWDwFoUlr3HCJR0QoFE2K9cO3
         ieYw7hr8gnwhk6LVH1UVXhlGffImDvPGbzgTcS3cuH2Qv82F5SP3CleD34rP/RM84cxQ
         7a+4Ff9EcJTIu6DK+yWr8G2A79lfS6tr5qidoFRJ4fEXddgTWPx4GEkUhio5QWEf7FPE
         XQJEA//9k78sH19Y085uutoB2etxx60iQWIHzg+/Bj7KlO986+4VgdoW54n0FiBaJKKi
         uwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793193196; x=1793797996;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dOD5XrVmD6y96EgRoiJnai2L/0L+uuMS0Loaa0UEtIU=;
        b=eqbgujQHi6gDOK/caTv4CZStriY8N4U94zs1eJbjweCdB2LGhBq4SHrfgoI/LbyZxr
         Ij+ui5avjsuCt8In7bL/D2GGSDluWq2Q4q/ctDTvhXDuWCABI0i4s1Py4NmsdL2KXmLQ
         FJBEBDltLzYWGzLS2fyq9HUlPwKGthvFtrZToQy3qGyBDay1JgCE1qDiTV4KNF8+n0SR
         DDTtv5WJi3LiJYh7wfmGoanoqBTS0PTEijybUmKd/six/wKOgaEEDgy6dTEBNd9WyIM1
         J+/rBqDL/AR10eRRkIG2pAfdTvV7vR5Z7Rqg/gRRZfoS9uN5H7oJQqgw15QqGYgyQird
         3gLw==
X-Forwarded-Encrypted: i=1; AKwUvBwWDTqpvSTpK7bQoLRphVkQZZoki69RiFte90gQftGzZCGgMdkMwesbapMokA0fjxOsKtyYorNDotQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBQoDsAOmbOKQn/IjM7V+0sw6WkB72OFWm5xyfK0dkTf57OIrY
	VNN4UN+L4dYO6p+sfj3EjCFgoL0yTLiAkfSi3nFNhqF4WkQdtKBC7NMq
X-Gm-Gg: AYBFou3TEUklbVyMwFLj8gd2ogW5touxtjtEH3jq/TeGbx3Yx9h7aSLXkmZahLivYYC
	krv5gFSTduOL35ZROmulr2OVRKzvSAm/W+kIc/DVXa8UvS0yKN7Gp+ywQ+9KwFFEKxjYUL8ek7z
	X3ei5NvcviZZ/9zC9RyibvPIW5jZPWCYx3ZZ8Lh2e8IbmNUvMlMKRTMDNWIDRXbQZkpuNGMxcEJ
	1STVoFR5qraSv9htntkLPnc3iakQrDgEjvgXE7xD8Xy8bjvFfDAZHp1W7QfMp0OmO5FWmOgt0K/
	9EfrnLuTfBpOqocSQ91NjHPPMHIbHYsnG9joRW4tZMukmF0V65An47VL6OpIaF/G0C/PQZjBjtU
	NIKUu26SOBvs4vSVr1tlK3Bz5y78RoIixNevajd8/NSxwmcUCVbRlDvCKM5maObTouEm8Y4aT2x
	0+jSxhhmkx+Bl+SiBs6PwKlGoueFLvYTUv0/ARzdJyql2PIMMHkKBYgSmn49Dn3ChVZH7fL0xLL
	lmyQKwOhbffHFuN2NMKdXi8Ff59pv5FAHJxvjVeihmXRAi7CihpRFJHqySNRrZs57lEMDMvsJKF
	HNarSEL8dYo/FHJGwS9RDBZIcu4VbsRr
X-Received: by 2002:a17:907:5c3:b0:c36:a4b4:b1ed with SMTP id a640c23a62f3a-c49bdf2b4ebmr204254166b.11.1793193196093;
        Wed, 28 Oct 2026 06:13:16 -0700 (PDT)
Received: from [10.0.0.21] ([188.146.170.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd798391sm601342666b.71.2026.10.28.06.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 06:13:15 -0700 (PDT)
Message-ID: <0d584595-4479-4116-a52b-710e01f20bb3@gmail.com>
Date: Wed, 28 Oct 2026 14:13:14 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: chemical: add SGP41 driver
To: Jonathan Cameron <jic23@kernel.org>,
 Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Akshat Chandra <notmissinge@gmail.com>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>
References: <20260831151235.64076-1-notmissinge@gmail.com>
 <20260831232157.27037a5e@systembl0wer> <20260904042215.0e21cf29@jic23-huawei>
Content-Language: en-US
From: Lukasz Kulga <lukasz.kulga@gmail.com>
In-Reply-To: <20260904042215.0e21cf29@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 05:22, Jonathan Cameron wrote:
> Whilst it should be a separate patch, the route here to use
> trivial-devices might make sense.  Only thing that might be
> worth documenting would be vdd-supply.
> 
> I'm would be looking for description in the cover letter of how this
> is different from, and not suited to extension of another drive
> such as the sgp40 (obviously there are more channels on one than
> the other so it isn't trivial!)
> 
> Jonathan

Hi Akshat,

I'd like to pick up SGP41 support, taking the approach Jonathan
suggested above and extending the sgp40 driver rather than adding
a separate one. I have SGP40 and SGP41 boards on the way for
testing.

Unless you already have a v2 close to ready, I plan to post a
series in the next few weeks and will Cc you on it. Your review
and testing would be very welcome.

Thanks,
Lukasz Kulga
