Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794990519;
	b=oEl+bt1BfGE4vhB6aCz03R8KmfOriyGiirVJVm/KiamVxleOrLLiBJM2z8+xmEnEek9h
	 I6lPvaqeMYzY6UnXVD84wImRi8fSc8B+1skexgK/TJRdAyFGf+WdHWd1GK7qWm1+ZtKtZ
	 18q1ti9WX0e/cZXf37v5ObSHqZKeaNlkYu0560nfyluCx/HIyoHN9xQbZWc4e0s9aWQw9
	 REtUblbIE6+VH5chHtdGeTa5JBJ0cNZ5x86k2pKPJ5cx13nfTzsnbD0XLhGUox+jD0ACh
	 dBrQ+jBaOYd60VsT3vhicmy2W7OEWpY3pHwoNvpQHXwKTBB+5AKNWOYrx/BuecAStJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990519;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GxgQBT99MyWszOEHDCa+oYob1rjBpPdrVq1ie+sH/JE=;
	b=5ck+iLGmLcCkmZYYXmt82ClNrwfVCZ4HRSXffAX/bwMyUzfQk7VvFdRNUMk8e3lV9cbc
	 sXykL1F+o79sd6gUSFUKaXU9JDHqvpCXIDTqhhiHDFczfmxThItYjgvbd2fZetSeKM9Vo
	 RsdUxkWIl6dP8Ab5YShwOkDmTEDUIzqXsjj5qcRqBm0XdimduaiBjqXq1FWT3OoOfL5Wd
	 ZJ1iCw4n590jf88TANByw1Y8rUJK7dJeV/Vz4RTwtYKVMiEiuCmjci/aJl7TSH4qqRmqS
	 uGQiazuKB/tmhDaNOK5vHmHpLPWQR2bOSqZ6MfLog7IyhIDOnv881SLqaL8GLtb371g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxBzCZxD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FC606A32A
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxBzCZxD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794990518;
	b=AaU8dA9Dh6p8A7OMEHygjG7tBo48O1fnU/1SDJTkShBPtWpi3WQd1oYRiMcIhQU/u6lq
	 TnF9agEUDtvhL8XKhZmTzwoDuI1MiKrxprkM55ZI6lRT/LYXturtcMJ4IH6EGPOHxFCQl
	 keIb81AZi8v38L6MVTThfDxpeMe8tpxI4y/tHc9VVuK4rC65EO2ArvrnR1WcdwTAuXIQX
	 640jIjESwtTQfUKEfiGbR0fjCq7g8cHFTigX79+fi4ll4qRwXUKvgHxesrJm7pKQzq7cj
	 qUKxKc0gHTy4yKBiFi4wD8pjXH/Op5Li33AMbfGwQC2a06Rrwa5d07MmGrxLhA/7fdg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794990518;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GxgQBT99MyWszOEHDCa+oYob1rjBpPdrVq1ie+sH/JE=;
	b=saY3vX4pApjgCSL67jIxgklEuGaoGPcm+3UjsHstpGFkuX1lnv60+7ppNqbccwXNl/Cc
	 rKHk6ZIAvenLM+IHnhvDdOBky1aOgfBynMqOzouuYgKFbqVqRgzKd7oqfsZB+XdJ525AO
	 jtb5XK0svNw1MOStUpmkDOMpqMG2gFHj3APUy/vtspyVaP/SDfTCe48fOlIcmo0jmzmUv
	 4UADq+15C8D4Z2Qmg1fr82xXPREyfRhO7BkFXDVx67yUvIUfZbPT+gLTzdbGh2PAcoSQX
	 pSMu2eat8qCW1LcubBEgQpT3uBrat3g16/0HQW0fh9QdKqp6+4DrQlt8UYrV2uM358A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id D19F61F000C4;
	Wed, 18 Nov 2026 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990518;
	bh=GxgQBT99MyWszOEHDCa+oYob1rjBpPdrVq1ie+sH/JE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nxBzCZxDxyr53Oy1oLDgQRk5qGgz6D66JEUHEJ8kQxSVIGYDhfN1reeQOQZ29/Om0
	 v+A9nymoyLy/CrcNHfvHJ3T9VKqRBBcwkO0oT33xwJMBr20RBq0gE7Xd6le+hqrrUV
	 j+Mfpu+l1r0sd5gw8WhWqF7agV7slPuFMI7OO9HUbOn9lMopF5jPaTHWLfoCMX86aA
	 ZOVR8jLBmHfWp28/PZTFiJKm4JnN2dSXDkBkk3vHU3KHraAsL2ftTHjlt2WZ2vJl7C
	 zwLBSYaIlHTUMEvmTB2PVO+CpAKifKxYo7f33VnoCbsDLE2F97cC4gb6euxp4XZ+4K
	 k49MM1yfLL9xw==
Date: Wed, 18 Nov 2026 09:28:12 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: afe: rescale: Don't use ULL(1) << x instead
 of BIT(x)
Message-ID: <20261118092812.000014b3@kernel.org>
In-Reply-To: <20261117101216.1486231-1-andriy.shevchenko@linux.intel.com>
References: <20261117101216.1486231-1-andriy.shevchenko@linux.intel.com>
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

On Tue, 17 Nov 2026 11:12:16 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> ULL(1) << x is just an open-coded implementation of BIT_ULL().
> Replace the former by the latter.
> 
> Note, the rest of the code properly uses BIT()/BIT_ULL() already.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

This file could get IWYU'd as well at some point.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
