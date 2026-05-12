Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816C4D90AA
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587526; cv=none; b=cod8RDC43lwuYr8MLdNjVNrmFWOZ06VDSDS7hVVYM5l7ZS1FG9cRmVSYbWrpRpV+eHFUN7Z+altzmQN6rPvisxAnsr1zxSXXPfUeZwtMKaZSgswRrRQrPQiy6UgFidglHrDanZOqguMY0shr+0FNXpmHlex6/eZQeveItrCubHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587526; c=relaxed/simple;
	bh=eiiQn3LPaQ1C0TSaD+je1ad7MkAQEuJiYrexYHR8JW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFx+QLmBxbU0PuWkEd2z3+VRR/BMfbUR02PlJDN7PZQkaRp2ZDmNj9yFDY6VbW0EODarBIz7AGtrjtagGIBBkkEXf1o7MWQ+FlzZNu7A8tp+oDymiOGyTqFoFPKhUa3HEw+7ovg4ZeXb2wLjV/e9oiZhfYhkz3HoZ4DsMhYHfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG+HTSV4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG+HTSV4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48374014a77so50163695e9.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778587521; x=1779192321; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MPixCwLYwSCQ7IjJ5OrD8u4Z57ctKq7410nlp6rxWgQ=;
        b=EG+HTSV4JkPS3hTqHjB+yt+2e+0nzu+OuRQI95huriZbSXg2R2D6Tx5aZDlNrwPJvU
         SKK9Yh2q15m2Nnvi0x6TgxU3vupDmFvZZOrBcjYoMnJTnUfohr5mhUiJ/qWziCI2i0uW
         3olmrnHEDreSZzClwTG7ly3Q60/mh4sUGZXowJdDw3NP+A0EcKrmS6dbqCmXhDkBV9ZI
         I2Tfcqv8rC4cy50GfBXnOY+ePaTMduZgGTIqN8XKKmqgwnt1sW+ZTySYNTox3aUIoDVq
         2v/Xl7eXkcLxgdmDIqVlTV4pmoe4Q1Ixtn+fv9UTqOue/nYuDLcYu3psdITUkSgsdxl0
         BP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778587521; x=1779192321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPixCwLYwSCQ7IjJ5OrD8u4Z57ctKq7410nlp6rxWgQ=;
        b=YOS3uVeqGfLaJoNnbIveu49C5SQj5V6XNnwJbpoZms3p+PqEGkggNw4KFyjQfrfmSm
         nOUPOZPpBZTbsC6OEBarM6taR5yuOyRlQEpstnZ4chJsF7T8UiO2x31/FzvTMBOR9faz
         lDnrh7rBC1mn4je4CTHU1uSAwS55hH0tr3Sre33qLKDg+INjDCCbxyqIwpx+NNTard/J
         PL4ZJ6TC698r0qS7M+cCKpDXCRB3Fcso1BfisVD7eFrAIYfqxnyos4O3RU5KOBuv0aqw
         TGi3JLheInZ0hLMY+F4h+vBcX07JuKx2/PooEIlqGPI3KdhUpKYKwTvoNigaT2qUduZT
         uzcA==
X-Forwarded-Encrypted: i=1; AFNElJ9vxyYw2//A6eKtHyvIUu7O1WjyUGHUFGmfDLJP+mEbSo6d8xH3ajtjx+P0ktVR6oj6GzxiXp7bmHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2LjC+ScXnuulwxUB9UZ6HQYIHzOsAhVzCH16SgCps5I8Ngk3
	Vzy8pvFNjsInK5H9EMqKXgCIPKUxc+oo1u8NjOEhiFV4cmGtkVFtn5ByWUBwlQ==
X-Gm-Gg: Acq92OHSghuZdKUv1DmEsBf0sTj1Q2im3nvjQ3ifv69bgfnxBBoBhMY1BuJTgpivSuQ
	hUGUGd7YsIkivfZOz33FPbG1p8cc9ILqSwDJN3s45hepfqxeQ6bbS7qhdWcVG9RQFym4tz8y/Lo
	8bj6zy5r0zevHLf/rdon4OADuBiuma8MfNyxaF0Wc8Ebsprq+x5y1uZ8DCEj85h3zlLoK0LnhpX
	sfpOv+kuCBV6ZpuzqoV+r50SMTb19IryvLvdLwVwzGFA5rwLkauPS0/HsyS9M9H19KXzQ+4zXsZ
	U5wPWC3ZSK+SUcc7VQyY9abo8gkf9apKy2+b/D2pe5rm8nALxYmoCAtar3jInOsuaQkqqlRQnbn
	8xkR98mGl2/EBZCNqD/eY3lDRZ3M4wgB6ix/8DCCiRiHHjQ2HzSsApEWogy3IoNUSsnsL7QW7V5
	9rqmYsM8YEzpgF5Q==
X-Received: by 2002:a05:600c:4f46:b0:489:e126:b757 with SMTP id 5b1f17b1804b1-48e707fbb13mr229757235e9.25.1778587520803;
        Tue, 12 May 2026 05:05:20 -0700 (PDT)
Received: from nsa ([185.128.9.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f42a845sm15997055e9.20.2026.05.12.05.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:05:20 -0700 (PDT)
Date: Tue, 12 May 2026 13:06:14 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, 
	"Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <agMXiWA39tW9mZ2O@nsa>
References: <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af3oezNmmBhI4Yu4@nsa>
 <SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af4LCQiqNaiMzFkX@nsa>
 <20260509154600.02e2d11a@jic23-huawei>
 <SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <20260511121820.3be9e635@jic23-huawei>
 <SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <agLhb-S2ISSjaopc@nsa>
 <SA5PR03MB837758532C0007A97121F6CCF6392@SA5PR03MB8377.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA5PR03MB837758532C0007A97121F6CCF6392@SA5PR03MB8377.namprd03.prod.outlook.com>

On Tue, May 12, 2026 at 11:55:21AM +0000, Stan, Liviu wrote:
> On Tue, May 12, 2026, Nuno Sá wrote:
> > > > > The current approach presents it as IIO_TEMP since the chip outputs
> > > > > coverage (using the custom table interpolation) via the temperature 
> > > > > result bank, not the resistance bank, but I agree a new channel type
> > > > > makes sense. Should I create a specific type like
> > > > > IIO_COVERAGE_PERCENT or would a general IIO_PERCENTAGE 
> > > > > be better?
> > > >
> > > > For ABI purposes we don't care where it comes from.
> > > >
> > > > We already have some 'ratio' type measurements like concentration which
> > > > are percentages and similar to those I think we need some indication of 'what'
> > > > is being measured given it's unit free.  Hence IIO_COVERAGE_PERCENT
> > > > seems the better choice to me.
> > >
> > > Understood. Will do that in v2.
> > 
> > I do wonder if a complete type is what we want? How will we present it?
> > 
> > in_coverage_ratio?
> > 
> > What I'm not too convinced is that coverage is relative to what? Well
> > it's a percentage so I guess we could not care and leave interpretation to
> > userspace (to know which device is dealing with). Still I wonder if a
> > new iio_chan_info wouldn't be more appropriate? In this case applied to
> > iio_resistance. So something like:
> > 
> > in_resistance_coverage_ratio
> > 
> > So it's clear what physical quantity coverage ratio is affecting.
> 
> I still think a new channel type is the right approach. Consider copper 
> trace sensors - they also support a custom table, and when one is 
> provided the chip outputs both a resistance result and a temperature 
> result (the interpolation output), each in their own register bank. The 
> current approach handles that with separate IIO_RESISTANCE and 
> IIO_TEMP channels. So, for consistency, if we use a chan_info 
> attribute for the leak detector coverage output, we would need to do
> the same for the copper trace temperature output. Since IIO_TEMP
> makes sense for the interpolation result for copper traces and
> because it is a distinct physical quantity output by the chip, I think it
> would make the most sense that leak detectors follow the same
> pattern and create a separate IIO channel.
> 
> What do you think?
> 

Yeah, makes sense. Jonathan already put it very nicely for the distinct
channel case.

- Nuno Sá

