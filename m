Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2252225403
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789789588; cv=none; b=ChDA551es5o9KcaaMI/FWS2joSWyCGohC8SPxri/x0562lRrmkipDQEjr9y7dQDDdbz/UZMdSj+t4c41Lzq5C91jCFqF1YajFeP+QRMH5W7AQH97N2C1zgcc1Bec+MHYKfqq0gtddBn78wjtaCBYF66VOXW/IXUbdhIhmWWIQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789789588; c=relaxed/simple;
	bh=fHoduSfqmeHU5vnirE2APiqfMdBihLmLNXcPHXFuxyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/bKpt/O0Rcz3DRbyaFHY9T2BU8LgnVbC8Ik0gu8buLeAxBMdMZNVThGJt99ok1grUPWxWhxo3h7CEcAGbVI1iVrtoOSA+4TqquUtW3a3AY0jOAT+88yrJqwE6fQkD0atDD8TxVvAPFyBvOoKM8T3p8Bhr33L1BjEmO2yg0gm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMt7HpIH; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMt7HpIH"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43daa8f4so10061067b3.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 20:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789789585; x=1790394385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kkEWiPdkM+yBWXXqRxoSdmIjUeqUoHdebZ7h0q4+WKg=;
        b=KMt7HpIHhl7BWzKbeN/pe9ncuijW0RX+rPxXTHgWiRNS44HjWnMKU9UOLLbOblVPNJ
         XkTk8GRja1LzkTuqoouR6kWrIXFWqhHsmq57p7Vtp/Aa68Fon1HZE/Nr25BWHc58wRZL
         9cjWcIPxDo7e1vIHKe6HRrDH/4SaLw1j2XhTXfnSbrTjz+p/4YbEaQn90KZoqL+WaklO
         qQu4sGPuZnpiGI+XFVEK1vkRq10xav/pYOGJxd9MwbBYl4JDl0M9GCVZvHhhOiNz/dqs
         0zjLu/DzlvtZBML+uKdCmfJhq1Yrwq0B9pCqtYfVS+jutyrZ9x2BHLJLE3cYlHN6Z9gt
         SJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789789585; x=1790394385;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkEWiPdkM+yBWXXqRxoSdmIjUeqUoHdebZ7h0q4+WKg=;
        b=y/TCHP82ekH0cDZUxYPZIYAnXMYJg7q+dlD11tHw2OhHUrIqN0S9J5sUGaRK7vSf4m
         C3NlwWo2jRnC81NXbOaejxyWt0tvdgyydfw/WX0zyeCyTq57y/suUqAwDScuM97vWCqh
         U9iIZuWxkos2z2NryaV2gykJWQrZOujEfF+/WYGKX1QK4uUULbqUeOITKhfgO3fu+MLU
         i1Vnr9jDvEM9Q5Kz43DYoeD3oxFVp0Vh6ScVolc8i0VcQhSdWP7Jy7QbOwNajz8wn/Zu
         hqEqq87117LdB+lRJxDLgJFssedKNxISIMMquNfnqkzJOKsxMH6NJXYIeaS4hUuP1KQB
         UTbA==
X-Forwarded-Encrypted: i=1; AKwUvBxPtbHju25Iyx936MC2FvqLGWOhSUFCSZxrV96ANA1K0USWtiW7WFVKPLFxC39ha9GSLtGA8MrDdak=@vger.kernel.org
X-Gm-Message-State: AFuF++mYDdM/B43bWDDx+TOrV5/QbyQAvSHMv+puJw31xEMM0gCnMwww
	ruLC/bOlx5QI8yMVzIJCSK7rygFUt90t5pXvnHeO+c3HD/oI50PW6EE2
X-Gm-Gg: AYBFou3OOPZ5PsOAMDzeW2EIJMWqX4kXTfH6dzUz8HHxuvzaAnn2qk/uD/iG0QqSMpe
	fPkcSDpgbQxA0hPSw8V3hzhalOccK42WB2AGlc470AcbUPvhZicM9n2t4LtlOR4uvd+hPEkYOL1
	V2QZJWRWYfAyGJwL8stOMdyt/JVaosWO4lgAiP6dkRvC8JMn5d5CL2DFEU5rC/OiX/VVtRbv18w
	/yYzbCNR5XECdn5xaReHlxqgAeaCLB2YkQUgi3+xFXMSp5i3Pn9y6FeiblQ2AgWUwxX4o6X5CSR
	lqWA24L1CJyhOlk1iIXtbTt2n/RA/ueqhKWhbDABJm/6TmFD1SL6f3ZqO3mDEuE8qhuke3hFYP6
	K8pIelkeRKTHBauS200oRi8LMdq5yq9pTyf5bxLlOYHMmWzcnjyRvRr4Lo8/jqVFnwk6+TS6jsh
	SWhvE+RmWxb/q+d+iLUWbnTxyAddpSIINtjdzKIPA+D7nILMOMNN5oSw==
X-Received: by 2002:a05:690c:88:b0:873:5bd1:98c9 with SMTP id 00721157ae682-8973839bd60mr14337277b3.59.1789789585628;
        Fri, 18 Sep 2026 20:46:25 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a480d45f9sm5919867b3.36.2026.09.18.20.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 20:46:24 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:46:18 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <aq4FioMYYiPqlhwS@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
 <20260912013912.51887-3-marcus.yu.56@gmail.com>
 <aqepkmQS_p6K1Bd6@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqepkmQS_p6K1Bd6@ashevche-desk.local>

On Mon, Sep 14, 2026 at 11:00:18AM +0300, Andy Shevchenko wrote:
> On Fri, Sep 11, 2026 at 06:39:12PM -0700, Chang Yu wrote:
> > +#define AS7343_ID				0x5a
> 
> > +/* AS7343 config registers */
> > +#define AS7343_ENABLE				0x80
> 
> > +#define AS7343_ATIME				0x81
> 
> > +#define AS7343_ASTEP				0xd4
> 
> 
> > +#define AS7343_CFG0				0xbf
> > +
> > +#define AS7343_CFG1				0xc6
> 
> > +#define AS7343_CFG20				0xd6
> 
> > +#define AS7343_CONTROL				0xfa
> > +
> > +/* AS7343 status registers */
> > +#define AS7343_STATUS2				0x90
> > +#define AS7343_STATUS3				0x91
> > +#define AS7343_STATUS				0x93
> > +#define AS7343_ASTATUS				0x94
> > +#define AS7343_STATUS5				0xbb
> > +#define AS7343_STATUS4				0xbc
> > +#define AS7343_FD_STATUS			0xe3
> > +
> > +/* AS7343 spectral data registers */
> > +#define AS7343_DATA_FZ		0x95
> > +#define AS7343_DATA_FY		0x97
> > +#define AS7343_DATA_FXL		0x99
> > +#define AS7343_DATA_NIR		0x9b
> > +#define AS7343_DATA_F2		0xa1
> > +#define AS7343_DATA_F3		0xa3
> > +#define AS7343_DATA_F4		0xa5
> > +#define AS7343_DATA_F6		0xa7
> > +#define AS7343_DATA_F1		0xad
> > +#define AS7343_DATA_F7		0xaf
> > +#define AS7343_DATA_F8		0xb1
> > +#define AS7343_DATA_F5		0xb3
> > +#define AS7343_DATA_FD_L	0xb7
> > +#define AS7343_DATA_FD_H	0xb8
> 
> > +/* AS7343 FIFO buffer data registers */
> > +#define AS7343_FIFO_LVL		0xfd
> > +#define AS7343_FDATA_L		0xfe
> > +#define AS7343_FDATA_H		0xff
> 
> Please, keep indentation for the registers the same. Also would be nice to have
> them sorted by offset.
> 
Due to the register layout sometimes registers with similar
functions/purposes are scattered across the address space. As a
compromise I'll group registers by purposes and sort by offset within
the same group.
