Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499457;
	b=uYZJxfnMz2bJLBovk27Kznew8Q8+DsauxCBvjFmh7W3Jip9BtKPqRCt+ZV85K/InyxU9
	 CFz1UAPBTlbUcLli17aEO3+O5sJAmpfN7eT2XUpFeTJPYJd8bhAOYOXt5IofSCCLPCUin
	 5xss0FsG4FgMsxstArGPLsUH/Rg5XS7Ybr9ii2gaXcQmZ/FA0a8m4reLjD9Bze1HtPxGv
	 +PO7blDF6DFZzTRht2+KQQQgJrddK7lEfEFyvSsi5NxMzPlx3xxbBPxQuMgJRRy2y0tIn
	 19pwVv+nrVQItMQL7g7LIexHF9SfNtxpT05obKJF38n7YydZQbbx0Z+cqJ+3qAFS/KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499457;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oCK7+EplOOE0q7E+MSnK/Zua0vggVQNuH49ckfjiKEQ=;
	b=ERyrlkyqrVWahT77eUzcvqAnlVxoMEVJJzAUchNfWwUde/6qpZFN54+sOgEqh1chELne
	 VhAV1CO/btVlU9aWL0HoBKYFQGv4o3Jc6846ov8CK3vGPgqTjeNvSMpmbKILsppjpIL1A
	 +6qqZnpNFXESjtjiqjIAcvh4vmEJ3mrVLOVZz+RRRBL4LQrQUBJfhOA4y+WqudPP0W76e
	 YweKH3AhkAlHXXz+xhLRHwysYYQlNWWPzs7r9z3/vIYXfjt2uVpqTVi/V4KIQhkhQKpxu
	 w6uJQNY7YUGvPXGFIi+PBWCeEjgaCvJAYVQCVSycHl0ciK5vFD5WISlSPLuwSNdh89A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH7JvcV+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18B606A324;
	Sun,  1 Nov 2026 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH7JvcV+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416551F000C1;
	Sun,  1 Nov 2026 02:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499457;
	bh=oCK7+EplOOE0q7E+MSnK/Zua0vggVQNuH49ckfjiKEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BH7JvcV+u80IQbXCdD43J5xQOXOh4t3dYIEsVu+pKlUzs0hVagoPj8UCL6YdZ3gEV
	 fJlwGqL86GDuIIIFhV1GXoycn5+FDjVoLCzTZvk+9ovz/t22zfP3BBtT2YC+SJ31tN
	 i7iXDl1MMnNWScec0SrBD/pZqs47zXFmCKwqwj4rsDsc9g/h2JJlAu6vIrZLbdN9gN
	 Bi9MIGFbSnhtDBBv4VhqCtNw/i1GYxJhsdURqnyieE8EFjck7E7B/hpDJdVXiXo1AD
	 sQikdqGS8ymaaJGGsRdm97ixevq9aDOvJ2Ztk9ThhxBTfapPyrZSwipzCuV5epQERZ
	 es82FlrG/LBaA==
Date: Sun, 1 Nov 2026 02:17:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Sanjay Chitroda <sanjayembeddedse@gmail.com>,
 Shi Hao <i.shihao.999@gmail.com>, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 11/15] iio: hid-sensors: fix a division by zero
Message-ID: <20261101021729.4a0df058@jic23-hlaptop>
In-Reply-To: <20261027-llm-char-misc-iio-v1-11-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-11-0d818334f6c7@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 17:19:15 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> convert_to_vtf_format() divides the micro part of a value by
> 10^(6 + exp).  The unit exponent of a HID field is a nibble and goes
> down to -8.  For -7 and -8 the argument of int_pow() is negative, which
> the unsigned parameter turns into a huge power of ten: 0 modulo 2^64.
> The division by it is a divide error.  The exponent comes from the report
> descriptor of the sensor hub, the value from a write to the hysteresis
> attribute of the IIO device.
>=20
> Multiply by 10^(-exp - 6) in these two cases.
>=20
> Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and trigger")
> Cc: stable <stable@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> Cc: Shi Hao <i.shihao.999@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+CC Jiri, and Srinivas given they are co-maintainers of this driver.


> ---
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/dri=
vers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 9e7c26e37880..3b0985d500ae 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -140,7 +140,10 @@ static u32 convert_to_vtf_format(int size, int exp, =
int val1, int val2)
>  	if (val1 < 0 || val2 < 0)
>  		sign =3D -1;
>  	exp =3D hid_sensor_convert_exponent(exp);
> -	if (exp < 0) {
> +	if (exp < -6) {
> +		value =3D abs(val1) * int_pow(10, -exp);
> +		value +=3D abs(val2) * int_pow(10, -exp - 6);
> +	} else if (exp < 0) {
>  		divisor =3D int_pow(10, 6 + exp);
>  		value =3D abs(val1) * int_pow(10, -exp);
>  		value +=3D abs(val2) / divisor;
>=20

