Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500686;
	b=xWu9mIU0j3cD+PlFwtzm218TJu/1zVFocPTaowfutyjlxbD5+SNGixRZeXssfQsyPfIU
	 ckTCaxu8zZ4OWwLOVQVdOvZwtHIa4cwOEZWq9AQVCueaUX/fGDunN9lJAnPsrgvPGGeCZ
	 ieOHkDuls+gNU7qMl41yX+c5bDY1YYvLvI49Mf6yxHCMqonvzYYmHA7FnwJSuNCNGqZWp
	 QIHTfx05Ofy9B952/rK0ObSco3vPaKemtTk93XIJ9MnJur0vReGLCeqlGsNSbD/D7scOk
	 +F7CIpW2N1jPIuM53l8ZkLBvFztZunPdduox3e+Q48lKqmcYPfKEBkd1OlraxpT2MZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rB0mddBSqsDlweoJ61uwS1PJuXMjqqw6Y6LVGosjryQ=;
	b=XMNhPoTHobwvlDfcms1J6K0qzul0X+V942cajfeGjMCtYHnO4jJhjjKbUxUzVm72rP7w
	 51xK38TISk7JwyvdK40hJWH31AFeCtdvTRFU+fHXdjbFOlvJ3D1hrGhvSmVRHMGYoo6sZ
	 DR3TkV8JmqMeOVyUbA0LR79myLa0ol1oxGXX/+KX4FseLUwn/yUB3nn9KlW0tYqq3BaoZ
	 hq+6xkW1vIK02cixNroz4yD8iTg4y1yvUCtYelG0rPT6VXhUi5XZESBwTYsgRv41SNFKz
	 a9YMb3cDQIRUd/oIgjotbUmjc3Hc356FrcyCPr2zTo5pMpEfI5o2/y7hfnHGORVt/+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QvPjYHvZ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB00606A31C
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 12:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AB00606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QvPjYHvZ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so6700079eec.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500685; x=1793105485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rB0mddBSqsDlweoJ61uwS1PJuXMjqqw6Y6LVGosjryQ=;
        b=QvPjYHvZJ5dYn6/iEdlxdaWAsIecFu48u8rOrcAApkyQ5hXrymlR0ZMV+8Ok78gUVj
         RDvM6FxRCmdR/K5V07s4VLJNqOOtSa3grFJCrhSHJnCcXzgN3Bi0IF69icDuicxAJ1Hs
         LsN054mIt6VDH/IOLQUmzdVPrrih4WQ6rblXNO+j+4cBYiHJ/29CoCoagL3CSqKoCQ0G
         JGIfwiD81BEbP5ZhZINX0vrKkYPbADiaiGK2Hi4IePyH0SaGOaeIHyW/O9SC1CJFXJNg
         4hScpqWV9Fm+vFI8qtGMk1qRtqwJ8qkNlL7pJWDc9AwJraB8gH4wsRrp9kmpU1k5TX0U
         go+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500685; x=1793105485;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rB0mddBSqsDlweoJ61uwS1PJuXMjqqw6Y6LVGosjryQ=;
        b=KEcdOVT9cgAWnvNVIl0Hr4ruzcjgUezOv4CjLE1vhMYoqQqaVTrAlW9Hck/iRwrdqs
         T5qeBDYCGDRvk+hkEFzhJVhVtRvBRo7eVl7vbZNiNxhzuJNpRa6acqwQ4HbblOEWqfrb
         kehiZ5B3M/GB2rQ11IG4sbqllzdnUKf+cQHeM6/BC3oIF4CetbdmI7ZnplH8kSysLYVD
         D/ieU0fPGb73QfTtpav0F55PDD4am1CLG9KTfqP2LeTkNcr0kgfjf42tzYyN1zgsjB0i
         im7zqNj+6O/8aNtEM/aa1y3HNwKn73X9+Nkd8xtSjUOdPCc1OAUsiLhEXMt/g5XUW0eH
         YWmw==
X-Forwarded-Encrypted: i=1; AKwUvByoosNKnLsmk1FwH+ZR1hFGmFQguErnTEYTu4SekUMUFQrvIF1kHvA5I8ghTxF/h3dsc37CpadhFWA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhnDQo2UEN3Tm9ZdKuyXyiTZjzE6goSNO3uMLZq1ztleM9/2+f
	gVGHizA+jT/t6JEPyvpS/sXAMJJON4JF7qgyVhkCPDWNz+tqoze1BhdW
X-Gm-Gg: AYBFou3rVnH4/ya+YGdDZmJTCAA/WKCt/el1Cincin54ENZ/vZBIXh+Bed8js5Qqn6I
	BNLCHNphBgKeNnvyKbmK1tdWcsdyODO70cbfogO6CNhyJjyYaZHVW1VcU6Rro0XIKxdTD8OZLN1
	UjV62yfQA3Ol9ge0CoHK2uwX//rrpJ3sSt+u64M693LX+15RK8Utagvy8A+gU5Mz5Bcah3MRNO+
	qjnA6wicpgMfn+1dSX1vuxyWqQHuLiC+c5U9q3JThjLa9Xpavqcrlv5fWiaNG9yjSNJoUxXs8PD
	wauBofJOUgoLkaaA+gQ38+cg1EspD6lY560ZEvEeN6DqhvqE8fZbnG9qycImnlZAox97UEk4ZUX
	HroXREE9/j6OBdHrroi1oWtD5+m+OfBZ2eUmX9c17PnlbTsCzPebfKLnz9V0TLRMpDknpG5Qjly
	8YAYAtO6VIwIz4Cm78iceoAHfCFZVMo7qbN8V3m8+uT27c6P8uJgOhD50F7tpICUp+ifwLeIdi4
	yYBgelTK0u4FBonixZyFEuYbNqbZYXKnBMsO7FwPCg4uU+omtA1vK+1Qa7gQoQwDujlrQ==
X-Received: by 2002:a05:701b:21db:b0:14f:fb87:cf62 with SMTP id a92af1059eb24-18512f1d04amr14840107c88.27.1792500685047;
        Tue, 20 Oct 2026 05:51:25 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314ef8ed8sm34558292c88.3.2026.10.20.05.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:51:24 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 20 Oct 2026 09:51:19 -0300
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v3 0/5] Add E notation support to kstrtodec64() and
 IIO sysfs writes
Message-ID: <ncmlzfubxpr2haygeaa2o7tauzvljstf555m5ej2rs5cu4nviu@oti3xkyqtooo>
References: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>

On 20/10/26 09:26, Rodrigo Alencar via B4 Relay wrote:
> This series lets kstrtoudec64() and kstrtodec64() accept numbers in E
> notation (scientific notation), such as "2.7e9", "1.5E-3" or "1e+16".
> It then moves the IIO core fixed-point parser over to kstrtodec64(), so
> every IIO channel attribute written through iio_write_channel_info()
> accepts that format as well.

...

> Digits beyond the resulting precision are now rounded to nearest, ties
> to even, instead of truncated (new patch 2). This follows from the
> second motivation: floating point values printed by userspace often end
> just below the intended decimal value. "%.17g" of 0.3 gives
> "0.29999999999999999", which truncation turns into 299999 at micro
> precision instead of 300000. E notation makes this more visible, since
> a negative exponent can drop integer digits: with truncation, "19e-1"
> written to an integer attribute gives 1. Round-half-even is the IEEE 754
> default, as used by strtod() and printf(), it is unbiased and symmetric
> for negative values, and inputs that fit the precision (including values
> read back from sysfs) are parsed exactly as before. The rounding is done
> before the IIO core conversion, so IIO fixed-point writes change
> behaviour only once.
> 
> This changes existing kstrtodec64() behaviour, so feedback is welcome on
> whether it should stay in this series or be sent as a follow-up.

This might not sound good, but I have increased the scope of the series a bit.
I think it was a good fit and it would not produce anything unexpected.

> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
> Changes in v3:
> - New patch: round to nearest, ties to even, instead of truncating.
> - Amend kstrtox E notation tests and IIO channel write tests for rounding.
> - Link to v2: https://patch.msgid.link/20261013-e-notation-v2-0-d4adb5e193fc@analog.com

...

-- 
Kind regards,

Rodrigo Alencar
