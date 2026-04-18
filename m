Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD402E62A4;
	Sat, 18 Apr 2026 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776543669; cv=none; b=OGjVuQUrGk7raaIbuWLswahSfK/dFca0sUDn+sRodGJCSU3F1mQWHJf55z6Ee1ToCZpmuvKlCZqRBvNvaDUwNXjOIbgQpzCr/m0gmgNLlXQdu2ci3j8BJBJjnIQX2ERaxg40t0R5Ma9QwcPTpW79CxzeXpvpus8PlCq81hyne7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776543669; c=relaxed/simple;
	bh=uKWlxl3GBp17vJ8wClbLm2X803+Dflk0Su16uBstMpY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qj1DjesWknWgVMnizgmleoG0csZJBM3f1OH1MOLzWwCqJSCVzYx3fcBGQwRNmr0xybilH1imaZ/VIffz26Ux9xnXipSTp66cDWY/wwXxRBu9i4Mwy1zay0SfTCswj4/jaZp15lX1N8tTCE6lUxJz68FzWip+95WQuI6Kw4gf7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RuQQ49jy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KUi3qRQN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RuQQ49jy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KUi3qRQN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 43269EC017E;
	Sat, 18 Apr 2026 16:21:06 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sat, 18 Apr 2026 16:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776543666;
	 x=1776630066; bh=hPYP9eUQ/eFYZOJFHq/Y0RBvgQgoNH9PKsqBaOrxT80=; b=
	RuQQ49jyWjn6Jom0CeSAIywm+FP+ccY6QfhsaL4mHv1Qjp4DSIdRcn0MXKyBYXpO
	9x/v/UJ/Ej/9PxZ0qllDKipoerwj9NnPqsvS/Zx8wnxUEr0bfLxvUpUxSCpmaG8/
	v3fQhpG/kTSh0wXrZ/WLWvD4NjGqiwAvlanBI5wSYJPZv9Q51xYnar96YEEz72lZ
	2BTtXVTpueX+MkoJFlAKZZ1MWlV82xsY5JbC6YhjelDMP+d4UUAqS9aLFUQ0c4CE
	KfwXauoJfc6bllK4Yv/SLGWCEX/c66igcT5GjJ1iCfPvawKT0AQj2sNDr88Yf4SO
	H7SxBJnB3mRZFitPvTYOAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776543666; x=
	1776630066; bh=hPYP9eUQ/eFYZOJFHq/Y0RBvgQgoNH9PKsqBaOrxT80=; b=K
	Ui3qRQNyT2ETE/LFDvK9Ld+axPSR3FvEJKbWhg/GBz1NR0NNL/tbVYAkq1V21FdK
	jYeY0wgTDg2SPM2QNSMI4Z94NZv/BiHapJux60u8ZTG93j5btuIR+N+g5wedb+xp
	cBqfpHxyr98g8UlJyatS8q+g3Bg5iLlTLSX9uCPLNEotxXYkZNv3WRjVfuGaUYv9
	CKP6m9/Sd2UpuRFVrZAXwY8FMa8KhCCxUn04Vkd4DkZroqEOEJI8p47KViRDuo/x
	HH953lr2fHRF7T7GsuHl6iIUEQItFAZK/i+vckjkQ1KK1re3TAj5/QY9Sk2LmqqS
	SEsfU652mTUgqB5gkxWmw==
X-ME-Sender: <xms:sefjafQETE3ukY_1sqjBw9Xhoy0upLAje-pBeuitv8ltOpWXeY0SJw>
    <xme:sefjabknUDqeOiPkznVbNq3XW5YJoeeZ224-Gg3lfnliFUlB9BUV-7M90Zzz3wVAb
    C0rTexlOJcFAN3f7BZz3S3chKmwh0QNABzV4glg0ElnSpcg-dQv5pAO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehfeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepnhhunhhordhsrgesrghnrghlohhgrdgtohhmpdhrtghpthhtohepug
    hlvggthhhnvghrsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegtlhgrmhhorhel
    heesghhmrghilhdrtghomhdprhgtphhtthhopehrughunhhlrghpsehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtoheprghnugihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhitgdvfeeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sefjaSALFtMZeX9IYriJ7JPFKlxgpcGTKtjXCEgGpZlTZ1tvJbAgPQ>
    <xmx:sefjaQNwp03WnTpqiia_87zeRhXzQNCcrCFlh5PQm77TCBEvXpog-w>
    <xmx:sefjaeOwKCNdEs-08Iqe4BxJ_ACR9kRhH1a84aY4FOEeEW2JxYwBaw>
    <xmx:sefjaSKKA6Mrsb8pnfgH9i5upaJX0piegCIlng0Rll1q22Wr7H0E_A>
    <xmx:sufjafiMrWZufyXkudmOG-EETmERMknbnGOp27aBU6FeYlFl5hh8pC-8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8FAEE700065; Sat, 18 Apr 2026 16:21:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4Pw2mV9al1B
Date: Sat, 18 Apr 2026 22:18:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Lechner" <dlechner@baylibre.com>,
 "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Jonathan Cameron" <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <6e9e830b-edb6-46a6-919c-8772b904262e@app.fastmail.com>
In-Reply-To: <36e3611d-642e-42de-9a56-cf81c3e06832@baylibre.com>
References: <20260418144716.132936-1-clamor95@gmail.com>
 <36e3611d-642e-42de-9a56-cf81c3e06832@baylibre.com>
Subject: Re: [PATCH v1 0/5] Update APDS990x ALS to support device trees
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Apr 18, 2026, at 18:24, David Lechner wrote:
> On 4/18/26 9:47 AM, Svyatoslav Ryhel wrote:
>> Document Avago APDS9900/9901 ALS/Proximity sensor in schema and modernize
>> its driver to support OF bindings.
>> 
>> Svyatoslav Ryhel (5):
>>   dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity
>>     sensor
>>   misc: apds990x: Use more device managed approach in the probe
>>   misc: apds990x: Drop Vled supply
>>   misc: apds990x: Convert to use OF bindings
>>   misc: apds990x: Drop IRQF_TRIGGER_LOW trigger
>> 
>>  .../bindings/iio/light/avago,apds9900.yaml    |  83 ++++++++
>>  drivers/misc/apds990x.c                       | 197 +++++++++---------
>
> As mentioned in my reply to the dt-bindings patch, there is already an
> IIO driver that looks like it could be compatible. I'm guessing that
> this misc driver pre-dates the IIO subsystem. I would have a look at it
> instead (drivers/iio/light/tsl2772.c).

I see that we have a number of ALS drivers like this one in drivers/misc:

drivers/misc/apds9802als.c
drivers/misc/apds990x.c
drivers/misc/bh1770glc.c
drivers/misc/isl29020.c
drivers/misc/isl29003.c

As far as I can tell, all of these are entirely unused, with nothing
in the kernel creating the platform devices. The drivers that used
instead have all been converted to drivers/iio a long time ago.

Is it time to remove all of the above?

The notable exception is drivers/misc/tsl2550.c, which is instantiated
from both arch/arm/boot/dts/ti/omap/am335x-evm.dts and
drivers/i2c/busses/i2c-taos-evm.c. There is a similarly named
drivers/iio/light/tsl2563.c driver, but unfortunately that uses
a completely different register level interface.

      Arnd
