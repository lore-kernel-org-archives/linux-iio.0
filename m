Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB993515DF;
	Mon, 19 Oct 2026 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376141; cv=none; b=WbG0kVKXSlTQAtu4/kQKFiMMwXL5XhiSfEjaNaYKV/IgP6u2rMDzJxT2OlTT8nvhICvFCY+k2Snwrs7Q08KNGsdb96ue2nGnuTEeKV7OGi1K82Fx2PjkvFFyDgOlGhuED0neQTcAEF4azyz/dBpCAERGWCzDZxxMFFLWVGHZKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376141; c=relaxed/simple;
	bh=hHyRIG6B8JqSLcobiVX0pG3LsTCfKQORZICSvpdpMIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXglJClQ+NgVh0zS8jbJ2BRAqxK+OLc6iuBUzoPes7YHTAPzzf0wtOUF94Af7ZIoUb7c76aW58Unzpt0w868t2gS09QXGGflD3GspcH2pg2kGL7LsWccI2fcaSTGe949JflfSMfe6I3PYxxckQIHcAgrEmsfUVkMk2RxMMY/Mgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moA/Q+Px; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moA/Q+Px"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B221F000C4;
	Mon, 19 Oct 2026 02:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376140;
	bh=cQFWfoXDdkcfR0W/4Xa+pHeOAwrT9wkvDMQxWmOzl2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=moA/Q+PxiVCFtO7dUKzE59NQLqN/p/iePabOrq6wGE+mkEfZAhwmq1J7NowUni61H
	 gSLhYuR8Fe+NTWD+YR3tbQi82TkMkz6C0U2Obaf/uK9M/Fvzulpo27rNqw1vHlM4NC
	 H6OTnZEqjlh+OOvNUcYCxZrLySWY7NcH9Vdp4gKBkLxycgHBeRS+eI3Rv6X2mvt8n0
	 jWH4lQpVaXrXxutMMbzpUAtqdKy/EF/NFo7b/PDQWoYyb5pP9NLvpXLR9ZPan3MVhS
	 WBxSpyZnsVXwJesi0rL7jY+yxohIo+OSFylG81z1qOBnKn/4OtYTFH/s0eHHOe0opu
	 1x5b+bWVXQVXw==
Date: Mon, 19 Oct 2026 03:15:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH] iio: humidity: am2315: fix negative temperature
 decoding
Message-ID: <20261019031534.1ac2801c@jic23-hlaptop>
In-Reply-To: <CAFqz8LJbyheyXmf9i6v2cqMgVti_jii5OVe0WSkLvi4sSJXmVQ@mail.gmail.com>
References: <20260928142450.103799-1-vidhu.linux@gmail.com>
	<CAHp75VcW3ADQdf68Whmo7yhqu9rdi54YVYgyh5PRLPccH6aUBg@mail.gmail.com>
	<CAFqz8LL0bgOu3TKfxz0Ri=qw09wVHC68CbVS2yZZjv7oKTGwVw@mail.gmail.com>
	<arrgEPs779q9ck8q@ashevche-desk.local>
	<CAFqz8LJbyheyXmf9i6v2cqMgVti_jii5OVe0WSkLvi4sSJXmVQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 22:14:56 +0530
Vidhu Sarwal <vidhu.linux@gmail.com> wrote:

> On Mon, Sep 28, 2026, Vidhu Sarwal wrote:
> > Decode the sign bit before storing the temperature value. Positive
> > readings are unaffected.  
> 
> Hey,
> 
> A gentle ping on this patch. Please let me know if any further changes
> are needed.
>
LGTM
Applied and marked for stable.

Thanks,

Jonathan


> Thanks,
> Vidhu

