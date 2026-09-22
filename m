Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA95625F9
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093284; cv=none; b=CxP/XuKshHkF5I6FlHG/2IAX6wkHGwgMmrzUpOvuol4EWTgYZMhFXRzhk/rZ4/myxUUsdvybpgCfH7YySik7OkufTWqRn3VFNHaL3I6wTQPfcEJVE/h22OWf/OHFn1PGLh3ULmCstbS6Wn9fejr4Zywmblwq0+MRwJoBqBT/NUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093284; c=relaxed/simple;
	bh=GOaR3oRNiNzhSpbEcZWvDkegir/uIorFZ2eUkpF7mf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQmrumSmdNPjfvi4M7Kr4x8ssJ7rjCesdQMqW5iD4x8eggSuOOfj9jQCxmf2Ex8+vw6XryN88IOTXRf5V04TyQoexg3PC4EyK+bZQAugK2ltkqJPs0YI/osKjVz84T8x2tnx5NguW8a9ed3tpd/mZ4uOd3TWKdE1i5MOA447/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrZwnIRs; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrZwnIRs"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc74520b20bso35382a12.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093280; x=1790698080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HBbhvK2kEOBfPteB03TY1EsiSBGN3wG4ENtFO8lw2k4=;
        b=DrZwnIRsQ7NbvOs6gJ8be7d71msi9LrrXvn7cEfhcKrnmvRa2PcoxkUmACXZVYjy4R
         yxFcVTi9OAAhVF2+jXmO9UP6RWEXHK04xygvY2hSllV9vT9u+iV/TS7l4VGVF29xJAVW
         qp5YQay5V5F+TBX/P61+ibxiNNbMP8VsEdf8ViWdi6oPAduOvnxFKMfGkTAADWsvKw6b
         QtcsaXTeJ/i+ig9CluAxB7VIPQqeba5hQr8b0erWD/q/cmtOuUtgC/Ry2mhzvZfO6dwL
         FOUy7vhHcDQJ8nOoTK2DvtbJKCiTZMRu6vf8mJvBLAeDPbjtulp/221dgZgJ3GV9bnU/
         vkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093280; x=1790698080;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HBbhvK2kEOBfPteB03TY1EsiSBGN3wG4ENtFO8lw2k4=;
        b=dbneYh5mUFeeIkfRKuxu2+4HcZlNT804CHH50qVzWBZGQoklNMScDaUmFCye6dTpsw
         0ezFyRwtdLuPe3/QdtqV8L38HP6HIWvDUlDExZhVikudxf2QdKhke8OTgM8dIHrKWPOS
         JCpwrXHxxyb9k6c7UO64iOHljJgoBgMDyy6XzntrxWtgEEeVt32olsEPpQ1mwjBcLLJ7
         /lE300+IKt03G+uZOqS1tlCVP/Uo8oNJJjvzskDt1Wo5l+Qad/OeVsm77Pt010GjK9AU
         plQf7erA9D6PydCZ6rcRBZ3sYokl3UMQo4L87qkKcehA5XvZlQbxFX2raiYNZGHP4wEJ
         cZcg==
X-Gm-Message-State: AFuF++kQR+z2/albjgtJs3xohAKEm6kfcIAHm6LrLz5g6NEid88i5sqZ
	euUb11JQZtPZWTUJli2KwikJ1/W2wiYo1U40BE+cBYjTa/M6gGIj7AYYywQkmZNm
X-Gm-Gg: AYBFou2vV/0D5ZS+yNv3UOCDqRb/04y5b1ulyRHUZQTwC0hXfcqRifsXu73MIatBn2a
	2ubtR6KQdmYfNFY2gX2UI2ReJVWhD1XLbXJ0a4Cz2paVmT8wfKAQBTYiqRZUrQlpVTop4NIyKZL
	Sg6mROkLFg2S2DKZDFlQXp7deRYZU81pvdGQ8ldpr1OKzB2w9hrtrwwuSYMSGfVqbiDenRioEyH
	vZV4POMEZQbmgI8AZyB3OYT1VgtpUTkg35V6Hv7+WvnX++csBx/IoLEIHVE5Gj/fErj9SUcTLJs
	oDIMTY0pIH7quG1/3MYK03q7A23+b6LXF145IJpvrZrFGFHtu/CI3WA7C/THb6xjc/zCn/QJTCK
	+TCNhjbUMQNj+d+a64ZFyNne0NFLkYmAHEG6At1Ib9PkD6omJ5uRaZeHbzN31ZC4h73Mr7471Cc
	jKM6EeQ086zuGY43lvWpcUsfzwyDMCTnOWReNq4A3ahNsYU4MDA6rSEH/gWW3UjSLa9Is6jOsYj
	sX7okaEGZ1j8mOJEh/iEMyR5Lvo0YLK6spSLcPYKHHig+lMn53uFlfAKSJKhnokUXeX3j7pu6bJ
	EFKjUzU=
X-Received: by 2002:a17:90b:4ac2:b0:39e:6c68:fd8b with SMTP id 98e67ed59e1d1-3a0736ae0e5mr1221986a91.32.1790093280523;
        Tue, 22 Sep 2026 09:08:00 -0700 (PDT)
Received: from HYB-2NH2WFe09VB.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de20eb1sm63989a91.12.2026.09.22.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:07:59 -0700 (PDT)
Date: Tue, 22 Sep 2026 17:07:45 +0100
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v10 04/17] iio: add IIO_FREQUENCY channel type
Message-ID: <bukynp5qvtqf5jgqnxzxesvt5vimm3i3lvqrwmffc7fecjnabx@rqyeho7v5cnn>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
 <20260729-ad9910-iio-driver-v10-4-aa1f6167729e@analog.com>
 <xevuqaudwm4hpnhbful263yx6r45liuch6yc7xjk2i7wly3oxo@xe2htu27rkl7>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xevuqaudwm4hpnhbful263yx6r45liuch6yc7xjk2i7wly3oxo@xe2htu27rkl7>

On 22/09/26 16:56, Rodrigo Alencar wrote:
> esOn 29/07/26 09:25, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add IIO_FREQUENCY channel type to support Direct Digital Synthesizer (DDS)
> > devices that handles frequency values written directly to its buffered
> > interface.
> 
> ...
> 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  drivers/iio/industrialio-core.c | 1 +
> >  include/uapi/linux/iio/types.h  | 1 +
> >  tools/iio/iio_event_monitor.c   | 2 ++
> >  3 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index bdf3d4c06331..a45277bc5d99 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -99,6 +99,7 @@ static const char * const iio_chan_type_name_spec[] = {
> >  	[IIO_ATTENTION] = "attention",
> >  	[IIO_ALTCURRENT] = "altcurrent",
> >  	[IIO_COVERAGE] = "coverage",
> > +	[IIO_FREQUENCY] = "frequency",
> 
> Hi Jonathan,
> 
> Thanks for not giving up on this one! Taking a look at the testing branch,
> I think this line was dropped during the rebase (addressing a conflict)

btw, now that we are at this again, it crossed my mind...
Is it fine to have a channel named the same way an attribute may be named?
wonder if userspace tools could get confused.
 
-- 
Kind regards,

Rodrigo Alencar
