Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2128406287;
	Thu,  9 Jul 2026 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591470; cv=none; b=DlwxagN6WDBBsLNSraJNbPBf4yK/b/FSyQFnI4WGD1wSMLHv2+rSDnehQI4fdc0MPQhmiDPP71Zeg4Z8MnxglOhRiA82ByFhBfRyEiHrEdXQI9GEczkl0o7Q0VIJEBjlmLs2qOuLa3kq7Y5h6gFXUaSsJdkJqG873cS6GSVC73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591470; c=relaxed/simple;
	bh=83dwYyFcaU55ghmn5xrQZV9qr/tiAXvwfw93RtEnGWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4ffml+CKUj4qFfAZGjMsrcm3T/5mAr6x3MebiJFbt/An36NWT/2eM2a+E2j0fdpI3pz5S55VVm9LV+FJTXwcIYKMCstbrH4coLMau879dhOOgSvWYcoyXN1qmojJ4BTKQhbZ5IjxBGIDzhxyLaFjV6w51JFnBfL+O39Fmqt6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=ItmQvK5Q; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="ItmQvK5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1783591460; x=1784196260; i=lukas.metz@gmx.net;
	bh=USuhseTGFuEXWc92U8HIk8WKyZ4VAiRhWM2IQRdM0Ug=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ItmQvK5QYhR8A4zWgxU14y71JPnQ6u+OEgRK9dtKFlM5Qi7+uSwLik6PVc2CJuCl
	 ElFP2jEPsgsVmMEp8GK5O4huajA2IKt+2WrJAbFY3GM0qUdtpfpJtMcGjpNSMCus+
	 y6PAURgm6/ixq4X6Wy9jN1IEItFRnL5k8kYLY1I4TSdzWzKzDBR41WV4k8DbPlPs4
	 J0vM7TGNts6lznB8MV4JZQ/Sf5EaP28sEem+0oCjWFVklx+Nadnl75Q0nljDT3f45
	 MwVfqLR1YoH9p4jKAg7D5LbhEs33TpSM1BB+K9p+LXz8VZaMdGNZC3KGwHra2qY4S
	 T8FSsFaWV5Skb0ReMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1wY2S715cZ-00PKGP; Thu, 09
 Jul 2026 12:04:20 +0200
Date: Thu, 9 Jul 2026 12:03:14 +0200
From: Lukas <lukas.metz@gmx.net>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <ak9x4iKf7yR1rMWN@berta-MS-7693>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
 <ak41MZNHFvVzeq6Z@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak41MZNHFvVzeq6Z@ashevche-desk.local>
X-Provags-ID: V03:K1:VxkbhtbInvJx/V1PGrnBIv4LsX/nRBrVRrBrDJUecpMxk+3Kqlf
 TpQ5yTWt/XbdRibtis0UM58b6Nkob1Hd+b3pIzxNg19iSE/jKEylfFj8Ft1xgSKXqv3JZsa
 lswfmzsn7oo/jWerpEsV5L0XWLI8f2DOH9k8QFINbHPZWZBday4atN+5w+F0eAoy3US8EPq
 IADBZ4NOsCmAjhMuJTPug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GhFA5QtiZ7k=;Qz7siSPBBkj7+vjqet5DGu9j1a3
 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
 GLT9heliNJi4xzA==
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 02:32:01PM +0300, Andy Shevchenko wrote:
>=20
> At the first glance it seems I already commented on the issues in this d=
river.
> Yes, I see that I commented
>=20
>   "Leave trailing commas in the non-terminator entries here and there."
>=20
> and in several places in this version it has not been addressed.
> Taking into account this I don't want to go through and check what
> else is missing, so please go again to v1 and carefully read *all*
> the comments and either address them, or explain why it's not done.
>

You are right, i forgot to change that in several places. I think i got
lost a little bit due to the amount of changes. I will make sure to=20
carefully check that i didnt miss anything before sending v3.
Thanks for taking the time.

Best regards

Lukas
