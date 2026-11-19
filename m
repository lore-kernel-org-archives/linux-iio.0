Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052651;
	b=ibDKlMT1eJN/pL465KqXtgoCM5OBCA/3I3DiEO/623EBqDtDZ2TQ5T8no/CCsdi17VxU
	 ZeC1tr+wW+IB1ZLLO2DhUWzT8+wBS8Rgomq1E7zRZL/qGl09ZX+EncDMPwqOsVGnRVxLn
	 S0RzT0547rYLBidQg22VBbpIIm6RcyHETY6lRNFfkx7FCfrzzNG3bEdJyHQQTI1LNF/Ht
	 iJjugCJtmQdmemU+zWuAVdjCZR9aRluyYz6EMzPZ9Uj1iSpRZl3C1UN5+tPCQAlPakuxK
	 nEZU42fMEeuRzfZ+GFH8j5d6nm6NhjOfHooXTODuG8mb4m+v6H3uGAXddKJKBg3JS2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052651;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oR3zaB1RSgfSBALWqoflY3XEFZ9EicoDk2o6RRqqgQU=;
	b=cwR1UVMQLAumVIYm/QhXYyTsM6E7YFFwU15oDxYs6OfZ072JLR3sKxOXEf5WzC4gFv3S
	 usuuwBAv+vRziXnm3qL6uZEuZ38GxnCB6ckrKrXH4jBctQWVzuExmKNdHdg/Y2Aem1QPZ
	 OHFujw90cPDLTfUm/BNtpEdoyS9BdcXiq4U06/aKjaODeWVTMlWdEFiUo5v9vYkxSTEzp
	 aq42JtHGG9DRpE6vZUDjcNNBXvIJ8jFqj8RqKkuCjM8y/qcNBT0hBUaq3Gi1iLXuG8SPc
	 hUudEKQryiytsl9qtcWcUivDstar3zbA4YapgSa5Kxx9gWnMKK4vKap+/9Qw6FXVxmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcTVlPB4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37312606A335;
	Thu, 19 Nov 2026 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcTVlPB4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0F71F000C8;
	Thu, 19 Nov 2026 01:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795052651;
	bh=oR3zaB1RSgfSBALWqoflY3XEFZ9EicoDk2o6RRqqgQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CcTVlPB4U+q9gVnBm1Ll2kZJJswO7Jp5t1viC3TFRvC158JdFvxOP9NHkkfIwUwvt
	 tNpg4T3+jywIPY/ZV3EJMEZa+1CGKHBHE0RP42FaKvvEitzOuHpeBJ8BP1OuNHRr7Y
	 eRityK3lXK9OABtV2Uzd0+BMmAVa3lW4zQyI1usT4pi771fsoBWDkcgwKABh3Zol6x
	 18fVJ60eViKAOAFb29gyIcGzpic+SBmwtd7ethiTG2J9bWLZvlxutdqdrtWCaC3CBy
	 9hCbCEsOKo07sO6ot1cOS8jEUeqygwE1sOKP8liCWdrpXunsJHxTNf1N2LiTiu05hX
	 2fVKRJobM/GDQ==
Date: Thu, 19 Nov 2026 01:44:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: NanamiKite <nanami@yosoro.hk>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Hans de Goede
 <hansg@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: cm32181: Add support for CM32183
Message-ID: <20261119014405.2eee7298@jic23-hlaptop>
In-Reply-To: <tencent_E90EB0AF3888FA057AA5F6008C16C610650A@qq.com>
References: <tencent_E90EB0AF3888FA057AA5F6008C16C610650A@qq.com>
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

On Wed, 18 Nov 2026 23:11:00 +0800
NanamiKite <nanami@yosoro.hk> wrote:

> On the H3C MegaBook 14, the ACPI CPLM3218:00 node declares a Capella
> CM32183 ambient light sensor (CPM0 device ID 0x7db7 / 32183) at I2C
> address 0x29. Reading CM32181_REG_ADDR_ID (0x07) returns 0xc383, with
> chip ID 0x83 in the lower byte, causing cm32181_reg_init() to fail with
> -ENODEV.
> 
> The CM32183 uses the same register layout and ACPI CPM0/CPM1 tables as
> the CM32181 and CM32182. Add chip ID 0x83 to cm32181_reg_init().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: NanamiKite <nanami@yosoro.hk>
Take a look at linux-next or the iio.git tree on kernel.org.
Or indeed sanity check the list.
https://lore.kernel.org/all/tencent_850445458D21608E9C8821E6728457F31C0A@qq.com/

Pretty unlucky to hit same thing that was added about 2 weeks ago.
I guess that device is proving popular!

> ---
>  drivers/iio/light/cm32181.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b32a940..aaf1af3 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -200,6 +200,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  		break;
>  	case 0x81: /* CM32181 */
>  	case 0x82: /* CM32182, fully compat. with CM32181 */
> +	case 0x83: /* CM32183, fully compat. with CM32181 */
>  		cm32181->num_als_it = ARRAY_SIZE(cm32181_als_it_bits);
>  		cm32181->als_it_bits = cm32181_als_it_bits;
>  		cm32181->als_it_values = cm32181_als_it_values;

