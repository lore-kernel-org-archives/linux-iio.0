Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F47351C2A;
	Mon, 31 Aug 2026 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788138903; cv=none; b=CUsB0buwwkf5MvISYha2Q9/n0iyv+z7y2CbrBYJYbofvxmmp/1Efm7s8YFShgrWPoyPESD7zQooNYJi7yCcxcG/nSydAgvNfNre5M913y84Wnx2Vlm+I9MPl2Qi5IvQKpPHuLZ2XGkFC3brNBPn+vSb75zj167ZwFfLjQKq9LMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788138903; c=relaxed/simple;
	bh=/spp0J/X/Qn6SNBgMWqR1VpdKMx2QctH7d2bKRvY0xk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=XG2R2M/8uxMemziA8orTnQ/6wjjAyG80jTGE0qzOI6r0Ivgw5hK+ZJqUymR1qD6eQrBimWNXwdeh1znEQl2S8kThf0ObQ6M3r4vWR+WeUogF1j8DJRZfvxEHe5qpV9RwSnPkZlxQxHi4XoQSncl7CbA5VS5VMH4KVcxMtYgZ++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NszBREvh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NszBREvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0C11F000E9;
	Mon, 31 Aug 2026 01:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788138901;
	bh=IhrsxaK1SnaziFGJt7Z2KpMwTqpqhw5qMI7DCQ4iWvo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=NszBREvhZ4k0AnUauxLf4HlAkZ/9kUoLKee0oc4hOUi+lkNSpAiO/6o5+xDGht5S9
	 pBp474iL6JDIVXGpWpwZVdYPqXIE4YG+s6YAHcQHuiR/XS8Lb+6418gAY3IElfGTOH
	 +dL6xB8/dcY5DJDQxmyNcB5Zw3RJ1ADAeW06FKGWMPsWLOfpnzGms4BdnWNhWBiohK
	 G8QntgRjLCyHivNHq7LJVck8yolad/TXYwO3ZfvBcSJiw3wKIDOUnqhkFEQXqxisba
	 dH04SSMiR8RbO2H7AhbcbPojS8bpS9dlVV5ziSaIF+WhwHFm/n2kJe+LJK2OCL5eR6
	 ADXlHg3DfPXgw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 6/6] iio: pressure: dps310: check the lock markings
 with context analysis
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>, 
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, 
 Justin Stitt <justinstitt@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260824201203.396651-7-zoone.rupert@gmail.com>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
 <20260824201203.396651-7-zoone.rupert@gmail.com>
Date: Mon, 31 Aug 2026 02:14:41 +0100
Message-Id: <178813888151.2788519.7490126649907374080.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=622;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=/spp0J/X/Qn6SNBgMWqR1VpdKMx2QctH7d2bKRvY0xk=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlNWQCDnGKO90eRVG+RXfakIOayDNkm+ukNBsR
 BVYb1xG1K2JAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapTVkBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiCLEEACUTq7qlwiABhDG//4+VKtCLJaBqyP33XZAOrOGllQHSQ/
 nmVBCbLcLQ8en2jrMniytFxvLwFh6V2dWVo6ENnxmhtj78i4tEUmoDuT+bEX6EizeqN/x94C4FW
 aT+uIkWW5kbBEDDZSfVm8/h3urGys/C3JeWXFvLq3aWukkjTs6/Zzozj17aj0A+X++OuDo7f6tO
 jygQaYZ/1zXHqUK+g34J6f54YSYe0NycVdIr1RkriqGs7ltdWs7ltUqxCLRVFZ7iIFr4B9ClZAH
 +WDf2Mhk4fc8RwiI+h59Dlw28ghCVpvikWymvtFejLEwTkLzEjkVo4roVcscgkdaLZfQvdyu4cW
 Jxn7MT2ckPsuz9lrB70T7YgetldkKFIIFN8vPFK/whtUjfaEtRo7nFdWL8yJ7U/ExTx5EnvNOMO
 He3dUoqAqFbv3BZsdkG38A1JdWOJ3AQI5KskfHv6KOZSjxWFiNw0xZj6dJYPZ7LK0Ozr+UHxyLn
 I5DlHXORRAitX66S+ao0CGsuI6znziEIWNh1M1bsBR1EJ4gMmXQSOrwDPJhXpFE6LjxEn7LiZ5t
 1EWvzWAHiPV6VJOR4VnY94iP2SC6+mPmyDYjBLIa2u4IqrjFqtdavVf1QunFf5jmyUBpdVM+55Q
 aQxVmEdFKYkt+vdlmW5JBTAUOfg8GGGwPU7N6oQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> __must_hold() markings added earlier in this series are only
> documentation unless the file opts in, so switch the analysis on for
> dps310.o.
> 
> Clean with clang 23.1.0 at W=1. It does run: dropping the lock around
> dps310_fill_scan() fails the build rather than going quietly.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>

This does make me nervous, but I guess we need to test the water
at somepoint.  Ideally I'd just flick it on for the whole IIO but
it is notorious for false positives.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
