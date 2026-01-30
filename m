Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABB364E86;
	Fri, 30 Jan 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794737; cv=none; b=PDagUXZ3m7++RY6GyIflaf7LPXsGV4WtOsXkXZaYhVTOecrQyxC2NaZ3qMYD3b3klkUYRLFeveIHFRc4elHPHHnUT0rsNiUJCuNgStDmPgeJYRKqo5B27XPKoQzexrlOjumGk6qXmaABpqh93t8CmoBT+/rCsNcLgC3a9uUeV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794737; c=relaxed/simple;
	bh=l2/Jgl2xxdOouZ0M1s3EYc7Yi3pVflx+RrvtswaJpVI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhCmcBnYbdSb44cx+Vs9R5IqPpF+LriudFX3n6bQzwQ3x8Lolu6Ue6UeOsugxFEpzE85VOUdY6fFZHSVE0UWnF87fgOIU5kbIoyZIthqGEh/OUvC534PqDpcCOl7yZOgFTMPnkvF4DbpriYjRkmG30c48ZqM3gr2rmJrs6IZcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f2js42znSzHnGd6;
	Sat, 31 Jan 2026 01:38:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 496D240086;
	Sat, 31 Jan 2026 01:38:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Jan
 2026 17:38:51 +0000
Date: Fri, 30 Jan 2026 17:38:49 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, "Fabio
 Estevam" <festevam@denx.de>, Sakari Ailus <sakari.ailus@linux.intel.com>,
	Chen-Yu Tsai <wens@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad4080: remove unused dec_rate field
Message-ID: <20260130173849.00004447@huawei.com>
In-Reply-To: <aXxAVIM3iTXdQJE8@smile.fi.intel.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
	<aXxAVIM3iTXdQJE8@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 30 Jan 2026 07:23:32 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jan 29, 2026 at 07:21:58PM +0200, Antoniu Miclaus wrote:
> > Remove unused dec_rate field from ad4080_state struct.
> > The driver reads/writes decimation rate directly from
> > hardware registers via ad4080_get_dec_rate() and
> > ad4080_set_dec_rate() functions.  
> 
> Jonathan, the changes look good to me, but the process wise it made badly.
> Up to you, if you want to apply this, but it might be confusing as this is
> definitely *not* a series.

I'm not planning to queue anything else non urgent for the coming 
merge window, so we have plenty of time to do a v2 nicely.

I'd not be against having this lot of cleanup as a series if it
had a clear cover letter stating tooling used to find them etc.
Whilst not one driver, and can merge independently that sort of grouping
is fine if it provides some value (such as background info).


Jonathan


> 
> Also some patches should probably have a v2, I haven't checked that.
> 

