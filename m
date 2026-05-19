Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389362DA756;
	Tue, 19 May 2026 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217733; cv=none; b=OWstXFovPW86w6/VyxD4ws01UURtKbpq5TL3bz3ztFjd7fTlzg5t7TTW7vC8EfVhHVraMJvy+gVdDDlOAzNOrdSlSNjxva94WmNERuUU3LLAShfT0k7J0fh29YL4UdP4BMOKgoRs9I0X/JjV1nNpmbwX50juxfmtG5+ddv/G0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217733; c=relaxed/simple;
	bh=j6aQRnyvUdTVo7YWQtupvauqOkZXwgkS4SNHGJ3ojIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqxHWwY1cnLy2WLFsCpuJ6M+cD6BrnH6Wqk7E2opwjiHZ6K5OLKetGXiiXTpvAaIdbPouWLzgXOxqoFOznk8/iMoZ7Vhj1szeterkJ5yQ4aqXIa/EG601c1npPg5AN0tnDwdeOEFn2GxaWcHqG0CZRz1+A4XtMymdqy8STlU+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nspTuznY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nspTuznY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643561F000E9;
	Tue, 19 May 2026 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217731;
	bh=j6aQRnyvUdTVo7YWQtupvauqOkZXwgkS4SNHGJ3ojIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nspTuznYyh8NaXFrIKXbxRnI2THNJK1BWqwy6UghfoWRnP2RK+1A0XXuzaT3HZ3ah
	 5bZeM1PxvHrFIzn6obwDlVQddhxoiE5EIMVt87EelWfdNn3rIHqlxjGTd0H8n4AIqL
	 PGJ++IQmB21EEX2vzioN91OJgNNMgo0DVv91S/LWOvnYVj5485hVY0oOGrV3twlKBg
	 bbHQkq+6dG/dGI8Ze6wFfTKWmrnE8dzEgTtlJy5HViTLC/XT/DbNv6h3RbxngQABRp
	 dyblwVYE9/3dAVy+TC0YXRw6zBX/OMU1O5oSuLY9A/K3fr3pEyXywqxFVWeGuYyr5c
	 RwmS2uqcQaC2g==
Date: Tue, 19 May 2026 20:08:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Shi Hao
 <i.shihao.999@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: proximity: sx9324: Drop unused driver data
Message-ID: <20260519200847.5f230746@jic23-huawei>
In-Reply-To: <b5093a1ad184c758855e737926553e34bf21ad59.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
	<b5093a1ad184c758855e737926553e34bf21ad59.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 10:13:07 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> The value assigned in the three device_id entries (ACPI, of and i2c) are
> unused, directly in the driver and also the sx_common support lib. Drop
> them and while touching these arrays, convert to named initializers.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied.
