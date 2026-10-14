Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530DF2264DB
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966547; cv=none; b=lfS95PP5HVAO2+eOECFcYvjVCcWHi6P7dhfiKrV6ovk8sss4uEVkUbj3D0W9607yZtOk+8I6WLImFCGe+Wqt9uv0w0RBpMYsy6CTuzZC+1yLOZ76eWt3Rc7q8DVtIn0mZrTR9cfmCXok8fSTOjzYga8XccMwKNiKQh7HrJKBYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966547; c=relaxed/simple;
	bh=K1xTFF0dZvielDw7CPdKjT3Dos7Fsn3aW1yWLZaKQb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3yVbz62v1BUXywJnBKbZORWzk1wSTfEut7/Lmz2KGzKYxLhNcDEiMHaRFGxWL7s2zpnerOlmE8VERr02eNqVl9cYy8XW6+YnQUkkh4K/NvZl0p6SB9vpf4pmO2CL+2u6dSLgL2hizngAhrV1A+i78/qb4OvYpx04R3DIINllD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgFed68e; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgFed68e"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48af27fe287so236021f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791966544; x=1792571344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ONOYFUsExbiTAqauGcHDMWUDVRV1mSLiP5XphPmFoUU=;
        b=EgFed68eXGL3coPtaEb352qXlKG2T+5+8wH2QxfE0ZOieJEb46OYWjWxsO/ulYoO+n
         JsOKRntrefw1bBTbd67DdSJuGQQAxEs8ZwMhsEOdh2+0kSWvcAGd+3GHGunWJ3FQbQEl
         oXmLskyPmoGg75x2/8Rl93C+kuv8xDSGvVv3tddKMtDByA20m608mw5fRYanSYfLmEeV
         KX/s/0d3m77q69uOAx10yClZvPgh8lTKmkqJT9y68ncxw2aRm987J6e2w5k9v7SZDjtP
         f0gyO3WyIfFW3nrYbc71jxZL3sf5ltlr+JgmRoHMXRGiX0cn937IPMQrRGkciLorn3Pa
         o9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966544; x=1792571344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ONOYFUsExbiTAqauGcHDMWUDVRV1mSLiP5XphPmFoUU=;
        b=s8+eXCQR+cvrATrM/TuhB3vmfFj7B+xJw622E0AQC1zd2yYdZwq+wOXbeD5kUYal9J
         U+JWCl8MAkU0NI/Oazt3EqKVBItVCD+WtoycLVf1UXDO3p8l/teJnHHyyca//RMVmCvk
         8RhWT9ludY8/xlRhiJGWE4tKzstwDVBrNRLjmzo/oWs1LDaQ4stR3/4wOvXabBGPoNoV
         43Ihmcw9H5RCdq5nrdEpm3kjT7CwYI0BJ5wH1Hk4C7KDzRR+pPNFly5Z7pQF/wykyyM/
         bkWKWzJa3CBb762DBvUhTSxYTjR6uiRPapoQ8i+MlSRHyaGdY9fn7H2HfWO2Hrxao3ng
         8J/w==
X-Forwarded-Encrypted: i=1; AKwUvBxr1eKmNe4iR4QaWPtM7TrpIfD+sn3+Swp/FhFJSxSdh6hKJlCjRT+HU/zpkGUvmXMqRutkTb2bRvg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6/id9ErawyOUn8cJ8XYOT70oES9c5/GAc9HSWgwVL2ZfFIwI9
	YV24zn0DR5eZXkyojSpknsc7JyJjiBe8U5xqTP+Xlz8oUpirjHi3Xfjl
X-Gm-Gg: AYBFou1FYFpdm3BuPJDqFheM342j+Co3Dyj+GgiLg6l68DWxxzetSgjzy65pxXNWuxp
	aetP6fbV+j+LcHnHif5hFS1LS77HLyp1/xHPx92zVud35fFv6ALGaDqXtjltZFPa+832ehbbgKU
	+zeqwTFh6hJ9pF+XhW37wvbFCrHrIMkUNeZT32BLhiQsfLVI3xbfm+MOhG7DogV/hQfXif5h+6v
	jmGyaxx9srKPhHIhqSK/sW1YqJV9MvTVuhV7G+ow/STEX07yvj8e33asabT//8mX2P0E2Fu1tCC
	JnSy7jhZRRWaXD2II+EEP0BFtnrcJTGBaIxE5rKd/isJqom78xYzUuWnvsiMz8EepqiyoOq7ZDz
	I4mdOr3nbNz2z0CM4x1eWiJqvpt/7Lu9MblUtbUvjk7IJWT8gkmf9uq8C2v1pgLW0IKYCHRzGMk
	uFJUNwRJS6k7qvVo4uX0YAQtmqvFGl1Jle01L3DB43RFXIp8W5AWl8S0MbCPEJEOo1Tps=
X-Received: by 2002:a5d:6443:0:b0:48b:536:c93 with SMTP id ffacd0b85a97d-48dbaae36f4mr21674351f8f.30.1791966544421;
        Wed, 14 Oct 2026 01:29:04 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:20a4:7be9:4762:f55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48ded185de7sm1899715f8f.31.2026.10.14.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:29:04 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:29:03 +0200
From: Jan Remes <ciakval@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>,
	stable@vger.kernel.org,
	Martin Triska <martin.triska@mycroftmind.com>
Subject: Re: [PATCH 1/4] iio: light: tsl2591: don't divide by zero
Message-ID: <as89TxIwfpw7x40g@mm-ntb-00805>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>,
	stable@vger.kernel.org,
	Martin Triska <martin.triska@mycroftmind.com>
References: <20261013143943.436816-1-ciakval@gmail.com>
 <20261013143943.436816-2-ciakval@gmail.com>
 <as5zy1LRyE5hr6vn@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as5zy1LRyE5hr6vn@ashevche-desk.local>

On Tue, 13 Oct 2026 21:09:15 +0300, Andy Shevchenko wrote:
> On Tue, Oct 13, 2026 at 04:39:40PM +0200, Jan Remes wrote:
> >
> > Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
> > Cc: stable@vger.kernel.org
> > Reported-by: Martin Triska <martin.triska@mycroftmind.com>
>
> How was it reported? Offline? Off the list?
> Otherwise we have Closes tag to point to the report

Yes, this was reported off-the-list in an internal report at $DAYJOB.

--
Kind regards,
  Jan Remes
