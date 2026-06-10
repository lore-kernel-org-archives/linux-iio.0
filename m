Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCE40D56B
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093963; cv=none; b=PFN0pgZIGm0Eg0ZOSNI87boLMuneE9GWgy0Xyp/wlQ9A+95/urVYAtjYtrcYvMkR17BuTcmG+rzYPbcQvsIkn1gZEK9jD9D20oTdbYYuC3izELYlsEv0yUbO8lSggWlyuniZ9eSbCjeY8DA4xPC3/fYqawtP1w0wk/bxhgGN4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093963; c=relaxed/simple;
	bh=zxYJs+l4vwEP1WsqTw7YX4PmfhSmZk3Nu7mRqrVorus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9QcPU3ZMychl7XE5Vo63J25wTxVCdaLpVF4eqQwurpGBoWPH9b7W4XFS7jKAdppILJ1/nNXQb3Ttlr+yyFLnyPOEy6qDgcmHhihDp4ldvwy8RfuoPP6FQtbc1p0jMd9qVSZOFJc6SWH7BY/DITcq3bvfs2DAC0ECEIZK9JM7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZjzbMbs; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZjzbMbs"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ced8f44da0so73302276d6.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093960; x=1781698760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GX8so8D0LdsxLyGx+h3I0h7Z/PH7ZZYi77dt1OsmmTU=;
        b=bZjzbMbsL2upz4g3Q8tnYU/piqtm12xzjhtoaMnfuwn7xF60673QjBt/tCx7YuS2Dy
         CpEHRkhcKf8ODGN6Cf8nOWJMNbIhEyJwxCdR6RvAwLnH5R1QNZivbL6budXcJmrWzKZu
         XVzyZ0O20l0mfEWgui6ovCYVb4b+InM3L/qPDb7PjpYxcFk8q543AdxsJcNnrzyLMynB
         DU5UIiIIeiID7UbcBnSZOYuLvKUkFJVdw0mfDwBBNit01dbFVWTV6Pvnoe/0b+XFRNrF
         gdo/fcy5FxfSACzwrjceDAMYsrVKdr208+hkNeFX4MGYVqhiYOFIKiwCEGGIg+Uww+Pq
         lYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093960; x=1781698760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX8so8D0LdsxLyGx+h3I0h7Z/PH7ZZYi77dt1OsmmTU=;
        b=cwBbbZ6N3sRERXQ7ive5o9fDovP/cWCSiB5yIKTKq1VPhjSHgR6vzjRgVuj8i1X0Nw
         aLocaxhES1jl+xYIi9x2dw/3BLY+I2T9uU1Hn+oSJwROTyJqMjMTbodpcz++OFwkiwzu
         OkcLUFRqbjN3k5aTthPqAmi0NVhPbTdNBSjuV/+XVjS9eDMZu8bHsOyjb7HmazSOTxQN
         ovUxAGF0iCCGuE56A0VgIUaMj7Rh7OAHwIsrtg6rIpNPkxsR51G0V3dbJZ6FbBhLRp1X
         Y58Iunbi/Z1264hDYoVroCSYXOsXezDQcM0MIyN6HEvRxKKb8Z8/g2+xuVVr2D/Bk8xK
         wwZA==
X-Forwarded-Encrypted: i=1; AFNElJ9sdpTafNz6QPuXRE2oBGDLS0ieWOy3EcNHDQx/hIugTIkZw3ySmvhVEbSDx1ckEccy2dBKA9koRlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0FQNkp/9vbSWnOKxNcahKMwru4evtE9ACdiGzPQcdj/4FDTG
	rVZs8F9drjCPU9rbI/OtAlAZNgEuxXxaWKxisSIqxO6sEUJn8uO2aAT+
X-Gm-Gg: Acq92OFZ+KBu65v4ZbxePO6BOygBrZlJWy4iVhS81YbRCPOWdobN2mk9d08PlgINjOE
	MzmP5KOPmY60/Qx14wwr90atCXouQhkE1D4P0/FwpW8tqplrByaAqYQts5eOWomgZnRARcPPQc4
	E2NkRpd/O6lHCBLjDrZI0l9uHdV/6mtmb0BCU+PlOPmQ0qKJ7FOIymGi2xG+X+Hw65QwU3cnn/f
	j6jN7cT21Pe/a7UafFZuH/3LL6962yG050DUy0OkSH4fS82flWIEtvwf+EDMi34gp3Zdas9kHhe
	Nksdl2bDrXvHLkhk5hbwhdJTCiDFvnlsiWzG7hDBmst4UfkgYXERU1kXre3c6GJ4gJoBvAyiCBq
	juCbccx/MOIRldWDtil3psLEnDrtxUS8xkYXYmbAcG/cijN4SmPnpJdM90WEYNFkMOwJX7ZxwE8
	dh8H4P85htUkWk3v1VwEVhuMGnv2nl
X-Received: by 2002:ad4:52c7:0:b0:8ac:a6bd:503b with SMTP id 6a1803df08f44-8cee5fed5damr322934136d6.15.1781093960602;
        Wed, 10 Jun 2026 05:19:20 -0700 (PDT)
Received: from localhost ([43.225.189.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb9bd6sm258065746d6.13.2026.06.10.05.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:19:18 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:19:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <ailWP0rNKbVAn4kG@stanley.mountain>
References: <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
 <aiFWg6vC2cVbONTK@stanley.mountain>
 <aiGRzFrSU6QUL4R2@ashevche-desk.local>
 <aiJo1kjN3_XDUdBc@stanley.mountain>
 <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
 <aiewiqInppHKilw1@stanley.mountain>
 <aik_bXUpVc90_eIy@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aik_bXUpVc90_eIy@ashevche-desk.local>

On Wed, Jun 10, 2026 at 01:41:49PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 09, 2026 at 09:19:54AM +0300, Dan Carpenter wrote:
> > On Fri, Jun 05, 2026 at 11:28:18AM +0300, Andy Shevchenko wrote:
> > > On Fri, Jun 05, 2026 at 09:12:38AM +0300, Dan Carpenter wrote:
> > > > On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:
> > > > > > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> > > > > > >    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > > > > > >                              ^^^
> > > > > > > Uninitialized variable.
> > > > > > 
> > > > > > s/variable/data/.
> > > > > 
> > > > > With what I asked in the previous reply and what you explained there
> > > > > (thanks, btw!) I still think your patches are not fully correct. They
> > > > > will require to atomically write all or nothing. If we want support
> > > > > partial writes we need to go with that differently (reset ppos when
> > > > > we got enough or more than enough data).
> > > > 
> > > > Requiring writes to syfs and debugfs be atomic is pretty normal and
> > > > works well in practice.  These are very small writes.
> > > 
> > > Perhaps. In any case your patch will break existing partial writes, right?
> > 
> > partial writes never worked
> 
> I don't get this. Does it mean it never worked at all, or in this particular case?
> Also "never worked" means the same issue you pointed out (uninitialised buffer) or
> something else?

I mean in this case.  The patch doesn't introduce a regression because
partial writes were already broken.

regards,
dan carpenter

