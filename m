Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A8444717
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038711; cv=none; b=BMlGrIYF6zW5sUgFr+DrN46a4vjdYIrcwsP6sQFZjmQAzx6I9eWEUw68gUZtYrl4nxHRmIPmFtGuZyKXG4twHBqQiUn8j+0l+uswGqbWJDTlQku0NLmP1cwCkoAAfreOM6q35VAU2Sf3bXtY5Y+9O2Qi72zhte/vGJiMrcsOv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038711; c=relaxed/simple;
	bh=0DKG2To6jCVPnZRJ2L+oO8w7P5y+YqwjWTPKkHTL7CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUgukAG7aTsyXlvhEafAG+6gABuHLkaRtf71lgIgE8O3R4gJOlucxXHyFWqMDaby2LFZV5NdGvl2OhNZR6Lil4T6/mCGlfLZPuMcgSQxgcKbqvkETrPm5gYl1dB4yf2NbM00eZGXgC3zbb/QjBCTKBXAN9ph23bYaLbDRo3Nd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCNYjfqJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCNYjfqJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1671ec8692so28021566b.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784038708; x=1784643508; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZB9rfFkhOTFphdLGR6TyG9TjcpFUip/IJVahTcTdLg=;
        b=rCNYjfqJEzBdbv652WV30QWwA2LgBr0pVAD1wzBiaswK7omi9pocA3wJjjcecykjC2
         IHB2Xtqi6vIH5UoMxzAmV1VQs/VWLMsqCpJ/Eh2u3f/1eIIGIFfbOkKu22BvY57YbhPY
         KL3EWDh4ZOl1Rosam/maNvWAUmYChjWAY84LonhCeltJ5qigSq+nqu0jKseqCI3TFmTo
         x6Dlhm80cUzqpq2pIwqI/o70c/oEQWawZQVH/6eBOPWjJFCwEb/s6H/+HdjHSfgr9HK5
         M338OIPwzRhuwWmGNhSzhDzVjs5s5JG2OCDAOf82nzPJd4ikbw4YKjWKEUlMh4hMyNwz
         iQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784038708; x=1784643508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lZB9rfFkhOTFphdLGR6TyG9TjcpFUip/IJVahTcTdLg=;
        b=ZiX2exXG0lzxp1h+PClZEziIpw0227taBtToJj03v/s9jFKkLqZVB0s6xSDwnpBhNS
         gXds2lvMDoN+URCci+mUFBK8ZlXD76bYwmEsb9bZ2iLvjRekXWPhXT/LALLw9X+eOus8
         nr6j51Q5hk5cmF6CswfmPflwt4Nim8ZUxuBtzypzn42//DWwFq7DXOc7nXWZpfYJH2wM
         7UnBbKl3O9JY7OduXsUyLV7kywSP+62+EnmAju2fVVGDUB7LR2svCp+ZtBYtp0MqE7o8
         6+W8turZakOo13hqb/FOYZFDTnCOooGYumLmmryaKujqR8raxzvOa7jPgnKS8gXzOhq/
         x0UQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHggr2265yiyZtAiVK8NvlkvfpPha9o3m3RAlVTOGfqz9MjFFVPgiSJVr3tcOs6zZF+HT08pg9fzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0heg2LNg34FjelOdzx6TnrGZZwcWdd19mj9cGd/NofI3HI/a
	bnVFGtQJf/NOVGWc3IuARTHmsdfCTJjW1BOWw37t96w7xeXqLrgHt5zk
X-Gm-Gg: AfdE7ckqkT3diVoD08pEbLVVP7tA6H8QypRDlzByJI+yA7WydN5MATh+D/88zZoOu8s
	LsOVcFSPN+s8tDaF6VRRKlNrBZw7EzLGJeNqHS95Nl467uL4imEOeRaT5NbpCVTktekzwbhxZd6
	Ici/SVjp5l46Pc0Ccpp6tvGQusE400lk3/T/Gx7NtTSJjkkQSoy/FGm0WmT5d80aGoqopikgvKN
	XRxTicWfHluFkGxL+uiwKk9nmmyKOp7ZBRCqUVV9LzbfUmgezMynjUS6v3lmwvYlS8vBptufN3p
	xie5BDL7euVDw+/8P2V6OSrdlJEtoW5AmHdD8x6adeC24CZnGpJtsfsYOnSpOI6g/m/pcztnGWT
	47TuDgeaNamAYCqgHpHmFjWYgirqRPVfPXjWFWtc2gbn/Df4HTGnv8HmiLat/L9BDhrVanXUkqb
	mBXCTXdS7nR4QlMuWFtERGHo2R2Uc=
X-Received: by 2002:a17:907:d58c:b0:c15:c290:ca8c with SMTP id a640c23a62f3a-c161f58f09amr573359466b.39.1784038708083;
        Tue, 14 Jul 2026 07:18:28 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15deea5cf6sm853090966b.16.2026.07.14.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:18:27 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:18:24 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, jananisunil.dev@gmail.com
Subject: Re: [PATCH 3/6] iio: adc: adi-axi-adc: Add support for CRC
Message-ID: <ucrlt75xiwbv3rrc4gvgdop24u54eizhuqzf2av2qsa6ceymdp@kfkuiwuvakhl>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
 <20260709-ad7768-driver-v1-3-44e1194fd96a@analog.com>
 <20260710014617.323acf6e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710014617.323acf6e@jic23-huawei>

On Fri, Jul 10, 2026 at 01:46:17AM +0100, Jonathan Cameron wrote:
> On Thu, 9 Jul 2026 10:50:14 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
> 
> > Add support for enabling and disabling Cyclic Redundancy Check (CRC)
> > processing in the AXI ADC backend. CRC provides data integrity verification
> > for high-speed ADC data streams, ensuring reliable data transfer between
> > the ADC frontend and backend processing systems.
> > 
> > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> The 'other things' I found bit from Sashiko is interesting. Far as I can
> tell it is right and [devm_]mutex_init() is missing for lock
> in struct adi_axi_adc_state().  
> 

Ouch! Yes, I was also wondering about the lock comment.

> Nuno, looks like it was from:
> 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
> 
> Which indeed adds the lock with a mutex_init()

You mean without :)?

I'll send a patch fixing it!

- Nuno Sá
> 
> Jonathan
> 
> >  static const struct iio_backend_info adi_axi_adc_generic = {
> > 
> 
