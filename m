Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991482;
	b=xZcWbu87d8WQ8Hae03MrgI/KFWorCT/fYulWbhSUf37YUwwBcvw30F4EpUoBDU8Zox5d
	 6sjYdLfNue7F+n3gnTZ/v5eh/neuanoWQr+3Zeo7kk60oFFEK9xxvRScTQWx1sNXs5OUl
	 WTYBDLWJdxPQ05z7WvyD4eiumly3itVQ28WEiULxaa1HW+kmSI9bV6DRFiUVvRImY3dLL
	 x1mUIcG/OBESbs5MfV1h1Cj0dXchl1wzeedHL49OuPQp6FgcFzVJXbQQxaKScdsCParyA
	 aqwA+5Z91YxjgbyGln7ECEatHQlIsD0TbhkaHkB8wMqjm30xkiUeREE7fk/s86RubJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991482;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DCoiDSvUXcq0tOlNKyFR+Cm5poLJLSqjOgt7b8dpkGw=;
	b=ZD/6FoHL8BtcYZHE36kXQEyyPP9gds/lPs/FCwFEtjUydxi2tuZS/wk2YvrjdynsGqXR
	 BlpZPy0N+R11icAXKgP99N2QKPSn7+Z54nWVdG0wU7veiSia7FuAcrLMx1H/zXhFo00wO
	 9urE0pE3sx2m797BolBpC3iC0BtftfFbomB/PMeblLAj4FZgi0P0Xm4rA3/lb97mSOggY
	 PIEvJBkVr76X3XCrVFhMgdBC6h8rURhMvL2XUWxq2xLDDx1jkJoMF1axgeqJSfo1+yiPN
	 PjlA+9j98HvwTMk+6mB880UoDxKbw1z+K4n1jfcWkROyvJTl7z1zTzp+mp+vzzu8Skg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+QiVBbF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91549606A31C;
	Wed, 18 Nov 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+QiVBbF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794991482;
	b=SG/PE1vBCunFIwW8vznb1ROCO4gGIwLgKmKOfo97kqp2/kNybnfV25aE7o4Xqavql47O
	 RtgyIpcnoOmIMi8GIl5Q+qv3j9qyyuLSnIaGcoTRkhBuDyYPRikLi331DULO1lGAzjhIK
	 2XtauBj1hqJW5aR+MpS4y//aRz9x8SpQc11Z5+xod142E6A2Tra5KAQpVdtMNaFhs75/r
	 5osCzzj+3XtxN+PMmS4fnme17a1+iZHgds7+2IwyqnUcPnlPU0DigLMKsvF98aC0X6rII
	 ZuLyouChxZ8P+uLErGN1KdwoQ2n73vXdq0RkgI17VwdHIEM/hjNDBOZ8klQCkG6LSGA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794991482;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DCoiDSvUXcq0tOlNKyFR+Cm5poLJLSqjOgt7b8dpkGw=;
	b=Uxjrz1JPp/DOUecy0/jtrbTUJy5jK7xxbK0wcjwdAb6r+7Ii83UWCVZHMqTHuajVRIiD
	 jeIdTXSMNOfDweWmAzOzEFqkJM1TcjrbEfVUho7REz+SCFVWJskBUuf0GbUh7j4bn0SKd
	 SCbvgxp6LD3VVzKQOrxZQoHEND0Fix0ftPI+Pip9r1JTX0Jsq2IphFSCIaajxpgdKGAjH
	 iTk1shBtmgY1ujJVIu2o2HMLjR5Ggvw8XAOCOVCRYhZRrGWLEgS0kzRrrtP1pZvOwcowc
	 FomBkResraBdlZKUUIH1Qc47z5XN5cGTZvVtoCuDfNjn6rU+VidIw4VYo74ot1JaGGg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 080E11F000C4;
	Wed, 18 Nov 2026 08:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991482;
	bh=DCoiDSvUXcq0tOlNKyFR+Cm5poLJLSqjOgt7b8dpkGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k+QiVBbFbLbZLxg6K7UL/JF0DL4PHyb0MMNO9M9FS4+Tpwby3LuZcIYAx6aekO5ED
	 o3ipq3+M30sd0dBnTSZd2UwNzaZ/v6iu31uGVN7wmMnWMntXpek52c1zGkkywDRSFR
	 tBoqRj+apQwROLysoUt8ekp4GtCX2XupZ/lXhAJlCo/hKV2TifmJ27Qc9VW3DZ4juw
	 ToGA2qFrfQEQlzzBbagt0BNkdktOGTeTqaiqqPjfeh0AEq+h78JzUAjqQtkaqnaV43
	 5lv6myYwKNpILmiDoXmV598Ioicre8T86BZVcZdibiibEXtQR+J0Rt7wLGzv5QQbgP
	 wjXGKD2J1op9w==
Date: Wed, 18 Nov 2026 09:44:29 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-kernel@vger.kernel.org, Martin Tuma
 <martin.tuma@digiteqautomotive.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-media@vger.kernel.org, Gustavo Silva
 <gustavograzs@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Tomislav Denis <tomislav.denis@avl.com>, Jorge
 Marques <jorge.marques@analog.com>, Petre Rodan
 <petre.rodan@subdimension.ro>, Dan Robertson <dan@dlrobertson.com>,
 Jianping Shen <Jianping.Shen@de.bosch.com>, Gwendal Grignou
 <gwendal@chromium.org>, Maxwell Doose <maxwell@maxwelld.cc>, Tomasz
 Duszynski <tduszyns@gmail.com>, Esben Haabendal <esben@geanix.com>, Narcisa
 Ana Maria Vasile <narcisaanamaria12@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Vasileios Amoiridis
 <vassilisamir@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Nishant Malpani
 <nish.malpani25@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH 06/35] iio: adc: ad7768-1: use default_trigger
Message-ID: <20261118094429.00000942@kernel.org>
In-Reply-To: <20261116014823.3132576-7-jic23@kernel.org>
References: <20261116014823.3132576-1-jic23@kernel.org>
	<20261116014823.3132576-7-jic23@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 01:47:54 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Set indio_dev->default_trigger rather than taking a reference to the
> trigger in probe(). The IIO core now takes the reference during
> iio_device_register(), so it is not leaked if probe() fails after
> the trigger is set up.  This avoids fragile ordering requirements
> in probe().
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")

Sashiko points out the Fixes tag is probably incorrect (and I agree). Commit a5f8c7da3dbe 
set indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED, which guaranteed
trigger unregistering on driver exit (I checked and it does this by bitwise & with the
INDIO_ALL_TRIGGERED_MODE). This behaviour was then removed with:

bca036de0ab2 ("iio: adc: ad778-1: do not explicity set INDIO_BUFFER_TRIGGERED mode")

-- 
Kind regards,
Joshua Crofts
