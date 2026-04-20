Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489D377558;
	Mon, 20 Apr 2026 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674025; cv=none; b=jVN1r4X2ynQ7Ao109oMyKZ0/WZJ43NzU9sxSRcLjqGD/x3IGmkhS799dwfrYVAWOngxbNJpk9BAN3TCwLCyleknjYgOW2fbyyJYARRqTDtXke8mIxRYDl270kT0YikiIbV07jh7PVV8wybEn9SAmLzSZjgqIKX6fOsgHI/xneE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674025; c=relaxed/simple;
	bh=ZE03wWhZsUseRUuH0pap4nkT/0vVyl3JaI1R/jMFHk8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lVbIYwFpQCVGyDeG+g1VEzQIuwlLbkz6rrhRBfJYvA/1/OAF9POexaIj75EcW8GS1xqh8AgFTxhHKejLX6JqzrnN6xC1bTpb/g9FV8OSUgrEJzEaMUfC0ohWmUsVuPhlkY2jSi3fyfC49fv0LTSr2GWYFOhn8qHRF/r8S1hipYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AGfjwo7D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qjkyUWd5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AGfjwo7D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qjkyUWd5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D9EAEC02D0;
	Mon, 20 Apr 2026 04:33:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 20 Apr 2026 04:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776674023;
	 x=1776760423; bh=tXaO/nAR364cIIXq3MDm75ZMhdZ7UuAUWKwuLrwZUUw=; b=
	AGfjwo7DotA/7U7GcjidNAmPidJ9HfmBEeQYBOrSx19cax0M1rhsTcPalsn1HctY
	yYiL+PYusVawDGIXyt87dBvl6wAas+rN5l828AxTURP6gEukZZQBADHY5IGZuTB0
	RgLjBVSmwKBfeCwN4DHIW6jVbsXTYHgw5pRY6thLo6G56JMq7ZJRshNiCp6x7h2N
	RJHBTFOwcj4v/SCZY8fGxrgrI5M8BRDQVnOoThDsn2trEu8WHSgaxaz1eP7zH688
	F0ufnXE+sYUlbJb6+S5buhcmKv9qqwJXI8Kl7Kmm70yVnBDYevqtCqfPAG8KiadD
	lxiP6tW35TyPZkupt5GYIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776674023; x=
	1776760423; bh=tXaO/nAR364cIIXq3MDm75ZMhdZ7UuAUWKwuLrwZUUw=; b=q
	jkyUWd5xIAm/xzyAlgr9W2lqGk3LTmziPofvuLDb78khAiDudYhyFe4c8nXjVurC
	ZU+VIMsqLTPtvQOaX5f7RFtiujgHL6oTT349RHK/AzbvhGkKZuaeRQHOr6EVXLMN
	GKfRlsdToKzNFR+SHDHGjTfecJTOwLoVvws8dFWGidEK84ofK6yvygGbU/HPk/fV
	bgBLcV84uho3JNp6Ayo7j28zcUdty02iSl94+rSPbc8ut9fxBL91BIgbJDD5hKj0
	FyP+o9ZYrWxVwGhcjLiTdR6mH9uMhYzJhHXynvWb8AhnRzeR2OUwfXdm7m3RwSA1
	vF4FBysPVO/yeZrPy5Acw==
X-ME-Sender: <xms:5uTlaWaVbr7y47rZSQ8c6EtUXo13oeA7eflBzhVLwomEKxsnnAJ8LA>
    <xme:5uTlaUMU5niuCsa7IHlu9RF45nUElPNNUQhbGcfvA9i0WJOaSc6Bd6DQBa_wmv0K7
    Ny_mFSeVO_VIg4CJEgWg0LRApb3qmLddt1jZN31xQ5ha8BQsROj1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepnhhunhhordhsrgesrghnrghlohhgrdgtohhmpdhrtghpthhtohepug
    hlvggthhhnvghrsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegtlhgrmhhorhel
    heesghhmrghilhdrtghomhdprhgtphhtthhopehrughunhhlrghpsehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgv
    lhdrtghomhdprhgtphhtthhopegrnhguhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgtvdefsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5uTlaSmZnjeoDKBryYtTwZsVA6Qy8uDXRx4Q8Qinnw-aKxvKM-IYFg>
    <xmx:5uTlaVzLMjUKP_h_vXJglemObjU2HAT9HIx7VQS-B0K-uS2SGmsiaQ>
    <xmx:5uTlaWzaBk1Vz1zkamR3L-F1UCeUKOHirF5G3FwVhp05w3f0wQm9nQ>
    <xmx:5uTlac_gXRrZc7NHwzl4WCzRjRFxa1qjAeFect2HqGwFXD_9w03nfQ>
    <xmx:5-TlaXrNE3mB-7CCnE-U5kjbMDGOXO4quzldIfCmZl4ZhwZcsuSiMxvL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C8E1A700069; Mon, 20 Apr 2026 04:33:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyRRm7xDvSp7
Date: Mon, 20 Apr 2026 10:33:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Jonathan Cameron" <jic23@kernel.org>
Cc: "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "David Lechner" <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-Id: <68c671b4-6754-49df-9fdb-2b3382033fb3@app.fastmail.com>
In-Reply-To: <aeXh7j410AxESy4U@ashevche-desk.local>
References: <20260419083125.35572-1-clamor95@gmail.com>
 <20260419083125.35572-4-clamor95@gmail.com>
 <20260419143346.45ed78c2@jic23-huawei>
 <CAPVz0n1qrSYr16zSSqRHuTWVkRfdC+c9w+mxAhtzgfHzL41XFw@mail.gmail.com>
 <20260419172216.3cf10e51@jic23-huawei> <aeXh7j410AxESy4U@ashevche-desk.local>
Subject: Re: [PATCH v2 3/3] misc: Remove old APDS990x driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026, at 10:21, Andy Shevchenko wrote:
> On Sun, Apr 19, 2026 at 05:22:16PM +0100, Jonathan Cameron wrote:
>> On Sun, 19 Apr 2026 16:41:24 +0300 Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
>> > =D0=BD=D0=B4, 19 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 16:33 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:

>>=20
>> Their userspace will be broken by dropping it.  The lack of upstream =
users
>> makes this less critical but it can be argued it's still a possible r=
egression.
>
> Usual recommendation is to google, and check Debian code search engine.
> I randomly chose a couple of sysfs nodes and only kernel code refers t=
o them.
> So, at least there is a good sign that it likely not in use. But one h=
as
> to perform more checks (all attributes, more sources of information) a=
nd
> summarise that in the commit message.

I think in this case it's sufficient to point out that there is no
devicetree support in the driver, and no pre-DT board file ever
declared a platform_device with apds990x_platform_data in mainline
kernels. The ambient light sensor drivers in drivers/misc/ were
all added in before the change from boardfile to DT, and from custom
ABI to drivers/iio.

     Arnd
