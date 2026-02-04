Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA23254A0;
	Wed,  4 Feb 2026 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223505; cv=none; b=LTB/2NEbtsHw+BztPaqwjFGpxVNoJhrL5Hh6dCAaFsFWMb6AVvCMHmtmNl3Q6qfyHdyUZf144BUNZ2rMHQi+XG1Ohsz0zREHAXq8OdV9wT9QUzlcltLRbrynw746Mw2H+wO335azdeB0YkbNa7yNb1r2SvC4xhuqYsGbgP1VM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223505; c=relaxed/simple;
	bh=xOKSUsRopa2S0eU3oN+q4riBdQRDTA5gMvixarpvBx8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i6jQeG7feo1fX2X4JM563foxmhbbnBnL/lCAFF1dYYWurrlju6lmLVhmtt0bGRNnewSvI7Dt/ABthVI6I/dIWfD7fqlbGQCXlyfC45b01ISPdNQanqplq618alwHUJsnqCWOMkRUc9Q7ZBHH0AC5L/4g1KR5zufTpf0ONsIzoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SSmGxKc2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y13BINuI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SSmGxKc2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y13BINuI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A801EC012A;
	Wed,  4 Feb 2026 11:45:04 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 04 Feb 2026 11:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770223504;
	 x=1770309904; bh=8ZDcifP4P4fB473XIUlUUVFbynGXLbl7un7iNzjpgQs=; b=
	SSmGxKc2cbUDyiKze5BUUTz72Bdz32Vae9rT47WI2G+y8w+sw5bj/IieMHaNiFp1
	kxbem8CLTwOzXuX1oWoasyu27sNEdNfgkQQJxLL53eJtak/0Sw36ibkOAJULMbWr
	PmFR2QG0fHCcJFKE2NHT7Zooo42beXSl4Txh91I2EBcV+uYaHNIwNX77dd0FIRjm
	eMt6AvEWI59dx3zGs96YE+PRSUI5Ndd9NQNEidudWP7QtBwT7AUIag06YemuHQPU
	GuoVsGoAr6VM8rfAUIZNP7oIucNGEUF8yImOakazZAor/QjgXjGXp2iV0hTJ0Adr
	AHz37t3vlyS9W7TR8jxnzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770223504; x=
	1770309904; bh=8ZDcifP4P4fB473XIUlUUVFbynGXLbl7un7iNzjpgQs=; b=Y
	13BINuIsuZMcfWNAD18WoPWecFxXHUVFmbl8gyAR7wTDz2HZz6yxaH2NB2RLnCvS
	O/4nLanot9cVuPwdNRZVNPWKXS7Mw0GSlxlIpmLmI9KyHnVVqKixWOT28rdRuT8m
	PIjJh14czpKB2bXqBMsOXbg9AvOUryCZxgV7RPj56oinx9T+NHRRpQPvAs+vU29Z
	3TJ31fVXe28S7z/f+bvd2yOyTmGBcWmx7j1zlsrHd/WEyEjLZ1HsQfFCOp8xPi3U
	XNCxeWoYEDLpw0Gln68LOVIuLnRV3DDh7o3kRu5FiHV3UjCeDfCn3iBfyFtjrANl
	8Sc6e87F6Iy0ntdfGDlHw==
X-ME-Sender: <xms:j3eDaQIh68sdHEBLAdgKKiE7_QPQZldYwvnbcwW_nMIkpRlEiPUmqg>
    <xme:j3eDaa-tKxhgezjm8XbjBgts7SZH6tPzuiRLUZbSZvb7ie4Rw1a2x1EuEnvo3B1sh
    j0hxqQdgHiZzxLBqaKXFd8lohEvMRLYww6xV9SPc1yyho_ShICCrbI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehnuhhnohdrshgrsegrnhgrlhhoghdrtghomhdprhgtphhtthhope
    gulhgvtghhnhgvrhessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtoheprghlvgigrghn
    ughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehflhhuth
    hurhgvlhdrrggurhhirghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihih
    rdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhguhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhh
    eslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:j3eDaciJcp7UtbcI1E9MDX-n3vBfvJ0rcnVXBG0KFsHRHtM7r78OFg>
    <xmx:j3eDaWj2z5XqSxaZmgqcMnpRbASTJ-3PavxoJQsnYk-QXIMmmJvdtA>
    <xmx:j3eDaRszcxuuCQ0msJ3HPtyeIIpklvW-S-OEG6DruxTKF0a9Wm40hw>
    <xmx:j3eDaUu3msNgbg0fnnMvVsf1BNg84IdVR9SbZSVXp8FsnosJVoUGTA>
    <xmx:kHeDaae8ybN10he0zJRdQ2G7hDG_u7LYKWGUeEESRIsKi6Rgxk5-_z7Y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C77BF70006A; Wed,  4 Feb 2026 11:45:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEyqQNis3263
Date: Wed, 04 Feb 2026 17:44:37 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Jonathan Cameron" <jic23@kernel.org>
Cc: "Guenter Roeck" <linux@roeck-us.net>, "Arnd Bergmann" <arnd@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Frank Li" <Frank.Li@nxp.com>, "Adrian Fluturel" <fluturel.adrian@gmail.com>,
 "Carlos Song" <carlos.song@nxp.com>, "David Lechner" <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Jean Delvare" <jdelvare@suse.de>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 linux-iio@vger.kernel.org
Message-Id: <207e6197-ca3b-4266-9b96-49ad5ec56fdd@app.fastmail.com>
In-Reply-To: <20260204162604f55a84b5@mail.local>
References: <20260202160543.3654499-1-arnd@kernel.org>
 <a8f8ee55-3c87-4e9c-a5a9-12929855b86f@roeck-us.net>
 <20260202205011.221c1359@jic23-huawei> <20260204162604f55a84b5@mail.local>
Subject: Re: [PATCH] [v2] i3c, iio: fix i3c driver dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 4, 2026, at 17:26, Alexandre Belloni wrote:
> On 02/02/2026 20:50:11+0000, Jonathan Cameron wrote:
>> On Mon, 2 Feb 2026 09:50:58 -0800
>> > 
>> Hi Arnd / All,
>> 
>> I applied a less good fix and the pull request has gone to Greg for
>> the IIO bug. I copied the hwmon config you have below.
>> So I'm absolutely in favour of this improvement but it's
>> probably a case of rebase after rc1 and it goes in next cycle.
>> Or maybe Greg could pick a rebased version up on top of char-misc-next?
>> 
>> So with it rebased,
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Sounds good, thanks!


> I guess I can pick this up after rc1.

Ok. I've sent a rebased patch with a slightly adapted changelog
text and Jonathan's R-b.

     Arnd
