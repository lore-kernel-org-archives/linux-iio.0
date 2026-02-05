Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7D40759F;
	Thu,  5 Feb 2026 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302605; cv=none; b=u1xv68v4MBORTa1OEdFJa3Yv5AA9YdRaThrzaIX6L7MGrVxJVULekbP3Tb1gS2fLvojjhCMy+py2p4CRaNPpUIoml6EUiMOW0e1sHp6NfDwnYzmj32YSQGKMCGoTjzLE8aiYcFmrkv4WdZooaH8EEQSlHuQ+8sjsw0xoXyTTBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302605; c=relaxed/simple;
	bh=eWHlJ4nFd4SyMSaWVJi2Nrgh4CRi612VYNWrrMBBJWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AskhaPEv0idY+S9vPdc97gNnpnlww6ZkUfWgV+x4/Oa+e0Xo4hKddIfDiN7RiGEGmMJM8/fdTMrOax0iUTbNm+s3MZv2nNeLKSOOtoEC6xfBrFvrdsYWuAOoTKewGbdNoG+ftjeb9BW/40qZxPV9nNTJmOKmyGJ0/CVK+ZzzkRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=r0FBUZJX; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="r0FBUZJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770302603; x=1770907403; i=markus.elfring@web.de;
	bh=vTNnVdH8mUSc4UsSz0U1drC8Kf626lrVxuBcisNvaC0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r0FBUZJXiawxwINKr/drpcxBc5pm7sABBP6y28QoZgSWlMQPuEvnSlvl1NoRd5er
	 HZoISbmrGqZ+/KJ6s+RW8Tveypcwp7OKQW4c6oxFJClNUjKlkUmTKTRjO0DDDQ6Ce
	 7Vz0NttBDwpIihzyYLYVQeqc1D0kChUrfCrwczpAdiJwi8NQSorDEQ3wfw9iJYiwj
	 6wXvvPCD7k9XwvYbdIRtJg2e2jzxm64mVFrcgHN649OxaWfbDX+skURYTIBbOh/WT
	 2WcFJJegqcJR5G6aR33Vwmf86jgnGtJjQkbgZEI6HLw7LsRI0pn9tymIEIWA7Skkm
	 PRRofjr6K843Wxojlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.222]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myv72-1vbJFZ01mk-018IqP; Thu, 05
 Feb 2026 15:43:23 +0100
Message-ID: <b0ff5675-bb6a-47e6-8cca-ed741db1edfb@web.de>
Date: Thu, 5 Feb 2026 15:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] iio: chemical: bme680: Fix measurement wait duration
 calculation
To: Chris Spencer <spencercw@gmail.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Vasileios Amoiridis <vassilisamir@gmail.com>
References: <20260204133636.29361-1-spencercw@gmail.com>
 <ca0c3d9c-eb09-4415-9fa9-b5ba274bd04d@web.de>
 <CAGUNXRQUuWiSJuqAmW6exdfR0R4WUoGJNDoNk3Om+tBN7uy-0w@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAGUNXRQUuWiSJuqAmW6exdfR0R4WUoGJNDoNk3Om+tBN7uy-0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nSDzh6lIUgwj2ZZwjp3mKSsjUqE1I0LIQ6J0Cr/gSWUbNff9QZk
 p9iz2SsUneu0Hbybqou9v5RAMkfcbNwdX4okC9zhDh1IqTNJJBP9hIPy56QXnDaIfn4oG+F
 aTi8kQHZhT7z9sRd6qZX9jcfO6lUdbe6hpGBIKa5cI++YIHLV6DQJwzrENoBsxXCuYH+Yf1
 efVPLKdsaduPtizOfaazg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1jToUQAAcHE=;n1va9YZv9cNUT816UV8eMI/aZ9h
 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
 jfE2rYqb2xn8JbcmxOnU

>> * See also once more:
>>   + https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/process/submitting-patches.rst?h=3Dv6.19-rc8#n94
>=20
> Can you please clarify what is wrong with the commit message? I have
> used the imperative mood in the subject, but the rest of the message
> is simply background information. How would you suggest rewording
> this?

I propose to mention another action in the change description.

Possible wording:
Thus adjust an inappropriate value.

Regards,
Markus
