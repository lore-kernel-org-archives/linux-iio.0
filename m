Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F4437136
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695956; cv=pass; b=PCKfjMOWTvq7VWUACl6ZpwhcOk7PBRKKsoY3wsN9Qb0C+j5MDM9VTUqFSFrAiKV2/JIqwLDbao8Z4hjljFIOo7napAg6WDGg1m4gS/icUxX8DStgQSvuefHKDi96JGs8MKl56dcthiJE1rYv6oKYb4sKEjJKzrHgCBSBh4iCndY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695956; c=relaxed/simple;
	bh=v1BNryYn9UG65SmucsASVajlh7AWj3G/tejH1HYOSXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4/DpNgIw2ujjnIw36PyhYy/VNjgc3oDdH+rAX9/fVg8oLniPoVXvzfzIiW6b254g7X0EXPF7b05iOuAQsSjesCqgza96RwQPfMDD6SmfJEp4n/RMo1xoRadAOujdNNKhioKqeuX/AkUoNBwxconfFlBmrVOXY7Hq5vqCHwS4wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHIcD5/n; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHIcD5/n"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f703a9d05so491759f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 01:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786695945; cv=none;
        d=google.com; s=arc-20260327;
        b=jt8eMLroHKEBnYX3sfHZgF57H2GCelL4888KzcEOR4s0AxfZV34GAcS4VIRzUl8QzZ
         fza1funDLxB5qHGrgtJDZd+1kFFs7pBCKy0hf+vHpuMY6Et595waJLiQKhCFZzFL7pWL
         OSGhjfi+93wuJgN7X1g/wyI8lxPrWqH/JWgjci5/F9NQXdGKMoJUjOg5bn7dVV/jEOE0
         ISsHFXUvMfxHqLFYCPeaKhN2ikGFAElGpY/uqSAIHCEgaxjFkdgF97iAg3sI9miFxTs3
         WAFqytipgMuZTUoxRkyNx5Gw328RALHLvVjD+WJAjhhYnx7Vj3+hq/CrpsRmRB3TD1Go
         YRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v1BNryYn9UG65SmucsASVajlh7AWj3G/tejH1HYOSXc=;
        fh=COOJ4xAorLzdrUeEWHGv+6m6BgzpdlAYNmnm/zR8N/k=;
        b=hx/UfZG4AmuZ2VoTV0d8qNqlT2gBcYV69p9YOKUjULOUeE6UYX13yYM0f1LiXQ2aRN
         0kjJUEljtXVLepgNIUTkynisyqcrVPH2Wp4wTZBK71b7s4quk0ch3hhi0aHxG6BEYE/E
         fElRcEeEwxU8aSxug/zra1FCm6Y9ITBZEEKJnTWcHumuThpORAe5CHX/cNpNCxU/LhHw
         0leART656SAl+5/ceWsUD85WIWy/k3qCkoaCYnw5FTFdXSpxBGlGG51/BIze31xrcOO/
         pRbT0Pz2qgR9zoAL+O5H18kSdxSx0lXezGlIdEyw88ll13T+jaOZCHFtoDr45FJg86Uc
         FaLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786695945; x=1787300745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v1BNryYn9UG65SmucsASVajlh7AWj3G/tejH1HYOSXc=;
        b=JHIcD5/nV77+L5+9kJZQ4KaQRvfeHc532IGX2t5OmKXA8zsHwJwl5TT358JLepGkvF
         FPe2nN9VcyO92M9a5okQbcTBuNjNRLDfduatSk/w90wC704h8tTKU1vdFYoYORynErbi
         MumL2a3//ei2LN9dyVAfCEknKsROgjddPYRqFQJJAawzb4V+F6McS8UMdQSFcqR0rUB1
         P8et5iSx0xi33nhHtvQXQAnX8uRAY+iSmQA+VnGbC6gCcVTU3tUUKrSK5nhi6vQCRzbn
         wXp+17Lk3SWLCTZs073TQHcH5cYUJ+AfsgLYsjrSz2///MhxjBMfyygcbe8Dxiv42CUz
         uWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695945; x=1787300745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1BNryYn9UG65SmucsASVajlh7AWj3G/tejH1HYOSXc=;
        b=jvolSeH0LklLTMJKbFF7ehE8o+2pEEcY4ivXwcUszenWaN7KbnGSWEfVY37ym6YqT8
         g2BHWthVzMv4B6BxEux4nzhRdOhnKYSDRS9yRSK3yfN0lzeA4uNKBxnldtDJXYC6IZQ5
         lPSDVwscoR1emxsrTJPIz0OfsLrRBpVNn2HzknaMZTgfGxUHNdsUOv75zMyAKOK5zgjB
         Mwt1JHlDTsa8kCOWJuZBwVyujBkw71smqot6Oe0I8eFtByKQemr6AjwkXcUm9mwvSd0F
         r+jMJJP4H+MiE1rFiioTfWgGA8g9A9EAsSf0kE3wG68fEO2Ohywo/YZm/sGCNPy3I7dW
         nXVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrCycLMAgP/x/HfuMSV1B2QJ2URz4DT2llAPv22HrQfpUQ1e9Pty4p296CJGuEG2cZjhHSNrOEx8BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQA7s6bVQ4ZxKvuOVAojCwhDbg/ollFyozMptp0933Zlfrr0BE
	/Js0kKJRJdNaVuFchn9YNVkpLcbK0Eo13Pk/eOglxR5KptKaiMBsWA3PdZuRZ8kxHHEvvjOLtG8
	8QuKlWNboYf7hKgyHzvZFxxhd8mLbggCQ26MKLBk=
X-Gm-Gg: AR+sD13I4hjW5CiUR6uAYp/lo8BzRxJC4Whv4PKeykwjVscYG27gjfBbaMLwz9qAsk5
	EHpNCacIMPbQFOTVHlFJR+bqnI8h/os4M742kKPXDkrad81be+C35m26PLMZc9eGDnKi6NS5GNN
	n5RA3OcjNQg2hlFeV1nMQipNALK0CS2wl0MR19p7yO9q4AsUZZian0mbvAhemNBxDd52j9ie19w
	VbleoDRFWbOMbNg9gcUwKWLraO30sSu7jokvuCKp6CBvlfHo4OFb7O1W9RGYmEzoc6Whocc1lTY
	AsOko6Whxq+f5NC79cwInwFbSKKrQYO/7QTTP4YR/ffD2nc9bjl1mkIZ64hDcHjGl4ql+BpzQFj
	hs+CGV3EGcTQUOpyVyjUe5m8nfVVdhOMMD2l5cbxTuuMZqU0hZwUetywv/ZcarLqn9K/OuqvCU0
	qKnp4KUauVjzuQT1Lxz8GggEeTLD0mSLCFFws/+7dg25HG/opJPuEbhDBAMpRBf+zVrD+J2ZXO+
	RWjUkzTFyo0nhMe
X-Received: by 2002:a05:600c:1d29:b0:499:7410:545 with SMTP id
 5b1f17b1804b1-49987968512mr50359855e9.12.1786695945122; Fri, 14 Aug 2026
 01:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
 <DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc> <CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>
 <DKOBND0GKI21.2843OFKP0KR40@maxwelld.cc> <an7OSM04kiviu9xL@ashevche-desk.local>
In-Reply-To: <an7OSM04kiviu9xL@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 14 Aug 2026 10:25:32 +0200
X-Gm-Features: AUfX_mwJ8JJB8aBhQVa9GYJ2H93YzKzOzpOkx3gTYpetqKuG2Bg3fjqpQ3Vc6aA
Message-ID: <CALoEA-xkxGY9sTeTR3cXgzadp+Uuk3MZh21ubD82kyijo4NN8g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Maxwell Doose <maxwell@maxwelld.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marius Cristea <marius.cristea@microchip.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Tomasz Duszynski <tduszyns@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Aug 2026 at 10:16, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 13, 2026 at 09:47:00PM -0500, Maxwell Doose wrote:
> > On Thu Aug 13, 2026 at 3:47 PM CDT
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Aug 13, 2026 at 8:52=E2=80=AFPM Maxwell Doose <maxwell@maxwel=
ld.cc> wrote:
>
> ...
>
> > > Note, that kernel.h shouldn't be there at all, but that is definitely=
 out
> > > of scope here.
> >
> > Makes sense. I wonder if it may be worth doing a patch series removing
> > all of the kernel.h inclusions in IIO all at once (or maybe some driver=
s
> > have a legitimate use for it, but that seems highly unlikely).
>
> Yes, for sure! I have simply had no time to do it myself, but I have a lo=
w-prio
> item in my always grown TODO list. So, if you do that, I will really appr=
eciate!
> But be careful, the actual patches should care about the whole bunch of t=
he
> inclusions, and not just about kernel.h. This means each driver should be
> carefully inspected in accordance with the IWYU principles.

This will be a gruelling task (implementing and reviewing), but perhaps it
would be easier to do one sensor type at a time instead of the entire
subsystem.

--
Kind regards,
Joshua Crofts
