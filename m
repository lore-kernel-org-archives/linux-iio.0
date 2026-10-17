Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95649BB61;
	Sat, 17 Oct 2026 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275098; cv=none; b=PIfQ0u+ikr/xBZf7OFq9rLvlf8ejfCf0VMG7r1A309uKSAwR/ZYJBp4gp9w4z72oOXFfEicvHgMz33oQLo3G+XncpVRzrZAOkuPSfXNcq5lp8JWQUbNcAd84kRluH9mWsju2EqQ/95W0kyHAFiwxhuOmv6cHqZ0nSWlgF8oTX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275098; c=relaxed/simple;
	bh=us1xAfdtY+OwE/kjNhXj1NFgGLpRhGbUHM31ScDdh+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH3DrLhcUNb7iQTvG1txQxooFzMXahev2qyrAQlbONQM3OO13qUGzG7erlfflHqHvPLHMzb9cQ/M/pWG66EZadUhE9aOZ7PLxr0Qzw/zip4O+6WAjJyYaU/0DhA9UgaXOThumoRpBQD2I7BEP5P97C2I1WvZleiaUw8RyDSM14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOB6SYDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOB6SYDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AC91F000C4;
	Sat, 17 Oct 2026 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792275097;
	bh=aQKq96l9JRsZg4s1OORIe54N8V7JG/5z1SNM2zjUXpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eOB6SYDWIiXi1dfASIqBeJ/ueoB6Uz4SEgJVSJeuKE6HYbGF/Rko9RZ0secSdr9SE
	 DwcuwHX6o5HfMqwBKC6kNfNrUHo8H6b6W9/UAdvJOCEALQ1oHEbJTnqq4FVmEHB+K0
	 OxnEgabFWbYipH7pM8oJExMJKLMaWfZZrfzmOEOLvbaXIf7ediuMRu6GJMIHbBhWbD
	 aNcSTEWLI7Q1NUwiXDum2s1vLOeSs3uGR26oasDUIaoyaifCfkXi5to8VxjAyjDFYl
	 9XDcHGyJijmMcHtz0c+3jhJb3whrfPV1yiEU/feBM3QqBMOJeaOh+X5k4lrIqNIbtG
	 ITQilTvHUel3g==
Date: Sat, 17 Oct 2026 23:11:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
Message-ID: <20261017231131.06e518e5@jic23-hlaptop>
In-Reply-To: <20261007135151.11780-1-abdelnasserhussein11@gmail.com>
References: <20261007135151.11780-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 16:51:51 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Replace manual and unsafe character checks (e.g., buf[0] == '1') with
> the standard kstrtobool() API in sysfs store functions. This ensures
> proper handling of standard boolean inputs, fixes potential safety
> issues, and adheres to the Linux kernel coding style.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
> Changes in v2:
> - Included <linux/kstrtox.h> explicitly as requested.
> - Renamed the boolean variable from 'req' to 'val'. (My initial thought was 'req' as an abbreviation for 'user request', but 'val' is much clearer and avoids any confusion with block/network requests).
> - Added Reviewed-by tag from Joshua.

I'm not immediately spotting the tag in Joshua's reply.

If it wasn't explicitly given you shouldn't add it.

J
