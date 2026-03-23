Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67636BCC4;
	Mon, 23 Mar 2026 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296313; cv=none; b=GLKm5RNg9cCv013QttC0sxMrFS9rZJp6GoIfRsbUb3dWHCw/QLZk+TSe4BpZLQavm2h4SBNdnyZRAfccf4QlanIrb/VWiOpXGwOLo4AXwnTYxJdq53bP1ZinZ+pYPpAUXNiBzY9e86xR7+P3EnA2a/bhF5JLRYj0dWIi66O1GXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296313; c=relaxed/simple;
	bh=UZ9ChSt7XSFj5XUt7xiPIRnO4bztL5/cVzJffKBGDwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYVJCSN7Eyz+PwKTG3+GbqA6DbY9owlUo2em6ljJp3hmJaZB7oYuHaywl50Yqf2nRMXDTn0gmdO480DslsUiZO9X1XgPPKaWi6SnqHmyFaqTRR6ZU3m0xIawmDnW8E6KdSjLNxh7iDFiyo1eYUoKnpRXgkSCosN3KhPHK86suwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0ZNdUlT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0ZNdUlT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FC2C4CEF7;
	Mon, 23 Mar 2026 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774296313;
	bh=UZ9ChSt7XSFj5XUt7xiPIRnO4bztL5/cVzJffKBGDwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c0ZNdUlTt1+GePDysp0DSARn/iM2OTvuKxvIdQGh9IDA4QS2WQzHYU37aoaFaR6ac
	 BVAYp0koYuwLVZ0jULgRwbaxC2sbvY6e3SiY9HLLpFxgYNhpdWdbHpK9CC1w6AkvJ0
	 K/Dy6MMAzSo0Taqmqxwnz6zQzrgxMuKu28gA1BoJTpL/BdVq/R5utrLgFO58qsx8T0
	 PLAy8ItkRiyc3gjlnEcTheeYEtYlvlOiWNX0HPiHtfd/mClH+2aGiyuL6rllIM8BD4
	 KdNexGiGIanUM3yrGGllm4FAusSstNJDJpjt290u32hsbsjN6osd/3wq8JqnuLOMk6
	 vfHAnc28BW3ow==
Date: Mon, 23 Mar 2026 20:05:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nick Xie <nick@khadas.com>, neil.armstrong@linaro.org,
 khilman@baylibre.com, martin.blumenstingl@googlemail.com,
 jbrunet@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: adc: meson-saradc: add support for Meson S4
Message-ID: <20260323200501.6c116226@jic23-huawei>
In-Reply-To: <20260323-quizzical-striped-husky-68e24e@quoll>
References: <20260323013408.429701-1-nick@khadas.com>
	<20260323013408.429701-3-nick@khadas.com>
	<20260323-quizzical-striped-husky-68e24e@quoll>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 08:54:21 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Mon, Mar 23, 2026 at 09:34:06AM +0800, Nick Xie wrote:
> > Add support for the SARADC found on the Amlogic Meson S4 SoC.
> > According to the documentation and current testing, it is fully
> > compatible with the G12A parameter set, so we reuse
> > `meson_sar_adc_g12a_data` for this new compatible string.
> > 
> > Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Signed-off-by: Nick Xie <nick@khadas.com>
> > ---
> >  drivers/iio/adc/meson_saradc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> > index 47cd350498a0d..3ac48b7842c4f 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -1313,6 +1313,11 @@ static const struct meson_sar_adc_data meson_sar_adc_g12a_data = {
> >  	.name = "meson-g12a-saradc",
> >  };
> >  
> > +static const struct meson_sar_adc_data meson_sar_adc_s4_data = {
> > +	.param = &meson_sar_adc_g12a_param,
> > +	.name = "meson-s4-saradc",
> > +};
> > +
> >  static const struct of_device_id meson_sar_adc_of_match[] = {
> >  	{
> >  		.compatible = "amlogic,meson8-saradc",
> > @@ -1341,6 +1346,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
> >  	}, {
> >  		.compatible = "amlogic,meson-g12a-saradc",
> >  		.data = &meson_sar_adc_g12a_data,
> > +	}, {
> > +		.compatible = "amlogic,meson-s4-saradc",  
> 
> The point of compatible devices is to not add such entries. Drop.
It's used for naming in the userspace ABI which is supposed to reflect the part number.
I don't hugely mind the names reported showing the compatible part.

Jonathan

> 
> Best regards,
> Krzysztof
> 

