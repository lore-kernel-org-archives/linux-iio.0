Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735670830;
	Thu,  2 Jul 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020659; cv=none; b=NvGJ26eXMuroP5aOZZJ8VwHKjOmIWrSg19Nh1tMUk4x1oUWOnIL7y8gExNLJmGYcYHPTzwA5OtSNNimVLZe/FXRIiZrK/eXgjHiiASjQ0J+0BDlXHUgF6/rYizeujzqJ0SG6IV0ZG1Q0GX1QG8HDSllWWItE+kWFM9PoCUg2H+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020659; c=relaxed/simple;
	bh=Dn6UWY3mSDJAHfVAcurT+ZUStGtKjhoccn6GkyrX27k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQzq4okbR3h/tFjg0NFpRJX+N8NuSlPHX3XWJGCUgFXDXrRE0Ay72fZo5WPnltocBdBWmvuC8RMAUOGGmkS5KZU/nhe6gU4NkGr7c0gnsrRqm/fG9NlzD60IaY2XWpG0FQKvuRCAoUH7UQV+jrZAYA5ghWx4VA7Yu77Qs0jhRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmSH7iJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmSH7iJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18F91F000E9;
	Thu,  2 Jul 2026 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783020658;
	bh=I0E6G0wI4aJTTRKSLJz49t69TW7I6ObwdGcPx9DdeTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dmSH7iJ1aQcHlqb+K0cs+rKU/0lpBdUZKhrNFMSV2qMeya1XigXENyEsafI+ZB3JE
	 NCyeTbhCMQtvZ6AbuFv7T4htOOK7ppxMZM6HJOdwtl+ktwicaQWXfs24Zd3rBCHnTr
	 wRNCV4u7+qze7fQT+TOZcMiYYOVXvS+/mFfgeLZe9I9/NE+vU30zlGTpJ2q/jQSIQy
	 8huhM8oTtGnDDBfQY2ZbNOE46khQ1uVY9xfn3HMNf0CdXOMnkWQBxDZAw2uYP3c8Uh
	 qjTqVLm/B4X4Y4T6P7fadQgIyzFabQ6FJLZEfGHSG/SkDrexqP0RnY0S361VEW+fR7
	 uTjdduKchzlWg==
Date: Thu, 2 Jul 2026 20:30:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: iio: adc: add
 input-channel-rotation property
Message-ID: <20260702203051.4d9d702d@jic23-huawei>
In-Reply-To: <20260702-litigator-commuting-5a3a37a7fb40@spud>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
	<20260625-iio-adc-ti-ads122c14-v2-4-ceb9b0b561cb@baylibre.com>
	<20260626-retinal-thrash-1095940e36ab@spud>
	<4a2c4c42-69fb-4491-ba77-b858623275ec@baylibre.com>
	<20260701204133.2b77edab@jic23-huawei>
	<20260702-litigator-commuting-5a3a37a7fb40@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 19:58:32 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jul 01, 2026 at 08:41:33PM +0100, Jonathan Cameron wrote:
> > On Fri, 26 Jun 2026 13:27:44 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> > > On 6/26/26 11:14 AM, Conor Dooley wrote:  
> > > > On Thu, Jun 25, 2026 at 04:55:06PM -0500, David Lechner (TI) wrote:    
> > > >> Add a generic input-channel-rotation property to adc.yaml. This is a
> > > >> feature seen frequently in ADCs that are designed to measure resistive
> > > >> loads, such as RTDs and strain gauges. Enabling this can reduce offset
> > > >> errors by swapping the positive and negative input channels on every
> > > >> other conversion. This can have side-effects in timing and filter
> > > >> response, so it is not always desirable to enable this feature in some
> > > >> applications. Therefore, it is best to make this a property that can be
> > > >> enabled or disabled in the device tree.
> > > >>
> > > >> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> > > >> ---
> > > >> v2 changes:
> > > >> * New patch.
> > > >> ---
> > > >>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 7 +++++++
> > > >>  1 file changed, 7 insertions(+)
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > > >> index 9ec1f447b565..3d52c00922c9 100644
> > > >> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > > >> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > > >> @@ -81,6 +81,13 @@ properties:
> > > >>        ADCs usually allow choosing between internal reference sources or a pair
> > > >>        of external pins.
> > > >>  
> > > >> +  input-channel-rotation:    
> > > 
> > > I got some internal feedback after I sent this patch that "chopping" is the
> > > more common terminology for this feature industry-wide, so in the next revision
> > > I plan to change it into `input-chopping`.
> > >   
> > > >> +    type: boolean
> > > >> +    description:
> > > >> +      If set, the positive and negative input channels are allowed to be swapped
> > > >> +      on every other conversion to reduce offset errors. This is also referred
> > > >> +      to as "chop" in some datasheets.    
> > > > 
> > > > "allowed to be swapped" means that this property says the feature can be
> > > > used, but userspace may have to be the thing that ultimately turns it
> > > > on?    
> > > 
> > > No, I don't expect a userspace control for it. More like the driver should
> > > enable it when possible, but a driver doesn't necessarily have to implement
> > > it and everything will still work, just with less accuracy.  
> > 
> > Perhaps we need something in this text to say when it should not be set
> > in dt?  
> 
> I think I would like a wording change from "allowed", to something that
> is akin to "If set, the hardware supports swapping...". Allows sounds
> too much like something that should be a userspace control.

I'd be inclined to talk a little more specifically.  What hardware?
It's the not the ADC that matters for this control, but rather whatever
is wired up to it. Otherwise agreed.  Maybe "If set, the connected
circuits are suitable for supporting ..." or something along those lines.

Thanks,

Jonathan


