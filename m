Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93B3E4C6D;
	Sat, 16 May 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778950102; cv=none; b=s6Ct23dvenBQHhToZCyKjqUyq+G+Hv8lhZTdFetiRoiU6oY6Rn8K0SeqCSN+JHl9/1gIWwPT577h9w9VYtResLRFbqStMKVxe/5xR/hR/Ij9Ak0ss2RjWJI6XYG7eYoDK1k+ECyPC0PrYrY61U4C4ylVWlDdADJi4jEHZGce3AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778950102; c=relaxed/simple;
	bh=Xg0oaIbkXldUYVud3hui19Lb/73VwV79P8e4Zmag96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+YyOUTvB+EskDoVJQiqyulhUk+YXPDqHsbXpg6DTHKd4cpgICW4r7RvuRZf91VkpigNjQNpu7dRHxySbcA3ysi9ps9aer7U50Zw70VRyNIoYel5a5OD1DKLgaojz34KyGNzbegaKodVJe6MQhonTInMsXa/5oBDLy6y+bKJlqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA+1Yu8F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA+1Yu8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD69C19425;
	Sat, 16 May 2026 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778950101;
	bh=Xg0oaIbkXldUYVud3hui19Lb/73VwV79P8e4Zmag96Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bA+1Yu8FYLDy/YdFyO/xxOGS5GctTGR6SuP2q800ovUcMHR5ndMxyQYSmCD7P8Nex
	 bcg0VX5EC+LYsLr62lhczEx+uXfvJ1Cpizrb9uYD9UKS1k7aSpNkpDD8v37eQ9wPnW
	 YXaefL9gqg3fY1mLD5T+NY96tWT8Xz0+QxDd7MWQlli06PIJGZClzKlGkX8nJgu6kh
	 Cu4UZf9tJhocRWdo8qCQiLMsooYRLu2egch1AAplaui87+G6zhcbjjz0vQE1Iw5DQY
	 bozoGgaF/x7Js6ZT9QQxm034375Sug9ygRwpPySFt6RgHie8X9k0bVkE3PIaY6buKg
	 aCUs1KwfDOLTQ==
Date: Sat, 16 May 2026 17:48:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] iio: temperature: ltc2983: Fix inconsistent
 channel wording in messages
Message-ID: <20260516174811.76580432@jic23-huawei>
In-Reply-To: <20260514144712.64374-4-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
	<20260514144712.64374-4-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 17:46:50 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> Replace all occurrences of the abbreviated 'chann' and 'chan' with
> 'channel' in error and debug messages throughout the driver.
> 
> Fixes: f110f3188e5639c81c457b2b831d40dfe3891bdb ("iio: temperature: Add support for LTC2983")
> Fixes: a00838cae079b9b9b90969c2b7b031b1bfd9ab3a ("iio: temperature: ltc2983: convert to dev_err_probe()")

Wrong format and also what is it fixing?

I think you have misunderstood what that tag means.
It almost always means we should backport. Which is not something we'll
do for consistency in error messages.

> Signed-off-by: Liviu Stan <liviu.stan@analog.com>


Sashiko did call out a few more cases, but I think they are fine as they
are using chan: %d to tell us which channel a message is referring to.
However you should relax your 'all occurrences' to make it clear it's
not 'all'.
