Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603003;
	b=4+ORnFAYn0WFPchHZMgdzgNuto8WSJJHmna1X35NIkiGGhVJ+6MM3qsqJg0A2JoK6/X4
	 EY46NsKfih477PAjgh2o4eDbMdlGonxTLJ3vbE/GXCg8CHUT3X8OrepPcj42O+bdIBNlh
	 1J3aK/MRTxrLA8Di3dy3QKgoiyL6olcgdp/pDGqmiz6MqPLA6kHm3+Iin0Kqu0Qb7GrTr
	 X1L8NnJ88Oj+epvDbKnxo0OBm2YRoiL/9dhpZipo/rL5LklgUq/3jxnvWfOHP1/c1r1li
	 l4yuV5AhCbIUb4tz4UyItxbDPp/MVKOdZccTE0l+9gMioLguTQfEUtf2mfd34XIHOxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603003;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=9QNZIgRLGXJkL1hUhl0BYMvpVZ296Sq+L6zrN27AYSk=;
	b=XsLFwmuyydgDpG678my67d7n0Tv6HtWiwgIPejv0K1XVZn0YdRRtHvrvjx2zAGKVkdW4
	 KdGIEAvW0Wd/+v78qVUFZsjhXGS8zw3e/gwacNqvIfC7r7IREX/waIo1tzhMFFGbUkyLm
	 hDgN42wdzHUv9o/EOHCCEVfvvSVcrNZZ+aiZP2G5fEJ/E+PihKrWe11K/RQCliq9dkVcM
	 4A7xtx/VOmt9yFE6vM3D2SN+rXNzF0hzTkHe/d5RaIYb0aNqE22erXjIUvJlX7IiR05dC
	 KBmnxHgwoWubtwFCV3iWL/NXFs95TbS/YOqRYRgizn5/ctLq6Sc171ImT91YfahL/vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=ioCyNiQs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=oYSQRy4V;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88650606A32D
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 10:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88650606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=ioCyNiQs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=oYSQRy4V
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id A7771EC0BEB
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 05:36:41 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 25 Nov 2026 05:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795602996;
	 x=1795689396; bh=9QNZIgRLGXJkL1hUhl0BYMvpVZ296Sq+L6zrN27AYSk=; b=
	ioCyNiQsP2P96haN1ZZCB3Usw4sFY9sZlQ8nqYzitKMCP6U399+jVTfPpDmQAScG
	loVBq7ssE6f14AYQyorsF8XYWh0Vlkbtwcfb8fgHNMaW/LdAs1PAfiytZftd+iKG
	ysTavQVbRiT6QpfgdoDm4CYl5Jdl3wEZC/FjZfQODEcS5FxL3NddLr1foxWdi961
	pFlfa1fISM+V91YzO4a74c3iBsZlDGq+xQSTr3O8V1BZz+9FmPppsP8EnFS+8Lf+
	77wjuzr4FzeLI7Oepr9Krjv9wLcgBCnWuXNvXEspYH++vuWzeQ3ucdeKWvHM+mGK
	bcFhgjIuAJqK4SETSw/sTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795602996; x=
	1795689396; bh=9QNZIgRLGXJkL1hUhl0BYMvpVZ296Sq+L6zrN27AYSk=; b=o
	YSQRy4VDfwJlpegDuc1Wno2pRIUJT3kNk5imGi6c0f8bgxljDgOXud8zG6OQZYFN
	7keOMtjH8o2q5hWr2rCo2XC4Tt7F7k7CCsrUsbA35GuWGy64UyemL0OJ83YPfhIO
	tj+AzyVDGko68boATBLf1GPgk7r0/HoZTAF2ykbqKHwGCE3AD7kHYa32ZuaHJVzz
	nPUUv4vox44d/4l+Kl7lhC28Ax8rJ0Th5P9v07CIGc9CXk++XvmwubF4fKR5QZ3y
	uz7t3fA9yuRm+XPQQZJMB4p+8FAs5+50EVkJpybmg5SwaXN71aDhcItPySvmgmo6
	jfVOApwKtROVg76NIWxnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795602996; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:EOQtFiYLjHC/J5i6onJtpohK/dyv+Sy6VQGeBeGytPjVDHL
	i0+MP4GN9cjn/eBwVffiKdC2r9GJLRHMsIbHVZ7z0W7s7F4n7uakut+KICxLUE6R
	gW0Vflc5V8BMP241E00RXfICOHAd9a+aNP5qBjT9MvQ6h5iZLAWytfgeMHCi4TgU
	6dzdCc72xuDYfNlCCGGWhtNJZ0yRwDWFyvk2kGgqf2KLgbZXlEZl7nu8VWwe4Y1h
	th9LILKtXyJE90aa3EMqpK6jxQdI1Mv7L0IZr8jsZpkv2mNNBi5wnFapdMvq2NJU
	sNujhWtE+5jjQOI4Lzz6HDL/yqNY7VFas4Q9ZoA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cVSzvAOp4X3DHKrub80zsHXdJaYAJflynbLeHX1rZLM=:9QNZIgRLGXJkL1hUhl0BYMvpVZ296Sq+L6zrN27AYSk=;
X-ME-Sender: <xms:MboGa2JLPzSCjkiU263n_uGpLc5smlCekbAW2vv7N-B-oMu5eShJng>
    <xme:MboGa4_4k3KkgpbYY0OkoZRri15Kiqxs6xBTQdN98tiMvy18y3LsUS7kfudPWP8St
    zlV3VYwUnBz5Xhfy5pSF0n8JpeS8GVZ-iAfNGZ07XfGe0CSxnQSZdmc>
X-ME-Proxy-Cause: dmFkZTEkvU7L6hjSdEUQ8q2Kk8p+X2SghwVfdiQt8PKN5pWJiAPuNOFL4WmhIWneIK+YI6
    hj8n6g2vmyNJjQ7xrwAnH9cKUMPq7ol4gnacMft7OYGtXJF1GYgGCyskDwQLy9bRpwjYUq
    ZwQKZbdmsQatPAx6kycpSoVM2Il46y3stk99PFLSXMHjtOSFw2x9iu7ghmKG6pD16U3XzJ
    fMxIMzNE9873gj3ddgEziM+NXPAkfsydhMUQUisR8HS6nh9xlkWXdmDEatn3pdLhkENUzn
    wuVJZDLpIpEQHiSa8k4wf6M/KXsflOU56ZFFzqfgoG/zvzOuONjZ07LCjDpSZHTK7ePOAl
    oRfyYW/OisZfPnzFa8L8NZ0hrN1ooXYKh417CeH/hYDkYKd+OXVWjPDrqOjA2HPTmdHQzq
    B0n2w1vZYLGqLDXRIQg38d07Kmza/YNJYI0N9Moxl99QplZmUuv1Jr6gdNsn/P2sZ8WNF9
    PfrkeIX5JYen5phByoW79NgTWKDm08vyBx1xkt+BuuvFNQXlVbgSc2SzgcmCPwrHtKu+tf
    jkR4/bXtaqIEcPcjAYxhr3GPEvflOrDZMHegfYIywE8COh0B749DdcZCVATP0pmC2lBSjh
    Scx8f7zdCSyDji/XWrpyf8zGwL2/FdlsDzV7JTBDb+bPEkEWf5tGBwX3z4zA
X-ME-Proxy: <xmx:M7oGayGLYMzFoBRg6XLxMzXn3IbTyoCC1IaInS8-CC2lNR-TCTjLpg>
    <xmx:M7oGa5th8fQjQaMT13nEF7pf1MSAMnoLXNv2ETPwUh7JkErf290lgg>
    <xmx:M7oGa4bySwodY98W9ShidkV6FxpPoq_14xVQZxPBG6bEzMiuSKIlEg>
    <xmx:M7oGa55GMMue_GYI3PQc_9MgwYjuO3CaAktFImgtQXEEaDI1wFWnBQ>
    <xmx:NLoGa6ej-NqGaxUOjM4J3KieJ9pwa2zEIsSxuPl1hxSChHdfs-NHNrxR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6A9FD32A0099; Wed, 25 Nov 2026 05:36:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AhgfpmuO-5-Z
Date: Wed, 25 Nov 2026 11:36:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux@analog.com, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko" <andy@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Message-Id: <f18b118e-9c5e-4cd8-8466-bb3852a80e56@app.fastmail.com>
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
Subject: Re: [PATCH 0/6] iio: adc: drop platform data from some ADI ADC drivers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026, at 11:19, Nuno S=C3=A1 wrote:
> The ad7266, ad7887, ad7791 and ad7793 drivers can still only be
> configured through platform data headers, and nothing in tree uses them
> anymore. This series removes them.

As far as I can tell, there have never been any upstream users
of the platform data for any of these drivers.

> The ad7266, ad7887 and ad7791 drivers already work without platform
> data, so the headers are just dropped and the drivers keep the
> configuration they use today when no platform data is given. The
> ad7793 driver refuses to probe without platform data, so it gets a
> binding and firmware properties instead.
>
> Patch 1 fixes an issue in ad7887 found while looking at the driver: the
> on-chip reference gets disabled exactly when the driver relies on it.
>
> For ad7266 and ad7887, the code for the modes that could only be
> selected through platform data (address GPIOs, other sample modes and
> input range on ad7266, dual channel mode on ad7887) is kept, so that
> someone needing it can easily add firmware properties for it. I'm like=
ly
> being optimistic and odds are it will be just dead code so I'm glad to
> drop all of it if that's the feedback I get.

The patches all look good to me, thanks for cleaning these up!

Acked-by: Arnd Bergmann <arnd@arndb.de>
