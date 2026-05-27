Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0C3C09FC
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907024; cv=none; b=cS8ny6b48ABuXlcGNzeGEDoZt/GFmMWteVO9csZI/ONg9A4byXpDUJqyM8cONeSRtVsE54NmZtBPmfcKQ1elpzNq0xL1o2fUFT2MjOxRTRDnaFLQW3/p0BIJILPV31eMDOev41hXbi8Fno1i63YWA3EknikdrAO43F5qxppGhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907024; c=relaxed/simple;
	bh=rgk3eHtd0lyWrCD9sIIeDRoJK6ViPSKXhweHuuv9yxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtSBD2lTqooWr2OoVYj8xJCD9FIz4C4cJnfKY+wliX3xQNvOGaRGyzFw4c+nvWWucO+39hypJeeIzt/OQ8fS7hWNFwxjkvQ4XZJnzmexs8pyDllkzHgHYnXH0Xl5jE5E8uAcKU2eDyRQNStFuWbGms9Hkg98BKJ3vKqX0ktA+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIbCr6XA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIbCr6XA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso102894795e9.0
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779907022; x=1780511822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KGdtGnI3f6LaijrilIy25ebFbmyU4uhssnIeZ4Rq2bM=;
        b=kIbCr6XA3KMkVmzhbY+HYn44hU5vOmfTNKNM9FZZugIaSsywFJ0g450eERMju1YmA9
         zE8NYlNyQGbsbkseqlJcuu0hKvqDQ9OzFZBxeJBLTj9vZXGm7VJDfmRQ7WQgEcejBlrz
         uUrfmbMRW9qOaA2cg3knB3mYNoVxdSbCqUzIGPLWhRrG/Mum6oYQpKm/EK06FahExb/v
         hKrEQrF/mn0Tklr6Jl6irP3byGuUibh4UEzeYTbPGX1qbxltmsYtjM6lOwKKd/sNqX2z
         GfK1X6pIlMkXIKCPxeiLheqku6jCara/QFLpxLmEzo3ITqPr5DOPdKYvTOpmugXhMIAt
         Fvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779907022; x=1780511822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGdtGnI3f6LaijrilIy25ebFbmyU4uhssnIeZ4Rq2bM=;
        b=JVVdbJ9BjeyNgjNlKBEZaQ2gKSkTFRe4BdywfYg0WJ/fcdGT1JnEOmNCOn1CFXCN2G
         DkPZMEjEyLcN2ADJPFkHLGsu16H1oB2qERajx2itvf46zY2PX28Q/K3dxu66xXViKBnv
         zXIKFhL84FoX+GJ8KHzAGPt4HXO3eCvY2PrIHNKuSoZidNYFW5XLVVUj/5JNevGJY6P4
         WmcUdUbXLtSq8oCiBOj79q2W8h2ixZKQ+sXTFFwY4i7EVDH7WsyBowwaRqKdHBBceW1X
         QU2fEWmhYWRl/+hTXUp/7gT+1tzMXYWnlIbReVCJgO9Tpzksp90B4EMPr8t2vhXsET3q
         CaQg==
X-Forwarded-Encrypted: i=1; AFNElJ9oz0gNiKvpR4jTn6vyKkye3j2yIMUlLEDF91lzVZq4nh8WPJ4Q82WjsDMzciAdrxGyLKFgkPdgBtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmGyEDlFT6ipskSl2PKHA94FIzP56pM5HDrbCQoJazbjggX8C
	ftn4pJjYdGdouQx9o1g9KJ6VVzMw087435X2aCKUdtY46cl4t4osd/FW
X-Gm-Gg: Acq92OGCrd1U9w3b+q2zEvqW7pwQQT3qdxzG99Zec2ORfaZHScp1nXq8vRSbhuu6PYE
	GUjXOb/jVt2XIO0f/sK7Bi99+gnEOj6evuasdFk0wE8m/r5JAdzE8bmD9r6XtJN6UrhkN6pHJT2
	+KMCeV0FCzs6yQXTZmbQfIoE/1GqoO9pxzvmvSJCYospmELeL2Kn2hpBa4nlX4oeYgxg+Rxjo4+
	WiaVZQRReuM721YnGfaatEMwdRVxzalKijKZ4aHMY+yeYbFwjX8jk4M4hjH2nFOTMdWfoxFwLEl
	r1N8aCvdtGXPpsicbm+du7vJlmT3A8TC6Zc4gQSVWNv8tgyi1KjOR7UesyTcnQ3kiF3N+9QTg8N
	xL5iJ0SJAcoJXllpsCre9TzQOZI+wrWWDwCm2dJ6pJYyN/XWX5mZu76b0UfoRDmEfV1I031/pov
	9tVnjYzUDVCOj0zyA=
X-Received: by 2002:a05:600c:4e4b:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-49069da61b8mr202971925e9.20.1779907021615;
        Wed, 27 May 2026 11:37:01 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a28casm11256028f8f.23.2026.05.27.11.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:37:01 -0700 (PDT)
Date: Wed, 27 May 2026 20:36:59 +0200
From: Wadim Mueller <wafgo01@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com, 
	ak@it-klinger.de, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 4/4] MAINTAINERS: add entry for Sensirion SLF3x
 flow sensor driver
Message-ID: <gcfxahbdslp4px3tj3whfvl4e6ohegw5zi7fjrd3qz4xi2uao2@aq4zog55ncix>
References: <20260524205112.26638-1-wafgo01@gmail.com>
 <20260524205112.26638-5-wafgo01@gmail.com>
 <20260526173616.256fd535@jic23-huawei>
 <20260527143515.102794-3-wafgo01@gmail.com>
 <CAKqfh0GbHLALg8eEBf2EtmKXAsB=H7EXL=6D49yaNWiMutycvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0GbHLALg8eEBf2EtmKXAsB=H7EXL=6D49yaNWiMutycvQ@mail.gmail.com>

On 2026-05-27 09:42, Maxwell Doose wrote:
> Hi Wadim,
> 
> On Wed, May 27, 2026 at 9:37 AM Wadim Mueller <wafgo01@gmail.com> wrote:
> >
> > On Tue, 26 May 2026 17:36:16 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > > > +SENSIRION SLF3X LIQUID FLOW SENSOR DRIVER
> > > > +M: Wadim Mueller <wafgo01@gmail.com>
> > > > +L: linux-iio@vger.kernel.org
> > > > +S: Maintained
> > > > +F: Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> > > > +F: drivers/iio/flow/slf3x.c
> > > No need for separate patch.  Bring it in with the dt entry in the binding
> > > patch then add the .c file in the following one.
> >
> > Done in v2.  MAINTAINERS hunk is in the driver patch (3/3); F:
> > line points at drivers/iio/flow/slf3s.c.  Series is 3 patches
> > now (types, dt-binding, driver+MAINTAINERS).
> >
> 
> I was taking a look at the data sheet for this device and thought it
> was rather interesting. I'd be willing to help review patches for this
> driver if you'd like :)
> 
> best regards,
> max

Hi Max, sure every reviewer is much appreciated. v2 will include you in
CC and an R: entry. 
