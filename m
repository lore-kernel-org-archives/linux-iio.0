Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5173A4F34
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268489; cv=none; b=PiUtZuQjRYjLH2hy36Y2smBS4jBbh6Ad1XzWFNabYhNoX+SOMLJ+ID6Imog5t4yyHsftvc8AsVirbIrYXgITxCHTkFWWYcnBRFrBfZyTXiAvlTAEVUFnOW3MUYAj3tDoGvlTxNV6VlJ5rJ7x2PEcS8AeYjxtiyphmbLZGejIidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268489; c=relaxed/simple;
	bh=Mnb5jQDMmmDKcsAgTmtSwwQpbHnknHyuvUA6EP5VPUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvoPpg+pcHAGIhe717zozkdbMeDPb6e23V4Vp4xDIJ3zZ32N151P8vft7xeBLgCxGcCJ5D86J1tqD92JJ6hBEZclEOFgeYtgGc+L/Hc0LUZH1SXJy/x6mXsFU3CcyxigJgdlP9UTB5mABjU7JfdNp9t8WbFjR+/xkN0D8ZSM09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVtqBVaD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uDgZYt13; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVtqBVaD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uDgZYt13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785268487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V+jyHiNy79/J/hkBXzj6oSKA3bKerUWbLvWU40tpTYY=;
	b=aVtqBVaDn3aMHNB/TuLkgRe3zMi8p7M+yYpu/9JxwE3hpGTjLL1cHSHH8fmJqL/47lIArK
	g6GptcW+3YGYPPQo3qAsZdUXh3S7BH9phTNbor2PBqCj95vH5Lyjdz3O7q2p0dpwr+S2kB
	XxxVmlY25RZc26RVtai2lYQWaHN9H9o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-qHE2aMTeOwm3BYo8MC8JfA-1; Tue, 28 Jul 2026 15:54:45 -0400
X-MC-Unique: qHE2aMTeOwm3BYo8MC8JfA-1
X-Mimecast-MFC-AGG-ID: qHE2aMTeOwm3BYo8MC8JfA_1785268485
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90410c668adso2414796d6.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785268485; x=1785873285; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V+jyHiNy79/J/hkBXzj6oSKA3bKerUWbLvWU40tpTYY=;
        b=uDgZYt13rIRVIF/Qq2nNnfF3SpK8zlpy/QvBikOdFUjvvZUH0bc3G6dAjpxrxUhrjp
         LNkPdCmAzlYHj2+pycoKPC5Q7lOBmUVrhS2v0OYfwO+NFfA0xMQ3PQ0plgnhaRpCRbqG
         8mEJLl+VSMOx51IFHqCTqVqO51wJDqs4Tx9v6Mhobf3C8NAgG0kVeAmIXtdiJb9/nfjE
         8IR3w0ySl/hcF+o1GPjsXpFFl9ZdMjMYM3AGQQxpRRqSvICFh73vq9KfPep9GXL7eyol
         vDnomelqzLBtAMzfrHtX2XMyKH9EBNCx5LXLPjV55ZWnB9+udJsxUOpaMoC/E/VVqIPJ
         aXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268485; x=1785873285;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V+jyHiNy79/J/hkBXzj6oSKA3bKerUWbLvWU40tpTYY=;
        b=nuzsc6Si3uUONauLYVhB2IG7CLg27jeudrFFjXXmf+naVmbaInxN5czho8bv0splIz
         gPs90JhWIgt5nrC0xg6bwjjpGstxqbP6L/BKDQrsBgk56UvWQ1/CPoxkefFDlEPDKX/D
         w7UT9DHkdTIT2HHXyhRCE1CBP5matghdmAqOjT2F8wgYFEPsXEZmiJ9F9FXZg4CDR7mE
         E6mKCLxIY1wSRcHfiRjdVohBn/zE9r9nQTXdudF6Uny6Jmxyl/pFFqM9SG3snzBdPqC9
         lWa/hcZszF8yqB4Z1XSGsAfXjLUxxnutsMLbcjGWRQkDqD1C+UYAaz2/sSBe4wZCZsiZ
         U9Tg==
X-Forwarded-Encrypted: i=1; AHgh+RqUp2I3gWnoN8NBZz72oOldniIp8VqEMkyziKzkVNyhXGth+5cWNDT0eZJH4d2OBHhpUTATmxoaRLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxcOTL6GxBkOnA4d+fJM1qWlY2aXe+uW+CRkBWwu0DPHxoddPx
	8sm5IXWDtFpDVEnfdrR09Na6Mvf4Y6ywSTDYTFTSSOTbl64qldQ2aCGxd1KJbSkjOgyYIbrOmLC
	2ISJIbzzGTsHWQiM2nF/594X4QwU87fPzzWTqMeqsOKXZh4whqbI93F+x3PMVfA==
X-Gm-Gg: AR+sD11Wb9qIgrjHYLve+BTJCszWHrEG/dIehFZKUjSpno279K/Vvf8MzjnK0Aog48I
	zpcTZcv90V8tp8tAT97bgbVPfE4AwLmUtpxiwjsQH4OpHHLiVQdM7WacjH18DS9AgrF+Zk3pK3i
	T8f06+t5g3j42Mm82zQiEzHn4SdO8BPDu8Qe3j9/ykFYLmZGEjAGfopf6YRvuZ+kTeW8oNsMavO
	Iht9Wn6AbXsIMBpBUXu5K4X0OMtoVrwLGaUBU7oFbXA0t/Lxqq+0u7SBLmFU7LmzkFFE+AdVyp3
	Zb3FJcR417QmFtzIzMg12z9/aLDRCjwEUDlYU/HscDFBVax0XZguV2pwL3m9BhwnVt313fZaH58
	SoNwdF55N2WB4PzO49LZGv3C7Wp0YpJ+RSls=
X-Received: by 2002:a05:6214:458c:b0:8ff:60cd:817b with SMTP id 6a1803df08f44-90817341bb7mr46431776d6.64.1785268485011;
        Tue, 28 Jul 2026 12:54:45 -0700 (PDT)
X-Received: by 2002:a05:6214:458c:b0:8ff:60cd:817b with SMTP id 6a1803df08f44-90817341bb7mr46431536d6.64.1785268484643;
        Tue, 28 Jul 2026 12:54:44 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc498f1sm6828116d6.9.2026.07.28.12.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:54:43 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:54:41 -0400
From: Brian Masney <bmasney@redhat.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Brian Masney <masneyb@onstation.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 1/9] iio: light: isl29028: return zero in write_raw() on
 success
Message-ID: <amkJAQDfPJu1TI7u@redhat.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
 <20260727184755.2055414-2-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727184755.2055414-2-ekffu200098@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Tue, Jul 28, 2026 at 03:47:38AM +0900, Sang-Heon Jeon wrote:
> isl29028_write_raw() returns the value of pm_runtime_put_autosuspend(),
> which is 1 if the device is already runtime suspended.
> 
> In that case write() on the sysfs attribute returns 1 instead of the
> number of bytes written. Make isl29028_write_raw() always return zero
> on success.
> 
> Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

