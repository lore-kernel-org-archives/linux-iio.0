Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B933262B;
	Tue, 18 Aug 2026 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018473; cv=none; b=CsTWWKZGzFI/e1ChU5wj4VPCtvnVA8bPGFQSn/IO+PJgj52AF/lEQTtdA/GXsc0lhE1yjbAK6GY7KlBYDxTMldvyNz/3o4UNxtX6fDjNDl1/0oboUe15d/8BhR6hIy6uyFA5pDDWsLZRkykBNzJ1uhgdzGAwPRUiqCvf5p2X6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018473; c=relaxed/simple;
	bh=O+3e8rmOPehZMs0EKl3SCK5CsjJ7+7A11taQY3shiFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy9N7Jg28ICPeypyi/LX0byBJF99bkqti/cBxlB2g3bt91w65xsU60NvutzbWfx42yC+IXEA6/A5awL5N5h13sWiSTG2tqWVMg9cmVWn7MrOwNnfbgWXJlsgVB5BfZDNVhvWBoOvLOMA1rnUvkQoBhYjgMPrfVo6LNlSvvouUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL5rZirL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL5rZirL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B783A1F000E9;
	Tue, 18 Aug 2026 02:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787018468;
	bh=u17WxwJqKdR72csOPdW6d6pAW4/Yjd4RKtw3iLLADWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CL5rZirLhjrdVK8eDdfSrgG6B058Wm8QBkvVm3U937RjI/Bhrmq8D9LyhsOoNqSOs
	 +XBvkjkijuN6YALrNeod9pO7B7WbJaOCz5hkvb3OTMtcPy9L63rfvnnZl/vw+lIgYs
	 IsQD+IHLeqmdtFn9bBXUJLBaFDdO+vTu16qBd2Y01j0hTX2DgsPwrI8SdmO61Tzwt9
	 7drT7KcuS0PF9ds46b2EZzlDX2Ig5YQM+1gSiykvr9QFZ3Fzjm3xs39qoliDEfeoIV
	 uWhdcNBq+jjiJOTK83srTDwvsx8CagYrZx9Gg/sq68rWB2IBMKoiDx3ZViQgyseypG
	 uQ6BkTnPvXN3A==
Date: Tue, 18 Aug 2026 03:01:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
Message-ID: <20260818030103.41e598fc@jic23-huawei>
In-Reply-To: <a6ea43ab-964a-4667-924f-50efb86dd73c@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
	<20260817021252.5ef32a57@jic23-huawei>
	<a6ea43ab-964a-4667-924f-50efb86dd73c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 08:51:46 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 17/08/2026 04:12, Jonathan Cameron wrote:
> > On Mon, 10 Aug 2026 10:53:07 +0300
> > Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
> >   
> >> From: Matti Vaittinen <mazziesaccount@gmail.com>
> >>
> >> The BM1390 tries to initialize the AVE_NUM to 110b at the start-up. The
> >> field location is not taken into account, and value is written unsifted.
> >> This causes the AVE_NUM to be initialized to zero.
> >>
> >> Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> >> ---
> >>   drivers/iio/pressure/rohm-bm1390.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> >> index d00d7ed54cb1..29454570f257 100644
> >> --- a/drivers/iio/pressure/rohm-bm1390.c
> >> +++ b/drivers/iio/pressure/rohm-bm1390.c
> >> @@ -479,6 +479,7 @@ static const struct iio_info bm1390_info = {
> >>   
> >>   static int bm1390_chip_init(struct bm1390_data *data)
> >>   {
> >> +	u8 regval;
> >>   	int ret;
> >>   
> >>   	ret = regmap_write_bits(data->regmap, BM1390_REG_POWER,
> >> @@ -512,8 +513,9 @@ static int bm1390_chip_init(struct bm1390_data *data)
> >>   	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
> >>   	 * be fixed when IIR is in use.
> >>   	 */
> >> +	regval = FIELD_PREP(BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
> >>   	ret = regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
> >> -				 BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
> >> +				 BM1390_MASK_AVE_NUM,  
> > 				 FIELD_PREP(BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM));
> > 
> > If respining I would drop the local variable and just go a bit long on the line.
> > I like the mask to be clearly visible in both parameters and a local variable
> > prevents that. Fine if the line is really long, but it's only about 83 chars here.  
> 
> I am not going to insist - but I will explain my view - which will sound 
> like insisting XD
> 
> For me it is always a tad harder to read code when function or macro 
> "calls" are done inside a parameter list. Hence I like a local variable 
> here. I do 100% agree with you that mask (and sometimes raw numbers) 
> should be visible in code - and not hidden into variables / defines. 
> Still, in this case, the mask is assigned to the variable right above 
> the line it gets used. So, I could argue the mask is still pretty 
> visible, and FIELD_PREP() is called on it's own line and not inside the 
> regmap_update_bits() parameter list - which is more readable for me.
> 
> Well, if you feel strongly about the variable - then I can ditch it. 83 
> chars is still okay(ish) - even on my "old eyes, big font and 3 
> terminals in parallel" -display setup ;)
I don't care enough to insist :)

J
> 
> Yours,
> 	-- Matti
> 

