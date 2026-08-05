Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C53E3C50
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914786; cv=none; b=noyWkv+RgSREQiHFb8UMAfMQqZjKLXCpKwskbUKYGeZoaexo4s6rcWhMxe4hb42YgD6i7CuO4Hc7/3tzOtXtBGhpOcr/bJlnxtUZOL8x70r1NHHtmMSNc0P3yjZLG0Eyfw9xGQ2fC8WV9Q/ThBwdgAdk7FyZm5Pdj92IX85TmrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914786; c=relaxed/simple;
	bh=wjvqB3IJjwoVYlpfTDuT7J8G2MSWTTWsKLIOnNAuzTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lU52jglkokioo2SymTHkhb4JFKta0pQQnDoUt7anY/mfAQROO5v3szMYmvwRwFhFH19GqpSmd7wlS86xRGcyFxUST50lHuBsQWQQjGcAmSVW4dyywWJbQyyAU1KQYw8Iddz/NvKayu0+YKrRlczc6WUHUhKsnvi+EAKigCQ/yuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=l1N++3BM; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="l1N++3BM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785914782; x=1786173982;
	bh=wjvqB3IJjwoVYlpfTDuT7J8G2MSWTTWsKLIOnNAuzTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=l1N++3BMJDl8U+y3hin3J935eAsttWEl/Xxvh6ei9DuxtTNQJ5qaUMjIBQefyiagy
	 Tp6GAW7wOY3KSx3ydy7AEwoWhDPBuvwlNXR5z2Y/tUzISy7tGDp182/6Q1Bc/pU+eZ
	 uqz0pgHtDOXnLYQ1R5liCs9Bb0AgxkV7U/zGPKD44TMOvFl89A9p1mA+Q3PGEBwFcj
	 Vyh+hLdk3/4C/OmpRJZWh0OFc+ovBTWnrvRipIWiG9+Q/U9vdxaWHjen+gPLiY1krl
	 nZiGN8UFCW2/P9w2YyNtxb+bgfXVVVGNjGDUg74N4x5tgI9fXV9aN/Re2grcfkLjZo
	 ZiWvE7zQeXztg==
X-Pm-Submission-Id: 4hFMR03Z0Bz2ScQF
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
In-Reply-To: <20260804235400.3f99d3de@jic23-huawei> (Jonathan Cameron's
	message of "Tue, 04 Aug 2026 23:54:00 +0100")
References: <aldH3vtk_eKh6oCC@ashevche-desk.local> <87ldbco582.fsf@geanix.com>
	<Tu8Mavh-mfl8Vv75Oab3vrghtEbTXiYPZ4qhj6RZv8xe5nWKP4lG1KSuJXEQfyKeio7zv9myLbmifMjFTl8juA==@protonmail.internalid>
	<aleQVYrK9YBoLqGl@ashevche-desk.local> <874ii0misv.fsf@geanix.com>
	<alefh86sqW-XvLHl@ashevche-desk.local>
	<J2apVLUJhrI3AOweGpouqGGB0XhxbcqLiWasDpOdm4d2YGgNv8PuE-udUGJZcH0z-V9yyqbjIwMKDdtuam0mp6ya5F6GHUzf6OjRCo0GdaA=@geanix.com>
	<nnp75d8J8In8paKGfojb_WdiRMfnz84lOlzz_LBKVsxDzR3fG7Y5Mn91q6P4BF2LetfZS7da2SeqGhpiLUOE-A==@protonmail.internalid>
	<alkgZTnHyvEasMCk@ashevche-desk.local> <877bmtsu1h.fsf@geanix.com>
	<alpqq3zhSS_iYGJq@ashevche-desk.local>
	<nlzE8HA1b2C6D9P6L63VNtKUWaXbUTxoJB5c3K4eFLIrEkoV_2CDQNp50cj2ILfMni0Rjz94guWdLadq2ewdHw==@protonmail.internalid>
	<20260719023035.2380e8df@jic23-huawei> <87tspb63oi.fsf@geanix.com>
	<RuqoMWPGexWkNKQz7GTa2WKKFTYQ1iZXAYp7Hub1YDdiifvVKmLnOmCuoCUDr_Jk2wulpLH_FGdN7O-TQcKaLQ==@protonmail.internalid>
	<20260804235400.3f99d3de@jic23-huawei>
Date: Wed, 05 Aug 2026 09:26:19 +0200
Message-ID: <87a4r1auzo.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Mon, 03 Aug 2026 09:53:01 +0200
>> >> I'm on vacation, but I disagree on the approach taken in this patch.
>> >> I leave it to you and Jonathan and others to settle down.
>> >>
>> >> Here is my formal NAK (to this form of the patch, as I said, w/o shared
>> >> support it might be okay to go).
>>
>> I would like to find a way to agree on a solution with shared support.
>
> Hopefully Andy will be fine with what we have above.
> I'm fairly sure I talked him into accepting similar in the past ;)

I have implemented the changes discussed and submitted v3 of this series
now. I hope it is better now.

/Esben
