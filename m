Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FECF39F19E
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540736; cv=pass; b=pkKvy4An73lNXuCjf8RjaO+d98pmgs7lRoJaMChOb1Q5WFgAyTn9UsQZ8b71z6Ke1KidiOkAd/PEJfMbo+6ZejrwGGBhR6cd33eSj5a6aBZb7hSlPwB35xZMXzFqGJj5jOxpr1KERFnNfEbbixJg+niukUJ28sKueRuZrg1DyTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540736; c=relaxed/simple;
	bh=tqf6nWwlp5o4xzSq/MPNLpvLO8G6JzYUHMXN97KkpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFoIsrw3FuBjhgtobmbnSSyMN36O7PHXeMs4g8lXGyU9/mQ86lwH2Cy2w3FgHP9eWciMrvh2lictuRoOJPahINPMhRj5/6Ac9OXv6i48vjSfTn0MrcY/gW85nPkJSAVI9dPzXIQR2PhdrpkBwo33zuK2dBFFyobSzqOHwLTwb0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By9ZRyIe; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By9ZRyIe"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fde5b81a1so560651f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 02:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777540734; cv=none;
        d=google.com; s=arc-20240605;
        b=T5k86ZMC/e12dt7F6yyMoSAYQ9I4JILTvDT2+Y3jYOfm+gixYrhDV6jLGvjlYkVzqS
         lunrFQCslobqCmLvl58Yxh7jCI1noYV3dekroMN1Iq+Me/xQpdzWg5aniaaBsr3F9DYN
         eqoBk9CF1SnKC4wWkFLzafDc3gOSJzIxyeguKjjudd9vKvVmu7Ug0UjeclBadvn/f4Il
         QkWertZOtyFVTuzx0WSQrjIqbb1OYyR7Jj7mRmg+atGBXoedauCYPR29QFk8Bdtb1Llw
         b59XslANBaG7P86HaTugYF3Ei5H8Anp8roTPiTQz52m2scSDUplxOdZ2c8XNYw1LJlRx
         sQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2uL+9X5LFu3j2QlwPMN157Ph4pY0ctfqJ6Z7kkcL99g=;
        fh=NYg5fwKm1BATy/808PfABo+ZbNYKYXEiL6EWMgAAMQc=;
        b=Z7xCxfXidEbnneHrvDbiWc79Erk9Ss26gOwddnn6xkzl/hgI1XIorYeNCE1Bp0LSdE
         ph/39jtB8IwPaw0Q9+SaH3GDrG2AsTPJjstwY/uBfSpnhyaDbgItz92rceZjCi3PFRGe
         DNMg7q9WgKbmggKJXOR+hXrsNfhlKTvl00xjH7IrxGE/8vIr78ZU3jlLWeYpGwyZNyNx
         k05ZHnOXfHPGUJnSMOLjNra3+u8M0yBqZDAogHXU4VLXSNEnLjey0sHVTRUSrE0iAKhQ
         /zYAC2dZSBcYaA8RkqlXi2Ngl2u/G8CWDzN3ejGUox0GsNDAv/owbLL1yDKA/XvBE21U
         FzrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777540734; x=1778145534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2uL+9X5LFu3j2QlwPMN157Ph4pY0ctfqJ6Z7kkcL99g=;
        b=By9ZRyIepG4J7lVF6yo375nKhca5ApdwR95ZmW5cRt3ViennGwUNrL0h33aWKoxTbI
         1dqldIoZarql+Q2qHJXCmYf8Eez8f6gOxskwCPtb0UzgC4mAper4wMuNZuWs2WwO9eZ8
         /Gfzq2w2HZpQiZMnlEimzf1Lx0Uvbkb2Qwbz2zaqgAXiziTGHds3suJ526SpiUbGCofF
         wKixTUqNgzJVxjm+vrzbc0wY1hl++wDPV8FKNsh9kZKAaI+6wLu2Pqdi4n/C0Lhqgsnx
         1f/4pOsME/5J6F3ksA8ymTlQhipFIg+HjVRR/+yg8EcwP2vYTpuz4LlqcDXuZuXYW+b6
         q+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540734; x=1778145534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uL+9X5LFu3j2QlwPMN157Ph4pY0ctfqJ6Z7kkcL99g=;
        b=KFaWN4EORoBRRsmNbiARBXpRaRHAoX/dsGyGRGEL5BhIHSCDNb1sm5W5p7Btky029Y
         i4b/95MLY70UaxnBzwdLuJyhyPKDQ2r1iirP9oR+S7D1qxuNEIy/BJ4tXA3iqOoEj6Sw
         quE3lAsZsXeUcmOBUjSNfpkxmyKW0Jawzpqn93F0kvjTg4XkVeoSB35UNsdTGYTSsVm/
         GgnCVJgPACuGHqgnkilv1QNX5xOhIbiaZavT8ibnIGeArMJ3NDPTJaOqsl8i5X5eQQ5e
         BQ9/W++zXWos0RvXGpmD3i5+4+3PhagR0z+L+0hwQoA6AaMhOmaxiJcLo0/ezKYDJe5u
         6WBA==
X-Forwarded-Encrypted: i=1; AFNElJ/2EK/R8c5UjKtuvcxn40rZ+tj8no91/T/X77FIcK3rioPvdPxCMLFySiXT6XSROA8urK06P0GJ3hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkx0DPqqOQFN0m4xS5ZBG20C/69/j82uBUGJBjnujUuVlrDBVT
	5vqaBDXESawCqW3UfK2Y5kzySmAFjEQIzUr/SibTGTLLzEjmSnrlQ1ownA+MW0d/XcRWWunWOdR
	RDgfABSxgrm6JJ8h33DnTnpy5F0hRG6Y=
X-Gm-Gg: AeBDietlL6OpcmfC9uUkU7px2fFsoNAy4W8KNllFO9YkZeCZR10hULxAC93LldFTCJR
	sSglROedantvToElqJtnQ/bkx3KGoRBBYbrchCTmoIeWRNbBbTKOPv6N1sXdIa3Qw38XaLmbDmZ
	smxe65lyVSU4saU7duI3p3hhOz5c1QWobRqjnLhAg6v6oIeg7+8an3fMdrjpsME0CvmFF/ag2qe
	/SBBJIgpDjbYvNlILsxUArHiUVbNivkwZoOntjskZPiYvUWkSPqPpDpkQu7wpfltS9DTHH0FrQT
	aO165FLdQg6vMG3vvweA0LDNJxuJUSSJB5CX8ZsHIrI1cxD1YpSt4rGiYXehPn3sIqDQ7valRcr
	WRF+bM7GJ+Mm2LLGcMiA+De5WqbvoPXKiOsO+8Zgd9vAYXxQ3DGJRN1yJzfd0N2qK+Sn4hxqnEb
	4sZXx2WGtgWxgZuNPQ
X-Received: by 2002:a05:6000:2408:b0:43f:e94a:e777 with SMTP id
 ffacd0b85a97d-4493f130920mr3325000f8f.37.1777540733634; Thu, 30 Apr 2026
 02:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com> <afIRG2S94JEn3Oqd@ashevche-desk.local>
 <CALoEA-yBU_pwiOFQx89-Gcgmtz_KtuxJJvph7uKPHKJNihDS8Q@mail.gmail.com> <afJLlpsU17Pmp0uH@ashevche-desk.local>
In-Reply-To: <afJLlpsU17Pmp0uH@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 30 Apr 2026 11:18:42 +0200
X-Gm-Features: AVHnY4J3zGOvhYOUcJM0n_VUAOqGumuOnl1bD_3OPrm_J7YbjUsGaBNOtvKkDdU
Message-ID: <CALoEA-wvYvZr7ixC4UOh98mZAas1vbOe5CXT89DOy3e7xTmJ_g@mail.gmail.com>
Subject: Re: [PATCH v4 06/13] iio: dac: ad5686: refactor include headers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Michael Auchter <michael.auchter@ni.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 20:19, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 29, 2026 at 04:38:02PM +0200, Joshua Crofts wrote:
> > On Wed, 29 Apr 2026 at 16:14, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > I haven't checked this deeply, but I hope at some point we will have
> > > more or less usable state of `iwyu` tool that may do this automatically.
> > > At least current result looks better than the original.
> > >
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> > I did find a "filter" file of sorts for IWYU that Jonathan had on the
> > mailing list.
> > It does a good job of omitting reports of very low level headers but at the
> > same time IWYU still tells you to include things like <linux/stddef.h> and
> > remove anything <asm/*>  from your includes. Perhaps it needs more
> > tweaking?
>
> You need to check that manually and then decide if we need more amendments
> either in the patch or in the `iwyu` "filter" file or in both. In case of
> filter file changes, please share them to Jonathan and mailing list, so other
> people can adjust their work in case they use the tool.

I have made some changes, so I'll send an update where people can get the file.
Also I've noticed that there is a /tools/iio/ directory in the repo,
perhaps we could
add it there so people don't have to search lore?

-- 
Kind regards

CJD
