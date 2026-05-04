Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348C282F10;
	Mon,  4 May 2026 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915658; cv=none; b=MztDhQ7IxndWCFsv/GYk5iTM1tQ8xyshgFUBorGHtAv2kjf+ODdvodnNBKExe//2X5JhfWZfgmydRGqPHwg2HWj+GPDhV4euVsWoFC0UeN1qMnu3f/pbapGCJDRDfP3AkTFAXSRPlXZjhlZutUgCzQMq22qrJAz0eSubc7DCW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915658; c=relaxed/simple;
	bh=ZeuRXsf87zEEWTj8RHS1t0NWABMXd1sj0Md3Y2gbtas=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OrE8kozeyQbWPrdcEccqt3tc+cwRL14DRpj3OWZuFx0OcvrBfpENa/nhZkUMBlLpDwT3zOf1hjXs3hr0LOmd84YAQ1byp5iwXBaQ059yJS4jcE+5U50YMYVTJQ1jyPuw8KgszagO0+qM1dXaNE7m6mhL5pz/dsJM8DnrsKLXBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=wG3iz1af; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AnyzUp4F; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="wG3iz1af";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AnyzUp4F"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 46D42EC0307;
	Mon,  4 May 2026 13:27:36 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 04 May 2026 13:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777915656;
	 x=1778002056; bh=PKhOnIqkD7OddmCvXQ+7Bvp5CGMRz9+KcuJBJZlAia0=; b=
	wG3iz1afyziRW/spIsFmx+E56N4iunySx7s8DU8ZZ/JzUUTKv/tW4+6XftpGF+jY
	tUJ5eSrP7UqpnS412VXfC83r8QYpu4POZ47W7radouKCwG1ZRwWxxHixAasC7/IQ
	4jMh6nqtWDUo1AFecrRyELJs4FvsuYYbRTtFYipq7euRrHsiRHEnYjYhdBtuVDNM
	RYOB0VR16BvEzkJsxUpsgRa8WMR5nGOZUlgTbYAzX8SoB7bCHrYV9temyfpCCleT
	8ijzVQPa4ir70EF2tilpV9sipjGva8GAtJfMP8caGMyFVGBo1nw8i83nwts39S+b
	FshmKoNtp+6fnHkQa65s5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777915656; x=
	1778002056; bh=PKhOnIqkD7OddmCvXQ+7Bvp5CGMRz9+KcuJBJZlAia0=; b=A
	nyzUp4F6JOgsx/s2h1/jgLFhRpewE1TO6Q6IrJ9nP9cIiRpIMqMJ1PpmjCCPY9+T
	zBdQDHI1QF0L2taGzG4MRuvc9dXwegVJVgohq+Dhuhh+OumAyKRf3BueJHKpUa5Q
	0xaS7DQCyvGZhh+izlU2IPE25SVi1aDsC53Km26sUgqzTlUHnyp6pYyqY7Iz8j22
	YHTOsx4pOEVI8lA2beW80X7vTot05tTJww+BXBwjcny7CrdK78TJL5xIOAxlATpf
	3tOcUAcnHGsJhVCG/DtVxbcFB2L0vMeYeqTTGwB4dgzN7cZxAEcbde7Kw9Zfkuep
	UfnymMQ2MN5aDFwN5zWDA==
X-ME-Sender: <xms:B9f4aQE45qs6GXeQUBmBZ4RCQxyqCtU5SI74QyIv2V9XpXhtZkK1DQ>
    <xme:B9f4aUKS0WFZ6qLZ8HVyMUajYySmrvAVZyXqGhUqkmQKJYnI6AiFmWuTPfSpCLePR
    OqvdzQitYrP8ZkZpXbvs6ONDu5Bvzv9fdAfqBOO5w4dL-Qm0oXX66TR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepnhhunhhordhsrgesrghnrghlohhgrdgtohhmpdhrtghpthhtoheprg
    guuhhrvghghhgvlhhlohessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepughlvggt
    hhhnvghrsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehsfhhkihhnghesfhgufi
    gutgdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhs
    rdhsthdrtghomhdprhgtphhtthhopehmtghoqhhuvghlihhnrdhsthhmfedvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheprghnghgvlhhosehkvghrnhgvlhdqshhprggtvgdrohhr
    ghdprhgtphhtthhopegrnhguhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhitg
    dvfeeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B9f4aXqD8Y6YHMd90HQZp0EfrCIxZBNxnW7F2OZm7HGxXmkRnKOVKQ>
    <xmx:B9f4aaYylXYuqJyKS87d9f5zkrH1zUwBm9uKvSCoh1OalPvu7Vacww>
    <xmx:B9f4aS7Urnh_rpGGHp2v_ZThVAv1j1RaCBYxpBMhXMOqOYNcPtePMQ>
    <xmx:B9f4adRClFUUKW7RDce4XDf0L5E-X5YNAfOQknuYIcuToWZWlnp6Pg>
    <xmx:CNf4aW9G3x_OAzZitTHBOu0WPZA0WgWEgHNMJeleLaAlF1Ah_ZjpushM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 37100700063; Mon,  4 May 2026 13:27:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMJQmnOn-FE-
Date: Mon, 04 May 2026 19:27:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Angelo Dureghello" <angelo@kernel-space.org>,
 "Greg Ungerer" <gerg@linux-m68k.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Steven King" <sfking@fdwdc.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>
Cc: "Greg Ungerer" <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 "Angelo Dureghello" <adureghello@baylibre.com>
Message-Id: <965cb599-37ac-4d69-a8c0-015152037139@app.fastmail.com>
In-Reply-To: <20260504-wip-stmark2-dac-v1-10-874c36a4910d@baylibre.com>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
 <20260504-wip-stmark2-dac-v1-10-874c36a4910d@baylibre.com>
Subject: Re: [PATCH 10/10] iio: dac: add mcf54415 DAC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 4, 2026, at 19:16, Angelo Dureghello wrote:

> +static void mcf54415_dac_exit(void *data)
> +{
> +	struct mcf54415_dac *info = data;
> +	int val;
> +
> +	val = readw(info->regs + MCF54415_DAC_CR);
> +	val |= MCF54415_DAC_CR_PDN;
> +	writew(val, info->regs + MCF54415_DAC_CR);
> +}

We've recently discussed changing the MMIO accessors on coldfire
to behave like all the other ones, which makes readw() and writew()
have an implicit byteswap. An additional driver means one more
place to change during the conversion. Maybe you can use the
new mcf_readw()/mcf_writew() helpers that Greg has started
introducing? Those will keep using native big-endian register
definitions.

       Arnd
