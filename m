Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECDF2BE7DD;
	Fri, 22 May 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472055; cv=none; b=qFwppx7htxQfwVb4IIVMC9caDJElfqpi3FnMSrPkPY5q9W4hYTlGFYgRkCIytgwyTg5qNP+cPGYoXU+kB2B3nqjmms/J9ixdTV1J67+SRGcFhGZNfzAPsOi2ZAxivJpWMVQvSYI9pRFVWg1BL9+Vp3IXm+iukwh8eNcZkPw5LdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472055; c=relaxed/simple;
	bh=QAsnBcLvhHzJOKM8KliDYC3zKOVCXqFQk+MalyCmSgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQJMQqEipAuTyIPeijSsRm/Ce/gBhQ8UPVN5BUB9hylePTgU48XNGyTM4usDHypHP5UD5cVPOvUoA9fG2u2UcGNt4oxxFQTt1rJ8I3mFAIvQ8ki88ZQMB6Nnim8Df6cdxO4Mml2WNgdn4b+DOvIg8Eg/dkD9/L1qanlk9Et5QUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9Vf+Chj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9Vf+Chj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47ED1F000E9;
	Fri, 22 May 2026 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472053;
	bh=wdOZgX6GWu7ll+GHDji6Q1cRH07Eb0/1T8YPJc+lGRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n9Vf+Chj4dDZA7WEztbYrqM5abCwFZYlJwQbc3/A02XwnezJqBCLELHJiqe2M50dK
	 W6/ySaL2OjUgros64EVhJmDcSxoV3gsSEJUnW202I0ahtBLrIbvovJsdgC7ZdrFcXj
	 0ANhJmLGg5j1ioMgepa9W4nokanAEzlKaNhJPWuB6tfoe9GQO/fBZiYtYNDiahSRVS
	 9+pgaufdD1DfEuQPeunOnL3vos8R5JQU5SuYHOtQ4LRFCumuABp5Lc9LzRc9KWeioy
	 SAu4zAzEUub3AGtbog2wO9HugExKT3EfR4aa1AjGvlkXVKZKPXBoh2lIkTpY110m+3
	 5nJNEDXy9PI3A==
Date: Fri, 22 May 2026 18:47:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 04/13] Documentation: ABI: testing: add parent entry
 for iio channels
Message-ID: <20260522184722.209f3c96@jic23-huawei>
In-Reply-To: <20260517-ad9910-iio-driver-v5-4-31599c88314a@analog.com>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
	<20260517-ad9910-iio-driver-v5-4-31599c88314a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 19:37:48 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add documentation for a read-only sysfs attribute that allows to expose
> parent-child relationships between IIO channels.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 925a33fd309a..399944974e34 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2118,6 +2118,19 @@ Description:
>  		specific attributes. This is useful for userspace to be able to
>  		better identify an individual channel.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_parent
> +KernelVersion:	7.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute containing the label of the parent channel
> +		for hierarchical channel relationships. Only present on channels
> +		that have a parent channel with a valid label. This is useful for
> +		userspace to organize channels in tree-like structures that reflects
> +		the physical or logical relationships between them.

Perhaps an example would be useful?

Otherwise it seems reasonable.  One vague concern I have is maybe we end
up with a channel that actually has no other existence than as a parent.
Image two signals mixed into one.  If that mixed signal has nothing to control
it wouldn't normally show up in the ABI.

I guess we can give it a label though to ensure there is something there 
(even when not using labels for this!).

J

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
>  KernelVersion:	4.18
>  Contact:	linux-iio@vger.kernel.org
> 

