Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91334107D
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087946; cv=none; b=lt3oDYI9hSW8f+Eaf6dN8K6gUBNkwWBtTEkpyPnamg5jgazy8QSNhm6Q8eQQg5yuNjVkpf0F2j8o9yJNsflt+MZfV0dFPHSuzI/1Qye5Vaaliwdia5DlilZVPukzvdWzD0Oj15epvmEhqZqVg0WnQnquvOSgyx/rxQFKlprR3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087946; c=relaxed/simple;
	bh=unZyHVEipl9wdEWFBpOzZAY8m4Aj3u2FhP2DEVz2+VE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FG1BO1UTAW9L4AVNm9bpb7jWs3RIZjKUv7cIKWHkMYnIy8p+19swfSYJmgK1upssatLQALpTTgYzyDhHryDChf8/ZSu+OSUlrtdqXQIQ96t0UYCznMN6IL/xSfw8NkGAtP5hC03L+KtEEbEqDYVxIjtZKyOHMZgeGAJR00zhTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=DeG4ygGW; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="DeG4ygGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1786087929; x=1786347129;
	bh=unZyHVEipl9wdEWFBpOzZAY8m4Aj3u2FhP2DEVz2+VE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DeG4ygGW8G2ec6P+5H3tLB1u4xfYKnvgVHhRXMU4YCKQ/JBf6WCGm5yx6hVotC+Ob
	 pTTQ6uLov/tHcDqXEikbq0M7MKtoTigXpNemWOwZwdo9MH5KGA+iVgdftoKY2urYdB
	 wIJh9y/VlqnhcwApTJfFjU5DhDttXIFDHcx+lTXz2FBHewBOftTbUWMO2+b9WxNdhH
	 mVVhepRRT8NZwd8TNgC6dhVWWA+YCjemhdOPQyvCiCijrgG0PY3xq5DJgzXuG5vAAd
	 sHbyVGNnprvOJLLGuTEdMRHAKPsj73HUgBWHToO8gE9GX+Y6ftM3YT6PCKQFueGn/q
	 uFjIEsPhBxztA==
X-Pm-Submission-Id: 4hGbSk5SPqz1DDrs
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <stable@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] iio: light: ltr501: Power down chip if request
 irq fails
In-Reply-To: <anT-qMXnSJ2BL9x2@ashevche-desk.local> (Andy Shevchenko's message
	of "Fri, 07 Aug 2026 00:37:44 +0300")
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
	<20260804-liteon-ltr329-v3-4-c6b768c7c745@geanix.com>
	<Zg1kHClcaJDFipprnST6IAFp1kSIfzNtPzTtyzC1z4Eg_i5zCWZEysYVmODsCK7SrQ9uupp0K1upHP0skEoRzQ==@protonmail.internalid>
	<anT-qMXnSJ2BL9x2@ashevche-desk.local>
Date: Fri, 07 Aug 2026 09:32:05 +0200
Message-ID: <87mruyxu6i.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Tue, Aug 04, 2026 at 07:02:15PM +0200, Esben Haabendal wrote:
>> In case devm_request_threaded_irq() failed, we were leaving the chip
>> powered instead of powering it down again. Power down the chip switching
>> ALS and PS modes to standby.
>>
>> The dev_err() message was causing duplicated error messages, as
>> devm_request_threaded_irq() calls dev_err_probe() on failure.
>
>> Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
>
> Be careful with this. The removing of the error message should either go
> separately, or you should be assured that the IRQ core prints it for you
> in all stable kernels where this goes to be backported.

Ah yes. The duplicate error message removal is only valid as of
6.18.
I will split into a separate patch, and mark it with Fixes against the
change in devres.c that prints the error messsage.

/Esben
