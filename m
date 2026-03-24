Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F33DA5BB;
	Tue, 24 Mar 2026 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343228; cv=none; b=suKTfeDbk3wWGpe8qxL8C91RRtUBqSJd5spxugEnSnbc+zZahMEcz1WrGU3kOIY+XvMn7J4C0HCxOLGBpKZbr/ft+HdLDD1APSQVkwYn9zN5c9lUSakJr0Bo0HiygLn4QzkWNZ3dO+wauQ7FNbFdokaK+3FmskzQqX4qhfNtYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343228; c=relaxed/simple;
	bh=ipl++/qAmGUU8wsdRN7gsKCaqWSN3ktvNdzN9/XyDGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeOS8hDdwm4+xgFTHJn/dvbRvi3lVXfVRpMZME6gFf4mvbykVVdwNAGgXvGmPGn8rzJ6YD/FhEcyMT04ehWS/dZLBNoUna00oT9SEpr8+zohFnrrpOcPCtBxYHihxvYUwEDwX6scDAiLskooG5ebMbNg/qc+iDuGTNZdG4c7pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QISBbcTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QISBbcTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A690DC19424;
	Tue, 24 Mar 2026 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774343228;
	bh=ipl++/qAmGUU8wsdRN7gsKCaqWSN3ktvNdzN9/XyDGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QISBbcTWH1BjuTXj5tdCebK+STCgtUuleFKaXSW4FFWEJ6gfDdgmiq9AatHiZRsIf
	 k6ZH9Dch1wRCTUDmjT85C07fUhpMdA1Kjarpmrsq6MpZtmhut7J5ONlQ9iqc6f1/ft
	 oV9cHiq1agKy2CzVyhw6H7b1byxLCgN+Vywf2slwkg2pm9SVABgOmuSa8RV9gOm0/G
	 LCGNceGgQ36wgwy+e4qLcsEkpYHA0y8WFVZlpBpEIWXgwPPF9aGmD51bHvZdzTd9zX
	 PBvWgMeTuMf2IpMtFyrCLbtKvTuVsPqQF2D9ArCe2ZWLwRvOTyrc7oH5a0+m9F2DZV
	 KqA3bT75B5d3w==
Date: Tue, 24 Mar 2026 09:06:57 +0000
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
Message-ID: <20260324090657.211d5046@jic23-huawei>
In-Reply-To: <171e30f3-e294-40fb-8731-476fb51d5a3c@kernel.org>
References: <20260323013408.429701-1-nick@khadas.com>
	<20260323013408.429701-3-nick@khadas.com>
	<20260323-quizzical-striped-husky-68e24e@quoll>
	<20260323200501.6c116226@jic23-huawei>
	<171e30f3-e294-40fb-8731-476fb51d5a3c@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 08:07:15 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 23/03/2026 21:05, Jonathan Cameron wrote:
> > On Mon, 23 Mar 2026 08:54:21 +0100
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> >> On Mon, Mar 23, 2026 at 09:34:06AM +0800, Nick Xie wrote:  
> >>> Add support for the SARADC found on the Amlogic Meson S4 SoC.
> >>> According to the documentation and current testing, it is fully
> >>> compatible with the G12A parameter set, so we reuse
> >>> `meson_sar_adc_g12a_data` for this new compatible string.
> >>>
> >>> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >>> Signed-off-by: Nick Xie <nick@khadas.com>
> >>> ---
> >>>  drivers/iio/adc/meson_saradc.c | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> >>> index 47cd350498a0d..3ac48b7842c4f 100644
> >>> --- a/drivers/iio/adc/meson_saradc.c
> >>> +++ b/drivers/iio/adc/meson_saradc.c
> >>> @@ -1313,6 +1313,11 @@ static const struct meson_sar_adc_data meson_sar_adc_g12a_data = {
> >>>  	.name = "meson-g12a-saradc",
> >>>  };
> >>>  
> >>> +static const struct meson_sar_adc_data meson_sar_adc_s4_data = {
> >>> +	.param = &meson_sar_adc_g12a_param,
> >>> +	.name = "meson-s4-saradc",
> >>> +};
> >>> +
> >>>  static const struct of_device_id meson_sar_adc_of_match[] = {
> >>>  	{
> >>>  		.compatible = "amlogic,meson8-saradc",
> >>> @@ -1341,6 +1346,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
> >>>  	}, {
> >>>  		.compatible = "amlogic,meson-g12a-saradc",
> >>>  		.data = &meson_sar_adc_g12a_data,
> >>> +	}, {
> >>> +		.compatible = "amlogic,meson-s4-saradc",    
> >>
> >> The point of compatible devices is to not add such entries. Drop.  
> > It's used for naming in the userspace ABI which is supposed to reflect the part number.  
> 
> Indeed, I saw this pattern in more places. Does userspace need it? There
> is no "compatible" entry shown?

Yes. Userspace uses this (+ a label) to identify which of multiple devices
it is talking to.  Given some of these parts are very specific rather than
covering a general purpose, people tend to be looking at datasheets if there
are multiple parts and they want to know which is which.  Knowing whether
it's compatible with something else doesn't help with that identification
part.  

> 
> If there is no, then probably this could be automated by taking the name
> from compatible after ',', but that would be out of scope for this set,
> so here it is fine.

For DT that works but not for other firmware types.  We had a bunch of bugs
where people ended up putting out ACPI IDs (some of which we've had to leave
in place to avoid regressions).  Hence I've always been nervous about not
encoding the string explicitly in the driver.  Obviously this is a bit
paranoid for DT where it's reasonably tightly defined.

Jonathan

> 
> 
> Best regards,
> Krzysztof

