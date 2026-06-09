Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F6361DD0
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034568; cv=none; b=EHCqcKMZEw3smtL952C9ketnEIqFCCzRUSu7wS+wdC6j81zX6vr7XgFDzkHmwiWs/KMQs0tUSKw8Cby8H59UXVbg/u2df2pIuICdw68xhDBVtApjBt5LdD74GCLrpXmo9lpd38dC71OI8lOqGRqnVv7tkQSi6YmFEjEP/oiJIzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034568; c=relaxed/simple;
	bh=GgKZnTuVOJ6xRAmOu/hDneQopQHt5m3ut48mdldgavo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBRQ9XSueCbtHHk82WEcVzxwhGDNX+4trW9ag8bIUoEF6R5N5+DQX+bQbdMHWTUGIRtKS6To1k138dpOO7EKCh0CBxZhFisztNVoHwxahpAx58INR/b4K+ittj1EfcJNSnpgr6bNwvci3Pway5qiVM1DrmHmbJmW4LRjrkKEQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=jxZ8lbzX; arc=none smtp.client-ip=185.70.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="jxZ8lbzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1781032548; x=1781291748;
	bh=dLyB8XawH2sgIIZ5MIGWnJ1sq7S1TgdTUSfQDubvnvY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jxZ8lbzXdWYig6RBNon62GlCSUWxQT8YgWPOGrQicRm1+BP4F6N1vmbOsYU2Mf6Jg
	 aJHhD77bzauCDH34ogxqUaD8PHf+9PtL2fo6qgpBpwtuMhHfWA7kZMj4ozOSkoh/X/
	 L3jmVZQ1JnSp3vUJFiP6sqSSmpvPjUsR04kvLBfPTGNp/e4oT0FQwcIObd5vouo9hN
	 ZrWdB0hgOK+fwTNA3vRUqr9CsiUmc5zbP9ZwKxyK8Vt1m7tXr2sQnrfELoGXIVHWJe
	 Ic68gU5gkwaRChhxc3HO2DwlcXXA/qE/mRDopRlf/ZjpwVvciYM983aQZAxDJI0uiH
	 uLYUKLEuxvytg==
Date: Tue, 09 Jun 2026 19:15:42 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC driver
Message-ID: <hacDZbv1Whk_g8AMSfJqKHrgXfyVKt2o3_UGK-1k9jNRJyMxEFPztGhytHvHbc1x9j-F84I_ZuprmXWf2Azbtdqj2vnVal4PO1gG_DijYyA=@protonmail.com>
In-Reply-To: <aihbxowyAIlSeDjH@ashevche-desk.local>
References: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com> <20260609-mt6323-adc-v2-2-aa93a22309f9@protonmail.com> <aihbxowyAIlSeDjH@ashevche-desk.local>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 254bdc277eca4fcbf59a132a374d5de774ac7810
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tuesday, June 9th, 2026 at 9:30 PM, Andy Shevchenko <andriy.shevchenko@i=
ntel.com> wrote:
> On Tue, Jun 09, 2026 at 04:31:59PM +0300, Roman Vivchar via B4 Relay wrot=
e:
>

...

>
> > +=09ret =3D regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19, val,
> > +=09=09=09=09       !(val & AUXADC_ADC19_BUSY_MASK),
> > +=09=09=09=09       10, 500);
>
> It's better to split on logical boundaries:
>
> =09ret =3D regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19,
> =09=09=09=09       val, !(val & AUXADC_ADC19_BUSY_MASK),
> =09=09=09=09       10, 500);
>

Agreed.

...

>
> > +=09case IIO_CHAN_INFO_RAW:
> > +=09=09scoped_guard(mutex, &auxadc->lock) {
>
> I'm wondering why we haven't moved to guard()() here

The compiler would complain about 'cannot jump from switch statement'
due to default case.

Best regards,
Roman
