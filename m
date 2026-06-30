Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7D202F71;
	Tue, 30 Jun 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780633; cv=none; b=Wt7BhCEWuDXu0+aQOs+jrt+ZqUbSl+pUkTgv+/EK2SRaz8Mdy1/ldqUxPPqV04EvO4SSaoUuy+cEc8RrVY+sNom105U+A2hXO1bRiWBmKzXggdgOBqe7gGpWnBLUqi8xVd2vKxaDmH9vjVKB2Zj94pdI6UXOFV7S9wkVgnxUEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780633; c=relaxed/simple;
	bh=eGB1aA3MYZSQ4ABwOXSfoaX8dodZ8wViZDuZ158V2kg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Or5uqpmrORUU3KJR+yYttUJz82bGnEZHeXYM4QW1JWbHKzijjE9dzhaks6jK3bhdD2R/+//flNH+sU5RopxUyKg8yD5QKXyhlOUJoBczkd/jCl3BqR6488S8M/fC5/QJCdXEjdA0ptCdvRqpVEM/KfTxAdvI3mS11P/Ws5MjYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7oVdGpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7oVdGpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1098F1F000E9;
	Tue, 30 Jun 2026 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782780632;
	bh=byOD9B/TMVPb3ZQ/y5PPcVmLSHr/LCJ5i59OYDGhbJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S7oVdGpDAQxIEAe6/wZe4NnhbGO2Iwk5oZ+coVc9ugd1oOTtIJSXv6FNZaV2fDMSK
	 il5zxn11kjK8wWjoKl3r3TJei4ImUN6hqR3zmG9lMMC3FyhJ84NJfJ6SIjuZ+0/94c
	 kcMR/pAPTkYr4MKCsogaphuvhP1LU2klEMbFouUuXF8949tVPW3SiW7YDJ9tXJ/6QK
	 TXYDSo4lHWZq7XLRHgVwul9W6Hc/69R1NONMiX8Gq8NtNMqj1WfaDDr6yrnBiZ2FmC
	 QnpHj58Y9szJ9SMLl9vG1e6X0c/CHVrKDesKuHlNESmMqw76gP1zuGDb3+PJCe1FhA
	 jZR9AQl0yi7iw==
Date: Tue, 30 Jun 2026 01:50:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: adc: ti-ads1262: Add conversion delay
 support
Message-ID: <20260630015027.3afdfc3a@jic23-huawei>
In-Reply-To: <20260628-ads126x-v2-5-4b1b231325ba@gmail.com>
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
	<20260628-ads126x-v2-5-4b1b231325ba@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 00:36:06 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Expose the programmable conversion start delay as a per-channel
> IIO_CHAN_INFO_CONVDELAY attribute.
Coversion delay was always a somewhere weird bit of ABI.
What are the delays relative to in this case?
Is this a device that does simultaneous sampling?  Pictures
suggest otherwise, and convdelay is currently only defined
in that case.  We might be able to extend it but it needs
some thought.

Jonathan
