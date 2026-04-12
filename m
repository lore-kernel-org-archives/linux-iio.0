Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDD2D9EE7
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776001877; cv=none; b=qokvh7DAdv22smzeQ4+30kmUA75whf7XuKP1460GbrWLHeU4dT4MUKN0lfJGh1B1Vq7t3hirYSRWK9X3KwGECr7MyKCDCue6T5HNLqkIKAgBB8dharVHGDNWQan/OR9Qmry1zyCkvdZY87iTIs59jeCr4Y9rJ0ulvHEEgawmQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776001877; c=relaxed/simple;
	bh=ybPna+nSlRaJ7cglCwRHGUEazf6aydGHXkQ4uUZ+Evo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opq7M31loI8HfMtpKdwhcXnbcXYxTD4CYzCzcwyLxsSWqlgiIs30LyUVU/ETItwsf+gbav0fH5SmayKaMO3YUzdaD5qpdBR0yx0a+jg3m/A4y2Ao5Gas9oAwM/aBu+8W8vk/Y3TFbBaql4KgTyc1VdJ3ZXlD31tu33Sv05ORyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbeDosMu; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbeDosMu"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b6b0500e06so6321332eec.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776001875; x=1776606675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YERkmdChGOOp0AVPK9xGAVYSfYkxQNZiG/hsYlzmk4=;
        b=kbeDosMuIcP53PKkVfg50yTB7XBLC/ZWT1wVDEu2YL/s8fZ0+uvg7mg+HHF3BVKc0T
         L+wXXz2KP5wJXTKYK+z4oM3C1cq6CF7rg6KcUli/WRKvHpsA4zK260WBCyqEtpRlY7jC
         wuOFhDj4diZF8CMReSPNbqlen+Z1/qdOyI1beTOWEYB4+17TTGyP+JBWYYGJOB7DI+aC
         vyIyqUotpZZ3KQJQqSgUjNLLWFE2XR2JMDP3z2c5jtn4npCEWaA4kXjOplpgZMe0nV0l
         ++a70oQ2xx1gEgppKRUbZ6w96P8xnG4vjo001oC4WEcYyVo8Gdcy94E5Z/QMOJ83wlA/
         O3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776001875; x=1776606675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YERkmdChGOOp0AVPK9xGAVYSfYkxQNZiG/hsYlzmk4=;
        b=MLNQ+GnngZgZ0iTb/7XbisHAgSMgm703cXJIkosrfB3Anc3q4F7VYphA/uBtluCW+q
         4cE5CRTMZDt8bREZj1E8uoAJdbi8vEHmB3s3fVBQyg30m3/mFCwDgTtNapEgBeke8B7t
         EFCesRND/tPgRIFOKKBhQRjOGBaCjW3DRvIFamxKfpbUZ2z83C0EvCmO6YGj5DPtq6Ge
         Cg3bSZcm+qAhGHpCF3f31YUzU4cyEouOpuanMeVmZpAGPkoQrvayMrc1aYBvl1i9BOFZ
         jWyBU5XgMHlwumK/61c/N6SXnBKKoNYUeDmzVsfp96P4T/JFjT/fL9XH+CjLWpE+vU+s
         2lzg==
X-Forwarded-Encrypted: i=1; AFNElJ8jM0+cvHXRPpkTE7FkP1Wko5KWumZTQZ2IeA5/BRsPFjzCXV6f7K7MCN7dxAJx0mqovFT1+U7VMgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vK0/1YpFvkU1JZeqkpuhHQns4hfLARmBz1kc2vuRe3SYJBa4
	Kzvq5HXR4XJcCEI9Y7xKrBxQWSms9HvCHW7b5QG1OdxSiu+uMutI6cx0
X-Gm-Gg: AeBDiesn62yvbkku2/iH1w72ox5DkK5opSrd0NTDLIAL910zsRcfkcaPjXYGo4MvoZ0
	l1gwdB5UIIND5S22L1sQfVHqhF6gCDAhq237XU4+r3uqTheK6W0klR2/ltBRbhYUFuuKtvLYgf9
	IGblnnAcDbPg3VaMtAQrwAvTD5OWcft0TmF+xACkdBpAW17+8sGPgOH6J9FbjH7fpmrlEB0rfrM
	UhTAhZMB2R1hg+VMoAEXXea0Q3PhHjz15D/DU6AsSwRnqjg7Vb3oOoovGG8vp2PyGeVBowgSxTV
	c9KO5a3UNNjIW4jAnW/CpmDeMrdO+KCIDDkO4T4sGboZmoD1Aez08jnGtx8EMLsTYSSJieEhgBE
	ogfNIhKyt+JtaSHOjKoAAGFjic/8iHWUUpwVVVi9Atw+A0QcBzic6Jq4SwPfqDJPDAKGEgoYYG1
	CdInkYBYrByfUQdIVo2NA9WP0yduCjC9H/
X-Received: by 2002:a05:7301:fc02:b0:2d6:78af:ef5f with SMTP id 5a478bee46e88-2d678affb8amr2700095eec.3.1776001875147;
        Sun, 12 Apr 2026 06:51:15 -0700 (PDT)
Received: from localhost ([2804:30c:1615:e200:d5b3:6e10:b20f:aa53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa5257sm12729835eec.9.2026.04.12.06.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 06:51:14 -0700 (PDT)
Date: Sun, 12 Apr 2026 10:52:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4170: use lookup table for gpio mask
 selection
Message-ID: <adujgV4nfAwiJPjA@debian-BULLSEYE-live-builder-AMD64>
References: <20260405213725.25426-2-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405213725.25426-2-guilherme.bozi@usp.br>

On 04/05, Guilherme Ivo Bozi wrote:
> Both ad4170_gpio_direction_input() and
> ad4170_gpio_direction_output() duplicate the same switch
> statement to map a GPIO offset to its corresponding mask.
> 
> Replace the switch with a static lookup table, simplifying the code
> and avoiding duplication. This also makes future extensions easier.
> 
> No functional change intended.
> 
> Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>

Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
