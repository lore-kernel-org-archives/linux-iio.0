Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.235.175.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321605;
	b=J0z/u/e/KUWZbt6AGuGEQ/B3aQ0F4z0xVoR/aHI6Znfs3M0bMJ1yn5L2usptYeRuCf8L
	 HkiKJXOp4DQKxn97jFYZmcyjGGx8XQCNq4ZelL6Vr5hfgshH+CtqB8uJF72iJr7TjcDLx
	 hR9Bap7qDtDLXGMY0gYOgjAToknuLA36JBc+1aLCpbpldpX1ksqhPvu13jpW3cSEkZFXd
	 X4y+UPKw03IRxfW0Dg4HjcLECfrxG47N2BHgCJE4m3s2IKJFkJxzs3sWnjIrFX49CiNcT
	 vE3876O3Bqwr/yiUfuZyyhZ6naJc1u+glEhMQwkesokIInJ2nwZ8eD6HYIROQRHC16A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321605;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=M6B7wm/MjtuZzcE3OhjP1XVp/XFHOdLD4wUFd9qjfr4=;
	b=oKrIZryz5mn/mHQlZSCuQfZ8mgsZxAVAuFu6vduMzrVBaE+ou6WKcaXvlJz1GU+c/9HX
	 vnYbhg/cELYFZ1cvqZh6EWljvLH5lHZl16xgHjx/bzDGbf7kIT4cStU8Ir3sg5l1pqdWH
	 MDH/fBHuTn3CU3XwoQmRUWP9wozg/2IPWAHfeyAxe5zjnfLncRcAoUg42DnFrPfHh+tH+
	 MFhKmOYAwOv+C+co+pyXh6gXz1tS8T7iXBRMtD8jgqid1D7WKA8wj9NSJ2LGweTrVazDd
	 qkY5Q64uOFYQMudgT8Tv3RJYLCgxUj+8lt2yOLoKz+VCkNbwnmjGWOg/SOeu+3zbSPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lechnology.com;
	spf=pass smtp.mailfrom=lechnology.com;
	dkim=pass header.d=lechnology.com header.i=@lechnology.com header.a=rsa-sha256 header.s=default header.b="0lbZ5Ks/";
	arc=none smtp.remote-ip=66.235.175.158
Received: from galaxy.gendns.com (galaxy.gendns.com [66.235.175.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5863606A321;
	Tue, 10 Nov 2026 14:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5863606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lechnology.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lechnology.com header.i=@lechnology.com header.a=rsa-sha256 header.s=default header.b=0lbZ5Ks/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=M6B7wm/MjtuZzcE3OhjP1XVp/XFHOdLD4wUFd9qjfr4=; b=0lbZ5Ks/8q3d
	2flJwauKAUZ/lQ/0eIhBVx4B0LheQPzvnyXEwe//ZBLGwmNl6+yDDI0TEZjfhJlvX7wc7YnErkVTT
	1nHnQP62X+qVph2pfPiLjwfDPRJ91GBF6uJJifymDYt/4Rtrn7FUsfUywMc0BJZHOw2IEFgSDTTt4
	latPJOylZtToWiOO2E0nthwP6Luu4sOa1dtcD1RiIB3kNSNXjShojLx+Q+n5rgw7LyuEVJRC7HopH
	OW541pPhuCGuPve5xxt725r3zTo8mwLEqa6TjvcxO9diJtUx2NHwzewzQHMIN/XSmr4pxDZ+ixBpF
	BBhIf87u+4izrYytBDXH1A==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:34610 helo=[192.168.1.143])
	by galaxy.gendns.com with essmtpa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <david@lechnology.com>)
	id 1xQn0x-0000000BUxP-1wd6;
	Tue, 10 Nov 2026 09:39:57 -0500
Message-ID: <75f2bbfe-23e8-4455-b042-3570c123832a@lechnology.com>
Date: Tue, 10 Nov 2026 08:39:56 -0600
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
Subject: Re: [PATCH v4 1/2] counter: ti-eqep: Fix runtime PM leak on probe
 failure
To: Andy Shevchenko <andriy.shevchenko@intel.com>, phucduc.bui@gmail.com
Cc: wbg@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 m32285159@gmail.com, nuno.sa@analog.com, sozdayvek@gmail.com
References: <20261109084342.51865-1-phucduc.bui@gmail.com>
 <20261109084342.51865-2-phucduc.bui@gmail.com>
 <avJV68gHL_jvZ6dZ@ashevche-desk.local>
From: David Lechner <david@lechnology.com>
Content-Language: en-US
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <avJV68gHL_jvZ6dZ@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: galaxy.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: galaxy.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 11/9/26 5:23 PM, Andy Shevchenko wrote:
> On Mon, Nov 09, 2026 at 03:43:41PM +0700, phucduc.bui@gmail.com wrote:
> 
>> ti_eqep_probe() enables runtime PM and takes a usage reference manually,
>> then returns directly via dev_err_probe() if devm_clk_get_enabled()
>> fails, leaking both.
>>
>> Manual cleanup via goto would mix managed and unmanaged resources,
>> which leads to the wrong release order. Instead, use
>> devm_pm_runtime_enable() and pm_runtime_resume_and_get() with a devm
>> action for the put, so every probe error path unwinds in the correct
>> reverse order. As a side effect, a runtime resume failure now aborts
>> the probe instead of being ignored.
>>
>> ti_eqep_remove() no longer needs to touch runtime PM. While at it,
>> report counter_add() failures with dev_err_probe().
> 
> I'm confused. Why the PM runtime is used (and announced) in this driver at all?
> Do we have upper layer (like a bus driver) disable power before handing over to
> the device driver?

Your guess is right. There is a parent bus shared by eQEP, ECAP and EHRPWM
that has to be turned on so that any of them can work.

> 
> TL;DR: what's the point in runtime PM here?
> 

