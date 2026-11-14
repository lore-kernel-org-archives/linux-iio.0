Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621334;
	b=b7mWV9o1v78l9NqGdeuNu7gKl4cm9kvnENEvR/IqcIeIUMLEX6aAlR8Ltuh4RgfAUDEM
	 Wj3HCOL9Jiip7+Z7yejkGMT2erDDGg5U7Ymjel2MiSIw3Q8BrhvA1Qqw25uw3WPjcDxWt
	 6730WMzDMPQgTOjfI62hYioT/DkFPUv4scLt4tYfF2u01hB2CSAuweO7yughFGecqke62
	 gYmn40fPjcZ4KfUcNSuS82xstHSB4p0HGpmQUWgRox8bQhsC5480zHSUXJqs6j4hDOFpf
	 AHalcqqrjz9hr21LqJTS31S+MTvlXT6YHeEICBJGCkIwmuYWc+w66A2Gf4K/s/FjQQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621334;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3cz+V38plNTJPcp3llScVwOtDk3GlbXYerN2ggsL2T0=;
	b=vfNPCJuDFGxBy3aoLZ3RhsFwIw1yqDjcyjzJ7HB2asB1axxh0Uv5bj2GknmdgxfaYIch
	 +ADZjaiR4hf1fbcLp/lU8KbWzf+OauHDGJ8QnkUOcz0Q84tAnvdPdqE2rPy0Zfv5Qp6yk
	 OzsC6wZJ5cKbCM/rEvrwq4onseiLBTtuXxU0+SfdqgERLeMxlHCzBgcRsOVOvffZZw9kx
	 nU622vbszX/0IGKDilexghT57IzzNfG2B8+Z2f20Sj+Jeql6A7JyMxN49GNTF3wCaVesM
	 J8lm8WY1hLK5mqakweWSoso/cjjNcHwBBvGpYhKjUVVXRiJg8F08kXPd2i0wfG159ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfWoaAbo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1059606A329;
	Sat, 14 Nov 2026 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfWoaAbo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC0C1F000C4;
	Sat, 14 Nov 2026 01:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794621333;
	bh=3cz+V38plNTJPcp3llScVwOtDk3GlbXYerN2ggsL2T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gfWoaAboZbJALt4PM57nLrHReXg1HEKQMYJ5UhQbhDV95EUbW+7nDyspw/ksWqTz3
	 QzgX4Z9D4kwnOfXnQj3dsIHw6WNFvAu1CWoTVk6sLOiZzD6WMhz7deepEg4LP3KcDC
	 lYZFCU/klw47T6lCu/kodjgIiYAs+Zu2Cm27LXm+h0NTctVOpzEfo/4/rDHp2Jz+53
	 MQDMuAwlVzIvGnBHuUtasx0fcCqqyitC0PAPvgqj7dtWdgIiT5L/ZL5T3tnHk8g/Xx
	 54Pri++1G+sHKGIji9tePc1QPT98SxDMJq72p/kRDSMwAH7mJtIH+r/j9AuISsvfmv
	 fFhobGq+sKKhA==
Date: Sat, 14 Nov 2026 01:55:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable
 Hub)" <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] iio: accel: msa311: use regmap_reg_field_*
 functions
Message-ID: <20261114015302.2d8390e2@jic23-hlaptop>
In-Reply-To: <SN1PR12MB25284D05A476483E668E1255A57F2@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528812E26B65457239E9EEDA57F2@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB25284D05A476483E668E1255A57F2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 00:55:46 -0600
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> Simplify the driver by using the new regmap_reg_field_* functions.
> regmap_reg_field_FOO is equivalent to regmap_field_FOO, but takes
> a reg_field directly instead of a regmap_field.

Hi Victor,

In general this seems like a reasonable idea.

One minor suggestion inline on dropping some comments that
add little value and reordering where the defines are to
give better grouping with what they are about.

When sending a small series, just send the whole lot to the list
and all people on the thread.  I had to go find the context
to understand why this was an RFC.

> 
> Tested by compiling.
I'd drop that below the ---

Thanks,

Jonathan

> 
> Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
> ---
>  drivers/iio/accel/msa311.c | 298 +++++++++++++------------------------
>  1 file changed, 106 insertions(+), 192 deletions(-)
> 
> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> index caf9b1b6397f..63c795d6bc99 100644
> --- a/drivers/iio/accel/msa311.c
> +++ b/drivers/iio/accel/msa311.c
> @@ -75,137 +75,85 @@
>  #define MSA311_OFFSET_Y_REG       0x39
>  #define MSA311_OFFSET_Z_REG       0x3A
>  

> +/* Soft_Reset */

These comments don't add any value because the register name is over here...

Obviously one set of them in he original code were equally pointless!

I'd be tempted to format this whole thing differently to keep register and
register field definitions together:

#define MSA311_SOFT_RESET_REG     0x00
#define MSA311_F_SOFT_RESET_I2C	REG_FIELD(MSA311_SOFT_RESET_REG, 2, 2)
#define MSA311_F_SOFT_RESET_SPI	REG_FIELD(MSA311_SOFT_RESET_REG, 5, 5)

#define MSA311_PARTID_REG         0x01
#define MSA311_ACC_X_REG          0x02
#define MSA311_ACC_Y_REG          0x04
#define MSA311_ACC_Z_REG          0x06

#define MSA311_MOTION_INT_REG     0x09
#define MSA311_F_ORIENT_INT	REG_FIELD(MSA311_MOTION_INT_REG, 6, 6)
#define MSA311_F_S_TAP_INT	REG_FIELD(MSA311_MOTION_INT_REG, 5, 5)
#define MSA311_F_D_TAP_INT	REG_FIELD(MSA311_MOTION_INT_REG, 4, 4)
#define MSA311_F_ACTIVE_INT	REG_FIELD(MSA311_MOTION_INT_REG, 2, 2)
#define MSA311_F_FREEFALL_INT	REG_FIELD(MSA311_MOTION_INT_REG, 0, 0)

#define MSA311_DATA_INT_REG       0x0A
#define MSA311_F_NEW_DATA_INT	REG_FIELD(MSA311_DATA_INT_REG, 0, 0)

Then even less need for comments.

> +#define MSA311_F_SOFT_RESET_I2C	REG_FIELD(MSA311_SOFT_RESET_REG, 2, 2)
> +#define MSA311_F_SOFT_RESET_SPI	REG_FIELD(MSA311_SOFT_RESET_REG, 5, 5)

