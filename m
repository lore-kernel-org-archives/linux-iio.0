Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7E15C14F;
	Sat, 15 Aug 2026 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786759059; cv=none; b=iJbQEAl83fDBOLlaZNkujEMa7IQLKRhL5ft6aLox5NfQMyjBhsQIZXDCi4fGK64ykirguXnJVPL7rrCJl2LuuF7HWvwz7+168RXHeF/GoS6WM2un1xonVWKVsBvhgcbRleQvS5myihwTvWb9yXCQMfSvl95Wk8kxk/YLHuEX+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786759059; c=relaxed/simple;
	bh=2k21oP3uc3CpSpDf6M9NnnLHW6BVjcb1UHkbnQKiIUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBFPZiq3oCAPlYnRMpYB0b5Ch3VdxX0bTSPZrH4E0r5scOPAPer/E6oom0bs12Bw8Jcjv1Kd1Cj9vTPfJBun8TcmjkdvT0PLK7B3AaZfUXabgYEIXEw7FGUtcZY87hhydzHOXXHMv8aI4K2MY8EtURASG0VjEk2+cyhNB30wdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzZFlhvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzZFlhvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD61F000E9;
	Sat, 15 Aug 2026 01:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786759058;
	bh=9zVksnQyuPy07Sp7sNksTJnIRmmkQHtYXS8UklOtV60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lzZFlhvFFzT7JNr11cvMu4yCeFnhSny1TroFsX2oiTWNjfDTiOEZTqJqGWdEGU9rl
	 bby36qoqoQ7Dw1aAMu2RPox6lSE6bOg/yzO+JvRmbGCoafKNJ0Fj0SXVsjJQ1pW2eF
	 m+nubQelGmT9gTU8c4s7PXn4h/8J9HBYXoEa19sEbQ4tmPqm+TkVJAVkGC5gihMOLY
	 VpNX9kFcIFqTWesxMGNL/WOKYDO8/Inbh1NhPtTa210nFttRUEfbP4joyQT4vCQFFM
	 wBDXl5J0nQsvaYB/47BTntXz7YNNTk/l4XwRL6pVNnbapp3t8tN3Oy3UGaUvTV9lKO
	 GuH0WGA90Z54g==
Date: Sat, 15 Aug 2026 02:57:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Daniel Thompson
 <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel Machek
 <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold
 <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 08/14] mfd: lm3533: Convert to use OF bindings
Message-ID: <20260815025717.05a1bbfd@jic23-huawei>
In-Reply-To: <20260811191132.GA1072730@google.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
	<20260731113632.158440-9-clamor95@gmail.com>
	<20260811191132.GA1072730@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 20:11:32 +0100
Lee Jones <lee@kernel.org> wrote:

> Jonathan,
> 
> IIO ack please, mate.

Oops. Not sure why I failed to notice the IIO parts in these other patches.

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for-iio

Thanks for the poke!

Jonathan

