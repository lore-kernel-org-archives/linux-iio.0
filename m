Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D8392C21
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875026; cv=none; b=bIoChnJap3zz90qpHTNDpLgBxphT9kGMBuudtjiLq8EvAV7gqnsveN+uN47lbsxsR4CsWGrikIT8bCjpcOqPI/dLokQDqe+iOyUbKHrq/+wnzsDPmim2WVXglBJ4sqKZejx9lrMuvxzPPr3Oy7+go0x47WBfxSzlXPNxbdmjb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875026; c=relaxed/simple;
	bh=iPVKEaL/sDhtjxjiJ4ovC7cycjNBtMDP+R44lrz4ljQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cbg4jttyAb1QoGFRRrUv2YSSeAbRDw8V+jwR/FgzT1b6TQrGtZnvoj92BqN9C3WNKLxpwQyf9Vz++VO+fQCKb79j0qnr/iIjySl6GautUDRD7XkmqMNQkfQ6AK2Y/S81XA0WiixigUVe3l8e2U0Fx5fwWc5lJmnEXWEQeCo2Us0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwp3A8uA; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwp3A8uA"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-662dc387b7aso2444549d50.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781875022; x=1782479822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccV2VXwAWn79HMfOu8BYWCMbmbtC3czR+CKDR5g5+lg=;
        b=iwp3A8uAiIvAF9lIpLMisywqTS+JzhsXpCWltqej+lYc/vGtWHa/KuO4p2ahcxhPL9
         SNPMleaBBqc+bM+ggfaFpdrE74phjj5irxTzGUkoOvzpLMqZQm/FGuL6hYO0Z4KkNaRU
         HKFz4w+H+LWhtjAaeMjnJvtQ1I4jZNROenVeja38lQpnpDs25cb03y6Ezdseeiwva5XF
         4gCyhVHQOYq++BLgnWjcJPFoe/DtKLo1SVswA5ODTlkbLNOCe6NmHNNa9plCW5pj4zBk
         JwFALsd9kNf09zgmG/VQ/Ao/Qx/HqqjQxVMBVjOIDnHq6oWVZAlfPTsgGbTDnCHV00nC
         vocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875022; x=1782479822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccV2VXwAWn79HMfOu8BYWCMbmbtC3czR+CKDR5g5+lg=;
        b=XZPrWLDP9jqP1OKnE0B3h5aF6QFcSScWNngq5lDQHdF1v7noOZ3uiJ4OIpgJOptwc0
         rNt2B98I1VrQcUJJB4Ue+pwRjgqwnHWNw+fkt2NrGtcHMHLBHvOjYfkXnjwsTdyHfXqS
         uClGt6iWVQy4vcgMDkpaiiKjspFXv3ne94Q9ZRr0Qez+BvMPU5Btf2jW9N5lL2j0Zm5t
         y/f6Xs8IkZUGNWGl07eZHNZup0iMHm5iPJj0vv8fjEqJ8N22tXx8awxd1lIl2OuiQFVJ
         Hf7U91a3bv/pUbufYKc2OSCZV+2ybPem8D2Hie+4Ub8wi5b3wYHWicUNieALCs6KEtvE
         AIJA==
X-Forwarded-Encrypted: i=1; AFNElJ/1eK+Yz/kxQiJ0uBata2It7wJJc/b5CTuzg97IBZBoYwdz12uNUJexrNYPVlWo9ujYoFT+n2Q3DeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzKc7b+xY/+uboJrHcL8jwgdNhJNDGCpDVrTVZsMwquUSi9rY
	cid9CBKH2pSUwDpl7ndcPXNJFeGDR/5zBsLvvsjYverQzWAp0WQrB192
X-Gm-Gg: AfdE7clMIRJH3dva1r+wrjixEtzmxA6tOElJCNTdKrb23cZ3vVtASPb5TIPt4ipEOX1
	7i3zLB3JS3ZrRSnLPP/Mfi9l0HshMXjKziW/C1BI33Xg2q2y0uGGKFO4O1IRRzvYZ4qvA1wkabg
	EcvO6a/dT0fJsb4kN9TbEdHN/Nm6MZMFz+b2tkVEm6LshjQ1tCB7hTxv+MtHKI3VA3WtEdlMzvK
	IveSkPxPcg6gK4J8jMBLRMJuhgpEFo48tL0yXrAWJX3yiwF5SOzy2nhlahDBayPbU1vD3ByZJuj
	bVUq8i0vOK62cj3p5YQxgq5hGBMoesSxI9bX0Zvs2P7wI8S3D1XrA14D+O6IqmkeVkNR+sTyF05
	Dz1Qey3tbGoTXu2YA54Auz6PE16NniYKvqNJ3fHLTUOTpgO+MZLjKxCiyyb4HHLLzuukAFs3WrH
	31ASe9D2iFeplxJzB0U2viI7D3QllNmkII
X-Received: by 2002:a05:690e:1553:10b0:662:d8cc:6b2c with SMTP id 956f58d0204a3-662fc91fe6cmr3377503d50.25.1781875022447;
        Fri, 19 Jun 2026 06:17:02 -0700 (PDT)
Received: from localhost ([2804:30c:1f0a:b600:e457:1a16:4082:3e0a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de61d36f0dsm22122186d6.27.2026.06.19.06.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:17:01 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:17:40 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pop.ioan-daniel@analog.com
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: adc: Add ltc2378
Message-ID: <ajVBdImL-S-YEx9O@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <f9e88abdbd23df8039282497a81d3c8698a10665.1781661028.git.marcelo.schmitt@analog.com>
 <76d39d2a-051d-4706-8433-3d3eb97e7f2a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d39d2a-051d-4706-8433-3d3eb97e7f2a@baylibre.com>

On 06/17, David Lechner wrote:
> On 6/16/26 9:03 PM, Marcelo Schmitt wrote:
> > Document how to describe LTC2378-20 and similar ADCs in device tree.
> > 
> 
> ...
> 
> > +  vdd-supply:
> > +    description: A 2.5V supply that powers the chip (VDD).
> > +
> > +  ovdd-supply:
> > +    description:
> > +      A 1.71V to 5.25V supply that sets the logic level for digital interface.
> > +
> > +  ref-supply:
> > +    description:
> > +      A 2.5V to 5.1V supply for the reference input (REF).
> > +
> > +  cnv-gpios:
> > +    description:
> > +      When provided, this property indicates the GPIO that is connected to the
> > +      CNV pin.
> > +    maxItems: 1
> 
> Missing pwms property for when CNV pin is connected to PWM.

Ah, thanks for pointing that out. Will add that in v4.

> 
> > +
> > +  interrupts:
> > +    description:
> > +      Interrupt for signaling the completion of conversion results. The active
> > +      low signal provided on the BUSY pin asserts when ADC conversions finish.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +  - ovdd-supply
> > +  - ref-supply
> 
> I only looked at LTC2338-18, but it has a REFIN, which is optional.
> Nothing named REF that is required.
> 
Hmm, I think that's the only device that has it differently. Will add allOf/if
properties to differentiate these.

Thanks,
Marcelo
