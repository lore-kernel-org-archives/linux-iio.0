Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508515;
	b=pevePhKXsojzJf2rcmWvYlP95QvPZfwQCr4aSjvHl8Wy4t3cJGLwCepa1kO1tGgZU4Ew
	 044e2wwwnzQt7pRrG4HkTLBxUCKuhoIq0hSnq+CHUeX3O2RetCWW/AHwcQg2iaakf8NgT
	 K2CnsLuBugfIM48CXweuQSI1Urz+k7fTBOIS6WOS6z0XNSngUrMAqdN2UohkcsPYhPX0R
	 V2qh6j15+TH9sogvfGr4a7L+GqNOOck14q15st30UUmKewUnI1Zjm6Kwy+TlBoEZRfzsU
	 6i28I7cm+FxuzzPyKu9I6U6LxOSTRLwF0fzkaop0tTQfC2V2XCSnbDXhLclCLLJRQhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508515;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CO+fKCpu1tf03GanRs3KZIuxKyHrU5zsBgVc8okHP7g=;
	b=SmQf1YmKDZg1tFEiXdmp0uKeuSbXFsA1JszOsoHwpg+UE8A7Sz3wcJ44USltphk1S3ph
	 lxNT2IpnkFUrU5l8bzIg5MxFyXwcn4s16ryPivCuRkLQbCWwCf5dQ8zJycJYc8ogW7YYm
	 B2nkM0TzsSH1SZ3x7U4WruUU7ceQL3HdoHJ20kUpOZB0XQ93P8rkcTy9YDrmNJY3D+pHl
	 JDAMvO5CJgZged/d2jzZOUBtIK1nlwqM+dJ+PCLQ6T0TN/IlbORvGSMIAwHbLIBWLSimR
	 wOfSKpKLY9yiAod3YUd6PK9cdgQjZLd4eR65E3U/Fke0xyhv9AtMsLDmvoNWAsxIxhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEMEdmU5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA48606A321;
	Tue, 24 Nov 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEMEdmU5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43EB1F000CA;
	Tue, 24 Nov 2026 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795508515;
	bh=CO+fKCpu1tf03GanRs3KZIuxKyHrU5zsBgVc8okHP7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IEMEdmU5jd+d1WZK7YVmEy3lzTglLG9MXNz2IPD4QzFQ7v4+kvBM5UZ5hlwhMwAVp
	 9inc6e3JLirdW/ppxObgeEv4te+Ihkr1insCKtwcPv0EQoyR+aG/g+olB3NU+zWcR4
	 5+SqLeUkoygKfBw9c3kU19d18KrbtZI5YQ36RziYGHZIx0UtVC1CAvQK3BnMFdllq1
	 FYomlD3W7u9N990tFqDOueMwhWOKhu0zmcqwGp3OpEctuFTGJP2KhjKfCjHNqCO6ZI
	 /iJ0JOx0BvmIELBMSszO74zstU/7EKXAxMac0Q8d26N0En3zcyQpTIpNFEFdFjitpq
	 m5AnWywJTeECQ==
Message-ID: <6c9a0f83-b355-4256-8b38-7ecd57cbd64a@kernel.org>
Date: Tue, 24 Nov 2026 09:21:52 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] iio: adc: Use cleanup.h guards for mutex locking
To: Vaibhav Chahar <vaibhav.chahar26@gmail.com>, jic23@kernel.org,
 marius.cristea@microchip.com
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261123070802.14487-1-vaibhav.chahar26@gmail.com>
 <20261123172836.130440-1-vaibhav.chahar26@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123172836.130440-1-vaibhav.chahar26@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 18:28, Vaibhav Chahar wrote:
> Modernize mutex locking in the mcp3564 and palmas_gpadc ADC drivers by
> replacing manual mutex_lock() and mutex_unlock() calls with cleanup.h
> guard(mutex) and scoped_guard() helpers.
> 
> Changes in v2:
> - Patch 1 (mcp3564): Wrap switch cases containing guard() in braces,
>   add blank lines around guard() calls, and clean up the commit message.
> - Patch 2 (palmas_gpadc): New patch converting palmas_gpadc calls to 
>   guard(mutex).
> 
> Vaibhav Chahar (2):
>   iio: adc: mcp3564: Use guard() and scoped_guard() to manage mutex
>   iio: adc: palmas_gpadc: Use guard(mutex) to manage locks
> 
>  drivers/iio/adc/mcp3564.c      | 63 +++++++++++++++++++---------------
>  drivers/iio/adc/palmas_gpadc.c | 46 +++++++++----------------
>  2 files changed, 53 insertions(+), 56 deletions(-)
> 

Also, please don't send a v2 as a reply to v1. It hides your series
in people's inboxes and may potentially break tooling like b4.

-- 
Kind regards,
Joshua Crofts
