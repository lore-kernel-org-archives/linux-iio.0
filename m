Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520402E1EFC;
	Fri, 24 Jul 2026 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854565; cv=none; b=kthaJa6W+1+ACuwMn+hZ45sWgimpYfoxtaEX6QVdKuD46WsGT4L2dNXoxjjDzWcZn7H35OsaI+S10iaqWzl5RynJCYzxRFW9pB3jEohBwtFy55NZQ0bAdM95RTiFNIX6MNcej5G/IM3maSqqAKfY24b7VwyW0ZW7prvjkrjwY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854565; c=relaxed/simple;
	bh=dsFKrnTq6s54n+XL7pbonQWJ12sx9dfUfWTemEIcwEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxrNtQfvwKm33VYzIIstamLQkZY9wNQwI0/uowur3twuFgLZzr8mPaOS1Muzw3YIjihzCLyhpv9X5VaUk+tQll1Vbrc6ScikCDtsSy9cIKEsPNaE6bsZbPTMpL+K8gl4Jd0oxFkVrVhdly6Zq6/xcskRarKn+bn3gfQvXXfrSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brcMULhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brcMULhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164C21F000E9;
	Fri, 24 Jul 2026 00:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784854563;
	bh=h6qruIUyjnf6ugFoXrXkRcoc+H2KNtme6mMp+9VeAh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=brcMULhxlh/Atkwq5Ofcv5grR6A9+jlGereu68gwYTb0vd2Ccw3tZSw37phoT2cyv
	 ONFCZR1nove9I6gPgeEBKLMWhaM7Q1Um4dFyW4ysc9T8rmiIDUkdSp2q3qznpZBGkw
	 1kOKFaRT9DSEphliqwd8LrPPNfMkPH0Z9CBmJggMQNASegp+ffjnu58AatFnUEKG7O
	 KOxTHz87u8eamh/7IQutZQaBPkegLHg17k16VyRr7u9pLuPmyayRxmx2nQ5Kgaw5jY
	 5NWCJQ0+PXD6XUYARRvcYlnymi+BaP6ZafBGdp9HrGYb8IQfSCvbMNiN9ftcPA4VhX
	 qd+Nh16OShwrA==
Date: Fri, 24 Jul 2026 01:55:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Siratul Islam <siratul.islam@linux.dev>, devicetree@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, Song Qiang
 <songqiang1304521@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] iio: update email for Siratul Islam
Message-ID: <20260724015558.577d807a@jic23-huawei>
In-Reply-To: <178472604213.223954.6496981771222842971.robh@kernel.org>
References: <20260721150314.24545-1-siratul.islam@linux.dev>
	<178472604213.223954.6496981771222842971.robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 08:14:03 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Tue, 21 Jul 2026 21:03:08 +0600, Siratul Islam wrote:
> > Change personal email to the Linux specific one,
> > to have a single and focused point of interaction.
> > 
> > Signed-off-by: Siratul Islam <siratul.islam@linux.dev>
> > ---
> >  .mailmap                                                      | 1 +
> >  .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml         | 2 +-
> >  MAINTAINERS                                                   | 2 +-
> >  drivers/iio/proximity/vl53l1x-i2c.c                           | 4 ++--
> >  4 files changed, 5 insertions(+), 4 deletions(-)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 


Applied to the testing branch of iio.git

Thanks

J
