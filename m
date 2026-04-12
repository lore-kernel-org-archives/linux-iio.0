Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10798533D6;
	Sun, 12 Apr 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019545; cv=none; b=Ji52AsejwK22cFGyElH06nFa7OdIPBLKfkyTYWVB1r3ppCrxaSSXMZKbciuxtlFwbhyQnTucnoma6onyq6JnmcYx8isudcQNmVIK+94KIWJe/fZUwmjZUW8ej9n/s/VuMwFi6/9ju6uTiijbyv4V3gtVAEHuEgu938YQe85C73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019545; c=relaxed/simple;
	bh=Agq7iuZI7TwoDC54sDJNra27Vyhdi5tX5HeVWEKIW30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anPawXAv9yxCpw/96EzkD3tsJxNeWgwIRLmpYu8QvY5rRrlKUraXApW4rb5CiFwkFgjtJrBYsRxKfhxVhXiPd3vF1oc6ua5CmUnebuhA0oFzFIRhQPzHtgTAG2Yw3o3pSb08esVu7RLOGwAy7wgE9+oaxHu86MTrcuf1mMgmlXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bycqnVpX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bycqnVpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40F4C19424;
	Sun, 12 Apr 2026 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019544;
	bh=Agq7iuZI7TwoDC54sDJNra27Vyhdi5tX5HeVWEKIW30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bycqnVpXPTPgvJw8/ZAaGyFmwEL683z7xemZeNS8KtMVWpqQ1Dhgfv0MIk034UQZm
	 K7nzHLHx59Kx0TtYB5cAimyXx0N7QxFcPzuEKaD4ebTaGebyzS6TUAJVgZfJntQOwU
	 f3R0TtJ/H5XaIj5RmpcJQ+9UNQJBsS18fV6gBZHonBwiyMchpv/YD4K6MpnnXMIGru
	 IGm6GK19gv5s0xkougYWIIdu1GogqGfRhlgUeOcJiwNGO6TRNpnwfp6+BBiQNd8xW7
	 Dm7NwO+zGxqGCrRxybRiZl6oGd2T3rMAwW+sNar/6iTFK2+wzVb/adESQcbNyc7Lwn
	 TwTQeCIzMAiLQ==
Date: Sun, 12 Apr 2026 19:45:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] staging: iio: adc: ad7816: redefine mode
 constants to start from 0
Message-ID: <20260412194536.51fc4d02@jic23-huawei>
In-Reply-To: <20260331072453.6530-2-mdmahmudulhasan1511@gmail.com>
References: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
	<20260331072453.6530-2-mdmahmudulhasan1511@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 13:24:50 +0600
"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com> wrote:

> Redefine AD7816_FULL and AD7816_PD constants to start from 0 instead
> of 1. This change is necessary to use these constants as direct
> indices for the mode string array and to align with standard
> indexing in modern sysfs helpers.
> 
> Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>

Hi.

This shows one of the perhaps less well documented bits of kernel process.
Hold off before sending a new version for a while!  Dan commented on this
in v3 but after you'd already sent v4.

General rule is wait at least a week between versions unless it's very minor
stuff after the patch set is very stable or you get an explicit request to
repost sooner (I'll do that occasionally at the end of a kernel cycle).

Anyhow, see discussion on v3.

Jonathan


> ---
>  drivers/staging/iio/adc/ad7816.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 172acf135..9a2f60b97 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -22,8 +22,9 @@
>  /*
>   * AD7816 config masks
>   */
> -#define AD7816_FULL			0x1
> -#define AD7816_PD			0x2
> +#define AD7816_FULL			0
> +#define AD7816_PD			1
> +
>  #define AD7816_CS_MASK			0x7
>  #define AD7816_CS_MAX			0x4
>  

