Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F413AD26
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777207689; cv=none; b=gPmUQdnZNNeFWgC2kG9LL9T0UaMAW8QkGoj8lXwrr5Ggc5rhVNfztJX4IkaqjAUzfJXpior7AujoBFSCObv9ccmkea2xgdIXnhxHZ1g/xW7D2IDDr5uWBh8VrYCpkJ3y5ecV569kTHZLwiwX1+XEzwsh8AiBEU8hQI7NqrdmHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777207689; c=relaxed/simple;
	bh=/C1jSY0hNOX4U3GO4+9/Qy/3BO+jkxZrZ1AeBT7K+Lo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMmxSGldRi7PTft7Es0ihAhl71Lm5nNe6y3MyCrL/srPyFvO9B7/iHRdTRQhIc84HoXcpmg23a/VDy2iXNqxc+madSBojzj8G6gTRh9vtfeOFvrFnbOU5jh9drDZVWNLtJlKzlso9lE7GJ35vYRseDkVAqrhdXVDg5Qv5rU1yYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APmDflE1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APmDflE1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d77f6092eso6457043f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777207686; x=1777812486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdSlfN5TOas9ObtsBftpjoK8qDSsbhsD2j4mnZKffjw=;
        b=APmDflE1rTbEnnkoAupdrwLRCNVThkRqEmKQd1oLLRoNZUz0N9kQl40vM/bAd7yoto
         b20y7Ir//2zXgnA1K0tuLhNuypM/QnPfDvnxyos9R5g6V2s3DNurJrsXr+5GKYZPP2A3
         PDS7ZlOlx0/rADiT7KaG94ZW045eBHxYSMGKlvWz3sC44dwuo8KWdlGA9iYEvTzOaam1
         KmyaVhSBBtkIGwibu73lNuKGfBzBBPqEEoTdYNapQhUMNcohUq6waT2diMY0nWopfqqN
         MqGZFf0JW9T1hmJAwL7iGqvSW9mXpGCD30HhLReN3Btam9EKsBDQnvYjoKRdY7NYQOr3
         7Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777207686; x=1777812486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdSlfN5TOas9ObtsBftpjoK8qDSsbhsD2j4mnZKffjw=;
        b=H2ZoWskNwd8SC+vI+VXKDz6UeMz8j8Ea+Ma5ANwWEs91QBRC3oJnQI1ge1B+K+LRnv
         5p2VT/dhbB4YBLOET7wjy53X9UB6TaCXsKrsn/T/dl6fET/Ckg+C4gMZCB/gs1tPsB2I
         ESHS2ZPTuCj6xrJSc7fYjhkuY3uT0RjHdEVW/sKePAeIcgqcG5/hho2QQ0wy0CHD+REd
         brBiCjmWHSSVK1kY6KViaBNoPl6Z4FXGA4b9GWacRSer2g3wN6eNpZRqPvtm0k6923da
         htEtbZJDzSHdrqSHTX5/1y6BS5qRCpNYdBz2U3Uc6OvqP+ACjgwT40McyXcSREmqyGQY
         lrFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4aFvb4wVXzYv0ffjffNOew94JxRwmNdB2Hw9xxBrV5qneoJsKt4LpGZB26Uc6/mCyIgLnaXYgzDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLuzKGiE5YMScyZqrgRzi9gez0GHgNW/3ODSZf+VyLclmzrPR
	JI4VbTJkwuKkDZZjXupF/hy6efsE7wdVc8WcUtmh26yNjePbhbkEaJXM
X-Gm-Gg: AeBDievm1d5Nwyx/vFWiRCOOKlgCjkuNu+aG3uEaWUAACrHD8lhQFx/M8eMaGQYJdLZ
	fX8S08KGY1CoiOO4liCiP334W9+sAPBpw5Ciqqt0PeA1bc2lNleUwowlFk+o+y2FPeNsbtiXBpf
	s7rK/3xEt3pEQt4nngDxgQWbJtWaH9MQ+ZjLymHUa0wQoBEgJUDwrXVju4X3wJPZYzoxLGWq7TK
	+b6SISuI02YXorAqS6EjC4ttONv/WVyFba75zXpMoa4cumP4IfXpAj0vGddcrA1y4Y7rlkYIbZ/
	QVZJfIKpKJ0Gy8f3PeyDWA6TMImNbssbxRS01HkUVXEGVtsP5XDfMbEXgjSRweokuxasmQymMUJ
	HgPkfk7wkZGccm6M8MRs8zt8HXaR7XBqAwvCXRq89obNJEM9BpK6Ekld8HfbyVsy7g6Rp5X4Uy0
	r9eOvXQY09+8erKwYY3UnfKoWwI499CcSqrlIW6pmitalX4OHagA+ws5/TzTzxyCuwTY11aLETM
	U50CwcSn+MHd741V/oSoX1YZQI3y7648jpIFEeWZa8up1O91DH+sX481cNh
X-Received: by 2002:a05:600c:3546:b0:48a:5546:61a1 with SMTP id 5b1f17b1804b1-48a554663d4mr338552955e9.15.1777207686168;
        Sun, 26 Apr 2026 05:48:06 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5a579bd3sm376534015e9.6.2026.04.26.05.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 05:48:04 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 26 Apr 2026 13:48:02 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v3 1/9] dt-bindings: iio: frequency: add ad9910
Message-ID: <662bly5emi76xwhlcetznipwsa3a5ncyne6zvpffqyxp5pvczq@23udi3emw6sp>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
 <20260417-ad9910-iio-driver-v3-1-29b93712a228@analog.com>
 <20260426120139.3fb8f3da@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426120139.3fb8f3da@jic23-huawei>

On 26/04/26 12:01PM, Jonathan Cameron wrote:
> On Fri, 17 Apr 2026 09:17:30 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> > configurations for clocks, DAC current, reset and basic GPIO control.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  .../bindings/iio/frequency/adi,ad9910.yaml         | 189 +++++++++++++++++++++
> >  MAINTAINERS                                        |   7 +
> >  2 files changed, 196 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> > new file mode 100644
> > index 000000000000..61e879bca5c2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> 
> ...
> 
> > +
> > +  reset-gpios:
> > +    description:
> > +      GPIOs controlling the Main Device reset.
> > +
> > +  io-reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO controlling the I/O_RESET pin.
> > +
> > +  powerdown-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO controlling the EXT_PWR_DWN pin.
> > +
> > +  update-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO controlling the I/O_UPDATE pin.
> > +
> > +  profile-gpios:
> > +    minItems: 3
> > +    maxItems: 3
> > +    description:
> > +      GPIOs controlling the PROFILE[2:0] pins for profile selection.
> > +
> > +  sync-err-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO used to read SYNC_SMP_ERR pin status.
> Looking at the datasheet there are a few other things that might want to be here.
> 
> pll-lock for example might be wired to a gpio to allow a check that lock has
> occurred.  Maybe sync-samp-err as well though possibly that one wants to be an
> interrupt?

I can add the lock-detect gpio. sync-samp-err must be a gpio, because it must be
used by a calibration routine that modifies sync delays and reads the gpio value
to check the sync state. The goal is to find the best delay configs. More details:
https://ez.analog.com/cfs-file/__key/communityserver-discussions-components-files/318/3426.Synchronizing-Multiple-AD9910s.pdf

-- 
Kind regards,

Rodrigo Alencar
