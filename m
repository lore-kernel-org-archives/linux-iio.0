Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911E4734C2
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268754; cv=none; b=OCWXZDetYsULqiMHUlQrBLVtowRZyHF6uYi+McbEHNN9tSZpFAMO+2FZrTYmiqTWVie0Gf7Z00jGEBdgIoF3Hqpe0fEiVpLcf10WpPH4RsQhRKfevc7B5tLV7ZiL8E5CTwFzJBNgrBkX+bVMbso57z/ojF+gEv1cHNEWC80dJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268754; c=relaxed/simple;
	bh=fSsnBBDVenBdoikZNgpHLslXDJ/55s6kInlpuDTVN0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLjD2tIj9mX7nXkKFTjVx/IKorhUS6x3BMF68/79Wi3lvd0rzdL6jM3jyAyK+gp8z6+UZyuh2fePnWGc9LOQ0ptQLKWLauaq2FvrDH7LCMO9IApmKnqM913AYJB9YDcN4lZzjif43/NhRmfG+sbWPk1WEP4TaF+VMVEkvL3XGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ua2zPYhK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGJScJDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ua2zPYhK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGJScJDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785268751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfb/2XjvcxGKzTmsfsDxm8YHs5zyBujhHHkRZzbLBIU=;
	b=Ua2zPYhKR3JDx+Cz+n2dd2mVG1godgQLk3THyy+Mi0JJQKt1bAwE+xMdkixtjbHh6zpiR3
	guyJJB6nWMuhIWko9uXLBGOviOIo9/kQtsA6k6RIxizAThmPF2R5/Tu+pSAEHIWiywqBAw
	use/tM1o3JEanDN7hcPI9L/1MWVgyk4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-bDrPimlaMTqVaFGnKl8WTQ-1; Tue, 28 Jul 2026 15:59:09 -0400
X-MC-Unique: bDrPimlaMTqVaFGnKl8WTQ-1
X-Mimecast-MFC-AGG-ID: bDrPimlaMTqVaFGnKl8WTQ_1785268749
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e934385db1so2727146d6.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785268749; x=1785873549; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Yfb/2XjvcxGKzTmsfsDxm8YHs5zyBujhHHkRZzbLBIU=;
        b=aGJScJDe/8S3JUoGL/V233CyTQJjPdkgz0feAWYSSOAQSEfYUbKd4I5/qZkIzYe25R
         5TSYiBqLb72x0NTjzcwNLqaIsjfFMttfpwa2aHi4gELEyLGxD3s5gPHv7lSAvlBIceKF
         aIZWBjHD53SbrZVDsGjS0tHEhqNdYtOWuJLSoKeodr+l/L2DRnbv+Mn2QqCqxofkQXEB
         yMHWg2nGuNoArjsBC14FYv0+u67U8dZv/WJaPMneSMWM9X4DF/Bj0s1Kz72MXcze3OAv
         VQc23SIo0NAfvXC/4SVTneTLG5kbNdsI7OfgcNUY8+DlFDhF1X4vNkAaUaoEOmOsHRgN
         t5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268749; x=1785873549;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yfb/2XjvcxGKzTmsfsDxm8YHs5zyBujhHHkRZzbLBIU=;
        b=JVAP9bKF8D7TopYJ7rIa5uG8t1N2pAoCjKMNbTzzqE5f2aBZCr7nXcXd3TPrt6QT2l
         SfmBm713h75i5Ojl7EDFk2BFnKEy6A+IU9j8Zbtj9BTqWS0+PnBs8kUhf+HJFa40Bjck
         /1ofhP9sA1EAj1KhzAEq0jfan6tDW9modm/wco9gb5ZJDNBT2doo5HY4nbMrfT820/ou
         Zf5bnh1oOOKZKoh8AoXx9hb+9MMNNeoC6zmCXYHK9A/eMBXq2Hx6Y1ums3kGbGznl+nd
         gjJwx3lvG6L9akEjuTws+PTKQXlq1IOqzzdbUtxZf8SW/xMb0R6RrJl1kLwGVONRoyoY
         vNZA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9XZ+NBDpgG1xQ6iGF6mw5oCNKaSPsW89etxWVfLucTXtuFoFKR4lRtCME+wIEdYXdHh75ktyymtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRmIhQtf3zuEx5+HqNvWEOAzl+r5UcoUfk/Nsl33lI5Kg4Vr5i
	MSls/Am84k0dmT0yack2vz1T1QBTN6NcBnQ076NMiOFVaQcCmbe0hxq8nkIEv/W/lMaBIzd7O6G
	jAcZrZOpRoZ3vOJk+Cnlaqd00vexDva/qmNm9+7K2TXKBarKeNuEcdpZO7X7hbA==
X-Gm-Gg: AR+sD12dWGMYvUjWWssBpQGQL85UBuTzTZKRIdsYdQaXFG0D+//FyztUX+iSi9z4pH2
	q0UgrAeL2DXDhrI+qmQlOY5HMcVA6CR/g0+XOD949j1Cr6zankIXY9c1Ug4TwX6VchQe/QE3tZK
	x+8Idxz4DREPouSVQaW0DDFGEOPHaABCLvkCssv/R8EZrfD1MhyfZq8wEonGi3sl8t1nIEQ9Dzv
	TUXzkYBM7UXwdIbdwAZzET6QSOb8XV7dIi+i4gmsOoo4KeQFLWc9FvZsQV98oLqfYsgkFTAc1Ge
	3j1Q536O4r0Khgk9nsdWBDt5JBExNPViMJmqioNxVqxVMocz5/7Nm0cMVTs2+e7q1tPT8cLbIDn
	habjgXvjf1bGaP96CL3qEbMSh1fS1DZio9vI=
X-Received: by 2002:ad4:5ce5:0:b0:8cc:f72d:6a5 with SMTP id 6a1803df08f44-908172c021dmr46355126d6.36.1785268748720;
        Tue, 28 Jul 2026 12:59:08 -0700 (PDT)
X-Received: by 2002:ad4:5ce5:0:b0:8cc:f72d:6a5 with SMTP id 6a1803df08f44-908172c021dmr46354816d6.36.1785268748204;
        Tue, 28 Jul 2026 12:59:08 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081f69f65asm3076856d6.15.2026.07.28.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:59:07 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:59:05 -0400
From: Brian Masney <bmasney@redhat.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH 8/9] iio: light: tsl2583: remove conditional return with
 no effect
Message-ID: <amkKCV0mjQFQp6JW@redhat.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
 <20260727184755.2055414-9-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727184755.2055414-9-ekffu200098@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Tue, Jul 28, 2026 at 03:47:45AM +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has no
> effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

