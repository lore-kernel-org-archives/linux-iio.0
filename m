Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B034425CC9;
	Tue, 28 Apr 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389134; cv=none; b=fZ4ctcIrdImwrTLfh5jpl1po74k1iz1oeRCd8adzuEQsjTRyKtI96u48XJaXUiR+GBgyr1b+qXupzusnJjvR4VULP6UFlz6IIEIZICqLzJwd7gTG8DXUolV6oDiZ+24o+9QazlUpog/zjOb554xxUi7ybU0akB2ngvONmjPp+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389134; c=relaxed/simple;
	bh=+0UQXFv+bWoqHZIKLg2/d4G5V1y4JinsT7r2fuBel84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ8KoY3YwPCE7dYJheXjTifAPqlxLWmRXLKr9sp6cets6vG7pHHdPz1B6DYR7YDeikdQq2Ax4tNRhneRoMwR4qvWxbzJqJ8uK+OoIwux13AiCS+LCxYIG0TnZl1/UTx+2x1fB4VNxNY2BspEqBqFSf98+QPGtSQ28QReSPxYPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce0ORsjN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce0ORsjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F18C2BCAF;
	Tue, 28 Apr 2026 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777389133;
	bh=+0UQXFv+bWoqHZIKLg2/d4G5V1y4JinsT7r2fuBel84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ce0ORsjNo5R5Qx8vppM1zwBAm5yk/dbwMLETHfdIazLOVNw8Mz0VuOH2sGLWSI3ZS
	 i98s86cAQGOaZIzBx90WcTGaTFMARrD/3OW/vSVRaofdhE2psyW7OSWGK2YnK+swzP
	 1vYDVx/99XOgPZYguT9h+SxrTTSO7RcP8EdslYSwNkirNRA84E6QoyDyS6rWzgRtVB
	 2MzkSgTIF6HJTwfwtY/iffUGrxA+TA/QL6wU0jArZsbMfb55pGevwMwPl2anpoowm4
	 ujCuG1RYRVzl9ekFeRMnaPTUJIys7a/eGuUPhi3U5fBhVh0pHegTNg09UWn60eaT73
	 A6s4++MSn9iRw==
Date: Tue, 28 Apr 2026 16:12:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: light: si1133: remove unused macros
Message-ID: <20260428161203.36575c71@jic23-huawei>
In-Reply-To: <20260428-si1133-checkup-v2-2-70ad14bfefe2@gmail.com>
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
	<20260428-si1133-checkup-v2-2-70ad14bfefe2@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 15:18:34 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Remove unused macros to improve readability.
Hi Joshua,

Don't update macros then remove them - that's just increasing
noise in the update patch. Reorder this patch to be before patch 1.

Otherwise, I think a few of these can stay. See below

Thanks,

Jonathan

> 
> No functional change.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/si1133.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index 52e4269dc35014b87b7c46a120e64723be716768..ada8da122b76c9a0a55751baa6522a145f0fc7e8 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -22,8 +22,6 @@
>  #define SI1133_REG_PART_ID		0x00
>  #define SI1133_REG_REV_ID		0x01
>  #define SI1133_REG_MFR_ID		0x02
> -#define SI1133_REG_INFO0		0x03
> -#define SI1133_REG_INFO1		0x04

This one isn't in the category of things Andy was referring to.
It's a hardware register address definition.  We don't have hard rules on whether
a complete set of these should be defined, or just the ones used but it is definitely
acceptable to just define them all up front as then easy to check them against
a datasheet.

>  
>  #define SI1133_PART_ID			0x33
>  
> @@ -40,7 +38,6 @@
>  #define SI1133_CMD_RESET_CTR		0x00
>  #define SI1133_CMD_RESET_SW		0x01
>  #define SI1133_CMD_FORCE		0x11
> -#define SI1133_CMD_START_AUTONOMOUS	0x13
Similar for this.

>  #define SI1133_CMD_PARAM_SET		0x80
>  #define SI1133_CMD_PARAM_QUERY		0x40
>  #define SI1133_CMD_PARAM_MASK		0x3F
> @@ -86,13 +83,9 @@
>  #define SI1133_CMD_MINSLEEP_US_LOW	5000
>  #define SI1133_CMD_MINSLEEP_US_HIGH	7500
>  #define SI1133_CMD_TIMEOUT_MS		25
> -#define SI1133_CMD_LUX_TIMEOUT_MS	5000
> -#define SI1133_CMD_TIMEOUT_US		(SI1133_CMD_TIMEOUT_MS * 1000)

Dropping these and the one below is good as those aren't register or command
defines. This last one is entirely pointless as better to have the rescale
inline and only one definition up here.

>  
>  #define SI1133_REG_HOSTOUT(x)		((x) + 0x13)
>  
> -#define SI1133_MEASUREMENT_FREQUENCY 1250
> -
>  #define SI1133_X_ORDER_MASK            0x0070
>  #define SI1133_Y_ORDER_MASK            0x0007
>  #define si1133_get_x_order(m)          (((m) & SI1133_X_ORDER_MASK) >> 4)
> 

