Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22791DE4F1;
	Sat, 16 May 2026 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778932951; cv=none; b=sgvhKuHR+tXzeRxnOOcoamkspO50m+xUU6toH9Ja2xg74ZnI8shpIQ//3/JbS3LhvieC+akNR90Vq/KsQa0SnEU9yS1GTUzrhozG3+/rQPrOPkk9ua65CBswiNlnTMSyLiaTULsFcVcEBaKIXfo0bfFmTo4jCCJBKD9yiaedgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778932951; c=relaxed/simple;
	bh=1MGl/KztPgwhQg5GSBl+fNG+g/A2gqU8OXfBKbY2XYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nizmNDgQSO4AnMxE40QlQcLrWVYgXxdgRCFpkGuVyxEl8SxKV5UufEtKRl8DRkyIUmTU+YhwXzWGe+kJnjtwRioFG13bMqZdT3qTatHIPUv0Q6lwdfynEo852m9kzLpRQxD0jluQukUiT1nXpQYbxN2g+ScZqXWhla/lXxbl9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqcPm0Kn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqcPm0Kn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63926C19425;
	Sat, 16 May 2026 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778932951;
	bh=1MGl/KztPgwhQg5GSBl+fNG+g/A2gqU8OXfBKbY2XYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RqcPm0KnepzEc1pnInmpCgx2+dCurNnW7+v1P+xGEGwJUBWjR6YYMPI09PKGGn/Lv
	 iJsQhY80WvVJvgFuGTz/PUjmXfx0dSeIv1iV6VhMguJaOXagbHcpePzW7dk5+yPkyY
	 W2uJQapbabR0c4aLnZYxGZr/mkZk85GvRrJJQaRQc3uxRuSAc+dtUsRMA2fyMWwHlW
	 P3iiZSGue934+xTfeebN77u6EweEu6wZclw5eYiF4+ztLl/GGF1Gbe0gN2NxF3M63x
	 I3bBJlbL+zFhkRCdgVIGYY+PL4oQVXNOQNUbAKcQ7RR3VBdEsB6XpIg4frgx6Se8DV
	 AKGyG9EBHzPVQ==
Date: Sat, 16 May 2026 13:02:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Alexander Koch <mail@alexanderkoch.net>, Michael Hornung
 <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 04/10] iio: light: opt3001: use local struct device
 and i2c_client variables
Message-ID: <20260516130222.10e4ca6a@jic23-huawei>
In-Reply-To: <20260512-opt3001-cleanup-v2-4-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
	<20260512-opt3001-cleanup-v2-4-8018cf3a8a0a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 12:57:24 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Switch the driver to use local variables for struct device and struct
> i2c_client to improve code style.
> 
> While at it, ensure that parentheses alignment is correct in functions
> that were changed in this patch.
> 
> No functional change.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Here onwards will be affected by me not picking up patch 1 so I'll leave them for now.

I don't have anything to add on this one.

J

