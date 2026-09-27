Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12379421221;
	Sun, 27 Sep 2026 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534934; cv=none; b=Ill9ELuFkJ2twoqkQPJEpmfKyP0v9nWyE46qwCCew06Zerb+EOK3pYZpcPhnEdiwq5XJKPGVeqwcrOIn2ylJzrjJQlSnGhX4TpjUWZ++JRpR+rKjjo9kvKH5Sozz2cLOMwQyRbeJuygQ5uZ5H+1zCwVAFkVX8CTfBeAjszUqY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534934; c=relaxed/simple;
	bh=wSJKKlH4f3dFd85YH8R1fHaQ0lnRdwCe30jznCU79xI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvpoWRjAcu5M1fTwa6P8yRWWBtaF5mj7lf6ZCaQuhNvfaHaN5KT3XA78Igms1eE1o8KFzZ1nQnTBDK2uWtMhqcnNRxN1MpCOmUf6XIk3znfGAyO9pYjeGsRdGG6s0CEBSHrMQh5uf7wSoCDVHXbS4+zRNui7dZoqN2KfIlgPc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R903sp2D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R903sp2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60B11F000FF;
	Sun, 27 Sep 2026 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790534932;
	bh=VBjGAd9X/zAnWgHj13H/8QzSsE5H8RY6xaFmtpBOQ14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R903sp2DwAooZXScU8nDNt2rZ6n5SKZwuomCde+rCXiNdSivYiQQSmUaBegEgKWM7
	 V/J9929eKN3iZUeLwJK5H5i930pifBHDkv1hcjc8CeQyioyFrMZIPQ91skE5pP1ftD
	 aJKAHo7rxqwuTMP3mmp2JCPlzvnHy4I5YfjIoT6eCsRVUJOVGShEC6AK1hNTML50aG
	 RytM6ZdvdvAnM3uP3krBA0MpwMp5TZlBpAF5QCvcs1qNkoF4VJn2615yQIg5I651Yw
	 kSn8oqipNfeI6Ru1WbzBfmMxq9qXgeFLXW73oboNRL+Q8V/6CbzPKu6H6IhADi92Qt
	 hiSgrNTwZPArg==
Date: Sun, 27 Sep 2026 19:48:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: Add dedicated CM32181 schema
Message-ID: <20260927194846.51b62d34@jic23-hlaptop>
In-Reply-To: <20260924090617.00007d47@gmail.com>
References: <20260923191616.2217203-1-robh@kernel.org>
	<20260924090617.00007d47@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 09:06:17 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 23 Sep 2026 14:16:15 -0500
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
> 
> > Add a dedicated Capella CM32181 ambient light sensor schema. The device
> > has optional vdd-supply and interrupt properties, so it no longer fits
> > in trivial-devices. Include both optional properties in the binding
> > example.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > v2:
> >  - use additionalProperties instead of unevaluatedProperties
> > ---  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
Applied to the testing branch of iio.git.

Thanks,

Jonathan

