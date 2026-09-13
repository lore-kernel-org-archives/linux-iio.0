Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C543AFAE4;
	Sun, 13 Sep 2026 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338121; cv=none; b=hEIakGPI4fo9W1u1y3RXHviKHC95kPeviwGU4PoUHV8AiphB0jekrXPVI2a909RbQiBCvzS/8M2Q10esRLy6Ha55BtOfZ+qr1Orbkp4tvZwrsXF0rY02x3XSq4B3TaJ3TZFtPe/I0mv0Rl37Sqtw6ChCr9/XBwuZSX9jC3Bbqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338121; c=relaxed/simple;
	bh=kq1BpoM7C/V6JQDkCK0zkPTDzzMuB0vOaJfQ6WvZF+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXOb87A1R6kEr2Q4e6ynpfagTTL0rOby0JuBMMkTAK81iMvc+yJz4kHjBnEfoQMvRRNkJHKqE7GfFne7jL/VRNyjck0maXd4jjG7CgsSeROhFOJegEoOs+km7i2NfM2+z0vo9qg8IXZ3s8EBKrRH6efcvHzJiIABqWByalOU/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLDha/A/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLDha/A/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C1E1F000FF;
	Sun, 13 Sep 2026 22:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338118;
	bh=9O4wxgg5dOPGItfKtMMGgnoEa529njmg7OZ1AsNPJ0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SLDha/A/RueVnjMJCTbFBwoqJVkLLHa1CxtQRfvdFmjUP19KsYes8f6cP2Ep18Uts
	 QrmVo8/nnX1WDeX3rJcl8lbJsRXi8ZCiByOFNANxcwFM+apBXcXheCtdiWBCsUZzSU
	 GuZXrOMf0d2wTF9bsn6tojG24a6WxNhnz1t0/Yskm58zS8PGi0dtbiwm/K+6QAKMG2
	 xTFbpkK7yjVW3opEb4fSXxmSyNCD/aDCRe+e4ER2t6zrqktpSXVDNXbkGcyCNl5aGk
	 3vWJqSR4A1Tq4SjGKirBkJO5CowhApD0zxE0RPLetmGux4NPFKEO3ke2ts7i3+qeXa
	 +iFnQD7lqBibA==
Date: Sun, 13 Sep 2026 23:21:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ad4080: add support for AD4885
Message-ID: <20260913232155.5b8d226f@jic23-hlaptop>
In-Reply-To: <20260907101944.9748-3-antoniu.miclaus@analog.com>
References: <20260907101944.9748-1-antoniu.miclaus@analog.com>
	<20260907101944.9748-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 13:19:44 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4885, a dual-channel, 16-bit, 10 MSPS SAR ADC.
> 
> The AD4885 is the dual-channel variant of the AD4085, sharing the same
> register map and SPI interface as the rest of the AD4080 family. Like
> the AD4884, it uses two independent ADC channels, each with its own SPI
> configuration interface, but it runs at a lower maximum throughput and
> therefore uses the same maximum LVDS conversion clock count as the
> AD4085.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
LGTM. I'll leave it on list a few days though as we still
need a DT ack.

Jonathan
