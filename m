Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E947DD74;
	Wed,  6 May 2026 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079469; cv=none; b=kpT0XZQGUS+zjZrRlf4hqSdheRKkkTlU7eYb9pCPbds9Y0q/ArjnPX/JIIwJ4gc1GmQGRh/TbFytMQ+dGJIcgNXg8wMQQUTPc2GQsieXBOsDnWX4hJa2Pe6pOx92+/y9OlaSid8cgmqlVZNkUo8KTE2/bnVo6+I7N5j4E4+JY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079469; c=relaxed/simple;
	bh=8si24IOti1/iGS8Ii+rD9oCJOsgxix/eRYlFpzIWYuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paqqan3DnxsQYSZA9raCFgxd3aIsm0oDuXIZqY4H94NXR+hE1iQ2PS27yzko+Q454YCKZAGKsNiSKdwWpRRpbK+SPjDWr5DZ6Z4ev7ynS41VhiUH8tkuHK+jOU/owNB90BQw2Conlmx/OskNlVC4vERKWbn4AAuNQlDX0LfriSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQnqq4MR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQnqq4MR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBFBC2BCB0;
	Wed,  6 May 2026 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778079468;
	bh=8si24IOti1/iGS8Ii+rD9oCJOsgxix/eRYlFpzIWYuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lQnqq4MRZCzlWelxIgit2yM3HH4EOKJSumvuI3HQjVtEG+0doLGq2jGnpgVSB7+o3
	 YfqiifCEKZWvIZahx7FybsNrPwPyVqBKSp1bMxcBSbuweHLYfxYHemhRs1QQdLwWMe
	 hAs6YjV4pJpabCN9W/8x4pJ0fvzOfpJmK15/8c7hpjvsQFIbbE2KJvU898al6C+v5B
	 mtU9tL0BkU4OjJdS/wrEqYPBXieZ4/jB3tTMW7jgwMoN7TXkv3VS/v+ZFbl16IBihR
	 yhll48547hyJrCYB0GMa7d0s18ykDZMNNrIF27lHOh4GXK6JSiq/WnyHcOUS6bsqTF
	 Hhz3kEKxPaEqw==
Date: Wed, 6 May 2026 15:57:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Angelo Dureghello" <angelo@kernel-space.org>, "Greg Ungerer"
 <gerg@linux-m68k.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Steven
 King" <sfking@fdwdc.com>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Greg Ungerer" <gerg@uclinux.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, "Angelo
 Dureghello" <adureghello@baylibre.com>
Subject: Re: [PATCH 08/10] m68k: stmark2: add mcf5441x DAC platform devices
Message-ID: <20260506155737.6cd625a5@jic23-huawei>
In-Reply-To: <ef773bbd-1cf2-4cc2-96a8-fccd3355d6b1@app.fastmail.com>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
	<20260504-wip-stmark2-dac-v1-8-874c36a4910d@baylibre.com>
	<ef773bbd-1cf2-4cc2-96a8-fccd3355d6b1@app.fastmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 May 2026 19:28:28 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, May 4, 2026, at 19:16, Angelo Dureghello wrote:
> > @@ -94,8 +94,42 @@ static struct platform_device dspi_spi0_device = {  
> ...
> > +static struct resource dspi_dac1_resource[] = {
> > +	[0] = {  
> 
> This looks like the name has a copy-paste error: this is not
> related to the 'dspi' controller at all but is just the dac, right?
> 
>       Arnd
> 

https://sashiko.dev/#/patchset/20260504-wip-stmark2-dac-v1-0-874c36a4910d%40baylibre.com
Has noted some more alongside this one.
Seems unlikely a DAC has a bus number.

Jonathan
