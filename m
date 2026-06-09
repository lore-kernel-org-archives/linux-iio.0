Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2E327C0D
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018523; cv=none; b=TyT4k4XBtQtLzF63w2TMUSFb92147Ea4+ODNJhZNm5vJHBQDSFvzPwkzTmqWt+JSPe702BHw6XDM3mF7lhhe+3aEkpXp78IgSsvVxwHn4Kvx+KsPZ/50OmMcMjftxMNIBwZGk+NF9IBMNnG/aQZcRhN/3Wo8gbLKHMKCdZ4Zlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018523; c=relaxed/simple;
	bh=8wn/RHQ9vfWfJtThQDGntrdWQDmzCM+WOf4YP/9vsrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2hUT2QtA/N4Rg/iusxI7fRvhoiVXiXYpJFPcSDrRdZOA7gr1c3eMEmAL9kggQPZ7HBcF2mWEiWowjitfzywxM8eYJyMqr6KbJIeeMCdZn8r2Iri30IZaNZap3CkP/JWqaXy38QAp/9XVj+b3+BFrjAw85geZaOsjqMGZ/0VfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdkRhST5; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdkRhST5"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6da33a561so4666950a34.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018521; x=1781623321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0yrNExNQjistpNCKCUpfYoDWyRkZSebhTJ0IaboNn4=;
        b=MdkRhST5W55EqtXPd7ivBA6F4X0Qw7WismvVxq4xgtL20wFWRnmljzTra6cGOLLYwl
         sVSsAETd+tUC/HvMq4Qd4egqhBCxQJkGHFKPbZcLgwOYgMWx2zuLIUjaQq9FBv7n8Pcn
         MYQ0DWIR5muvuDRdXO4VEh1jXFIgxqh6DZNRtZfenZU5MMNjvzOKiEn5ovwovJ/GOBMc
         Q9zsBvIeU9g/VXkqV6hQ91Nl1ja+Ej5Z1z9MZ4+p/KVsvDGVb8nigJqsRRCC02rg4mnI
         pyJmBxdewQ58OxR5QwAc5jkbzQEYTltj8jJCPtYiFmOslPD/JZ/ksiAJTqecrWDPPxk9
         HItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018521; x=1781623321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0yrNExNQjistpNCKCUpfYoDWyRkZSebhTJ0IaboNn4=;
        b=XCREP9Gld/t+RXHtossvKcLkVIiznxFYhubinYSdTrNGCySozgE4zDgfymIjoPrgjt
         PyCCTUitwxyY+Ce+qIvqoY0zhzhfe8AmDZUsN3MxUz41oc+xSF88aTpJOCoe70PY5rt/
         81rVVhw1lGxef4x0RcvqSFMPmTwsyTjK8iewLNm7G8FWvwWT/dpA/ZvpEgPGKgGZots9
         EdyiU2BpqRAhyhacKGu2Mfd9bN3amTkbj99ggdDvYXl5zybUWVBo9yvN/var0kyRdNQe
         AVr/i90Mo/pLoRlhYHvpO3+sBdFip1Lm/W/co/iL0ECtD8Fhz363WYOCYYGv2D+7Rq8/
         I/kQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Xl2lcvujOV8IfJhHOP4NqSsvsaxkH9lkm2mrZpP+5YelSBErlvruxpzwXGxpBnS7Py3SGLLCtR3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMro/qcFhZohRBjMKxAumiWvsgHItJvPHIV+fR0IBlfzXqVT3a
	13GicGx7SlCMKyZ1kqkXaKT3pPvu4NBTKHUoom/upOVxXIWrFGSOzvkm
X-Gm-Gg: Acq92OEGtOXNRmfT8bUUeQvH+8sR26NuUAvKoFhDywmHsi1GL/hr/psTzdwgFQa34O7
	XXmY1DZHEL9HAU/9wrjGa+oBff3X42yyUMB9VT8Mog/GdH4e3jMiQx7lV1QH4Erys0ESjdT8VIN
	1j4Uc7gY0wAEkNlD/eyhDkf3HHu4xsyOyBlRW76joEtqa05cl/cbD8ZxR5/ANPPStfvDhSr7HnJ
	SmKhopdlaUIVFOsza5vxu9X3BKhFiMyWWJeHM8avdDFAuBGXSdfWk8+zoY6WjylSJDw5gE/Y5rn
	aky340g6bklEg00SEk9k6WjqNYbIKCRxRalal5DIssa56oCpkr4UrEBblUOAflSHgMBy+kRkXL4
	yLrwulxX1+pTbZL2Id0Tq/asm5hQdKN+SnXghrvBQ5b4olKiPS/vXgio9keF8QEaoqJB218hgPK
	5Z9C3LSITh1A6IOSkKIdCrvAW0bNsJugZrPD+WOYF2szg0IPNIt7LsCWrdwaLH9vg=
X-Received: by 2002:a05:6830:83b1:b0:7dd:f615:a84e with SMTP id 46e09a7af769-7e70ca0a914mr13228302a34.18.1781018521008;
        Tue, 09 Jun 2026 08:22:01 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78de8bdsm14245597a34.16.2026.06.09.08.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:22:00 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:21:59 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, "open list"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 tduszyns@gmail.com
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
Message-ID: <20260609102159.14c68a8e@linuxescape>
In-Reply-To: <20260609140712.2e5d1640@jic23-huawei>
References: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
	<agAvydze87mMLaVC@ashevche-desk.local>
	<20260608085754.32def4cd@linuxescape>
	<20260609140712.2e5d1640@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 14:07:12 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 8 Jun 2026 08:57:54 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> 
> > Hi all,
> > 
> > On Sun, 10 May 2026 10:12:09 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >   
> > > On Sat, May 09, 2026 at 07:14:35PM -0500, Maxwell Doose wrote:
> > > 
> > > If email is not bouncing, let give him time to response. If there is no
> > > response in a reasonable time (usually up to month in the summer time
> > > due to people usually have long vacations), then we can act accordingly.
> > >     
> > 
> > It's been about a month now with no response. I believe it may be time
> > to make a decision about who becomes the new maintainers of his
> > drivers.
> >   
> 
> Send a patch.  Won't go upstream until next cycle anyway so plenty of
> time for any late feedback
> 

Alrighty then. I'll probably take his chemical/ drivers since I've
been spending some time in there. Regarding his light/ driver (ROHM
BH1750 AMBIENT LIGHT SENSOR DRIVER) I can take it but I want to see if
anyone else wants to first.

-- 
best regards,
max
