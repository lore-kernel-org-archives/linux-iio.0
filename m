Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE13A383B;
	Sat, 16 May 2026 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930666; cv=none; b=mKgUVtu8PZMwWMEfPFABrW9dovYY2GUJEAmL2yv6hYnDrQjO7pkjTZMAOxZwPF7TOOKN2FhD/WiJgw+UpbX4XCI3GzLRy/l9EKs0KPQfnBxQEsGj+/1/YG3+3ydjAwxZrhTWX0QNg7tHcaFdJkGfV14TZxrp6HxS9MWF24fqQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930666; c=relaxed/simple;
	bh=EA/Q7nKqbYFAMrhz7LHhr7+oSbrplCT8HFjH7eXnFe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfPnJ8XHikZ5bjYg1knKVvzCSDJOdSGJGpX+JVLFAkMUO+f15VZDhRNxi2mhA80KaM3EcifQBpQz6GJfCHlCqJYcZ0XNw3Dbse8AovPm3xHC0xQIzq8s835ebJmG7OaNa1CO6UT7gnkmlgO120/BY6H0K+g3Es+DDLXHFtJKTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuXVgXhI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuXVgXhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62163C19425;
	Sat, 16 May 2026 11:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778930666;
	bh=EA/Q7nKqbYFAMrhz7LHhr7+oSbrplCT8HFjH7eXnFe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IuXVgXhIPe8btqPKdh9qBmxCBLOcZAF/MXKt8d79vgBynJygIyUj5Z6w53SMeCvPY
	 YNcTRfclCR3B1UwX4tsw+Sqo2UNlYkzaUIf6CeiNVFEo12Z14S8Amf0I/PQ6PRYaPh
	 7keLO0ahVKTWfL7e0QCOyVuOqF3Kj+pc06y/sNXX/4kena2DzAgzbQywRdC2j2+Yyt
	 n9xLfyxZsQospRAJ/5dg57a1zdYbu59zaLgqWCQtZySB8ecvEffgz9QiHuxqIZEM2F
	 KOvtPJ5WOxtfHKkGanAX74zKmYOWhir2XSn6pzF9rN0TnqFPZH2nLvmqWFg2fkv7LJ
	 9LHk+v1oqk2Bg==
Date: Sat, 16 May 2026 12:24:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: andriy.shevchenko@intel.com, joshua.crofts1@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 gregkh@linuxfoundation.org, hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
Message-ID: <20260516122417.389add6f@jic23-huawei>
In-Reply-To: <20260513083342.764-1-sozdayvek@gmail.com>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
	<20260513083342.764-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 13:33:42 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> On Mon, May 11, 2026 at 19:56, Jonathan Cameron wrote:
> > Silly question for you - how does this driver actually bind on a
> > modern platform? That is - how do we get one of these? =20
>=20
> It does not, as far as I can see.
>=20
> Grep across the mainline tree:
>=20
> - The string "iio_interrupt_trigger" appears only in the driver itself
>   (drivers/iio/trigger/iio-trig-interrupt.c:101 =E2=80=94 the .driver.nam=
e).
> - No .of_match_table and no .id_table on the driver.
> - No platform_device_register*() call anywhere in arch/, drivers/ or
>   board files that would create a device named "iio_interrupt_trigger".
> - No Documentation/devicetree/bindings/ entry.
>=20
> So the only way to instantiate it on a current kernel is an explicit
> out-of-tree platform_device_register("iio_interrupt_trigger", ...), and
> nothing in mainline does that.
>=20
> Given that, please drop v1 and v2 of this patch. The cleanup-for-its-
> own-sake is not worth the parent / sysfs-hierarchy change Andy flagged
> when there are no in-tree users to validate it against.
>=20
> If at some point a user appears in mainline (DT binding, ACPI hookup
> or a board file), the devm_* conversion can come along with that work.
>=20
> Sorry for the noise.
No problem!  You got us looking at it.

So wider question for anyone reading - do we actually want to keep
this driver?   Meh, to catch peoples attention better than in this
thread I'll propose a patch dropping it and see what responses we get.

Jonathan

>=20
> Stepan

