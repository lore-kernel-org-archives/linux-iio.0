Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052017;
	b=I8lENSfIa65xRyMtM0E8F97oyuYYiWZIKML2tXabmzjCIlKUa+uLid2BJjdzMvJWbMHQ
	 1c9vYuNsNrnvfdfK/TQJKpVGULPeZnVu67wHJjinhJFgt9vEshZmLCSLA07a4jOoK2EVW
	 2dOK6nDHrFZ9saDoEFo7GIXIylnNXdH3rgrEDkbc83BLjb5Vv+r8DWWMdjaDOSiYIv/cr
	 zTPudN/bKbwcJSNN6zDtng7g+DU7OD8lW5k4gxvQkR8Sr3GZVMq9HH2mVk76uHIJrZnr6
	 KnJ7jb55jEIYPfDSTjUokOezWJaw2C1KiAzy9N0CxnSiXdnOqPAKPaKz6z92nQomdaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052017;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tP0juyknCZt8Oi7eygtZ2/jilIZpwxKA+5FAOW9aG1s=;
	b=m3lS9qGRvO73VwlAx9Bzp5Vt2MvICvNaf4eNO8wg1M+6EDmPLg5Bk3vWk3K12OzmR+tJ
	 BZOdrwpdBJwtUd1JTW+LvEbRMfUZcKcAztMP/i8YdNhZ11g3bhGWtrVOvyt+4+7X3XVuB
	 i3/x0RuGw9ezZxnc3BtKzCtVVAYTqsdk5PUkARcPvYNJWWkRtsBD1/KO5Bz4n2D/yOt00
	 DFtR0l6VG6sq546lMl5zp/e446G5zaBgdmDp1gmmhRBz9r20TTwq/CyMwaqqf188Kye8V
	 qVpUNCA4vCh1pY5MiTlH2mJYWKiqYuZ+vn8K/LWZgRG34HuMWJmcvKbVjgBTQVMjtlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ls7L0Wsc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41A606A331;
	Thu, 19 Nov 2026 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ls7L0Wsc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689FB1F000C5;
	Thu, 19 Nov 2026 01:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795052017;
	bh=tP0juyknCZt8Oi7eygtZ2/jilIZpwxKA+5FAOW9aG1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ls7L0Wsc7iCYCzVnyZzARTwRePJk5UiPF6oirwJ7n6IU2Ri8OMuQB1/6hZI4bThbI
	 U2ZGVmGi8DOMpLa0/hDGd6gpJ1cTH/VjFNMaP0/4JPFOrAahNJfeltazzUZ8StWlbw
	 Uf91JLh7A89zfvtsp4X7HNemzsVOmbwAwODbxg9joam8WHoooJyX3joKDQZPOznY8C
	 QebYqazHBwfoQnbQhK7phWmeQQAdLcjfVdBfGqoG1J4QSxhZj84tXoayrJyB3WBULf
	 W2sP26/AYHvuBQw3QQyaqE6URuC0++a56ktCyFeX9Ga3vKdA9KGgUvkg7oZ8gkjs5S
	 xvl9Q3dSaN0Ng==
Date: Thu, 19 Nov 2026 01:33:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Raffaele Tranfaglia via B4 Relay
 <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Cc: raffaele.tranfaglia@gmail.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joshua Crofts <crofts@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 0/2] iio: light: adux1020: guard() conversion and
 follow-up cleanup
Message-ID: <20261119013333.333a1896@jic23-hlaptop>
In-Reply-To: <20261118-adux1020-guard-v3-0-2c6a18954fc7@gmail.com>
References: <20261118-adux1020-guard-v3-0-2c6a18954fc7@gmail.com>
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

On Wed, 18 Nov 2026 07:29:53 +0000
Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org> wrote:

> Patch 1 converts the driver to guard(mutex), as Jonathan suggested
> when applying the sampling frequency hardening patch. Patch 2 uses the
> direct returns this allows to flatten the channel type checks in
> adux1020_read_raw() and adux1020_write_raw().
> 
> Tested on arm64 QEMU with i2c-stub and lockdep enabled: reading and
> writing the sampling frequency (valid and invalid values), reading the
> LED current, reading in_proximity_raw and enabling the threshold
> event. No lockdep warnings and no hangs after the error paths.
> 
> I prepared these patches with the help of an AI coding assistant, and
> reviewed and tested them myself.
> 
> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Applied to the testing branch of iio.git

Thanks,

Jonathan

> ---
> Changes in v3:
> - Patch 2: add a local regmap pointer in adux1020_read_raw() and
>   adux1020_write_raw(), and use 'if (ret)' for regmap_read() errors
>   (Andy)
> - Patch 2: split the adux1020_find_index() arguments logically (Andy)
> - Link to v2: https://patch.msgid.link/20261117-adux1020-guard-v2-0-89707fa070c9@gmail.com
> 
> Changes in v2:
> - Drop the unreferenced Link tag (Andy)
> - Move ret to the end of the declarations in adux1020_read_raw() (Andy)
> - New patch 2: return early on unsupported channel types instead of
>   nesting (Jonathan)
> - Link to v1: https://patch.msgid.link/20261108-adux1020-guard-v1-1-db9c582f1eea@gmail.com
> 
> ---
> Raffaele Tranfaglia (2):
>       iio: light: adux1020: use guard() to simplify lock handling
>       iio: light: adux1020: return early on unsupported channel types
> 
>  drivers/iio/light/adux1020.c | 189 ++++++++++++++++++-------------------------
>  1 file changed, 77 insertions(+), 112 deletions(-)
> ---
> base-commit: d922ed738439e1d5b4701df7f4cdd49a09925624
> change-id: 20261108-adux1020-guard-3820ce794843
> 
> Best regards,
> --  
> Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> 
> 

