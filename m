Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7D19CC0C
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160824; cv=none; b=lVJgbOG1VtMcdKgq+PRDHoNWoKqJh+jkAY1OUpskSkKqT1sglDJw1ZKy34FmSMQJGLTJd+mygcImX8OD11+yYnFqCJyGbb19pWfPdctORKx4HTzUoCygunVeHVG2HQVrfGy5A38xmYnFaJyHZ4k0MWST4cCB533WR8+cTGYQWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160824; c=relaxed/simple;
	bh=35i0h8c7Jiad5xGsHBJyqb2gG5DbCy2CFgaGwgMnvho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkF/Iko7EfqW0ZWkqR7K+LgG6xm5CkbOcVOBA0rzehlEt12ulmNqS1TzEkPlhBpyLCFnHGtw6MowGP4U7RPoCg9UCmQtmSzWp5qVqrPqW7jgGdfd/bPYQmeCZJt2KvUdenNa3pu5ieSaQW3RV6BVhNraZiffY8jDIRsorBXmPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/KtbnFe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/KtbnFe"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso1460045f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785160820; x=1785765620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fWwbMjSZz9WnJ1CjrPuhixo0ML/od46qhmZPvL+D6Jw=;
        b=J/KtbnFeS+m8RbOlLxxI3NHNHE+MXVJzMf9hPhPkL6NfliJHizJd8H25cVRwongFmg
         4f79KcrJmvEcvsmMr95Hdkl6HnFhedunUgvOejzguVJs2Ot4RIl+tDOOOr1NVSfYbSrI
         FxmM0CmzNBDOc2u2u4805iQQO/Bw9CBTBux7OtRmz3lj/zKgPt8OQ62jaV/KT6+IAeGG
         8MURW8ElwNGffhv7s9J8W1DrWQH2sP3Tk+7I/D2xShalImWrYNtnM8IKFNMhik2gkXmd
         wTBnXUSht3sNjcGOsaW1MD39nZPWjtAFNiaJ5fRXwm8A21ssk2Uy/R5Axb78ciowRiAb
         Ka4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160820; x=1785765620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fWwbMjSZz9WnJ1CjrPuhixo0ML/od46qhmZPvL+D6Jw=;
        b=Ms1OL8uiibFgSBsyWxD/xjwVFHjtKu7YvSq7ahL3W2Fp/AqMvXFBWHyP+ivLWQg+XO
         jii7TmgcJdUIB6TwrHoOEhpZziyQRICyWH8c9h6fjG3scyVh7C74M0bNit/ntLVW5rRv
         k3IAwhOKEmWNr5ooPjALwvgZiN+ENbO5AVhAoFkSQLToDyuiizVWQJ68yS1mRdxkUs70
         saGlySaT2guC0BxZLq0gVznAG2zHHhb4GWYUgp/hfcIh83NtGzPwN4GWqTispBrHVIWe
         zbWQh1o59xS8PclPGaGgHRDhvqmYfFiesYYXj+bTO1aq41EZDDulfr00HMmcXLi1UWpj
         IE3g==
X-Forwarded-Encrypted: i=1; AHgh+RrZNOhatsAzXRSCAdXzVCWBBM/jYc7973SfuTdND35W9u6nxKjUsTWhNFxvGkC8QcLjXcqf2tha378=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3w2Zg4kKXYgQtnnXuBr6hXxjvbuXHFu2p9/KRrBqCd8aqafP5
	8Hk28NIfwVxub284DivFp1Y6ST+D7nw2jzqM6X32OKqzwGQx0bOWOSWB+eoJlA==
X-Gm-Gg: AR+sD10KK/LntJ+8zBDyS2O+VliEIDXxo4BkbTzca7QJwtVAgzYFdWdnnF89qD6pgU9
	Y677qkQkieBtL4gpEMIXWwLc4TvDm49bPLyzgUAJMGKJi8s4+S31GkwHaeb6XYzoPMF3Jk+w7TR
	nDZ+AK6EiysDTMR58rw4le0lCrkDiKYal9PxrOrEs47Lvq4o8XCVxFkN7z+S4mILFQkjZHsGeoN
	87d2wKcs6+vIBNPU4ElTIuuY2ox8IgQy7jbQQZFnX353rWghjHglG8o7xA9xLb4YZY+lKPYF6Qb
	zLDebBxiH+LoN+tMDQLhgw6xtbHHiHe3RPDYKWBFuqIBe/TMvUgVtsdKPMTeNDhHuarv80/D2A5
	8Oka4cwnTtLFJGiZn1bA8rua8t1gf55J5wHV7+1oIO1dM7i3RGwTs5EpBoscoXGZGKwsR2mOMiJ
	17WEOx
X-Received: by 2002:a05:6000:2905:b0:47f:93fc:2d20 with SMTP id ffacd0b85a97d-47fae7a741amr1079389f8f.40.1785160819907;
        Mon, 27 Jul 2026 07:00:19 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5c4sm49375208f8f.8.2026.07.27.07.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:00:19 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:01:28 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <jananisunil.dev@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, Janani Sunil <janani.sunil@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: Add AD7768
Message-ID: <amdko3OV-7FXftRJ@nsa>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
 <20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
 <36df7c4f-82ea-4ed5-a4f9-3a29c75dc99a@baylibre.com>
 <9dd16bb5-7a30-4024-88a7-4a4bf47c35e8@gmail.com>
 <e791f4f9-63dd-40f5-aec4-5b540bcee5ff@baylibre.com>
 <d159cae0-b11e-49e9-a546-023ed61b900e@gmail.com>
 <20260722025853.6ca3961d@jic23-huawei>
 <amHLZK46lxqSZIC8@nsa>
 <20260723234855.10f6cc9e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260723234855.10f6cc9e@jic23-huawei>

On Thu, Jul 23, 2026 at 11:48:55PM +0100, Jonathan Cameron wrote:
> On Thu, 23 Jul 2026 09:15:08 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Wed, Jul 22, 2026 at 02:58:53AM +0100, Jonathan Cameron wrote:
> > > On Tue, 21 Jul 2026 10:03:26 +0200
> > > Janani Sunil <jananisunil.dev@gmail.com> wrote:
> > >   
> > > > On 7/21/26 03:39, David Lechner wrote:  
> > > > > On 7/20/26 9:00 AM, Janani Sunil wrote:    
> > > > >> On 7/9/26 17:43, David Lechner wrote:    
> > > > >>> On 7/9/26 3:50 AM, Janani Sunil wrote:    
> > > > >>>> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8
> > > > >>>> channel) simultaneous sampling ADC
> > > > >>>>
> > > > >>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > >>>> ---
> > > > >>>>   
> > > > >>>> +
> > > > >>>> +  adi,power-mode:
> > > > >>>> +    $ref: /schemas/types.yaml#/definitions/string
> > > > >>>> +    enum:
> > > > >>>> +      - low
> > > > >>>> +      - median
> > > > >>>> +      - fast
> > > > >>>> +    description:
> > > > >>>> +      Power mode selection.    
> > > > >>> Unless there are pins that control this, it seems like it should
> > > > >>> be left up to the driver to decide how to set this.
> > > > >>>
> > > > >>> In this case, it looks like the power mode also influences sample
> > > > >>> rate which is normally something controlled at runtime.    
> > > > > Looking at this again, there is also an MCLK divider that influences
> > > > > sample rate, so sampling_frequency to power mode is not
> > > > > straight-forward anyway.
> > > > >    
> > > > >> Hi David,
> > > > >>
> > > > >> The reason we'd like to retain power mode control is that certain
> > > > >> ODRs are supported across all three power modes (low/median/fast),
> > > > >> and the RMS noise and power consumption differ significantly
> > > > >> between them at the same ODR.
> > > > >>
> > > > >> The higher the power mode, the better the noise performance, but
> > > > >> power consumption nearly doubles for every ~3 dB improvement in
> > > > >> dynamic range. Silently selecting one power mode in the driver
> > > > >> would remove a meaningful hardware tradeoff from the user.
> > > > >>
> > > > >> We'd like to propose the following instead:
> > > > >> - Remove adi,power-mode from the DT as suggested.
> > > > >> - Expose power mode as a per-device sysfs attribute.
> > > > >> - in_voltage<N>_sampling_frequency_available dynamically reflects
> > > > >> only the ODRs valid for the currently selected power mode.
> > > > >>
> > > > >> This keeps the DT clean while still giving the user explicit
> > > > >> control over the noise versus power trade off. Would this approach
> > > > >> be acceptable?
> > > > >>
> > > > >> Thanks,
> > > > >> Jan
> > > > >>
> > > > >>    
> > > > > Jonathan usually pushes back against userspace power controls. We
> > > > > do have this for accelerometers, but not ADCs currently.
> > > > >
> > > > > If we can't think of anything better, maybe we could use this. It
> > > > > only has low_noise and low_power options though, so the driver
> > > > > would still need to chose the best power mode of the 3 based on the
> > > > > other requested parameters. E.g. always make all sampling_frequency
> > > > > available  and just pick the highest power or lowest power mode
> > > > > that can provide that rate based on the power_mode attribute.
> > > > >
> > > > > I wanted to suggest maybe adding some kind of noise attribute
> > > > > instead, but I'm not sure how we could do that in a way using SI
> > > > > units since the value would depend on so many things (at least
> > > > > V_REF voltage, filter type, temperature and even the physical
> > > > > input).    
> > > > 
> > > > We considered the low_power/balanced/low_noise approach, but the
> > > > customers typically use the datasheet alongside the driver and the
> > > > datasheet explicitly uses the terms "low power", "median" and "fast"
> > > > for the three modes. Abstracting them with different names in the
> > > > sysfs attribute would create a confusion- the users would have to
> > > > mentally translate between the two naming conventions. The noise
> > > > attribute would not actually configure anything on a register level-
> > > > it would purely be informational. Furthermore, noise performance is
> > > > not solely determined by the power mode. There are other parameters
> > > > (eg. filter mode) that has a significant impact. A power_mode
> > > > attribute directly configures the hardware register and has a
> > > > deterministic effect on the device.
> > > > 
> > > > Jonathan, could we keep the power_mode as an attribute in this case?  
> > > 
> > > My really strong resistance to 'mode' type controls is they are
> > > meaningless to general purpose software.  It has no idea how to
> > > set them correctly. The purpose of IIO is to provide general abstractions
> > > and power modes are never that.
> > >   
> > 
> > Unfortunately lot's of apps engineers for these parts just like to
> > control it all and don't care about generic interfaces (given typically
> > these the devices are the only ones they care). So we also have some pain
> > trying to explain all of the advantages :).
> 
> Good thing they have to play by our rules if they want to have it
> upstream and not ship the driver to very possible customer ;)
> 
> > 
> > > Hence we put a lot of effort into mapping them to controls or measures
> > > that have precise meaning.
> > > 
> > > I can't remember how I got talked into allowing the accelerometer
> > > ones either :(  It was way back in 2013 and we have only one user.
> > > I should shift that ABI doc to a driver specific one so as not tempt
> > > more users.
> > > 
> > > To give a firmer opinion I guess I'll go read the datasheet at somepoint
> > > but it's not a small one so that may take a little while.  I do see
> > > that there is a recommendation for each power setting to only cover
> > > one range of f_mod.  Maybe that gives us a route to a control that
> > > it at least numerically meaningful (For those who know what effect
> > > the modulator frequency has in a sigma delta modulator! Which
> > > doesn't include me ;()
> > > 
> > > Any chance we can kick this into the future and get a useful base
> > > driver ready for upstream?  
> 
> However we go with this I'd like to keep it separate from initial driver
> merge.  Then we can have a focused discussion around a follow up patch.
> 
> >It is a lot easier to have these discussions
> > > when they are the only topic related to a thread.  One path to move
> > > on would be to decide to default (only option for now) to the
> > > best noise option.  Later we can add controls that result in that
> > > initial default changing,  
> > 
> > Yeah, those were my internal 2 cents. Not sure if this is exactly what
> > you're proposing but what also came to my mind was to have a RMS lookup
> > table (same as in DS) and for the overlapping frequencies, just go with
> > the one with better RMS figure. My assumptions is that most users will
> > prefer that. If not else better comes, we can have a driver argument to
> > override the prefered mode (same way we do for some ADIS IMU devices).
> > And yes, I know module arguments are not very encouraged...
> 
> Yeah, for other cases a bit like this we've always assumed they want
> minimum noise for a given set of parameters but that isn't quite always
> the case when power consumption matters on the platform. 
> 
> The IMU low rate allow thing (I guess that is what you mean) is perhaps
> a little similar as you suggest.  It is an intentional override of
> datasheet recommendations.  I'm not against doing that here, but definitely
> as a follow up patch where the reasons are laid out clearly.

Agreed!

- Nuno Sá

