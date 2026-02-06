Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD42727FA;
	Fri,  6 Feb 2026 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366127; cv=none; b=GufgjnAMUOscPf21kbk3nvMpey89fTp5/8AfYOdx0I8AjD//8MjPkbqupnxTK9PQMdNSYs3pU3lTPjQcS2R07795DrmUqagDIeXu3OJuT2Ipuiaz2ZLEdk9wjkztjG+5x0026E+7/Bdq8u0lsozkXNMv2Nba5oX3VflgZGq4178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366127; c=relaxed/simple;
	bh=2dn6OYC6uXqXemjwgn17FZC/UWdF9S0PG9Ir1d9Xw+E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F1zQ+P7jbgX7NtgDmSFzM+vMq470a6FimKlYQezm1pC9GZiYHJK88IFVRvFHj7lfN8j6iAoCtFQMz0eVXsisIcaNEvy5YjrMK83O3R6DZb0XkbW5iGECjml5p3Nhue1oHkAhdg9pHi5H1kCDDGEu0K6j+MsQQu6GG2Vecu+oCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QuBVsouW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e9j8E5N7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QuBVsouW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e9j8E5N7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id ABEB4EC0218;
	Fri,  6 Feb 2026 03:22:05 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 06 Feb 2026 03:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770366125;
	 x=1770452525; bh=QM8lN0ZijwEypD2bYQjHjlWA62vBMiJ2Qc21XQUpg0w=; b=
	QuBVsouWaYEP9pP4vTnG+HCJ1o0D2ptOyQ3azLmLbFYLj+IsY+3H/R0tLWkhjKwV
	xWERgphmY8cbD+73sC8NT5/r+NaOnIXpmkhCSOBii5sLlZ7Z7W6kNg6IfUuHeZ3x
	ORilE/Ee68p0ZEtzeTvU+YIZ0sfLIqeGKmgAZO1MfqPcP7HMNdD8BYkoWkWrBaJu
	OfOXIncHtMUFjjs2xXIr9tsiji6GqJsJ9HGvUvJV46XIzO9e8+0z7+TZVeKrT/dI
	Smtk70HnixzpmctzKqjab+UfcC6i2YTl6iU+TscXI977k7PWmYHq7wTwozbUEreC
	O+FVxRtCwNIZJZxHlRhI/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770366125; x=
	1770452525; bh=QM8lN0ZijwEypD2bYQjHjlWA62vBMiJ2Qc21XQUpg0w=; b=e
	9j8E5N7J/iXrNFFxPiUp+u3IIznFlz0HADBu3e/P4H37/pGWwMlhc/Dp7FngQOrU
	QFJuxcpqGN8kDX889gVfuZBncuDrm2IpB+2vSXd3bJAxMWVNcdaJs7a2kOCEycgU
	ubv0nbs9dFpGOiQTsrmc4gxbB6Va9yKWNpHDg2tsIRK9k71c9Jpo0wkwKV5VyuEe
	IW//DqMAD3DiKzSCY+2/mgZSGWB9ZDgDio28AZKe1OAbJVYYkoUFSGarfqbl4aFz
	MjWuQ7SdeI2LMSrWNSnFjK0R6AkHgjJx1MGWQzdtEwUOcMV0YjBPoieNwvw+pB6S
	RWWqBz9ASTg+q9mmOU7yg==
X-ME-Sender: <xms:raSFaUqz_PAh3iNIFeC9jF78tH4dc5XDe51XzLZLrKNU7ByBsYlBXw>
    <xme:raSFaVemc_TQ3aa9aoG0nfv3nqCF338vW_AsyJ3aYXwHIQQ9pkZTf1Z4Z58-2xZAr
    QmdpWnHvdRyhhMtf5hcz27uCXVdTcgzwm3z77jY1OlH1fAuJBWBMWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtg
    homhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgt
    ohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjih
    gtvdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhs
    thhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugiesrhhovggtkh
    dquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqhhifmhhonhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhiihhosehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:raSFaQIxWHKD70uZ9pKQkOx-sBJDCyWkx5kaR5yP20InZgObPrdKCg>
    <xmx:raSFaTOr4QXxUt3NA6f_XlXaX1E3xWH4DiwwxznK29R50T7ZG_HVDw>
    <xmx:raSFabWOB6o3IKz_4DMr0kAXmLp6nITsX9CephKNXsa1-BUVLZYy2g>
    <xmx:raSFaZnYTI0qUt62pc2HBSewdjFgqI3NVafwRmaH5RSE4pL1SUA4uA>
    <xmx:raSFaX3KuwbQ7QIbAwLPDogc_Hyl7Bptob10PVgjn3lOJ7Sq9uOre_TV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0F0BC700065; Fri,  6 Feb 2026 03:22:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A62Mc5cPnZB7
Date: Fri, 06 Feb 2026 09:21:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jonathan Cameron" <jic23@kernel.org>,
 "Guenter Roeck" <linux@roeck-us.net>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 linux-iio@vger.kernel.org
Message-Id: <879b9cb2-95f3-464f-b300-ff8a8065b451@app.fastmail.com>
In-Reply-To: <20260205201126.66995e9e@jic23-huawei>
References: <20260204164216.544409-1-arnd@kernel.org>
 <b2fdaf5f-62b3-4695-aa89-b674aabefffb@roeck-us.net>
 <20260205201126.66995e9e@jic23-huawei>
Subject: Re: [PATCH] [v3, apply after -rc1] i3c: simplify combined i3c/i2c dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 5, 2026, at 21:11, Jonathan Cameron wrote:
> On Wed, 4 Feb 2026 10:15:56 -0800 Guenter Roeck <linux@roeck-us.net> wrote:
>> On 2/4/26 08:41, Arnd Bergmann wrote:
>> > From: Arnd Bergmann <arnd@arndb.de>
>> > 
>> > All combined i2c/i3c drivers appear to suffer from the same link
>> > time problem when CONFIG_I3C is set to 'm':
>> > 
>> > arm-linux-gnueabi-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_i3c_driver_init':
>> > mmc5633.c:(.init.text+0x30): undefined reference to `i3c_driver_register_with_owner'
>> > 
>> > This was previously fixed every time by marking individual
>> > drivers as 'depends on I2C; depends on I3C || !I3C', but this gets
>> > tedious and is somewhat confusing.
>> > 
>> > Add a Kconfig symbol 'I3C_OR_I2C' to help replace those dependencies,
>> > and use this in all the existing drivers that had already fixed it
>> > as well as the new mmc5633 driver.
>> > 
>> > Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
>
> I think can drop the Fixes tag now given there is a fix in between for
> the original issue.

Right, my mistake. 

    Arnd
