Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70333DEFD
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225497; cv=none; b=HGGWOzBdW4iwHH1xKY7+jaYLfoQTr14PjvCeTG2ouy6Nxmw1gOfX7CR2awkxdEShPB0bVPxQaSyQ0fWlbqMK9hW2jZLonI4p8AOzrbSs9ua3wjyDN5xxZDNBm+10RPl25KIaEyJox1SztI0P5JoG7lrZovYLMNiVJrp20JZbt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225497; c=relaxed/simple;
	bh=uiZ+x+vhRWQhm/RdJSk6EPcAg6VKMKgUIQhfffQ2FTQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bW6uXlUd0atHm9gzN/DtuX551UukY4bI9yosW+ZKjJWMxnLuupBPjqkVKpLzRjwpxJS36YiXzFGU8aA/iqzOwPFr944u/muxfqqsn8e2m0YFfu9JMlMesvS8+vebVI/aAJngyL/FdDJReN5cD9ZQGsv32mrOjUiNbhWqGVzguJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=CnY67PWE; arc=none smtp.client-ip=79.135.106.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="CnY67PWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1785225492; x=1785484692;
	bh=uiZ+x+vhRWQhm/RdJSk6EPcAg6VKMKgUIQhfffQ2FTQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CnY67PWEdvVCG/3T+ILplemqYk01J2Uhs9DgZM5H0HrGP0s7rM7ziPNnt1nql5o6N
	 4/7QGneO/1F3nVAuFojXjo/UiGwTwLwF2p38xCSD/LFyKrro3useUlrSBrpVLhNyIZ
	 vxn/WU/NQ8t2mP94h/3wmm6jxwPiKCKHX1qB6MOt8XXHlnxqh6Q+ePluprrTWED/qv
	 em9RmzWpCr4raNQF3/RuuoVpOp3r+e+guOqI01E5veshOFkc+dnOcsRziTQSO0CCFf
	 Y2rp2Ki96td4HEdHRT9CLbKcgssCZa7coSFG7DyHsZbFSlvqrhnlN9zMceDhqSwUU8
	 LNsFBtnUE3iQA==
Date: Tue, 28 Jul 2026 07:58:07 +0000
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>, Conor Dooley <conor.dooley@microchip.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/4] AUXADC driver for the MediaTek mt6323 PMIC
Message-ID: <92F7jsoczEi2TOWKT6Qqmppk-KE3uJjCKASTXa0RPV7nJZVfXhxdbuP9RptMsvV4_dnvJAlCh9NYvmiiO2mDGQojZoCozVKhXyOJmp2x6AM=@protonmail.com>
In-Reply-To: <c11705b1-fc46-440b-a27e-0cc38f3b2d69@collabora.com>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com> <f2d5801c-1d12-4a61-ac23-aa24dfd0ee5c@collabora.com> <20260710005424.5c559b5a@jic23-huawei> <c11705b1-fc46-440b-a27e-0cc38f3b2d69@collabora.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 0039053f5457e970d1073aa66047293d5cab3657
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

Could you take a look at patch 4 (DT)?

Best regards,
Roman
