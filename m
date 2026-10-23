Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789143;
	b=JFjRHghU0aSrulPtGDk5w1xx5WigaWUOK+i/kl07Fz+XJSoauSw0jZ/slvuT0OvHPNoJ
	 nNX25RkFFtL8OjcfaLadzF50rfaxm8Ep/gf71LMdi/C43RpRQvDpGjyMN8HgtEU3RGcg4
	 K8tfPw06VjIdZmUYuqKr6e3btBUYjpr6El7SDpMAONGcFny7sm4zQgnf9Ej3CwNnDp4gR
	 AREIkruO4x640CZg274vjjKKGtkOgUr4CueqxuhLc1UwUAXk9V8XmPUXicXdy8aW+CZsC
	 WZThNUxsrgYOu/6h5wK6B5h79M1q3lX3zGdgAYbua5C6lsS8qJa7s+IRKiGj35nOphA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789143;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NqkLuJBowrg5uO/LzxwlbNqWRXOx6BWUFV29tyybZko=;
	b=iF3BUkcCyfZ9hBogTyOWrexEqB9JMTIAe0pWsIGMKP364w+6QH3Bd1cv0vKWUsdK+3GI
	 T5/bq6mcZ+4K30uS4K0CcGUEVH8Sl2SuNMMabrCeW0A/4jwajYAj2ALWwFl/pJoHC68ZR
	 ZZgCx1DVV24iEEq7CAeHI1+PzXxTXCUqUZ7lKcl7MaMmcRJ3RrIywsAMz/s8hYZq6KC5W
	 wG7ia0dAcb4UJCIaHzLQCgfp+T9yh15qeahW3b5fE5tFbJKFV2OxobHBiF+ZA/PeuEIG/
	 bIS7MecS7hjomaoOyMqNkpM0wKmcu+R+M2UTitA+mhiNmP+zs20Ke7LeBVGhKle7fCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mitaLlNr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A212606A31B;
	Fri, 23 Oct 2026 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mitaLlNr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CC81F01825;
	Fri, 23 Oct 2026 20:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789143;
	bh=NqkLuJBowrg5uO/LzxwlbNqWRXOx6BWUFV29tyybZko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mitaLlNrKV/nfViGZGWPL8DopsgmEkL7ebk3WYav7/TSUHeFAq5AGZmnDc4tXWn7k
	 783/fAuBYjd7AWZWs2B4Vxu68y4f4h3OaGZ3RKjITdTVpsDxBR+Ac3MbEn5Tenjuod
	 MGhhuw88vCZ3OC2zuyibiLUOnZs7caWpkklT/0mIoge5Xs1Rgj4wRWeOP8GDbbYzln
	 Xd+crNHPF8jSjXa4uBJq8kkViuDDadMFCx0uky7s7N8rJZekG9+qxk7W+R4Udim95y
	 S/Ks1/mfiVe+axlXozUa33T03uy7ndZZLzMpiqStqGnJg8wkRjQ8spjH7dNyFYeinN
	 l/IOrFBtLrKdg==
Date: Fri, 23 Oct 2026 21:58:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Stefan Windfeldt-Prytz"
 <stefan.windfeldt-prytz@axis.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@axis.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] This series adds support for Texas Instruments
 OPT4041 Ambient light sensor
Message-ID: <20261023215858.623ef46b@jic23-hlaptop>
In-Reply-To: <20261023-opt4041-v2-0-ee320812804c@axis.com>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
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

On Fri, 23 Oct 2026 14:30:27 +0200
Jesper X Nilsson <jesper.x.nilsson@axis.com> wrote:

> Extend the opt4001 driver to support OPT4041, since it is so similar to
> OPT4001. The OPT4041 adds a second channel, a wide band channel ranging
> from 380nm to 1000nm. The register map is almost the same for both
> devices. OPT4001 has an internal fifo of size four, OPT4041 has two
> fifos of size two, one for each channel.
> 
> Since OPT4041 has two channels it has one bit in register 0Bh to select
> which channel is compared to the threshold register. The driver does not
> support setting the threshold registers, so no new support has been
> added for this.
> 
> The OPT4041 is pin compatible and has the same package as
> opt4001-sot-5x3. Although the device id is different, I added a new
> compatible string since the driver already had different compatible
> strings to differentiate between the two OPT4001.
> 
> Datasheet: https://www.ti.com/lit/gpn/opt4041
> Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>


Normally I'd say slow down to give more time for review, but seems
you got good reviews anyway and the code looks clean to me.

Ah well, sometimes you win - but generally wait a few days at lesat
between versions.

Applied to the testing branch of iio.git. I'll be rebasing that
on rc1 once available.

thanks,

Jonathan
