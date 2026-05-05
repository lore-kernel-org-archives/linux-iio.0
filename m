Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4CC40B6C9
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964523; cv=none; b=ipcXMWNFw1i3PqV2OISFava13UNrHOcOqjYeHn9VMChucsUZ4uI1MdB74yDJCrXjqgvn0zLJ7I7z4mWT4pnJOyph1+7AezWnmT2nOA6wRCZfghYsVSBSB9orArJSWDN9e8T801C9sOCIwnnESwjERrUNrpLDLlySCOsdZtmNn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964523; c=relaxed/simple;
	bh=atpocCViVZpUvDy5Jq4P7at3QeU4Hvp6bppgvQ2BWM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIBmTle1Znaraek93fB1Q2K3DgmJgFZdQpAblWyJ2bXIVrJfwYZWOqrIEMobKGmFpp1K4GuH7nUU6D2G6loencrhYU2n1O0+gUoaE+QvgOt6+A7hDopi0OR0EDoStwDcTCtNEKU1KtccUp6n7u9Pa5uFCrI4fWAKkUnaI7PEq5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWJ7kkWZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWJ7kkWZ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bc23bebd345so291683866b.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777964519; x=1778569319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJoGeOymzDzt4BduT12fzk90tICGYXHSXGced9NaYww=;
        b=GWJ7kkWZA2Zjn11QZC9RrrRKqySJfrW5pQJQO9uMwhMzyc2vUNZ7L2LMmbUvIML1B7
         X9SQnNZe2oopfQEdhU3bai0KD4VYqmo2JKarc7Cdyfjgbb/nls0pvtoK7EYD3BeFz/Gt
         jQrBxaCJAzkjLcn8EowRgOAN8PzbZ6ITLVwKZcTFc0dMXf6kKcsgeAulhWnis7rhIO0n
         7DBeiYros1ifzz7nVvaZTtkoCyO8AjTdHxUEZWYVcAjF0swoZADL6O8J5t0XDo3eMGnv
         c/+jP81XqgFCq2LbqQJMFWTMz2hUiy2LULSTP4vnOu+DNViJHHlOMif6/kyq8mp7MDyj
         79vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964519; x=1778569319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJoGeOymzDzt4BduT12fzk90tICGYXHSXGced9NaYww=;
        b=K+onRNzo8EdNEv56gHCm+i2SCJtfCM/Y/z2ztllzqpmBkW+aMGkU8PiaDdAtV0Vv8d
         iDcD8zQb3gH588FF8R10JyQpdhpID/BOenbUhbPOuPbO5GhiybE6GP2Mfi/dgCOJfeMb
         Q7lRVe5CEuCeGnolkDRFrJO4k1oSfm55hxsEX8TaXElKaf+KXKf/3rKkLY3ZQbhht/Vz
         OGp0uzaGwq7hYLbMPwQXL9DL0wavXPvuDcT0CMGvEeazdgO/UdMto8N/0/T97rhGlTsu
         GvOD0B8ks/2FVonX24/fzza6KHx2eS6/sOJO2i4DfMclQ8ifF4tw159xe8Y0d7kdiptQ
         wImQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vKAao83Vwom2pU8YzXjj0YdIyhyVyCylcQyLX5PaE1tI0lN99up0QfC9ReC7G2hi1gnvlTRtFP2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+UkDJdp7aoWNRZMAZ1okeWmqFeLMOCaDJJ3lhvUtmlyhZgsq
	jVpKerp/kKy+k6aqjTKiQm+ZZvCfagXX5p30oaJkzWSeYnU/stzQq7Td
X-Gm-Gg: AeBDiesZyppesd6aYjWesjA79FUShTF/xzl3KXI4nJRp7cDwl082Cj0HW/ZHyCQXBFI
	dB4JpCObGqQqXZHYv/m7P9+XULC0j8xJjM0vpCRGP/eqhFeH8S9rl57yw073yjWBfNpKplcEb7R
	GdhfjY70cRU876euipbbMwTRwktP8kb49KOljR/6HSFYagaCSsSU3ZcN7h2pY+f+Bm8nedHylxT
	/Ufp6qm2GiouaFosyveuI7W4612wMVKiu7CMFSdtdnsmq0vlbxOlVaBRvwNv+t8yXvGHzlcNhRf
	uZY0ErU9uThQ2wfiOT7yAxszzlkmuRdytRWtPhMmsOoAW65AFoCcn1Ap7AlI+r7IfGP3tSWxk7B
	m4IGd7xb5qxeYvs8RQmGku2rYBdEm+gCm7lKFQtQIE3s3uRUhLbdLdKNGggzS6b5rubAd0yf/j1
	w0MpEfVtEOsGaXSLk2t9OkqNc=
X-Received: by 2002:a17:907:e849:b0:ba3:961e:d5e4 with SMTP id a640c23a62f3a-bc3d0652a8bmr153046066b.1.1777964518946;
        Tue, 05 May 2026 00:01:58 -0700 (PDT)
Received: from pc ([196.235.252.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc20825b337sm188510066b.23.2026.05.05.00.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:01:58 -0700 (PDT)
Date: Tue, 5 May 2026 08:01:55 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tsys01: fix broken PROM checksum
 validation
Message-ID: <afmV4-FD1rjtGrRG@pc>
References: <20260428152239.66213-1-salah.triki@gmail.com>
 <afDXJLGYzF8uwaj5@ashevche-desk.local>
 <20260429103304.654ed9a0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429103304.654ed9a0@jic23-huawei>

On Wed, Apr 29, 2026 at 10:33:04AM +0100, Jonathan Cameron wrote:
> On Tue, 28 Apr 2026 18:49:56 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Tue, Apr 28, 2026 at 04:22:39PM +0100, Salah Triki wrote:
> > > The CRC check function was incorrectly using only the first word of the
> > > PROM (n_prom[0]) instead of iterating through all words. This caused
> > > the driver to fail probing on most devices due to incorrect checksum
> > > calculation.
> > > 
> > > - Fix loop to use the correct index n_prom[cnt].
> > > - Ensure all bytes are summed as per the datasheet specification.  
> > 
> > ...
> > 
> > >  	u8 sum = 0;
> > >  
> > >  	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
> > > -		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
> > > +		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
> > >  
> > >  	return (sum == 0);  
> > 
> > This change makes more questions than answers. How had it been tested,
> > if tested at all? (This question is to before and to after, the commit
> > message is also unclear about what datasheet says or the real field
> > testing gives.)
> > 
> I'll guess first word of the PROM is typically 0?
> 
> The datasheet indicates that it exists but then says absolutely nothing
> about what is in that word - unlike all the others that are documented.
> 
> To me the fix looks right (based on the datasheet) but absolutely this
> patch description should make that clear if this isn't tested on hardware.
> 
> 
> 

Thank you for looking into this and for your clarification.

Indeed, the code audit reveals that the loop index is ignored, causing the
driver to process only the first word repeatedly.

I will send a v2 with a more detailed commit message explaining that this
fix relies on the datasheet analysis rather than physical hardware testing.

Best regards,
--
Salah Triki
