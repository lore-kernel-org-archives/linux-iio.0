Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4426A0A7;
	Sun, 23 Aug 2026 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447941; cv=none; b=Kfhx8IKvxdsbB0AZu5Vh2yHv68nIlxNXaMzgOrjXWbLYzk1wdSx4yHi/g7Li8Zopm+ShJZeEwFcVl7FpiPGsoxtqK4459xlEzFucNmHtWt6nfhFlPByCi+Xpq+KpqPYX/i01MYiENbMydLnSyhbGacG+a0Y14yQ9Kyj0fFRYhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447941; c=relaxed/simple;
	bh=02yDEM1j4MXomiOVVPxUVPuKJjeaRS3im4AKKFSsS9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sft28t8//dZxi06ZdQiqzb924fR0EuRyCD4FNuCHpg8yRqFapDh27uAQo1F7Sn++aXmajluB7kkBPLewlS2YgWDQw0YgsKcewsdkUR+jWXiGFoPhjSlMmxWMKa/e0QmnM7VN9ca0UsotWDwLHEbi8a0QecGqivLmJOgJXs2TjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTEs5gAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTEs5gAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5661F000E9;
	Sun, 23 Aug 2026 01:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787447940;
	bh=wYOO3CdXvlKH8yVkpzLpoijLGnZCZnfLRzL6voEADEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UTEs5gAGJ65bHpjOaoJxhKcFb2ljuqFUS0FdIutyYBxX5LTKMLuBvjmCFkT9awPfo
	 CzXMY50mGUQYLI7Xg/fvLTAwAnlMA+KNURNHyLJXVUGE0jwo4Q90RxkTGb2ukr/pG3
	 0Iou8ZA0m2xcr/6Pr57+OPshU+RAJvYAbqMVcwldSVrPLOrVxGj2EWqYqIbUh0WqG5
	 gd1RXeHTPN2Vv8PwngR/NVoyPvMVx8miRIKGfZ+NyIBAjNjjJ1HTkE8WRNmQdjl50s
	 4I53KYLd29u2ptbQTGJQLJuJfxQjaIaLnzyknfO1X4pBp/6OAVWZNHK8vvzQ/Ev1u7
	 geg2coOY6GYow==
Date: Sun, 23 Aug 2026 02:18:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux@analog.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: Make sure clk_init_data is fully initialized
Message-ID: <20260823021855.6f49bfcf@jic23-huawei>
In-Reply-To: <cover.1787240005.git.geert+renesas@glider.be>
References: <cover.1787240005.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 12:04:05 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> 	Hi all,
> 
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Hence this series aims to make sure all members are fully initialized,
> to avoid such bugs, and to prevent future breakage when converting
> drivers to a different method for specifying the parents.
> 
> Part One[1] fixed all cases that I identified to be real bugs, in
> response to a crash I saw on BeagleBone Black.
> 
> This series is the IIO subpart of Part Two, which fixes remaining cases
> that are currently harmless.  These are still fragile, and may cause
> future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Thanks for your comments!
> 
> [1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
>      initialized (part 1)"
>     https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be

Applied to the testing branch of iio.git.

I made a trivial tweak from {} to { } to follow the style we are trying
to stick to for these in IIO.

Thanks,

Jonathan

> 
> Geert Uytterhoeven (2):
>   iio: adc: meson-saradc: Make sure clk_init_data is fully initialized
>   iio: frequency: adf4350: Make sure clk_init_data is fully initialized
> 
>  drivers/iio/adc/meson_saradc.c  | 2 +-
>  drivers/iio/frequency/adf4350.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

