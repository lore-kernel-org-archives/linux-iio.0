Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BA42FCBF;
	Mon,  7 Sep 2026 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768005; cv=none; b=EcbOLkvsqJKGyqhr2rhxCFtGsLFCjERdNv0iDCHuVgU5lbbVMK2LanomCykFe0RWAZMoicESISKaZ/KAJcKwW3IXLMBs3ftSR+3aq6sxxtIYoTz+4mChk3YVjkVtOg3/3UFjvtVU6YNqxsCEWkrLjyGsWfng9by4oiZptj0s3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768005; c=relaxed/simple;
	bh=h3WFXrx2EjpSSH8EOeN7N1Vyz6XlhpwWUwi+4XpdQ70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3QACkOA3IVRT17+i2ptauLDqmKKpQ301T2WaSzzGwCSrXU0LNBzwfLcuM3yBq91qEYKeqb95BVtocgbKNiuktMHtoQR9JDSBpJFl1PvL8mN+Zq6jwC6PzCMEW7lonttd0Sx+CBotrSDJtnTrNl3xGKlHM+FpLtqYWtMmUMMybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGQKKHnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGQKKHnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9B01F00A3A;
	Mon,  7 Sep 2026 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788768003;
	bh=ynDRLViH04RclRGJqBCrPVaMpkrMgbaRYlnWLqlefjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bGQKKHnqP4O+gTfX49A5woF3lGv3vUkC2MpX/xd3HsEuPLEBuedU3prgqxvjyLkHc
	 0iBifv+aY7CzKHxRDNnFj929H6+2ZE5iG5eMi062HYlz1tB8hwHAqYUkq6BQGupj+5
	 MH8OPduqu0IVIxXrgtHqC4wHupvQ9ag+u8soB2COlwZCbMTagNEvyZ+n5Z7SjHY3yL
	 wNP1tWhVipTbpyLr9y2vhUxKLxhBi6ID0+Egw9TZbV/JpYHWMmMucLkoFQVnmLrjto
	 RbW0G3btRm8wIuOXErTBvvLcZx4Q6QtpEuBfgA8/B3uEjcCchpI8I6L94RhBqedmgw
	 zNdwp8NMvi7cQ==
Date: Mon, 7 Sep 2026 09:59:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Flaviu Nistor <flaviu.nistor@gmail.com>, Andy Shevchenko <andy@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads1015: Add label
 property
Message-ID: <20260907-elusive-sensible-rottweiler-0da0b4@quoll>
References: <60dc58c6-dfe2-4377-9a73-f65cda56179c@baylibre.com>
 <20260903151939.5117-1-flaviu.nistor@gmail.com>
 <61d64649-603d-4a55-a789-babe655a2de8@baylibre.com>
 <20260905025612.09363f51@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260905025612.09363f51@jic23-huawei>

On Sat, Sep 05, 2026 at 02:56:12AM +0100, Jonathan Cameron wrote:
> On Thu, 3 Sep 2026 10:30:01 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 9/3/26 10:19 AM, Flaviu Nistor wrote:
> > > On Wed, Sep 2, 2026 at 9:31 PM, David Lechner wrote:  
> > >> On 9/2/26 12:22 PM, Flaviu Nistor wrote:  
> > >>> Add support for an optional label property per channel similar to other adc
> > >>> chips. This allows assigning distinct names for each channel which can
> > >>> match the schematic signal name.
> > >>>
> > >>> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> > >>> ---
> > >>>  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++++
> > >>>  1 file changed, 6 insertions(+)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > >>> index 718f633c6e04..777a75c21d7f 100644
> > >>> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > >>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > >>> @@ -66,6 +66,11 @@ patternProperties:
> > >>>            - minimum: 0
> > >>>              maximum: 7
> > >>>  
> > >>> +      label:
> > >>> +        $ref: /schemas/types.yaml#/definitions/string
> > >>> +        description:
> > >>> +          A descriptive name for this channel, like "vcc_ram" or "CH3".
> > >>> +  
> > >>
> > >> Apparently this chip has quite old dt-bindings. Normally, we would have
> > >> included adc.yaml to get this and other channel properties.
> 
> Quite a lot of bindings predate that generalization work :(
> 
> > >>
> > >> And we would have used diff-channels and single-channel from that to
> > >> describe which pins are associated with which channel rather than having
> > >> a magic number for reg. And the ti,datarate looks suspicious as sampling
> > >> frequency is usually we control at runtime.
> > >>
> > >> Anyway, none of that is really relevant to this patch. We'll see what
> > >> Jonathan says about using adc.yaml here vs. adding a label property.
> 
> Given it's only a single property and label is pretty universal
> I'm fine with just adding it here without the reference to adc.yaml.
> 
> DT binding reviewers may disagree however!

Yeah, I see how adc.yaml could be used here, but then it should disallow
"diff-channels" to be explicit, that old "reg" style is used, so maybye
not worth the effort.

Best regards,
Krzysztof

