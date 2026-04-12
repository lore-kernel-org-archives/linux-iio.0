Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA661533D6;
	Sun, 12 Apr 2026 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019575; cv=none; b=m4csifJbmWZZFu2VKiZh18bCXqmzUC1LBl0Lm9dE5EvhG/ZvMj3KhyVjxuf5+d8tk0jW/emk/vWnjppRG0EweAcoiK/29MeEDNnR3mxWl3MmzoxbVdKThUeoYQMpJQpbdgTXTO22fdXUn7IxvRp9/bxzwpeC99EfYXtgj2nBfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019575; c=relaxed/simple;
	bh=jaqZ6+8tsFk7bSV56E7zUhKYMMJy41eQnIkW7MdyA3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1X/X3F5YxIWE/zAoarQeVPzlVCu8r0nsjTZcfGeCK9OlEYLku5VyyRHF8fx7PCPEUnkSlx7fbzwq+ZJIPi5GTIMclg2h+v7Pkb5V7An6LDJYcKtEgOhb0cb9LsdUYUwoPDa77NOtP/KXzfHMBTo+tY5YyRoBXFIXHL2skeG5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+v630ci; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+v630ci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB760C19424;
	Sun, 12 Apr 2026 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019574;
	bh=jaqZ6+8tsFk7bSV56E7zUhKYMMJy41eQnIkW7MdyA3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A+v630ciLs/qQLtVd+hDNk2TB5BaEarE5ktQc3XUYDJSmjQHUIDGgSSeYiu6UWtiP
	 eDKSGNEJYjUQFs87H9tP5lNMrW/b27S3ntIsvWHvzmKoF+K/FfohP1cYybMbb7shQ6
	 eOqtAoFZUD7Dy3YQIuVK3QlLJs5+1m2Er1MLlXCdyr4R57tU8oYC6Ptzh87763vdSk
	 dtNNATUwMHnN/0J/Izo0H7v7igKXfXJ/OX6kabc+ArZ3bJmrWo4JTlWp5zsT7jA8A2
	 wODUa18UMB863C8Q7YnUma+6DvmR9t5dCoBiNpqTuMXHxGYHPls3tb3GnficCNeFXE
	 2duGaVZEDJ5vA==
Date: Sun, 12 Apr 2026 19:46:05 +0100
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
Message-ID: <20260412194605.6d04ff5e@jic23-huawei>
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
Beyond the discussion on v3, in what way are these now config masks?
>   */
> -#define AD7816_FULL			0x1
> -#define AD7816_PD			0x2
> +#define AD7816_FULL			0
> +#define AD7816_PD			1
> +
>  #define AD7816_CS_MASK			0x7
>  #define AD7816_CS_MAX			0x4
>  

