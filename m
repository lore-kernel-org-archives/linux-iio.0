Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF333BED78;
	Tue, 26 May 2026 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819168; cv=none; b=H3jgJf0zXdJ94zwCOFvsEJRs5LOgedtwv3H4qMRJ3z8oBtkr1JUfxQZ38x3ETKBpU3xTdcCLEjpq5bpZnFD0V7mi7t70ucRu86hfZgpe1D3A2idxCYKmDJWkMLaDpoo5UqGegpAV98ITePLlXXazOVo7BLeGsra5UiVMm1sQlhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819168; c=relaxed/simple;
	bh=/AOziNIdHB9VXJDnMub1OWI8LVaCU4dkbjUTxh9RKmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1i3RnVpaudwIDZpRB5wrqrDrWLXjXw8LsnoNWg+x7m7k9A6flpQU9kthfbYCa/wjNBb0Qnm085uD0EHKYjhUuUNs/hOn+fTkbU7rCEHDaiUxTHrM8QwZ/kBjMLCbWcsqP0S1u+7BhucjO5Ufi5tas14VxNnPA5OKkiMLLaNK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/tm/PMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/tm/PMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C74F1F000E9;
	Tue, 26 May 2026 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779819167;
	bh=5ngCoUCdLUTbdrymHOsCev6X6hH5iQoI3DmGS6ubV2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j/tm/PMK6+xds8mCajlHkpjxIdln5XEF/6vMWcOztxsauj1YR3ATmxVMine3MbaIr
	 18ADqFnZ5vyMr3g2fI2ATHMYtCdy6BpHvi3j6IqhI0isnTMraXyFLlQyOaeDiDCo2X
	 gf1tys8RZWGoVuqNvkA4fesqF1kf6vFx/4mS1N2ATGABncvcZPrLCFwzynRAb1Yv10
	 wNnQW7AQFUY6vBX6t9C38qNM+9ouImx91LGPOKrQRb9Uha1kyyPzncAClj2O77Pkc1
	 BwaSViJRG/pCvr8LOwbOfuanKixf9gGBp4LquqcbtG+ToBhBdML4N2BbF8SnontwTb
	 +23XpWM/w0rrg==
Date: Tue, 26 May 2026 19:12:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jyoti Bhayana <jbhayana@google.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: pressure: cros_ec_baro: simplify timestamp channel
 definition
Message-ID: <20260526191235.0a01be62@jic23-huawei>
In-Reply-To: <3c12da03-6c62-4045-b831-e7b07c0ecb5d@baylibre.com>
References: <20260525014654.2399354-1-dlechner@baylibre.com>
	<3c12da03-6c62-4045-b831-e7b07c0ecb5d@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 20:49:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/24/26 8:46 PM, David Lechner wrote:
> > Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
> > manually filling in the struct iio_chan_spec fields. This makes the code
> > less verbose and mistake-prone.
> >   
> FYI, there was a server error when doing b4 send, so this last patch
> didn't get sent with the rest. I missed the [PATCH v2 9/9] when editing
> it manually to send again.
> 
> 

New and exciting way to confuse b4 :)  Anyhow easy to work around
with a -v 2 for the first lot and then it thinks this one is v3 anyway.

Applied.

Thanks,

Jonathan
