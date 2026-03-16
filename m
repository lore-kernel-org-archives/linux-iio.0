Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374938F94F;
	Mon, 16 Mar 2026 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657749; cv=none; b=kAaxajglvMFA3s8OQbpKPe3KekbcxgmYP7q6rJUlX2jRk+WKVdGDLe0cZfxSHAwb3rCcbEklA5izIkKQtHbP7wOPmN6+YjeaxmUcE5gUmWse6P83uJe/So5WRWI+8c2Uhy1jnYYkjpko6v0u24RBfRjq5gxgngPfJz+SxZb3o8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657749; c=relaxed/simple;
	bh=zU5th8rBwXnIFqb77/5IA/2xOyC5rHyvka3E1aB/LQI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=czyMLqpegZZwvDOOtMg1VlqtuCPvKlAgHhnSs00SYp5fb/wgmmD99OQ8iOdfJpnMPTVUwzaxm/6CIsksnB8gw5pJTLkgclzdkaV0X/0xMRwFXmxI6WNPYpVss6dAQqp2hKoT1iGMzNFNzcjyrxgVI9el7d32YbUJ5WvB+4bB9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Go2CIZkB; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Go2CIZkB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773657744; x=1774262544; i=markus.elfring@web.de;
	bh=HKdNLY158aHib5DxKnSUxxS4fkZJRNS0QfoPBlO+ZGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Go2CIZkBPTN4LYP0I8pi3iXlcBWZtIHrbJPryzcvGlaBOHGWsJ+tr7ZEaWrkNHtx
	 pZcP/5lfgCZfJCRw6r052L3XvTKs8awxGMLVD6a17Hfar6cN27mYzcMoDOuvQAt6j
	 va4AVPSrdf87JZ1OgDXbgyy3/ykIJpaT7BhwknXuMcFryXjyql8COjHw/VTuBpYvq
	 fLLD6ERqGSO3qYn3AjUO2u2AVAS1NnocivCMFkrEnvAQTBUL3rB7QLRLntq8c9Zzo
	 wvBLEVr/oUzc55pFquIPY8GIjJcbxU251QkAKU6mrWJrQiWwCpC2Q4yHihfQmhxv/
	 GSSWPRIJDyzTsIqqTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCmZ-1vFpUd1mvv-00fy8x; Mon, 16
 Mar 2026 11:42:24 +0100
Message-ID: <06cc64e8-38e1-4940-b129-75c74b7058fb@web.de>
Date: Mon, 16 Mar 2026 11:42:21 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Parthiban Nallathambi <pn@denx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260314-iio-light-vcnl4035c-clean-up-scan-buf-v1-1-400d273eb026@baylibre.com>
Subject: Re: [PATCH] iio: light: vcnl4035: fix scan buffer on big-endian
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260314-iio-light-vcnl4035c-clean-up-scan-buf-v1-1-400d273eb026@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o38+usrV/zdS07moAPuRl1CJdCs+0HOhP2PjerqhPWRrWC3YV4S
 qDEK1gQSP8ZsTv2mwZqdWj3GYD0zansrftDLayE6/Fv0mpXjg9YeSL8zQwEPM6KfaWkKQWw
 E5Ibli2mptW6xQfkaJ08hymH6GhDMgnnSn5w07rUBY9nzH61wjX0zmLR3rbpDNJmvZrLCVM
 T8TtQbLIJtBZ/NWaiomUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Akt7UwiN0zw=;QRaKv8yi4ZPVQHSNKNJ/ZshLTZr
 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
 c695OM36ehjjr35TCIcA

> Rework vcnl4035_trigger_consumer_handler() so that we are not passing
> what should be a u16 value as an int * to regmap_read(). This won't
> work on bit endian systems.
=E2=80=A6
          big?


See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.0-rc4#n34

Regards,
Markus
