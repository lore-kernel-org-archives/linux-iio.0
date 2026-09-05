Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713E2F7F00;
	Sat,  5 Sep 2026 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569505; cv=none; b=dRGd2OkZU8OQGv5cro2SOkjHi15+5I8BohvxzvLDhcitV9qKWX5OfJ7gS1HpYnhdKcXliCf/+iKAWc8I4GRZLfnPG53dTptbjLZELtQzjrUWL8M59eCU7OOsoKPtp0GkfTxwXtTnF9AE9W8ZdPSztwHYRLj/qZROyPJGV1n2HhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569505; c=relaxed/simple;
	bh=KnVN5xtkqDAv3y37XsOhPZj+6LXQUEF5dlkm1D6vk2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIF31c0wAdA8+VGTfbbqjVCV1uLN+UwE5WDgnOlfLfEibRLd1G8qtJtgv3O/yEZqVdhqbeMlaACfJQeQvu/2NkvsJ+4xHTQVrnsXHSe21B9atzAoFh/alqmTuV6a2NsYFoKIixDsDucDBJChA+jqYn17y4TbxySR5BB49i7iXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUXHTjMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUXHTjMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A941F00A3D;
	Sat,  5 Sep 2026 00:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569503;
	bh=pNS/yp0ToiRllsSwmF6RE+K9dTG8ctvR08M7jDDCU00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kUXHTjMxkUuK+gWD9wasMEh/8s7gYieta7nMuYPSh2inHJsA1Mp7quSRB4tRz+FUp
	 c/kkFZHPgdBQa6vrsCYLeJjF2cpqNPTWajNdKNbakjdIFgfiMPhlLosn6dOY19bJN7
	 QluNO8JZsKfiWTjwgwpXD5KbH3OhuygorSQOw91BpczA+juwlPXecw0vQ7lC8jVPy3
	 gSKwGMaOm+edfkmB72DWz3j4yvjAfeBrofTTlMZnd4upw3QOMy0W+EEvGQwdSXwwUQ
	 QaLi+EEH3s2QUJ7yA1QXs1JnpUW5jN2VG2Ld8hUGrAlIEJbplWgxHeUL0GuCJGNWF3
	 kNO26d4IzWYqg==
Date: Sat, 5 Sep 2026 01:51:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, Kees Cook
 <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Weiss
 <luca.weiss@fairphone.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 0/5] iio: light: stk3310: per-chip match data and
 STK36C61 support
Message-ID: <20260905015137.66432d84@jic23-huawei>
In-Reply-To: <20260901005114.203062-1-jorijnvdgraaf@catcrafts.net>
References: <20260901005114.203062-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 02:51:09 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
> colour sensor whose register interface is compatible with the stk3310
> across the ALS and proximity data, threshold, gain and
> integration-time registers this driver uses. The part name comes from
> the Fairphone 6 manual, which lists the component as "3IN1 ALPS/RGB
> sensor/STK36C61". The layout was probed on the device: chip ID 0x95,
> the stk3310 STATE/FLAG bit layout, data and threshold registers
> (thresholds written through the event interface read back from the
> chip, and the FLAG near/far bit crosses with them), gain and
> integration-time fields the ALS and proximity readings scale with,
> and an RGBC data block directly after the ALS data, the red, green
> and blue assignments each confirmed by the matching channel
> dominating under the matching illumination and clear by its broadband
> response.

Applied to the testing branch of iio.git.

Thanks,

Jonathan
