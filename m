Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB234A78F
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521963; cv=none; b=ED822HA6JXb+Q3xvrH+pzelXKYiTzLab+KT8vHIxCpUgPGKcT9cPICxUHcUXQBbqSZIMQ993tnX4rMUUbOIVmKviqFq/oLnsOpn7jbyxft/i4hyvuI6FHnq2igZnmBKEhRRLbYQxkAbIU03BZ4GvPy6R2wOsK5qAqckDiHJauAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521963; c=relaxed/simple;
	bh=rhIP3xpggh82GZU7CmoSbbhDhRtAE2Yq1Aqs3Z7Bwm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNGZptdocGJKwpGynscCz6JPP83SyFh4CKhSvpYlQ4UwW4m60hD5vzw1746oMR2FUWnjEUUXvoPjeE33PNbaWp2Ik7OxO8mv6Izlv9xINcvgq/U5mbu2ZdZ0fgMoiHq3cHeO9d70gokn1ledemc+FIxnHdvYw5gVKcihiVlHs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9lVuUmT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9lVuUmT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b966dd74so3135125e9.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783521958; x=1784126758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pEp1ol1LlGWoTCSbyN12Tvrg/hxt8xJFi5XclnHnmwo=;
        b=s9lVuUmTwciOqWa1I6yt2CrDPzWoEYlgcbrXZ6Q1oFWpdGj18+2ON9CvLyI5bQfW0U
         a42VpgZZzwyHxABEfoiX48uJn7XgQvnytE8/odS1QzdD6XcXr4AtHcJWuuNkyN38AxMR
         QH0xPyktpQPFfgqmQd2JsbEj0444b8eAJ0ncAnNkhlhTJZfTgHWpWKph95T5D0R6cQY3
         nlMShkb6zp6EGnpBrXb1d5Cgjdhdo7gt303S8OWEhQs7QGySkiUmWXQS5bit4h6otZvk
         DcluSMEO2Gr+j//xIdzh+ruG0NZOppP6R2Q6ik/fQ+4STG3VUxxI0XrJW+Izwnl+w73J
         FujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783521958; x=1784126758;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEp1ol1LlGWoTCSbyN12Tvrg/hxt8xJFi5XclnHnmwo=;
        b=Qt58C/Av3P8nMiWA/D8ZF+YrMOEQndTSh6XMjdnTN96YMnY8W3RpTdNuqQOBCUhCbg
         +JGnXSmqGIbJFBM1duNee7DtkPYS1sSMiUF6O+uVvBrKYrEmJdiFkGJ6irJhuGjrzHVY
         pym/Dl6E4Q0yMVe7Cx60sdVmA06nSA3CoUzVJXSg9n733iuQIUA8DDi2jpJymKlE6vO2
         yvJDceHuyPKv79vyZXoa7nvFcLIyYllqqbSeyZXwtl3pk3lIlh2pv5apsDaSHibWVkf+
         YsW721+G7/lSy6WktZFuqrFNiSqVId6KAm3ikzwzge84fHOs8FBC+dxEzKhn40P6llE8
         5sPA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8fDzbC8gKOqisna6w9I3r0smDwIv+btEP4RT9xrEa1U5Otpd2TpKZpCtUKWr38EpyC+58ZTY53JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdva5+0ZA0bQFg2QPrUireGWDTRSxo1FGRtBtUldgbjnOZJqjo
	WC7hmq5FgyAE/D/Lar39kh7GgLB7dAVtJtOH1dHZQj73cyJ6ok/VuyQY
X-Gm-Gg: AfdE7cnch0+M0Yo5Gir2ZrT3BhD5X1Bzh2lSnBdy/CO2Niw3r8OfFtNB0+Aa+eup9ko
	J4XgZ7NP0kpod1VFwMrI+DeLrFObLZxSkWkGNpxQMWp+CqRw1kNc2NiT0Hd4r5XXu+dkflE+52f
	iqcwayh2WRJxGooRZ4KcL3zJZHFa0TycIZQ8pLYAiypL89uA3LG7cdAjM5MZn6rONjzm1uPjj7/
	7EwtTjhuTM4vPnCKeBAFg82lxeuoe9N5BzbAioySyJkny6fV3k4I2UYSuFM0ZPMpPJ9IfHq9JyQ
	vUHR1VY8k7S4THrniMZuZufFT4gbNJ56gzf1CGVHQxtMTT3imC1drp4P2d67W6rQbtOpUwyG6Jy
	pd569l04CRL4sbMXA8bq6yLaIF50qJkB+jt7A9HIoOaoHVGmRlAFwVKXq0V5cYJu9b5ZExjlZIM
	XKlZqdBJe3YwlqgZ176YSbQADvDEpK+Iq3fX8dQI8Q98uwP3yWzFbAHMzB0xSIZI/viV3shXA06
	ehjD+eSODP3Ix0arpJnK7nHcs9bBg00nhvigRlSZLS7SaDA1BFlc3q5NcxERZ6Bt2wcPopgO3I7
	POsIlbbEJ0oejfID6F+6AO0Pt1dVHW09cL+77nGXFUO8DsZyEzkSs0WeuygAlF9wVAWtB4dhxPa
	2WMAeCAkMZMhDFQh7c4NsFWgppLYVSf+JXw==
X-Received: by 2002:a05:600c:3e86:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-493e68316ecmr30972775e9.2.1783521957530;
        Wed, 08 Jul 2026 07:45:57 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f294b3sm129329345e9.3.2026.07.08.07.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:45:57 -0700 (PDT)
Date: Wed, 8 Jul 2026 16:45:55 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Stefan Popa
 <stefan.popa@analog.com>, Julien Stephan <jstephan@baylibre.com>, Ivan
 Mikhaylov <fr0st61te@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Kim Seer Paller <kimseer.paller@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ad7380: add missing 'select REGMAP' to
 Kconfig
Message-ID: <20260708164555.0000602e@gmail.com>
In-Reply-To: <6d8c6b4b-89b3-431b-a31a-11de654c2901@baylibre.com>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
	<20260708-add-missing-regmap-v1-1-6d424322e3d4@gmail.com>
	<6d8c6b4b-89b3-431b-a31a-11de654c2901@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jul 2026 09:32:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/8/26 12:34 AM, Joshua Crofts wrote:
> > The Kconfig entry for the AD7380 is missing a 'select REGMAP'
> > parameter, causing build failures.  
> 
> This one has already been fixed.
> 
> https://lore.kernel.org/linux-iio/20260603134955.2f1d5ede@jic23-huawei/
> 
> Suggest to use linux-next for development so you get both the fixes-togreg
> branch and the regular togreg branch.

Ugh, my bad, I only use the testing branch in the IIO tree.

Thanks

-- 
Kind regards

CJD
