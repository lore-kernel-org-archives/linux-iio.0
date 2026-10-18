Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302EB4CF473;
	Sun, 18 Oct 2026 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290704; cv=none; b=NL7kCh/o7FTwyY51YAsZINNcF5rbuoXjbzHXwLgvyhGXKiHdVoKR+Qi+C3jH5Q8WM9jPu5JzyOosDl2N/HdEP0/s2MpLB34wc7f/TMCJsJaDdtpdu7jZA13RYEAL/K3Pn0fFyJip1GiraMYgJGFPdBl7vWyxFQHVxwvFdsun274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290704; c=relaxed/simple;
	bh=fZYeM1gvn8ZU0/5MGQAJpQX9X/wq0lVSPfRyfVqmdGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhPvl4JOzhNa6jm4QiWvQs+vHOU4nfoLZR/P3Y6tCKJA8qnCSsgIs3bYxzXCUn8VzYzlI9YXYLFaGH1ygEArByFoUluAz1KiZRiN3HFGHsT4V7ZzJ37ELGiGEfMtfqykRki0WPodV8iZIdZ1+u7ZXn36urb/15july+NR0xtqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBBin8NF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBBin8NF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347191F000C4;
	Sun, 18 Oct 2026 02:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792290702;
	bh=fZYeM1gvn8ZU0/5MGQAJpQX9X/wq0lVSPfRyfVqmdGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MBBin8NFgEoqWZNmSCQo2jl4yowzbK3jRmBD/2eZ5Pca3bC9scm29VEDu5d439OYV
	 OcUdKXAm/zR3mCKWj4L/ln0g/DOdoNSL9SB1tXER3Asv9NbMic1zbYbN0q2hB6XfRb
	 FE3XTOwUT6TAU72nwkipoFJLJ+CKIqgfS8/oHNSdmoO7RzpPYYvi9POOd0YHId96sL
	 v2GSvCY1oaWzFYc5COdMh/haKEGES9UyRQCKzflm/sFtwmeV1T/NJUarxpLqFIufg2
	 +A0RZ3TRUC1KJkWvZfoH3IqPtVZefQYPOagTPJN+2ITGrvmG6U+E36VKeCUpi7kxiy
	 e8XkO9IHz0SJQ==
Date: Sun, 18 Oct 2026 03:31:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jean-Baptiste Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, <kernel@axis.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] Add support for InvenSense ICM-42370-P
 accelerometer
Message-ID: <20261018033136.6d145f06@jic23-hlaptop>
In-Reply-To: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Oct 2026 13:54:24 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> InvenSense ICM42370P is a high performance MEMS MotionTracking 3-axis
> accelerometer. It supports I2C, I3C and SPI protocols. It has a 2.25kB
> FIFO and two programmable interrupts with support for ultra-low-power
> wake-on-motion support. It has a built-in temperature sensor. This
> patch series adds basic support for the sensor with functionality of
> performing raw reads and writes via the I2C interface.
Make sure to check the sashiko feedback. At least the few bits
I read closely look valid:
https://sashiko.dev/#/patchset/20261009-b4-inv_icm42370p-v6-0-e53884f185ff%40axis.com
