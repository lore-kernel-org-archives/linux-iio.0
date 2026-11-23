Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795431285;
	b=QmKM5AL+wrFkkYX2qPw4VzAYDG6noKEgmkrnCyVZp7sHFyA084UOe6+Bu7YbghZcUTfS
	 YNOvaOB/drdU0+Aj+iTXcFxiRZy3afbRP/IumnjfLLQkegqDN1D4ZNFO7nNN7TvSsY4NR
	 t7RC6DGQINALViYC9oFfw9fe6eUOOuqHr6efQy7L5RgecLdhdke6vM3xLuU+qrt14ZcPj
	 NjcPiB+FrfsD79RCFLfgOTOO/4XdUW6KScTzxJQ45TpTH1VclqbbW4ywjH1CeOOFOoseq
	 mU+LUsWUBTTy/RRajahhRxhneWd07XfGqBYzD5/BGK1eCZp4REtxHWN/VIeUuFl5eYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795431285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KCyyvoiSEyd0eyemfSZuFH09Xb5bgsjks8Lk3a1B1RQ=;
	b=kzevN6v7habedkjeyd/Ql8GacIH9MtFBGOfPoGdS9zLiXmGJ4FjJUGdLIVAxK0ImiWeR
	 LQQzt7qUnwKd+K179GILoIq5exHmx51GF+arJLcCJ8V8UZ9mtye/NfVQgi5Z+mPcDln2X
	 Id/Ck0jQ7TSqqG6Piin6HPo5l+dHT9H7CfCZdguQZ8D4NzkTTH2IQWyPHR4HD10mEjlFd
	 xqudHejaDiV3xXpIxRdSI+WX0Gl8osez7ZVjuiuczTnXddf7AtT6L1PSVI6/af8+i5vH3
	 HQKs49cbis2b8W5xnF0ddt3On+bpMNTUqYRlRZ8wCSTM6yLcHLsStXTxGysBXOChzKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qRmi0yoQ;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491F606A31E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 10:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0491F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qRmi0yoQ
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d581da0aaso407749066b.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 02:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795431283; x=1796036083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KCyyvoiSEyd0eyemfSZuFH09Xb5bgsjks8Lk3a1B1RQ=;
        b=qRmi0yoQ+uzCzxotO0Ibh2NIKm8hjU9kqCxqPpYHpCIxL4z9fDxE8e0i4qw/EqrdxM
         TkPtMZB0BeTOABui0Kj4V630nrzM1IxxaCGeT35QLWy8XGbMCoLM2Z17ZvKME7f88h0H
         H1dpFsTkYcD7uvEv0lrYm1gFZL/rL6ssmxxDYrx1AfZuSRynpG7p5/NmuZOIfNhixci5
         MSr0GZOLsR+4zZyX1g2QXsQVOiexoZ6525O3ZaEKKDAW1lIv2XdSy+UGXA6wVr0uq3Zk
         3K/rt6M03DBv6OIfFfH+62XtrVA8rlJzj2sTfbIoDAozEDWFf/lPemyIdDzhKqJvYYrl
         kE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795431283; x=1796036083;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCyyvoiSEyd0eyemfSZuFH09Xb5bgsjks8Lk3a1B1RQ=;
        b=euFB2+aUD/oxI6aJ2qJ+T5uZK9CFbwvlFY+tgpFsr6JBccxpWDmRCulfrPHrvAj19y
         Mxzhrh52PkooTlrn/u/xRgF8K2doTnSwYrhy7Gl2f2HNG8afUntB9KT681d2JXZ/YKvR
         MOcdPsPpL7/pXh7KEErQv9QqQGIRnbALNrzWj47TohGx/ctmQdM3TNdG7izg9wD1BYO4
         4EvM8l5Rhq2bhCaxRS2yDInacVw1Is50JoK4E3KN922OM0m3/fhvCDdsw2ASDZXUnQEt
         J7gz871FqSfPR59ODoXaCt3kk9Hqlb5dtC0RGdyg0SslEZHHbmfjZAAHYujczBsJa9x5
         UT0A==
X-Gm-Message-State: APuU4Z9gtKjIeWVISbQeIcVD2u5ZjeXYCc11XHALa1kY695FCNoU9Zjl
	/qRA8P2QQSI6vMWWmcuSbAT+v7V906wPQD0fQnX/+IvLhr7ci4+amJkoOquV+A==
X-Gm-Gg: AZFdTZfokMRoAF+++oHR19aPagu/MsnRhBH/bzDEU4WfChw1CuIKWjOZV5cl4wiaLvj
	x3vhIUeqIaWyRTWEgyBb/stcC14vcm/ok5Dw2RJw26iN/6KX6psa8Vhbor/yxclT+VnEMUFtIRD
	ENzpdg7+YE7IiVdNOVoILIIAx3k33d5GmsJFCiQb2/XiJBBAqj5InBo3rkZPGbVYfdcgJGrm3YM
	vavfAvJoh0k0MEHR0T/TTyEm1D0orbtyUU/Fv2TAxHBBoEBJor80W4uByCtjOZSlB/Wfc76yWhh
	pTZ7rUyO1V8H/ZnS0GCPk0uAEl5ZD5bpHjOL3HxgFVFsa06qbFe1QfeHA9zb5zbf4YMcCksi29j
	wCLB2ZWJE8Dbaw55f8NK04XYC9PpC5FYPHDqvbUoFNZgkZJlx5ZxKa+jnZ1W10E6ltUl/rDjWCb
	YXoQ4ZtyojotzHh55UN91G9DrclbsCJLTbVTtVLbhzigXsDuu43O8iat59I+mI9+DPnC9JM5cCb
	mlDJoI8kntH/LVJdqw0ddFFq5R+PPp8S1bNxYY9DSZ+7FlxbdQTpN+piAzNdENvZXj7MiB0QrCk
	hPZFxqeqitpadJB39RTw4ZKdnOfvLDpOWiSrdIKbnXXKZjEf2AogYlshAGy+14CLT27Vkzg2aJr
	HDp0id+/rCExak9KOm7/sSDzHZyEr0g==
X-Received: by 2002:a17:907:c17:b0:c4d:31ad:9dd5 with SMTP id a640c23a62f3a-c513ac86e26mr918793166b.42.1795431283107;
        Mon, 23 Nov 2026 02:54:43 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc73d3sm384468766b.64.2026.11.23.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:54:42 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 23 Nov 2026 10:54:37 +0000
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 0/5] iio: split struct iio_dev_attr into typed core
 attributes
Message-ID: <xx235ezl6b2hopaaw6cb4o4rmz6tqumkatnhcg52sv3ooebqtr@klqbvsrlecl6>
References: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
 <20261121013907.5e15d2b1@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121013907.5e15d2b1@jic23-hlaptop>

On 21/11/26 01:39, Jonathan Cameron wrote:
> On Fri, 20 Nov 2026 18:03:56 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> This is missing key thing for an RFC.  Sentence at the top that tells
> us 'why?'  To me this looks like nice work with no obvious outstanding
> questions so not RFC material.  
> 
> So unless I missed something, drop the RFC for v2!

Okay, will do. I assumed that adding the RFC tag would make more people to
engage discussion. I thought that messing up with IIO core and introducing
an internal architectural change would require that!

Thanks for the quick review! 

-- 
Kind regards,

Rodrigo Alencar
