Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2D39E6C6;
	Tue, 24 Feb 2026 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940661; cv=none; b=LgVCnPaHO7w4ddEKg2Ba7E0visoL6Vha86YiAGgsz9BuQwlij7Sb2qTfgVXCuHVIMFSVTp/SSCcgfFDg/RMVKYr3fKsnSrIxLz8VLgC5jzUY2MtxBNGGwakL1s9dTgVNmFKB91SfK3kiyBZPHl+GL+zXsLcujpq4rx0+KyxMW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940661; c=relaxed/simple;
	bh=iFJ+tJDSAjOyF6lYx/Aq0VD1vQilMTWZvPsth0ieMV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo1ICKLXWazLiPXWj7xDk3G5n+2bvQ8eWqRgJMunZgkTAhbYcFqbBXUds4AAzL+gprIO6tJI+wlRRij+6pg8ZZuPQCFvFKAov1BDIijKo4y/gDlRzSa76nujDronfkFx1q+0PJ4Ifw93mL1EPBx7dnDgwn1QQ3541+8+ARBtUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2fpoekWL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3QMeibLf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2fpoekWL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3QMeibLf"
Date: Tue, 24 Feb 2026 14:44:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771940657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFJ+tJDSAjOyF6lYx/Aq0VD1vQilMTWZvPsth0ieMV8=;
	b=2fpoekWLwvI5zipjGbGDxW4ju9SQyPs2z9nuibBN0q4F5ZNTcCHgOekQJh7dv9txQD19Bc
	grM/TCIZJUodNSRJRnJujRCvMbh7iIX8ZEg1f4KxnlMMFYmAzI5GiUP/uYQ6A7rzL3tDSH
	V2371LbHCokhpKSZjghTcQThbU7UPQ1c2dHF2A2O3B9AvpY1bGxooidGSKAeDuAkvjvoQ5
	NyBXzvWJR2mU+b8Yy4/iAxqlvomLQ0dV3OdOhivMLINwAyb2DvhhLiWk6Ah11ZlhXQ1reB
	pgMTFXsLwIOmbTz/dFhyT81EVIXLs+RTqd74LMUSCBAOJfVyUEzcKYFpen38Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771940657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFJ+tJDSAjOyF6lYx/Aq0VD1vQilMTWZvPsth0ieMV8=;
	b=3QMeibLfsfKTqDHtMjGROrngtwt76c9tISsCaIR7uIMqyFSP01deQFJJ8AfiG5a6Mxnhfp
	XDQ6RWZSmIoeRdDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Felix Gu <ustc.gu@gmail.com>, Jorge Marques <jorge.marques@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4062: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Message-ID: <20260224134415.QTvIqL9c@linutronix.de>
References: <20260223-ad4062-v1-1-8ee93ea173a6@gmail.com>
 <aZwXVZ-eq3OULitA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aZwXVZ-eq3OULitA@smile.fi.intel.com>

On 2026-02-23 11:01:09 [+0200], Andy Shevchenko wrote:
> Wondering if @bigeasy already sent a patch for this.

No, I haven't. This got in v7.0-rc1 and I haven't checked -next at the
time=E2=80=A6

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
