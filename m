Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD868336896;
	Sat,  7 Mar 2026 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772885738; cv=none; b=XKZEP3yF5UPBo+qnrW5vDcj0pGamyCdAoG8jo8Hoju74rB4swW9H7MP7X22KNE7x91pxh+fjpT1GHRRICGXQCxYyokrInjGuSch6ZvhkWIfbYYflRo43rVD5+Q/+yIj9m4wtFck3ylOHbcsI6atdltg2aHmxrNS1tTOYFdWprTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772885738; c=relaxed/simple;
	bh=YTLGQKysy7KrlOKBvRZ+w4qhKo3BkN5JPNneWpJyDFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8ioxe+S6SB6rFlbQxroZujo9lp6zTHt38EDRK8GLP9mqafgRXmKrgMyqVqQQPYG0ZI3KTIJcXUvOKWes7tE2WV4KFFBZJKb/dAGhvzi7tdL+p4eeYE3zHdBceiyZMtAE02W9pMPRse6ii1uUw3wy0D4NX59bdYKikr0i5XxBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIeIhN4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIeIhN4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FBBC19422;
	Sat,  7 Mar 2026 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772885738;
	bh=YTLGQKysy7KrlOKBvRZ+w4qhKo3BkN5JPNneWpJyDFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oIeIhN4i1SF9RjNh/ZNnAwe1cjh0rrTMO/34HTzUpijGfIae+PsAnARyWrg99NAIF
	 mTdpM1dvk7g+v4Ux2rFuzBafuKYnz0vcSdBufV2v6o/r8dpM6LQ8gcDpHpOOfahgNQ
	 vqsP/oQTFpALcRfG5dHenA2morc2m0j0pVAYFqOb+8OqknWO+paZs+ocup4oc+K5Uv
	 KAqd+fvO86zepC91D71BrcuQNgkV0DvDtSw8AoJtNair+48JjPK5hCFul8cu27nJC9
	 h2evubbcbtV0YM7fkMxAhhV6tcHMlRRVsd+R/hNsVbWwHtAGRJsVL47SeG7AwJ6g4d
	 e1CXSFbmXtEbg==
Date: Sat, 7 Mar 2026 12:15:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chunyang Chen <chenchunyang0908@gmail.com>, kuurtb@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads1018: fix type overflow for data
 rate
Message-ID: <20260307121530.370dd3db@jic23-huawei>
In-Reply-To: <aarDrwAITxtS1ziI@ashevche-desk.local>
References: <20260305021550.120614-1-chenchunyang0908@gmail.com>
	<20260305124302.129637-1-chenchunyang0908@gmail.com>
	<aarDrwAITxtS1ziI@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Mar 2026 14:08:15 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Mar 05, 2026 at 08:43:02PM +0800, Chunyang Chen wrote:
> > The variable 'drate' is currently defined as u8. However, the data rate
> > values in ads1018 can reach up to 3300 Hz, which exceeds the maximum
> > value of 255 that a u8 can hold.
> >=20
> > Change the type of 'drate' to u32 to match the data_rate_mode_to_hz
> > array definition and ensure the data rate is handled correctly.
> >=20
> > Fixes: bf0bba486b5b ("iio: adc: ti-ads1018: add ti-ads1018 driver")
> > Signed-off-by: Chunyang Chen <chenchunyang0908@gmail.com> =20
>=20
> New version =E2=80=94 new email thread.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>=20

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
