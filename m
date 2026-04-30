Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709B45BD45
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574701; cv=none; b=miuaWZDsswQqVqTS3c66cIJ85OAjxuoUAYW830FQc2TmBJpwh8YDZ+0JZn0NnEWg/+c6n2F0Gr9RNfIoHaRL7Z58WPUIFJE6Xi6tbziNvcQ+cFVgkAU4kRSyfvyo/SI1a613SEyOEnim38resohD5SZwqxtP8dzyH2EV1zLZPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574701; c=relaxed/simple;
	bh=VLaVDgj8ZnPayo8eGy9SjLSzOJdW7XJIBwRRpCmdxgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsLZVFPrvQH/9IXEFIR+H3c2Hb+s9Q1Umh+NrGgcRdifWg18Y5yml5Mi0R0w/Vsk5gL7xGRfkjoZySz6BllRKtJAC/nk4s9DiX+czclqpufYUHAwo3eyvii+lWpLjMD8Jd85Xup66HTzHLi88RwjO4ZRgJV7+4HQFJIqLnKCQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oNQWsgu9; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oNQWsgu9"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g62y12MvGz9tZ4;
	Thu, 30 Apr 2026 20:39:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777574345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY6ny8OXYXVlyrp9UBKxhkCC4vNYs6VOM1f9rb+Dqvw=;
	b=oNQWsgu9ZqGUu5zMFpXIcQUD/9HYXUzNwWrvaPFpG0Lt6SLe1gSWtXEI9ope0jtwQy3t5K
	IPoVsFcsY4heckYxRARuVxjAz8ew0kMb8XjWhn/R1SGfqij0lfFjGdXVEgF6gA3rh4vBEu
	vTjzDNCD9tXZCsuM6DOjIQWElW6H4u/5ttlg6AirQfZ+5RrpGw8CqY0eEJH5H7rkwVrH+0
	tAqNx4UGcT6oBW21npgRIDDi1sdh4uEaGfak8klRhi3MpWlT+wkGp+hBPjPGWlxofn6bFW
	Ga38NC1U4gviSouT8ihFwrY1U8+TQZ5Lv9jpZrCa31+7kkE3fbGu7keRko3yTw==
Message-ID: <21265bd7-e3a5-4c35-a087-8fb2112afad6@mailbox.org>
Date: Thu, 30 Apr 2026 20:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: adc: rcar: Fix up Marek Vasut MAINTAINERS entry
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>
References: <20260429192751.543190-1-marek.vasut+renesas@mailbox.org>
 <20260430172729.262fb6f3@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260430172729.262fb6f3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: soqzi9fj33b85reaet4itbz16qpzf18r
X-MBO-RS-ID: d3d7ccd3eeb42996e0e

On 4/30/26 6:27 PM, Jonathan Cameron wrote:
> On Wed, 29 Apr 2026 21:27:23 +0200
> Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> 
>> Use up to date address. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Applied to the togreg branch of iio.git
> (I'll not push out for a few days though as travelling)
There is zero rush, thank you .
