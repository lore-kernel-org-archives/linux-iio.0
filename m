Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25F367B91;
	Tue, 19 May 2026 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216599; cv=none; b=YCwA0adS6VG5phN8IPeD2Z8fdtqWRuHsSzmiXO82cmzj+lEaUjDydV3rShsxWuvG6SeM8L0J3NSPC+PVWxvUTl3kf/R6FhQVLrOAGhgxgorlwSl1hU3z1q7WdRpkae3MH/1N6rJOJcwZCC+DtAdsaKMWfuGxSvnt9osTWg6xqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216599; c=relaxed/simple;
	bh=huzo+LLe7IsqAClW39j9F6vDk3dYASBmyv7Jck1Ks5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7i8HbBfEdzG33ALBMJi3mkCxaQNxdXzTCUXeBCTQZHGAsb1vc1gcpKWazkJ7OVSAPr2NN0dc0dufMDV3dp12c7Oq9IxmzPzRjTzP8C/GWI4JVPJ5n+EVZ7tsNT6ej//J11RwKKGgmm1kcV21R/yLn8rf5rq3kbjJ6r9bA/pjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMNOmGqE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMNOmGqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E14C2BCB3;
	Tue, 19 May 2026 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779216599;
	bh=huzo+LLe7IsqAClW39j9F6vDk3dYASBmyv7Jck1Ks5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMNOmGqEwa8BfO+Kx3SOgFdo5N/uyRVCswVyDcmWgZuatoMhBMSff2bPnDpzD+mYF
	 9mDAmGohFW7/MRx++uAyocaSVBe9pIaQ5aVG+BPzCGRurNjr27+Ej2bFTTFMx2jH4v
	 YaXlJ4y/WB8jl8mePVDzcHgeVVVY1MM5wD9umXQceQzka2NhBlo4nzN7AZTYGpB853
	 YdcU0gJtIq3xwW3c4WhQdf1ggGwxH2as7EjcZYyjvIBcASYdGzqceuxTcnSQkGNtCR
	 uDmt9iUlLjBTcv1yTeq5wRzfISfndnYQ5Ip0a9498o9269UflZKBjhNsdNPRI8DEZv
	 BRv4rIcIq74qw==
Date: Tue, 19 May 2026 19:49:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iio: adc: ad7091r5: Simplify driver_data
 handling
Message-ID: <20260519194954.618efb0a@jic23-huawei>
In-Reply-To: <2464690a0a70aa65880c5c61602b52fc9ed9d69d.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
	<2464690a0a70aa65880c5c61602b52fc9ed9d69d.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 10:13:05 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> The driver only supports a single device type. So the return value of
> i2c_get_match_data() is already known and can just be hardcoded without
> type casting. While at it also remove the unused .data of the
> single of_device_id entry.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied.
