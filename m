Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8C3BBA1E
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088788; cv=none; b=j0Xh1A8ub0OBYtDMs6X0lI9vW7azAPSzvXX8PssTUvd88aP3Mwvafel6EB3aQ+5M0ZMZzCxVkVN9lKesoZCkoP7YKlfC9Xw/xd/mJEo4FNXC+6cZTj+gQFW/fyW0+mkNwsUZy342jtaXTzEvWiU3B3yqeW0a5N6UUczi84C2URM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088788; c=relaxed/simple;
	bh=cD9r5rgbyeEJeZPEcQsZu54NOuAAt1fqMW53neQG9qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OD+Q741I7OGSCegrntpvb3B/z/JxygI8g8If9xWwJMfndnViRwB6rfkMiZHRsw9p8wFdcZmOOjQ3HJeAPW/18ORwRI7k0kKNZDboSd0Lte7SnXO2Ic6qfdkJQ+5hXwIoj8k4ln535d25bzw3UtK8Tb2kubDMsPBhNrnbJiLZgms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RRywLx8g; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RRywLx8g"
Message-ID: <eda63b141f49e544efb2accfbe5d5a6bc9e801bd.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785088782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cD9r5rgbyeEJeZPEcQsZu54NOuAAt1fqMW53neQG9qo=;
	b=RRywLx8g7BmkIlcVBi7dG7TZBt9VkvsTsdmY2b9avbGa5ApfO+zoHWs5B07BotMKcHY+Et
	2dz6bFYqlkiANZgKhMe9wnpjUS6mAjWZJhYcioVrR+sbWIoOF1ZkX+7UMJna+2FrwqIKCd
	MgHDC9yYJqO+KGkQHKlbqr1X06Jb7G0=
Subject: Re: [PATCH] iio: chemical: bme680: Use dev_err_probe()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: =?UTF-8?Q?Vojt=C4=9Bch_Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 "(The Capable Hub)"	 <u.kleine-koenig@baylibre.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>,  Siratul Islam	 <email@sirat.me>, Bjorn Helgaas
 <bhelgaas@google.com>, Takashi Sakamoto	 <o-takashi@sakamocchi.jp>, Danilo
 Krummrich <dakr@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"	
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Sun, 26 Jul 2026 23:59:33 +0600
In-Reply-To: <20260726152111.171339-1-vo.kratky@seznam.cz>
References: <20260726152111.171339-1-vo.kratky@seznam.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Sun, 2026-07-26 at 17:21 +0200, Vojt=C4=9Bch Kr=C3=A1tk=C3=BD wrote:
> Used dev_err_probe() instead of dev_err() to simplify error handling.
>=20
> Signed-off-by: Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@seznam.cz>
> ---
Reviewed-by: Siratul Islam <siratul.islam@linux.dev>

--
Best regards,
Sirat

