Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188483328FC;
	Sat,  4 Jul 2026 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783151680; cv=none; b=eh5zLTc99jPplnl7dy6FLFPrTVo0eaHBGbKtV4AzicO+7C+3r0N6LAzFutQFWwhIf8MfwH0xpAojbhDjfhZBSpbQp/vJFUZ47S4UXoblwWb2iZwIJPjJaYHNxyo6JFTURze8Z1Lkl5aelDGMW20HZigUPJGs0b6mCq/cV/qqCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783151680; c=relaxed/simple;
	bh=bQFDd7KmQFchqUiGlC94JtTg0+K1xN5VJ1iAmEeoPnw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fIaERmBHX4h8ZsV8De7esRgm7aHDKsMXZE1G9ZVFo9Pn991nyWM+i2o306qzAO+nItQ1iTGQlUFIWcObBI75KqVaDBSRtGtnZoJh4KGVMsSWc21mU4piNlO9recFRSqcY8ynvNkiLDzGQA4GBqZVTVT1jq4879fUSjrv6h9TFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vo4tAakv; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vo4tAakv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783151655; x=1783756455; i=markus.elfring@web.de;
	bh=bQFDd7KmQFchqUiGlC94JtTg0+K1xN5VJ1iAmEeoPnw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vo4tAakvp7NBDg780o2wjVXSE/uNRm1eVIlUgOrjb/JxZvYxkhQRL5ZTqK6Gv/qr
	 Lk4uCY7NHTYZafEVPkNrwEQFwi/imcCaVayxtMOZX5t3JN62ZBv+AaZSHUFmKAnMy
	 E/kyEcUeFHLrlzyu1SdtSNlGIphSoqV3HMKAyr17EtUE4QFBhrT35MyVjdSCceMe6
	 eOehW3DnujqnmFrSuuUXSKHX8Xdt/LDNbWeviF48QZ6DJwRywdQK8qHy+Qj+3gJQq
	 4bRfL9BdTmmX9tGDiIgqTIiixslssoMUx4MjWRy28lmWxr0Th4K12rCszvT3zwxRi
	 VodktxHqJ1OtcCaPYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mv3Ya-1wxS7T0rC4-00yLyv; Sat, 04
 Jul 2026 09:54:15 +0200
Message-ID: <8774ce7a-47a0-459b-b09a-7faef0d0fef3@web.de>
Date: Sat, 4 Jul 2026 09:54:11 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260704071511.23184-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] iio: light: rpr0521: Propagate regcache_sync() errors
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260704071511.23184-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lsqNNqYO2YH7YgbvGmapFaSIY6FQiHBUAstIW8E8HeU5PjtkmTF
 G0UloNbefxLfV1y7hJmOu9gtmSr8uFYH5K+xaktiNvp/bsuIR4ISU6V8lIg0N9mr+tlbk3M
 qxzJkHaahjYpC2GIQbomvZ46eEfsl8S5t4xOwX9LU+U4lpVUZDDt9EzZcABSsMAkVGzzudN
 B2vlZkQYuuW2DJLpX+Kuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CyNWhBGswr8=;IxTk71r3fR9lyyFrwjlMA6P5Qh0
 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
 uGhsPQ5S4nSZ87cZdTu/2u1bhhw=

=E2=80=A6
> Return the regcache_sync() error so resume does not hide a failed
> register restore.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2-rc1#n145
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc1#n34


Regards,
Markus
