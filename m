Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D0327204
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127549; cv=none; b=KxKaCi/leVJNBSSHN8BkUGBNCBi2479bE4Mx3dIt55HMrtJLMhgLumWhtz6QkO/JRhJXCkkPII1srmpijOxz89cG1FZnr4lLgqj/5aRAvW18UQSm9nwWJ20nwqfNajZcW3ZFWaTaHp/55gLGTAB8jtHU9dKKj15/fIgkHXFZTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127549; c=relaxed/simple;
	bh=LVRpvRWQSaxHfSgYe3MtbFfNAnOMtlsZRIWS10Dv0GE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7+VDbhPXHwfNZpPS1YUsxV2v+IlwupBZUIgNEL7CXgjiWU+KL2WicTjL7ByB4yJj9fXoWd/WRF60tifBwtQOVEJmhfsJuGYvKKcUdJzjCP+6H1r/i+SZFFwaTMkpUgKIGBiTwJZwun0a8+Oufilb8jWyScKU0cmXHjS/cez0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odgy0yVA; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odgy0yVA"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5276d598b96so19776661cf.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786127547; x=1786732347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rCdCLUuBP8/CkfxUK6b74oN1gwbSsaQEa9gHG9eOXxo=;
        b=Odgy0yVAwz1f6T3u3e6D5aLzpKR0SEszq4Ybvk6ObUU2mm2Sz57aPamD6C7rMrk0hD
         CHS+0uO6eil35GKH9+tCdcaS33dREJ9EGdwj1oId3uNifKKlmHi/0TYetDGGd9s841pm
         VZIuGYlLaetZuD0e9kjLobf0s/UD2gSxIPAx8c1RLM4f9hlBkvGTzYhg1K8SqevQbEl/
         I/NNYRiWJHt4kT6u71v9eybwr1dOfa1KAZuA1ZqTqyO4eCzWFZEsT/Dn2T2nZXNAiB4Q
         ByMY7h39Xydh710GiBRwYVBsOOQoFfh4IFsWiYAgLsLpUe2oy9N6FePWwGkN8oToTMNN
         Veew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786127547; x=1786732347;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCdCLUuBP8/CkfxUK6b74oN1gwbSsaQEa9gHG9eOXxo=;
        b=QenDLcqTTF7I/fGMaDLGAhbp1ANuKIJNZyD3obOnjYZvJ4aU3TLvtKtU3T9GvHANAK
         xuXAYSD2zJL1M3mTUotR+UvgCyJbrGkee1dNF8ym14gS01V0kjmVbuJpPVwhBYmb4IBb
         cnXwDjSwj/AKb6LlQxxhCgrIj3pCNr+QxU3vorvdCOAo4CoSdAaKjNphFhqctUVmFLY8
         XKbioQCVLoTz/s1qPCNGC+xhPMcXtPwaZBEo5H/ycXU4C3IXyTMNQW5Myaa5Wlqs08oy
         4Kl08LAypfj1jee5kENkYADPgVYjK6ZLS2ien6Kpi8k/XrUDeF2iJ2sHuEERwtv4xKnV
         cs7w==
X-Forwarded-Encrypted: i=1; AHgh+RpblPgetvxN4RY0XLPu3DlTWXcBWXPfRRs5Vzi3YQshkJxEer4txjzJHq4UDtYeunf5GhxFjhzqwrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm673+wWPnnL8DFp+hk/TzpBaPNxHYgRQ15V/CnetU9hs0umoL
	eJtuVZ/cumMUyUs8AqKNQksXNVq3w64efJUtiflbWQLhHTPFpEW+59jP94mHeVj1
X-Gm-Gg: AR+sD135cPGJXCEjpaMjK4E89MH0I991W/VO10hzXqir11V274onD+nyymMwOCnppOV
	dijeru5/JV5c1m0QtVtRuKXXR8NNSupmII22PGV7HLJ95VN5a/2eYMCAmjmNonDeJXgvLv7hWby
	Bd9ZEyyfkuJulv61Z4VMCRD39Tnl2ii5WQe33wBBmjwH/tNSQ0Z/amy6HXd5uTPPqvTxxcLZKi5
	xcVZ/i3wDn/5VquXhLI9u4jd7RgONrplwgPvwtnvO8ut/hVACeqN+Cb4TnLl2kya3ZOOHrKoUBY
	u2XrBnFryof0SARq+fNsA7zDMSYujrqJ+gerSPln/hQd8StUresIcT0hAzSoZpQG7xAudnajbRb
	Zz3eFyqyJwiZRYkzjTFH0cJ3ljse7gCwc5MuMP8Rupi0vN2gGbNhF7967yBSICVOKhSGyfj0oQz
	eWNsihj9Jw2MjLaoOj2s1WeEBwe1AmENrP7XSPpOK44hT3zv/MWohzHyCiiKNWNDF0afUzIyW2W
	g==
X-Received: by 2002:a05:622a:1487:b0:516:dff5:68c4 with SMTP id d75a77b69052e-52ce5f449d4mr258294841cf.7.1786127546775;
        Fri, 07 Aug 2026 11:32:26 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d1637f4a1sm17779741cf.9.2026.08.07.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:32:24 -0700 (PDT)
Date: Fri, 7 Aug 2026 14:32:20 -0400
From: Louis Adamian <adamianlouis@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: ms5637: Add variant specific
 temperature compensation
Message-ID: <20260807143220.409fe4ec@louisarchdesktop>
In-Reply-To: <anT8Qs1ga7ayvtWZ@ashevche-desk.local>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
	<20260610020458.104818-3-adamianlouis@gmail.com>
	<aimvBvJp8CsNKlPU@ashevche-desk.local>
	<20260611151026.4abf8804@louisarchdesktop>
	<aisNMmwMREF7Iga6@ashevche-desk.local>
	<20260805130651.4aceb71f@louisarchdesktop>
	<anT8Qs1ga7ayvtWZ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 00:27:30 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 05, 2026 at 01:06:51PM -0400, Louis Adamian wrote:
> > On Thu, 11 Jun 2026 22:32:02 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Thu, Jun 11, 2026 at 03:10:26PM -0400, Louis Adamian wrote:  
> > > > On Wed, 10 Jun 2026 21:37:58 +0300
> > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:    
> > > > > On Tue, Jun 09, 2026 at 10:04:58PM -0400, Louis Adamian
> > > > > wrote:    
> 
> ...
> 
> > > > > >  struct ms_tp_dev {
> > > > > >  	struct i2c_client *client;      
> > > > >     
>  [...]  
> > > > > 
> > > > > Please, check with `pahole` if this is the best layout.    
> > > > 
> > > > I will correct the packing on this per pahole's finding.    
>  [...]  
> > > > > 
> > > > > Can this be simply embedded into ms_tp_dev (and copied there
> > > > > if required)?    
> > > > 
> > > > Copying in ms_tp_comp_consts provides no benefit over
> > > > referencing the pointer; the values are per-descriptor, not
> > > > per-instance and never modified. I'll keep the pointer (same as
> > > > ms_tp_hw_data).    
> > > 
> > > Okay, let me ask differently then: Can we use the same data type
> > > in ms_tp_dev instead of adding basically the same fields as in
> > > ms_tp_data?
> > >   
> > Sorry for the very slow reply. Yes, for v3 ms_tp_dev will hold a
> > single const ms_tp_data *data instead of its own hw and
> > comp_consts. This drops the duplicated hw that predates this
> > series. 
> > 
> > One thing worth noting before I do that: ms_tp_data is currently
> > private to ms5637.c and will need to be moved to ms_sensors_i2c.h
> > for ms_tp_dev to point to it. I don't think this is a problem; it
> > matches how ms_tp_hw_data is defined now, but let me know if you
> > would like to avoid it.  
> 
> The pointer may be opaque, in that case it's not needed to be exposed.
> 

ms_sensors_i2c.c dereferences both ->hw->prom_len in
ms_sensors_tp_read_prom and ->comp_consts in
ms_sensors_read_temp_and_pressure, so an opaque ms_tp_data would require
passing both pointers as parameters. I plan on moving ms_tp_data into
ms_sensors_i2c.h, dropping the original duplicate hw, unless you prefer
otherwise.

-- 
Thanks,
Louis
